Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69423777464
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 11:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233715AbjHJJYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 05:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232651AbjHJJYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 05:24:15 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B01162129
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 02:24:14 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-40c72caec5cso169321cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 02:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691659454; x=1692264254;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UvmlkjRaUwStD8KrOqZaQANSxCF6BiZRXjgKYWBLx+w=;
        b=XwtH4iwzGr5CwV7pQZ0W+QC1Vv5v3twEOn1MCsa1chsFp8ykj3mF6ncJL/GyxrxWJV
         4Ys2HBa79AkVfTv4Lttwzvr7CQabdyWQo0WyUJ3Wkatmr/A40BRrblkcp6mJoi4JGss6
         U/S1tksRh2luHIVkYDBg8vS+yOEsAQxjl3bk8toHfG5jn7VVotvWcCWUvlX+ulmJ4eUX
         suOMY8v2rnIasVijgnQgtHceJu0p32/W1Dzh4X4+rmAfZk4iAsJGM7dOIOuVA+9pwCpO
         nyXWpnFg7cW9KrUO/ijReoAaXuaXKBHGro+PDqgpJ90z5d1eggZsy+YCFPAPAxKTOGti
         cKAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691659454; x=1692264254;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UvmlkjRaUwStD8KrOqZaQANSxCF6BiZRXjgKYWBLx+w=;
        b=SnRY4qhNZXN/sgqSC7JhdIWuSk/RvVX2EJiBndj4mAEbE627OfOuuPb/icHNYvhuqu
         Ey5mOoBc89bqaQYiMXKHrlRvCyXNpHA2IcKGQHMBgAi7jQzw0CTVb9QvBkJJfWt+CzUr
         1DsDsjnLMRa1mWOSrlWEcPUuqEpJDpK/gg+BhbK38VA7tPOMkmFhRyC4k7l4rzq4qPBd
         KZ2xZ5SvitKuWkF4o9/Si98bi+sinUoeWOA5MqMs2NbPYChsM3hjRQrydnd8IR1WRXbL
         R2+10Ej42O1PJf1VdJCm/8ZsEnHmyv/yUQg2FcYLrxM/0Js6iOTwnSiebccuoj9+/hGB
         8V4g==
X-Gm-Message-State: AOJu0Yyi7HZ+rvD059KzX/fBJOpm/EUvQRNVlZNesN+QJLNpH0jYPFhR
        8Bs4qRE+vRpIe9jlnKEWRgybmJnzF0IS41S00RWI1Q==
X-Google-Smtp-Source: AGHT+IEvxkkOOdQAeawTNBRXfZVPIuyN1RySq0hwMmVFjhEczedgs9oTSeoBmtpEvPQwpib+CFb1hglaX812zPHc57w=
X-Received: by 2002:a05:622a:cb:b0:3f8:5b2:aef2 with SMTP id
 p11-20020a05622a00cb00b003f805b2aef2mr440070qtw.26.1691659453665; Thu, 10 Aug
 2023 02:24:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230808171446.2187795-1-mshavit@google.com> <20230809011204.v5.6.Ice063dcf87d1b777a72e008d9e3406d2bcf6d876@changeid>
 <20230809135024.GD4226@willie-the-truck>
In-Reply-To: <20230809135024.GD4226@willie-the-truck>
From:   Michael Shavit <mshavit@google.com>
Date:   Thu, 10 Aug 2023 17:23:37 +0800
Message-ID: <CAKHBV24ybm1gT+mQs1fDPZY_kGzop8+dQjccP+_qOFCmx69spQ@mail.gmail.com>
Subject: Re: [PATCH v5 6/9] iommu/arm-smmu-v3: Move CD table to arm_smmu_master
To:     Will Deacon <will@kernel.org>
Cc:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, robin.murphy@arm.com,
        nicolinc@nvidia.com, jgg@nvidia.com, jean-philippe@linaro.org
Content-Type: text/plain; charset="UTF-8"
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

>
> > @@ -2465,6 +2450,22 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
> >       if (smmu_domain->stage != ARM_SMMU_DOMAIN_BYPASS)
> >               master->ats_enabled = arm_smmu_ats_supported(master);
> >
> > +     if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
> > +             if (!master->cd_table.cdtab) {
> > +                     ret = arm_smmu_alloc_cd_tables(master);
> > +                     if (ret) {
> > +                             master->domain = NULL;
> > +                             return ret;
> > +                     }
> > +             }
> > +
> > +             ret = arm_smmu_write_ctx_desc(master, 0, &smmu_domain->cd);
> > +             if (ret) {
> > +                     master->domain = NULL;
> > +                     return ret;
>
> Can you leak the cd tables here if you just allocated them?

The CD table is only de-allocated when the SMMU device is released, so
this isn't "leaked" anymore than on a successful attachment. In a
previous version of this patch, this CD table was even pre-allocated
at probe time but is deferred to first attach following this
discussion: https://lore.kernel.org/lkml/ZMOzs1%2FxoEPX2+vA@nvidia.com/
.

> > @@ -2472,10 +2473,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
> >       spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
> >
> >       arm_smmu_enable_ats(master);
> > -
> > -out_unlock:
> > -     mutex_unlock(&smmu_domain->init_mutex);
> > -     return ret;
> > +     return 0;
> >  }
> >
> >  static int arm_smmu_map_pages(struct iommu_domain *domain, unsigned long iova,
> > @@ -2719,6 +2717,8 @@ static void arm_smmu_release_device(struct device *dev)
> >       arm_smmu_detach_dev(master);
> >       arm_smmu_disable_pasid(master);
> >       arm_smmu_remove_master(master);
> > +     if (master->cd_table.cdtab_dma)
>
> Why are you checking 'cdtab_dma' here instead of just 'cdtab'?

cd_table is statically allocated as part of the arm_smmu_master
struct. I suppose it could be allocated by arm_smmu_alloc_cd_tables()
instead?
