Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 304EE753498
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 10:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235122AbjGNIFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 04:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235360AbjGNIFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 04:05:15 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD9A3A8E
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 01:03:27 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-4036bd4fff1so252561cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 01:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689321806; x=1691913806;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=12v+SPtROiuj28H9N1MOzT6JNCiTmCYWUdjB7HIYh9U=;
        b=iDmMZDSqf3iIVvRyT48YiFdmq+VtvdVcdpZrTUHa8AuNtkQDzhSgtzn80pyJOeSdSn
         WthTd0bac9iDmnhxto3e/SJh08OOfhdyqS4S4LAinwn0JhKL8ANCv2EAo7c3y8auT+w1
         Ba28IpqEcKlincwLS/D9tL4sYCR474IumKQBGexhNlQHOw9B8ruCDvFkk7LxP4oUJ0MY
         /DEWJVUg4hRVGRhgbKVRQAXRG+LsQ3EZatz7NR44xbydr0RwXY6D2p/NBirMlaugADB7
         +0eGokxsKNQcA2MxyZdUIdnM+RBST+ojJqHhP4a6loAhuN2oVY7wZGsQJcJDKE8kiYrl
         F5JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689321806; x=1691913806;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=12v+SPtROiuj28H9N1MOzT6JNCiTmCYWUdjB7HIYh9U=;
        b=iFzf7gtsSqF3aH/l0KX+Dd/sDKs/EAPNk402RQTBvN5abFgtCvjDWRjUl6TrRCsc0a
         E/IWhLABjt4v4fBZVdSrPwCGawlNE/PRTY6LqQizcwk8I5BuNesK1qrmv/SAyUjABtG1
         5FOBXe7L4eToeVGiAnBvFg3sTgiXxOMzJwfmqoO0rLqSS6jKNqviaUDzeUaltXnqIK1w
         XS/bJkYYvETqIJK2E6AzwgV3LSa7adxbAQezmtww5Pb1OaRYNXOz2BCqoHFIB8QR/Qum
         9L4cGn4NRoUk8AwIeLw3wQRDO6XDloJsOHwASkq3jLehOLXiYb/+i1HARs/9ZFkPpjOe
         IapA==
X-Gm-Message-State: ABy/qLbguWoIxmOc1ErUwYhWISGlq3xOkqQCuejWk/wwqTvE+UiobQwv
        0Q6oUGP6LoQWagXLZEzWjyY3e0tOOhS7tiSgCx0d6Q==
X-Google-Smtp-Source: APBJJlGKNpfvbfdCqxqjT1YvdZfgE5A04mkwsR12CMTw8mOVWHG7g74SOPl9dWaNq9JuLTwk3VVOv7ZuNeEPP+nMHEE=
X-Received: by 2002:ac8:5905:0:b0:3ef:302c:319e with SMTP id
 5-20020ac85905000000b003ef302c319emr754044qty.8.1689321806537; Fri, 14 Jul
 2023 01:03:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230621063825.268890-1-mshavit@google.com> <20230621063825.268890-3-mshavit@google.com>
 <ZK9RycgNAVrxe343@Asurada-Nvidia> <CAKHBV26wi+xKnNjo-R+QOcVLPH2KJTFP+mF4CW1xE61nOdF5GA@mail.gmail.com>
 <ZLAKQw+DzcpSRSyi@nvidia.com> <CAKHBV25YadRVFiag5z5Yc13L093ScWkCjAOCd=VuGm2RUaDyzA@mail.gmail.com>
 <ZLApQjaqoOshT2TJ@nvidia.com>
In-Reply-To: <ZLApQjaqoOshT2TJ@nvidia.com>
From:   Michael Shavit <mshavit@google.com>
Date:   Fri, 14 Jul 2023 16:02:50 +0800
Message-ID: <CAKHBV25BRWTxXO0YTGq3q1OdMQHAzop8BqJJaa9CHxdQzxnNbg@mail.gmail.com>
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

On Fri, Jul 14, 2023 at 12:41=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> w=
rote:
> The master object owns an optional CD table. If it is exsists it is
> used by every domain that is attached to that master.
>
> In the code flow there are two entry points to attach a domain, attach
> to a PASID or attach to a RID.
>
> For attach to PASID the code should always force the master to have a
> CD table and then attach the domain to the CD table.
>
> For attach to RID the code should do a bunch of checks and decide if
> it should force the master to have a CD table and attach the domain to
> that, or directly attach the domain to the STE.

 Yes. This is the current flow (except that we fail instead of forcing
when a CD table isn't already attached in the PASID flow).
owned_s1_cfg is simply a pre-allocated version of your optional CD
table.

> When the master gains a CD table then the CD table object becomes
> attached to the STE. In all cases we should be able to point to the
> object the STE points at and don't need a cfg or pointer to cfg since
> the object itself can provide the cfg.

Ok, practically speaking, are we just talking about reverting patch 3
and keeping a handle to the primary domain in arm_smmu_master? Instead
of directly accessing the currently active CD table using
arm_smmu_master->s1_cfg, you'd like set_dev_pasid() to look for it by
investigating what kind of domain is attached, and reaching to the
pre-alllocated/optional CD table otherwise if necessary?

> > We want to write something (page-table pointer) to a common CD
> > table. Where should the s1_cfg which owns that common table live?
>
> I would suggest a 'cd table struct' that as all the stuff related to
> the CD table, including an API to cacluate the STE this CD table
> requires. If not in actual code with a real struct, then in a logical
> sense in that a chunk of the master struct is the "CD table".

Sure, that's almost exactly what s1_cfg is today (with these patches)....
  * s1_cfg.arm_smmu_ctx_desc_cfg describes the CD table
  * s1_cfg.s1fmt and s1_cfg.s1cdmax describes attributes of that CD
table. These could technically be deduced-back from
arm_smmu_ctx_desc_cfg's l1_desc and num_l1_ents
  * s1_cfg.stall_enabled was introduced by patch 4 and in retrospect
does not belong there at all. It should have gone in arm_smmu_ctx_desc
instead (ignoring the whole should arm_smmu_ctx_desc even be
precomputed in the first place topic for a second).
