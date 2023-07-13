Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5453752872
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 18:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbjGMQfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 12:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232637AbjGMQfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 12:35:38 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 910D92D41
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 09:35:12 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-401d1d967beso2361cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 09:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689266111; x=1691858111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/0tnBY0Y8/bwKnmLpzTcUU9wCQlG8IWXPXBkGVcnoHw=;
        b=X6GrHI9lGLYu3yPTrOBHhjvdk9rAw/jNavkyOGvzqP57TvSbvU7RdS9Lh9/UbaI7mA
         6EG2s+81o3Og/OD4P0mkdjvdI1aX1HX47fi54BRECAEOiXyjF6ZAQfjczHt/Sq6bLIZi
         DwEMq2zE/ynNCBkmXa8pxFDSKppQ9tLqoyIOeuGnjRRaBfNH83wdC+xdFQeBT3VU4Wbu
         /XYhC72PCXbWNhFK984knIrhHvZHMYOY4jiydh2QB9XzEwmEJeP6NH1Z/zUUqiMdGoY4
         TORxYjZgYIo9rELNS74lYjX++IqjbD6BOnlcU8YqDgE3ioHyiZS0JEDFuWU678Z4TbnG
         igqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689266111; x=1691858111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/0tnBY0Y8/bwKnmLpzTcUU9wCQlG8IWXPXBkGVcnoHw=;
        b=SOVmGJsGakwR3iRQFL/23XV7uGV2FJ9g/Ec9fzF0mXFGQhUCRrLS9eWMaNbwz2jN1B
         O0KKb/+lFrzrTjDt0E8YQzmb1XlROEr8XWb47u9LgJbDA0LSnTji+HElVF+g4ogkciWK
         JU0ETnH2j8cg7kUgK/hGEpvEOsLxI8EMCVKRPPjDoKJW2QyoDpN+U5XV/SRk+S1UqLug
         pPae2vy6Weln0zItrozdXtjNjrFNBMZnrC8C7rdSsxoKsDr1yS923TiTsI73FgUNF5qI
         vg22ZO75gf9Z/La58QXWo5R2LU0dt+k2TMu0mhDBlna18uJ7XnucLOOP2tnkd0ot2hLC
         tPCQ==
X-Gm-Message-State: ABy/qLYrguVCUFKNYn9UyQP+SSfxZf7rQfDRTmR0aPIKsIAqMZKLG1NJ
        pbGywlYbiJZnvrI7EgNOwgdEI4V8658MEA1A1CREUQ==
X-Google-Smtp-Source: APBJJlHNKfPG76aMpE6PBWeSOZ8u4EIxgpzWc/MltqAh/kYbAk8R7UT9ux0NTmj5EYE3xdx2tInSZNkJ/6BBVhMbzD0=
X-Received: by 2002:a05:622a:301:b0:403:ac9c:ac2f with SMTP id
 q1-20020a05622a030100b00403ac9cac2fmr478923qtw.17.1689266111449; Thu, 13 Jul
 2023 09:35:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230621063825.268890-1-mshavit@google.com> <20230621063825.268890-3-mshavit@google.com>
 <ZK9RycgNAVrxe343@Asurada-Nvidia> <CAKHBV26wi+xKnNjo-R+QOcVLPH2KJTFP+mF4CW1xE61nOdF5GA@mail.gmail.com>
 <ZLAKQw+DzcpSRSyi@nvidia.com> <CAKHBV25YadRVFiag5z5Yc13L093ScWkCjAOCd=VuGm2RUaDyzA@mail.gmail.com>
In-Reply-To: <CAKHBV25YadRVFiag5z5Yc13L093ScWkCjAOCd=VuGm2RUaDyzA@mail.gmail.com>
From:   Michael Shavit <mshavit@google.com>
Date:   Fri, 14 Jul 2023 00:34:35 +0800
Message-ID: <CAKHBV25+vOroe+prca2ivSH341A8RLHW+shycyKD5z3UWZVgpQ@mail.gmail.com>
Subject: Re: [PATCH v4 02/13] iommu/arm-smmu-v3: Add smmu_s1_cfg to smmu_master
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Nicolin Chen <nicolinc@nvidia.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, jean-philippe@linaro.org,
        baolu.lu@linux.intel.com, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 12:16=E2=80=AFAM Michael Shavit <mshavit@google.com=
> wrote:
> domains a-la aux-domain). With this change, even attach_dev with a DMA
> or UNMANAGED domain is now just preparing a single entry into this
> common CD table.

I have to correct this part, arm-smmu-v3.c's attach_dev()
implementation does both: it writes to the pasid=3D0 entry of the
owned_s1_cfg's CD table, and then installs that CD table to the STE.
