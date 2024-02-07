Return-Path: <linux-kernel+bounces-56886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7586584D0D6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 19:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 827451C22DF1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 18:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07978614D;
	Wed,  7 Feb 2024 18:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="rmP6HGES"
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B9585943;
	Wed,  7 Feb 2024 18:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707328957; cv=none; b=lK0/VpcE1+cwr5piDFj5bSdFITxUfwUOkhWobZM+wOEe4LcAeWT9yil+Ymmv0XZZhAm9ye+6yXIjuiBBNgqFQSYhVhrD5Kb9/7pSu+V5/+s1qySdoLw+xGQlb/N43JTaMBYxnVZbshX3vGbXlXBByhTBSXnjFT039hOTBJSBjmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707328957; c=relaxed/simple;
	bh=mRFzsib6y4l8IWxZx9WcZMfnSgpvgAJ1pdNPENvGXJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ltzTiXlD9Z6wM7aYWpSJ6B2zLr39MDRt4tkqjo+U9Q+h+70l2Kimk9TeaDPDoGyaK5+Um+NoKbrRVn9uHJpdf3oZ2+hU+8/lYj/v7dC55EP3cDVBsuHbnZiUxJJIIjiysdmV/v0jZBURohlPEt0h6An6F37M3a9vz7bDSFMgJ9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=rmP6HGES; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 75CB09C48A0;
	Wed,  7 Feb 2024 13:02:29 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id Q0gpBNSmz0O5; Wed,  7 Feb 2024 13:02:28 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id C4E259C46C5;
	Wed,  7 Feb 2024 13:02:28 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com C4E259C46C5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1707328948; bh=pJXroaVZ9MbVDlYIkJN4kCmIjVMtbnSfFQM8MOR33Ic=;
	h=From:To:Date:Message-ID:MIME-Version;
	b=rmP6HGES0lprspwL1IqqwOfdk0ricykjtrzCLjBIopGi8lKJUnwkyICjsSG1Uf3gE
	 LGyNoGRuST3U3DaCzYOi2BIcGWRO3fh0wli9e8/h1xfkdAftGMVZoF2vJt5XclpVUo
	 CXi70ExD5/1piWlp+yxSp0d6GX8v/O8Q5w1VB2qT0FRxGtteTNKZVh3KtVSxy5pwED
	 p7aSNCJsjBCoJqoFWX5EX/5y32JkfscHRHflAz/RQtZjOT2vATFklchrKDT7UEwTD0
	 N9zQR+mxzHJqoehulkKUuuX7CGBaobAkbSGdKiU6rR6GM/sU1J8IGecTgEGEFB9jwC
	 uc+gYrXB0an+g==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id g491560bh9fL; Wed,  7 Feb 2024 13:02:28 -0500 (EST)
Received: from pcperry.mtl.sfl (unknown [192.168.51.254])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 9C7039C43D6;
	Wed,  7 Feb 2024 13:02:28 -0500 (EST)
From: Charles Perry <charles.perry@savoirfairelinux.com>
To: mdf@kernel.org
Cc: avandiver@markem-imaje.com,
	bcody@markem-imaje.com,
	Charles Perry <charles.perry@savoirfairelinux.com>,
	Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	kishore Manne <nava.kishore.manne@amd.com>,
	linux-fpga@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 2/5] dt-bindings: fpga: xlnx,fpga-slave-serial: rename gpios
Date: Wed,  7 Feb 2024 13:01:25 -0500
Message-ID: <20240207180142.79625-3-charles.perry@savoirfairelinux.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207180142.79625-1-charles.perry@savoirfairelinux.com>
References: <20240207180142.79625-1-charles.perry@savoirfairelinux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

By convention, gpio consumer names should not contain underscores
(prog_b here) and shouldn't contain active low suffixes (-b here).

Signed-off-by: Charles Perry <charles.perry@savoirfairelinux.com>
---
 .../bindings/fpga/xlnx,fpga-slave-serial.yaml        | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/fpga/xlnx,fpga-slave-seria=
l.yaml b/Documentation/devicetree/bindings/fpga/xlnx,fpga-slave-serial.ya=
ml
index 614d86ad825f3..650a4d8792b64 100644
--- a/Documentation/devicetree/bindings/fpga/xlnx,fpga-slave-serial.yaml
+++ b/Documentation/devicetree/bindings/fpga/xlnx,fpga-slave-serial.yaml
@@ -36,7 +36,7 @@ properties:
   reg:
     maxItems: 1
=20
-  prog_b-gpios:
+  prog-gpios:
     description:
       config pin (referred to as PROGRAM_B in the manual)
     maxItems: 1
@@ -46,7 +46,7 @@ properties:
       config status pin (referred to as DONE in the manual)
     maxItems: 1
=20
-  init-b-gpios:
+  init-gpios:
     description:
       initialization status and configuration error pin
       (referred to as INIT_B in the manual)
@@ -55,9 +55,9 @@ properties:
 required:
   - compatible
   - reg
-  - prog_b-gpios
+  - prog-gpios
   - done-gpios
-  - init-b-gpios
+  - init-gpios
=20
 additionalProperties: false
=20
@@ -72,8 +72,8 @@ examples:
         spi-max-frequency =3D <60000000>;
         spi-cpha;
         reg =3D <0>;
-        prog_b-gpios =3D <&gpio0 29 GPIO_ACTIVE_LOW>;
-        init-b-gpios =3D <&gpio0 28 GPIO_ACTIVE_LOW>;
+        prog-gpios =3D <&gpio0 29 GPIO_ACTIVE_LOW>;
+        init-gpios =3D <&gpio0 28 GPIO_ACTIVE_LOW>;
         done-gpios =3D <&gpio0 9 GPIO_ACTIVE_HIGH>;
       };
     };
--=20
2.43.0


