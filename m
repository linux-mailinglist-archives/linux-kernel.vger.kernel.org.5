Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E156377C708
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 07:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234776AbjHOFYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 01:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234702AbjHOFVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 01:21:39 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6AE21BD4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 22:20:50 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-40c72caec5cso126481cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 22:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692076850; x=1692681650;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R8rldmZbFQsdFeS9GjoqGMHcF+DWT+Us0qlghVZOIyQ=;
        b=0jsmJBp+rB0QHzuCJc+wW+cKrZ99ZF3C5PhU9hnj2pYiKV0RTwO5iPjtRUk+tFIwYz
         qaz6+Km88XGrbKnCMuyMIt62JBK/zCZomIffpie+6l7I07pwx6zoyIwYwnWe7bl4u4vJ
         suu1OKmj+RRoJ5JcdXr0HnTN5GVzbKcRs+9wGFIe57LqPGexwL6yA7o1mSpDCg0dVb3h
         n5cio5sPjIkjYwem+UvovKPjhsZDt9RYZBFGeTmIpYuQdz5knKSxpgtWPmAstmcOPNTO
         yMdku0D10bP9qHUH4fs/HdrJxPtdkOTazLbsbngH6t7J6edMQ/pSKIWpy1ZXGSG1n6hb
         q0mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692076850; x=1692681650;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R8rldmZbFQsdFeS9GjoqGMHcF+DWT+Us0qlghVZOIyQ=;
        b=bUGMeJh5I0RljMQi1Y00lRW21C+vRQhzsfSRJzPZKq5tpu9Q5LsZxihBnXPusDCnqf
         acZbcXbp5WxYzdXtoic3aiQcS/6V1vYCL8KKRwbjzx+8WzfjV7HU/cKNYdN1SKCgpHs2
         5njMyjoU7m6NfPRyGtXvDujSVrQZVpdmJRi+zCom1C/5M/SmDr1LfQs2XoSGhRxiYtGn
         PcTpQKwFJt8kcj9FglzMT2199V9Q9j/U/Brq88llyjszroHxxMxijL+n5cKmLHVftwdk
         RbnYLuuMxoA2u4y7eQFeFQt5fw4+SDgDDynwPEUkXE8FbClbmxw9Te9ckTGpXC6ORPWm
         uBGA==
X-Gm-Message-State: AOJu0YwhDoD5vlDIc0jPjBqc2MdfsHWvKLaOjsHcET6hD2mUaBHbLw1s
        LUSvrt31eM79tq9xDh/Tg8FjnIevXSKWjaBs0GusAH3iT4zCKwxrz7LMpA==
X-Google-Smtp-Source: AGHT+IFZAtCioCc6H5ESRtOUJNo3u9I3NatUhzr9FskoqmSyhlPqKWZm1LKLKijfMH1VvuR7PEya8GQDPyMrOzHM7ig=
X-Received: by 2002:a05:622a:1303:b0:3f8:5b2:aeed with SMTP id
 v3-20020a05622a130300b003f805b2aeedmr603740qtk.21.1692076849682; Mon, 14 Aug
 2023 22:20:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230808171446.2187795-1-mshavit@google.com> <20230809011204.v5.5.I219054a6cf538df5bb22f4ada2d9933155d6058c@changeid>
 <20230809134959.GB4226@willie-the-truck> <CAKHBV25CQYfqm80a1ztHXn3s6kj7KCuJBwJz4EZk5cog4n6R+A@mail.gmail.com>
 <20230810144051.GD5795@willie-the-truck> <ZNUEuIlPmrckwMyn@nvidia.com>
In-Reply-To: <ZNUEuIlPmrckwMyn@nvidia.com>
From:   Michael Shavit <mshavit@google.com>
Date:   Tue, 15 Aug 2023 13:20:04 +0800
Message-ID: <CAKHBV24SLBNw-yWn3m6BtvvHUgD0h1e1QkEb1LrUcWSwpR85Yg@mail.gmail.com>
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

On Thu, Aug 10, 2023 at 11:39=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> w=
rote:
>
> Actually, I don't think this even works as nothing on the PASID path
> adds to the list that arm_smmu_write_ctx_desc_devices() iterates over ??
>
> Then the remaining two calls:
>
> arm_smmu_share_asid(struct mm_struct *mm, u16 asid)
>         arm_smmu_write_ctx_desc_devices(smmu_domain, 0, cd);
>
>         This is OK only if the sketchy assumption that the CD
>         we extracted for a conflicting ASID is not asigned to a PASID.
>
> static void arm_smmu_mm_release(struct mmu_notifier *mn, struct mm_struct=
 *mm)
>         arm_smmu_write_ctx_desc_devices(smmu_domain, mm->pasid, &quiet_cd=
);
>
>         This doesn't work because we didn't add the master to the list
>         during __arm_smmu_sva_bind and this path is expressly working
>         on the PASID binds, not the RID binds.

Actually it is working on the RID attached domain (as returned by
iommu_get_domain_for_dev() at sva_bind time) not the SVA domain
here... The arm SVA implementation completely dismisses the SVA handle
(I also have a patch to fix this ;) .  Need to find the time to polish
and send out).
