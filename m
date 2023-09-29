Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC3AA7B3A4C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 20:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233866AbjI2S5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 14:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233321AbjI2S5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 14:57:13 -0400
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B128CCB
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 11:57:09 -0700 (PDT)
Received: by mail-vk1-xa2c.google.com with SMTP id 71dfb90a1353d-493a661d7b6so679267e0c.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 11:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1696013828; x=1696618628; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PfGmlUOH9WqPWnLVrZOgqHtX/zXmyHSs19G+T4XU/J4=;
        b=x4Juh4W/zt/bFPDb6FJqxMcAy7g+7e6UTSZmacRw/ePZHxl5zNDC65v/f0oifdQtXs
         PB6uMPprbdeIUqmY43eZRP6u13+Cfjlxo3mkoi0ZYAdJvRfXwVkhKKxcwzZOQITUbD8u
         XTEW3PeGZ2gkp2fBl5ok7yp6/9L8hMR+k0Ac30UiifhU89PLFOH9ED9pUhEoAMuF0Vg4
         7iNb49LVG6AwbOU5/+NKkNlh7ewcuI+IJKmZIWJkI88Kp9fAzQ4qDWQjMxnwZRygBvuF
         QiYlpojXzs4C8XY8ne6jwEr6t6B4FkMN7J3tY3SvyAvEHKkBx/3PUJtE2MQPHExnb6iQ
         KanQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696013828; x=1696618628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PfGmlUOH9WqPWnLVrZOgqHtX/zXmyHSs19G+T4XU/J4=;
        b=gTiPzqjS0gpx0Gjbrp15SgDv+o+/48jhIya02dIbUhJRmhXl/ISrNTrOvRVl7EUJxN
         NxL8t4RVGsi6Vw+6Ot4ifMWtkVqtBHAzCa2gqEru8NV/f2wMpFnM/X7eoowJUFcHie92
         TKuFRZVa0eU3ukKX0YV9/35NsQ99THVz39eRH+3bqDMVWB1UzQPlUbuGXmn+dVg6qkwK
         tg43O4iGawyiKrza+4bsgGKF/wc2zxqX91Rw5fJtkCfdWXE1YNeRKht1nBBu3mZ/PoyV
         wq956zlC/0E1IdBWSQkKXoGNQx3lX8E+LmfhqY5QR2Ps8biOVlYWbtVC/8a7pp+eRLlF
         U9eQ==
X-Gm-Message-State: AOJu0YydMY3IeAocJoWzWeF+aVYKtlKlP+wenIbza/OcfqLyFEnDX0HS
        2/KCTvNFWuiIY2hRCbpyWwdmnAdzeI3XZs7kJ7wfRw==
X-Google-Smtp-Source: AGHT+IH3FssCml86EbKEbG65HknTNtIiiRcy1+dyinuD+hUUafhGYqMCdeajRJt0KLvuWhLlY6n/w6UUQ1DWLDbxrRw=
X-Received: by 2002:a1f:4985:0:b0:496:187e:b33f with SMTP id
 w127-20020a1f4985000000b00496187eb33fmr2570041vka.3.1696013828344; Fri, 29
 Sep 2023 11:57:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230928092040.9420-1-brgl@bgdev.pl> <rb3xf7pumyegck2reyj73sfnpgeyr3sufgcycteozpquah5py4@jpjvcwy5k2kz>
In-Reply-To: <rb3xf7pumyegck2reyj73sfnpgeyr3sufgcycteozpquah5py4@jpjvcwy5k2kz>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 29 Sep 2023 20:56:57 +0200
Message-ID: <CAMRc=Md1upfk8FAWDMYi-+Z4qwVyiFV=PT6-uCrwAMb00NhvvA@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] arm64: qcom: add and enable SHM Bridge support
To:     Andrew Halaney <ahalaney@redhat.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        kernel@quicinc.com,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2023 at 5:29=E2=80=AFPM Andrew Halaney <ahalaney@redhat.com=
> wrote:
>
> On Thu, Sep 28, 2023 at 11:20:29AM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > This is technically the second iteration of the SHM Bridge enablement o=
n
> > QCom platforms but in practice it's a complete rewrite.
> >
> > During the internal discussion with QCom the requirement has been estab=
lished
> > as an SHM Bridge pool manager with the assumption that there will be mu=
ltiple
> > users, each with their own pool. The problem with this is that we don't=
 have
> > many potential users of SHM pools upstream at the moment which was righ=
tfully
> > pointed out in the reviews under v1 (which even had some unused symbols=
 etc.).
> >
> > Moreover: after some investigating, it turns out that there simply isn'=
t any
> > need for multiple pools as the core SCM only allocates a buffer if give=
n call
> > requires more than 4 arguments and there are only a handful of SCM call=
s that
> > need to pass a physical address to a buffer as argument to the trustzon=
e.
> >
> > Additionally all but one SCM call allocate buffers passed to the TZ onl=
y for
> > the duration of the call and then free it right aftr it returns. The on=
e
> > exception is called once and the buffer it uses can remain in memory un=
til
> > released by the user.
> >
> > This all makes using multiple pools wasteful as most of that memory wil=
l be
> > reserved but remain unused 99% of the time. What we need is a single po=
ol of
> > SCM memory that deals out chunks of suitable format (coherent and
> > page-aligned) that fulfills the requirements of all calls.
> >
> > As not all architectures support SHM bridge, it makes sense to first un=
ify the
> > memory operations in SCM calls. All users do some kind of DMA mapping t=
o obtain
> > buffers, most using dma_alloc_coherent() which impacts performance.
> >
> > Genalloc pools are very fast so let's use them instead. Create a custom
> > allocator that also deals with the mapping and use it across all SCM ca=
lls.
> >
> > Then once this is done, let's extend the allocator to use the SHM bridg=
e
> > functionality if available on the given platform.
> >
> > While at it: let's create a qcom specific directory in drivers/firmware=
/ and
> > move relevant code in there.
> >
> > I couldn't test all SCM calls but tested with the inline crypto engine =
on
> > sm8550 and sa8775p that runs most of new code paths (with and without S=
HM
> > bridge). At least qseecom would need some Tested-by.
>
> I have been playing around with this on my x13s (sc8280xp). It seems
> that efivars works ok (and therefore the qseecom stuff I believe), but
> with these patches applied I'm getting -22 when loading any firmware.
>
> I'll try to dig a little more, but thought I'd report that before I
> context switch for a little bit.
>
>     dmesg | grep "firmware\|-22"
>     [    0.000000] psci: PSCIv1.1 detected in firmware.
>     [    2.351999] qcom_scm firmware:scm: SHM Bridge enabled
>     [    2.353002] qcom_scm firmware:scm: qseecom: found qseecom with ver=
sion 0x1402000
>     [    6.727604] systemd[1]: systemd-pcrmachine.service - TPM2 PCR Mach=
ine ID Measurement was skipped because of an unmet condition check (Conditi=
onPathExists=3D/sys/firmware/efi/efivars/StubPcrKernelImage-4a67b082-0a4c-4=
1cf-b6c7-440b29bb8c4f).
>     [    8.198381] qcom_q6v5_pas 1b300000.remoteproc: error -22 initializ=
ing firmware qcom/sc8280xp/LENOVO/21BX/qccdsp8280.mbn
>     [    8.198418] remoteproc remoteproc1: can't start rproc 1b300000.rem=
oteproc: -22
>     [    8.407641] qcom_q6v5_pas 3000000.remoteproc: error -22 initializi=
ng firmware qcom/sc8280xp/LENOVO/21BX/qcadsp8280.mbn
>     [    8.407742] remoteproc remoteproc0: can't start rproc 3000000.remo=
teproc: -22
>     [    8.588496] adreno 3d00000.gpu: error -22 initializing firmware qc=
om/sc8280xp/LENOVO/21BX/qcdxkmsuc8280.mbn
>     [    8.588509] msm_dpu ae01000.display-controller: [drm:adreno_load_g=
pu [msm]] *ERROR* gpu hw init failed: -22
>     [    9.392185] ath11k_pci 0006:01:00.0: fw_version 0x110b196e fw_buil=
d_timestamp 2022-12-22 12:54 fw_build_id WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V=
2_SILICONZ_LITE-3.6510.23
>     [   10.229367] adreno 3d00000.gpu: error -22 initializing firmware qc=
om/sc8280xp/LENOVO/21BX/qcdxkmsuc8280.mbn
>     [   10.229383] msm_dpu ae01000.display-controller: [drm:adreno_load_g=
pu [msm]] *ERROR* gpu hw init failed: -22
>     [   11.041385] adreno 3d00000.gpu: error -22 initializing firmware qc=
om/sc8280xp/LENOVO/21BX/qcdxkmsuc8280.mbn
>     [   11.041399] msm_dpu ae01000.display-controller: [drm:adreno_load_g=
pu [msm]] *ERROR* gpu hw init failed: -22
>     [   11.070144] adreno 3d00000.gpu: error -22 initializing firmware qc=
om/sc8280xp/LENOVO/21BX/qcdxkmsuc8280.mbn
>     [   11.070160] msm_dpu ae01000.display-controller: [drm:adreno_load_g=
pu [msm]] *ERROR* gpu hw init failed: -22
>     [   11.321999] adreno 3d00000.gpu: error -22 initializing firmware qc=
om/sc8280xp/LENOVO/21BX/qcdxkmsuc8280.mbn
>     [   11.322015] msm_dpu ae01000.display-controller: [drm:adreno_load_g=
pu [msm]] *ERROR* gpu hw init failed: -22
>     [   11.340989] adreno 3d00000.gpu: error -22 initializing firmware qc=
om/sc8280xp/LENOVO/21BX/qcdxkmsuc8280.mbn
>     [   11.341002] msm_dpu ae01000.display-controller: [drm:adreno_load_g=
pu [msm]] *ERROR* gpu hw init failed: -22
>     [   11.576180] adreno 3d00000.gpu: error -22 initializing firmware qc=
om/sc8280xp/LENOVO/21BX/qcdxkmsuc8280.mbn
>     [   11.576198] msm_dpu ae01000.display-controller: [drm:adreno_load_g=
pu [msm]] *ERROR* gpu hw init failed: -22
>     [   11.593647] adreno 3d00000.gpu: error -22 initializing firmware qc=
om/sc8280xp/LENOVO/21BX/qcdxkmsuc8280.mbn
>     [   11.593661] msm_dpu ae01000.display-controller: [drm:adreno_load_g=
pu [msm]] *ERROR* gpu hw init failed: -22
>     [   11.854212] adreno 3d00000.gpu: error -22 initializing firmware qc=
om/sc8280xp/LENOVO/21BX/qcdxkmsuc8280.mbn
>     [   11.854226] msm_dpu ae01000.display-controller: [drm:adreno_load_g=
pu [msm]] *ERROR* gpu hw init failed: -22
>     [   11.879925] adreno 3d00000.gpu: error -22 initializing firmware qc=
om/sc8280xp/LENOVO/21BX/qcdxkmsuc8280.mbn
>     [   11.879937] msm_dpu ae01000.display-controller: [drm:adreno_load_g=
pu [msm]] *ERROR* gpu hw init failed: -22
>     [   12.157090] adreno 3d00000.gpu: error -22 initializing firmware qc=
om/sc8280xp/LENOVO/21BX/qcdxkmsuc8280.mbn
>     [   12.157106] msm_dpu ae01000.display-controller: [drm:adreno_load_g=
pu [msm]] *ERROR* gpu hw init failed: -22
>     [   12.183074] adreno 3d00000.gpu: error -22 initializing firmware qc=
om/sc8280xp/LENOVO/21BX/qcdxkmsuc8280.mbn
>     [   12.183088] msm_dpu ae01000.display-controller: [drm:adreno_load_g=
pu [msm]] *ERROR* gpu hw init failed: -22
>
> Thanks,
> Andrew

Huh remoteproc seems to work fine on sm8550. Can you post the full
kernel log? Do you know which SCM calls fails?

Bart

> >
> > v1 -> v2:
> > - too many changes to list, it's a complete rewrite as explained above
> >
> > Bartosz Golaszewski (11):
> >   firmware: qcom: move Qualcomm code into its own directory
> >   firmware: qcom: scm: add a dedicated SCM memory allocator
> >   firmware: qcom: scm: switch to using the SCM allocator
> >   firmware: qcom: scm: make qcom_scm_assign_mem() use the SCM allocator
> >   firmware: qcom: scm: make qcom_scm_ice_set_key() use the SCM allocato=
r
> >   firmware: qcom: scm: make qcom_scm_pas_init_image() use the SCM
> >     allocator
> >   firmware: qcom: scm: make qcom_scm_lmh_dcvsh() use the SCM allocator
> >   firmware: qcom: scm: make qcom_scm_qseecom_app_get_id() use the SCM
> >     allocator
> >   firmware: qcom: qseecom: convert to using the SCM allocator
> >   firmware: qcom-scm: add support for SHM bridge operations
> >   firmware: qcom: scm: enable SHM bridge
> >
> >  MAINTAINERS                                   |   4 +-
> >  drivers/firmware/Kconfig                      |  48 +---
> >  drivers/firmware/Makefile                     |   5 +-
> >  drivers/firmware/qcom/Kconfig                 |  56 ++++
> >  drivers/firmware/qcom/Makefile                |   9 +
> >  drivers/firmware/{ =3D> qcom}/qcom_qseecom.c    |   0
> >  .../{ =3D> qcom}/qcom_qseecom_uefisecapp.c      | 251 ++++++----------=
--
> >  drivers/firmware/{ =3D> qcom}/qcom_scm-legacy.c |   0
> >  drivers/firmware/qcom/qcom_scm-mem.c          | 170 ++++++++++++
> >  drivers/firmware/{ =3D> qcom}/qcom_scm-smc.c    |  21 +-
> >  drivers/firmware/{ =3D> qcom}/qcom_scm.c        | 149 ++++++-----
> >  drivers/firmware/{ =3D> qcom}/qcom_scm.h        |   9 +
> >  include/linux/firmware/qcom/qcom_qseecom.h    |   4 +-
> >  include/linux/firmware/qcom/qcom_scm.h        |  13 +
> >  14 files changed, 427 insertions(+), 312 deletions(-)
> >  create mode 100644 drivers/firmware/qcom/Kconfig
> >  create mode 100644 drivers/firmware/qcom/Makefile
> >  rename drivers/firmware/{ =3D> qcom}/qcom_qseecom.c (100%)
> >  rename drivers/firmware/{ =3D> qcom}/qcom_qseecom_uefisecapp.c (84%)
> >  rename drivers/firmware/{ =3D> qcom}/qcom_scm-legacy.c (100%)
> >  create mode 100644 drivers/firmware/qcom/qcom_scm-mem.c
> >  rename drivers/firmware/{ =3D> qcom}/qcom_scm-smc.c (92%)
> >  rename drivers/firmware/{ =3D> qcom}/qcom_scm.c (94%)
> >  rename drivers/firmware/{ =3D> qcom}/qcom_scm.h (95%)
> >
> > --
> > 2.39.2
> >
>
