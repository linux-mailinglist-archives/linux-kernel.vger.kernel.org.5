Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD3475455D
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 01:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbjGNX1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 19:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjGNX1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 19:27:53 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 832A63A87;
        Fri, 14 Jul 2023 16:27:52 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-666e916b880so1659550b3a.2;
        Fri, 14 Jul 2023 16:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689377272; x=1691969272;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=PNHZ76ih19Fp+iv2zVmp4vUPN2JAZpilkacEs+GwIMk=;
        b=ARFrS7d1ZD5U7uR0DTasdGjDv+nXkBOA1N+MAQv5XhSGKA27NcecmbCPUK0Krp8ZDq
         6Oh7DlSy/ApB84Zsn6pB5oiWEnGjmDY1AP56fC5tbHb/OMgc/FW5bZB7N1U8JwK6IxsD
         0J/LOIUaeVhttQ0gynuNaqLE+7v2kgjhrHtMZh6ALQLzFYoZVpsNQB2Yw2j9WJwpyfnW
         1ophpwu1IkK/k+A9uE+MeGAXSkDRCJlG8w5VaFuETib7FLKqFNqbQct2bM+heYjPQWDW
         GEasCl+nSJFX07+0ADXJej1ZC5mP1pEzsWckmDt85SknzjDhYvBJpe+xvVHGERFQvu0o
         jnGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689377272; x=1691969272;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PNHZ76ih19Fp+iv2zVmp4vUPN2JAZpilkacEs+GwIMk=;
        b=iscuhl4PkW5oVyittkFaPJSiBFzsb0nHZUI8PAK+d2osCaHtEt/EIQIaLoCzgGdzSk
         bcnR9kamNyO2u0KDGNhrAZ0WbziMBpZ1cxKDhFwdjXczu4Ll6E21P3ogXUP+r8AxWEuE
         vLhi9tquQX4Dxw1zYoYKMLYpsM2u/FE0RlAiaxxKlVWP1+Xt2z72cWbejLTgEw2IY32K
         vO0/d9gSLpCHKwnFkFLj9GjLEQJ9YbS4j62RFBbGW9mRP9/1Mm2gD57E3YKiiW0cbXIP
         4SOWTAYr2bepjKYhe3u2F5/zOrtWxJNZLNovv72MyaPMlpSWezxHUXKAv0nCcPw7aFZN
         lQ5A==
X-Gm-Message-State: ABy/qLYOD+lIhquaXzVUWETCbPH2AyHPZgHk1ig/QzrxPuKhS7eujzDr
        BYPyRPIdeVAKzLH5OSXOheU=
X-Google-Smtp-Source: APBJJlHXffSUGposmcbI1zI79Hzsgjr0SSrdKymNS66nBZAPJ0EIZhG2i4fmVS4/A+dDlq/LMwAATg==
X-Received: by 2002:a05:6a00:2443:b0:682:4b93:a4d3 with SMTP id d3-20020a056a00244300b006824b93a4d3mr6198293pfj.1.1689377271928;
        Fri, 14 Jul 2023 16:27:51 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h25-20020a62b419000000b0063f00898245sm7869952pfn.146.2023.07.14.16.27.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jul 2023 16:27:50 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <0b0e6961-1211-4765-2a63-4b69789dbbb3@roeck-us.net>
Date:   Fri, 14 Jul 2023 16:27:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 2/3] arm64: dts: ti: Add reserved memory for watchdog
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>, huaqian.li@siemens.com
Cc:     wim@linux-watchdog.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        huaqianlee@gmail.com, vigneshr@ti.com, kristo@kernel.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jan.kiszka@siemens.com, baocheng.su@siemens.com
References: <20230713095127.1230109-1-huaqian.li@siemens.com>
 <20230713095127.1230109-3-huaqian.li@siemens.com>
 <20230714225240.dvlwqaodp2l3cczm@disfigure>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230714225240.dvlwqaodp2l3cczm@disfigure>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/14/23 15:52, Nishanth Menon wrote:
> On 17:51-20230713, huaqian.li@siemens.com wrote:
>> From: Li Hua Qian <huaqian.li@siemens.com>
> 
> I guess I should be explicit about this: Lets keep this dts patch as
> "DONOTMERGE" in subject line for driver subsystem maintainer (I don't
> want a repeat of cpufreq maintainers picking up dts and associated
> warnings that are now pending fixes), resubmit at next rc1 and I can
> queue up the dts once the maintainers pick up the driver and bindings.
> 

FWIW, I never pick up patches outside drivers/hwmon without explicit Ack
from responsible maintainers (and most definitely not dts patches unless
a maintainer responsible for the file(s) specifically asks me to do it
(which I think never happened).

Guenter

> Ref: https://lore.kernel.org/all/20230714084725.27847-1-krzysztof.kozlowski@linaro.org/
> 
>>
>> This patch adds a reserved memory for the TI AM65X platform watchdog to
>> reserve the specific info, triggering the watchdog reset in last boot,
>> to know if the board reboot is due to a watchdog reset.
>>
>> Signed-off-by: Li Hua Qian <huaqian.li@siemens.com>
>> ---
>>   arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
>> index e26bd988e522..4bb20d493651 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
>> @@ -63,6 +63,12 @@ rtos_ipc_memory_region: ipc-memories@a2000000 {
>>   			alignment = <0x1000>;
>>   			no-map;
>>   		};
>> +
>> +		/* To reserve the power-on(PON) reason for watchdog reset */
>> +		wdt_reset_memory_region: wdt-memory@a2200000 {
>> +			reg = <0x00 0xa2200000 0x00 0x1000>;
>> +			no-map;
>> +		};
>>   	};
>>   
>>   	leds {
>> @@ -718,3 +724,7 @@ &mcu_r5fss0_core1 {
>>   			<&mcu_r5fss0_core1_memory_region>;
>>   	mboxes = <&mailbox0_cluster1>, <&mbox_mcu_r5fss0_core1>;
>>   };
>> +
>> +&mcu_rti1 {
>> +	memory-region = <&wdt_reset_memory_region>;
>> +};
>> -- 
>> 2.34.1
>>
> 

