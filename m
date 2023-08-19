Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B019781820
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 09:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344456AbjHSHvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 03:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344387AbjHSHvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 03:51:01 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99CE33C0A
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 00:50:59 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-5257e2b5d12so1973692a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 00:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692431458; x=1693036258;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c2oYh3TTzNeTuUfhfe9bLaXyjjwVpe2Z5um2bA3QDLw=;
        b=Ch/ZUaVNG8SyNggdPRWr6YWdqOGZg9KmQXV1MOwzgEX3peRKUvPm3qzctqZUm9a0aI
         kRC+/gGhtCI7g8sjK+u5t5Zk0SUw58alahFB0Vh9L0BkVu51DJXGCi208IAjV7KH8I6H
         wcfu5b6Eoiv5q9qMtSJ58Ki4JqKywBtcrDcg9/aIZi2EV6bIO09rOVUEUw1yHvX4ckJ1
         KQ1+WilUo9q+JN1bUn6h3xCKTIpamsMgNaeAZsem+BQjBXRQKXsThG6eYb0SDRwaH71v
         6w0wHUTJoU31hTog5O+hcTHB73XgPmQW2CuEiparQvtfcMVERR/yEht/HeyGyyC1KU0W
         2yAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692431458; x=1693036258;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c2oYh3TTzNeTuUfhfe9bLaXyjjwVpe2Z5um2bA3QDLw=;
        b=Ob2me4nx5Mmbu8sbBrcjB9I1G1W00MwOXxoY306NtVPUU2lG129cRJpuIHi6UyGS9o
         mzdM0gHzODXL5fSPDxXwwPqB221evNnd9XzZPNoDfJGRaTp96mpCIKewro2zW9L+7SeH
         se6zAjTbwdf20Qx6q4QymbQve8u+O08yEu1BrPn6jQ62gln3/LYVvZKHaligHGFaPy91
         P2KtsE+r2djA6/6m+QdVkGWuZFfV7KsuPUwlQdySqjLiFDX8HIz4ybSZfWDllKwZE0T8
         aYRJp9ui379AehRqOzVDIQGkNnOq2Jx+knF/J8LxOR+QcVI1/OWh9NYcMa/Mus10dfXC
         9u5g==
X-Gm-Message-State: AOJu0YxhaVoi0OlSYFbDhCcLPBg07eOantMJYBmRfo8PRAHECJSgHe/S
        EiN2UGcaMCpnj5EDXX/4umZS4g==
X-Google-Smtp-Source: AGHT+IH5bBzz6oXjRhDT4zgMtjhALSUwRs/3e/TBQjpuXStR7NkNyoV3p/BdDFW1VR4ywleUSwPN7g==
X-Received: by 2002:aa7:d6cc:0:b0:525:69c8:6f4f with SMTP id x12-20020aa7d6cc000000b0052569c86f4fmr1081908edr.23.1692431458128;
        Sat, 19 Aug 2023 00:50:58 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id c22-20020aa7c756000000b00522572f323dsm2052775eds.16.2023.08.19.00.50.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Aug 2023 00:50:57 -0700 (PDT)
Message-ID: <6f475c9b-dc0e-078e-9aa2-d876a1e02467@linaro.org>
Date:   Sat, 19 Aug 2023 09:50:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 0/1] Add add-maintainer.py script
Content-Language: en-US
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Guru Das Srinagesh <quic_gurus@quicinc.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Kees Cook <keescook@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        quic_pkondeti@quicinc.com, u.kleine-koenig@pengutronix.de,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
References: <cover.1691049436.git.quic_gurus@quicinc.com>
 <20230810185526.GC31860@quicinc.com>
 <4d94d0fd-72d4-0196-3a30-3e1efb9f5aca@linaro.org>
 <20230816171538.GB26279@quicinc.com>
 <6fb1176f-90f1-7a65-3ab5-f6447418c51e@linaro.org>
 <20230818194609.GA1428172@hu-bjorande-lv.qualcomm.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230818194609.GA1428172@hu-bjorande-lv.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/08/2023 21:46, Bjorn Andersson wrote:
>>>
>>> With this script, the workflow would be as simple as:
>>>
>>>   1. Generate patches using `git format-patch`
>>>   2. Run `add-maintainer.py` on the above patches
>>>   3. `git send-email` the patches.
>>
>> So one more unnecessary step (2). I don't think it is easier than my
>> workflow.
>>
>> I just do only 1 and 3 and that's it. The simplest way ever.
>>
> 
> There's no get_maintainer.pl in either 1, or 3, so obviously this isn't
> the only thing you do.
> 
> Thanks for the link to your alias below, it's now clear that you don't
> need an extra step in the procedure, if you only have your extra wrapper
> around step 3.
> 
> 
> I now also understand why you never ever have a cover-letter, something
> Guru's proposed flow handles quite nicely.

It's not related. I usually don't create cover letter from laziness, but
pretty often I create them as well and my script/alias works there
perfectly. Cover letter is just one more step:
1. git branch --edit-description
2. git format-patch --cover-letter (with format.coverFromDescription =
subject in gitconfig)
3. git_send_email 0*

No need to run any other tool, no need to add any maintainer entries
(unless touching defconfig and specific soc@ stuff, but this is always
the case regardless of tools).

Really, that script proposed here is the unnecessary step.

Rob's approach with git send-email identity required some work for
cover-letter, but it was also running get_maintainer.pl per each patch,
so recipients did not receive everything. Unless patchset is big, I
prefer to send everything to everyone.

> 
> 
> That said, b4 prep and b4 send seems like a better suggestion to those
> who doesn't already have a workflow in place.

Yes.


Best regards,
Krzysztof

