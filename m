Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18B78756010
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 12:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbjGQKHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 06:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjGQKG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 06:06:58 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62C3107
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 03:06:56 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-403f21d3c2dso66141cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 03:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689588416; x=1692180416;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U5jr9e8QR2CE+jx7hoK3GYY7WZVYLsVZnNa64/yh+4I=;
        b=uCnJPisDxbxoSg9iZIjEFb2x+X9zbUG6vyd41nBHxaEmhrNt2YBpuSx3cYUyKHPq74
         utL0TXKl1roD8amFlbIe3Pc7S9swevZuGTWT2bYRijFOMoWuvNDmeSgPJqChYojFidJZ
         uAfVmbfZptzUJBTW8Wr4WbInuVICD1E7GjpWmnMgSFcJwm8EfE3fiUkVd79WDAuviW+E
         9m63548nzRPE2iPsimlvy9WhMaDOawHTUBVdJfCAERtM3zFzDSw5jQB6LdRudG5lMo5I
         wkRPiYjX9ddjcmHtrAEfzWhDGfj/2wq6OU2NLl7bwH2/x6JBEZio2Aw8p838LokZGgJH
         DTUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689588416; x=1692180416;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U5jr9e8QR2CE+jx7hoK3GYY7WZVYLsVZnNa64/yh+4I=;
        b=gU2ct2p8aqMvDXjF2fNFc7ZTBPkElm6tV73MnLkVRLN77miXStEKt/g3dZ93ARTOLr
         2V1dPE58AmLokdOJngP3llHXXSXxClo/0rGkta4X+uEdFDg2EAPT5FJfhSs6Ax2gfgLI
         FLhDNtBBXGnWERhmsfEsxmX7B2nrcHsZoUg96cJnE6WJB4SRLH/DdzYvW6kxcjTN7gVS
         E3WwTgB6Nb5VARZ+i2Jpubq/VeEJEtvhtSCBT97RWi652kUjSWD4tqkZ6dnTmP+LXL7a
         7EXAzRC90FvZsv269JXbjtUhz65uPQFW7tLt60BYGu4ZM+PlzBVJ36Ox9abgJ+HHgNTM
         LbPw==
X-Gm-Message-State: ABy/qLbM/KUHEgZwCJc5GSDJiboUGmD2a9LnAD1iF8tVDiAYjxk2h/0N
        Lr47hjxKIxGEKRVOgWFCuRtqVu3nWZ36jQYBE9t5WQ==
X-Google-Smtp-Source: APBJJlHk3I92nOg/KDAqxcg+hjcLwfd3/yj6Vd5EH/l1EKkLJt7jrWGYw4/lnPg102I8xgYoY8Lxr3GVek0aOdLOlIM=
X-Received: by 2002:a05:622a:1355:b0:403:eeb9:a76 with SMTP id
 w21-20020a05622a135500b00403eeb90a76mr122576qtk.17.1689588415600; Mon, 17 Jul
 2023 03:06:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230621063825.268890-1-mshavit@google.com> <20230621063825.268890-3-mshavit@google.com>
 <ZK9RycgNAVrxe343@Asurada-Nvidia> <CAKHBV26wi+xKnNjo-R+QOcVLPH2KJTFP+mF4CW1xE61nOdF5GA@mail.gmail.com>
 <ZLAKQw+DzcpSRSyi@nvidia.com> <CAKHBV25YadRVFiag5z5Yc13L093ScWkCjAOCd=VuGm2RUaDyzA@mail.gmail.com>
 <ZLApQjaqoOshT2TJ@nvidia.com> <CAKHBV25BRWTxXO0YTGq3q1OdMQHAzop8BqJJaa9CHxdQzxnNbg@mail.gmail.com>
 <ZLFLyh1b+wiqb7Ql@nvidia.com>
In-Reply-To: <ZLFLyh1b+wiqb7Ql@nvidia.com>
From:   Michael Shavit <mshavit@google.com>
Date:   Mon, 17 Jul 2023 18:06:19 +0800
Message-ID: <CAKHBV24zQ+4waZgsYV08LzeMkjze1gTcwvEv5uL8RM1GcBgrzg@mail.gmail.com>
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

On Fri, Jul 14, 2023 at 9:21=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
> patch 2 should delete arm_smmu_s1_cfg and just put
> arm_smmu_ctx_desc_cfg directly in the master. arm_smmu_ctx_desc_cfg is
> a weird name for the contex descriptor table, but it is much less
> weird than s1_cfg. As you say s1fmt/s1cdmax are redundant.

s1fmt is fairly trivial to replace but s1cdmax requires inversing
previous computations. I don't really buy that getting rid of it
simplifies anything, even if it's technically redundant.

> patch 3 I don't understand, we should not add something called
> s1_cfg/s2_cfg to the master. The master should have
> 'arm_smmu_ctx_desc_cfg cd_table' and 'arm_smmu_domain ste_domain'

This was simply meant to be a more convenient way of finding the
currently active cdtable from the
arm_smmu_write_ctx_desc/write_strtab_ent functions without having to
inspect the currently attached domain. But sure, that's easy enough to
revert.

> patch 5 makes sense, but something seems odd about the order as we
> somehow half moved it in patch 2?
Ack; patch 2 can be reordered to come after patch 4, or even squashed
with 5 if you prefer.

> My suggestion for patch structure is to start by cleaning up the CD
> table object. Make arm_smmu_ctx_desc_cfg the CD table, remove the
> redudencies, remove arm_s1_cfg, clean the CD table APIs to only use
> 'struct arm_smmu_ctx_desc_cfg *', add the 'ste_domain' to the master,
> and then as the last step just move the arm_smmu_ctx_desc_cfg from the
> iommu_domain to the master.
>
> And that is a nice little series on its own - you end up with a shared
> CD table in the master, and no CD table in any domains.

I don't entirely buy that refactoring s1_cfg is worth the extra
effort, nor that it should be tied to this patch series. This series
already makes s1_cfg behave as the CD table; whether we want to
entirely get rid of pre-computed data useful for writing an STE sounds
like a separate cleanup.
