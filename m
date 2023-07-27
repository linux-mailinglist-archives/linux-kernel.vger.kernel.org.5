Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6333D76522D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 13:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232969AbjG0LWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 07:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbjG0LWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 07:22:43 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B32E4F
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 04:22:43 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-40550136e54so268001cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 04:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690456962; x=1691061762;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5znSXkBTI7s/miWUhZa06rDZhJ/+eYLN2IwckbqVcpM=;
        b=CDP/mJ6pIwwNwaMUbOAIFOQXZTexa2gF8bh/6x2AhR9HwVUFpBynA6umqzTsEQTGTI
         NDXybLHyUBaZYGBIU0Hxxw+KJUtSWoLn60tOa+yeqtwlD6vF0j8pCNYzTgJzb41ronjf
         DOOay1BU4I6aohcInADy2DOd0rZjv1VVhdisnyLZfCww/zv7EEeU7oxY0mnl6kXQsLNH
         HW1jE63zHWd/8h2ZlyCNDGMelrHhqBRneaWrb28ENECnlFfAEMsFOGe7sdRUvSDEZ2Ns
         8GKR+H+TtxdIcuhF18kB8OAEvDMA9leyjBLYO8XIgbqFR8m8IMQ5ICaxeTB5Zg5Emzcp
         HS0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690456962; x=1691061762;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5znSXkBTI7s/miWUhZa06rDZhJ/+eYLN2IwckbqVcpM=;
        b=jHNryagV5pt7Jjr5OAwbqOBfpLOc3nsLRZkreJvR7XHwK3YPMI0/Tv6PIUqoR/rDEZ
         /zHW9CLQkSS7ua2waJmRprzmhS78nKS1KW4vJPbfC/93MmF4RKF790GIfhrGZ2LQ7y9A
         705gBkKWerNNc76OlDfBVgLSHABpRCpwoHDH0dP6CVicouEuPMC3FGcFsgOu53yIsZ5F
         FLuQcWJV8VsblA5CROGZynhWPSX7HT23N3o8luYJztlQSkzFCZTLFq2gB5Dsnaov59T3
         idmc6ftiNkms0Fkz7X7trVFQF1wxCvduDEvfz/59+r66y9IYiIiORvOv9ubgMiiQfcOH
         e6Xw==
X-Gm-Message-State: ABy/qLZyTpJT2CjuJNHHli3FQXVHxgi6LJPcylGbq+c6G+X7M5YTOUsk
        7OIeqFlGcscXSpB5VKpIVXJd6c1R8HaMiJFAOjH30A==
X-Google-Smtp-Source: APBJJlFKsrhjqr+pGO2xPAA7ZPtIkomN091N3COEvvJv97fo1FfhsvUjkQ1Uim0YUmvbb045Wes5qVyQXhvsWl+gViw=
X-Received: by 2002:ac8:578d:0:b0:405:432b:9973 with SMTP id
 v13-20020ac8578d000000b00405432b9973mr220819qta.0.1690456962027; Thu, 27 Jul
 2023 04:22:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230621063825.268890-1-mshavit@google.com> <20230621063825.268890-3-mshavit@google.com>
 <ZK9RycgNAVrxe343@Asurada-Nvidia> <CAKHBV26wi+xKnNjo-R+QOcVLPH2KJTFP+mF4CW1xE61nOdF5GA@mail.gmail.com>
 <ZLAKQw+DzcpSRSyi@nvidia.com> <CAKHBV25YadRVFiag5z5Yc13L093ScWkCjAOCd=VuGm2RUaDyzA@mail.gmail.com>
 <ZLApQjaqoOshT2TJ@nvidia.com> <CAKHBV25BRWTxXO0YTGq3q1OdMQHAzop8BqJJaa9CHxdQzxnNbg@mail.gmail.com>
 <ZLFLyh1b+wiqb7Ql@nvidia.com> <CAKHBV24zQ+4waZgsYV08LzeMkjze1gTcwvEv5uL8RM1GcBgrzg@mail.gmail.com>
 <ZLU0IZJr6WSjknHf@nvidia.com> <CAKHBV25QZn9xApRT+=oAtwQRAjCD--S46uXRDwW+E5=at0ESQQ@mail.gmail.com>
In-Reply-To: <CAKHBV25QZn9xApRT+=oAtwQRAjCD--S46uXRDwW+E5=at0ESQQ@mail.gmail.com>
From:   Michael Shavit <mshavit@google.com>
Date:   Thu, 27 Jul 2023 19:22:05 +0800
Message-ID: <CAKHBV26sRpFJv8-_f4n2jsTKiOgnHF0_FZ07KBbVaueX+T2kWA@mail.gmail.com>
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

Sorry for the delay; I'm trying to refactor these patches now.

> I think the master should have a pointer to the iommu_domain that owns
> the STE or if NULL the master should assign its internal CD table to
> the STE.
Just to clarify, does the nested domain patch series require writing
CDs into the user-space's CD table using arm_smmu_write_ctx_desc()? Or
is there any other requirement for writing a CD into a domain-owned CD
table from arm_smmu_write_ctx_desc?


Writing a CD entry to the CD table involves some dependencies on the
master(s) that the table is attached to:

1. The CD entries STALL bit value in arm_smmu_write_ctx_desc depends
on the master (e.g. if STALL_FORCE is set on the smmu device). This
could potentially be encoded in arm_smmu_ctx_desc_cfg, at which point
that CD table is only attachable to masters with the same
stall_enabled value.
2. arm_smmu_write_ctx_desc must sync the CD for the attached master(s)
in the middle of writing CD entry.

This is all easier to handle in arm_smmu_write_ctx_desc if the table
is always owned by the master.
