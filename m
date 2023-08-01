Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1755076AA90
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 10:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbjHAIKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 04:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232100AbjHAIKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 04:10:30 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC7811D
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 01:10:29 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-40c72caec5cso225401cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 01:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690877429; x=1691482229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jfxf35QEdYY0OSeBLLB/TKiEyw1s73KmxDhCmVa+GQQ=;
        b=BSOQo36x+R0DY2LXinFdqRdbB4vEfzSH24J2R8rF2ZzJkOBf/+rmJn4aawldedN5tY
         NartRiOVkWmgbnwGkEY4FG3KnMDVLrSeIV0N2hFSGgvfN8VwP8mgC8snFIPLieUgJ8lz
         UnsHl+weLbuJ95bnCtmh+cC/uFYGOm6QOOoES23M8+0Ph3OGOtEcdG2+qaqtq37IluXj
         zYQeLNpC10fXzo6jTlw41jxZ7DYijHb107QXif9qn+RdmePhho23AibOx+BtQ8sXZL40
         fXanBtDzAkdNvnIup7L2K2799jnm7PV47+aFNN0+2akBInHyDY/3fGSPBV5At3EFxZwM
         ptfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690877429; x=1691482229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jfxf35QEdYY0OSeBLLB/TKiEyw1s73KmxDhCmVa+GQQ=;
        b=jTaogaExXIItVDQJeVNgZsUpEK8Nm519yd8PvDiXGWK4T6mMhgc6MZ5V3w1SNXyjmO
         v3ZDyvbwxS6pLV5m/K3wS6bdb1w1IKpTX/OKlIDBR5u4GTBO+RXF9O4klfSzA5eYLOOW
         uROmTxXNpue9toKexrfeNKo8gy2s7pOUo5LhssSDiCLDar3JdR+HpQcrHHxU2zmd1s6D
         TOi7wRPyrE1FhZzFtZ9r0G5LLzvvv616vNNew5tyqj7XRG4vXt/0/088u3HaR/lVGRcn
         h//vTh/1pEB7JgF8tUZ60Q+PMF3AdXp2+nOgMAlCesL4hyZtBYLYlae5rJdKvihrNN3Y
         SEKA==
X-Gm-Message-State: ABy/qLY23o51LqBPgKxQTM+eCEoMrxQfQKDrXu7iJyc9lI4YIEByNc1I
        2M0lF0YIxVbKciMuriO0YxwWtzvoMwOqF+FuLWe4wA==
X-Google-Smtp-Source: APBJJlECES7oDVzhAvgrIjKnBacfwahdB7C4mQA9TtcZDBFnk6u3FAWxLlAKrD+AAjCc+35TLdjxAMV3SUtY8es6x0I=
X-Received: by 2002:a05:622a:104d:b0:403:9572:e37f with SMTP id
 f13-20020a05622a104d00b004039572e37fmr594142qte.22.1690877428749; Tue, 01 Aug
 2023 01:10:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230731104833.800114-1-mshavit@google.com> <20230731184817.v2.4.I5aa89c849228794a64146cfe86df21fb71629384@changeid>
 <ZMiJ9Cg5wfbxMZ+W@Asurada-Nvidia> <ZMiPjRtch1c06F5Y@Asurada-Nvidia>
In-Reply-To: <ZMiPjRtch1c06F5Y@Asurada-Nvidia>
From:   Michael Shavit <mshavit@google.com>
Date:   Tue, 1 Aug 2023 16:09:52 +0800
Message-ID: <CAKHBV26C17_9VrVC0ZESC9FF3TheNifVx8w97ig2qeMFHFfKjA@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] iommu/arm-smmu-v3: move stall_enabled to the cd table
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, will@kernel.org,
        robin.murphy@arm.com, jgg@nvidia.com, jean-philippe@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

> On Mon, Jul 31, 2023 at 09:28:40PM -0700, Nicolin Chen wrote:
> > This cd_table->stall_enabled comes from master->stall_enabled, and
> > cd_table will be in master structure. Also, struct arm_smmu_master
> > pointer will be passed in to arm_smmu_write_ctx_desc(). So, there
> > seems to be no need of master->cd_table.stall_enabled in the end;
> > just use master->stall_enabled directly?

Yes it's correct that this change isn't strictly necessary. Thoughts jgg@ ?

On Tue, Aug 1, 2023 at 12:52=E2=80=AFPM Nicolin Chen <nicolinc@nvidia.com> =
wrote:
> Actually the stall_enabled might still need to be per-CD/domain.
> If a domain is attached by two masters. The domain->stall_enabled
> is initialized with the first master->stall_enabled. Then, the
> second master->stall_enabled would be required to match with the
> domain->stall_enabled. arm_smmu_attach_dev() has such a sanity.
>
> So, I think we might not need this patch.

But why force domains attached to different masters to have the same
stall_enabled setting? Whether stall is enabled is strictly a property
of the master, not the domain. IMO the fact that it was stored in
domain and checked in attach_dev was only because the previous design
required it, not because it's more appropriate.
