Return-Path: <linux-kernel+bounces-126892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D80C8943F6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 19:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 153ED1F27657
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 17:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BCBE4AED7;
	Mon,  1 Apr 2024 17:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d7WHz8As"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB73F40876
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 17:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711991412; cv=none; b=hwdsSw2bwpSmRkcgiZOxchkakPayg8qQB/ikb4NUXAe0UvImgGVpQtNMZgdzotirvXKuuq+VtuKNaMWsgqREayaQS1c1NTNazgMFXgrq8ic2izMUH1RhsY1r9AVFI95eZMXLihbzFslJjVe9Q5aqKZP4baWAaYJ9eLTr6ZoQsYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711991412; c=relaxed/simple;
	bh=YzB8K4a9xj5GS0cCZFDj6TwwMf7QWgUds8AWn3uuVss=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=XPsHSzp3Zp+EQ5Ei3ill/Vf2+SZq+57DoRbUKOkj9TwyEDUmRubkDKL7AabOrEMJZuufN4VQu2Sev6zuMnEQYll8FWDvFQadXe69nsLd9SkUBLw3Z/712Y3GnUix5PnSwBN9iRmMlgVug4BDlceS5Jic95OOZO/2KC4xeuYlzPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d7WHz8As; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-415644aca59so9272185e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 10:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711991408; x=1712596208; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cOLKrFXode7RL7ZHvCqUyHCs2EwpfvvlesdpnmleB6M=;
        b=d7WHz8Asf+l0QrCaG9sW6LH016cFvUxtE2utO558cfL2HHmBwkCoL1Ull6vlMTvXNI
         nqGWM583qERkDhhE2s6lsSykB3fW4SgvU58FDcLd4WbyOmkFibKB03vOT4hJ8nhvDQnU
         PlyVazKu78bsfgpZ5CUBn3qkcf/RDli9rXXwShJ2zBAYD8P1VV4Tjjmtz1DVyKEbMQE1
         FI3Nh96E6dhfa027t2H0Cw91mKTtsOD4TbYSSQzVxB3kKGBI5C4ekSNUvHX3lGR+pEyA
         Cg59KpaQ53UIh0B0fN0Acjxx+GV/5j9FjwqvGYU/1a7bN0WldNYHNAzgfQvTbx28jA+y
         UUag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711991408; x=1712596208;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cOLKrFXode7RL7ZHvCqUyHCs2EwpfvvlesdpnmleB6M=;
        b=JDgwucb8ib7d94uz8CpvnVITg7GCO1WzXjzX7Q28o0qoBXYHEvCx+69mK5DgOIGN+6
         VVMiMqk4NDYiDPaA0VG1ktMzYeD4dswm16H9iuxYVdetz0V9AiUr95IYFocymdXLln3O
         UVx0Z6KSJ86TCCBdecfp2ccCyj18vr7vXLfX0W1uXxyNSZOGr5Ae0/AHhPTcXKR7foTa
         FOBaRx1zHl5UmPR5Xk3Szl6x8qfZE4Q+9iJnstvWNG8FHDtLHRY7Fwi/3fAk/h9OE2sS
         S3TAsRhHmlYsU9BKRGILlxtR6HzSyDnr8rKhbMQlzQoMxpakL7Zx0wzuQNA+e2CwWTOa
         gDLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfmgVXFN7nuBtQbLIqXm7i6ZWAP34DmOtVUcZDphfeSY8GHtSTHhTOYo82+5wxGsoujT0PgFV2brq+zRwrQ57HZ26UybQmKY7VR4+V
X-Gm-Message-State: AOJu0Yy7dD8L8q7RERvQNwtQWv9n8IWb80sHPMnzKu6YMC/wzYB0FKWI
	WDPYXgekb1yJYcV/wqkymQ4GEzc5DYteVo+v4sf9fASK55nzh48+
X-Google-Smtp-Source: AGHT+IFdvWVQ5t5OSPrCcdGuPANNFpwX5kFJrnnSRIfNsMRL2/flh2LngyKi3zlajFubCMdZRc8Qmw==
X-Received: by 2002:a05:600c:1c1d:b0:413:ee55:8bba with SMTP id j29-20020a05600c1c1d00b00413ee558bbamr9516959wms.4.1711991407785;
        Mon, 01 Apr 2024 10:10:07 -0700 (PDT)
Received: from smtpclient.apple ([167.99.200.149])
        by smtp.gmail.com with ESMTPSA id n38-20020a05600c3ba600b00415509b11c3sm11433054wms.22.2024.04.01.10.10.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2024 10:10:07 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.400.31\))
Subject: Re: [PATCH v5 00/10] drm/ci: Add support for GPU and display testing
From: Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <20240401061235.192713-1-vignesh.raman@collabora.com>
Date: Mon, 1 Apr 2024 21:09:52 +0400
Cc: dri-devel@lists.freedesktop.org,
 daniels@collabora.com,
 Helen Koike <helen.koike@collabora.com>,
 David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>,
 emma@anholt.net,
 robdclark@gmail.com,
 david.heidelberg@collabora.com,
 guilherme.gallo@collabora.com,
 sergi.blanch.torne@collabora.com,
 hamohammed.sa@gmail.com,
 rodrigosiqueiramelo@gmail.com,
 melissa.srw@gmail.com,
 mairacanal@riseup.net,
 mcanal@igalia.com,
 linux-mediatek@lists.infradead.org,
 linux-amlogic@lists.infradead.org,
 linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <43FF2E86-D0C7-4497-8203-E598E80FFA1B@gmail.com>
References: <20240401061235.192713-1-vignesh.raman@collabora.com>
To: Vignesh Raman <vignesh.raman@collabora.com>
X-Mailer: Apple Mail (2.3774.400.31)

> On 1 Apr 2024, at 10:12=E2=80=AFam, Vignesh Raman =
<vignesh.raman@collabora.com> wrote:
>=20
> Some ARM SOCs have a separate display controller and GPU, each with
> different drivers. For mediatek mt8173, the GPU driver is powervr,
> and the display driver is mediatek. In the case of mediatek mt8183,
> the GPU driver is panfrost, and the display driver is mediatek.
> With rockchip rk3288/rk3399, the GPU driver is panfrost, while the
> display driver is rockchip. For amlogic meson, the GPU driver is
> panfrost, and the display driver is meson.

I=E2=80=99m not sure if this is describing the contents of a test lab or =
making
a statement on the Amlogic platform; but (being the pedant I am) I=E2=80=99=
ll
point out that Amlogic G12A/SM1 (Mali G31) and G12B (Mali G52) boards
do use panfrost, but the GXBB/GXL/GXM boards (Mali450) use lima.

CH.

> IGT tests run various tests with different xfails and can test both
> GPU devices and KMS/display devices. Currently, in drm-ci for =
MediaTek,
> Rockchip, and Amlogic Meson platforms, only the GPU driver is tested.
> This leads to incomplete coverage since the display is never tested on
> these platforms. This commit series adds support in drm-ci to run =
tests
> for both GPU and display drivers for MediaTek, Rockchip, and Amlogic
> Meson platforms.
>=20
> Uprev mesa and IGT in drm-ci and add amd, v3d, vc4 and vgem specific
> tests to testlist. Add testlists to the MAINTAINERS file and skip
> driver-specific tests.
>=20
> This series also includes patch to add vkms testing to drm-ci.
>=20
> Working pipeline link,
> https://gitlab.freedesktop.org/vigneshraman/linux/-/pipelines/1140647
>=20
> Vignesh Raman (10):
>  drm/ci: arm64.config: Enable CONFIG_DRM_ANALOGIX_ANX7625
>  drm/ci: uprev mesa version
>  drm/ci: uprev IGT and update testlist
>  drm/ci: mediatek: Refactor existing mediatek jobs
>  drm/ci: mediatek: Add job to test panfrost and powervr GPU driver
>  drm/ci: meson: Refactor existing meson jobs
>  drm/ci: meson: Add job to test panfrost GPU driver
>  drm/ci: rockchip: Refactor existing rockchip jobs
>  drm/ci: rockchip: Add job to test panfrost GPU driver
>  drm/ci: add tests on vkms
>=20
> MAINTAINERS                                   |  11 +
> drivers/gpu/drm/ci/arm64.config               |   1 +
> drivers/gpu/drm/ci/build.sh                   |   2 +-
> drivers/gpu/drm/ci/container.yml              |   6 +-
> drivers/gpu/drm/ci/gitlab-ci.yml              |  18 +-
> drivers/gpu/drm/ci/igt_runner.sh              |  16 +-
> drivers/gpu/drm/ci/image-tags.yml             |   5 +-
> drivers/gpu/drm/ci/test.yml                   | 138 ++++++--
> drivers/gpu/drm/ci/testlist.txt               | 321 ++++++++++++++++++
> drivers/gpu/drm/ci/x86_64.config              |   1 +
> .../gpu/drm/ci/xfails/amdgpu-stoney-fails.txt |  25 +-
> .../drm/ci/xfails/amdgpu-stoney-flakes.txt    |  10 +-
> .../gpu/drm/ci/xfails/amdgpu-stoney-skips.txt |  23 +-
> drivers/gpu/drm/ci/xfails/i915-amly-skips.txt |   9 +-
> drivers/gpu/drm/ci/xfails/i915-apl-skips.txt  |   9 +-
> drivers/gpu/drm/ci/xfails/i915-cml-skips.txt  |   7 +
> drivers/gpu/drm/ci/xfails/i915-glk-skips.txt  |   9 +-
> drivers/gpu/drm/ci/xfails/i915-kbl-skips.txt  |   9 +-
> drivers/gpu/drm/ci/xfails/i915-tgl-skips.txt  |   9 +-
> drivers/gpu/drm/ci/xfails/i915-whl-skips.txt  |   9 +-
> .../drm/ci/xfails/mediatek-mt8173-fails.txt   |  15 -
> .../drm/ci/xfails/mediatek-mt8173-flakes.txt  |  13 +
> .../drm/ci/xfails/mediatek-mt8173-skips.txt   |   6 +
> .../drm/ci/xfails/mediatek-mt8183-fails.txt   |  21 +-
> .../drm/ci/xfails/mediatek-mt8183-flakes.txt  |   8 +
> .../drm/ci/xfails/mediatek-mt8183-skips.txt   |   6 +
> .../gpu/drm/ci/xfails/meson-g12b-fails.txt    |   5 -
> .../gpu/drm/ci/xfails/meson-g12b-skips.txt    |   6 +
> .../gpu/drm/ci/xfails/msm-apq8016-skips.txt   |   5 +
> .../gpu/drm/ci/xfails/msm-apq8096-skips.txt   |   8 +-
> .../msm-sc7180-trogdor-kingoftown-skips.txt   |   6 +
> ...sm-sc7180-trogdor-lazor-limozeen-skips.txt |   6 +
> .../gpu/drm/ci/xfails/msm-sdm845-skips.txt    |   6 +
> .../gpu/drm/ci/xfails/panfrost-g12b-fails.txt |   1 +
> .../gpu/drm/ci/xfails/panfrost-g12b-skips.txt |   8 +
> .../drm/ci/xfails/panfrost-mt8183-fails.txt   |   1 +
> .../drm/ci/xfails/panfrost-mt8183-skips.txt   |   8 +
> .../drm/ci/xfails/panfrost-rk3288-fails.txt   |   1 +
> .../drm/ci/xfails/panfrost-rk3288-skips.txt   |   8 +
> .../drm/ci/xfails/panfrost-rk3399-fails.txt   |   1 +
> .../drm/ci/xfails/panfrost-rk3399-skips.txt   |   8 +
> .../drm/ci/xfails/rockchip-rk3288-fails.txt   |  50 +--
> .../drm/ci/xfails/rockchip-rk3288-flakes.txt  |  21 ++
> .../drm/ci/xfails/rockchip-rk3288-skips.txt   |  15 +-
> .../drm/ci/xfails/rockchip-rk3399-fails.txt   |  38 +--
> .../drm/ci/xfails/rockchip-rk3399-flakes.txt  |  28 +-
> .../drm/ci/xfails/rockchip-rk3399-skips.txt   |  11 +
> .../drm/ci/xfails/virtio_gpu-none-fails.txt   |   1 -
> .../drm/ci/xfails/virtio_gpu-none-skips.txt   |   9 +-
> drivers/gpu/drm/ci/xfails/vkms-none-fails.txt |  33 ++
> .../gpu/drm/ci/xfails/vkms-none-flakes.txt    |  20 ++
> drivers/gpu/drm/ci/xfails/vkms-none-skips.txt |  23 ++
> 52 files changed, 890 insertions(+), 144 deletions(-)
> create mode 100644 =
drivers/gpu/drm/ci/xfails/mediatek-mt8173-flakes.txt
> create mode 100644 drivers/gpu/drm/ci/xfails/mediatek-mt8173-skips.txt
> create mode 100644 =
drivers/gpu/drm/ci/xfails/mediatek-mt8183-flakes.txt
> create mode 100644 drivers/gpu/drm/ci/xfails/mediatek-mt8183-skips.txt
> create mode 100644 drivers/gpu/drm/ci/xfails/meson-g12b-skips.txt
> create mode 100644 drivers/gpu/drm/ci/xfails/msm-apq8016-skips.txt
> create mode 100644 drivers/gpu/drm/ci/xfails/panfrost-g12b-fails.txt
> create mode 100644 drivers/gpu/drm/ci/xfails/panfrost-g12b-skips.txt
> create mode 100644 drivers/gpu/drm/ci/xfails/panfrost-mt8183-fails.txt
> create mode 100644 drivers/gpu/drm/ci/xfails/panfrost-mt8183-skips.txt
> create mode 100644 drivers/gpu/drm/ci/xfails/panfrost-rk3288-fails.txt
> create mode 100644 drivers/gpu/drm/ci/xfails/panfrost-rk3288-skips.txt
> create mode 100644 drivers/gpu/drm/ci/xfails/panfrost-rk3399-fails.txt
> create mode 100644 drivers/gpu/drm/ci/xfails/panfrost-rk3399-skips.txt
> create mode 100644 =
drivers/gpu/drm/ci/xfails/rockchip-rk3288-flakes.txt
> create mode 100644 drivers/gpu/drm/ci/xfails/vkms-none-fails.txt
> create mode 100644 drivers/gpu/drm/ci/xfails/vkms-none-flakes.txt
> create mode 100644 drivers/gpu/drm/ci/xfails/vkms-none-skips.txt
>=20
> --=20
> 2.40.1
>=20
>=20
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic


