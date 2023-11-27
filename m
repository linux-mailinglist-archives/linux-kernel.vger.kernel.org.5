Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACF3E7FA8A4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 19:11:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbjK0SLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 13:11:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbjK0SLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 13:11:15 -0500
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C12DA18F
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 10:11:21 -0800 (PST)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1f5da5df68eso2706267fac.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 10:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701108681; x=1701713481; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FZpnOthRbLnBBpEEWYgeGNsasjoY9FPd9WygBxdXcBw=;
        b=nPJanSQZiGVTomOTWDU5DKzD4yhTBbjNd1r0MG2BQnkWKVXV/T0oWa4702h87Wn9H9
         1232RmOeDGiornw93ObLwcxyRTkD6GxEs9u3+Nm2oqoGg8Bgy1UXfuhRP/JQXBEIA9ul
         OPYobEhroe+CcXoGXRUs3xFhTcIWUObTYDxCrAyTdPmviYFc9MFNqI6anVjCMoOUxoUY
         EtlidszMnYQEi24CS4izq5q9vTuMCln33n+6vTXN0Wxjp1aWqfAgKVZhgMbx4fDzv7yS
         MEDSMljKavTKll3V7V3ppuEhuJemrKmmiBTFGBSMqUiWA7hYvOLiN0Y1Q7oi2UfAXGkF
         dvwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701108681; x=1701713481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FZpnOthRbLnBBpEEWYgeGNsasjoY9FPd9WygBxdXcBw=;
        b=D7NjaUq0867as6KzlKQkuGlzxB1A+W+vTbBkYEqlRvtMNEBNuDO9p1QJjXXShqW1CQ
         BSBTnw97nL4YDYPtoVM/a9MrCd1fds9yM2h085F2/fjKthglEwPUmRB0HH767cyBfxhJ
         mE2Xyepw+eaONN/hOuMTTbfFigSTHzFVs0w4BdlGbjQkVxBMB+oTV+Bi37YcxRLC7OWG
         GSywIMCI1zYZbIaFUq6zPINYc6UnOIYtTTz9DwNklQoVMUnAT+XBB8PCCzUcISRUpbsz
         cLvxvcWGvjweCX86K5gJmhZMCZH9n8aDK+5j14YUysvsv8rucXGnXg6NqJQO7TTkYT1u
         tydw==
X-Gm-Message-State: AOJu0YxwUJuehPEhPuDLFm2mfBDR+ero+5vKOuFLh7T+UokYYSAK9w9E
        bHkictOxeF9PM0xYgtgWhhAktSEJZV4EgHJAcnI=
X-Google-Smtp-Source: AGHT+IEZ2Q1pPFFtrc4DZMkZZf1dFGfQfy1FQra1QFO0P3NVZ5tug31nYbbhrMJlHAIRN8Cg98fI5rZIWVMyELuwYFY=
X-Received: by 2002:a05:6870:8092:b0:1f9:6247:4d05 with SMTP id
 q18-20020a056870809200b001f962474d05mr15112722oab.22.1701108681026; Mon, 27
 Nov 2023 10:11:21 -0800 (PST)
MIME-Version: 1.0
References: <CABXGCsNRb0QbF2pKLJMDhVOKxyGD6-E+8p-4QO6FOWa6zp22_A@mail.gmail.com>
 <CABXGCsOqbLRHSkiz79NkVQ-wUtR7y-ZFHvhMw0+JJ_cY2AZmSw@mail.gmail.com>
 <CABXGCsPE9=Qp3Jg5hkRsTQoNgODnS_cXFU1d+hg3Baob40AaAA@mail.gmail.com>
 <edc5b75b-c08d-4c62-ae5e-089ffac27772@amd.com> <CABXGCsO=pdxorK9pO7qBPJM-xvgPPtpZqxLvQO4t2AK5qW3vcA@mail.gmail.com>
 <DM8PR12MB5400EAB81E5FA10F4309A732D1B1A@DM8PR12MB5400.namprd12.prod.outlook.com>
In-Reply-To: <DM8PR12MB5400EAB81E5FA10F4309A732D1B1A@DM8PR12MB5400.namprd12.prod.outlook.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 27 Nov 2023 13:11:09 -0500
Message-ID: <CADnq5_P8aRkj340FtBJKsZDnV8iOCmdmCHDWKHGca+4UtfNy1A@mail.gmail.com>
Subject: Re: regression/bisected/6.7rc1: Instead of desktop I see a horizontal
 flashing bar with a picture of the desktop background on white screen
To:     "Lee, Alvin" <Alvin.Lee2@amd.com>
Cc:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        "Mahfooz, Hamza" <Hamza.Mahfooz@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Wheeler, Daniel" <Daniel.Wheeler@amd.com>,
        "Wu, Hersen" <hersenxs.wu@amd.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
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

On Wed, Nov 15, 2023 at 1:52=E2=80=AFPM Lee, Alvin <Alvin.Lee2@amd.com> wro=
te:
>
> [AMD Official Use Only - General]
>
> This change has a DMCUB dependency - are you able to update your DMCUB ve=
rsion as well?
>
> This version mismatch issue is something I'll need to fix in driver for L=
inux.

@Mahfooz, Hamza @Alvin Lee any update on a fix for this?

Thanks,

Alex

>
> Thanks,
>
> Alvin
>
> -----Original Message-----
> From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
> Sent: Wednesday, November 15, 2023 1:22 PM
> To: Mahfooz, Hamza <Hamza.Mahfooz@amd.com>
> Cc: Lee, Alvin <Alvin.Lee2@amd.com>; Wu, Hersen <hersenxs.wu@amd.com>; Wh=
eeler, Daniel <Daniel.Wheeler@amd.com>; Deucher, Alexander <Alexander.Deuch=
er@amd.com>; Linux List Kernel Mailing <linux-kernel@vger.kernel.org>; amd-=
gfx list <amd-gfx@lists.freedesktop.org>
> Subject: Re: regression/bisected/6.7rc1: Instead of desktop I see a horiz=
ontal flashing bar with a picture of the desktop background on white screen
>
> On Wed, Nov 15, 2023 at 11:14=E2=80=AFPM Hamza Mahfooz <hamza.mahfooz@amd=
.com> wrote:
> >
> > What version of DMUB firmware are you on?
> > The easiest way to find out would be using the following:
> >
> > # dmesg | grep DMUB
> >
>
> Sapphire AMD Radeon RX 7900 XTX PULSE OC:
> =E2=9D=AF dmesg | grep DMUB
> [   14.341362] [drm] Loading DMUB firmware via PSP: version=3D0x07002100
> [   14.725547] [drm] DMUB hardware initialized: version=3D0x07002100
>
> Reference GIGABYTE Radeon RX 7900 XTX 24G:
> =E2=9D=AF dmesg | grep DMUB
> [   11.405115] [drm] Loading DMUB firmware via PSP: version=3D0x07002100
> [   11.773395] [drm] DMUB hardware initialized: version=3D0x07002100
>
>
> --
> Best Regards,
> Mike Gavrilov.
