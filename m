Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85AE27665B3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 09:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233952AbjG1Hs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 03:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbjG1HsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 03:48:24 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2385230DE
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 00:48:23 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-40631c5b9e9so167111cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 00:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690530502; x=1691135302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zUIcMhVF/1TXo1rqJGfnJ10sMHDmAV5y2UmUPZxHyso=;
        b=zm2w/xaSYP9fraWbl9XbK57vPboGwFbaKmAn53G34La8VFbct9frpGoZBErfB8qcY0
         PsyLraOMAE6EssS6TGMr6sTBNSTalvEFjJHW5pDKCfWyeY9cQUdJSlT7Q3ciDuWx933m
         SIrJEdSjUCoOCLHgLMfkUD/mZMsuh9qwOVZ63YlKtJl0fVtTei+MWl2pYvL9kP7eJxSC
         T/Edi/zqpNKBM67b65buVS3yEYEHj1/AX/KU5sCI1XeC0+KTHfzEni6E7S9hvCm3kJ48
         ZDtjwcmmYqPVfHxpU455E2j24bzWpPO+th7YT10EKaeCkEMBDRG0tOC4eSNj0pkYpjKA
         TUKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690530502; x=1691135302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zUIcMhVF/1TXo1rqJGfnJ10sMHDmAV5y2UmUPZxHyso=;
        b=dEMxczkk7pA7GV3mnGKyYH4j0sI8X3qpW/P+wHpkNt4UlTReXQkDtN4/ImsVvTLwlQ
         7qbZ6qgxbD3EDCC9LkLsXEhRKy+DU9KefaKPHypoEld5zrvOPO/YxeZa5LO2/Ojhfdbn
         h0ejGizAKowTrEMPkDyReW172Et9qYGkAtI4yetXc3tnyyR7FlH9ibK6LaMVemtZJd0A
         kp+Qxlz9XCJCE/kdPMREkjLtbO2spPpEMd1Xbom/U3gfvEFeYw1S/Iii8gXj0ITmUu1e
         LpvBy4yd3NyolJOl7qeVoR+8E343NJkG6xFRzp9t1bFR6t3RP5iLMSUd+v1+OmgKymHo
         cMHA==
X-Gm-Message-State: ABy/qLb71IVRpgDqxZjaHbme+PxDJqHsrWCCpXfl8o+ypEl+zo2+/T4F
        10h+ovH9IfUgMP7uscCDiiSYE8nCdYmQNEhE+cBpsw==
X-Google-Smtp-Source: APBJJlHNHh7OBFkfrB6xevuRXLFBa3hgMyt/+TAPrzU2QxrKh7IGRGo24VsyFyVjyhWh6yXWTm/ElpomUyCgUFPl7b0=
X-Received: by 2002:a05:622a:58f:b0:403:d35d:4660 with SMTP id
 c15-20020a05622a058f00b00403d35d4660mr129612qtb.11.1690530501658; Fri, 28 Jul
 2023 00:48:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230727182647.4106140-1-mshavit@google.com> <20230727182647.4106140-3-mshavit@google.com>
 <ZMLaM9QjHDu11iKf@Asurada-Nvidia>
In-Reply-To: <ZMLaM9QjHDu11iKf@Asurada-Nvidia>
From:   Michael Shavit <mshavit@google.com>
Date:   Fri, 28 Jul 2023 15:47:45 +0800
Message-ID: <CAKHBV252e5Cx1nssFTPVBmr_iGqLhvp1jjBfR5euRynAzHC12w@mail.gmail.com>
Subject: Re: [PATCH v1 2/7] iommu/arm-smmu-v3: Replace s1_cfg with ctx_desc_cfg
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
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2023 at 4:57=E2=80=AFAM Nicolin Chen <nicolinc@nvidia.com> =
wrote:

> It'd be nicer to align all the variables to "cd_table" like the
> 2nd piece here. And if we rename the struct name too:
>
>         struct arm_smmu_cdtab_cfg *cd_table =3D xxxx;

I agree that renaming these would be nice. There's 36 usages of cdcfg
in arm-smmu-v3.c, and 6 usages of  arm_smmu_ctx_desc_cfg.
I can rename the struct since we'll be touching many of those in this
patch anyways, but I'm a bit concerned of the churn from updating all
the cdcfg usages.

> Though "s1fmt" is redundant, "max_cds_bits" doesn't seem to be.
>
> It'd be nicer to separate them in the commit message to why we
> remove s1fmt and why we rename s1cdmax.

Will fix!
