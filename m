Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77EC676CB9D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 13:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234124AbjHBLT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 07:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234121AbjHBLTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 07:19:54 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3916D268E
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 04:19:49 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-40a47e8e38dso135591cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 04:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690975188; x=1691579988;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Wq8cn2J6sVYRERovJLmedigLkU1hrLj8goBJfFuNds=;
        b=kOrKMge0UoNaRBw0wrdtyfN0q3TJ7HPqJutvDcwc46Gv+XF5TpZpoXcnvFCjJxfscJ
         VOsC3FlmCH9tyKdBBq3osNmeW4/3B2zoAhzNtN3BEL64qq4/6jtMS9Be1jGywd8w5NoY
         +/B6EaWWy5/yo6losZFJsX4goGF41WslK1jcQeFKTrsE8ACj0I28azDJqdMnq2hbj4Hs
         uoD9PFrFYaweFOjuhh4z32GOzFYo6SmU4oWyAH1SjVoSNG4QwzdYgL9L4yhCpno6MYv0
         LyYmS9+Kq+fnYglWOTSIXVoeqPAXDVCae+FRprPd94iMec/HvQtJ/EGd4Pv/4Yc2ddLj
         EYCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690975188; x=1691579988;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Wq8cn2J6sVYRERovJLmedigLkU1hrLj8goBJfFuNds=;
        b=BZ9GAcJZnEkWFoddf4nojTFoX6efGOia0GrUtoLI9e/bf3sIi62DpfA3Z1y9MsWSQw
         /MLmhcaA9R60CmPwlJrs7ocg4bihd8tzha54GMFUSqkjglPl5F6VXW0QlrKlMpOL1KON
         EimP46BPD13/NlvgPB3b7YWmBLMp8ufrDPcn2w6sTRP4e6WbHlD0qxM2DYaC7JBHJsMl
         mSQJUKctOkRRZ3kjTPEER44Tu6+wzO4T73EKuynm5NSzyoeht6cEePxd7YqepzNF4DvY
         FpSAKp2c8E1ncTkzPl8X18imJS+v8Dt57b0V/m7spCmQmIQPBXyFw6da6Bm1dIz+BhuI
         3kWw==
X-Gm-Message-State: ABy/qLZwK4lLoKM+oPBDyRYEyvs+nQwUcM4aVa6S2jzrBGeIwp74JFah
        lfKlDMJmg96ZytRFXau/aQpkdNs4Maj5iun6ZZqtZw==
X-Google-Smtp-Source: APBJJlG0I3Dhg+TBORKYrBn9z8NMpsRfeSBGXC1mEccDfQVVS1/uUKsIB++bl54caZq72N8AvPt4aT2zHVUtP/TVO4I=
X-Received: by 2002:a05:622a:130e:b0:3fa:3c8f:3435 with SMTP id
 v14-20020a05622a130e00b003fa3c8f3435mr999983qtk.27.1690975188231; Wed, 02 Aug
 2023 04:19:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230801183845.4026101-1-mshavit@google.com> <20230802023524.v3.6.Ice063dcf87d1b777a72e008d9e3406d2bcf6d876@changeid>
 <ZMma/qk0otN9eyW3@nvidia.com>
In-Reply-To: <ZMma/qk0otN9eyW3@nvidia.com>
From:   Michael Shavit <mshavit@google.com>
Date:   Wed, 2 Aug 2023 19:19:12 +0800
Message-ID: <CAKHBV24e4YAB8J7MP=vuVarn5cVSWrB-NsjO-obH5CZECk0xNg@mail.gmail.com>
Subject: Re: [PATCH v3 6/8] iommu/arm-smmu-v3: Move CD table to arm_smmu_master
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, robin.murphy@arm.com,
        will@kernel.org, jean-philippe@linaro.org, nicolinc@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 2, 2023 at 7:53=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wro=
te:
>
> On Wed, Aug 02, 2023 at 02:35:23AM +0800, Michael Shavit wrote:
> > @@ -2465,6 +2440,22 @@ static int arm_smmu_attach_dev(struct iommu_doma=
in *domain, struct device *dev)
> >       if (smmu_domain->stage !=3D ARM_SMMU_DOMAIN_BYPASS)
> >               master->ats_enabled =3D arm_smmu_ats_supported(master);
> >
> > +     if (smmu_domain->stage =3D=3D ARM_SMMU_DOMAIN_S1) {
> > +             if (!master->cd_table.cdtab) {
> > +                     ret =3D arm_smmu_alloc_cd_tables(master);
> > +                     if (ret) {
>
> Again, I didn't look very closely at your locking, but what lock is
> being held to protect the read of master->cd_table.cdtab ?

The cd_table is only written into (with write_ctx_desc) when something
attaches or detaches (SVA is a little weird, but it handles locking
internally, and blocks all non-sva attach/detach calls while enabled).
The cd_table itself is allocated on first attach, and freed on release.

Doesn't the iommu framework guarantee that attach_dev (and
release_device) won't have concurrent calls for a given master through
the group lock? I can add an internal lock if relying on the iommu
lock is not OK.

> > +                             master->domain =3D NULL;
> > +                             goto out_unlock;
>
> This is only the domain lock:
>         mutex_unlock(&smmu_domain->init_mutex);
>
> Which is no longer sufficient.

Hmmm yeah that lock looks misleading here. Let me move the unlock
further up so that it more clearly surrounds the section it protects.
