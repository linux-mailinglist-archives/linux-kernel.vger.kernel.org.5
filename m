Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1B95752822
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 18:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234699AbjGMQQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 12:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230439AbjGMQQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 12:16:55 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813C01BEB
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 09:16:54 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-401d1d967beso333661cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 09:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689265013; x=1691857013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KIGK1YyVHYZJI7AzNx8908/vhc/B3w7S4pe5DEK+mb0=;
        b=uBZ7B6Zp7EpOVHlAWk+Xb4+1TnfJlI2oH/iQ+Xztosvc4TV7SX1M/zrx6B4Rdhmt9Q
         Sht7ScVZahLgJXbdq7YTR3rylVnso4JJTzYc67XLXMpJ3IWApKIrD/T3d4vKgSKKNf8x
         ymhPMEcB6aXYoU6bHLTW/u3CNE9UhpVdBoKMpl0rt63TxHl+a6Yk/7fJDQYXGrjQWTqC
         wUT5gO/GFlxcD9sqHhzpjIU3oNj5NG4JkhL47DLx5bw+BRfg3DngcmIAX9USdcQgEbLs
         yUZ3WadqYOt3uNCw3II/023hqnWLIYkQrvNQZMx1PrXLPn9bNiS1heYxcUdw1gjK7xDp
         PYdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689265013; x=1691857013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KIGK1YyVHYZJI7AzNx8908/vhc/B3w7S4pe5DEK+mb0=;
        b=SmpKiVci659rRYhLzSzYlC8oi3tYgeYJKyF6Krilgydpuc3UP01mAtcNRcb1MCeUvX
         DtjGGJ9ulTjaLDHd9eeVyTtTRCWhujTsZNUrRh2JOfmXBipLHPHqaHgq2EVFSbPsp8NK
         SUYBhNEQ7Q9jehsZh5tZ+AHXiDoLNLjGhc/LVFzB/2R1J4Ab5lqPBCu0w7Sa1prCyicd
         1pwQVeohswIWeldvbtFAgP3tzhG3aIwQe1Fc4NtDdlRMU3nTKLMese2y/W0AwavhCdrk
         f01pXC3uecVHF3lgtHvwKUSB8hjZG39WutEkWC/LyygQ3dhqOD6T9Rd1XUy0XD3Q56yo
         jDTQ==
X-Gm-Message-State: ABy/qLYl+hE16ath5bBss7GJ9m5TDF/1615JsRBUbTlcehFaQ8iWoFMV
        YUDku7IWmPMm0CzTLMUxPXF6CIGL0EwKPwSkedu3HA==
X-Google-Smtp-Source: APBJJlFkh0J4qQCApfksef5WD+OIFNG9dkqTt8Lz2fZbUrMErakuqKo9MIIywxsc27dtNAaDAMMboaoPGHuyWPp4zAQ=
X-Received: by 2002:ac8:5a8b:0:b0:3f8:5b2:aef2 with SMTP id
 c11-20020ac85a8b000000b003f805b2aef2mr522383qtc.26.1689265013503; Thu, 13 Jul
 2023 09:16:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230621063825.268890-1-mshavit@google.com> <20230621063825.268890-3-mshavit@google.com>
 <ZK9RycgNAVrxe343@Asurada-Nvidia> <CAKHBV26wi+xKnNjo-R+QOcVLPH2KJTFP+mF4CW1xE61nOdF5GA@mail.gmail.com>
 <ZLAKQw+DzcpSRSyi@nvidia.com>
In-Reply-To: <ZLAKQw+DzcpSRSyi@nvidia.com>
From:   Michael Shavit <mshavit@google.com>
Date:   Fri, 14 Jul 2023 00:16:16 +0800
Message-ID: <CAKHBV25YadRVFiag5z5Yc13L093ScWkCjAOCd=VuGm2RUaDyzA@mail.gmail.com>
Subject: Re: [PATCH v4 02/13] iommu/arm-smmu-v3: Add smmu_s1_cfg to smmu_master
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Nicolin Chen <nicolinc@nvidia.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, jean-philippe@linaro.org,
        baolu.lu@linux.intel.com, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
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

On Thu, Jul 13, 2023 at 10:29=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> w=
rote:
> It would make alot more sense if the STE value used by an unmanaged S1
> domain was located in/near the unmanaged domain or called 'unmanaged
> S1 STE' or something if it really has to be in the master. Why does
> this even need to be stored, can't we compute it?

struct s1_cfg* and struct s2_cfg* are precisely what is used to
compute an STE. For example, when s1_cfg is set, arm_smmu_write_strtab
will write the s1_cfg's CD table dma_pointer into the STE's
STRTAB_STE_0_CFG field. When neither are set, the STE fields are
written to enable bypass (or abort depending on the config).

> I'd think the basic mental model should be to extract the STE from the
> thing you intend to install. Either the default CD table, or from the
> iommu_domain. ie some 'get STE from iommu_domain' function?

I don't follow this. When we attach a domain with pasid (whether
through SVA or the set_dev_pasid API) , we don't want to install an
entirely new CD table. We want to write something (page-table pointer)
to a common CD table. Where should the s1_cfg which owns that common
table live? I thought we concluded that it should be owned by the
arm_smmu_master rather than any domain (to avoid dependencies between
domains a-la aux-domain). With this change, even attach_dev with a DMA
or UNMANAGED domain is now just preparing a single entry into this
common CD table.
