Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA81782B7B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 16:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235820AbjHUOSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 10:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232300AbjHUOSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 10:18:17 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB59197
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 07:17:42 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-4036bd4fff1so465241cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 07:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692627450; x=1693232250;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WAzozgm16X1fH0QFclRaTRQERG1CaHapJ13GxVKye5Q=;
        b=HKzG8MnNKT59JKbCg5XwG28xOwrgoVG/QBYrz3oaKAuuWobyXMcVjTOdV0iGY2nsvH
         K+eudKuW+fWFTQEv4JXFOM10RI/ERRQyXbG1N7hMPMtz+nhUhSIxnw0vmtUnqb6G0TlY
         jh+wSeoP3us+0xCfC5fzDWplM9u7EKuBaxKtmQrvA7kcO+M0m7zp+OMsWQ3RjosEW58E
         naBCF1qV4Uj7KE3NleNFt1O5yRcIu6qpf0TEj4oVksveglX7qzP15b047GPEnYiFwdxE
         BFXrFTPzObdEe7bPFlykzwFaytGELqpJwVlcMD/do6xKKUD1e/a+V4werEyvkZppK92j
         gepQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692627450; x=1693232250;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WAzozgm16X1fH0QFclRaTRQERG1CaHapJ13GxVKye5Q=;
        b=gh3qWgXOgBtJRsdBQTPwLwgUS1jouyCqd/e2iYlX7DSGgOrvWQooXCVMBSLYKyknfj
         rWaTYK2S8G3mDA6lwK0IfxHLXF9ErTfIUX4rqwebIXGpDEPUc0tpp0UPdYWjBxl38wEY
         I8M5uaUWnFKrsbGMRLV3DT4MhbwNeC1cxNw0UYzllj4Tc+XuO+fPRyozTfQvTdA+N/E7
         +b+VwaVDvCXKHp0MyuDxzNDtIgQl5A96yXKgz/+q6uDYlCz9ONCc5scng2bUqDbvtPcs
         18VPr4YOWaq6Y50sQCQrAYD/49LD1PcwLZrRtrbdkLyTRClMHKFwXyRt8V1RoW7EePvg
         pUvQ==
X-Gm-Message-State: AOJu0Yxq3zfex+s2zOnUtekJXt5T8DD74w7HGUSmpGDRrYZp4CI6OGDP
        UBaaFYZ4MhGINpOhQzPiNzJvwMRtI3OMdbJ/v8WQgw==
X-Google-Smtp-Source: AGHT+IE9PRTMqGnkgquRoMpeZ8f0d8+290ofPpCLmPgly2h8O41jg7Fo4+31v+rvj1qtP90WTx53jqwAMZzgzjGfcX4=
X-Received: by 2002:a05:622a:312:b0:410:9d31:68cd with SMTP id
 q18-20020a05622a031200b004109d3168cdmr117607qtw.27.1692627450221; Mon, 21 Aug
 2023 07:17:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230817182055.1770180-1-mshavit@google.com> <20230818021629.RFC.v1.3.I326c62dc062aed8d901d319aa665dbe983c7904c@changeid>
 <ZN5pK03Drao/egeF@nvidia.com> <CAKHBV27k8F0ZLy=RA=WhjJ7+C9JMHRRnKs=4W4pJMNmxrMEXxw@mail.gmail.com>
 <ZONQgNh6qarqgA+f@nvidia.com> <CAKHBV26oTZLssq5bopePojqgrEJwukKHYEbhU02nAvHHVB13mw@mail.gmail.com>
 <ZONrkVX6kZjX/wus@nvidia.com>
In-Reply-To: <ZONrkVX6kZjX/wus@nvidia.com>
From:   Michael Shavit <mshavit@google.com>
Date:   Mon, 21 Aug 2023 22:16:54 +0800
Message-ID: <CAKHBV27PL=2jxOd0BoYdoBMTu_0rm4z_JP6iG+SVi5Ag7w2kWw@mail.gmail.com>
Subject: Re: [RFC PATCH v1 3/8] iommu/arm-smmu-v3-sva: Allocate new ASID from installed_smmus
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, will@kernel.org, nicolinc@nvidia.com,
        tina.zhang@intel.com, jean-philippe@linaro.org,
        robin.murphy@arm.com
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

On Mon, Aug 21, 2023 at 9:50=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Mon, Aug 21, 2023 at 09:38:40PM +0800, Michael Shavit wrote:
> > On Mon, Aug 21, 2023 at 7:54=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com=
> wrote:
> > >
> > > On Mon, Aug 21, 2023 at 05:31:23PM +0800, Michael Shavit wrote:
> > > > On Fri, Aug 18, 2023 at 2:38=E2=80=AFAM Jason Gunthorpe <jgg@nvidia=
.com> wrote:
> > > > >
> > > > > On Fri, Aug 18, 2023 at 02:16:25AM +0800, Michael Shavit wrote:
> > > > > > Pick an ASID that is within the supported range of all SMMUs th=
at the
> > > > > > domain is installed to.
> > > > > >
> > > > > > Signed-off-by: Michael Shavit <mshavit@google.com>
> > > > > > ---
> > > > >
> > > > > This seems like a pretty niche scenario, maybe we should just kee=
p a
> > > > > global for the max ASID?
> > > > >
> > > > > Otherwise we need a code to change the ASID, even for non-SVA dom=
ains,
> > > > > when the domain is installed in different devices if the current =
ASID
> > > > > is over the instance max..
> > > >
> > > > This RFC took the other easy way out for this problem by rejecting
> > > > attaching a domain if its currently assigned ASID/VMID
> > > > is out of range when attaching to a new SMMU. But I'm not sure
> > > > which of the two options is the right trade-off.
> > > > Especially if we move VMID to a global allocator (which I plan to a=
dd
> > > > for v2), setting a global maximum for VMID of 256 sounds small.
> > >
> > > IMHO the simplest and best thing is to make both vmid and asid as
> > > local allocators. Then alot of these problems disappear
> >
> > Well that does sound like the most flexible, but IMO quite a lot more
> > complicated.
> >
> > I'll post a v2 RFC that removes the `iommu/arm-smmu-v3: Add list of
> > installed_smmus` patch and uses a flat master list in smmu_domain as
> > suggested by Robin, for comparison with the v1. But at a glance using a
> > local allocator would require:
>
> > 1. Keeping that patch so we can track the asid/vmid for a domain on a
> > per smmu instance
>
> You'd have to store the cache tag in the per-master struct on that
> list and take it out of the domain struct.
>
> Ie the list of attached masters contains the per-master cache tag
> instead of a global cache tag.
>
> The only place you need the cache tag is when iterating over the list
> of masters, so it is OK.
>
> If the list of masters is sorted by smmu then the first master of each
> smmu can be used to perform the cache tag invalidation, then the rest
> of the list is the ATC invalidation.
>
> The looping code will be a bit ugly.

I suppose that could work.... but I'm worried it's gonna be messy,
especially if we think about how the PASID feature would interact.
With PASID, there could be multiple domains attached to a master. So
we won't be able to store a single cache tag/asid for the currently
attached domain on the arm_smmu_master. Still doable however; as it
could move into the struct mapping a domain to each PASID/master pair,
with your loop still using the first entry in the list (until it meets
an entry belonging to a different SMMU) for the invalidation.

> > 2. Keeping a map in the smmu struct so that arm_smmu_share_asid can
> > find any arm_smmu_installed_smmu that need to have their asid
> > updated
>
> Yes, the global xarray moves into the smmu
>
> > (on a loop over every smmu the domain in arm_smmu_mmu_notifier_get is
> > attached to, which just at a glance looks headache inducing because of
> > sva's piggybacking on the rid domain.)
>
> Not every smmu, just the one you are *currently* attaching to. We
> don't care if the *other* smmu's have different ASIDs, maybe they are
> not using BTM, or won't use SVA.

I mean because the domain in arm_smmu_mmu_notifier_get is the RID
domain (not the SVA domain, same issue we discussed in previous
thread) , which can be attached to multiple SMMUs.
