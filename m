Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0161C785173
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 09:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233104AbjHWH0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 03:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233239AbjHWH0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 03:26:39 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61EDFB
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 00:26:37 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-407db3e9669so169531cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 00:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692775597; x=1693380397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IKY7CwPvf4+r1qLRL9M25q8Xqba9hENCU7mXfg2rhjk=;
        b=oG7ku6fNiRTPSk5zpqst1UtlXF/tbr6lOVM47HAENj4iP9AVida2PEaMzVt4/7FJr2
         LLCU689z7LRhtzKFZSgpLasQWAgTZWIcZeVnIJ5Nq7fk9jQGcOuMvNloyEMpGa79pSd7
         u8e5wz8CLsupHHz4U5GSQB3RLli81DkZvWmwMHBhCTjt9wI0a7vJ+3mV/wMkOc/7P+3i
         ca4+eN2zRbjyQJYlAxpO+OwGOLsCqMFdpbzI0T9Vd+e/kykTB1/PyZz9UxFQnkfnA7iM
         omZQOb+yUgs9cecQZh8hxYZRq/Q3hHD2/p+6bMGO4zEgAn8jsqfB8RV9eQTrvefpYtIc
         A30g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692775597; x=1693380397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IKY7CwPvf4+r1qLRL9M25q8Xqba9hENCU7mXfg2rhjk=;
        b=M9KFnuHp1h6zSLs9zHy7Nbsy9e8CqnVktKnb5oD7ZVSFfJNX+r6eZa8LDOiaFwkg1e
         jbHCad/xf/9WTDYzGbqQhwinTtUr3Z+95ztW5d2rgAuBPyErCInFI03v06KQG8mm5VBr
         J3hEXhDgHAxO1pInEjBUloudO/BRDTXhi88gR4vGPb5r6R4Vu1TAW7F2NYBRYzJey14l
         k7u136COO4MAeIIsEo7MeHuU4+qWtIG1kHLSr5iNpvrO+9BvwRlzD8J5OW1LIidI2Ty+
         THBOZwBfP9yRi1+dbOUfM1P1Np/gd8hD936he9/yOwfvqVqVhoPRZNMwhzSbuN0qx3EH
         QRqQ==
X-Gm-Message-State: AOJu0Yzy9O79qe3chw9cj1iJhFZUUHyrpgmfV4ou7OjLHauRxlxmvZ6w
        vzXau5Bc8f3q4lPDJXq+exTffSzBpW5jv4q+bup74mU7KhpxN+qTT/D1IQ==
X-Google-Smtp-Source: AGHT+IGaR52Qen29UQuUR2cKn5Mefa8W6aQNGUUfBB5g3k3BE2dzPP8J0dm1AB1r5FvZ3UEf40orx2scFcp9F1Dm1Ck=
X-Received: by 2002:a05:622a:144a:b0:3f2:2c89:f1ef with SMTP id
 v10-20020a05622a144a00b003f22c89f1efmr369689qtx.5.1692775596551; Wed, 23 Aug
 2023 00:26:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230822105738.1607365-1-mshavit@google.com> <20230822185632.RFC.v2.4.I326c62dc062aed8d901d319aa665dbe983c7904c@changeid>
 <ZOS18J4ytKjHFT+N@nvidia.com>
In-Reply-To: <ZOS18J4ytKjHFT+N@nvidia.com>
From:   Michael Shavit <mshavit@google.com>
Date:   Wed, 23 Aug 2023 15:26:00 +0800
Message-ID: <CAKHBV27tdN6Wqovy41iOQ3dzSPWD4XSHgJgyBPoW_ttDCD3eyw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 4/9] iommu/arm-smmu-v3-sva: Allocate new ASID from installed_smmus
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, nicolinc@nvidia.com,
        tina.zhang@intel.com, jean-philippe@linaro.org, will@kernel.org,
        robin.murphy@arm.com, Dawei Li <set_pte_at@outlook.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
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

On Tue, Aug 22, 2023 at 9:19=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Tue, Aug 22, 2023 at 06:57:00PM +0800, Michael Shavit wrote:
> > Pick an ASID that is within the supported range of all SMMUs that the
> > domain is installed to.
> >
> > Signed-off-by: Michael Shavit <mshavit@google.com>
> > ---
> >
> > (no changes since v1)
> >
> >  .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   | 23 +++++++++++++++----
> >  1 file changed, 19 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/=
iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> > index fe88a7880ad57..92d2f8c4e90a8 100644
> > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> > @@ -66,6 +66,20 @@ static int arm_smmu_write_ctx_desc_devices(struct ar=
m_smmu_domain *smmu_domain,
> >       return ret;
> >  }
> >
> > +static u32 arm_smmu_domain_max_asid_bits(struct arm_smmu_domain *smmu_=
domain)
> > +{
> > +     struct arm_smmu_master *master;
> > +     unsigned long flags;
> > +     u32 asid_bits =3D 16;
> > +
> > +     spin_lock_irqsave(&smmu_domain->devices_lock, flags);
> > +     list_for_each_entry(master, &smmu_domain->devices,
> > +                         domain_head)
> > +             asid_bits =3D min(asid_bits, master->smmu->asid_bits);
> > +     spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
> > +     return asid_bits;
> > +}
>
> I still don't like this, it is not locked properly. You release the
> devices_lock which means the max_asid could change before we get to
> arm_smmu_write_ctx_desc()

Good point.

> If you want to take this shortcut temporarily then a global max_asid
> is probably a better plan. Change it to a per-master allocation later
> to remove that.

Two options there:
1. When allocating a new ASID in arm_smmu_share_asid, limit ourselves
to 8-bit-wide ASIDs regardless of whether all the installed SMMUs
support 16bit ASIDs.
2. In addition, also use a maximum 8-bit-wide ASID when allocating
asids in arm_smmu_domain_finalise_s1.

The first one has minimal impact since arm_smmu_share_asid is
supposedly rare, and is a simple replacement for this patch.

The second one is more intrusive since we'd be limiting the number of
dma/unmanaged domains to a fairly small number, but it has the
advantage of allowing those domains to always successfully attach to
masters belonging to SMMUs with different asid_bits values (without
having to re-allocate a new ASID for the domain arm_smmu_share_asid
style). Where-as this series simply fails to attach the domain in such
scenarios.
