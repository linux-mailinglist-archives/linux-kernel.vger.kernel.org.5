Return-Path: <linux-kernel+bounces-151571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A388AB090
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11652B21E51
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 14:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A3C12E1D4;
	Fri, 19 Apr 2024 14:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b="F27+akl6"
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E57912CD9C;
	Fri, 19 Apr 2024 14:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713536252; cv=none; b=bX2c3qNyyaDAc7CX/yNH4my60Dai3MYNW2FMAkKpx6PBoGg+4U8L/weSPAWT+jlzlmIOdYCQ4xpdoWsRIpCk/fOfhK+7lTI2M4rShCr6iB92AjqcNutB/drF/c5cAG2sRJsVhLuWTVtC8aefojDhlbHBiwxU+w0eMbQPIFVy0s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713536252; c=relaxed/simple;
	bh=HZJYsLSJO95Bda462oEdjVbzym3pJBr84Yzl4diz1Zo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NKAEzUDQrYaSvSgjLW+vigImQ954GaofEcVrpFp1t4xqVIaweQTlEYi8UoZRNFugNC3OmzThhyvHwcWsW3ofZP7BiCqxc6xJgtfhRc9vzGbu2ENK03/+7uTxXU20fqNdgMUYc8Vgh0hGSrQ6eFAGw+LwwSAPiH1qkgVI+oC3WFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io; spf=pass smtp.mailfrom=finest.io; dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b=F27+akl6; arc=none smtp.client-ip=74.208.4.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finest.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=finest.io;
	s=s1-ionos; t=1713536244; x=1714141044; i=parker@finest.io;
	bh=YqqvPxv1B8DJWco4lgEqCKwyKGylD23VurZSNiTLfx8=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=F27+akl6Altf+hlTr/3pT0wqU/+auQzcceKSHhbkFyvam7DdyBqHarvBlASC2EHA
	 fYxezS/1oYkMWzQFJESXB28RNKWsndgggYC5/ZT+dtghKcHK73HlV/Twr7tmkSRCp
	 oUt/J+tlfugKJ8F67ddo325a8J/QMERIQ7t/0alT2dqMpGfU3yZ2j/Fl3sVcKvvHm
	 zjKCJKwfE3I/GMJQ011vQrwqP1Sf2YGyeHsCr1nVkyLV+uC6KUN2LFbKwY5QlN7Lg
	 DaRkyT5HH3jI+XbEVpCRB/jmz0el/3PH9rYX/BiE3qeWgMKk2auqfVnhHDyZIB3Lt
	 o+vwHgNWSclaDO8+tQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from finest.io ([98.159.241.229]) by mrelay.perfora.net (mreueus003
 [74.208.5.2]) with ESMTPSA (Nemesis) id 0LvlsI-1snWS81UMu-017SbY; Fri, 19 Apr
 2024 16:17:24 +0200
From: Parker Newman <parker@finest.io>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Parker Newman <pnewman@connecttech.com>
Subject: [PATCH v2 3/4] serial: exar: return bool from exar_ee_read_bit()
Date: Fri, 19 Apr 2024 10:17:03 -0400
Message-ID: <cf67865525b30f58dbc8fbbe13865f73b5377c2f.1713533298.git.pnewman@connecttech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <cover.1713533298.git.pnewman@connecttech.com>
References: <cover.1713533298.git.pnewman@connecttech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xzqVBhCqb/U6CtNR6GG3MzefvOY+ONp/ikI1kv8y6i8PTMvBMtq
 fbSB1bte7QZ1aWW7jOxQox9G3ilqoVb8j4wDXph2la30vdK5XRDSR8+k8RO10YXEd61E5Zi
 2MXMUcXfZY/Hs/Eeq4g5fZ9sub9EiaCnviIJBN/D7F5+/ZDQu9gAVC0tfobXG6Voi2urrXd
 gGL7nWqy3CXK8m17NFAng==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:3/ULcuGN6sQ=;CxQJ8hjwFj2I82WMAcdKm0RXpjM
 u6Ef/vHIpgyjvEVfGcxtEdMDx7CnYWP/hhdSFnJlGxiUETGW/lTMGu8Srxvzw0QZRzfdnBvzA
 QotEgQS7Qjt8GFlljkyiVk7zfRNneCQUEzIK7mrHAgVIwxF+qxq7m/CW73Ug0+JytWzd2NMkA
 4p8py1nE9QYpx+UB7/8KzaHUpVIf9hag7xD9dZmskfa7kMuDQkdP+hCiCXBKRmoaz9NxuSrrA
 hwnqZiq6CmHmwx5a1DHNPiYvTjX8GNFvpoon3OY/vpZPdOTfXcp0/H8bvHe75NzhpnZYpJoaX
 HREU/ZipvResBHOkMjuZwfmXGUkWGMW7qXQ8d3AD2x+pKlli+S64KbdnW7pkGZf2mN3rDIg99
 H1Til+E9oLQvC/n11X5NgHBKOxLA/7CN2juHvATwXFPZOIcysRcXOIlzaKD7Dg/sghn7bM12O
 54rld8JLinPd18OtIyAofWngQZYCiWNCSMpFeeNh3N6dAyPM23ZsYwpr3RZJDe+zC9oZaQgRI
 oy0z4eufshZdsFFVmpOX1uew2aFNlIonevimLQk08D6DuHYYXjsRSB9EZXer2WxVCGqg68vdy
 QdqCUILNjYF/JcUqDxWeNOjykwcDkyjkIEwQF5sJ0zhQnm8BaxXIzH6ULNmqk/IHri3jRld8v
 NCwCzvjEo9qrwl8ANIGtV857B/qtqhyNG7vqkZPZRAtrzv0SCxM+Ov3TP4Pv1KjDUc1zDdVtW
 3MATxOZ/3TMBFpyK7CR+puKs8/NYsXngaR+LGWjk6ddUeKeOhZg2HA=

From: Parker Newman <pnewman@connecttech.com>

Change exar_ee_read_bit() to return a bool instead of u8. Removed need
for ternary or if/else for return value.

Signed-off-by: Parker Newman <pnewman@connecttech.com>
=2D--
Changes in v2:
- Change exar_ee_read_bit() to return a bool

 drivers/tty/serial/8250/8250_exar.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250=
/8250_exar.c
index 01748ddbf729..8665d3b7b673 100644
=2D-- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -300,7 +300,7 @@ static inline void exar_ee_write_bit(struct exar8250 *=
priv, int bit)
 	udelay(2);
 }

-static inline u8 exar_ee_read_bit(struct exar8250 *priv)
+static inline bool exar_ee_read_bit(struct exar8250 *priv)
 {
 	u8 regb;
 	u8 value =3D UART_EXAR_REGB_EECS;
@@ -317,7 +317,7 @@ static inline u8 exar_ee_read_bit(struct exar8250 *pri=
v)

 	regb =3D exar_read_reg(priv, UART_EXAR_REGB);

-	return (regb & UART_EXAR_REGB_EEDO ? 1 : 0);
+	return regb & UART_EXAR_REGB_EEDO;
 }

 /**
=2D-
2.43.2


