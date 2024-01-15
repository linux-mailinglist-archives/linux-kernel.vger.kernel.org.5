Return-Path: <linux-kernel+bounces-26499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C8F382E229
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 22:18:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B255C1C22255
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 21:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856CE1B274;
	Mon, 15 Jan 2024 21:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="qi9LY7tq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="u+R1L62k"
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE0E1B26E
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 21:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.west.internal (Postfix) with ESMTP id 7AAF23200AFB;
	Mon, 15 Jan 2024 16:18:47 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Mon, 15 Jan 2024 16:18:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1705353526; x=1705439926; bh=DnYQw2I6Yjs9w8Mtfh1LZ
	VGt5d51hfEJAUokeBtPaXk=; b=qi9LY7tqP/sGENNpaE1hw2SDDC20vdmw/oqSS
	3fHsL9VTjVoq2pzllMIUnnqqs27tj5iit1y+MpK1X3EWq94zvIQUjY58yPoAjZh4
	63al+U1TqiOIGkSG4cI4ZLveKWfrS8DhwtLr3Wv/yDfqBnn0TkVio7HTnRpNkj7i
	eW9idRjdFWo4qKrk8xZbHs31FQuMa34FHnultQf7tRPRMvxc+w7qs8mWa5V9rI6y
	UGDnEB1ka15I70/dmFYVq49jquwtEjg8um8TR2v17FlmBVdfMtrpWIL8loHusBqe
	uN/jlb7tzyv8KLy5iHf4OSJrBm5+IZZXpL040SCqZZnmDOhMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1705353526; x=1705439926; bh=DnYQw2I6Yjs9w8Mtfh1LZVGt5d51
	hfEJAUokeBtPaXk=; b=u+R1L62kESwe1dbe2NmkM1MY63zncow9Wes0H8UPpurk
	41K3EHiPeH1FE/83WF0ugQnhsYgj7OmNQwCQnhLSlbQpAtR7ZZGo2XKxZa+nZ2SI
	kcwl5Ee+cZrDn+SSSTqie5AC3ho5/oBLoVXOikE7ysmKk3eMBXsfvHIryuUH1wDL
	Sno1B7CC5U/pbHRQnYi7Bf8FJnS+1XQDHqiwSKbK14Wp6nRRuI030AlGF+d2jaW/
	ZeY5GVejvvyRlwleSCSX6RTfPgulDzWhpNxpCUtBaDCrrhBaa+k4eSObwW5OJeRM
	elY1Qrlw64zkn9ahCFeXSDzBFXdiVz2lySU1A7o5DA==
X-ME-Sender: <xms:NqGlZc66muWRbuH1s9KymEZHkoF1_S50XGhYxuaWx8Gk3t6r0C50ww>
    <xme:NqGlZd65lOiDFlo2u2A4Xy0kAFZE3OGb7f5vNzy7ia4pSGO_eqvjAIWJjRBOg3dmB
    qmWSBvhW9ccjX02QHw>
X-ME-Received: <xmr:NqGlZbfvWHr39ApGZ_MCbuxdSLJTMiraMWfspRUKn1Ui62qAUCtNoz-Zt4Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdejuddgudeglecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgggfestdekre
    dtredttdenucfhrhhomhepfdfnuhhkvgcuffdrucflohhnvghsfdcuoehluhhkvgeslhhj
    ohhnvghsrdguvghvqeenucggtffrrghtthgvrhhnpefgudejtdfhuddukefffeekiefftd
    dtvdfhgeduudeuffeuhfefgfegfeetvedvgeenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:NqGlZRLn0_IFMadBblId2CQAPZ8COgTDF3S2dUAHGC0nkXEo7zbK5g>
    <xmx:NqGlZQJTr6IZBheQeFIW88Ozp2Hw1CsaYUmEOzWxw0V3PFlAZK0UBw>
    <xmx:NqGlZSzA-Is8GzWFiBGeALQg1m2YSS-ayDv4bV9eMjckKilGyne-cw>
    <xmx:NqGlZaysGXl3s38e-ZQKQHBw85Sl5zCP-hWT4_AqVFDxDFLFclthmA>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Jan 2024 16:18:44 -0500 (EST)
From: "Luke D. Jones" <luke@ljones.dev>
To: linux-kernel@vger.kernel.org
Cc: hdegoede@redhat.com,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH] MAINTAINERS: add Luke Jones as maintainer for asus notebooks
Date: Tue, 16 Jan 2024 10:18:29 +1300
Message-ID: <20240115211829.48251-1-luke@ljones.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add myself as maintainer for "ASUS NOTEBOOKS AND EEEPC ACPI/WMI EXTRAS
DRIVERS" as suggested by Hans de Goede based on my history of
contributions.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f5c2450fa4ec..e7843beaa589 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3147,6 +3147,7 @@ F:	drivers/hwmon/asus-ec-sensors.c
 
 ASUS NOTEBOOKS AND EEEPC ACPI/WMI EXTRAS DRIVERS
 M:	Corentin Chary <corentin.chary@gmail.com>
+M:	Luke D. Jones <luke@lones.dev>
 L:	acpi4asus-user@lists.sourceforge.net
 L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
-- 
2.43.0


