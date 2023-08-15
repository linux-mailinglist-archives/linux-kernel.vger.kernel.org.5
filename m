Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A90EC77CC45
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 14:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236967AbjHOMEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 08:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236935AbjHOMES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 08:04:18 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7431510F4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 05:04:17 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-40a47e8e38dso199681cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 05:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692101056; x=1692705856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wa4ijFpMRNMdDOXZdXXDwrY7fporBKZPPmAwJ4muH1s=;
        b=NlAy2nuZM6YR9j6uv9fE7TfLbdb84+Dc3bcHB1de2on8b3q9QHMMiUaqqpZrkQfTCc
         4GQCzEK7vdfxxw4y51dSVfVL5+t+OL1kgGBV16+kVaFL6/m7Plodl3JNAfx682/FQ75x
         lTTt95SINOfPa4ECwMwnQH5R2b7ltvoy+KtDxfhvyR63QJqhmnkyqfbLqxZN3lcbE1Mi
         2LwENFpd6RuTxX+JnFJRI/4C3etxUfRuZLDPOo3lCxVXT0ARk6k6X4MTXweHPW9Ux3+N
         QxDvCF3OfjBV9yE9mL+o97vo1SoBWDXgU5WY0VvlZeZhLPpJqqXmPqhkOdLPtyJpGwLP
         XNUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692101056; x=1692705856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wa4ijFpMRNMdDOXZdXXDwrY7fporBKZPPmAwJ4muH1s=;
        b=Q/2KWAG5P403ZMYETwQwAelBIXchDGaPjBzP64BHKbrShMnXo2fo80x5cGhpLVpluy
         5quVqOJPgZQsSlmABLoNTIWGb8eg5FfEHU03R6vyChfNrdEB3m8vmJCX4b3UdbeewUer
         Y4ukE8as1qdKbeD12o0jXVVd9WbV3JdqGxElfmd2Brh+OITdTdrQdT95Lf21p0hPUk+h
         w6ngShh8urcfQdm3PCM5rXYqFOKOxSNSiIpcJnmkB8bWidD7c0Kvge9GT8ryKkKN83z5
         9vSsI5g2S4YP62c+oJtP6SwRwoUoJctdYHfD+TznQEp+pLwSrBkDRATXibEnxKztciQQ
         zVYg==
X-Gm-Message-State: AOJu0YwAE4zAX5DJjpgAL710opUzZdEqbMDR4cY2bZBygD0auyIRMCKa
        OESo0JJ52yn0i/WttpffYABHnuQsFSTnztmmDPhDDQ==
X-Google-Smtp-Source: AGHT+IFLbYrlXJqUODynvyJHT9/v4qYbX+kKrxOxLI/Ska83ZEsKVQNmI3ZCRWkbxaNCpQQIqaVcBPaHoOU23NqKoq0=
X-Received: by 2002:a05:622a:1822:b0:403:f5b8:2bd2 with SMTP id
 t34-20020a05622a182200b00403f5b82bd2mr660297qtc.9.1692101056467; Tue, 15 Aug
 2023 05:04:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230808171446.2187795-1-mshavit@google.com> <20230809011204.v5.5.I219054a6cf538df5bb22f4ada2d9933155d6058c@changeid>
 <20230809134959.GB4226@willie-the-truck> <CAKHBV25CQYfqm80a1ztHXn3s6kj7KCuJBwJz4EZk5cog4n6R+A@mail.gmail.com>
 <20230810144051.GD5795@willie-the-truck> <ZNUEuIlPmrckwMyn@nvidia.com>
 <CAKHBV24SLBNw-yWn3m6BtvvHUgD0h1e1QkEb1LrUcWSwpR85Yg@mail.gmail.com> <ZNtgD3LKwS4eatoe@nvidia.com>
In-Reply-To: <ZNtgD3LKwS4eatoe@nvidia.com>
From:   Michael Shavit <mshavit@google.com>
Date:   Tue, 15 Aug 2023 20:03:40 +0800
Message-ID: <CAKHBV25YKMGnAs2L0a5EwdaXrpwb9RPJqBcJjO6ahD7UMgEd2Q@mail.gmail.com>
Subject: Re: [PATCH v5 5/9] iommu/arm-smmu-v3: Refactor write_ctx_desc
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robin.murphy@arm.com, nicolinc@nvidia.com, jean-philippe@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, Aug 15, 2023 at 7:38=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Tue, Aug 15, 2023 at 01:20:04PM +0800, Michael Shavit wrote:
> > On Thu, Aug 10, 2023 at 11:39=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.co=
m> wrote:
> > >
> > > Actually, I don't think this even works as nothing on the PASID path
> > > adds to the list that arm_smmu_write_ctx_desc_devices() iterates over=
 ??
> > >
> > > Then the remaining two calls:
> > >
> > > arm_smmu_share_asid(struct mm_struct *mm, u16 asid)
> > >         arm_smmu_write_ctx_desc_devices(smmu_domain, 0, cd);
> > >
> > >         This is OK only if the sketchy assumption that the CD
> > >         we extracted for a conflicting ASID is not asigned to a PASID=
.
> > >
> > > static void arm_smmu_mm_release(struct mmu_notifier *mn, struct mm_st=
ruct *mm)
> > >         arm_smmu_write_ctx_desc_devices(smmu_domain, mm->pasid, &quie=
t_cd);
> > >
> > >         This doesn't work because we didn't add the master to the lis=
t
> > >         during __arm_smmu_sva_bind and this path is expressly working
> > >         on the PASID binds, not the RID binds.
> >
> > Actually it is working on the RID attached domain (as returned by
> > iommu_get_domain_for_dev() at sva_bind time) not the SVA domain
> > here...
>
> That can't be right, the purpose of that call and arm_smmu_mm_release is =
to
> disable the PASID that is about the UAF the mm's page table.
>
> Jason

For the sake of this message, let's call "primary domain" whatever RID
domain was attached to a master at the time set_dev_pasid() was called
on that master. That RID domain is locked in while SVA is enabled and
cannot be detached.

The arm-smmu-v3-sva.c implementation creates a mapping between an SVA
domain and this primary domain (through the sva domain's mm). In
arm_smmu_mm_release, the primary domain is looked up and
arm_smmu_write_ctx_desc() is called on all masters that this domain is
attached to.
