Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9622B782C1A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 16:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234503AbjHUOjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 10:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232388AbjHUOjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 10:39:53 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DEC0E3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 07:39:51 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-4036bd4fff1so473971cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 07:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692628791; x=1693233591;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ArMZ01EM52zYzsgGJfkmTs+2DiL/6v3Hz+klqWiqUbM=;
        b=H9nMrL1eOKFEj+UeeGDnf3Y/frvD3I27cCZxUrfeXUyr4f4bFtP+Pcwf6L7Elgt2Sb
         6z7DI6mpMkknwtblDqOTTm7NcCupvWKUG+boYEJ/3Mg5vTdpS3JZNw1NxYNtliIYZL7a
         ocPnVIVuLI+gzPjX8teN/RANLjcYJ9LWPbkqwxuinl3nqpbyT5rDp0X+rPJnKIhGsQJ4
         614mGvYtUZNtvI38ykfqHzpQbxO7I2XVPvG21L+sQKI+bCzYOJYywLk+Abuim6b/8E+R
         KtCiv7qjRP7Wb7zZdh0wjVlBwUEb5G1OmadahUiav5UQFc0u9xy+00CnkUSMySehfZ7o
         9jTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692628791; x=1693233591;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ArMZ01EM52zYzsgGJfkmTs+2DiL/6v3Hz+klqWiqUbM=;
        b=dyO7BQmHwsQ4gn+Qm2/nF2GXpDtn/RBBZT3u9iqO9JqTOiSLNarq6thJKyOt9eGAcM
         SchIVXOqzkuQn8FjCbM0rtDyr8qQiZJRpbRAqEl3e5Ux81L60GgXGnsjJwMTXNy40Tlh
         DY0fq6AHlm7/4p+IUmgD/OfF9lAniGlCnoBYu2glkcUp5ckNBSlnTSoMCY9C9AikKCx9
         ed5y/RvfnbJX0+pdbzhHZe+0wLOg2PNHmvhVlGEA63Sv9aIdp9ULQOah7nJ6f+l9k4Tw
         1N3/y0iGzX7NUHtlESJ20IjZ8REx7KADFOwuypUNOnZG6wP+aufMjs3WKyRRHPLUsF0u
         QqQg==
X-Gm-Message-State: AOJu0YwXJ4tlD6mrHafDZ4mrWDdj3rFQyvEoy8jNvy5z28kyxuCnmkZg
        KaS+aqPSakodpK1tRa+koh+8RD80Q0HWaQSm6OgDuQ==
X-Google-Smtp-Source: AGHT+IFsq3S91/JP9f4k0pNBd9EFygJqj/eC6WY1wM3xxG/fLTWNmZNC/DxpUNvBhJNSM1i0pRivt+i5WU0WMuKGIY4=
X-Received: by 2002:ac8:5fc9:0:b0:410:839d:941d with SMTP id
 k9-20020ac85fc9000000b00410839d941dmr474264qta.20.1692628790499; Mon, 21 Aug
 2023 07:39:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230817182055.1770180-1-mshavit@google.com> <20230818021629.RFC.v1.3.I326c62dc062aed8d901d319aa665dbe983c7904c@changeid>
 <ZN5pK03Drao/egeF@nvidia.com> <CAKHBV27k8F0ZLy=RA=WhjJ7+C9JMHRRnKs=4W4pJMNmxrMEXxw@mail.gmail.com>
 <ZONQgNh6qarqgA+f@nvidia.com> <CAKHBV26oTZLssq5bopePojqgrEJwukKHYEbhU02nAvHHVB13mw@mail.gmail.com>
 <ZONrkVX6kZjX/wus@nvidia.com> <CAKHBV27PL=2jxOd0BoYdoBMTu_0rm4z_JP6iG+SVi5Ag7w2kWw@mail.gmail.com>
 <ZON0E3KV46EEPw/p@nvidia.com>
In-Reply-To: <ZON0E3KV46EEPw/p@nvidia.com>
From:   Michael Shavit <mshavit@google.com>
Date:   Mon, 21 Aug 2023 22:39:14 +0800
Message-ID: <CAKHBV25P9kNGkM7f5Xc-HsozK362XzMz+NnLa8FcWiu3FFr13g@mail.gmail.com>
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

On Mon, Aug 21, 2023 at 10:26=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> w=
rote:
>
> On Mon, Aug 21, 2023 at 10:16:54PM +0800, Michael Shavit wrote:
> > On Mon, Aug 21, 2023 at 9:50=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com=
> wrote:
> > >
> > > On Mon, Aug 21, 2023 at 09:38:40PM +0800, Michael Shavit wrote:
> > > > On Mon, Aug 21, 2023 at 7:54=E2=80=AFPM Jason Gunthorpe <jgg@nvidia=
.com> wrote:
> > > > >
> > > > > On Mon, Aug 21, 2023 at 05:31:23PM +0800, Michael Shavit wrote:
> > > > > > On Fri, Aug 18, 2023 at 2:38=E2=80=AFAM Jason Gunthorpe <jgg@nv=
idia.com> wrote:
> > > > > > >
> > > > > > > On Fri, Aug 18, 2023 at 02:16:25AM +0800, Michael Shavit wrot=
e:
> > > > > > > > Pick an ASID that is within the supported range of all SMMU=
s that the
> > > > > > > > domain is installed to.
> > > > > > > >
> > > > > > > > Signed-off-by: Michael Shavit <mshavit@google.com>
> > > > > > > > ---
> > > > > > >
> > > > > > > This seems like a pretty niche scenario, maybe we should just=
 keep a
> > > > > > > global for the max ASID?
> > > > > > >
> > > > > > > Otherwise we need a code to change the ASID, even for non-SVA=
 domains,
> > > > > > > when the domain is installed in different devices if the curr=
ent ASID
> > > > > > > is over the instance max..
> > > > > >
> > > > > > This RFC took the other easy way out for this problem by reject=
ing
> > > > > > attaching a domain if its currently assigned ASID/VMID
> > > > > > is out of range when attaching to a new SMMU. But I'm not sure
> > > > > > which of the two options is the right trade-off.
> > > > > > Especially if we move VMID to a global allocator (which I plan =
to add
> > > > > > for v2), setting a global maximum for VMID of 256 sounds small.
> > > > >
> > > > > IMHO the simplest and best thing is to make both vmid and asid as
> > > > > local allocators. Then alot of these problems disappear
> > > >
> > > > Well that does sound like the most flexible, but IMO quite a lot mo=
re
> > > > complicated.
> > > >
> > > > I'll post a v2 RFC that removes the `iommu/arm-smmu-v3: Add list of
> > > > installed_smmus` patch and uses a flat master list in smmu_domain a=
s
> > > > suggested by Robin, for comparison with the v1. But at a glance usi=
ng a
> > > > local allocator would require:
> > >
> > > > 1. Keeping that patch so we can track the asid/vmid for a domain on=
 a
> > > > per smmu instance
> > >
> > > You'd have to store the cache tag in the per-master struct on that
> > > list and take it out of the domain struct.
> > >
> > > Ie the list of attached masters contains the per-master cache tag
> > > instead of a global cache tag.
> > >
> > > The only place you need the cache tag is when iterating over the list
> > > of masters, so it is OK.
> > >
> > > If the list of masters is sorted by smmu then the first master of eac=
h
> > > smmu can be used to perform the cache tag invalidation, then the rest
> > > of the list is the ATC invalidation.
> > >
> > > The looping code will be a bit ugly.
> >
> > I suppose that could work.... but I'm worried it's gonna be messy,
> > especially if we think about how the PASID feature would interact.
> > With PASID, there could be multiple domains attached to a master. So
> > we won't be able to store a single cache tag/asid for the currently
> > attached domain on the arm_smmu_master.
>
> I wasn't suggesting to store it in the arm_smmu_master, I was
> suggesting to store it in the same place you store the per-master
> PASID.
>
> eg I expect that on attach the domain will allocate new memory to
> store the pasid/cache tag/master/domain and thread that memory on a
> list of attached masters.

Gotcha.

> > > > (on a loop over every smmu the domain in arm_smmu_mmu_notifier_get =
is
> > > > attached to, which just at a glance looks headache inducing because=
 of
> > > > sva's piggybacking on the rid domain.)
> > >
> > > Not every smmu, just the one you are *currently* attaching to. We
> > > don't care if the *other* smmu's have different ASIDs, maybe they are
> > > not using BTM, or won't use SVA.
> >
> > I mean because the domain in arm_smmu_mmu_notifier_get is the RID
> > domain (not the SVA domain, same issue we discussed in previous
> > thread) , which can be attached to multiple SMMUs.
>
> Oh that is totally nonsensical. I expect you will need to fix that
> sooner than later. Once the CD table is moved and there is a proper
> way to track the PASID it should not be needed. It shouldn't fall into
> the decision making about where to put the ASID xarray.

Right I got a bit of a chicken and egg problem with all these series.

Can we keep the simpler solutions where ASID/VMID across SMMUs has
non-optimal constraints and re-consider this after all the other
changes land (this series, set_dev_pasid series, fixing sva)?
