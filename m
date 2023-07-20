Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEFBF75AE82
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 14:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbjGTMf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 08:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjGTMfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 08:35:55 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA5872123
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 05:35:53 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-997c4107d62so117351866b.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 05:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689856552; x=1690461352;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=myw7PI+FCyKio3g/zcLcGlSy11Ejvz7tGQQF7fcbIUI=;
        b=RsjO8PUnjdufXpf/tArBv4Te7lbY/T9GNu1DCIgU+a/WxaPrkl2rNfnnV7ZjBNNlpK
         FJEZ3j4zE/pDBbjEgOoHKp7xQf1Cstx0AtiY8zKNuj8BCi/TP8JSeoz7ECIIMestnaNZ
         oaBl/ncmXZCbFgqszHvlNp1VR8CFg3T+HRoHrC/JwZUBL09Fk66RsQwBbQx/oxfl4j8A
         cgt+5Q9F/7CvccRVaNSI2qRAKkDByHHMrHHy2VjtkQL/jWjUgOYFcgxaxwbwgfngrZzw
         apdkD5Uz1pkXQLvGrMHVkR2n08+LOcDgSm9P7pTmbmwdWiCKIA9y1BkrHTRHxkNwkMVq
         EQZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689856552; x=1690461352;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=myw7PI+FCyKio3g/zcLcGlSy11Ejvz7tGQQF7fcbIUI=;
        b=I3Pp8JX4XYkv9OYMMQ+bJuxO3iSNII3a7ntPk++kPmov5dj5GFmuyIlFVqGyFFRvVh
         aswMCKVoqpYp0deLcFQSVTcyjRTXaXEmB/0eXK5JF6herkozHto++g7f58IBzElsucxI
         eNFJHWQJIKW15VxcrC9kiBI8yCsHsGZBMbmyL6Wk/KcnG3eV4dfobieoiB0F3Ys9jj9J
         EennLZ+E1zL44ASk8Kwo8qVhyzQv+7buLR3yx5iI6bQ5In95nDlgiPFxTb7NW6ST5eTh
         KMV4oHMTCgx6xdn1AZW6Y3ft5iTTcjEfaULUfHOQQnG7FutGxSVuIxBGV5m3HDj5QzBc
         535w==
X-Gm-Message-State: ABy/qLao+Zhb/9I/zbHkZAsnVK8zZ2yM4frBMIAYoaupVNXpwlQOUDVr
        ReviziRrlE6KEVWx5UtZWLGqdg==
X-Google-Smtp-Source: APBJJlFpvMhS2TEhv5fL1Q0u/TaVzbThZGzpVmQnOCFKoEtb2tA2UwQYxJ1IFcodeUas7VvAgXbrFA==
X-Received: by 2002:a17:906:d04d:b0:997:e385:6597 with SMTP id bo13-20020a170906d04d00b00997e3856597mr4774366ejb.45.1689856552333;
        Thu, 20 Jul 2023 05:35:52 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id lc7-20020a170906dfe700b0098e4aef0791sm654842ejc.66.2023.07.20.05.35.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jul 2023 05:35:51 -0700 (PDT)
Message-ID: <ebb3267e-7257-654e-4a57-a55c626087f9@linaro.org>
Date:   Thu, 20 Jul 2023 14:35:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] power: supply: max17042_battery: Do not use CONFIG_
 prefix in regular C code
Content-Language: en-US
To:     Przemyslaw <przemekchwiala@gmail.com>, hdegoede@redhat.com,
        m.szyprowski@samsung.com, sebastian.krzyszkowiak@puri.sm,
        kernel@puri.sm, sre@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     lukas.bulwahn@gmail.com
References: <20230720123102.154699-1-przemekchwiala@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230720123102.154699-1-przemekchwiala@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/07/2023 14:31, Przemyslaw wrote:
> From: Przemyslaw Chwiala <przemekchwiala@gmail.com>
> 
> Using CONFIG_ prefix for macros is not a good practice.
> Use CONFIG_ prefix in Kconfig only.
> 
> Signed-off-by: Przemyslaw Chwiala <przemekchwiala@gmail.com>
> ---

For future:
Please provide changelog after --- and version your patches (git
format-patch -v2, or use b4).


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


---

This is an automated instruction, just in case, because many review tags
are being ignored. If you do not know the process, here is a short
explanation:

Please add Acked-by/Reviewed-by/Tested-by tags when posting new
versions, under or above your Signed-off-by tag. Tag is "received", when
provided in a message replied to you on the mailing list. Tools like b4
can help here. However, there's no need to repost patches *only* to add
the tags. The upstream maintainer will do that for acks received on the
version they apply.

https://elixir.bootlin.com/linux/v5.17/source/Documentation/process/submitting-patches.rst#L540

Best regards,
Krzysztof

