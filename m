Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CCAB7826E4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 12:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234565AbjHUKQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 06:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234597AbjHUKQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 06:16:47 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 992B8DC
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 03:16:45 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-40c72caec5cso384461cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 03:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692613005; x=1693217805;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4DBlaKc14FwN7oz3yb3olsvOOqmt5j3x+R4hTmIZQs4=;
        b=FNcTkll9b2OQnSTIUj9oooC6DOgVDY8CQJjvh4hSROYjpLVwHPXk7BIiBc9Zn2rfN5
         zmFhMetAOKN0N37o+cGuNKUqpt1wAHDI4+v+2rCPEOp/5H6Cht28SKNI7cKyUY3JrlIS
         5JxoxqftTexzBMTLrfBoxvUTfqxmtMCG6DWOIvUlsiX2PE0V61D68jCp5dmDKTv78pqG
         +SH05jm2peGOBr/AuRQUFmMu12SV3O+9bpGtuc2F4aGp3ry/+ciQ+j7C1FAV5C9jM23B
         BK4ogzi7gUmt/QEESoJ6PZTooygwHo2Xh8Sri2f3FVx6EEcON+rHIO3t6K82FHBWDtFS
         IOyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692613005; x=1693217805;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4DBlaKc14FwN7oz3yb3olsvOOqmt5j3x+R4hTmIZQs4=;
        b=UMIdj1xRLHbcImzZzm83eTHheUEieTuPJZk4SGRfcv/RC96DH49l1smr7EH2wouE/y
         9gb+5nO5Jb+gNPYVeJPIVVtBKf0WbuVrCUuMPawHxF3QXSrKE6Bujxi90srSYJDprPU+
         Z6ETr3baCZFs69A+GIPDGwP4XNdxXT6IZ8uhy76hH9GYzGtYIMf4zdjGeM1msoJqsqxz
         LWTkHpuVh46qf6+bq5ca6RoanRadicH1T+EVUkjuUiqkwg4jBHYKXGxQrwL1vcuk9WLV
         iAKkbuRJrMZK6RD1HDHqWhk2mBkbVwL8o64EDFXFBZBGK/ywsp7wAJNUAA0OvIQAZOiW
         2DWA==
X-Gm-Message-State: AOJu0YyJCefHuNgBFSrFtspeQxkA7e9uUJAy2sfVLevcIMF1ys4M0LEc
        0fP328U2GtDBaN49kIIVPck2BjF6VjeeAsAZ3d3EBA==
X-Google-Smtp-Source: AGHT+IHR+XOAWuayL0J0548thwTL5vNN/km9VwmcCAbpWlgoxTxZq9SZ2XoemRnY4jNkovDAtrOPYb+nUZ2rZU01heI=
X-Received: by 2002:ac8:5703:0:b0:403:f5b8:2bd2 with SMTP id
 3-20020ac85703000000b00403f5b82bd2mr444300qtw.9.1692613004602; Mon, 21 Aug
 2023 03:16:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230816131925.2521220-1-mshavit@google.com> <20230816211849.v6.9.Idedc0f496231e2faab3df057219c5e2d937bbfe4@changeid>
In-Reply-To: <20230816211849.v6.9.Idedc0f496231e2faab3df057219c5e2d937bbfe4@changeid>
From:   Michael Shavit <mshavit@google.com>
Date:   Mon, 21 Aug 2023 18:16:08 +0800
Message-ID: <CAKHBV274tBz2ydskRfghR2C_u-ibxh9MuEn3dGSaS7tGm8FuTQ@mail.gmail.com>
Subject: Re: [PATCH v6 09/10] iommu/arm-smmu-v3: Skip cd sync if CD table
 isn't active
To:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>
Cc:     robin.murphy@arm.com, jean-philippe@linaro.org, jgg@nvidia.com,
        nicolinc@nvidia.com
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

On Wed, Aug 16, 2023 at 9:20=E2=80=AFPM Michael Shavit <mshavit@google.com>=
 wrote:
>
> This commit explicitly keeps track of whether a CD table is installed in
> an STE so that arm_smmu_sync_cd can skip the sync when unnecessary. This
> was previously achieved through the domain->devices list, but we are
> moving to a model where arm_smmu_sync_cd directly operates on a master
> and the master's CD table instead of a domain.
>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Michael Shavit <mshavit@google.com>
> ---
> Happy to drop this commit if we don't think it's useful.

Hi Will,
Do you have any recommendations for keeping or dropping this commit in
the end? It's only purpose is to minimize any potential performance
impact from the refactor but can certainly be dropped if you don't
think it's worth the complication.
