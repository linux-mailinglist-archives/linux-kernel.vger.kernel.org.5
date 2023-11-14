Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0177EB182
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 15:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232996AbjKNOGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 09:06:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233254AbjKNOGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 09:06:31 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FBFABB
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 06:06:28 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-da41acaea52so5789823276.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 06:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699970788; x=1700575588; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2R5VXLdFwq3Yr4sy4ojbP/K5dGOeJnAWKMocChwVIJ8=;
        b=PPWCOEPprtacJePnsWu9kkCpjRktIgxNF65D9qfCuaMcLpFBh1j/KFMgk+cfOmgcZ2
         eCM1NG2KPQwC/XO2MlquiMxD8wILmOvB/Ry+W2hSSjb1W+Vwcw24EW4r2RkhcWbOEwa5
         BPgNLq2e+J54vGF04pbINKsaHT68rdsSr4Hf2OpTTthdvG7zZNvZ+AelAywTs8IM43Gw
         6tXFzD5pXEpQhkA1ra473jKjl0Od/CqfzzmMBoo6p/ki0/wW31pdS/yd8PgHnBlErRLc
         RaosEv6H6P4mYKhmNqbdVQqgexMcGIlw2S96AVbdHTEGNTLhE0RCPQCCoVCndXHIgglk
         BpGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699970788; x=1700575588;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2R5VXLdFwq3Yr4sy4ojbP/K5dGOeJnAWKMocChwVIJ8=;
        b=hggmkjGF1LTW1OXAu+hazwchJKZR6VnuLOW92lKVxTuzTlt8n+VLLllLO7coCBsGkJ
         +Vx7eAF63qGcIEDAFa+rAGzcXHneOnTbxkbUiqQv8cGmsRUiCkFnB+RBsrWf0j56we+4
         OYz/kBV0e+RatVNLF1q6eUL+yuA6WiJU+h7U58Gka0QW6KvwNLv2roOgwMiWxcnt6UtD
         Xa4aRxtjuJ1MxbaG76QdFcPEuGVD9/FdRc71BH9WnKk03VCHcappsd34BTdIA62sDBig
         8lKrHviJF92r7Me7o0iCsjBlxss8lSaVQwEabmkde7YmoWTCNbCI7lMp4IPzcbig4A8G
         SgcA==
X-Gm-Message-State: AOJu0YxFFrD+5S0lKE67HqHvlWJIWBJ7AAfIYzN5g0/6LLHbL8hgHYaI
        lpAXqhabfLOuPMAmXKBxba1fb4QAeGD9gYM7P7E7uA==
X-Google-Smtp-Source: AGHT+IEGp77zVfveIN9Tv1vvBchnTPzGdXtXYANmtfvx4aFfUmUd7u+dIH4PTpunAnvF9bFQWXfZM8eoXOYs6RvC8B4=
X-Received: by 2002:a25:cacc:0:b0:da0:ccd6:b8a2 with SMTP id
 a195-20020a25cacc000000b00da0ccd6b8a2mr11294551ybg.19.1699970787662; Tue, 14
 Nov 2023 06:06:27 -0800 (PST)
MIME-Version: 1.0
References: <20231114135654.30475-1-quic_bibekkum@quicinc.com>
In-Reply-To: <20231114135654.30475-1-quic_bibekkum@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 14 Nov 2023 16:06:16 +0200
Message-ID: <CAA8EJppjChesDEXqUo5E1tRtjj_WH9NUBHKCyy8-n4YDCj0Yeg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] iommu/arm-smmu: introduction of ACTLR
 implementation for Qualcomm SoCs
To:     Bibek Kumar Patro <quic_bibekkum@quicinc.com>
Cc:     will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
        a39.skl@gmail.com, konrad.dybcio@linaro.org,
        quic_pkondeti@quicinc.com, quic_molvera@quicinc.com,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, qipl.kernel.upstream@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Nov 2023 at 15:57, Bibek Kumar Patro
<quic_bibekkum@quicinc.com> wrote:
>
> This patch series consists of three parts and covers the following:
>
> 1. Introducing intital set of driver changes to implement ACTLR register
>    for custom prefetcher settings in Qualcomm SoCs.
>
> 2. Adding ACTLR data and implementation operations for SM8550.
>
> 3. Re-enabling context caching for Qualcomm SoCs to retain prefetcher
>    settings during reset and runtime suspend.
>
> Changes in v2 from v1:
>  - Incorporated suggestions on v1 from Dmitry,Konrad,Pratyush.

Which suggestions? This doesn't tell anything.

>  - Added defines for ACTLR values.
>  - Linked sm8550 implementation structure to corresponding
>    compatible string.
>  - Repackaged actlr value set implementation to separate function.
>  - Fixed indentation errors.
>  - Link to v1: https://lore.kernel.org/all/20231103215124.1095-1-quic_bibekkum@quicinc.com/
>
> Changes in v1 from RFC:
>  - Incorporated suggestion form Robin on RFC.
>  - Moved the actlr data table into driver, instead of maintaining
>    it inside soc specific DT and piggybacking on exisiting iommus
>    property (iommu = <SID, MASK, ACTLR>) to set this value during
>    smmu probe.
>  - Link to RFC: //lore.kernel.org/all/a01e7e60-6ead-4a9e-ba90-22a8a6bbd03f@quicinc.com/
>
> Bibek Kumar Patro (3):
>   iommu/arm-smmu: introduction of ACTLR for custom prefetcher settings
>   iommu/arm-smmu: add ACTLR data and support for SM8550
>   iommu/arm-smmu: re-enable context caching in smmu reset operation
>
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 156 ++++++++++++++++++++-
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h |   2 +
>  drivers/iommu/arm/arm-smmu/arm-smmu.c      |   5 +-
>  drivers/iommu/arm/arm-smmu/arm-smmu.h      |   5 +
>  4 files changed, 159 insertions(+), 9 deletions(-)
>
> --
> 2.17.1
>


-- 
With best wishes
Dmitry
