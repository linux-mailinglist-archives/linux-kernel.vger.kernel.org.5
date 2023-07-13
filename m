Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0846D751BD6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233694AbjGMIka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232830AbjGMIkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:40:12 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD4844A1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 01:35:33 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-40371070eb7so177821cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 01:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689237332; x=1691829332;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CUiEY1fSBTwYVk97ONcADqRi9c3ar1khFfmJ+HnVmuI=;
        b=gyanBDz/w9wX5l7O7NXT48CRH/6WxciJmda5d9B2FPcbw0+Gq46F1tkWLT74J78W/X
         mVGSg1kDkkO4CaFX1TK16spI+QMaC/5ySbVBT/E46wzmRpLFQPAEmyblcP5hEZxqaPbJ
         /6aqM6jyOSVYK/J9EDxvU3NQFqRWjiyXnqL5gF6Mn59jAuO5M2o/L5oDi3f2DnNmQMVZ
         7aFhnT7eeLSbohY7HpBsfSR+1L+/QZ5Tn+Ap2hDLgYTBz6wKpbu0XeAonfxXt4Pk5UHo
         jUnEwrpN3PRA9rCxxZq1vo7nAfaECJBfSrti5GFE8rWa76KI2+hjdfuBzV0xeJpHQRry
         BzsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689237332; x=1691829332;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CUiEY1fSBTwYVk97ONcADqRi9c3ar1khFfmJ+HnVmuI=;
        b=AZYgj8VyfHgEMQWWc6jEnQO6ZR+ab14qmInBbVIgPqVGGBS6NXybPAFsm/j/VL3a7j
         zoVIuIee71LhgQis9/eKwXx2o+TnjJwcYFfTh8mtHSC40YChevzQnqmJ2zAseR2bM1sO
         DQfj5CubbZlO4LWMtYLFd3/kwKmwxYULzYSj53Te455W5w5w56Kn5vKioyGV/99bQpNU
         Cpcgc0JPRuRI/cLg2/dQg6qEkKjntBo6uHrbnrnaFmO9Sosl7V2B8I7oQBGuXgf2fllD
         h6G00ZnVVnw82Nv+t2lU9Wmem6iUzVYmwqWfs0p+GqImbNmqMcFLk1vfQ8Xonct0iyD7
         RmYQ==
X-Gm-Message-State: ABy/qLaBMbeBdExfS8RV/gEW81tZdrsf0UuBO7Il/aR2u1Gnku8kBrHw
        eajcYa/NfFyt6x3xi4Hyp7XCZD6xMvrJs0bbKMze2g==
X-Google-Smtp-Source: APBJJlE8ZmsIj2Hzla7BztX6LrHSwBFzu2OcKKW8iqQh5D4S5j3zr68JLR331RxxDu7qRE6yXsUYFC+y34hqT56X5Qk=
X-Received: by 2002:a05:622a:245:b0:3fa:3c8f:3435 with SMTP id
 c5-20020a05622a024500b003fa3c8f3435mr435860qtx.27.1689237332162; Thu, 13 Jul
 2023 01:35:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230621063825.268890-1-mshavit@google.com> <20230621063825.268890-3-mshavit@google.com>
 <ZK9RycgNAVrxe343@Asurada-Nvidia>
In-Reply-To: <ZK9RycgNAVrxe343@Asurada-Nvidia>
From:   Michael Shavit <mshavit@google.com>
Date:   Thu, 13 Jul 2023 16:34:56 +0800
Message-ID: <CAKHBV26wi+xKnNjo-R+QOcVLPH2KJTFP+mF4CW1xE61nOdF5GA@mail.gmail.com>
Subject: Re: [PATCH v4 02/13] iommu/arm-smmu-v3: Add smmu_s1_cfg to smmu_master
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, jean-philippe@linaro.org,
        jgg@nvidia.com, baolu.lu@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
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

On Thu, Jul 13, 2023 at 9:22=E2=80=AFAM Nicolin Chen <nicolinc@nvidia.com> =
wrote:
>
> > Except for Nested domains, arm_smmu_master will own the STEs that are
> > inserted into the arm_smmu_device's STE table.
>
> I think that the master still owns an STE when attached to a
> nested domain. Though an IOMMU_DOMAIN_NESTED iommu_domain is
> an opaque object to the STE in the guest, the host still has
> a real STE for the nested configuration somewhere -- and it's
> likely still to be owned by the master that's attached to the
> opaque NESTED iommu_domain in the host kernel.

> I am a bit confused by this naming. If only master would own
> an s1_cfg, perhaps we can just make it "s1_cfg" and drop the
> s1_cfg pointer in the next patch.

Could be that the naming is causing some confusion. This owned_s1_cfg
is very different from the s1_cfg set-up by Nested domains in your
patch series. It's better to think of it as the default s1_cfg used
for DMA/SVA/UNMANAGED domains. Because stage 1 domains represent a
single page table, it doesn't make sense for them to own an entire CD
table. In contrast, nested domains map an entire CD table and it
therefore makes sense for them to own the s1_cfg representing that
table.
Would renaming this as default_s1_cfg make more sense?
