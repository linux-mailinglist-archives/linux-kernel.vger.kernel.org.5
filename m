Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58600755D9F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 09:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbjGQH6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 03:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbjGQH6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 03:58:08 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7603FE
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 00:58:05 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9939fbb7191so864849066b.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 00:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689580684; x=1692172684;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FmNQm9M+0zn/nMrIBNBkshVCde1QUTYeyBhIVjKtHnY=;
        b=sQNpV1XUH/ZgObuv1zrTnKpPMULBMO+AzfSKXjvsS1gay3a2emm3/9jpD6YLn7ixyv
         jqXWoFyybylAJcWZgtp1rebtgXsklM5cTyI7JZs3FsDT/qYKb+eKVg77Ids8kU0kUA0r
         BjeSfAiC9y3fHSvYk+EgihQ50nn7SHkXzlOJfXmok3IBfsVXlkDx4mnEas4xQGJw3O8f
         1r+8G17PPMIuNVEPHgd3KUWhc4WSIkYDR9KnM8hwrp10tHEMdHQ7NuC52eFpZ50IGkSW
         UsggA7SYOg8U88CMuMQvyfvFh7ndq99ePxJVakwAtXKJgfJ964M/sgBB+a786C8XKtVD
         TsWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689580684; x=1692172684;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FmNQm9M+0zn/nMrIBNBkshVCde1QUTYeyBhIVjKtHnY=;
        b=W5JrFKB0f50qrBodlO+vHTGTHX1zJnVev8i31n6VkS3iD0uN7hXwURnPiVR4Jgc6UP
         mxf4kgL2UNeAlnrTcVgnalwWDyLL5+NN97IYNL1LFg1U1QGYOEQbBAONqvfsfbFFp2De
         /HEaXKNQ+BOOM6XjiXAvmW6+QohVJJgaHDCgvz/eR6Yp939p62vXPpQ/Y6hWpz5ohXjs
         LqNQmErg7nUdJusl+MTxWeE6UQ6XkDNltp0bOsErALm0rkUj7NTTZBC0eVWOzjgxMnIS
         s2pMlnhu51l0UEwp4GG0J5hUHUU3V1Zff9JoRQ9xkh40m2OcW4uNItGy7alfMxKJIDhF
         PNPw==
X-Gm-Message-State: ABy/qLaK7tFVVENlkyMZmc1kO9bCaFRJCk/trTlcaRF5LIpgU6M/aEEg
        JHX0b0k/Yv872wtg1MxYYLLw3w==
X-Google-Smtp-Source: APBJJlGtCX9k5iJy3dI+RGwPFkVJmxznXKt3Y4+Mj8D95AdYaZc3jwO8W52PEiMJ5W/r28uuapZFJA==
X-Received: by 2002:a17:906:225c:b0:994:5407:9ac9 with SMTP id 28-20020a170906225c00b0099454079ac9mr9978026ejr.5.1689580684429;
        Mon, 17 Jul 2023 00:58:04 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id s7-20020a1709064d8700b00993004239a4sm8794738eju.215.2023.07.17.00.58.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 00:58:03 -0700 (PDT)
Message-ID: <66cff026-3e7d-f88b-e99f-8100233231bb@linaro.org>
Date:   Mon, 17 Jul 2023 09:58:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/3] Documentation/process: maintainer-soc: add clean
 platforms profile
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Nishanth Menon <nm@ti.com>, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, workflows@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20230714084725.27847-1-krzysztof.kozlowski@linaro.org>
 <20230714084725.27847-2-krzysztof.kozlowski@linaro.org>
 <20230714-verbose-unwound-fb8b1df29d25@spud>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230714-verbose-unwound-fb8b1df29d25@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/07/2023 14:50, Conor Dooley wrote:
> Hey Krzysztof,
> 
> On Fri, Jul 14, 2023 at 10:47:24AM +0200, Krzysztof Kozlowski wrote:
>> Some SoC platforms require that commits must not bring any new
>> dtbs_check warnings.  Maintainers of such platforms usually have some
>> automation set, so any new warning will be spotted sooner or later.
>> Worst case: they run the tests themselves.  Document requirements for
>> such platforms, so contributors can expect their patches being dropped
>> or ignored, if they bring new warnings for existing boards.
> 
> Definitely a more scalable approach than your previous version!
> 
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>  .../process/maintainer-handbooks.rst          |  1 +
>>  .../process/maintainer-soc-clean-dts.rst      | 22 +++++++++++++++++++
>>  MAINTAINERS                                   |  2 +-
>>  3 files changed, 24 insertions(+), 1 deletion(-)
>>  create mode 100644 Documentation/process/maintainer-soc-clean-dts.rst
>>
>> diff --git a/Documentation/process/maintainer-handbooks.rst b/Documentation/process/maintainer-handbooks.rst
>> index 9992bfd7eaa3..976391cec528 100644
>> --- a/Documentation/process/maintainer-handbooks.rst
>> +++ b/Documentation/process/maintainer-handbooks.rst
>> @@ -17,5 +17,6 @@ Contents:
>>  
>>     maintainer-netdev
>>     maintainer-soc
>> +   maintainer-soc-clean-dts
>>     maintainer-tip
>>     maintainer-kvm-x86
>> diff --git a/Documentation/process/maintainer-soc-clean-dts.rst b/Documentation/process/maintainer-soc-clean-dts.rst
>> new file mode 100644
>> index 000000000000..87feeb5543ff
>> --- /dev/null
>> +++ b/Documentation/process/maintainer-soc-clean-dts.rst
>> @@ -0,0 +1,22 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +
>> +=============================
>> +SoC Platforms with Strict DTS
> 
> I don't think that this title makes much sense, it feels like it has
> been truncated. Perhaps add "Requirements" to the end?

OK, but maybe better then

SoC Platforms with DTS Compliance Requirements
?

> 
>> +=============================
>> +
>> +Overview
>> +--------
>> +
>> +SoC platforms or subarchitectures follow all the rules from
> 
> s/follow/should follow/?

Ack

> 
>> +Documentation/process/maintainer-soc.rst.  However platforms referencing this
>> +document impose additional requirements listed below.
>> +
>> +Strict DTS DT schema compliance
>> +-------------------------------
> Should there be a blank line here to match the other section headings?

Ack

> Also, to match the title case you used elsewhere, "Schema Compliance"?

Ack

> 
>> +None of the changes to the SoC platform Devicetree sources (DTS files) can
>> +bring new ``make dtbs_check W=1`` warnings.  The platform maintainers have
> 
> Nitpickery again, but perhaps the first sentence here would read better as
> "No changes to the SoC platform Devicetree sources (DTS files) should
> introduce new ``make dtbs_check W=1`` warnings."?

Ack

> 
>> +automation in place which should point out any new warnings.
>> +
>> +If a commit introducing new warning gets accepted somehow, the resulting issues
>> +shall be fixed in reasonable time (e.g. within one release) or the commit
>> +reverted.
> 
> It is loosely related, but I was wondering if we should also try to push
> people that change the platform's bindings to update the DTS also, so
> that binding changes do not introduce W=1 complaints?

Makes sense, we could add such rule to Devicetree maintainer profile.
Anyway enforcing it relies on Rob's bot reporting the warnings, which
seems silent recently.

> For many bindings the platform entry in MAINTAINERS does not cover them,
> but things like the arm64 Apple stuff mention them specifically & others
> will get coverage due to regexes.
> 
> Anyway, nitpickery aside I like this approach.
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> 


Best regards,
Krzysztof

