Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFC08777EED
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 19:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234549AbjHJRPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 13:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234563AbjHJRPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 13:15:51 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FCF426B8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 10:15:51 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-40a47e8e38dso17611cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 10:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691687750; x=1692292550;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JR+DvT908I1ICbPFaZN70WEoRAJPsTY/Ml+jiHbe598=;
        b=O+8TJEX29ntsMx49vxz9eDxi5qRTBy/PfPdi6jrhS0S87A8dAfMat1Z/VRsbaJMGf1
         xBhIAvwZJvFA3fR+8a2SG7O8fJN3vHnWf21qEmqkgndgNOJEM87LCgXyOpq+LjsbwWAb
         wDaaT6YZh11NFKOcuoVGMDF1gljVmFxtgW9yspM8EdcB1iK0X1TYemcuQJq0wgq5sH7W
         0S2Y0BY530j6PNoP6zb7FhRmLSa4rLOh1tnpTu5b7ber8Nm+HlPo/FZVNO0ZG1jpj0MI
         GOzouVrrJTlcKHP2kMTp9His7UWWPZ09f9/i2zY4trGe1sD43wxXXQi1vStDPoWoovMl
         AlMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691687750; x=1692292550;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JR+DvT908I1ICbPFaZN70WEoRAJPsTY/Ml+jiHbe598=;
        b=XG7FTakhDWTBoofb4KTtTUWkeDbO8o/FuiiRBhpU9C8x61lNt7alL8A783RG6voz1/
         sCrdp1V92tV6A7jIkF8CgoF02HSupUc/uO/1COqXqsUmI0IcBgfn2rxmexmCP0hhoaZL
         SKKeeeDHEvlfGiX8f+tyczrBJKKLpOK26ih1pgGCGPdSm1u9HcRUKAJzgxSg2APjA+br
         mHPtm5HVA+Ojkwstwtaaf5pox8QgvjiLyrvIYEjTPavUzEXb3W2YU3KW5oNMatBTzALZ
         gymQAsSWMLW4KKwVLofXZitOwmVXtnbk0pocYNLzb6IMn60OyANR6QRKKhCKLhnN5K+h
         BUdQ==
X-Gm-Message-State: AOJu0YyaE8IDCVAGGA2SxvYy/OK4irFNRPHgiKSWQ/Igb/P2VS+k+Iki
        7epXF2W86wCO0fbgG/GupbwRvT8Yq/hOuyKj6/P24g==
X-Google-Smtp-Source: AGHT+IF2w8NqxF/8920Zh5iOHLtA/IWiK7hewBUqrSrDqDeLZHZICGqLq8Oz6cl/5J93KUbEpTpBSh8nrJDJ2iyZikU=
X-Received: by 2002:ac8:7f86:0:b0:403:96e3:4745 with SMTP id
 z6-20020ac87f86000000b0040396e34745mr11341qtj.20.1691687750089; Thu, 10 Aug
 2023 10:15:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230809011204.v5.2.I1ef1ed19d7786c8176a0d05820c869e650c8d68f@changeid>
 <20230809134941.GA4226@willie-the-truck> <ZNObxeogswAYyDQ5@nvidia.com>
 <20230809145542.GB4472@willie-the-truck> <ZNOr0ggoO9kXHJWl@nvidia.com>
 <20230809162254.GB4591@willie-the-truck> <ZNO+QVkXcHG78KG3@nvidia.com>
 <20230809162749.GA4663@willie-the-truck> <CAKHBV27JAFb56VkHJO2ZBZt=25aVregeiMjO2YJrg_fW9HQbYg@mail.gmail.com>
 <20230810094323.GC5365@willie-the-truck> <ZNTSU1Jm6OsauygC@nvidia.com>
In-Reply-To: <ZNTSU1Jm6OsauygC@nvidia.com>
From:   Michael Shavit <mshavit@google.com>
Date:   Fri, 11 Aug 2023 01:15:14 +0800
Message-ID: <CAKHBV254QmO3iXyEL6w0PqvVofm_UCDd13LKmpbhU-cEORB5ww@mail.gmail.com>
Subject: Re: [PATCH v5 2/9] iommu/arm-smmu-v3: Replace s1_cfg with cdtab_cfg
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robin.murphy@arm.com, nicolinc@nvidia.com, jean-philippe@linaro.org
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

> > > What dead code? Is the deal here that we keep the field, but still
> > > infer the value to write from (cd_table->l1_desc == null) in
> > > arm_smmu_write_strtab_ent??
> >
> > Keep the field and write it directly when populating the ste (i.e. don't
> > infer anything), but the field moves into 'struct arm_smmu_ctx_desc_cfg'.
>
> Yes - the 'dead code' is that we introduce storage for a field that is
> always a known constant (STRTAB_STE_0_S1FMT_64K_L2).

I'm not sure we're on the same page here. s1fmt could contain either
`STRTAB_STE_0_S1FMT_64K_L2` or `STRTAB_STE_0_S1FMT_LINEAR`, and this
value will be directly copied in arm_smmu_write_strtab_ent.
