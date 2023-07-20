Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B565C75B3FC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 18:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjGTQQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 12:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbjGTQQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 12:16:55 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C78E75
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 09:16:53 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id 006d021491bc7-5658573b1faso632584eaf.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 09:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689869813; x=1690474613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zplp2bhBZky4Squ0pXFd83tGtm8GV3nyjQWPNcN7AR4=;
        b=JoSeKiDK56FbZFVZu7TXcmkrCwjHKQQTcKFPBSiXHsCe2e6GDwDWovtVfteYXy9uoD
         CHcizBbXkboZTck4mXhABMQhEAfo2W9kOPBA0GZgR1rWKaA4ePdZgyOPDbLxZlYvPVvr
         +yHCIgr4FiNvaV1akSw7nRgUVlYfmOmmlvxoS66bBXyyko5iL7rowG/hNQR1H96Xhjoz
         3j3BubVdze3zzP806rkwJlnvEVuTD4D3VIdboXKqjOtREhayseNsK1AijD3BXdcuSgO1
         /BHLCI+QuP6StkOJTUnfIS9SiR68TiaoiiB9qzmlq2gLh7tpNscDJfXg0SQBhheTBu/H
         on+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689869813; x=1690474613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zplp2bhBZky4Squ0pXFd83tGtm8GV3nyjQWPNcN7AR4=;
        b=EnhXQjYm9easgMApbYt417+P8vY1W5wOT5neHXDOHms+FdbGdoMPM+lYxuFE7FuNfN
         pFKfJyz2xRei84MwqVLBS/+rkqQFsWCofdKv98EEJGeZ/8UJIQ6eIOhdQWqBWLVJ+fNf
         z+bJwY88fMSaVda+pPZr1WrhRaiKuzyv7mzdK1JI2WZRdVWngPq1aYiWI4gFEy/t7o6P
         EHIVyISRUcdRShs3AzUKaecr2BjWnIh83brDghf2R+kTrdRDN7OXkFKgNy+VIf1KzJqv
         SqhY/Qpe+5G3ZQrkms6zBlaUOkQS1SbbvxhoFTxrn0Ff7laQ5CA+t0XS0zJJKBNKmfms
         +6Xw==
X-Gm-Message-State: ABy/qLZtonHybgIHhZNa97C8JU6Zy7YgCPZtStOpJ+2jqMIzP80fwHyA
        JY/4+TOtfxVLLKVYJVSpZJN5M/cXVk817qUitj0=
X-Google-Smtp-Source: APBJJlHPxwpvLcmzxvpZCJXCQSqwyr4vo54qVf7FXwF/N1UobpcY3kT97pZ3uoP7mJHu7P/J+Z3+No/tVKkf/zN5hHE=
X-Received: by 2002:a4a:4101:0:b0:567:867e:8702 with SMTP id
 x1-20020a4a4101000000b00567867e8702mr2619535ooa.7.1689869812970; Thu, 20 Jul
 2023 09:16:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230720010514.54342-1-yang.lee@linux.alibaba.com> <9d8254b2-2e68-2e4a-055a-5afdb04bd115@infradead.org>
In-Reply-To: <9d8254b2-2e68-2e4a-055a-5afdb04bd115@infradead.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 20 Jul 2023 12:16:41 -0400
Message-ID: <CADnq5_PL0umjvrPh3x3aM+HbZTrVqr+16C2J1eZ-P2U8aYYnAw@mail.gmail.com>
Subject: Re: [PATCH -next] drm/amdgpu: Fix one kernel-doc comment
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Yang Li <yang.lee@linux.alibaba.com>, alexander.deucher@amd.com,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

On Wed, Jul 19, 2023 at 9:27=E2=80=AFPM Randy Dunlap <rdunlap@infradead.org=
> wrote:
>
>
>
> On 7/19/23 18:05, Yang Li wrote:
> > Use colon to separate parameter name from their specific meaning.
> > silence the warning:
> >
> > drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c:793: warning: Function parame=
ter or member 'adev' not described in 'amdgpu_vm_pte_update_noretry_flags'
> >
> > Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
>
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> Thanks.
>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_vm_pt.c
> > index 83e1923f6775..96d601e209b8 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> > @@ -783,7 +783,7 @@ int amdgpu_vm_pde_update(struct amdgpu_vm_update_pa=
rams *params,
> >  /**
> >   * amdgpu_vm_pte_update_noretry_flags - Update PTE no-retry flags
> >   *
> > - * @adev - amdgpu_device pointer
> > + * @adev: amdgpu_device pointer
> >   * @flags: pointer to PTE flags
> >   *
> >   * Update PTE no-retry flags when TF is enabled.
>
> --
> ~Randy
