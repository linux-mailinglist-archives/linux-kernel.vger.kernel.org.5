Return-Path: <linux-kernel+bounces-48363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7D2845AEB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:07:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1536FB2B176
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A577C6215E;
	Thu,  1 Feb 2024 15:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="mFjzsx5Z"
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC89A626C6
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 15:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706800023; cv=none; b=rNx+sFk1ZtsUd5/vHBgCIqAvUYWBdGwYq6dwIw1DAdjqNMIyNR03+6JHXoSxKfEmaB9lpZXUuDcfpSvefXlIDloOUunLyMszvdLiaHaA1vcQoAeBnSDnfLwU0e395Wtx8rTQEpGSpaUgutcKXa/B1mmUzHGN4dWzn4zkXG1V0LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706800023; c=relaxed/simple;
	bh=0S4hj/l+E8fsE2seDVwsBMXhR7T3oEgasUj3VCasABU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y10HSa0uHi4i6RvtHVWFpFVZ8W3a8qAaFywYWeyA04ZJ37npTps/mkRU0aZpReB5EA0zxuwviogyF0o+tkL/pgXfVEw7jXn2ha7N5WkZYRY1io4lhLT0pneuOSrd5OyC07viGEoeeg1xhdpPa3kr+GBIy8W7p4s8bkULk+MkXno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=mFjzsx5Z; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-7d2e1832d4dso509080241.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 07:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1706800019; x=1707404819; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pi8CL4e6ck2HTzkpX3NWKGudKljP6kgJIpvXQoGWMOY=;
        b=mFjzsx5ZgxHudLKcLanxLprPq0zmzRqkABqO66ISPmCfBYNYVvx6cnKjlVjI20kuR6
         OldRh+6izDGy3wqF3NTLdZ+soDWUeSAFbdbYEvGaUGR6pKuypJZ4bikvyToSJtCILL46
         Ndm3waRKAAUkJI6uunaQOJs5sea1DD1w7BRzuehwcoS4nhPgUukSgu3sAowUTNjUAQ/t
         6XfULaZsTvjMtdeCP/V9xUpF2jVifV9oBV66jx5EqTlZMH5Js+MjotzU3w+G+UlD6POS
         TcdHDS9ScnWTX1V7BGgDlUE79qhhysayrxTYPLDekaxaW3XnETTsU9lbURSGoxB3i4Kr
         fMFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706800019; x=1707404819;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pi8CL4e6ck2HTzkpX3NWKGudKljP6kgJIpvXQoGWMOY=;
        b=Sg6N+FqSYbH+eoE3Ix0cBvbWm1VR1p+kqpcx2XgPTPxWotP4SE7GnCClMG92mrGNFy
         o5Utes1vKL5wkskCnLptJmxuTeb2uh4fyr3OCVpsVCZ01ti0PEM9/9xZ40QQt1KvbxOv
         LsinnFv7DX+h49VaBGLgBE7pm1ShGW8cACO0u4iq6qj7ampB/JiE0Q/wXw9lMofgBaFE
         KZn3zX02Y1M5tILnjirZEaB5BYdxINuOX/WPshXH6cdSpir8sNZwN7mA3V3PHIX5iOAH
         C23Qa6qeNboeFYHZyfqXpyIzIhW/5FuQe/o3BWbC28469heNnPhvC7e+rbaLeDDdB6tJ
         Fmfg==
X-Gm-Message-State: AOJu0YySN0IAfgErM3IyuG4sN/JobQmv9k/gPp6LnjL3x+Ox37x7RZMi
	7gBi/brTumvpgGXHR/vqEFgmxra5m3rSLnTUahTCYrmVfO6IfZE7uHCsXv2tPGjHLOrj2515Ct3
	nu+Vz6wxktS3U9OeHNB70Geu3ruJr5sfx670V3A==
X-Google-Smtp-Source: AGHT+IEG5q+Ht07Sn9fefoBaUopYmurwwnmOpHyEtbhdBigl1iJ2zdTN4V4J9cZ4y2zMj9AA5AY9J15gI6CDwoltmeQ=
X-Received: by 2002:a05:6122:449a:b0:4bd:32c9:acb with SMTP id
 cz26-20020a056122449a00b004bd32c90acbmr2413468vkb.7.1706800019494; Thu, 01
 Feb 2024 07:06:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122102157.22761-1-brgl@bgdev.pl>
In-Reply-To: <20240122102157.22761-1-brgl@bgdev.pl>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 1 Feb 2024 16:06:47 +0100
Message-ID: <CAMRc=MfURBi=5frjL2EB0M-bzoiXU-5do+gtWDKqK9fp48HvXA@mail.gmail.com>
Subject: Re: [RESEND PATCH v6 00/12] arm64: qcom: add and enable SHM Bridge support
To: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Elliot Berman <quic_eberman@quicinc.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Guru Das Srinagesh <quic_gurus@quicinc.com>, Andrew Halaney <ahalaney@redhat.com>, 
	Maximilian Luz <luzmaximilian@gmail.com>, Alex Elder <elder@linaro.org>, 
	Srini Kandagatla <srinivas.kandagatla@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kernel@quicinc.com, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 11:22=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Resending after the merge window. I dropped the first patch which was a
> fix and was picked up last release cycle.
>
> We've established the need for using separate secured memory pools for
> SCM and QSEECOM as well as the upcoming scminvoke driver.
>
> It's also become clear that in order to be future-proof, the new
> allocator must be an abstraction layer of a higher level as the SHM
> Bridge will not be the only memory protection mechanism that we'll see
> upstream. Hence the rename to TrustZone Memory rather than SCM Memory
> allocator.
>
> Also to that end: the new allocator is its own module now and provides a
> Kconfig choice menu for selecting the mode of operation (currently
> default and SHM Bridge).
>
> Tested on sm8550 and sa8775p with the Inline Crypto Engine and
> remoteproc.
>
> v5 -> v6:
> Fixed two issues reported by autobuilders:
> - add a fix for memory leaks in the qseecom driver as the first patch for
>   easier backporting to the v6.6.y branch
> - explicitly cast the bus address stored in a variable of type dma_addr_t
>   to phys_addr_t expected by the genpool API
>
> v4 -> v5:
> - fix the return value from qcom_tzmem_init() if SHM Bridge is not suppor=
ted
> - remove a comment that's no longer useful
> - collect tags
>
> v3 -> v4:
> - include linux/sizes.h for SZ_X macros
> - use dedicated RCU APIs to dereference radix tree slots
> - fix kerneldocs
> - fix the comment in patch 14/15: it's the hypervisor, not the TrustZone
>   that creates the SHM bridge
>
> v2 -> v3:
> - restore pool management and use separate pools for different users
> - don't use the new allocator in qcom_scm_pas_init_image() as the
>   TrustZone will create an SHM bridge for us here
> - rewrite the entire series again for most part
>
> v1 -> v2:
> - too many changes to list, it's a complete rewrite as explained above
>
> Bartosz Golaszewski (12):
>   firmware: qcom: add a dedicated TrustZone buffer allocator
>   firmware: qcom: scm: enable the TZ mem allocator
>   firmware: qcom: scm: smc: switch to using the SCM allocator
>   firmware: qcom: scm: make qcom_scm_assign_mem() use the TZ allocator
>   firmware: qcom: scm: make qcom_scm_ice_set_key() use the TZ allocator
>   firmware: qcom: scm: make qcom_scm_lmh_dcvsh() use the TZ allocator
>   firmware: qcom: scm: make qcom_scm_qseecom_app_get_id() use the TZ
>     allocator
>   firmware: qcom: qseecom: convert to using the TZ allocator
>   firmware: qcom: scm: add support for SHM bridge operations
>   firmware: qcom: tzmem: enable SHM Bridge support
>   firmware: qcom: scm: clarify the comment in qcom_scm_pas_init_image()
>   arm64: defconfig: enable SHM Bridge support for the TZ memory
>     allocator
>
>  MAINTAINERS                                   |   8 +
>  arch/arm64/configs/defconfig                  |   1 +
>  drivers/firmware/qcom/Kconfig                 |  30 ++
>  drivers/firmware/qcom/Makefile                |   1 +
>  .../firmware/qcom/qcom_qseecom_uefisecapp.c   | 281 +++++---------
>  drivers/firmware/qcom/qcom_scm-smc.c          |  30 +-
>  drivers/firmware/qcom/qcom_scm.c              | 179 +++++----
>  drivers/firmware/qcom/qcom_scm.h              |   6 +
>  drivers/firmware/qcom/qcom_tzmem.c            | 365 ++++++++++++++++++
>  drivers/firmware/qcom/qcom_tzmem.h            |  13 +
>  include/linux/firmware/qcom/qcom_qseecom.h    |   4 +-
>  include/linux/firmware/qcom/qcom_scm.h        |   6 +
>  include/linux/firmware/qcom/qcom_tzmem.h      |  28 ++
>  13 files changed, 684 insertions(+), 268 deletions(-)
>  create mode 100644 drivers/firmware/qcom/qcom_tzmem.c
>  create mode 100644 drivers/firmware/qcom/qcom_tzmem.h
>  create mode 100644 include/linux/firmware/qcom/qcom_tzmem.h
>
> --
> 2.40.1
>

Bjorn,

I tested it on db410c as well so let me gently ping you about picking
it up into your tree.

Bartosz

