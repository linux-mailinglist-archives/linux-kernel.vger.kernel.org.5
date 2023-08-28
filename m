Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 892A978B6E6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 20:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232974AbjH1SAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 14:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233037AbjH1SAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 14:00:02 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C7C012E
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 10:59:58 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-99bf8e5ab39so455414766b.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 10:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693245597; x=1693850397;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BjrkEommxgzVsvPeELM83BT2d5xXvo75H1UStaGsfMI=;
        b=JTayhNgjtHQx8fxD1S0ic9K2eV0gHdK4jVwPvnPUGd2lV1rXAApieBetsa8bytyDW5
         kMywhMh+NFRhCXY36/qiT3S+8rQTEW+i/V9PBCqjsV/VcP8DScv2dhRyBuZWwt3ghzRB
         m8KwSRIQ8hTxsukbALZVslO4oivb0kZSsuC3weid+ly8l8KNNyjRfAZzl3BH+KfHXmDv
         cVrxK6SpS1YGApwo4iLhrKEIW2iBp1nGzCFWGASuUbfp94glhsFkKKjOQVqARPKZbGIs
         fAxj62ynY1wCpC7pkNCdi5h+EA10oCOXTjyg2BuRZ+r78s9uIXEdtA/l+JpCzH4OUS7m
         QCuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693245597; x=1693850397;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BjrkEommxgzVsvPeELM83BT2d5xXvo75H1UStaGsfMI=;
        b=M4Snw3NvUGDd3KDX/fdmpgCH9QpQij4tMXhAhFh1NmO6rsjmdIWKmZ7EUx/90VlaaN
         kLH7L1L5dCGig+PfjIrsFAW2Cr9EnyhgBNuLiKcdCTKe3w3Mdb9KTVldgSun1tLymVUL
         mPTB1I0GnOIy6af5EwcIGe57Wwh1eZre4XCdyuIKG6te48yFn/+3QBQQdYRiAV0a+P2X
         lco8tx3TF4l8Q1xJjKDi3Ndp2fiAxxtNqKEcsGJlhiktwhHmC+4Di9foK3sJGpEmVj53
         4m/K2DAFmDCnk8SvqHkibmPwdPt5QAO2+Lz0wnDBzc8fJ9RC/I/hqNZWsQh3+G6ikSoC
         /IbQ==
X-Gm-Message-State: AOJu0YzjxPLairze2jLakMLbE4aJDsCxNByuVCv8IyE5Ab/hvX9w4jBc
        ko9E6uWHAELwBIuU51h8oNe9yQ==
X-Google-Smtp-Source: AGHT+IEgWbg5t5ZGn+L+7J47VuL32+upXijCivlJd+5GNKo6BO3FJ+P2Y6r8QA61T+yNo9WfJ947sA==
X-Received: by 2002:a17:906:2921:b0:99c:f966:9ea2 with SMTP id v1-20020a170906292100b0099cf9669ea2mr17270150ejd.25.1693245597040;
        Mon, 28 Aug 2023 10:59:57 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.225])
        by smtp.gmail.com with ESMTPSA id b8-20020a170906194800b009920e9a3a73sm4921968eje.115.2023.08.28.10.59.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Aug 2023 10:59:56 -0700 (PDT)
Message-ID: <78aa33f9-ead8-b128-2a7a-40530a1a3ed0@linaro.org>
Date:   Mon, 28 Aug 2023 19:59:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3 1/1] scripts: Add add-maintainer.py
Content-Language: en-US
To:     Masahiro Yamada <masahiroy@kernel.org>,
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
 <2efba6b3-2399-9deb-d0ce-78f7b5e12f30@linaro.org>
 <20230828175629.GC23466@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230828175629.GC23466@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/08/2023 19:56, Guru Das Srinagesh wrote:
> On Aug 28 2023 10:21, Krzysztof Kozlowski wrote:
>> On 26/08/2023 10:07, Guru Das Srinagesh wrote:
>>> This script runs get_maintainer.py on a given patch file (or multiple
>>> patch files) and adds its output to the patch file in place with the
>>> appropriate email headers "To: " or "Cc: " as the case may be. These new
>>> headers are added after the "From: " line in the patch.
>>>
>>> Currently, for a single patch, maintainers and reviewers are added as
>>> "To: ", mailing lists and all other roles are added as "Cc: ".
>>>
>>> For a series of patches, however, a set-union scheme is employed in
>>> order to solve the all-too-common problem of ending up sending only
>>> subsets of a patch series to some lists, which results in important
>>> pieces of context such as the cover letter (or other patches in the
>>> series) being dropped from those lists. This scheme is as follows:
>>>
>>> - Create set-union of all maintainers and reviewers from all patches and
>>>   use this to do the following per patch:
>>>   - add only that specific patch's maintainers and reviewers as "To: "
>>>   - add the other maintainers and reviewers from the other patches as "Cc: "
>>>
>>> - Create set-union of all mailing lists corresponding to all patches and
>>>   add this to all patches as "Cc: "
>>>
>>> - Create set-union of all other roles corresponding to all patches and
>>>   add this to all patches as "Cc: "
>>>
>>> Please note that patch files that don't have any "Maintainer"s or
>>> "Reviewers" explicitly listed in their `get_maintainer.pl` output will
>>
>> So before you will ignoring the reviewers, right? One more reason to not
>> get it right...
> 
> In v2, Reviewers were added as "Cc:" whereas here in v3 they are added as
> "To:". Not sure where you're getting "ignoring the reviewers" from.
> 
>>> not have any "To: " entries added to them; developers are expected to
>>> manually make edits to the added entries in such cases to convert some
>>> "Cc: " entries to "To: " as desired.
>>>
>>> The script is quiet by default (only prints errors) and its verbosity
>>> can be adjusted via an optional parameter.
>>>
>>> Signed-off-by: Guru Das Srinagesh <quic_gurus@quicinc.com>
>>> ---
>>>  MAINTAINERS               |   5 ++
>>>  scripts/add-maintainer.py | 164 ++++++++++++++++++++++++++++++++++++++
>>>  2 files changed, 169 insertions(+)
>>>  create mode 100755 scripts/add-maintainer.py
>>>
>>
>> I do not see the benefits of this script. For me - it's unnecessarily
>> more complicated instead of my simple bash function which makes
> 
> Your function adds mailing lists also in "To:" which is not ideal, in my view.
> You've mentioned before that To or Cc doesn't matter [1] which I disagree
> with: it doesn't matter, why does Cc exist as a concept at all?

To/Cc does not matter when sending new patch, because maintainers know
they are maintainers of which parts. I know what I handle.

To/Cc still makes sense in other cases, when for example you ping
someone asking for reviews. It also makes much more sense in all
corpo-worlds where such distinction is obvious. We are not a corpo-world
here.


Best regards,
Krzysztof

