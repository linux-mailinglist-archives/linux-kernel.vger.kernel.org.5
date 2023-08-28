Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 259E178A799
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 10:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbjH1IWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 04:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbjH1IWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 04:22:19 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E9FDCF2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 01:21:43 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-99c0cb7285fso382646466b.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 01:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693210894; x=1693815694;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R/ThTKBMXaBdcMw21bB4Tb4UrarGnjH7VR3jlnjNz0o=;
        b=p0ofPENfE3XRABjMqYG0NDnT45lF6wkg4OivHw849Jmd0NTzi42hEWq4NSQm/ui6/H
         mx+cwroHygO0OeNDvQFFKbX4ynkLaDOOF8/1d0TzAbG5PGFRXdDhu+hqF/kSxGrZdmvX
         e6V0YiOH8qQPJoBgoNd331iQFOgFiRTtSX+bceYEo8QIdxaUjjggwwpKNCRG2lfuih9U
         YUA9cUMkdFwbdO4XsGbhVJ9BbxWdk7vMCFIMK519m6PXam6shCgHvBUA+lep9Em5zDD3
         AwQnmUMZj/8CrZwRg1r+SCdrak/ThkoTNCWe05o7IqFg06EMGtFoKmhu0dEJ+3/HhqUs
         UKLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693210894; x=1693815694;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R/ThTKBMXaBdcMw21bB4Tb4UrarGnjH7VR3jlnjNz0o=;
        b=H2x439cMNTlhBnslKf5ELrQAUy2E85wHQUMJp7Hk+ohKf8HPofnWF6Lc+pBE4dGh6j
         q02w0Y7Jcva76RNOE3RfPHn45UOFpt02VHcgJxBn16yaGEzUtErtKTYTzz3Uy9Scxi2E
         Clw8MnmeceCFrNw508ReTqhRfLnNpW9VZuX7QG8QPsgiXGRJrHscAziDhKhc7TRvp0N9
         RSzWfpEFHxoCOKA3Hacj2GMMrfdCA4bhpJRwLh4DSlR3pcSurRAn5DxJGNL8rVYALFC0
         LniM2zpt/PdSa4g2dHEvVZsgaynPkzknLQzvrasOvNIQIEmkD4pr0G69h7tMtyPMnSgj
         jv+Q==
X-Gm-Message-State: AOJu0YxVryfU0zpdF1SjpuVRtJaWP9n0nSfhTSyIBarCkiU7UFoebTFj
        Fn6v2MNYbz5dNl+zi0wHiYy2Hw==
X-Google-Smtp-Source: AGHT+IFBUK6E4zrbQPaHC6jS5bTEiJnj2yId8vtYo61AG/BoM8FRNNTdWT0PxEWyM0E9uZwDnNK+lg==
X-Received: by 2002:a17:907:a04a:b0:9a5:78c0:44e6 with SMTP id gz10-20020a170907a04a00b009a578c044e6mr5892043ejc.16.1693210894452;
        Mon, 28 Aug 2023 01:21:34 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.225])
        by smtp.gmail.com with ESMTPSA id v24-20020a17090606d800b0099364d9f0e2sm4368823ejb.98.2023.08.28.01.21.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Aug 2023 01:21:34 -0700 (PDT)
Message-ID: <2efba6b3-2399-9deb-d0ce-78f7b5e12f30@linaro.org>
Date:   Mon, 28 Aug 2023 10:21:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3 1/1] scripts: Add add-maintainer.py
To:     Guru Das Srinagesh <quic_gurus@quicinc.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        quic_pkondeti@quicinc.com
Cc:     linux-kernel@vger.kernel.org, kernel@quicinc.com,
        workflows@vger.kernel.org, tools@linux.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
References: <cover.1693037031.git.quic_gurus@quicinc.com>
 <141b9fcab2208ace3001df4fc10e3dfd42b9f5d9.1693037031.git.quic_gurus@quicinc.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <141b9fcab2208ace3001df4fc10e3dfd42b9f5d9.1693037031.git.quic_gurus@quicinc.com>
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

On 26/08/2023 10:07, Guru Das Srinagesh wrote:
> This script runs get_maintainer.py on a given patch file (or multiple
> patch files) and adds its output to the patch file in place with the
> appropriate email headers "To: " or "Cc: " as the case may be. These new
> headers are added after the "From: " line in the patch.
> 
> Currently, for a single patch, maintainers and reviewers are added as
> "To: ", mailing lists and all other roles are added as "Cc: ".
> 
> For a series of patches, however, a set-union scheme is employed in
> order to solve the all-too-common problem of ending up sending only
> subsets of a patch series to some lists, which results in important
> pieces of context such as the cover letter (or other patches in the
> series) being dropped from those lists. This scheme is as follows:
> 
> - Create set-union of all maintainers and reviewers from all patches and
>   use this to do the following per patch:
>   - add only that specific patch's maintainers and reviewers as "To: "
>   - add the other maintainers and reviewers from the other patches as "Cc: "
> 
> - Create set-union of all mailing lists corresponding to all patches and
>   add this to all patches as "Cc: "
> 
> - Create set-union of all other roles corresponding to all patches and
>   add this to all patches as "Cc: "
> 
> Please note that patch files that don't have any "Maintainer"s or
> "Reviewers" explicitly listed in their `get_maintainer.pl` output will

So before you will ignoring the reviewers, right? One more reason to not
get it right...

> not have any "To: " entries added to them; developers are expected to
> manually make edits to the added entries in such cases to convert some
> "Cc: " entries to "To: " as desired.
> 
> The script is quiet by default (only prints errors) and its verbosity
> can be adjusted via an optional parameter.
> 
> Signed-off-by: Guru Das Srinagesh <quic_gurus@quicinc.com>
> ---
>  MAINTAINERS               |   5 ++
>  scripts/add-maintainer.py | 164 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 169 insertions(+)
>  create mode 100755 scripts/add-maintainer.py
> 

I do not see the benefits of this script. For me - it's unnecessarily
more complicated instead of my simple bash function which makes
everything one command less than here.
One more thing to maintain.

I don't see the benefits of this for newcomers, either. They should use
b4. b4 can do much, much more, so anyone creating his workflow should
start from b4, not from this script.

Best regards,
Krzysztof

