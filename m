Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5E0C77CCCA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 14:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236746AbjHOMiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 08:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236386AbjHOMhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 08:37:33 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B466EE
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 05:37:32 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-40a47e8e38dso208531cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 05:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692103051; x=1692707851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mnrecSaJD34910gHzwXIpaaOwSJRpk0gL4cM/0P1omE=;
        b=hl7NM85AaleV8yYJ6mBSpcUlTs7PrwfoEdJWqLZIhab6uLt7Uf9O2/GreVEDYj68Ms
         GnCse/8AzcSYdiPYqEmql1yYKh160grmhVGQQ49GywXTe9IJpk9BS5tO20JogHB/WdIc
         oORoKHGlI7SlvUnlXOEamX1dm+buJD74/pTnAI9z/BH0axLDllP4ePDEz4YcK+ScWHGj
         SmSDn/STQ4OFO+pAacs6n6eUpDZ+hNME9koRJuJOVIjfwjjjolSvyG8QP1uNxKv/2dvR
         /awxrdsLyBBSN+qkABr9TLrcxuS6o8lulw6e2tZvk4eaeUpHVW9qdbuZCPP+i7W3+5nG
         A2Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692103051; x=1692707851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mnrecSaJD34910gHzwXIpaaOwSJRpk0gL4cM/0P1omE=;
        b=cXLiSS4zxSu20LqKD0eCa3NWL3D9UUC8Fv2696/qK0PktwWxbkwCiFkmwpH0C5RRHU
         E5VCOaJjcdrQ+Ier5XmA0tJ/wkDq0y9laDp2HYb6SHbgWF6Fbxd6OY684a2sHF276esb
         Yw/tl7D8vbwtUTtX1fm4k51TpE5pMVNvF6Jhcey3oiS9f/Cd024UTZRZNgRn4HCnNuKq
         POkoPRiIZfDhlTHLoYSPn6sQXLK0QpjKfl69pysJu2WBlhS1/0hyTSkQtDrMDsvtf5rd
         lBn/vJnASsqSOfyfdghz6a/pT52bxtih24lyyeJ7a+YvJDUEUflp/U4Lcqs3ppYnf735
         siVQ==
X-Gm-Message-State: AOJu0YyMZSqDWQwepjJx4rQY5s8E+1URQfbju21z3eP2QS0iuq6Nt4/T
        Ya2tZIeS1Cyg/LmztDtKws1VmnKu3d5Iz9XEurFw8w==
X-Google-Smtp-Source: AGHT+IGpTmrw2fGiN3up8cJegRBZAiPhJdILtNxzxvCDHEKSXB7pG2c7uVtSRIvQhLARUhGyTCFZ9YljOeRRb1JCBg8=
X-Received: by 2002:a05:622a:1a0a:b0:3f9:56c:1129 with SMTP id
 f10-20020a05622a1a0a00b003f9056c1129mr705742qtb.5.1692103051175; Tue, 15 Aug
 2023 05:37:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230808171446.2187795-1-mshavit@google.com> <20230809011204.v5.5.I219054a6cf538df5bb22f4ada2d9933155d6058c@changeid>
 <20230809134959.GB4226@willie-the-truck> <CAKHBV25CQYfqm80a1ztHXn3s6kj7KCuJBwJz4EZk5cog4n6R+A@mail.gmail.com>
 <20230810144051.GD5795@willie-the-truck> <ZNUEuIlPmrckwMyn@nvidia.com>
 <CAKHBV24SLBNw-yWn3m6BtvvHUgD0h1e1QkEb1LrUcWSwpR85Yg@mail.gmail.com>
 <ZNtgD3LKwS4eatoe@nvidia.com> <CAKHBV25YKMGnAs2L0a5EwdaXrpwb9RPJqBcJjO6ahD7UMgEd2Q@mail.gmail.com>
 <ZNtv+vLTOl43mXYv@nvidia.com>
In-Reply-To: <ZNtv+vLTOl43mXYv@nvidia.com>
From:   Michael Shavit <mshavit@google.com>
Date:   Tue, 15 Aug 2023 20:36:55 +0800
Message-ID: <CAKHBV25wD2sU-pVWsNBrJRdhDvmt41hWST7sr91qrVbmtkSZdg@mail.gmail.com>
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

On Tue, Aug 15, 2023 at 8:30=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Tue, Aug 15, 2023 at 08:03:40PM +0800, Michael Shavit wrote:
> > On Tue, Aug 15, 2023 at 7:38=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com=
> wrote:
> > >
> > > On Tue, Aug 15, 2023 at 01:20:04PM +0800, Michael Shavit wrote:
> > > > On Thu, Aug 10, 2023 at 11:39=E2=80=AFPM Jason Gunthorpe <jgg@nvidi=
a.com> wrote:
> > > > >
> > > > > Actually, I don't think this even works as nothing on the PASID p=
ath
> > > > > adds to the list that arm_smmu_write_ctx_desc_devices() iterates =
over ??
> > > > >
> > > > > Then the remaining two calls:
> > > > >
> > > > > arm_smmu_share_asid(struct mm_struct *mm, u16 asid)
> > > > >         arm_smmu_write_ctx_desc_devices(smmu_domain, 0, cd);
> > > > >
> > > > >         This is OK only if the sketchy assumption that the CD
> > > > >         we extracted for a conflicting ASID is not asigned to a P=
ASID.
> > > > >
> > > > > static void arm_smmu_mm_release(struct mmu_notifier *mn, struct m=
m_struct *mm)
> > > > >         arm_smmu_write_ctx_desc_devices(smmu_domain, mm->pasid, &=
quiet_cd);
> > > > >
> > > > >         This doesn't work because we didn't add the master to the=
 list
> > > > >         during __arm_smmu_sva_bind and this path is expressly wor=
king
> > > > >         on the PASID binds, not the RID binds.
> > > >
> > > > Actually it is working on the RID attached domain (as returned by
> > > > iommu_get_domain_for_dev() at sva_bind time) not the SVA domain
> > > > here...
> > >
> > > That can't be right, the purpose of that call and arm_smmu_mm_release=
 is to
> > > disable the PASID that is about the UAF the mm's page table.
> > >
> > > Jason
> >
> > For the sake of this message, let's call "primary domain" whatever RID
> > domain was attached to a master at the time set_dev_pasid() was called
> > on that master. That RID domain is locked in while SVA is enabled and
> > cannot be detached.
> >
> > The arm-smmu-v3-sva.c implementation creates a mapping between an SVA
> > domain and this primary domain (through the sva domain's mm). In
> > arm_smmu_mm_release, the primary domain is looked up and
> > arm_smmu_write_ctx_desc() is called on all masters that this domain is
> > attached to.
>
> My question is still the same - how does arm_smmu_mm_release update the
> Contex descriptor table entry for the *PASID*
>
> The RID on PASID 0 hasn't change and doesn't need updating.
>
> Jason

arm_smmu_mm_release looks-up the CD table(s) to write using the
primary domain's device list, and finds the index into those CD
table(s) to write to using mm->pasid.
