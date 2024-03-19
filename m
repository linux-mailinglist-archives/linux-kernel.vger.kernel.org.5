Return-Path: <linux-kernel+bounces-108186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 265D188073A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 23:18:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81E071F23355
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 22:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1625FDA5;
	Tue, 19 Mar 2024 22:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JCTKrsZK"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FD05FBB7;
	Tue, 19 Mar 2024 22:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710886655; cv=none; b=s662XMxvTn0Tpc/Cf2wXJpFr4v2IabOU+I+nN5HPxQQkaSScUSXLQ/SUnFbCRxrr3oBQimI4ohSoJi3yDvzgdDe8E9ZchfVx8OyHTeflzNQNHWgJWiC7TZFtc32G8c+ed8CHOOoPoYb89heoCuOvqpvLdKBDbStVq1cR4u9i6yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710886655; c=relaxed/simple;
	bh=MSyuiyO4jmisLWsBYvLWyrUhMbTgIpdQwkeBbREycr0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Eum64JkXaq5g/EOqjr1/qk2x9amoGW34+Jy47kuW3sDb67BEqAsFbKAuA2CIyF1/XOBVEHWd1VpAYtD5oNnESPgnmRGHg9+5bGX1x0DLPL/NyfEk0pVNhk42sZCmxaBkqF22SEYqVVW1w+axFvZXReAnxzifz8Ui3VXehopAhDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JCTKrsZK; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-56ba6c83805so736489a12.0;
        Tue, 19 Mar 2024 15:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710886652; x=1711491452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Glc2nUqM/BurNgNXCvp8j1tF0pWkjpc6BBQBi0GM1U=;
        b=JCTKrsZKUW3P76nz1XVi7Glq7qO116IxI96LHuDz0N5tu/0swH6eR52SOfBnQbYuIZ
         EDbSNqm8E1qNCdYvFsbv3gZ+H/76zcxYhKcUYbZ0CWh5MpbDSEy/OmJDrac2KsdzQ4qy
         bl2UjrNy6aeQmNUN1db60p44TYRTN6cZV+ClxGOrfiJgVDjHlrXCv6EH6+fxbWR3sSbL
         2j3cIfWSYFc3wLljxUPmdSSLAqIi5LJpzfdOH3uoo0/SP7PTol4bf0DYG50RrCHKW9fp
         RSpKCDokm2Hj4aagcA+cTquIpRkGgDFGNhaHNk+22mQPrvh1Xmqfl0DlYjTLOgrjarL8
         XOBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710886652; x=1711491452;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Glc2nUqM/BurNgNXCvp8j1tF0pWkjpc6BBQBi0GM1U=;
        b=u9pDjS7xcc54vzH/36eEfSttPgxSg19bmn4Qjnru74hIq2i3NKM7SlRT6EwwpBJWIh
         hxOtLdDyODkF6F28kDB6MFOzNDUSyt++a68o4nA1aD685Cf7Ez+UT+gLhlNbBgP4rcZq
         GuF0ytM06UxtYVbIAW5DZyA6WaI8X2ks4S1D5iXqNl+PfRgejDpsW0oOq/E/ehPHQgGX
         2ulVoeOJv147OtSKroqA72XM0VJA3yUkK1GjTuUOXpWanGJyobOTsZp7/zsJL0b5yYi8
         ZUlhV2jDx+I2AI7P19tlKzYbTSOSwbJ2zNKHipYe4ye6aAmUtsvlih4L8CksIb6aRJDz
         fVCA==
X-Forwarded-Encrypted: i=1; AJvYcCXxCNMyO1xfR7PswtMhL94PO1rJHxwqMO2U1xMvGGkhzwV2QAlxgO+yz2vilwbpqgxTr7Uoq3Q5oKFYof6F0yao9oDz5xw7riHHFwki98yIbeb6piGnVUJGiC/qhuwaskjZYOVUwebHD6zAotdjvIr1q504GGAXRZnUb5jGSIQ/TK3yeGX16w==
X-Gm-Message-State: AOJu0Ywj7AfR/Sc3qJ30h1cQ0e3t/MtlCZl5MDBiEvdnDmzCCIO7AS4L
	uprqIirbYVfSXKMYSgZ0ycAaOZxDC8A1ykNdjUBrpjFNEM4ha3nV
X-Google-Smtp-Source: AGHT+IEPQjrvDT+CC4URF2EPJejTjlUefXMm1fTxdH71dVxYAWNGE7W7xRjizfT2T9gpX4uUsGr5cA==
X-Received: by 2002:a05:6402:378f:b0:565:dd87:9811 with SMTP id et15-20020a056402378f00b00565dd879811mr11940867edb.5.1710886652527;
        Tue, 19 Mar 2024 15:17:32 -0700 (PDT)
Received: from bhlegrsu.conti.de ([2a02:908:2525:6ea0::11c2])
        by smtp.googlemail.com with ESMTPSA id n13-20020a05640204cd00b00569aed32c32sm2761182edw.75.2024.03.19.15.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 15:17:32 -0700 (PDT)
From: Wadim Mueller <wafgo01@gmail.com>
To: 
Cc: Wadim Mueller <wafgo01@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Chester Lin <chester62515@gmail.com>,
	=?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
	Matthias Brugger <mbrugger@suse.com>,
	NXP S32 Linux Team <s32@nxp.com>,
	Tim Harvey <tharvey@gateworks.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Gregor Herburger <gregor.herburger@ew.tq-group.com>,
	Marek Vasut <marex@denx.de>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Joao Paulo Goncalves <joao.goncalves@toradex.com>,
	Markus Niebel <Markus.Niebel@ew.tq-group.com>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Matthias Schiffer <matthias.schiffer@tq-group.com>,
	Stefan Wahren <stefan.wahren@chargebyte.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Josua Mayer <josua@solid-run.com>,
	Philippe Schenker <philippe.schenker@toradex.com>,
	Li Yang <leoyang.li@nxp.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 2/2] dt-bindings: arm: fsl: Document missing s32g3 board
Date: Tue, 19 Mar 2024 23:16:10 +0100
Message-Id: <20240319221614.56652-3-wafgo01@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240319221614.56652-1-wafgo01@gmail.com>
References: <20240319221614.56652-1-wafgo01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The nxp, s32g399a-rdb3 board is not documented.

 * Add entry for S32G3 based boards with nxp,s32g399a-rdb3 item
 * Add nxp,s32g3-linflexuart documentation

Signed-off-by: Wadim Mueller <wafgo01@gmail.com>
---
 Documentation/devicetree/bindings/arm/fsl.yaml              | 6 ++++++
 .../devicetree/bindings/serial/fsl,s32-linflexuart.yaml     | 3 +++
 2 files changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 228dcc5c7d6f..23bf1d7f95b1 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -1503,6 +1503,12 @@ properties:
               - nxp,s32g274a-rdb2
           - const: nxp,s32g2
 
+      - description: S32G3 based Boards
+        items:
+          - enum:
+              - nxp,s32g399a-rdb3
+          - const: nxp,s32g3
+
       - description: S32V234 based Boards
         items:
           - enum:
diff --git a/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.yaml b/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.yaml
index 7a105551fa6a..f8eb92c9a8d9 100644
--- a/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.yaml
+++ b/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.yaml
@@ -25,6 +25,9 @@ properties:
       - items:
           - const: nxp,s32g2-linflexuart
           - const: fsl,s32v234-linflexuart
+      - items:
+          - const: nxp,s32g3-linflexuart
+          - const: fsl,s32v234-linflexuart
 
   reg:
     maxItems: 1
-- 
2.25.1


