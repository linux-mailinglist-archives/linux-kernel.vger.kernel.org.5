Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5F9580CF4B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 16:18:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344175AbjLKPSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 10:18:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343993AbjLKPSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 10:18:03 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF5CEDF
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 07:18:09 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6d855efb920so3619690a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 07:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702307889; x=1702912689; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wvXAIFU3cHSe8gZFgZZL313yZ6BsbgxanKxV0o2G4D8=;
        b=XVHHl1DeaTo9BN1/qxgaJx7qQ9oBB7K6WPK2GNeYbvXBSy3XvYl+b7eRmGD6RBvi1B
         ZCGOwGlRCYm1axBSdGTr432TZC7xpqZLqtH0CgGUyLhTxYwZq5YjyjdRdQfFln3hgg6s
         smUotvaECqscUkJXHsS0o9rHr3O1+ByMnE8yCcLRd6T1HiSxB6gOD3bKvLqsGLFYetzw
         c1J1X/vK3MhGCCWHd/w6aObDqE5iyba8PAJfMWJI1mXwys7z8Px4RmLHVHgPTNiJMwJm
         zfnt0OTUpi2/xmb4fKblwFTDZtPAuo5q1xxHXf3dRcxWFmo4Gd5bnHwmM4u8sfSyKbiQ
         OSPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702307889; x=1702912689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wvXAIFU3cHSe8gZFgZZL313yZ6BsbgxanKxV0o2G4D8=;
        b=Wydj03KDKlcZ7tdWq6oJRnRw2kSa/oFj1L0wsjnKwnAc887d9KVb3ERcRsUTLrMDFA
         K0nY4vnpZlmGIISu39h9lLfwKPuNNGwUakk2kGh+7nyDWJdUBedh2aNl9SdP7cNdNrxf
         jnCOnYitn9H0MDLt+yLJrEEhYsdBBjsKu4wlad5lh6y5iF1aQposUyg/pWS4pFOPg2ng
         fcdS/WEwUAa3A0WiY11mV8hZoCw/wWQVb4FPA0q6f/nxzrpw6FBKmJiFwU7C1zb8DP+u
         nVR37Tw+bnn9wCMUvLJ26Z+qY1bW39QhsMzmX8e0l3OOPF1CpxiTW3yeHUutmu/WLIXP
         iC2g==
X-Gm-Message-State: AOJu0Yzdu+HUVzuDRr3uJHII3QKtepGxCNSkibN1FvrmJ96bfp5F8BNO
        4EGh4WZM2kpYHshJNtDax56Yjm4RI0/I7kIDGdCWRMad+/U=
X-Google-Smtp-Source: AGHT+IE6Pdq+QZOPZcT87hzEwOyfLxxsaDNBp8XrIaNN3aLL6Q2E3qAZa+aCTM/ghgMcR5Uq8on+1btr2EnnabaqbsI=
X-Received: by 2002:a05:6870:b154:b0:1fb:78d7:91b8 with SMTP id
 a20-20020a056870b15400b001fb78d791b8mr5975573oal.34.1702307889216; Mon, 11
 Dec 2023 07:18:09 -0800 (PST)
MIME-Version: 1.0
References: <20231122030621.3759313-1-samuel.holland@sifive.com>
 <20231122030621.3759313-4-samuel.holland@sifive.com> <20231123-headdress-mold-0dd7a74477f7@wendy>
 <20231130004224.GE2513828@dev-arch.thelio-3990X> <4f277982-fffb-4fe1-bc02-007633400f31@sifive.com>
 <5090a015-5b6f-44be-bb25-d2ca3fdf5d40@app.fastmail.com> <07d27191-12b6-4c84-b80e-75c618df9de4@sifive.com>
In-Reply-To: <07d27191-12b6-4c84-b80e-75c618df9de4@sifive.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 11 Dec 2023 10:17:57 -0500
Message-ID: <CADnq5_O+ozkwQAEn3K_=-pB2L0+pbc+tbPU0CEwOTa+QysogAg@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/amd/display: Support DRM_AMD_DC_FP on RISC-V
To:     Samuel Holland <samuel.holland@sifive.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        "Conor.Dooley" <conor.dooley@microchip.com>, llvm@lists.linux.dev,
        Leo Li <sunpeng.li@amd.com>, Pan Xinhui <Xinhui.Pan@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        amd-gfx@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        linux-riscv@lists.infradead.org,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_XBL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 10, 2023 at 5:10=E2=80=AFAM Samuel Holland
<samuel.holland@sifive.com> wrote:
>
> Hi Arnd,
>
> On 2023-12-09 2:38 PM, Arnd Bergmann wrote:
> > On Fri, Dec 8, 2023, at 06:04, Samuel Holland wrote:
> >> On 2023-11-29 6:42 PM, Nathan Chancellor wrote:
> >>> On Thu, Nov 23, 2023 at 02:23:01PM +0000, Conor Dooley wrote:
> >>>> On Tue, Nov 21, 2023 at 07:05:15PM -0800, Samuel Holland wrote:
> >>>>> RISC-V uses kernel_fpu_begin()/kernel_fpu_end() like several other
> >>>>> architectures. Enabling hardware FP requires overriding the ISA str=
ing
> >>>>> for the relevant compilation units.
> >>>>
> >>>> Ah yes, bringing the joy of frame-larger-than warnings to RISC-V:
> >>>> ../drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_v=
ba_32.c:58:13: warning: stack frame size (2416) exceeds limit (2048) in 'DI=
SPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalcula=
tion' [-Wframe-larger-than]
> >>>
> >>> :(
> >>>
> >>>> Nathan, have you given up on these being sorted out?
> >>>
> >>> Does your configuration have KASAN (I don't think RISC-V supports
> >>> KCSAN)? It is possible that dml/dcn32 needs something similar to comm=
it
> >>> 6740ec97bcdb ("drm/amd/display: Increase frame warning limit with KAS=
AN
> >>> or KCSAN in dml2")?
> >>>
> >>> I am not really interested in playing whack-a-mole with these warning=
s
> >>> like I have done in the past for the reasons I outlined here:
> >>>
> >>> https://lore.kernel.org/20231019205117.GA839902@dev-arch.thelio-3990X=
/
> >>
> >> I also see one of these with clang 17 even with KASAN disabled:
> >>
> >> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32=
.c:37:6:
> >> warning: stack frame size (2208) exceeds limit (2048) in 'dml32_recalc=
ulate'
> >> [-Wframe-larger-than]
> >> void dml32_recalculate(struct display_mode_lib *mode_lib)
> >>
> >>      ^
> >> 1532/2208 (69.38%) spills, 676/2208 (30.62%) variables
> >>
> >> So I'm in favor of just raising the limit for these files for clang, l=
ike you
> >> suggested in the linked thread.
> >
> > How about just adding a BUG_ON(IS_ENABLED(CONFIG_RISCV))
> > in that function? That should also avoid the build failure
> > but give a better indication of where the problem is
> > if someone actually runs into that function and triggers
> > a runtime stack overflow.
>
> Won't that break actual users of the driver, trading an unlikely but
> theoretically possible stack overflow for a guaranteed crash? The intent =
of this
> series is that I have one of these GPUs plugged in to a RISC-V board, and=
 I want
> to use it.

Does this patch address the issue?
https://gitlab.freedesktop.org/agd5f/linux/-/commit/72ada8603e36291ad91e4f4=
0f10ef742ef79bc4e

Alex
