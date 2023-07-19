Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E82BD759CE5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 19:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjGSR4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 13:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbjGSR4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 13:56:08 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE288211B
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 10:56:02 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fc03aa6e04so67034185e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 10:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689789360; x=1692381360;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q+5oaw2J5+G3GYFPR3to60Ow5YDUAwCVY4MtrYxrWzo=;
        b=O5tdpOzllo11N68hbvqat1rL/4izSOZ0mS/2NFq3W6QpoHAAtnacEgIE/ney42oTv2
         baG9U7DhaLclF5umoDw473TrB85LBTE4niFhYh71kp24dX/IN8IpfpLtVSNPiSNmk0Dx
         ELKwjMmadFYml++d7mnvFvKSqrYKNyNROBtMVaoH+dgbYgQRa4NtT2p8yv3hAfaKipVP
         yy6b/5ssaNPZeA+Fct6luOsGclO3j1r2EQSsUwxf7NvfgxrmXZZxznrl1KpZMg4/Iu9x
         bA8Z4+a5tUdsu+6ZBbRGVBvC749z6UrX7ZbxxkgUHeCO5P4QVhijnULOlpui+1R/d/3A
         MUeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689789360; x=1692381360;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q+5oaw2J5+G3GYFPR3to60Ow5YDUAwCVY4MtrYxrWzo=;
        b=X1h+Ug9GGnxCkgENUrugLe9kZ27uZIdwQrsAL0QHvGpOooYNbrcy5CxRqMAfK1bArd
         60TjhsTxbagFDTRcRNEIpn9jag8N9CkrZZk2i9reie7HQbqR0srILduvGnY0f/x9Tk4M
         zTvyPWAPyZsYybRB0WxE1irvWcuGNzSoj1J6j9AITSeTqwP3UzNYp5nbzCNdgB36kMVL
         csmqIETFkUXLuBpKVTDNDvtWiAre5aVfIdAuFoackHD5eAiV71EczGMINm42er+/XPLu
         4UmW7X84qVnxWcoP7tK+0JFk2weLajo1EA7oIJ9eBbZ6eRe6uy7a7bjYAcG4D4ms+flE
         v9EQ==
X-Gm-Message-State: ABy/qLaT9TucVkDw2V1jYCGewBpDgOoKM35V8BqRzsJKPky/p/2KssVS
        IP8pwk62a+MXvPge726Bsk1s4g==
X-Google-Smtp-Source: APBJJlGJWPVncsHecZCDgmX0fdTLwFLC8Wokgg9i2konxqVAbiNqQMmWxybL1xsSOpnBwDHWUMyY6A==
X-Received: by 2002:a05:600c:20f:b0:3fb:ab76:164b with SMTP id 15-20020a05600c020f00b003fbab76164bmr2552075wmi.13.1689789360496;
        Wed, 19 Jul 2023 10:56:00 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id y9-20020a7bcd89000000b003fbb1a9586esm2232470wmj.15.2023.07.19.10.55.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 10:56:00 -0700 (PDT)
Message-ID: <71f2c286-c205-13b8-885a-240eae4131e3@linaro.org>
Date:   Wed, 19 Jul 2023 19:55:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 2/3] Documentation/process: maintainer-soc: add clean
 platforms profile
Content-Language: en-US
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, workflows@vger.kernel.org,
        linux-doc@vger.kernel.org, arm@kernel.org,
        Conor Dooley <conor.dooley@microchip.com>
References: <20230719143309.204766-1-krzysztof.kozlowski@linaro.org>
 <20230719143309.204766-2-krzysztof.kozlowski@linaro.org>
 <CAL_JsqLXanpk+cMG0b8Ze9WAfmRqcu6-5EsdKVKG3TKCOwnm7A@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAL_JsqLXanpk+cMG0b8Ze9WAfmRqcu6-5EsdKVKG3TKCOwnm7A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/07/2023 19:40, Rob Herring wrote:
> On Wed, Jul 19, 2023 at 8:33 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> Some SoC platforms require that commits must not bring any new
>> dtbs_check warnings.  Maintainers of such platforms usually have some
>> automation set, so any new warning will be spotted sooner or later.
>> Worst case: they run the tests themselves.  Document requirements for
>> such platforms, so contributors can expect their patches being dropped
>> or ignored, if they bring new warnings for existing boards.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>>
>> ---
>>
>> Changes in v2:
>> 1. Add Rb tag.
>> 2. Implement Conor's feedback: change doc title, follow->should follow,
>>    minor style changes.
>> ---
>>  .../process/maintainer-handbooks.rst          |  1 +
>>  .../process/maintainer-soc-clean-dts.rst      | 23 +++++++++++++++++++
>>  MAINTAINERS                                   |  2 +-
>>  3 files changed, 25 insertions(+), 1 deletion(-)
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
>> index 000000000000..c460923f39be
>> --- /dev/null
>> +++ b/Documentation/process/maintainer-soc-clean-dts.rst
>> @@ -0,0 +1,23 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +
>> +==============================================
>> +SoC Platforms with DTS Compliance Requirements
>> +==============================================
>> +
>> +Overview
>> +--------
>> +
>> +SoC platforms or subarchitectures should follow all the rules from
>> +Documentation/process/maintainer-soc.rst.  However platforms referencing
>> +this document impose additional requirements listed below.
> 
> I would make it clear how platforms reference this doc:
> this document in MAINTAINERS impose...

Sure.

> 
>> +
>> +Strict DTS DT Schema Compliance
> 
> Schema and dtc
Ack

> 
> 
>> +-------------------------------
>> +
>> +No changes to the SoC platform Devicetree sources (DTS files) should introduce
>> +new ``make dtbs_check W=1`` warnings.  The platform maintainers have automation
>> +in place which should point out any new warnings.
> 
> If a soc.dtsi file has warnings a new board.dts will duplicate all
> those warnings. I imagine those are okay? 

This. I would assume that these were existing warnings, so new board
does not add anything new. Different question if new board comes with
the same warning for compatible in TXT (not DT schema).

> Or are we assuming soc.dtsi
> is warning free? Or do we need to distinguish both cases?

Warning free, or at least not many warnings, should be implied,
otherwise I don't think it is possible to spot new warnings.


> 
> I would like to see a build target for the warning free platforms, so
> we can easily run it and check for no warnings. Just hasn't been
> enough platforms yet to do that.
> 
Best regards,
Krzysztof

