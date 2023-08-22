Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBEE4783BA9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 10:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233778AbjHVIWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 04:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjHVIWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 04:22:17 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8471A12C
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 01:22:13 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-4036bd4fff1so236001cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 01:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692692532; x=1693297332;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=035Z4DWdhjk3oXMna5RKVA0vd/7PVI4Q30At83Psjek=;
        b=vajhMp/nJhIkdVSXWBr0q6Bmq/cpDtwwnntg9WX+cbyx4+QykDwalfXYUMMnvNLme8
         /66CTB6ty1wOI7nsvA0ZWVAXpYGK4jDeQ6BPbRsRQE1IlXSbmamhPtB/8TQIdSSCK6qI
         8WdgiJGeA00rqd+hewNTGTU9DZTsUnVJ/8hwgZuPRrRaoz5rZlxNitk8qI2TXySemaxn
         USVLtWmg6LMqJTmhFPg3X933BHkuWOcGkP5z87pUj/nLCPNj0nIFxOc6rPIpUgtw3xIp
         drD8Ba3VS+Ltb/rs076XyQj7BHJoXEq467bTIYdEb7/Pr/N6L2WrNlHqjK/14Dah6GG7
         d5Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692692532; x=1693297332;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=035Z4DWdhjk3oXMna5RKVA0vd/7PVI4Q30At83Psjek=;
        b=liJV5VL1o7myZJiBIDgaoJsfGxTOsgzIscXG+SK9+VpO0LQ9EQBh1f+jHqd+HavhVL
         sA1o1PjpH9b4439ihFdRt1dDlqM4t9UW5wrKZlg0dlpyaZvtqVcGdYxxbcVGOsj/eByM
         FIUtI0OS7R14qWMua9ZLbvN9XHQBCnyVxsCga+L38HmhzcQqrde5YC02od5KnzO8gP6v
         Apl/vWiJY9mDkF2D8n44fv4fh7L1xhp6d02jtWDEfCo998MZFWZ5aubdc7MX9gKnOrCG
         1zskqP7kWRhrS3Xub3K0raI7/H0gmMDGxFQ8Nz3aYRlID3uGLeg+9zGeFoZGbHJvT2ys
         6RVw==
X-Gm-Message-State: AOJu0YznI04ScZlEnfYHcF/eztIiULiCZb1scFNTH6Ui7+oJKnY7LwFI
        TLjk7UKZg7Pj+tcx+SJgWX9ok4RqO7aFVGDQz1P+ZA==
X-Google-Smtp-Source: AGHT+IFIWn0SdYzJML2bBic9el+KOaHhBqOGMOoy40UrltwvWrdEVxniizvKLdxkfWBxTbaXVEm6wmxD4iSmJx6vWDU=
X-Received: by 2002:a05:622a:15d6:b0:403:e1d1:8b63 with SMTP id
 d22-20020a05622a15d600b00403e1d18b63mr210444qty.24.1692692532485; Tue, 22 Aug
 2023 01:22:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230817182055.1770180-1-mshavit@google.com> <20230818021629.RFC.v1.2.I782000a264a60e00ecad1bee06fd1413685f9253@changeid>
 <ZN5y4N8ffSoiR/sm@nvidia.com> <05f69a1a-97c9-ebca-5e01-c0b00699c93e@arm.com>
 <CAKHBV27suc5nDoH7gMHebjYBONTNqsugWvxbo2E-fRjRGs288w@mail.gmail.com>
 <ZN93TO9mRIrX1grw@nvidia.com> <CAKHBV24L7pTajkStWCRiW7976+B8VtDHRDpo+Emta0RshkvRhQ@mail.gmail.com>
 <ZONRRubvUK7GXO4i@nvidia.com> <CAKHBV26knnw7WjUP-6kw1v0T9=196d3cJa5zO1tQa4kjteO-fg@mail.gmail.com>
In-Reply-To: <CAKHBV26knnw7WjUP-6kw1v0T9=196d3cJa5zO1tQa4kjteO-fg@mail.gmail.com>
From:   Michael Shavit <mshavit@google.com>
Date:   Tue, 22 Aug 2023 16:21:36 +0800
Message-ID: <CAKHBV25dK669AVe_H24PL6wgVXfnpL+MN5BiZyVam-2snWtccw@mail.gmail.com>
Subject: Re: [RFC PATCH v1 2/8] iommu/arm-smmu-v3: Perform invalidations over installed_smmus
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, nicolinc@nvidia.com, tina.zhang@intel.com,
        jean-philippe@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2023 at 4:17=E2=80=AFPM Michael Shavit <mshavit@google.com>=
 wrote:
>
> On Mon, Aug 21, 2023 at 7:58=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> =
wrote:
> >
> > > Since there's now a loop over a series of SMMUs inside
> > > arm_smmu_tlb_inv_range_asid, it makes sense to move the check into
> > > that loop. This technically works because only SVA is calling
> > > arm_smmu_tlb_inv_range_asid but can (IMO) risk introducing bugs in
> > > the future since it's not obvious from the function name.
> >
> > Well, I would remove the duplication and add an argument if you intend
> > to share the function that loops
>
> What do you think about this as a final stage:
> Once the set_dev_pasid and sva refactor lands, SVA could call a common
> arm_smmu_inv_range_domain implementation which would:
> 1. Skip the TLB invalidation on a per-smmu basis if it detects that
> the domain type is SVA, or based on a passed-in parameter that is only
> set True by SVA.
> 2. Issue ATC invalidations with SSIDs found in the arm_smmu_domain.
> This common function would be used for all use-cases: invalidations of
> domains attached on RIDs, on PASIDs (SVA and non SVA).
>
> Then we have two options for the intermediate stage with this series:
> 1. Non-SVA code uses arm_smmu_inv_range_domain which calls
> arm_smmu_tlb_inv_range_domain(_no_atc) and arm_smmu_atc_range_domain,
> SVA code individually calls those two functions.
> arm_smmu_tlb_inv_range_domain(_no_atc) accepts a parameter to skip the
> invalidation if BTM feature is set.
> 2. Same as option 1, but SVA also calls arm_smmu_inv_range_domain.
> arm_smmu_inv_range_domain accepts both a parameter to skip TLB inv
> when BTM is set, as well as an SSID for the atc invalidation. SSID
> would be 0 in non-sva callers, and mm->pasid for SVA.

(Something I sneaked in there is renaming operations that invalidate
both TLBs and ATC to remove the tlb/atc in-fix, but if people aren't
keen on such renames then yeah I suppose we'd need awkward names like
arm_smmu_tlb_inv_range_domain_no_atc)
