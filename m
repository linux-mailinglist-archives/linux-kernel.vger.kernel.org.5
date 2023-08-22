Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC187844B1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 16:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236934AbjHVOui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 10:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbjHVOuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 10:50:37 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1192D10B
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 07:50:36 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-52683b68c2fso5580690a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 07:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692715834; x=1693320634;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=msluY5KPez98wZI/eOA0tUrL+vBFFBWXhziisrbzFJo=;
        b=JErqmgPYQ5xytD5TGE6BelBNXyv/kKLLqbtPpxEVDujREXURJpUJgxSsw8i2fXs8Ca
         Zg84Fqne/uwCoyb8hOmwqt0NUXP+WqcJytoPhlUycYzeXJ8CVq2Wl5EkyUa87JnJbIpm
         Fi+v67UdEFKzzxsCFL4KNb9zXByGK0ynwFC/CfrWsyjDI52e34O1bp4xQccxiPaOYKwr
         jzvL9KnsM5zFtdtawzVCk2lgW+G87tEOQajXgSH8y1eUwrw7i2e87iI6wkmwueQuaMPz
         KzXmSxsDVqRV4Uo1xrq9CNw+v89dM5YBoLM7+D4x8g2jAN3PUBHKug0ShZV5WRgwNO2i
         IMEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692715834; x=1693320634;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=msluY5KPez98wZI/eOA0tUrL+vBFFBWXhziisrbzFJo=;
        b=eaAeyX05FON74thjjfe2Pd8fq8ArjY0QcvxtszqF+JMJ0Px6AZ0iJ5b4cUJD0Kgj1A
         bwnpd0edzcIh4S+3hPJ74G1yl+5VQdMFpMOOu46HSL05BtvxDXGD0Q901Y7dzLibGg42
         9R36K44pV8aqt7Oh0NzFOBxCcD8lkIrxQAMosw3hbELsZqCLm8sg3ifPyIYfki6AI7MD
         mbOAqbIrRs/Yjgz0af6ttnvn9CKteikQXZHk938ppCy8EhloUZ4BYet3IwIGs5P9xuWR
         QoClyKMW8ek7UTjFdtDXa+qhlVS67qdsLy1Vh1sEDf5uFGCOMEUJ2QxN+mgipHx/4W2Z
         nMKw==
X-Gm-Message-State: AOJu0Yy0MTml+Y+28Yp+G2FBIeknqHZwArHgjGRiAHFHopbcJ018sBN1
        9xhoOfSFeLJgEcYP8KgnmdQK0Q==
X-Google-Smtp-Source: AGHT+IEQQHveuQ5XBnXwAP3Jhb7yCJfBTmJT3JQb429ZDHDNyFXBgCmBienC2MnKPNIiz9yElIh86w==
X-Received: by 2002:aa7:d6d3:0:b0:526:9c4:bc06 with SMTP id x19-20020aa7d6d3000000b0052609c4bc06mr6535019edr.18.1692715834488;
        Tue, 22 Aug 2023 07:50:34 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id d16-20020a50fb10000000b005224d15d3dfsm7725415edq.87.2023.08.22.07.50.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Aug 2023 07:50:33 -0700 (PDT)
Message-ID: <c4275bc0-a608-ffe6-906a-f79037b19191@linaro.org>
Date:   Tue, 22 Aug 2023 15:50:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 00/22] nvmem: patches for v6.6
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
References: <20230814165252.93422-1-srinivas.kandagatla@linaro.org>
 <2023082217-banter-craftwork-281a@gregkh>
 <2023082251-browsing-moocher-6ecf@gregkh>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <2023082251-browsing-moocher-6ecf@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/08/2023 15:35, Greg KH wrote:
> On Tue, Aug 22, 2023 at 04:34:32PM +0200, Greg KH wrote:
>> On Mon, Aug 14, 2023 at 05:52:30PM +0100, Srinivas Kandagatla wrote:
>>> Here are some nvmem patches slightly more than usual for 6.6 that includes
>>>
>>> - Support for NXP eFuse, qcom secure qfprom, QCM2290 nvmem providers
>>> - core level cleanup around error handling and layout creation.
>>> - few minor cleanups across providers drivers to use better
>>>    apis and a typo fix.
>>>
>>> Can you please queue them up for 6.6.
>>
>> I did, thanks, but your email system needs to be fixed:
> 
> Oops, no, I've dropped them as I get the following build warning which
> turns into an error, and you can't break the build.  How did you test
> these?
> 
> drivers/nvmem/sec-qfprom.c: In function ‘sec_qfprom_probe’:
> drivers/nvmem/sec-qfprom.c:59:13: error: unused variable ‘ret’ [-Werror=unused-variable]
>     59 |         int ret;
>        |             ^~~
> cc1: all warnings being treated as errors

Sorry, my bad, There is already a fix for this [1] which I forgot to push.


Let me send a v2 wrapping that fix into the original patch.

--srini

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/srini/nvmem.git/commit/?h=for-next


