Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A00C47FE219
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 22:36:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234196AbjK2Vgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 16:36:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjK2Vgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 16:36:43 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1707D7F
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 13:36:49 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-4219f89ee21so1442621cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 13:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1701293809; x=1701898609; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RKdw1vp5oLSx4gO3m1/rl4eR0j44oWuSmpeWEj8OyEg=;
        b=OExQ1cLLwtG7+490nris8noYiYxSqXI4ie1YhzAm/VeuczmafNkSzFv5qw9D0HcErf
         ffPPn9sEPfg40Js8rnPoqm6IcpzTOTgPB/jswA+tpg/pJ5KrztQfCo7fsvLJA1skHJ4T
         Yt8NEPNif1go0SwFQYpEqCyd0fEz7D6QZBqhq+gAHOnWwnB4owKJhGROi7yWrwSiBZGS
         j7TrWhwDpwdt3UTK+XtFGEJ5vM2sYeDU7Qz9OlwbkKdaZ28zC4A0R/JYxs5DgNxTa26i
         RemFAI0Y90he8C4fmshjw22bDbsjE+K5y8NllC55xEQhe2wyuDKLxWvJpO9FKnkikNo2
         5P2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701293809; x=1701898609;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RKdw1vp5oLSx4gO3m1/rl4eR0j44oWuSmpeWEj8OyEg=;
        b=ABFRFz1dBFvBAz3WuwL3AAguVSP62Bj8EdK/PN4Gcl+PiDLwQAcTfB2dpWJB+O1DYQ
         AcvJ6FWj23h0NurP07ex9HAnQDVKRfH5OOL2ScQXO4h2tDAZGx7gceIIuffqzv0uIUY1
         7hNLhj2bKlGp4oiEx2nQoiuz/5Wrbm2mAgQU1SvzJkiQZ2r2T0/bkiM3mfSTfHagEzJu
         zRbbZsWb/aFhdRMQbDbJzmLXdDE3bDHQfJtU0fTFV2w7Z/PInlDwSnN4bWaI3VUWURZb
         6xTa7OUXE1qsLdUXj5WegqH+NMMF95j5EuSl0Mtd14TVID1sbAO8+OJ8P90P8lCJHsYm
         GAew==
X-Gm-Message-State: AOJu0YzWaLvKprV1LNOsS2Ur7V6XQ4YU45X2SiOpN0DR4qkjaBVqOsKd
        a17SrfyzKuZBuv6gufK1ZdJ6oA+tYAJ7BLxUAIar0Q==
X-Google-Smtp-Source: AGHT+IH1s42XbpuMqfnRK8jqZvUrCxoQ7Or7Gzckcwkn35i1gPeN3cfJsGoJeMBusJpvpuIBcFrnBzJ4nZCRPQFGmZI=
X-Received: by 2002:ac8:5c0e:0:b0:423:6e2a:1c36 with SMTP id
 i14-20020ac85c0e000000b004236e2a1c36mr29092766qti.35.1701293808838; Wed, 29
 Nov 2023 13:36:48 -0800 (PST)
MIME-Version: 1.0
References: <20231128204938.1453583-1-pasha.tatashin@soleen.com>
 <20231128204938.1453583-17-pasha.tatashin@soleen.com> <20231128235357.GF1312390@ziepe.ca>
In-Reply-To: <20231128235357.GF1312390@ziepe.ca>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 29 Nov 2023 16:36:12 -0500
Message-ID: <CA+CK2bBK=4qbHJG_6B=HSMOXe1vmg7D9TZmsJFhsqVmQau503g@mail.gmail.com>
Subject: Re: [PATCH 16/16] vfio: account iommu allocations
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     akpm@linux-foundation.org, alex.williamson@redhat.com,
        alim.akhtar@samsung.com, alyssa@rosenzweig.io,
        asahi@lists.linux.dev, baolu.lu@linux.intel.com,
        bhelgaas@google.com, cgroups@vger.kernel.org, corbet@lwn.net,
        david@redhat.com, dwmw2@infradead.org, hannes@cmpxchg.org,
        heiko@sntech.de, iommu@lists.linux.dev, jasowang@redhat.com,
        jernej.skrabec@gmail.com, jonathanh@nvidia.com, joro@8bytes.org,
        kevin.tian@intel.com, krzysztof.kozlowski@linaro.org,
        kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-sunxi@lists.linux.dev,
        linux-tegra@vger.kernel.org, lizefan.x@bytedance.com,
        marcan@marcan.st, mhiramat@kernel.org, mst@redhat.com,
        m.szyprowski@samsung.com, netdev@vger.kernel.org,
        paulmck@kernel.org, rdunlap@infradead.org, robin.murphy@arm.com,
        samuel@sholland.org, suravee.suthikulpanit@amd.com,
        sven@svenpeter.dev, thierry.reding@gmail.com, tj@kernel.org,
        tomas.mudrunka@gmail.com, vdumpa@nvidia.com,
        virtualization@lists.linux.dev, wens@csie.org, will@kernel.org,
        yu-cheng.yu@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 6:53=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Tue, Nov 28, 2023 at 08:49:38PM +0000, Pasha Tatashin wrote:
> > iommu allocations should be accounted in order to allow admins to
> > monitor and limit the amount of iommu memory.
> >
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > ---
> >  drivers/vfio/vfio_iommu_type1.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
>
> You should send the seperately and directly to Alex.

Thanks, I will.

>
> Jason
