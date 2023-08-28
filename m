Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAC7A78B463
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 17:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbjH1PYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 11:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjH1PYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 11:24:05 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F354125
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 08:24:02 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-99bcfe28909so426379866b.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 08:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693236241; x=1693841041;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=72V2x3mKZTjFbmEG9hhyFoPHvMJYQFTBTRNOrHHTebM=;
        b=Ompvoblzs3Cp9UAhmm1CCL0laidAubR1emolqZQO5pGzyhcP5fs27FuiKSLo4jbnPc
         ZJZLYcNrvuR/XnSGJPL2y0G4v0tg33+1UYeMtCbZu0WgF67eIUHuVcMOpMKcPCsL4knG
         m9TboCQzBqEplZyQn0SsgMTnlApvrsQ54VSs6FOGePvX0+ntcwY2BWWLZk/IOxRqjbs/
         mn5p+vlgdnCTymfmgLIQjuiREmqlFVqR+Oz2ZHZvYJaMuu1dY0xO4iQBBFAZKBKOmZgT
         LZw3R0psqj+/QYYYyk4y3Co0Kixhlw5D0e7FWLyyMI4E5qS4VBtiXOuIUiCYGYPER3SG
         ZqqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693236241; x=1693841041;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=72V2x3mKZTjFbmEG9hhyFoPHvMJYQFTBTRNOrHHTebM=;
        b=QJAS4kgPDgN/OrN9ngOHnxnfwqNwIjCVWIZxJAS74Oc7Qpd9LCu/piqsEJvyusnQ3J
         XXh601nflSI+S5sHapBxcoDVLKIQ7zvOLOFbYwm0aLWcpVXjlgWFHFQ8re2apqVCl+rC
         t0biUfWvsu2Jz7BtQZOE9eea9Bd3VnJGq7fiPlI3ikA7XF2MRatwkYBf6/s5JNJysNRK
         WENfrM734rNb+PjM2j1pjwnXFaYgLZ9qQ0CfK/X1DmDdeO/H4RSY7/H2YnpRfKzo/Tuz
         ObXepGtGTlPHkVb/Ckk4n1pga3U9rbHZ0xmNdxPpDq5gAcFCcOZAZKJwB0bFvOCnenwV
         dP6g==
X-Gm-Message-State: AOJu0Yz2+/8BJTnLNwklaw4mQ4o2SDzFKDgurMqtSwEOFLt9peSLItLK
        iO3i4Wl01V1wGPbYc/4h7/a+tQ==
X-Google-Smtp-Source: AGHT+IH9zZnahhAaJO4DU+2Gx+LWE+isMcEILa2c7LEidmge9Dr+hODq28bZiFtKa1uoaQGgr8j/Ig==
X-Received: by 2002:a05:6402:12cb:b0:522:3410:de23 with SMTP id k11-20020a05640212cb00b005223410de23mr20309002edx.3.1693236240895;
        Mon, 28 Aug 2023 08:24:00 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.225])
        by smtp.gmail.com with ESMTPSA id f15-20020aa7d84f000000b0052228721f84sm4588463eds.77.2023.08.28.08.23.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Aug 2023 08:24:00 -0700 (PDT)
Message-ID: <89c73602-43f1-30a4-ad58-637aadacd653@linaro.org>
Date:   Mon, 28 Aug 2023 17:23:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3 1/1] scripts: Add add-maintainer.py
To:     Vlastimil Babka <vbabka@suse.cz>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Jani Nikula <jani.nikula@intel.com>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        quic_pkondeti@quicinc.com, linux-kernel@vger.kernel.org,
        kernel@quicinc.com, workflows@vger.kernel.org,
        tools@linux.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
References: <cover.1693037031.git.quic_gurus@quicinc.com>
 <141b9fcab2208ace3001df4fc10e3dfd42b9f5d9.1693037031.git.quic_gurus@quicinc.com>
 <87jztf37ny.fsf@intel.com>
 <20230828133554.GA818859@hu-bjorande-lv.qualcomm.com>
 <CAMuHMdU+3oj+-3=f5WFVTRsKQjqCpU8SnVqKSZGk8XRxhsDcVQ@mail.gmail.com>
 <9aec0740-2482-d3ad-caf2-5e6278a050b3@suse.cz>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <9aec0740-2482-d3ad-caf2-5e6278a050b3@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/08/2023 17:14, Vlastimil Babka wrote:
> On 8/28/23 15:48, Geert Uytterhoeven wrote:
>> Hi Bjorn,
>>
>> On Mon, Aug 28, 2023 at 3:37 PM Bjorn Andersson
>> <quic_bjorande@quicinc.com> wrote:
>>> On Mon, Aug 28, 2023 at 11:14:41AM +0300, Jani Nikula wrote:
>>>> On Sat, 26 Aug 2023, Guru Das Srinagesh <quic_gurus@quicinc.com> wrote:
>>>>> This script runs get_maintainer.py on a given patch file (or multiple
>>>>> patch files) and adds its output to the patch file in place with the
>>>>> appropriate email headers "To: " or "Cc: " as the case may be. These new
>>>>> headers are added after the "From: " line in the patch.
>>>>
>>>> FWIW, I personally prefer tooling to operate on git branches and commits
>>>> than patches. For me, the patches are just an intermediate step in
>>>> getting the commits from my git branch to the mailing list. That's not
>>>> where I add the Cc's, but rather in the commits in my local branch,
>>>> where they're preserved. YMMV.
>>>>
>>>
>>> May I ask how you add/carry the recipients in a commit?
>>
>> I guess below a "---" line in the commit description?
> 
> Does that do anything special in commit log? I'd expect (and I do it that
> way) it's rather just adding a

It does. It goes away.
> 
> Cc: Name <email>
> 
> in the tag area where s-o-b, reviewed-by etc are added.

Why storing autogenerated scripts/get_maintainer.pl CC-entries in commit
msg? The non-maintainer-output but the automated output? There is no
single need to store automated output of get_maintainers.pl in the git
log. It can be easily re-created at any given time, thus its presence in
the git history is redundant and obfuscates the log.

Best regards,
Krzysztof

