Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6115276BABF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 19:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234284AbjHARGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 13:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234409AbjHARGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 13:06:02 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40FF330F6
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 10:04:39 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-40a47e8e38dso5511cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 10:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690909459; x=1691514259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TtiZ/2g+uRWOlvdf02o01d3yF2A6nxZGDaY/kcHLaKU=;
        b=DBSMzQ6mgKsgt1hDGi5ZVgF0h9BEm3p0wT9fus6WIGe4OHTavNXlngjdTRVLBTlswk
         8lNX8Bm5BQJtReLn1ylzH/1DHl5n7KsFnv2KPv7oGw38xOff4QHynk1DJfBKOKJW5h0O
         0qUaLecNno+Fg7EJ1wX0DRCHNlE2DGOVRDqCsI/CIBOCURh+g6/DWLprnsuobBhnuaEz
         PfTol6v95rg03T0UAsyJopKOaNmzNXA3rPlnzSAU3Ii6+QasrWUw/+soO7bnx6JBxN6x
         Hh25Rz1pQ486Be2zEVjQvNIKc0MVVtXWxfEuMbiycY65XBDlURXrYoV7jtH3sTONXVid
         RA3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690909459; x=1691514259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TtiZ/2g+uRWOlvdf02o01d3yF2A6nxZGDaY/kcHLaKU=;
        b=O6GcmTV5jdFNvWSX0fcEN2vsxnAhtMk8ZQK97Iu/95sK1GxdBFq88AKIipA61G1Bu8
         XxqyP7FvyijRyyki1C4rIUKsCnFnQhhXUuLBXnI6/qY8y48wfBPvUtaBLiz0N0EiuQOD
         E1SFRBUA+JWWI+fUyoFrnE63Lab6Cu4H3kKz9ECxz+QBzlzrj9MAvcMmCcNzpmZn4Bod
         wh8A3RX7jqw/0JqBRIAqNqYj9ct/Q6ruEl+s9ar5gHYn3KlMJGZGPQdJ2t/5pTt5hek7
         Rvjhk/AqytmhlqBeDBBpR7s5EsOZknSCZR1JWZ8qGmTGmtlSZNeQK1dwDXCyDH5VCOiG
         yodA==
X-Gm-Message-State: ABy/qLb+aWTWfamNM5HPqw0xVzX/FVX19SZBCGygmQZBeWAmSEcvHbAd
        wGs7lD2/BXWQK6f35vzFbGBmlGBb5Cd3CQd+4Ptpdg==
X-Google-Smtp-Source: APBJJlHpos92MVcMyqsUnxl06UQwzPlCnyYB0wP5AYGPjD0cWyAYOalszh5XhLejGTaOSoVqUGELBqR5Gp8/iCbcYNc=
X-Received: by 2002:ac8:7e87:0:b0:40e:332b:ba30 with SMTP id
 w7-20020ac87e87000000b0040e332bba30mr552428qtj.23.1690909458906; Tue, 01 Aug
 2023 10:04:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230731104833.800114-1-mshavit@google.com> <20230731184817.v2.6.I219054a6cf538df5bb22f4ada2d9933155d6058c@changeid>
 <ZMkULTvwIIE3zo5+@nvidia.com>
In-Reply-To: <ZMkULTvwIIE3zo5+@nvidia.com>
From:   Michael Shavit <mshavit@google.com>
Date:   Wed, 2 Aug 2023 01:03:42 +0800
Message-ID: <CAKHBV25W_UTdhaL2L4ezP60TxgvP86sa_1-8L-aOiyjz64Fkug@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] iommu/arm-smmu-v3: Refactor write_ctx_desc
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, will@kernel.org,
        robin.murphy@arm.com, nicolinc@nvidia.com, jean-philippe@linaro.org
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

On Tue, Aug 1, 2023 at 10:18=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
> You know, you should try to keep the function instead of duplicating
> these
>
> arm_smmu_write_ctx_desc_devices()
>
> And put the four lines in there?

Urhhh yes, I thought I had a reason for this but probably just a lapse
of judgement. Done.

> -     ret =3D arm_smmu_write_ctx_desc(smmu_domain, mm->pasid, cd);
> +     spin_lock_irqsave(&smmu_domain->devices_lock, flags);
> +     list_for_each_entry(master, &smmu_domain->devices, domain_head) {
> +             ret =3D arm_smmu_write_ctx_desc(master, mm->pasid, cd);
> +     }
> +     spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);

Just noticed that this is problematic; we may not notice a failure if
it occurs on an earlier iteration of the loop. Will fix.

>
> > @@ -987,19 +985,14 @@ static void arm_smmu_sync_cd(struct arm_smmu_doma=
in *smmu_domain,
> >               },
> >       };
> >
> > -     if (!smmu_domain->cd_table.installed)
> > +     if (!master->domain->cd_table.installed)
> >               return;
>
> BTW, do you have locking for this? I didn't check carefully

This is one of the reasons I wanted to take this as a parameter to the
function. This relies on callers guaranteeing that the cd table not be
attached/detached while this call is in progress. This works now
because:
1. No domain may be attached/detached while SVA is enabled, which is
most of the calls that lead to arm_smmu_sync_cd
2. The other call to arm_smmu_write_ctx_desc in arm-smmu-v3.c is more
obviously serialized with operations that detach/attach the cd table.

Maybe this should at least be a comment on arm_smmu_write_ctx_desc, if
not a lock?


Speaking of.... I should probably flip this bit to false in patch 5
when the cd table is detached.
