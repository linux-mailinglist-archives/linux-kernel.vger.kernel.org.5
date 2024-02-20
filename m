Return-Path: <linux-kernel+bounces-73185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ECA385BEE3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 15:35:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D973E28523D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 14:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECEB469D1A;
	Tue, 20 Feb 2024 14:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="bHJ+P3Ow"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707086A8D4;
	Tue, 20 Feb 2024 14:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708439701; cv=none; b=MY+m8Y1M95Uvh4dkuyVWs+RjXY9GQNR/kc1/fKAFdjDVHH3b2QgH7DsQxv/iajX3gbqVxX0+OjuQlUnhbNKB8h8Z8WxfRFKbdElms4de91wBgPeRjpcqaoH9PeVLkPXEsQhpzrFooXukULIVuhgRo5BO0TQqhwi09nap/6Vxfu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708439701; c=relaxed/simple;
	bh=tT6ZfasOIxoBveG6wwRIdl5KdNJ0nF+V4DEOiBUQA1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uYG7C8kGS2j3wfgke3ydVFmaehSo/EDADrPPgifVO8E+bchntGbeYzrDos2n2QfbMJiEKSILSN4gy28r/hIISc7c/bOi2LyHwSMYxHVtOiCq/LXNgEpf3uFRK7W5ZwdgZW3zww5pZtXg5FAZpTaAU8HpR3EmaqXg734rI20QryY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=bHJ+P3Ow; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1708439697; x=1739975697;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PK/5f0jqHYJ514WxFm9181WW1OvD4tNCz8ecedcg0LY=;
  b=bHJ+P3OwoKXEC6Ubg9UZ897vp1FLVOeApTtY4hjxLQAituMDNrexf4Gv
   m1wRb9NagQbkFlH2XAmemYNUAmtQrqGWC4Kw8KPmQXHJ8fsm2zxp7xNij
   cHz1YWLgqA05cdQVhHQ0XsbrpAiqj+2P2e2oZgESCJPaqxNgU48gJW68h
   gvLTMbw9zsKx0EzRv3WEIESZQRyL2JddfsVDrDpsv0zO/UlenMdmUgbpT
   0QnVKmh0dG3e4wiOzAT+SZGg49mJvkLTyrYQB8b5i7Bym6PjzfLsXHg3l
   ZwlsqK8eQ9IhM62KvG0ftaKjI12Z0tN6RoHS7YQs8sDBJTA9ieZoi97si
   Q==;
X-IronPort-AV: E=Sophos;i="6.06,172,1705359600"; 
   d="scan'208";a="35502635"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 20 Feb 2024 15:34:53 +0100
Received: from steina-w.localnet (steina-w.tq-net.de [10.123.53.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 51DED280075;
	Tue, 20 Feb 2024 15:34:53 +0100 (CET)
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Matthias Kaehlcke <mka@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Helen Koike <helen.koike@collabora.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Russell King <linux@armlinux.org.uk>, Javier Carrasco <javier.carrasco@wolfvision.net>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, Javier Carrasco <javier.carrasco@wolfvision.net>, Matthias Kaehlcke <matthias@kaehlcke.net>
Subject: Re: [PATCH v4 0/8] usb: misc: onboard_hub: add support for XMOS XVF3500
Date: Tue, 20 Feb 2024 15:34:55 +0100
Message-ID: <3548824.iIbC2pHGDl@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20240220-onboard_xvf3500-v4-0-dc1617cc5dd4@wolfvision.net>
References: <20240220-onboard_xvf3500-v4-0-dc1617cc5dd4@wolfvision.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Hi,

Am Dienstag, 20. Februar 2024, 15:05:44 CET schrieb Javier Carrasco:
> This series adds support for the XMOS XVF3500 VocalFusion Voice
> Processor[1], a low-latency, 32-bit multicore controller for voice
> processing.
>=20
> The XVF3500 requires a specific power sequence, which consists of
> enabling the regulators that control the 3V3 and 1V0 device supplies,
> and a reset de-assertion after a delay of at least 100ns. Once in normal
> operation, the XVF3500 registers itself as a regular USB device and no
> device-specific management is required.

While reading this, [1] come into my mind.

Best regards,
Alexander

[1] https://lore.kernel.org/all/20211006035407.1147909-1-dmitry.baryshkov@l=
inaro.org/

> The power management provided by onboard_usb_hub is not specific for hubs
> and any other USB device with the same power sequence could profit from
> that driver, provided that the device does not have any specific
> requirements beyond the power management. To account for non-hub devices,
> the driver has been renamed and an extra flag has been added to identify
> hubs and provide their specific functionality. Support for
> device-specific power suply names has been added, keeping generic names
> for backwards compatibility and as a fallback mechanism.
>=20
> The references to onboard_usb_hub in the core and config files have been
> updated as well.
>=20
> The diff is way much bulkier than the actual code addition because of the
> file renaming, so in order to ease reviews and catch hub-specific code
> that might still affect non-hub devices, the complete renaming was moved
> to a single commit.
>=20
> The device binding has been added to sound/ because it is the subsystem
> that covers its functionality (voice processing) during normal
> operation. If it should reside under usb/ instead, it will be moved as
> required.
>=20
> This series has been tested with a Rockchip-based SoC and an XMOS
> XVF3500-FB167-C.
>=20
> [1] https://www.xmos.com/xvf3500/
>=20
> To: Liam Girdwood <lgirdwood@gmail.com>
> To: Mark Brown <broonie@kernel.org>
> To: Rob Herring <robh+dt@kernel.org>
> To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> To: Conor Dooley <conor+dt@kernel.org>
> To: Matthias Kaehlcke <mka@chromium.org>
> To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> To: Helen Koike <helen.koike@collabora.com>
> To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> To: Maxime Ripard <mripard@kernel.org>
> To: Thomas Zimmermann <tzimmermann@suse.de>
> To: David Airlie <airlied@gmail.com>
> To: Daniel Vetter <daniel@ffwll.ch>
> To: Catalin Marinas <catalin.marinas@arm.com>
> To: Will Deacon <will@kernel.org>
> To: Russell King <linux@armlinux.org.uk>
> Cc: linux-sound@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-usb@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
>=20
> Changes in v4:
> - General: use device supply names and generics as fallback.
> - onbord_usb_dev.c: fix suspend callback for non-hub devices.
> - onboard_usb_dev.c: fix typos.
>=20
> - Link to v3: https://lore.kernel.org/r/20240206-onboard_xvf3500-v3-0-f85=
b04116688@wolfvision.net
>=20
> Changes in v3:
> - onboard_usb_hub: rename to onboard_usb_dev to include non-hub devices.
> - onboard_hub_dev: add flag to identify hubs and provide their extra
>   functionality.
> - dt-bindings: add reference to usb-device.yaml and usb node in the
>   example.
> - dt-bindings: generic node name.
> - Link to v2: https://lore.kernel.org/r/20240130-onboard_xvf3500-v1-0-51b=
5398406cb@wolfvision.net
>=20
> Changes in v2:
> - general: add support in onboard_usb_hub instead of using a dedicated
>   driver.
> - dt-bindings: use generic usb-device compatible ("usbVID,PID").
> - Link to v1: https://lore.kernel.org/all/20240115-feature-xvf3500_driver=
=2Dv1-0-ed9cfb48bb85@wolfvision.net/
>=20
> ---
> Javier Carrasco (8):
>       usb: misc: onboard_hub: rename to onboard_dev
>       usb: misc: onboard_dev: add support for non-hub devices
>       drm: ci: arm64.config: update ONBOARD_USB_HUB to ONBOARD_USB_DEV
>       arm64: defconfig: update ONBOARD_USB_HUB to ONBOARD_USB_DEV
>       ARM: multi_v7_defconfig: update ONBOARD_USB_HUB name
>       usb: misc: onboard_dev: use device supply names
>       ASoC: dt-bindings: xmos,xvf3500: add XMOS XVF3500 voice processor
>       usb: misc: onboard_hub: add support for XMOS XVF3500
>=20
>  ...-usb-hub =3D> sysfs-bus-platform-onboard-usb-dev} |   4 +-
>  .../devicetree/bindings/sound/xmos,xvf3500.yaml    |  63 +++
>  MAINTAINERS                                        |   4 +-
>  arch/arm/configs/multi_v7_defconfig                |   2 +-
>  arch/arm64/configs/defconfig                       |   2 +-
>  drivers/gpu/drm/ci/arm64.config                    |   4 +-
>  drivers/usb/core/Makefile                          |   4 +-
>  drivers/usb/core/hub.c                             |   8 +-
>  drivers/usb/core/hub.h                             |   2 +-
>  drivers/usb/misc/Kconfig                           |  16 +-
>  drivers/usb/misc/Makefile                          |   2 +-
>  drivers/usb/misc/onboard_usb_dev.c                 | 525 +++++++++++++++=
++++++
>  .../misc/{onboard_usb_hub.h =3D> onboard_usb_dev.h}  |  69 ++-
>  ...ard_usb_hub_pdevs.c =3D> onboard_usb_dev_pdevs.c} |  47 +-
>  drivers/usb/misc/onboard_usb_hub.c                 | 501 ---------------=
=2D----
>  include/linux/usb/onboard_dev.h                    |  18 +
>  include/linux/usb/onboard_hub.h                    |  18 -
>  17 files changed, 709 insertions(+), 580 deletions(-)
> ---
> base-commit: 41bccc98fb7931d63d03f326a746ac4d429c1dd3
> change-id: 20240130-onboard_xvf3500-6c0e78d11a1b
>=20
> Best regards,
>=20


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



