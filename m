Return-Path: <linux-kernel+bounces-122116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63CB188F208
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 23:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01F9B1F2CFEF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 22:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B195153BD2;
	Wed, 27 Mar 2024 22:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="lMMHtD0/"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F701DA32;
	Wed, 27 Mar 2024 22:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711579909; cv=none; b=OYJIzDCfAbcUuQTTSqfh0z1CS4EfJBQlD6ji2DM7Wr93GVBJwRoMjuL3IhdPDvubyRggkPMny7q19K0hXIJ8z/78yA6nwyKiZJtKasAeI7ZBagM9BKGMJ9WDR6gEVCX2m7F5TrGehrwVzhRvEdmzIbuLzU6QCCTwgbH0DwjQ8nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711579909; c=relaxed/simple;
	bh=whjepltUkj7JmkR3T9glCWglkSsbbOAabOufTu/xSGM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DJl6zL7ggZ8TU04c9kBaeD0WkPrk2m+/u7c0h9BRWGMevyN+GdYm6WIwi0oot38Pcpk1rzXf5hSb5duB/IvzPZZKgMQYxcxodwmCrpcj4PQP1PEyK56cqjM2GVWE6TJDbhQ9K5aFVOMa8CnUiKv5KJYSuuqVVMV4vVu0QFw6oYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=lMMHtD0/; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711579905;
	bh=whjepltUkj7JmkR3T9glCWglkSsbbOAabOufTu/xSGM=;
	h=From:To:Cc:Subject:Date:From;
	b=lMMHtD0/lVTjQd2pg2VnlEfkhuiRLJzB6IEqkLILQemmjYcHRjh4eQv2ZxxstRSm4
	 gpXbl/uoIEsfpNu6cZvcHWu7JX4s8Fdzce1KC0+E/bXEU18gMGF0FFBOEwBVZNDAF2
	 c96PcRDGEJrHYAvNVBUJbaRuRYLTCdf+z6Wz2qxzKThYxy1pXbI0YTtWANUnkq3FPG
	 f5UqcOPUaCwwcns5HkZwRHn87tFq0ZVjrbISy5Xq1PwQpRpH6p57ZIyDyiArgbF2e2
	 C8QLbBLzkqKQZkV7rD15SbPK6R3fMCxTQYyG/f8i8ntATMQj0vEPSGcMJdNVKlg+do
	 zUu85ReFVCYqw==
Received: from shreeya.shreeya (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: shreeya)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id B82D63782111;
	Wed, 27 Mar 2024 22:51:34 +0000 (UTC)
From: Shreeya Patel <shreeya.patel@collabora.com>
To: heiko@sntech.de,
	mchehab@kernel.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	p.zabel@pengutronix.de,
	jose.abreu@synopsys.com,
	nelson.costa@synopsys.com,
	dmitry.osipenko@collabora.com,
	sebastian.reichel@collabora.com,
	shawn.wen@rock-chips.com,
	nicolas.dufresne@collabora.com,
	hverkuil@xs4all.nl,
	hverkuil-cisco@xs4all.nl
Cc: kernel@collabora.com,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-arm@lists.infradead.org,
	Shreeya Patel <shreeya.patel@collabora.com>
Subject: [PATCH v3 0/6] Add Synopsys DesignWare HDMI RX Controller
Date: Thu, 28 Mar 2024 04:20:51 +0530
Message-Id: <20240327225057.672304-1-shreeya.patel@collabora.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series implements support for the Synopsys DesignWare
HDMI RX Controller, being compliant with standard HDMI 1.4b
and HDMI 2.0.

Features that are currently supported by the HDMI RX driver
have been tested on rock5b board using a HDMI to micro-HDMI cable.
It is recommended to use a good quality cable as there were
multiple issues seen during testing the driver.

Please note the below information :-
* While testing the driver on rock5b we noticed that the binary BL31
from Rockchip contains some unknown code to get the HDMI-RX PHY
access working. With TF-A BL31, the HDMI-RX PHY doesn't work as
expected since there are no interrupts seen for rk_hdmirx-hdmi
leading to some failures in the driver [0].
* We have tested the working of OBS studio with HDMIRX driver and
there were no issues seen.
* We also tested and verified the support for interlaced video.

[0] https://gitlab.collabora.com/hardware-enablement/rockchip-3588/trusted-firmware-a/-/issues/1

To test the HDMI RX Controller driver, following example commands can be used :-

root@debian-rockchip-rock5b-rk3588:~# v4l2-ctl --verbose -d /dev/video0 \
--set-fmt-video=width=1920,height=1080,pixelformat='BGR3' --stream-mmap=4 \
--stream-skip=3 --stream-count=100 --stream-to=/home/hdmiin4k.raw --stream-poll

root@debian-rockchip-rock5b-rk3588:~# ffmpeg -f rawvideo -vcodec rawvideo \
-s 1920x1080 -r 60 -pix_fmt bgr24 -i /home/hdmiin4k.raw output.mkv


Following is the v4l2-compliance test result :-

root@debian-rockchip-rock5b-rk3588:~# v4l2-compliance -d /dev/video0
v4l2-compliance 1.27.0-5174, 64 bits, 64-bit time_t
v4l2-compliance SHA: d700deb14368 2024-01-18 12:19:05

Compliance test for snps_hdmirx device /dev/video0:

Driver Info:
        Driver name      : snps_hdmirx
        Card type        : snps_hdmirx
        Bus info         : platform: snps_hdmirx
        Driver version   : 6.8.0
        Capabilities     : 0x84201000
                Video Capture Multiplanar
                Streaming
                Extended Pix Format
                Device Capabilities
        Device Caps      : 0x04201000
                Video Capture Multiplanar
                Streaming
                Extended Pix Format

Required ioctls:
        test VIDIOC_QUERYCAP: OK
        test invalid ioctls: OK

Allow for multiple opens:
        test second /dev/video0 open: OK
        test VIDIOC_QUERYCAP: OK
        test VIDIOC_G/S_PRIORITY: OK
        test for unlimited opens: OK

Debug ioctls:
        test VIDIOC_DBG_G/S_REGISTER: OK (Not Supported)
        test VIDIOC_LOG_STATUS: OK

Input ioctls:
        test VIDIOC_G/S_TUNER/ENUM_FREQ_BANDS: OK (Not Supported)
        test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
        test VIDIOC_S_HW_FREQ_SEEK: OK (Not Supported)
        test VIDIOC_ENUMAUDIO: OK (Not Supported)
        test VIDIOC_G/S/ENUMINPUT: OK
        test VIDIOC_G/S_AUDIO: OK (Not Supported)
        Inputs: 1 Audio Inputs: 0 Tuners: 0

Output ioctls:
        test VIDIOC_G/S_MODULATOR: OK (Not Supported)
        test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
        test VIDIOC_ENUMAUDOUT: OK (Not Supported)
        test VIDIOC_G/S/ENUMOUTPUT: OK (Not Supported)
        test VIDIOC_G/S_AUDOUT: OK (Not Supported)
        Outputs: 0 Audio Outputs: 0 Modulators: 0

Input/Output configuration ioctls:
        test VIDIOC_ENUM/G/S/QUERY_STD: OK (Not Supported)
        test VIDIOC_ENUM/G/S/QUERY_DV_TIMINGS: OK
        test VIDIOC_DV_TIMINGS_CAP: OK
        test VIDIOC_G/S_EDID: OK

Control ioctls (Input 0):
        test VIDIOC_QUERY_EXT_CTRL/QUERYMENU: OK
        test VIDIOC_QUERYCTRL: OK
        test VIDIOC_G/S_CTRL: OK
        test VIDIOC_G/S/TRY_EXT_CTRLS: OK
        test VIDIOC_(UN)SUBSCRIBE_EVENT/DQEVENT: OK
        test VIDIOC_G/S_JPEGCOMP: OK (Not Supported)
        Standard Controls: 2 Private Controls: 0

Format ioctls (Input 0):
        test VIDIOC_ENUM_FMT/FRAMESIZES/FRAMEINTERVALS: OK
        test VIDIOC_G/S_PARM: OK
        test VIDIOC_G_FBUF: OK (Not Supported)
        test VIDIOC_G_FMT: OK
        test VIDIOC_TRY_FMT: OK
        test VIDIOC_S_FMT: OK
        test VIDIOC_G_SLICED_VBI_CAP: OK (Not Supported)
        test Cropping: OK (Not Supported)
        test Composing: OK (Not Supported)
        test Scaling: OK (Not Supported)

Codec ioctls (Input 0):
        test VIDIOC_(TRY_)ENCODER_CMD: OK (Not Supported)
        test VIDIOC_G_ENC_INDEX: OK (Not Supported)
        test VIDIOC_(TRY_)DECODER_CMD: OK (Not Supported)

Buffer ioctls (Input 0):
        test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: OK
        test CREATE_BUFS maximum buffers: OK
        test VIDIOC_EXPBUF: OK
        test Requests: OK (Not Supported)

Total for snps_hdmirx device /dev/video0: 46, Succeeded: 46, Failed: 0, Warnings: 0

Changes in v3 :-
  - Use v4l2-common helpers in the HDMIRX driver
  - Rename cma node and phandle names
  - Elaborate the comment to explain 160MiB calculation
  - Move &hdmi_receiver_cma to the rock5b dts file
  - Add information about interlaced video testing in the
    cover-letter

Changes in v2 :-
  - Fix checkpatch --strict warnings
  - Move the dt-binding include file changes in a separate patch
  - Add a description for the hardware in the dt-bindings file
  - Rename resets, vo1 grf and HPD properties
  - Add a proper description for grf and vo1-grf phandles in the
    bindings
  - Rename the HDMI RX node name to hdmi-receiver
  - Include gpio header file in binding example to fix the
    dt_binding_check failure
  - Move hdmirx_cma node to the rk3588.dtsi file
  - Add an entry to MAINTAINERS file for the HDMIRX driver

Shreeya Patel (6):
  dt-bindings: reset: Define reset id used for HDMI Receiver
  clk: rockchip: rst-rk3588: Add reset line for HDMI Receiver
  dt-bindings: media: Document HDMI RX Controller
  arm64: dts: rockchip: Add device tree support for HDMI RX Controller
  media: platform: synopsys: Add support for hdmi input driver
  MAINTAINERS: Add entry for Synopsys DesignWare HDMI RX Driver

 .../bindings/media/snps,dw-hdmi-rx.yaml       |  132 +
 MAINTAINERS                                   |    8 +
 .../boot/dts/rockchip/rk3588-pinctrl.dtsi     |   41 +
 .../boot/dts/rockchip/rk3588-rock-5b.dts      |   19 +
 arch/arm64/boot/dts/rockchip/rk3588.dtsi      |   56 +
 drivers/clk/rockchip/rst-rk3588.c             |    1 +
 drivers/media/platform/Kconfig                |    1 +
 drivers/media/platform/Makefile               |    1 +
 drivers/media/platform/synopsys/Kconfig       |    3 +
 drivers/media/platform/synopsys/Makefile      |    2 +
 .../media/platform/synopsys/hdmirx/Kconfig    |   18 +
 .../media/platform/synopsys/hdmirx/Makefile   |    4 +
 .../platform/synopsys/hdmirx/snps_hdmirx.c    | 2726 +++++++++++++++++
 .../platform/synopsys/hdmirx/snps_hdmirx.h    |  394 +++
 .../synopsys/hdmirx/snps_hdmirx_cec.c         |  289 ++
 .../synopsys/hdmirx/snps_hdmirx_cec.h         |   46 +
 .../dt-bindings/reset/rockchip,rk3588-cru.h   |    2 +
 17 files changed, 3743 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/snps,dw-hdmi-rx.yaml
 create mode 100644 drivers/media/platform/synopsys/Kconfig
 create mode 100644 drivers/media/platform/synopsys/Makefile
 create mode 100644 drivers/media/platform/synopsys/hdmirx/Kconfig
 create mode 100644 drivers/media/platform/synopsys/hdmirx/Makefile
 create mode 100644 drivers/media/platform/synopsys/hdmirx/snps_hdmirx.c
 create mode 100644 drivers/media/platform/synopsys/hdmirx/snps_hdmirx.h
 create mode 100644 drivers/media/platform/synopsys/hdmirx/snps_hdmirx_cec.c
 create mode 100644 drivers/media/platform/synopsys/hdmirx/snps_hdmirx_cec.h

-- 
2.39.2


