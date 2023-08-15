Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E92AB77CBE1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 13:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236803AbjHOLlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 07:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236790AbjHOLkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 07:40:53 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA7210E0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 04:40:52 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-4036bd4fff1so203091cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 04:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692099651; x=1692704451;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bAJu/xV6A/2e1ZophwkUz7aqsqcAzGHXHsGTllbFSDU=;
        b=Yt3Z0KHaQfa/VFgCqpo6vQ60OvD5saTRP7dyiey6tapaKNkvQLdR/VDzkDGP59Mu/Y
         4gDzROVampwq61v03vv4W7YhLAV1zqxTjWqJUYTFrz/Wc8VwvqQM2SHxS4t//kljJ5Zh
         cSQxt1UXorwTk2lse4oKmtuxb06geCyC/g/tdWJb4xeIl/kqPIKaaR31Or/v184szh13
         XXf9Pvd27xDiPk56Jl1bnBg5ClOqqqv7qgxhiCjyKGAIIPBZiZ7kFXVEUg681wDT80uB
         /mvk/pbqUlQf/SMP187BtaVPwmPtjxiXgrTPCNGlnAQzdq7LAcb/uTglY7ruSDHnh/7N
         2zKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692099651; x=1692704451;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bAJu/xV6A/2e1ZophwkUz7aqsqcAzGHXHsGTllbFSDU=;
        b=kL+pglfe5n9Pa3QCJreARxiBn1YeVfkVhLX0+pZ9EqI5ni5wU81QFqax8asrDIj2qf
         snmhu2f7undWlG9A20kxBhw1RR68G1zVcs/1ZFVzQRKFv8KYUYzCNHdqCCKHsIXUjNlt
         aFC/Ai+LeiF5aF8jtIBiSaCBiIP3SnquIGOBKazQMnittr8QeS6CZMHBKBnJVu5XpSdC
         rh8qqQHPJ9Ect+7xQ0neKlYsiUj7y+tQ4dVS1DVwUm84vEqFs1lwCXVSqK2QxGoAXKD2
         2ASwIOCOSYrFglx6cJf4Ua0Q4lDDFgpBFLOlMlaI6/dvipM81eOYrXgP6TQ5Z3ramyzy
         1lhg==
X-Gm-Message-State: AOJu0YyuRE6Bhm5vzAuoRlBsq6F7wOdLVNiUrIiB+MRM+Z8fdiGVy9Ng
        cVTQkbwPvAyOYA/WL1bNeNiXiVrz0EBS0ij76yKMVJhp1JQbKXb9s0SF2w==
X-Google-Smtp-Source: AGHT+IGukCAhnkO/MP1s3J3prH4E8Xxsrw3oUBPU0yFdTWkCjSA7h2v7C99fsT47XO1RphI+iVrq64CDVJqWgUlyaw4=
X-Received: by 2002:a05:622a:1444:b0:403:a43d:be41 with SMTP id
 v4-20020a05622a144400b00403a43dbe41mr871291qtx.20.1692099651163; Tue, 15 Aug
 2023 04:40:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230808171446.2187795-1-mshavit@google.com> <20230809011204.v5.5.I219054a6cf538df5bb22f4ada2d9933155d6058c@changeid>
 <20230809134959.GB4226@willie-the-truck> <CAKHBV25CQYfqm80a1ztHXn3s6kj7KCuJBwJz4EZk5cog4n6R+A@mail.gmail.com>
 <CAKHBV27iMDaU3RgJSVFva0UBmyKD8oJEtzDU7PJ4LuPGWAjCCA@mail.gmail.com> <20230815101911.GA11399@willie-the-truck>
In-Reply-To: <20230815101911.GA11399@willie-the-truck>
From:   Michael Shavit <mshavit@google.com>
Date:   Tue, 15 Aug 2023 19:40:14 +0800
Message-ID: <CAKHBV25PuLERz9AwqtDF-WSPd3fWCEKMw3zyYFV=Lu-0c8Y5zA@mail.gmail.com>
Subject: Re: [PATCH v5 5/9] iommu/arm-smmu-v3: Refactor write_ctx_desc
To:     Will Deacon <will@kernel.org>
Cc:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, robin.murphy@arm.com,
        nicolinc@nvidia.com, jgg@nvidia.com, jean-philippe@linaro.org
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

On Tue, Aug 15, 2023 at 6:19=E2=80=AFPM Will Deacon <will@kernel.org> wrote=
:
>
> On Tue, Aug 15, 2023 at 01:04:43PM +0800, Michael Shavit wrote:
> > On Thu, Aug 10, 2023 at 5:15=E2=80=AFPM Michael Shavit <mshavit@google.=
com> wrote:
> > > On Wed, Aug 9, 2023 at 9:50=E2=80=AFPM Will Deacon <will@kernel.org> =
wrote:
> > > >
> > > > Since you're dropping this and relying on the lock being taken high=
er up
> > > > callstack, can we add a lockdep assertion that we do actually hold =
the
> > > > devices_lock, please?
> > >
> > > Will do!
> >
> > I spoke too soon; the point of this change was to remove the
> > dependency on the arm_smmu_domain, piping the devices_lock would
> > defeat this. In fact, this section is really depending on the iommu
> > group lock not the devices_lock.
>
> Sorry, but I'm not following you here. What is the devices_lock protectin=
g
> if we're depending on the group lock?
>
> Will

Ugh, yes sorry, we do need the devices_lock held *in the SVA* call
flow. The group lock is ineffective there because SVA performs
cross-master operations on iommu_domain callbacks. There, the
devices_lock is needed to ensure that the list of masters that a
domain is attached to doesn't mutate while we operate on that domain.

Nonetheless, it feels awkward to require the devices_lock to be held
outside SVA, since there we operate on a single master/CD table
rather. We don't care what other masters that domain is attached to.
