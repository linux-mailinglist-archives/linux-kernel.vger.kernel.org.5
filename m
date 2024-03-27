Return-Path: <linux-kernel+bounces-121332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD9B388E78B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:58:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 162E3B32B1C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16C7130E53;
	Wed, 27 Mar 2024 13:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="kiXNd6Ei"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B6A26296
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 13:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711544642; cv=none; b=iFJhQazrfFZqOYneBpUAgGm3ay2/szZZ3Y/xe5jdMO7xngOkbx293aJh7vA5lqXo1Rsvi0x263LJRTeZ6a3nes9y5tqBBG6PtfJLjut5mUBitWbl/KKZawvPeZiv/xy5yhA20We/ScHyhGrhfYCs06+zdiyZBmFpuShPaLfiSzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711544642; c=relaxed/simple;
	bh=fBckXIMsHbe2+Au1I+FoaYupzsY+KA/9pDk1D4J+lrA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=omUf5RUsm9v+wkjiEdScgnu+uh0ui0TBakx+4S6IfnnnbKULejFISWIdpkNIcuk67II9Nb0Pr3oTVdS7PvclnRjPNE8nTssOZv6hN8DZQ2xNzKer5be5pEHS6lMLPBLW2wemQSiYHro607tdTDKee+LYucKxrnTULACvXVhSyRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=kiXNd6Ei; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-154-34-181.elisa-laajakaista.fi [91.154.34.181])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id CAB38675;
	Wed, 27 Mar 2024 14:03:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1711544606;
	bh=fBckXIMsHbe2+Au1I+FoaYupzsY+KA/9pDk1D4J+lrA=;
	h=From:Date:Subject:To:Cc:From;
	b=kiXNd6EiywZInrxTUGsPmXI5/cxcIGs1SsCgdnoqpj4m2xvfWUY1qjHPvvmQjjhMP
	 pJSHyxHrKlteTkg4YYv6jGlIpdf/5fFaOkgh6vLlynUiHKDL3wicN1Dfl6KqL1hPZq
	 Dmr/aIfJ0k9aSYwMmQVValoI3FXd4CNWdJyfkdjs=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Wed, 27 Mar 2024 15:03:33 +0200
Subject: [PATCH] MAINTAINERS: Add myself as maintainer for Xilinx DRM
 drivers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240327-xilinx-maintainer-v1-1-c5fdc115f448@ideasonboard.com>
X-B4-Tracking: v=1; b=H4sIACQZBGYC/x2MQQqAIBAAvyJ7TjATg74SHUzXWigLjRDEvycd5
 jCHmQIJI2GCiRWI+FKiKzTpOwZ2N2FDTq45SCGVGOTIMx0UMj8NhaeBkXstpPDarkY5aN0d0VP
 +n/NS6weR6D87YwAAAA==
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=795;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=fBckXIMsHbe2+Au1I+FoaYupzsY+KA/9pDk1D4J+lrA=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBmBBk6L8A9Xw88l1g2tAOprbKEqvM/FkgDFMvRy
 GIXq1PQrL6JAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZgQZOgAKCRD6PaqMvJYe
 9Tk8D/4nlr7//mnEaXjY4VB+nbvdiZd8PrY7w/u4Bj0G4sg3+mXp2amK74xzBx6IN4/tWjBfmmx
 dngDQ6Mt3s9XE3hO9vZbNmK5IFRNBSwPZxkofpRWa/18QE0TNNyk9smJcTGeeZ1HTcMDTke146G
 blrMJfukfPO6n7AIZHetyDMebRpd7tTqL/9HvgLV7zAWj+Hr4+0JeQh5x6cFOhBBg/hzpS1ftdZ
 pmWthypWIyZP9hP/vdOZ0A3T/XJlLpPrmwd9VE2Q31/rMPNOffC0jWHJnmHywkhL/0KJGT/RraK
 7SHZ+9mtfIoXIRMAMxi3KaNgg3G/qbksQG0brjLPmdjdq2FuNz+oj1ZPDcUmoX7sTwt7rjUczgL
 RxQL9rSSpsi+R40OHHDUd2qXNpTryfdpnKvUdUxh0G5GyzNHDp49dYKbNoM3EQX0XRbfzI7yQ01
 ZNLl7j8SLEO0ecEQQQke31bsKmvwvFu29Ie9Su+qrXWZ+ynFw4fdNXTipD0/5nUNn/d2lzCiJIY
 GdYsEwSWrW20EYQbI4OanhZlY2OcX0BcNomPWHNVVvoldRqPYolALIfbyHA9LJ44Xgn9Pgr5vS3
 SpXGML1TFLsRCHsvqU379BX/AYOf/LTO5IBZYxgfQCu2/KvR3F2toeFPFZ0nBuq9oQ/gi9QOcVR
 ZF7zNBREqcXB6DA==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

Add myself as a co-maintainer for Xilinx DRM drivers to help Laurent.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1aabf1c15bb3..79ef5a6bf21b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7306,6 +7306,7 @@ F:	drivers/gpu/drm/xen/
 
 DRM DRIVERS FOR XILINX
 M:	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
+M:	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
 L:	dri-devel@lists.freedesktop.org
 S:	Maintained
 T:	git git://anongit.freedesktop.org/drm/drm-misc

---
base-commit: e8f897f4afef0031fe618a8e94127a0934896aba
change-id: 20240327-xilinx-maintainer-f6020f6cba4d

Best regards,
-- 
Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>


