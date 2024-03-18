Return-Path: <linux-kernel+bounces-106176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B728F87EA51
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 14:48:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AA82283119
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 13:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE01487A5;
	Mon, 18 Mar 2024 13:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="vkaHhyxm"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7BA481D8
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 13:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710769699; cv=none; b=cmm/U9qgf8M/t8Ry4/Wi/6r/rVvuplSSMcyosxBCRdijfLIVj7k/bpFAgMXa3CMkRvBJ60vRsJWtc5h5DG8KmOT9ErHTM5CfCOZedqa88Ec2BKUJAXmW+cpxqqBc/Y/vvIiPtzM5tfrDAYftWCx7zJZ4CsXH2Px1Bfd6AqoGAU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710769699; c=relaxed/simple;
	bh=05UYUGs2h/AbwbeXjSI4LIhGc28nhT5XwrdjPXeSHKw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=oRCIVAGSl965zaRSr/dV9vSq1g5fwRVxuwWBl0yhSxno+Ulfz6qMBaFnu9fwra0kYuY8f6a8GDFjNk1NZHiicouPVAxNqpbVlFqfW9rL7JYqjYKJe+MzUb2R/5J1IQGj+F7rKNp34s31NsvnNN2q6pYzqxtKXVzyc1nwHSfOVo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=vkaHhyxm; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d27184197cso59752131fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 06:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1710769695; x=1711374495; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U0AQrSb2a+lzMoRPNmdl1WH+tKIo050nITB8DgR+osk=;
        b=vkaHhyxmFWnAxE7kZqWY12zec2xgBm57t7jXLs2/UajxiQKpc3Qsiz/EgY5zN3h+Bk
         NekIwjDJnWbozEciOpuIFlJjdM3GBt87T/nMz1j8+pA0VzJOuPZGctdPJFpu2Sc0pPlZ
         a1k/tkn1kWs4X3D9ij9HxZEWhYPIpCsLWKCks3ryKm6GIVZ13zEWgCKNyWUlfORxxNml
         iY8xQ+WTCtksNBDHB9dv8KQBW3i5SSh2PwtojU1+/bfk+FrwFs8GzH843i4QBPuuL7Me
         5P9Z5iEuggeZdH7sCvVfAJxR2PaLsIJtALLgPCQkz7uPKSVGisPvmNGHdViBzkI+yyVC
         oWvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710769695; x=1711374495;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=U0AQrSb2a+lzMoRPNmdl1WH+tKIo050nITB8DgR+osk=;
        b=TT/1V4N5JL1GpP18M6ow+2OccDcComQu68T7iRqtqP2j0XUKXRqf17b3IUbEI2LBLm
         wef7QUND5liFE7mrR1Eltrli0GbZDqLbQYtzFRIdHcg6Yh5LVNsVDuVg99zSvMMSH0Wn
         KpiPZK7M7PhfrgAaqCGxwEoNsplBXhSxQyzJeu0DT6PKvNK3UCCzfHFxEe8/hs0KQDd5
         cfq7cqnJTOYLJt2Ljq7jW7e3Ry1uGDeauxn7/wAxK6ROqpLyJ7Bq6GKOfHiBKvby3WhU
         kzKjMYUK2M8TzUxO8vbnkty2lZT7tOwu6NHOkIOiXWfpS45QCaaYPxq4jZ1BiuYjNpBI
         0XMw==
X-Forwarded-Encrypted: i=1; AJvYcCWaiRkz+X6LTi5P7jheiiazXnaHIm+IkX9UzkcqyIaPAFPFQ0fk2vDywTg4lG9ADYq9S0MI5UIbiGppAOJKRDz5OzOeOE926u259+Gh
X-Gm-Message-State: AOJu0YxHXzxC319kmGkV+xLCAPuGO2sMoi4CgTAhCpYyKgBFlDFslueu
	T0dAq6zdZdpspzeW1KJFRqDDeU9RXZ/fNne8nEsNLza4yw9lmQyUyBsDF6juzxw=
X-Google-Smtp-Source: AGHT+IFaxpl58hma4pvlO2gkQlFKb6UCdUfMVcmqVrqrduWOm/5xCqq0bUd5UNzGpakdAwXRnuRWVw==
X-Received: by 2002:a2e:8949:0:b0:2d2:a3c4:4f with SMTP id b9-20020a2e8949000000b002d2a3c4004fmr8596189ljk.35.1710769695247;
        Mon, 18 Mar 2024 06:48:15 -0700 (PDT)
Received: from localhost (046125249120.public.t-mobile.at. [46.125.249.120])
        by smtp.gmail.com with ESMTPSA id az12-20020a05620a170c00b0078a0d65e968sm98832qkb.52.2024.03.18.06.48.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 06:48:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 18 Mar 2024 14:48:09 +0100
Message-Id: <CZWX8POMMGS3.1YJ0MLS9HO90L@fairphone.com>
Subject: Re: [PATCH] drm/bridge: Select DRM_KMS_HELPER for DRM_PANEL_BRIDGE
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Jani Nikula" <jani.nikula@linux.intel.com>, "Neil Armstrong"
 <neil.armstrong@linaro.org>, "Andrzej Hajda" <andrzej.hajda@intel.com>,
 "Robert Foss" <rfoss@kernel.org>, "Laurent Pinchart"
 <Laurent.pinchart@ideasonboard.com>, "Jonas Karlman" <jonas@kwiboo.se>,
 "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Daniel Vetter" <daniel@ffwll.ch>
Cc: <~postmarketos/upstreaming@lists.sr.ht>, <phone-devel@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.15.2
References: <20240111-drm-panel-bridge-fixup-v1-1-e06292f6f500@fairphone.com> <171075294759.1615603.8073986785380285265.b4-ty@linaro.org> <87wmpzq0bp.fsf@intel.com> <87ttl3pzzi.fsf@intel.com>
In-Reply-To: <87ttl3pzzi.fsf@intel.com>

On Mon Mar 18, 2024 at 11:59 AM CET, Jani Nikula wrote:
> On Mon, 18 Mar 2024, Jani Nikula <jani.nikula@linux.intel.com> wrote:
> > On Mon, 18 Mar 2024, Neil Armstrong <neil.armstrong@linaro.org> wrote:
> >> Hi,
> >>
> >> On Thu, 11 Jan 2024 13:38:04 +0100, Luca Weiss wrote:
> >>> Since the kconfig symbol of DRM_PANEL_BRIDGE is only adding
> >>> bridge/panel.o to drm_kms_helper object, we need to select
> >>> DRM_KMS_HELPER to make sure the file is actually getting built.
> >>>=20
> >>> Otherwise with certain defconfigs e.g. devm_drm_of_get_bridge will no=
t
> >>> be properly available:
> >>>=20
> >>> [...]
> >>
> >> Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git =
(drm-misc-fixes)
> >>
> >> [1/1] drm/bridge: Select DRM_KMS_HELPER for DRM_PANEL_BRIDGE
> >>       https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/e3f18b0d=
d1db242791afbc3bd173026163ce0ccc
> >
> > With my kernel config, e3f18b0dd1db ("drm/bridge: Select DRM_KMS_HELPER
> > for DRM_PANEL_BRIDGE") leads to:
> >
> > WARNING: unmet direct dependencies detected for DRM_KMS_HELPER
> >   Depends on [m]: HAS_IOMEM [=3Dy] && DRM [=3Dm]
> >   Selected by [y]:
> >   - DRM_PANEL_BRIDGE [=3Dy] && HAS_IOMEM [=3Dy] && DRM_BRIDGE [=3Dy]
> >   Selected by [m]:
> >   - DRM [=3Dm] && HAS_IOMEM [=3Dy] && (AGP [=3Dy] || AGP [=3Dy]=3Dn) &&=
 !EMULATED_CMPXCHG && HAS_DMA [=3Dy] && DRM_FBDEV_EMULATION [=3Dy]
> >   - DRM_MIPI_DBI [=3Dm] && HAS_IOMEM [=3Dy] && DRM [=3Dm]
> >   - DRM_KUNIT_TEST [=3Dm] && HAS_IOMEM [=3Dy] && DRM [=3Dm] && KUNIT [=
=3Dy] && MMU [=3Dy]
> >   - DRM_RADEON [=3Dm] && HAS_IOMEM [=3Dy] && DRM [=3Dm] && PCI [=3Dy] &=
& MMU [=3Dy] && (AGP [=3Dy] || !AGP [=3Dy])
> >   - DRM_AMDGPU [=3Dm] && HAS_IOMEM [=3Dy] && DRM [=3Dm] && PCI [=3Dy] &=
& MMU [=3Dy] && !UML
> >   - DRM_NOUVEAU [=3Dm] && HAS_IOMEM [=3Dy] && DRM [=3Dm] && PCI [=3Dy] =
&& MMU [=3Dy]
> >   - DRM_I915 [=3Dm] && HAS_IOMEM [=3Dy] && DRM [=3Dm] && X86 [=3Dy] && =
PCI [=3Dy] && !PREEMPT_RT [=3Dn]
> >   - DRM_XE [=3Dm] && HAS_IOMEM [=3Dy] && DRM [=3Dm] && PCI [=3Dy] && MM=
U [=3Dy] && (m && MODULES [=3Dy] || y && KUNIT [=3Dy]=3Dy) && 64BIT [=3Dy]
> >   - DRM_VKMS [=3Dm] && HAS_IOMEM [=3Dy] && DRM [=3Dm] && MMU [=3Dy]
> >   - DRM_VMWGFX [=3Dm] && HAS_IOMEM [=3Dy] && DRM [=3Dm] && PCI [=3Dy] &=
& MMU [=3Dy] && (X86 [=3Dy] || ARM64)
> >   - DRM_GMA500 [=3Dm] && HAS_IOMEM [=3Dy] && DRM [=3Dm] && PCI [=3Dy] &=
& X86 [=3Dy] && MMU [=3Dy]
> >   - DRM_UDL [=3Dm] && HAS_IOMEM [=3Dy] && DRM [=3Dm] && USB [=3Dm] && U=
SB_ARCH_HAS_HCD [=3Dy] && MMU [=3Dy]
> >   - DRM_AST [=3Dm] && HAS_IOMEM [=3Dy] && DRM [=3Dm] && PCI [=3Dy] && M=
MU [=3Dy]
> >   - DRM_MGAG200 [=3Dm] && HAS_IOMEM [=3Dy] && DRM [=3Dm] && PCI [=3Dy] =
&& MMU [=3Dy]
> >   - DRM_QXL [=3Dm] && HAS_IOMEM [=3Dy] && DRM [=3Dm] && PCI [=3Dy] && M=
MU [=3Dy]
> >   - DRM_VIRTIO_GPU [=3Dm] && HAS_IOMEM [=3Dy] && DRM [=3Dm] && VIRTIO_M=
ENU [=3Dy] && MMU [=3Dy]
> >   - DRM_BOCHS [=3Dm] && HAS_IOMEM [=3Dy] && DRM [=3Dm] && PCI [=3Dy] &&=
 MMU [=3Dy]
> >   - DRM_CIRRUS_QEMU [=3Dm] && HAS_IOMEM [=3Dy] && DRM [=3Dm] && PCI [=
=3Dy] && MMU [=3Dy]
> >   - DRM_GM12U320 [=3Dm] && HAS_IOMEM [=3Dy] && DRM [=3Dm] && USB [=3Dm]=
 && MMU [=3Dy]
> >   - DRM_PANEL_MIPI_DBI [=3Dm] && HAS_IOMEM [=3Dy] && DRM [=3Dm] && SPI =
[=3Dy]
> >   - DRM_SIMPLEDRM [=3Dm] && HAS_IOMEM [=3Dy] && DRM [=3Dm] && MMU [=3Dy=
]
> >   - TINYDRM_HX8357D [=3Dm] && HAS_IOMEM [=3Dy] && DRM [=3Dm] && SPI [=
=3Dy]
> >   - TINYDRM_ILI9163 [=3Dm] && HAS_IOMEM [=3Dy] && DRM [=3Dm] && SPI [=
=3Dy]
> >   - TINYDRM_ILI9225 [=3Dm] && HAS_IOMEM [=3Dy] && DRM [=3Dm] && SPI [=
=3Dy]
> >   - TINYDRM_ILI9341 [=3Dm] && HAS_IOMEM [=3Dy] && DRM [=3Dm] && SPI [=
=3Dy]
> >   - TINYDRM_ILI9486 [=3Dm] && HAS_IOMEM [=3Dy] && DRM [=3Dm] && SPI [=
=3Dy]
> >   - TINYDRM_MI0283QT [=3Dm] && HAS_IOMEM [=3Dy] && DRM [=3Dm] && SPI [=
=3Dy]
> >   - TINYDRM_REPAPER [=3Dm] && HAS_IOMEM [=3Dy] && DRM [=3Dm] && SPI [=
=3Dy]
> >   - TINYDRM_ST7586 [=3Dm] && HAS_IOMEM [=3Dy] && DRM [=3Dm] && SPI [=3D=
y]
> >   - TINYDRM_ST7735R [=3Dm] && HAS_IOMEM [=3Dy] && DRM [=3Dm] && SPI [=
=3Dy]
> >   - DRM_XEN_FRONTEND [=3Dm] && HAS_IOMEM [=3Dy] && XEN [=3Dy] && DRM [=
=3Dm]
> >   - DRM_VBOXVIDEO [=3Dm] && HAS_IOMEM [=3Dy] && DRM [=3Dm] && X86 [=3Dy=
] && PCI [=3Dy]
> >   - DRM_GUD [=3Dm] && HAS_IOMEM [=3Dy] && DRM [=3Dm] && USB [=3Dm] && M=
MU [=3Dy]
> >   - DRM_SSD130X [=3Dm] && HAS_IOMEM [=3Dy] && DRM [=3Dm] && MMU [=3Dy]
> >   - DRM_ANALOGIX_ANX78XX [=3Dm] && HAS_IOMEM [=3Dy] && DRM [=3Dm] && DR=
M_BRIDGE [=3Dy]
>
> Please read Documentation/kbuild/kconfig-language.rst.
>
> Basically boolean DRM_PANEL_BRIDGE selecting tristate DRM_KMS_HELPER
> forces it to y while it should remain m.

Would you know the correct fix for this? I'm aware of the pattern
"select FOO || !FOO" but I guess it's also not applicable here?

In any case building DRM_PANEL_BRIDGE also needs to build
DRM_KMS_HELPER, otherwise the object files just don't get used.

Unfortunately I'm not versed well enough at all in Kconfig :/

>
> Please revert.
>
> BR,
> Jani.


