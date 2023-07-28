Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB077665CB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 09:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233969AbjG1Hxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 03:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232496AbjG1Hxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 03:53:33 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986E2173F
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 00:53:32 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-40550136e54so220961cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 00:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690530812; x=1691135612;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FCkZl/qhv7Jne5YDBQ8ejzDwVZoTpLAS727QSMzp5Q0=;
        b=6fRRzIgSr85C86YxYuL3k72o/nG8Mz4C+lKlI3SrmzNHHvxxXkuNFPFBKeQ7TX6VT9
         qMWsGVOWBFZVuLPp4/jM6QV7f8kQsZIFy96EvVrmlJaNQOOi1ZHYPWmDicqh56k6QJbh
         qkxivVEgMFSRvkk4j2T/8djCvq2aX5q/T3qW17eojfahjzOLwUuR3i/2WYu5a/ZTpe5o
         Puw9HSdiZpO8SMxTZh7Q+Ha+D5d2n65k22wFvXf/3vHDhlUYQxQapBcUUk0J6c9v1EGi
         Oa9LgN65HyW8juGw72UI70gy6wpeQu5j4alDiL7mRo1OYRevd7VLzs0Xj2Vqi0vFNgVp
         Ex8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690530812; x=1691135612;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FCkZl/qhv7Jne5YDBQ8ejzDwVZoTpLAS727QSMzp5Q0=;
        b=PA/Tvf7bpgwoLD7zUmihfBjugLTAvTImT/2VN6H+moXDMBVnQVKzNp7loVgI9RWgoL
         HQSlV1dhMLE1p/dH0mfIzPJREJ5iiYWCqdwRdXGCfpGRm5I1gjcgcdH15ovTXN4wcQT0
         61YTL7QElTZnOuZMaC7KwXvsInsCstpcmmLZEktpTWUnOVFF7JDE9HRyh/ne+DYsoKvF
         //MEifEVbYmqEQUe64ZDz17Yz/K41VTj9q10mb+14dIV2IUf/JCBnfgaxoUOo4mcFxC3
         bjzdX9j5kagX0pEnNcd8STOJmQWY0U7hk+X36Ci3hzLj36F/mBM4rL5pGw6dmMZxB0mm
         FN/g==
X-Gm-Message-State: ABy/qLaWQjdw9qbV3oXyMGC9xEjJoc3vH8JtVzgSe/BcCeYFZt+mhMNG
        Rz5g6Tl/8tHBjR9S46tMcvcpq4BFY95wb4zIvX4pHg==
X-Google-Smtp-Source: APBJJlGD+SwyVD2EOuZnO4UoKoOOcE6/ENbNmOzXdUfuF/X+GQBYzXEFu/reLSXEl57dPRqhCmrPVZzVmXxy62vjJUk=
X-Received: by 2002:a05:622a:1a18:b0:403:b6ff:c0b with SMTP id
 f24-20020a05622a1a1800b00403b6ff0c0bmr216044qtb.6.1690530811464; Fri, 28 Jul
 2023 00:53:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230727182647.4106140-1-mshavit@google.com> <20230727182647.4106140-8-mshavit@google.com>
 <ZMK60wm3BBk038r7@nvidia.com>
In-Reply-To: <ZMK60wm3BBk038r7@nvidia.com>
From:   Michael Shavit <mshavit@google.com>
Date:   Fri, 28 Jul 2023 15:52:55 +0800
Message-ID: <CAKHBV24U3ekA9vFbh1_ZzO88qkozxVnwP=AMkNkbDnSTH3o_dw@mail.gmail.com>
Subject: Re: [PATCH v1 7/7] iommu/arm-smmu-v3: Move CD table to arm_smmu_master
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, jean-philippe@linaro.org,
        nicolinc@nvidia.com, baolu.lu@linux.intel.com,
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

On Fri, Jul 28, 2023 at 2:43=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Fri, Jul 28, 2023 at 02:26:23AM +0800, Michael Shavit wrote:
> > Each master is now allocated a CD table at probe time,
>
> Currently it is allocated during arm_smmu_domain_finalise_s1(), so it
> isn't allocated at probe time.

Urh right, I meant that this patch moves the allocation to the probe,
but that was misleading wording for sure.

> I think the right place to put the allocation is during the attach op,
> the first time we need a CD table then go and allocate it. If we can't
> then domain attach fails with -ENOMEM.
>
> Then you can put the free in a detach op once the CD table becomes
> empty and it behaves much like it already does.

Hmmm fair. I can't think of a reason that the table *must* be
pre-allocated for the PASID feature, and that could always be a
different commit if it turns out to be necessary.
