Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55BEC766AC4
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 12:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235975AbjG1Kef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 06:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236354AbjG1Kdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 06:33:52 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D5DF4C07
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 03:31:56 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-4036bd4fff1so265781cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 03:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690540307; x=1691145107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m/AXnTNrjt3ydEdFE4yO813xK+xMvSb9hSQ/KG4yXiY=;
        b=mIflqVFpPiPyE5coqLIaWLnBUmVWEBvqGt0jbIVzLQc5C6qj+8o2bO0+KhCxqUWJov
         CtmgIJ8meKYRW4W7+Gm6CtMyjfw2i+lhqB/SAa7eFDyi/wVYe6JcwbljhFYGk2z3Kgbt
         gUtwdoAGRhhODwV86DKsuUMEL50snPSFfgSxUZ+daYLIFXawYVJQ45nmP6GqgbXQXbSv
         NoA9FVxpE2kyIRYSO144o7RU6TFA2WuJUoE1mamcEvU00X6SQVJkEnrsbQ6aFTOnFkdV
         xnm/ZBpvBnqtwQDUPewsDPX1qVAmkI4oKitcEbKYi3FJ0+41eDYf7/bdoFbII+TlSFu+
         iaMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690540307; x=1691145107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m/AXnTNrjt3ydEdFE4yO813xK+xMvSb9hSQ/KG4yXiY=;
        b=Lb8etQ3npR1rzSkUJvrSIfmY50pd6kzPhW/VfoFWEuDClfHcN9/P5jiVSPKt3eloAC
         EUcb0U6/cGYpXM+AFyXO+iRizi8OMfBtEmXYijTyag3L5OGTNrOYGaZjRHwwQ6PPgIdp
         XMQ19iBA2ucxb7TFft+fGJ5TI7OqdFgW0WAw3ZGZbXn0CwPtbnTR5ryX4QSBFSrR3ljI
         ZKcMmZOxNO+CXUhM00Sd+ESJdbMsgYN7B5GD0cwt8vZF9MQyZuPu+6ttJaw3QSR+KAxZ
         7y7SM9pDn221ikSpTrnAUE4mdkIUzHKiymDhuDxZ3+l3iv3zJsGP9s/mALnK2EclEifK
         bo8A==
X-Gm-Message-State: ABy/qLapR6XnsCI7jY22BPUHrM7JDPYUD94r32MnbOv+LxKo0jMRvTn2
        sUBwSBGrmkokvHG7Mm+Iud2iDUp0PoPony1VavXwVw==
X-Google-Smtp-Source: APBJJlE9SwpJREDV8xCEmxNrhYG76qnWJF7dC5R7su/Hm9zssL6hBOFD4oidawqk/BxBEGlLlZO+2fyI6V8ckax7YrU=
X-Received: by 2002:a05:622a:1a02:b0:3ef:302c:319e with SMTP id
 f2-20020a05622a1a0200b003ef302c319emr255356qtb.8.1690540306630; Fri, 28 Jul
 2023 03:31:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230727182647.4106140-1-mshavit@google.com> <20230727182647.4106140-7-mshavit@google.com>
 <ZMLjqfp6M6n7HAxl@Asurada-Nvidia> <CAKHBV24bEYboxv9XXPvgt86q2B2DTm2He-mbO=kJqsNijCmMMg@mail.gmail.com>
In-Reply-To: <CAKHBV24bEYboxv9XXPvgt86q2B2DTm2He-mbO=kJqsNijCmMMg@mail.gmail.com>
From:   Michael Shavit <mshavit@google.com>
Date:   Fri, 28 Jul 2023 18:31:10 +0800
Message-ID: <CAKHBV25UURAQKEXADpP72Z3HT=EWT4aqnZYcOeus0Pn8jhvyUQ@mail.gmail.com>
Subject: Re: [PATCH v1 6/7] iommu/arm-smmu-v3: Refactor write_ctx_desc
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
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2023 at 3:34=E2=80=AFPM Michael Shavit <mshavit@google.com>=
 wrote:
>
> On Fri, Jul 28, 2023 at 5:38=E2=80=AFAM Nicolin Chen <nicolinc@nvidia.com=
> wrote:
> > > @@ -1101,11 +1094,11 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_d=
omain *smmu_domain, int ssid,
> > >                 cdptr[3] =3D cpu_to_le64(cd->mair);
> > >
> > >                 /*
> > > -                * STE is live, and the SMMU might read dwords of thi=
s CD in any
> > > -                * order. Ensure that it observes valid values before=
 reading
> > > -                * V=3D1.
> > > +                * STE may be live, and the SMMU might read dwords of=
 this CD
> > > +                * in any order. Ensure that it observes valid values=
 before
> > > +                * reading V=3D1.
> >
> > This seems to be true only after the following patch? If so, we
> > should move this part over there too.
>
> This comment is more in theme with the next commit so I can move it
> over. But FWIW, the fact that the STE is not necessarily live at this
> location is true before this patch, in this patch, and after the
> following patch. Fixing this comment is just a drive-by, not a result
> of any of these changes.

Whoops, I mean more in theme with the previous commit.
