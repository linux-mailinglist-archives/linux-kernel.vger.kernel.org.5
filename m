Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6366782585
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 10:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234014AbjHUIeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 04:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjHUIeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 04:34:15 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E59A6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 01:34:13 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-40c72caec5cso355821cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 01:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692606852; x=1693211652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SVU/Nryq1OKFV/57dRCXe3Tz8/JE0s1HOyjf1K6mQAA=;
        b=SVbxWMRl2XXD6/2UwEQS9lOlAvrGmy6841NebQiw2Meun2Ufvzr1pV+erEzIt6I4jB
         jkU6hH0tS8ezkTvI5rdPxQp7Njc/+Q4XEzZqs/2eOKLfhd/PRT8YU/+1XWnoRbFLguxr
         jGqJvUMyaoAc+26H6qTfaBRGyKdokkWDto+iKb7fCmTh5IQqTZ9yXxhWtiwAXnHNwGjz
         cfmPuJPTeJeXt9Vented9LfLJ0gpQPnDszsm2VigVz1j0zR20anQTTqJ9kvDy6XourAF
         tE1k7nOlltwKMU69UZCxnhdeKbDYaKKEuIo3kcw3JMGKxP6h3vD/dbZ6EBYiikBtKgfJ
         FsdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692606853; x=1693211653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SVU/Nryq1OKFV/57dRCXe3Tz8/JE0s1HOyjf1K6mQAA=;
        b=eyPxW1ln2TOU3ysP7eAMbOaRd6d8C1noHpHaVs+ZyJYwbEcqjTSZaOPR01MjSSnBck
         XFRLGxS287yuwNJB246BpmVAif+ESdovO/phpYCBAGbhFkcsNim74wAGAmhu2wNjnfYb
         +xEpvu8qoIKLGKk8TGEtzshTlaG66XwadyqbkzsukeEJehoM3620PdNra9hAMNcpEH4o
         k5aJZmuuPlXTyZUVW94utxdF7PuAf2B4/UDlAc5SNzoq4U5BBOwCljpwAqgXsPJfgYmd
         gThXzbkUkA91AhuONtYZwu/heEvP0N9qGOURY3VIb0V99ggG06UkLfEZj3MkgqSkeaf0
         +H/w==
X-Gm-Message-State: AOJu0Yz4++oFHmxvh/Rrr+wW1Ma3RisokvhuOB8rm/D9jyouL91CC35t
        QfBf4Utz9J5Q4tE59CzdNwDN6fybMMP5iuk+UC3byg==
X-Google-Smtp-Source: AGHT+IF5lj8CqHKSU+fGMj/v8EBHtUcF6dqeGwaeTNaKC8TL0GuPMcu82VpIJISeaDPykuUbG2akzADW3j32bjwlPZg=
X-Received: by 2002:ac8:5bc4:0:b0:410:8ba3:21c7 with SMTP id
 b4-20020ac85bc4000000b004108ba321c7mr191159qtb.18.1692606852525; Mon, 21 Aug
 2023 01:34:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230817182055.1770180-1-mshavit@google.com> <20230818021629.RFC.v1.2.I782000a264a60e00ecad1bee06fd1413685f9253@changeid>
 <ZN5y4N8ffSoiR/sm@nvidia.com> <05f69a1a-97c9-ebca-5e01-c0b00699c93e@arm.com>
 <CAKHBV27suc5nDoH7gMHebjYBONTNqsugWvxbo2E-fRjRGs288w@mail.gmail.com> <ZN93TO9mRIrX1grw@nvidia.com>
In-Reply-To: <ZN93TO9mRIrX1grw@nvidia.com>
From:   Michael Shavit <mshavit@google.com>
Date:   Mon, 21 Aug 2023 16:33:36 +0800
Message-ID: <CAKHBV24L7pTajkStWCRiW7976+B8VtDHRDpo+Emta0RshkvRhQ@mail.gmail.com>
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

On Fri, Aug 18, 2023 at 9:51=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Fri, Aug 18, 2023 at 11:44:55AM +0800, Michael Shavit wrote:
> > On Fri, Aug 18, 2023 at 3:41=E2=80=AFAM Robin Murphy <robin.murphy@arm.=
com> wrote:
> > >
> > > On 2023-08-17 20:20, Jason Gunthorpe wrote:
> > > > It is certainly wrong to skip invalidations generated for any other
> > > > reason.
> > > >
> > > >  From what I can tell SVA domains should have their CD table entry
> > > > programmed with "ASET=3D0" and normal paging domains should be
> > > > programmed with "ASET=3D1". This causes only the SVA domains to lis=
ten
> > > > to the BTM invalidations.
> > >
> > > Correct.
> > >
> > > Thanks,
> > > Robin.
> >
> > Would it be fair to rename arm_smmu_tlb_inv_asid (or move into
> > arm-smmu-v3-sva) to make it explicit that it shouldn't be used outside
> > of SVA then? Or add a parameter such as skip_btm_capable_devices.
>
> ???
>
> arm_smmu_tlb_inv_asid() is generally used in many places and has
> nothing to do with BTM..
>
> Did you mean arm_smmu_tlb_inv_range_asid ?

Whoops yes that's what I meant.


>
> Broadly, invalidation is not SVA specific..
>
> Notice that arm_smmu_tlb_inv_range_asid() already duplicates
> arm_smmu_tlb_inv_range_domain().
>
> IMHO I would split the ATC step out of arm_smmu_mm_invalidate_range(),
> get rid of arm_smmu_tlb_inv_range_domain(), and have the mmu notifier
> just do as it already does:
>
>         if (!(smmu_domain->smmu->features & ARM_SMMU_FEAT_BTM))
>                 arm_smmu_tlb_inv_range_domain_no_atc(start, size, smmu_mn=
->cd->asid,
>                                             PAGE_SIZE, false, smmu_domain=
);
>         arm_smmu_atc_inv_domain(smmu_domain, start, size);
>
> And make arm_smmu_tlb_inv_range_domain() just call
>    arm_smmu_tlb_inv_range_domain_no_atc();
>    arm_smmu_atc_inv_domain();

That's a nice clean-up but doesn't really solve the problem faced by this p=
atch.

This patch series eliminates the smmu_domain->smmu handle, replacing
it for a list of SMMUs. So SVA can no longer optimize the
arm_smmu_tlb_inv_range_asid call away by checking whether the SMMU BTM
feature is enabled since there's now a list of SMMUs with possibly
heterogeneous support for the feature. Since there's now a loop over a
series of SMMUs inside arm_smmu_tlb_inv_range_asid, it makes sense to
move the check into that loop. This technically works because only SVA
is calling arm_smmu_tlb_inv_range_asid but can (IMO) risk introducing
bugs in the future since it's not obvious from the function name.

The suggestion was then to introduce a parameter to
arm_smmu_tlb_inv_range_asid (or arm_smmu_tlb_inv_range_domain_no_atc)
to make this behavior explicit in the API.
