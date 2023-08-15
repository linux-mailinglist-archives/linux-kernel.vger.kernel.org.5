Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18F1477CC67
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 14:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237052AbjHOMLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 08:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237161AbjHOMLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 08:11:10 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B5919A0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 05:11:08 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-40a47e8e38dso201821cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 05:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692101467; x=1692706267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s8CNsFvRpwTwwqm07wAYxu9f1X6A+KEOcEVL6oP8Ffs=;
        b=jW+4S1UDSh2D4B5h++gFLUzk2kuwDyEZbyEAmIkB1x2JPtpZ9i09g1aGecTsGmDKhI
         HjuPNd761RauwQXs5VVIi9AAYejfThNHtpYEwPlVnQxqARMDYWSACzY/tdRB7k8LDWX2
         jOJLoOE+yg2N2YOz0VqQmT4Hd0EekCXL6kJtSzPHrOKliLMhBzGSfPkwyF/pDfbY0edd
         pG5X3gVsVMPK2W/NRoikES2s0krOJGBtzWDLhbuGK9Hp9Hs0s3Eq58sUP3wWWy9rZssa
         datCYiaG6olWZYpSgQc9OSV3EV6a6DXYdh7mg4iKtS7xGSyiVBu81DTm9/UQyXgvwQJY
         FTmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692101467; x=1692706267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s8CNsFvRpwTwwqm07wAYxu9f1X6A+KEOcEVL6oP8Ffs=;
        b=W+BTQ8s08Pu0U72NWlJH3lfUx66zVl0kQYmJzqbPZBfZa+Dj5Eo60nRNSmVcCIFxqG
         kzwfvoiasKdcSYsJjSqHq43ofGmqBGZacEleYobH7o9wwfJoNbzkxi5pJxWU2mKZswHu
         rV6gIhP8mhjKJI0EjzTX4IWdpKNc4G9/dgzwCsDipGf7GCI1EL7B5DFVcWbCVwVnyFZd
         bQNi2xDdBl4x1AVxh55JhvJMMFXZahCYwaYUB0b5WbrDGITgV69j+EIpH3Y4Ago5L8jV
         TdMmo6O0mKauTjrLKc/a8h+gXnQPAYsBIRS/sfDZlSH1pp2IuNiAjnnr73kI/1qBpZhW
         OrBQ==
X-Gm-Message-State: AOJu0Yxmfqs1tGjfIaaaVI3JlQsj8Y+IDB5wytBI5IkuRWs2Ibd7F3jh
        rnrl466QS7Fy0odqQu9ESJQ8JJnK8dmHX9S+zuwWIw==
X-Google-Smtp-Source: AGHT+IE1pWnFbq+bvNkANHEa6F9HgMq0nCpQURFTjbb3C8JLnaNzzyafy7rk9qiFfj7skQbIddqqZO1GMIggXTjT9jc=
X-Received: by 2002:a05:622a:c1:b0:410:4c49:1aeb with SMTP id
 p1-20020a05622a00c100b004104c491aebmr418242qtw.7.1692101467558; Tue, 15 Aug
 2023 05:11:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230808171446.2187795-1-mshavit@google.com> <20230809011204.v5.6.Ice063dcf87d1b777a72e008d9e3406d2bcf6d876@changeid>
In-Reply-To: <20230809011204.v5.6.Ice063dcf87d1b777a72e008d9e3406d2bcf6d876@changeid>
From:   Michael Shavit <mshavit@google.com>
Date:   Tue, 15 Aug 2023 20:10:31 +0800
Message-ID: <CAKHBV24royJvLUHemST07i1G+xhEizO=VdTX0Q9itpi_dLv=4A@mail.gmail.com>
Subject: Re: [PATCH v5 6/9] iommu/arm-smmu-v3: Move CD table to arm_smmu_master
To:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     will@kernel.org, robin.murphy@arm.com, nicolinc@nvidia.com,
        jgg@nvidia.com, jean-philippe@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 9, 2023 at 1:15=E2=80=AFAM Michael Shavit <mshavit@google.com> =
wrote:
>

> -static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_doma=
in,
> +static int arm_smmu_domain_finalise_cd(struct arm_smmu_domain *smmu_doma=
in,
>                                        struct arm_smmu_master *master,
>                                        struct io_pgtable_cfg *pgtbl_cfg)
>  {
> @@ -2115,10 +2110,6 @@ static int arm_smmu_domain_finalise_s1(struct arm_=
smmu_domain *smmu_domain,
>         if (ret)
>                 goto out_unlock;
>
> -       ret =3D arm_smmu_alloc_cd_tables(smmu_domain, master);
> -       if (ret)
> -               goto out_free_asid;
> -
>         cd->asid        =3D (u16)asid;
>         cd->ttbr        =3D pgtbl_cfg->arm_lpae_s1_cfg.ttbr;
>         cd->tcr         =3D FIELD_PREP(CTXDESC_CD_0_TCR_T0SZ, tcr->tsz) |
> @@ -2130,17 +2121,9 @@ static int arm_smmu_domain_finalise_s1(struct arm_=
smmu_domain *smmu_domain,
>                           CTXDESC_CD_0_TCR_EPD1 | CTXDESC_CD_0_AA64;
>         cd->mair        =3D pgtbl_cfg->arm_lpae_s1_cfg.mair;
>
> -       ret =3D arm_smmu_write_ctx_desc(master, 0, cd);
> -       if (ret)
> -               goto out_free_cd_tables;
> -
>         mutex_unlock(&arm_smmu_asid_lock);
>         return 0;
>
> -out_free_cd_tables:
> -       arm_smmu_free_cd_tables(smmu_domain);
> -out_free_asid:
> -       arm_smmu_free_asid(cd);
>  out_unlock:
>         mutex_unlock(&arm_smmu_asid_lock);
>         return ret;
...
> @@ -2465,6 +2450,22 @@ static int arm_smmu_attach_dev(struct iommu_domain=
 *domain, struct device *dev)
>         if (smmu_domain->stage !=3D ARM_SMMU_DOMAIN_BYPASS)
>                 master->ats_enabled =3D arm_smmu_ats_supported(master);
>
> +       if (smmu_domain->stage =3D=3D ARM_SMMU_DOMAIN_S1) {
> +               if (!master->cd_table.cdtab) {
> +                       ret =3D arm_smmu_alloc_cd_tables(master);
> +                       if (ret) {
> +                               master->domain =3D NULL;
> +                               return ret;
> +                       }
> +               }
> +
> +               ret =3D arm_smmu_write_ctx_desc(master, 0, &smmu_domain->=
cd);
> +               if (ret) {
> +                       master->domain =3D NULL;
> +                       return ret;
> +               }
> +       }
> +
>         arm_smmu_install_ste_for_dev(master);
>
>         spin_lock_irqsave(&smmu_domain->devices_lock, flags);
> @@ -2472,10 +2473,7 @@ static int arm_smmu_attach_dev(struct iommu_domain=
 *domain, struct device *dev)
>         spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
>
>         arm_smmu_enable_ats(master);

All this talk of locking on the other thread made me realize there's
an issue here. We are no longer holding the arm_smmu_asid_lock while
arm_smmu_write_ctx_desc is called due to its move out of
arm_smmu_domain_finalise_s1. This can race with arm_smmu_share_asid
which may modify the asid after we've written it, but before we've
updated the CD's smmu_domain->devices list.
