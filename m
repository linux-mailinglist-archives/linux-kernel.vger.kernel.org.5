Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 582D2783DA9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 12:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234692AbjHVKLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 06:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234691AbjHVKLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 06:11:41 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35809CFC
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 03:11:29 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-4036bd4fff1so264211cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 03:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692699088; x=1693303888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m0aet74oNs6B6aZP3zHJL6DaqiBdyTa5krwOSRs1jkQ=;
        b=4GJe1s1p0dY/EO/sMeo5l6OKEUn71iv5GbmtHxGECQ8G/c5zDLKlIlFi40ib7LoXvl
         ZFR4TSzXPfpheajQlUMeeaRE7HUxb+7jE8aCWVdMm7+gIZkc+tXKxQ2Za//LU1HNKZqq
         zi4X5jb+krb4KS+LQuOZn/ZvIK7VFr+0LIn2q7mLtOvEITBMAr+hY4pTFQw0ZeQQYVSr
         yCvJgzRSso1wAYkD4kbxBEjra8JXQqwsU4Pec676km9oVHP9aQ2sVBJBekokcTxAfIie
         2H4lY7r75W8dFGfDUOVaQgWoT62bRsRPRkHYDJupZfcGMzkdnNUcoQPTZvR+f81GdhXA
         YB0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692699088; x=1693303888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m0aet74oNs6B6aZP3zHJL6DaqiBdyTa5krwOSRs1jkQ=;
        b=X4Xn5RInzSPSxMHpGEnNSpK/KU/1epb5pIlDXwlLQmfRDZJsyK8+3W/V1XiAXyNepa
         WmPOUMEPnupTHq8K8/BrEOQHmdBjwvu/rT5PXvnPnVAoLl/aRBUKwU5GZe97fotVsIxJ
         Jx+OL+gRgN2EbcAovOVBMHwvqbmkcDX9kt8si/xEd+EyyjPE2v9or50/IAABO5SMPT0s
         ceZ2mGHfP2HD23djVkLBosoeF2JiIopv9lS6BadM7GStIHq9v2VpNrpirYs8p5vrRkeq
         EII70ycLzTSebZg7iXbbQqEddKJGsLy7c9K348fhXJjlK+CrvPgu9cIR2d3RXGzyKL+9
         xPBQ==
X-Gm-Message-State: AOJu0Yxn944E0BSNoWyvHSj2vqb4jWv+aXa2ZQ+YxrSXkch3daCq6X8w
        VC9T2xtkFM2WqdkX6WvvdgKrWu0hFh78s++LF+QvTWsptOd25etCgeWTgg==
X-Google-Smtp-Source: AGHT+IGcQQaJL1MF5GoPI5g2wwpYi0Dn/HGeGyVPl//rTVuMcMIa6CvOGMmzWZOZ+vKc0dtbZaAdUydM/3jqynFQ+Gc=
X-Received: by 2002:ac8:7f4c:0:b0:40d:eb06:d3cc with SMTP id
 g12-20020ac87f4c000000b0040deb06d3ccmr179947qtk.7.1692699088079; Tue, 22 Aug
 2023 03:11:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230817182055.1770180-1-mshavit@google.com> <20230818021629.RFC.v1.2.I782000a264a60e00ecad1bee06fd1413685f9253@changeid>
 <ZN5y4N8ffSoiR/sm@nvidia.com> <05f69a1a-97c9-ebca-5e01-c0b00699c93e@arm.com>
 <CAKHBV27suc5nDoH7gMHebjYBONTNqsugWvxbo2E-fRjRGs288w@mail.gmail.com>
 <ZN93TO9mRIrX1grw@nvidia.com> <CAKHBV24L7pTajkStWCRiW7976+B8VtDHRDpo+Emta0RshkvRhQ@mail.gmail.com>
 <ZONRRubvUK7GXO4i@nvidia.com> <CAKHBV26knnw7WjUP-6kw1v0T9=196d3cJa5zO1tQa4kjteO-fg@mail.gmail.com>
In-Reply-To: <CAKHBV26knnw7WjUP-6kw1v0T9=196d3cJa5zO1tQa4kjteO-fg@mail.gmail.com>
From:   Michael Shavit <mshavit@google.com>
Date:   Tue, 22 Aug 2023 18:10:51 +0800
Message-ID: <CAKHBV25n4pbcNXaxeG3KMN=cM3LUK4_+JK8C5WmN8fYSyNrA1Q@mail.gmail.com>
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
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
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

Ugh, ok, there's a reason arm_smmu_tlb_inv_range_asid duplicates
arm_smmu_tlb_inv_range_domain!
The invalidation isn't performed with the smmu_domain's ASID... but
with the CD's ASID (because the domain is the RID domain.... again).

I think we better leave this out of scope for this series as well.
Let's keep the redundancy for now, and add a parameter to make things
explicit. We can clean things up when the above is fixed.
