Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B48A765588
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 16:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbjG0OEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 10:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbjG0OEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 10:04:44 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CDD81BC3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 07:04:42 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-40550136e54so314061cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 07:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690466681; x=1691071481;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wro4I9SuyvTTnQF8s+nnyO/Nqnj1OCBzGy+P8LoI4UY=;
        b=OJDYpXYw1QZ7Cg5AQAdCH8DZAa7Q8WNl/ren99kQfwSe09jenn2kbXtQz408Cyyuql
         IMOcJADDxHflTG6QlBd+An7Bbti8OdvcQ1YX5SE0BlAE9o4okAArEymT4PsCa9jON0V9
         KemTA9eqriiBQFFkwXE6Sz0GXtTF2lMEnWHvTpXfuS2g8tGnyZm7/+ZFMtOmWXqP6ZvF
         VJ+yAfBGnYnKCHsDj+tyP5JSIYYHmLd6+m5/iIKQ4Hh9ZQXSiCaoCitW5rNcIvbXehhL
         YG1dnZ2VvxrqSzHtitOs6z6pthtt9hQTrKiAF2tn1eZ8F9DDqHYXeR8Z6WBJWpE0MRJt
         4qpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690466681; x=1691071481;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wro4I9SuyvTTnQF8s+nnyO/Nqnj1OCBzGy+P8LoI4UY=;
        b=KYMmm+8nshzhnamdeeGwdLycEFBp8SNUvG1wIglz5OQ4rXyPGk3ZOIpOwKOhlbWaCl
         lZlFJnasBoGn0+b7lgxtKpLO9GaAIIchehecQVv7LgA/sBoNlQtPOy+iu8HVaOhdk3Md
         hj9oIENnkmeZ1MVvH7MVnurdL0TO/0tYaVHy73VMP9CJ9f9rqBsrmTTRSkBnIqD0fVsj
         JzpAZMwMm2RGrs9Pgjl/FEnILf0YNbDpRRo1sx9EsyqWC5s0JcxVeqAd6xy83+pYECE4
         0kWLN9lIvK9IqOp+6Jk5st2JjxNK3f7aqKYVnJ3sK/BLCqhpUNfCChtEnstAZ5la6ojk
         R/cg==
X-Gm-Message-State: ABy/qLa9sPVGnW48CPP5eT72cILo5l0HHong23vthGb139EXDIAC/U1J
        qDFWLlKwwSMXzAfqCu02hdKwuqx6Dkoa4AMpzT7A3g==
X-Google-Smtp-Source: APBJJlFbpq9dEBh60onyb4nGTfsAwxbFVxzP9N2IZ58rh+h+naOWkc4TLzSg2cYP3r3qzM+MAE1Nv8ZvTAhWEsNtMZk=
X-Received: by 2002:ac8:5815:0:b0:403:f5b8:2bd2 with SMTP id
 g21-20020ac85815000000b00403f5b82bd2mr191469qtg.9.1690466681153; Thu, 27 Jul
 2023 07:04:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAKHBV26wi+xKnNjo-R+QOcVLPH2KJTFP+mF4CW1xE61nOdF5GA@mail.gmail.com>
 <ZLAKQw+DzcpSRSyi@nvidia.com> <CAKHBV25YadRVFiag5z5Yc13L093ScWkCjAOCd=VuGm2RUaDyzA@mail.gmail.com>
 <ZLApQjaqoOshT2TJ@nvidia.com> <CAKHBV25BRWTxXO0YTGq3q1OdMQHAzop8BqJJaa9CHxdQzxnNbg@mail.gmail.com>
 <ZLFLyh1b+wiqb7Ql@nvidia.com> <CAKHBV24zQ+4waZgsYV08LzeMkjze1gTcwvEv5uL8RM1GcBgrzg@mail.gmail.com>
 <ZLU0IZJr6WSjknHf@nvidia.com> <CAKHBV25QZn9xApRT+=oAtwQRAjCD--S46uXRDwW+E5=at0ESQQ@mail.gmail.com>
 <CAKHBV26sRpFJv8-_f4n2jsTKiOgnHF0_FZ07KBbVaueX+T2kWA@mail.gmail.com> <ZMJa3kGHD2iE0/za@nvidia.com>
In-Reply-To: <ZMJa3kGHD2iE0/za@nvidia.com>
From:   Michael Shavit <mshavit@google.com>
Date:   Thu, 27 Jul 2023 22:04:04 +0800
Message-ID: <CAKHBV27kr540gTDbgGwzYt6_X7J=NfdNONVe-_y0-XpAQjc4jQ@mail.gmail.com>
Subject: Re: [PATCH v4 02/13] iommu/arm-smmu-v3: Add smmu_s1_cfg to smmu_master
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Nicolin Chen <nicolinc@nvidia.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, jean-philippe@linaro.org,
        baolu.lu@linux.intel.com, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Awesome that helps a lot. These are the patches I have in mind:

1. Move ctx_desc out of s1_cfg
2. Replace domain->s1_cfg with `struct arm_smmu_ctx_desc_cfg cd_table`
3. Move stall_enabled from domain to arm_smmu_ctx_desc_cfg
4. Accept an arm_smmu_master instead of an arm_smmu_domain as the
parameter for arm_smmu_write_ctx_desc
--- arm_smmu_write_ctx_desc can simply get the cd_table it writes to
from master->domain->cd_table; this get's replaced by master->cd_table
in subsequent commits.
--- SVA is weird if we cut changes here: it iterates over all masters
a domain is attached to in order to call arm_smmu_write_ctx_desc(),
which ends up writing to the shared cd_table since in master->domain.
This becomes more sensible once masters stop sharing the cd _table in
subsequent commits.
--- arm_smmu_write_ctx_desc is used to sync the cd for all masters the
domain was attached to. Now that SVA is calling it in a loop, and to
break the dependency on arm_smmu_domain, we should only sync for the
master passed in as the parameter
5. Introduce a skip_cd_sync parameter to arm_smmu_write_ctx_desc so
that arm_smmu_domain_finalise_s1 can skip the sync_cd before the
cd_table is attached to the master. Before the previous commit,
arm_smmu_domain_finalise_s1 was calling arm_smmu_write_ctx_desc()
before adding the master to the domain->devices list, which was used
by arm_sync_smmu() to issue sync commands to masters. This
optimization was broken by the previous commit since we stopped
depending on domain->devices.
6. Move cd_table from domain to arm_smmu_master->cd_table.
