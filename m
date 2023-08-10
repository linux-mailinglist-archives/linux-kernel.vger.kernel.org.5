Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADA90777310
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 10:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234094AbjHJIfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 04:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233074AbjHJIfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 04:35:17 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC25D1BFA
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 01:35:16 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-407db3e9669so151021cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 01:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691656516; x=1692261316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+3gXvxbsF3hbjyqhSFUxSmTV+V3aM7IChf6I/fMQUak=;
        b=yPzXBhaOWEa3FxLqIQWK8lADdlX6+gZ9CK6KhlXR8ba/xUuAd2bG4WAoXK5YWI/Wjv
         QpLAkrJ8hZAO+aWBWudsJCfpHZvDTdl1FWqyBStvZcR7vbV8ZDGMZ/6SAG5srES7FNVK
         eprQmkYEY7cPdXkun2KuewHyoVZcxZgTBrk/+Jcw48cAtJf+jqyT3Q+NiKbCHOI9c0KI
         pn8st/Qlm3w5tSYo/6M5apn6eD5k6/P9TGRUwDiJkUAEx/EFVc3lrHDWPaum0ACAobW+
         qo4EokrW2x6sSpjRAGtCKi0A60+etXCWCr+vUCQ5ggmwpJsiAN/RIKmr7lzl80+Sh868
         /l9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691656516; x=1692261316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+3gXvxbsF3hbjyqhSFUxSmTV+V3aM7IChf6I/fMQUak=;
        b=NeTBTWk0iqzImo9kaxLbEfXvxztQZ2W/JEfC3aDssc4y2FnHr+KOGqJhRcNxQ/cwTu
         FqebRbDgNTBS847aYFzrvrLONC4olA25OvjbPgY0pzzORc2qXlYteltY5TKIlhz7I0ro
         oCi8eFZOb30X4MSOO9f8W7tH4DxscNXGIFR1uRydIdT9EErPWmI3MzKpAawwY0HiL5dE
         FXbbrFFvBvIU3m1fVwR6z1zqgr173HUidxSs94vcF+gjYvjBiPJZgWQhIfumFpLHjcNE
         UB4j2DE2T9tabUnRlbLJAA2xM7qIIVCIahQNKgx8+WP0k72EOshGXaLKoMeyEjh3i+TB
         FQCg==
X-Gm-Message-State: AOJu0YwRliEI4uglpCRJ10ZrrvYmlAPWP00pI7R0rBhFnDN5VyFeBDPt
        ZqXwe1GXLxafiWGO/toDiaEGaIY9hAnh3fEkwKIVDQ==
X-Google-Smtp-Source: AGHT+IFxpNbZVu1dU4nlN6JPB2xhhbodYZqhZaA7pE4MX5CWbmDuBfSFu+1BuT5QEUOIoNvJithVfpgaD30fXUd1Fz8=
X-Received: by 2002:ac8:4e51:0:b0:3fa:45ab:22a5 with SMTP id
 e17-20020ac84e51000000b003fa45ab22a5mr394510qtw.27.1691656515814; Thu, 10 Aug
 2023 01:35:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230808171446.2187795-1-mshavit@google.com> <20230809011204.v5.8.Idedc0f496231e2faab3df057219c5e2d937bbfe4@changeid>
 <20230809135011.GC4226@willie-the-truck>
In-Reply-To: <20230809135011.GC4226@willie-the-truck>
From:   Michael Shavit <mshavit@google.com>
Date:   Thu, 10 Aug 2023 16:34:39 +0800
Message-ID: <CAKHBV27LROax9-biR4ius2sXBYM+oJA82GTxsBo_LCd6zxVNgA@mail.gmail.com>
Subject: Re: [PATCH v5 8/9] iommu/arm-smmu-v3: Skip cd sync if CD table isn't active
To:     Will Deacon <will@kernel.org>
Cc:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, robin.murphy@arm.com,
        nicolinc@nvidia.com, jgg@nvidia.com, jean-philippe@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 9, 2023 at 9:50=E2=80=AFPM Will Deacon <will@kernel.org> wrote:
>
> On Wed, Aug 09, 2023 at 01:12:04AM +0800, Michael Shavit wrote:
> > This commit explicitly keeps track of whether a CD table is installed i=
n
> > an STE so that arm_smmu_sync_cd can skip the sync when unnecessary. Thi=
s
> > was previously achieved through the domain->devices list, but we are
> > moving to a model where arm_smmu_sync_cd directly operates on a master
> > and the master's CD table instead of a domain.
>
> Why is this path worth optimising?

I have no idea what the practical impact of this optimization is, but
the motivation here was to make the overall series as close to a nop
as possible. This optimization existed before but is "broken" by the
previous patch. This patch restores it.

> Doesn't this interact badly with the sync in arm_smmu_detach_dev(), which=
 I
> think happens after zapping the STE?

The arm_smmu_write_ctx_desc call added in arm_smmu_detach_dev() was
inserted after zapping the STE precisely so that we could skip the
sync. Is there a concern that a stale CD could be used when the
CDtable is re-inserted into the STE?

> >               /*
> > -              * STE is live, and the SMMU might read dwords of this CD=
 in any
> > +              * STE may be live, and the SMMU might read dwords of thi=
s CD in any
> >                * order. Ensure that it observes valid values before rea=
ding
> >                * V=3D1.
> >                */
>
> Why does this patch need to update this comment?

This is a drive-by to make this comment more accurate. Note how
(before this patch series) arm_smmu_domain_finalise_s1 explicitly
mentions that it calls arm_smmu_write_ctx_desc while the STE isn't
installed yet. Yet this comment asserts the STE *is* live.
