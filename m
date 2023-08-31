Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 922C978E69D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 08:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244806AbjHaGgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 02:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjHaGgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 02:36:43 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E18A4;
        Wed, 30 Aug 2023 23:36:39 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1c0bae4da38so2926745ad.0;
        Wed, 30 Aug 2023 23:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693463799; x=1694068599; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/kyvkupLew9Yd6VCA9XQC4cAMSTlDnrwdbWSR056bSo=;
        b=PIsxpXWslfEpysxQDfdqa+rhJiOIqSjmEvYyFBx6y5SBRRoMzc7r9BeN1p1AbCXaBD
         Z37X057Z96FDEAeTA7YKgTgKVsGYlAgd5AfTXNSsw2TBb7PJ9dR2h7D814r1H7PiTDcT
         vFVZEM/9CDewlHeaYZyL53ZOjupUMZuNRpPMJtWcrVMLz2Xs9vkfjN3zJDQR1vv8O+XM
         RTzgnx57iV2+vOCcvkhvWkitCSTTbq+fH9ihyl8rgr6X6DlRfgOmK+gD6lXThUTArxMD
         chNvgcBy4+onWuJi0QiZdl2wbfsR0jblJ0yhLeqzgsVoMhS1uEnFegs1lvE1eR/Xubz+
         DQxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693463799; x=1694068599;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/kyvkupLew9Yd6VCA9XQC4cAMSTlDnrwdbWSR056bSo=;
        b=Cd+IqFdI93ie2ay68wKVa4kpQnPS+hvMB8V9xUXBXZcXkY+SP/2pLBv5b+dKVsbxOv
         snLtHijp5roikL0OFbY9C+zTUEfojCbXS6zPyAv3WKBWbLXLJnjBe8nyrr2+kyU3PUHp
         6mQnMQX59LefDVvcpZSp+no/5GtUjV/XBR+0zbJwaiPIhnVnkPv3oJ+zBdjxOiEUiFy5
         RRcdth9bB65ppAqUxdh1Ya24JsUSxTttLn4OFEpqNPmTUHTOVddN2C1jee0410HelqdJ
         jwgjbpgta7sRAj1syixxjRFLi3dZD0pEHxdqdFvwQ6b2XqcFb5l/svKtgqGS/xJW5WVh
         9sGg==
X-Gm-Message-State: AOJu0YwlOON95hFOQaAdH3WV7fjFqKahIp1AS9W8++KZoy/fOS87KOAz
        Zca2aZDoefu/Yc5u5d3t4Es=
X-Google-Smtp-Source: AGHT+IF/QcbvfmvsqDftpHC9Yc9k9k1Flp6pBjturyK95MU7VeorHlVJlOFx/tBxCTurN4IFl3DROQ==
X-Received: by 2002:a17:903:18a:b0:1b7:ca9c:4f5c with SMTP id z10-20020a170903018a00b001b7ca9c4f5cmr2147913plg.28.1693463799233;
        Wed, 30 Aug 2023 23:36:39 -0700 (PDT)
Received: from [10.10.14.80] (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id l19-20020a170902eb1300b001bf00317a49sm552633plb.104.2023.08.30.23.36.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Aug 2023 23:36:38 -0700 (PDT)
Message-ID: <5347163b-c225-d805-d851-fe28e6b57c56@gmail.com>
Date:   Thu, 31 Aug 2023 14:34:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5 1/2] ARM: dts: aspeed: Minerva: Add Facebook Minerva
 (AST2600) BMC
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        patrick@stwcx.xyz, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     cosmo.chou@quantatw.com, potin.lai@quantatw.com,
        daniel-hsu@quantatw.com
References: <20230831055030.3958798-1-peteryin.openbmc@gmail.com>
 <20230831055030.3958798-2-peteryin.openbmc@gmail.com>
 <4cbe662d-cd20-ceef-e3e4-6608029f94b7@linaro.org>
From:   PeterYin <peteryin.openbmc@gmail.com>
In-Reply-To: <4cbe662d-cd20-ceef-e3e4-6608029f94b7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/31/23 14:20, Krzysztof Kozlowski wrote:
> On 31/08/2023 07:50, Peter Yin wrote:
>> Add linux device tree entry related to
>> Minerva specific devices connected to BMC SoC.
>>
>> Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
>> ---
>>   arch/arm/boot/dts/Makefile                    |   1 +
>>   .../boot/dts/aspeed-bmc-facebook-minerva.dts  | 377 ++++++++++++++++++
>>   2 files changed, 378 insertions(+)
>>   create mode 100644 arch/arm/boot/dts/aspeed-bmc-facebook-minerva.dts
>>
>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>> index 9e1d7bf3cff6..edb0b2105333 100644
>> --- a/arch/arm/boot/dts/Makefile
>> +++ b/arch/arm/boot/dts/Makefile
>> @@ -1604,6 +1604,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
>>   	aspeed-bmc-facebook-wedge400.dtb \
>>   	aspeed-bmc-facebook-yamp.dtb \
>>   	aspeed-bmc-facebook-yosemitev2.dtb \
>> +	aspeed-bmc-facebook-minerva.dtb \
> Third or fourth time: that's not a correct order. This is a nit, but
> since you keep ignoring it, I don't believe any other feedback was
> applied. Why you did not respond to my comments but just ignored them?
Sorry, I don't notice this is different file.
>
> Best regards,
> Krzysztof
>
