Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D470782AB1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 15:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235479AbjHUNjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 09:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235474AbjHUNjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 09:39:19 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD7D5E2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 06:39:17 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-40a47e8e38dso385651cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 06:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692625156; x=1693229956;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QPjzY4omsOysbo+WaFOemYqJ4xkslRZB8mPYNwUSQ6A=;
        b=w0I4haQ45UNsLNRiNXn71OMBdA6RsRmbCrX3Eo4uMIBz6usK8BIz3jjoqHsU58oYRc
         lur/ned6K0IBLZsvTzELh7g4+Swiy+UWxYrbvfmCicIzkcp1FXq4A19Ss7V0Hih3EzSW
         rkrBSnLJMaGCWH6gMU1KeOgXghoXfJNBu4aGsBbLGgeBoKPKu6xZsITNNluHOWjNQeim
         uLAhIKSNrVkpDM950F8nk2R93L6UjkuVdVPFtyIblupJpRfo8IUAptwe5WjMW20meJe2
         0zKHrHhku5m74GQ1Nwl/WdafDuwRGkW/8BmsulXpT32nZlWJswWz40fus+buJR8Q02cP
         aQ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692625156; x=1693229956;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QPjzY4omsOysbo+WaFOemYqJ4xkslRZB8mPYNwUSQ6A=;
        b=Jy06dBpuANjFCKhqCv0Y9AURpGP0spn/9vFlDHNMBCZocTyMSHb1mmFnOGg4nhHLJ8
         BRj9geH3M1/G2qawCQuFbkw1arWhdQHDsUwIijAFZS0RZzDRAaT1jvvYlZj7+09IJ/zc
         +TgnC94XqG1wVrRoALBsY+4VuqBrTgAtlZtI3P9TsqeQaEBrFBXcRjVFUkBPmKXsY4fa
         EKvPTkxbmcyDpOEDL82OtasDqeIv8ZTd0R/r7lruGIJUzSkMdFXgGLqKdqKDTHQlgF3b
         QGObF9zzaEeHEwSAGs1PV7TOcz2fbWtZ54BjwJjwziNwE8JMjqrmY/RFMfr7OvC1CEgh
         Anow==
X-Gm-Message-State: AOJu0YxBjiQK6idTNH1zdt1r+mBV2Cn1YHtZvZcMJaIzu1+1puVGfe9W
        GNaOZHIstfKw1eE4nK7nifJaWjOettL+ECpMszWKBA==
X-Google-Smtp-Source: AGHT+IETYip2DW6kZitAYkXOvPOKFFGmGfQS6VsuXvAMuzQdOcSsCUd4w3zy3HaeYzjV4q49oU7NBYYBlP61f1REQBY=
X-Received: by 2002:ac8:5984:0:b0:410:88a5:92f with SMTP id
 e4-20020ac85984000000b0041088a5092fmr395349qte.0.1692625156476; Mon, 21 Aug
 2023 06:39:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230817182055.1770180-1-mshavit@google.com> <20230818021629.RFC.v1.3.I326c62dc062aed8d901d319aa665dbe983c7904c@changeid>
 <ZN5pK03Drao/egeF@nvidia.com> <CAKHBV27k8F0ZLy=RA=WhjJ7+C9JMHRRnKs=4W4pJMNmxrMEXxw@mail.gmail.com>
 <ZONQgNh6qarqgA+f@nvidia.com>
In-Reply-To: <ZONQgNh6qarqgA+f@nvidia.com>
From:   Michael Shavit <mshavit@google.com>
Date:   Mon, 21 Aug 2023 21:38:40 +0800
Message-ID: <CAKHBV26oTZLssq5bopePojqgrEJwukKHYEbhU02nAvHHVB13mw@mail.gmail.com>
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

On Mon, Aug 21, 2023 at 7:54=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Mon, Aug 21, 2023 at 05:31:23PM +0800, Michael Shavit wrote:
> > On Fri, Aug 18, 2023 at 2:38=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com=
> wrote:
> > >
> > > On Fri, Aug 18, 2023 at 02:16:25AM +0800, Michael Shavit wrote:
> > > > Pick an ASID that is within the supported range of all SMMUs that t=
he
> > > > domain is installed to.
> > > >
> > > > Signed-off-by: Michael Shavit <mshavit@google.com>
> > > > ---
> > >
> > > This seems like a pretty niche scenario, maybe we should just keep a
> > > global for the max ASID?
> > >
> > > Otherwise we need a code to change the ASID, even for non-SVA domains=
,
> > > when the domain is installed in different devices if the current ASID
> > > is over the instance max..
> >
> > This RFC took the other easy way out for this problem by rejecting
> > attaching a domain if its currently assigned ASID/VMID
> > is out of range when attaching to a new SMMU. But I'm not sure
> > which of the two options is the right trade-off.
> > Especially if we move VMID to a global allocator (which I plan to add
> > for v2), setting a global maximum for VMID of 256 sounds small.
>
> IMHO the simplest and best thing is to make both vmid and asid as
> local allocators. Then alot of these problems disappear

Well that does sound like the most flexible, but IMO quite a lot more
complicated.

I'll post a v2 RFC that removes the `iommu/arm-smmu-v3: Add list of
installed_smmus` patch and uses a flat master list in smmu_domain as
suggested by Robin, for comparison with the v1. But at a glance using a
local allocator would require:
1. Keeping that patch so we can track the asid/vmid for a domain on a
per smmu instance
2. Keeping a map in the smmu struct so that arm_smmu_share_asid can
find any arm_smmu_installed_smmu that need to have their asid updated
(on a loop over every smmu the domain in arm_smmu_mmu_notifier_get is
attached to, which just at a glance looks headache inducing because of
sva's piggybacking on the rid domain.)
