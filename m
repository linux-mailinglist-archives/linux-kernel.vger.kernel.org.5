Return-Path: <linux-kernel+bounces-93676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39894873325
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:54:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA2F2286EF1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7965F862;
	Wed,  6 Mar 2024 09:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=j.neuschaefer@gmx.net header.b="YBIsdeLU"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690635F859
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 09:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709718860; cv=none; b=ivIFw//aL3Mlp7c+8n9ysJ2nkxPSBHG7BoTu8NVSW5FKVbck4EJm5nbkher00ZCjksbzW48/2OHB/pW2Z07ql6vGCd84EMErbi3jqXKBIM8HGQosvSPGM8KEKlndunHst0Ddwv/Gx+Qqt4zcDuV2yQnM8p1i9CwbewYoD37QkzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709718860; c=relaxed/simple;
	bh=Cfsjv3bMraaDifxBSHB4874EPFtiZVDgXo474KE3U1c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=T4lJWrOZZGR6LdhKsUYO5c/FY2g26ZmtPoHc0D1pv3k6kv+jKFxe17qldA1fkAnJCicMGQ8rsgFklO2EKiQ1+RPg6zdXf9M55/tJo0MaGBuwq+CZxHpEvIT5kBdQTYmHfWKC26GVnKpIg3GDvm53XFKvAoXYERYP02oZTyVQ8lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=j.neuschaefer@gmx.net header.b=YBIsdeLU; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1709718844; x=1710323644; i=j.neuschaefer@gmx.net;
	bh=Cfsjv3bMraaDifxBSHB4874EPFtiZVDgXo474KE3U1c=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=YBIsdeLUFZrENphSgtFfQOht98Gj7fpz0C8Gsk+F/kRKNw+E0f+syepUnK/GAh0R
	 yic4s3FAiY2prCs6T2ADDIS/1MbWnmkSHBdhTW0YFa9ioeCihWOCUmCGuYxPNYj+Y
	 Yfwxty77dMXFy4/3Y3nSZMXPX43+WACFtaBfdpRNlQ0NJRjvGyl0xVKfQVBmgXLUc
	 rZAbenCMxmLGt9AeY6+tbpiRw7JuT0WwYoxfR4Q2G5QWHz5BOa4hRbBHExJacLfc+
	 YtDCZBkzWm5ovdaSIXHfcYOvitFrhVUCC7spElEhTKxWuiAedpHkYyT1O1Uot7ZUB
	 yVqcYrHkOhtroKoDLw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([89.1.58.16]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MYeMt-1rMeLP1nBD-00VjrS; Wed, 06
 Mar 2024 10:54:04 +0100
From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: linux-arm-kernel@lists.infradead.org
Cc: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
	Russell King <linux@armlinux.org.uk>,
	openbmc@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: wpcm450_defconfig: Fix formatting of 32-bit number
Date: Wed,  6 Mar 2024 10:53:58 +0100
Message-ID: <20240306095358.509785-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RKv9wcRZzdbbUc8vslPj0/ift4zM2q31+YoQqAj7SP6uKHlVkDp
 /yVdn6Ol6am9gnjXrDd27PFrNO6rTdw53UmEMC09AA3yxp1QopeSMax4bGsbMBC4XB2khyK
 HE1S+iZa2bsYGxHLUTUj5K6/g0OrGSxeHXJsfDhC4ySw59Ppr56scFNh9FKn2OaNTGYpD08
 r9MAGCkl6Mde4e9LYVSUg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:OXmeCf3YRuQ=;8fXEFAY1RSLKfyS011j4wMXFL5x
 36SMp+OOuDxYHYtpK88bqtxDiGEJrqgz4KhrVAZ9iEEbZVKXELKmyW4GQQpRHkLhw3C/wkoum
 uMpcaAiudzFYxk59K0gdsaVUAmzO3dnLnzEG+CTd4bipgf55Nrd6mx+fFe/ePpI3BQzj94qdq
 X9bIqOentvxj63vC3rPs9ZSqriJVL/R5dzQLzu9YX9lv2ScjaS3oDSDxRSC1cz7tSYIUO9N92
 wD+784kzEBGSk2LGBI90HT8M32iLVpGzg/nqBB9Ee+4hQ6YCCxGsIRJrMCf+0vRJqQ42mfKxD
 TV359jMFV3cSC684/Qb5rtvf0RvmmH8M1EZCJKJvpOIGFnC+FVWWiNaHfpfrWoVAwqL+YF4J4
 IV8B9Y7opV1tRXvAPfEC47zR1J4lrbrAwgfnlVDoU37fYbLGefRJYGgFcH3zQbiX1amG8nAt3
 yR4dAHW2Z7ZnZ30M2/wcFotSvUy4TuIBbgW6tRfve2h4W/Mu/tZJuM3eg8B4r1uwhCi4TciUC
 uts8oTFsnjE15dM7ijhF3Dj6yw8m0U3TMhhd3XfLbiJK1u5mP5oP6o9RkHLBJs0cONoInNOZw
 qSvOvhyteGgkw5HVhe2TtGHGM0MMLLS0mf0REEg2AIbo14k0tW7NP0k/efD7bKX8yvvXnSjYb
 iJ3dyCpTeOAEMsSz/nhJZPtuxTAP7eg64sCbzKcN50RkBje+O7ZZ4grdjS+mlFXcFcQF7pCPU
 o2D+H0CxQfFn/grcqvPk24TKISC/j3f0/oGf2p40aCZBxGVZhfMqc88boiLWnjEDFrSqGZ0gX
 MATAg0+qBfONFzyJcBQJjU9TJGV4xYDTWjOpO5OqPzZJc=

Nine digits are one too many.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 arch/arm/configs/wpcm450_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/configs/wpcm450_defconfig b/arch/arm/configs/wpcm450=
_defconfig
index 45483deab034f..78b6c671eade5 100644
=2D-- a/arch/arm/configs/wpcm450_defconfig
+++ b/arch/arm/configs/wpcm450_defconfig
@@ -206,6 +206,6 @@ CONFIG_DEBUG_USER=3Dy
 CONFIG_DEBUG_LL=3Dy
 CONFIG_DEBUG_LL_UART_8250=3Dy
 CONFIG_DEBUG_UART_PHYS=3D0xb8000000
-CONFIG_DEBUG_UART_VIRT=3D0x0ff000000
+CONFIG_DEBUG_UART_VIRT=3D0xff000000
 CONFIG_DEBUG_UART_8250_WORD=3Dy
 CONFIG_EARLY_PRINTK=3Dy
=2D-
2.43.0


