Return-Path: <linux-kernel+bounces-106332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C5D87EC9D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 16:51:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 666EF1C21086
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 15:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542AE52F87;
	Mon, 18 Mar 2024 15:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Z8+NyVtn"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1696524CF;
	Mon, 18 Mar 2024 15:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710777071; cv=none; b=fgcm6rw5hQ55lAfxvgHtjXNYRMc4ZonvNaaxc+ACjJfUOzlImm3YK4HzSnd0fL5GbXZ65zc/yyjLWSTWnjhmH8OFuTDzMgWFjZUh1bZgKBb98qUIH+vaZ0on5hyMr7IbySQAjNRpPOBjxPacWaLbTizfnz10o8PwsK5ABcIhx9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710777071; c=relaxed/simple;
	bh=vFEF/OGYpnkktObt7GRCXvKVIPiNuH/3wZneowmoO2I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TYVPwOLC68JMEP+sr3mgfDhDIM8dUs/sCqXHmryqXtszVeTJVH8dOSuY/pLteYyE58JQ0ENbKJWytumEs8zLLYjhzASNubhomZafroUq7N1ZbxrQcRgdZ1iYUB7PjtEYv1zO9wwSbB+Uc6IVRIIftxz1REcxpkE66ypfYUBZpHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=Z8+NyVtn; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-154-34-181.elisa-laajakaista.fi [91.154.34.181])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id D8BC11B1C;
	Mon, 18 Mar 2024 16:50:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1710777041;
	bh=vFEF/OGYpnkktObt7GRCXvKVIPiNuH/3wZneowmoO2I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Z8+NyVtn4em2i8blDUKcsmGRiU2QTA1dCqc9g/+vwZwvB2kX90wnbaFEA8aGp7QD5
	 1lxa7Z2SJO2sai/M87Xs761h0XkLnO1r3I9u8Hsg+R7nt7kHdDLD5N7sNnDR7Bifu1
	 rTdXPWHb3O3gL/IV1FDgHuzlVlW0lnFNN1MaOE2g=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Mon, 18 Mar 2024 17:49:56 +0200
Subject: [PATCH 1/4] media: uapi: Add meta formats for PiSP FE config and
 stats
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240318-rp1-cfe-v1-1-ac6d960ff22d@ideasonboard.com>
References: <20240318-rp1-cfe-v1-0-ac6d960ff22d@ideasonboard.com>
In-Reply-To: <20240318-rp1-cfe-v1-0-ac6d960ff22d@ideasonboard.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, 
 Naushir Patuck <naush@raspberrypi.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Jacopo Mondi <jacopo.mondi@ideasonboard.com>, 
 Kieran Bingham <kieran.bingham@ideasonboard.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4239;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=vFEF/OGYpnkktObt7GRCXvKVIPiNuH/3wZneowmoO2I=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBl+GLoQiGKkmp9T7eCWGA0g1jd2pCFPuauIw9ss
 DsaPZybQv2JAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZfhi6AAKCRD6PaqMvJYe
 9Tx1D/oCn/zaGnZu1Jl5GazYhG6+m1v2p2UYXJ9gKHErKw3w8Ni1zRRN+PuXU/SLqkApEDY+4ez
 ww/b87Royxd6h8nQK5CCVef65kVWn0lBMoNKhb/YVNlEYGlDvwez/dowkhzCfQrU1k0RRJVAFl2
 EEKIV4g/1EkZEwritusWQ8ST9F9KOf5hCY5F+2/DPd3zaqSJKhbr5nOSxedBjqp+cHtj5tngGqS
 92nA9vnnR6i0UbtkPGjFbLzmC0Ap+oKjGISvcSSpXZLuIQh1GKgJtfFzC0NEkHj0YJ3vCd9s0nO
 c1V/BwZUqqa/4HMBInwvaD1JIcLgFJxIXtOfL8Sk9NwRNAsuyjaUx4f4/GMLkRnpViq8j2H/5b9
 qm9kNZm2wzLlrDenS3KWSEd0lJhM04FZCtNw3yUvme4oOq2mRpCYI+8BHdqUZnNZ8HHU6DQUkFF
 95IKT8tRkPELM4OVm1nkH7Rzw3w3e2F8NOXPpLDLM50Bi4coWvmLnGraCEWvi0tTO1K/n3nDJZU
 RkaTFeeBB3h4Unxf5W0p5yHDxzE0Qkw4qkBcYHXVQDHMfwkht21hanbA4ULSHv98Mty9nVzSFUP
 ndzXIAoB7zUPou9Hjc/Yt0J45o8NVNmWHDBoTWIqRSw5UKBgyLYoaZ+akm79mzl87DHu05PIn0E
 aBEIVfH1Fgp2mvA==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

Add two meta formats for PiSP FE: V4L2_META_FMT_RPI_FE_CFG and
V4L2_META_FMT_RPI_FE_STATS. The former is used to provide configuration
for the FE and the latter is used to read the statistics from the FE.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 .../userspace-api/media/v4l/meta-formats.rst       |  1 +
 .../userspace-api/media/v4l/metafmt-pisp-fe.rst    | 39 ++++++++++++++++++++++
 drivers/media/v4l2-core/v4l2-ioctl.c               |  2 ++
 include/uapi/linux/videodev2.h                     |  2 ++
 4 files changed, 44 insertions(+)

diff --git a/Documentation/userspace-api/media/v4l/meta-formats.rst b/Documentation/userspace-api/media/v4l/meta-formats.rst
index d82a5a9cbd2f..19493c579a8c 100644
--- a/Documentation/userspace-api/media/v4l/meta-formats.rst
+++ b/Documentation/userspace-api/media/v4l/meta-formats.rst
@@ -15,6 +15,7 @@ These formats are used for the :ref:`metadata` interface only.
     metafmt-d4xx
     metafmt-intel-ipu3
     metafmt-pisp-be
+    metafmt-pisp-fe
     metafmt-rkisp1
     metafmt-uvc
     metafmt-vsp1-hgo
diff --git a/Documentation/userspace-api/media/v4l/metafmt-pisp-fe.rst b/Documentation/userspace-api/media/v4l/metafmt-pisp-fe.rst
new file mode 100644
index 000000000000..fddeada83e4a
--- /dev/null
+++ b/Documentation/userspace-api/media/v4l/metafmt-pisp-fe.rst
@@ -0,0 +1,39 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. _v4l2-meta-fmt-rpi-fe-cfg:
+
+************************
+V4L2_META_FMT_RPI_FE_CFG
+************************
+
+Raspberry Pi PiSP Front End configuration format
+================================================
+
+The Raspberry Pi PiSP Front End image signal processor is configured by
+userspace by providing a buffer of configuration parameters to the
+`rp1-cfe-fe-config` output video device node using the
+:c:type:`v4l2_meta_format` interface.
+
+The `Raspberry Pi PiSP technical specification
+<https://datasheets.raspberrypi.com/camera/raspberry-pi-image-signal-processor-specification.pdf>`_
+provide detailed description of the Front End configuration and programming
+model.
+
+.. _v4l2-meta-fmt-rpi-fe-stats:
+
+**************************
+V4L2_META_FMT_RPI_FE_STATS
+**************************
+
+Raspberry Pi PiSP Front End statistics format
+=============================================
+
+The Raspberry Pi PiSP Front End image signal processor provides statistics data
+by writing to a buffer provided via the `rp1-cfe-fe-stats` capture video device
+node using the
+:c:type:`v4l2_meta_format` interface.
+
+The `Raspberry Pi PiSP technical specification
+<https://datasheets.raspberrypi.com/camera/raspberry-pi-image-signal-processor-specification.pdf>`_
+provide detailed description of the Front End configuration and programming
+model.
diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
index 0b4f5372c217..1d44303b7e81 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -1465,6 +1465,8 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
 	case V4L2_META_FMT_GENERIC_CSI2_20:	descr = "8b Generic Meta, 20b CSI-2"; break;
 	case V4L2_META_FMT_GENERIC_CSI2_24:	descr = "8b Generic Meta, 24b CSI-2"; break;
 	case V4L2_META_FMT_RPI_BE_CFG:	descr = "RPi PiSP BE Config format"; break;
+	case V4L2_META_FMT_RPI_FE_CFG: descr = "RPi PiSP FE Config format"; break;
+	case V4L2_META_FMT_RPI_FE_STATS: descr = "RPi PiSP FE Statistics format"; break;
 
 	default:
 		/* Compressed formats */
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index 1eb60baeb3ea..ad1a519eefe5 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -865,6 +865,8 @@ struct v4l2_pix_format {
 
 /* Vendor specific - used for RaspberryPi PiSP */
 #define V4L2_META_FMT_RPI_BE_CFG v4l2_fourcc('R', 'P', 'B', 'C') /* PiSP BE configuration */
+#define V4L2_META_FMT_RPI_FE_CFG v4l2_fourcc('R', 'P', 'F', 'C')
+#define V4L2_META_FMT_RPI_FE_STATS v4l2_fourcc('R', 'P', 'F', 'S')
 
 /* priv field value to indicates that subsequent fields are valid. */
 #define V4L2_PIX_FMT_PRIV_MAGIC		0xfeedcafe

-- 
2.34.1


