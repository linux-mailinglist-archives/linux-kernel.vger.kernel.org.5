Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E17B792BE3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346387AbjIERDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 13:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354649AbjIENOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 09:14:50 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086F01A7
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 06:14:47 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-414c54b2551so444101cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 06:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693919686; x=1694524486; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OFbNMkBJuPkeEaGJvYM58C6Cd/4ziikLBz9Bfejhs5c=;
        b=1VvLrnXRJr7Y/s6wAfAKL8I422tLDVssehUuegDI4/f+Zu0KosM7sV34CWI4LWT8qL
         VaajX7WF5EsMGkjHu3OvUgGTs3robJzBP2wqiwr6Ckg63OB5ia882t9GN9IKVRdGFiVq
         qhcmbrgBZ/mnT32r/DSCkjyikfL/3LTeCGkn042UJNnDDWwNy51xToPHEe4IZ0hQUpNS
         /cSVE6ZNadKOR78dSHetWwPQXe9W4vkICF/m76toyIv3Pnho5C2OAaHySDrrEupj6A6u
         P4r18o5akIAoN8fzzo8mxtzNXlKaHZ7629sBAHU+EsAD7E6IFHOGxs2IZmlj1OjI/DAl
         LaKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693919686; x=1694524486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OFbNMkBJuPkeEaGJvYM58C6Cd/4ziikLBz9Bfejhs5c=;
        b=iofYcu2dPakY2TlVTe7jR7MWi80O1WdN24CItcGCP2tk+YwsAAiXZSYAoW+WXrdDoZ
         TFhoeCVH9DLjEPVgqK+845OxaxGfvBl9uiy96nzaFi7+g+Db+GKccZILOizEefEQXPJv
         eyAURiK4ZiAVGfLaXbbV9omFl21gp7kAzgK955aJCfAFa05YIX3AVBHsgHYj24/2O7ph
         KET5ZXOP7pFVhDSrEblQgRJBq7706rT2iHQHvI+NEdx+bASbXQzHJvpV2HZJAsQsr8wP
         27RYnNIdHrnnfqyvyZqh5A8SAJfH3avY9ISLL5fXmXogHNJR8OsKMsRvxkeGwIXKzuq+
         e7OQ==
X-Gm-Message-State: AOJu0YwyQ/tTKB4hj4UquAhdqQCZdHw7+c42yrRL/FrmZsiqI/JDVtIa
        KQl7+Q9vknliwq+RRfwAP225aLCxwxd/lxnWFdpXcg==
X-Google-Smtp-Source: AGHT+IHAirqfK7qQebYh0aD5L/jpR4HP//Y1iUXxMQOm4eRtAc0UjWRDb1AGmrCxW11OAOyh1V7LgqX5zNgaMqAMc9I=
X-Received: by 2002:ac8:5716:0:b0:403:e1d1:8b63 with SMTP id
 22-20020ac85716000000b00403e1d18b63mr586298qtw.24.1693919685952; Tue, 05 Sep
 2023 06:14:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230905115013.1572240-1-mshavit@google.com> <20230905194849.v1.3.I211f2ab0ee241f53cdfbc3a8a573f14b8a46fb26@changeid>
 <ZPciLKG2Gi/Biovp@nvidia.com>
In-Reply-To: <ZPciLKG2Gi/Biovp@nvidia.com>
From:   Michael Shavit <mshavit@google.com>
Date:   Tue, 5 Sep 2023 21:14:09 +0800
Message-ID: <CAKHBV27=sTW3jXqqCJCPfMFRq=h8_S4JSrSAx61pfWqKrCak0w@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] iommu/arm-smmu-v3-sva: Remove arm_smmu_bond
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, will@kernel.org,
        robin.murphy@arm.com, nicolinc@nvidia.com,
        jean-philippe@linaro.org, tina.zhang@intel.com,
        Joerg Roedel <joro@8bytes.org>,
        Kevin Tian <kevin.tian@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Tomas Krcka <krckatom@amazon.de>,
        Yicong Yang <yangyicong@hisilicon.com>
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

On Tue, Sep 5, 2023 at 8:42=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wro=
te:
>
> On Tue, Sep 05, 2023 at 07:49:14PM +0800, Michael Shavit wrote:
> > Create a new iommu_domain subclass for SVA iommu domains to hold the
> > data previously stored in the dynamically allocated arm_smmu_bond. Add =
a
> > simple count of attached SVA domains to arm_smmu_master to replace the
> > list of bonds.
> >
> > Signed-off-by: Michael Shavit <mshavit@google.com>
> > ---
> >
> >  .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   | 70 +++++++------------
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  1 -
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  2 +-
> >  3 files changed, 26 insertions(+), 47 deletions(-)
> >
> > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/=
iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> > index 9fb6907c5e7d4..0342c0f35d55a 100644
> > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> > @@ -24,14 +24,13 @@ struct arm_smmu_mmu_notifier {
> >
> >  #define mn_to_smmu(mn) container_of(mn, struct arm_smmu_mmu_notifier, =
mn)
> >
> > -struct arm_smmu_bond {
> > -     struct mm_struct                *mm;
> > +struct arm_smmu_sva_domain {
> > +     struct iommu_domain             iommu_domain;
> >       struct arm_smmu_mmu_notifier    *smmu_mn;
> > -     struct list_head                list;
> >  };
> >
> > -#define sva_to_bond(handle) \
> > -     container_of(handle, struct arm_smmu_bond, sva)
> > +#define to_sva_domain(domain) \
> > +     container_of(domain, struct arm_smmu_sva_domain, iommu_domain)
>
> I'm not sure about this? This seems like a strange direction
>
> The SVA domain and a UNMANAGED/PAGING domain should be basically the
> same thing. Making a sva_domain a completely different type looks like
> it would stand in the way of that?

Agreed that's the eventual destination of all these re-works, but the
stage isn't fully set for that yet. IMO this is a simpler improvement
to get through for now, and I don't see it being an obstacle in the
future.

> > @@ -545,12 +526,11 @@ static const struct iommu_domain_ops arm_smmu_sva=
_domain_ops =3D {
> >
> >  struct iommu_domain *arm_smmu_sva_domain_alloc(void)
> >  {
> > -     struct iommu_domain *domain;
> > +     struct arm_smmu_sva_domain *sva_domain;
> >
> > -     domain =3D kzalloc(sizeof(*domain), GFP_KERNEL);
> > -     if (!domain)
> > +     sva_domain =3D kzalloc(sizeof(*sva_domain), GFP_KERNEL);
> > +     if (!sva_domain)
> >               return NULL;
> > -     domain->ops =3D &arm_smmu_sva_domain_ops;
> > -
> > -     return domain;
> > +     sva_domain->iommu_domain.ops =3D &arm_smmu_sva_domain_ops;
>
> arm_smmu_sva_domain_free() should container_of before freeing, but
> gross to assume the iommu_domain is the first member.

Oh good catch I missed updating the free.
