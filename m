Return-Path: <linux-kernel+bounces-151430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F2E8AAEC5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 14:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 120FBB21FDC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 12:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D7E1EB45;
	Fri, 19 Apr 2024 12:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b="lXDFXnHr"
Received: from forward501b.mail.yandex.net (forward501b.mail.yandex.net [178.154.239.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078538565E;
	Fri, 19 Apr 2024 12:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713530723; cv=none; b=RP1M6IZu7x6VVKraP3xENMhvh1aDZpCOYOfjqZ1knQ8wuNb0vZxEUU2dtODK5JNZDZ1thjyyeh0Lc7KQRkGggStk77E2dsRve6iPVR49cPSvT84i1NUapumRsRcR6Zcjhl5OwUWN98JvAW+IarG/IbViGs1ynaVvMxgcEDIrdww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713530723; c=relaxed/simple;
	bh=FOi6eJPUFSojRtF9P/XwjqEpVwed2EL1xlarcDukTeg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DPfUp6lPZ1gyNxzrYVtE5NbTKg6NzUeJA4lPX50BvnvaW1/iZNMQH75uqJatZIz4PrKsv7689vHefPXPt4i3MvcbBRg9xh4mkRJ5Q2P4QWBGXTyJY5j146CQ3YLrrrgJhZ3Gzs93sHjWvFS01VOJt8Lx8EvEiaXaecA0xjQUINE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru; spf=pass smtp.mailfrom=ya.ru; dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b=lXDFXnHr; arc=none smtp.client-ip=178.154.239.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ya.ru
Received: from mail-nwsmtp-smtp-production-main-45.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-45.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:5003:0:640:89b0:0])
	by forward501b.mail.yandex.net (Yandex) with ESMTPS id 6D3A6611D2;
	Fri, 19 Apr 2024 15:45:20 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-45.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 8jF8ngSo6uQ0-YxpMdtGo;
	Fri, 19 Apr 2024 15:45:19 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail;
	t=1713530719; bh=GaYIntdqsvXpjyEkkhoOihijbTv7eiJ72X4WWAqXMnU=;
	h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=lXDFXnHrDvfCgYIfU5IbNUSfYEs1Ri/4rRWnMVsXIH81AvoWgf5wQSu/J0m7a26NZ
	 VWD/eZgUzIYZNgxLNMDXs9DEFiJ30ng+3JB3tg1GfH6W3QMR2V13tpBVqMhLW6AY6b
	 hndVSItWLK6DzlliUQbPRHxMMk8SX97o5I7hUYXY=
Authentication-Results: mail-nwsmtp-smtp-production-main-45.myt.yp-c.yandex.net; dkim=pass header.i=@ya.ru
From: Konstantin Pugin <rilian.la.te@ya.ru>
To: 
Cc: Konstantin Pugin <ria.freelander@gmail.com>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Lech Perczak <lech.perczak@camlingroup.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v4 2/3] dt-bindings: sc16is7xx: Add compatible line for XR20M1172 UART
Date: Fri, 19 Apr 2024 15:45:02 +0300
Message-Id: <20240419124506.1531035-3-rilian.la.te@ya.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240419124506.1531035-1-rilian.la.te@ya.ru>
References: <20240419124506.1531035-1-rilian.la.te@ya.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Konstantin Pugin <ria.freelander@gmail.com>

Add EXAR XR20M1172 UART compatible line into devicetree documentation.

Reviewed-by: Vladimir Zapolskiy <vz@mleia.com>
Signed-off-by: Konstantin Pugin <ria.freelander@gmail.com>
---
 Documentation/devicetree/bindings/serial/nxp,sc16is7xx.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.yaml b/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.yaml
index 5dec15b7e7c3..c4bedf23368b 100644
--- a/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.yaml
+++ b/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.yaml
@@ -12,6 +12,7 @@ maintainers:
 properties:
   compatible:
     enum:
+      - exar,xr20m1172
       - nxp,sc16is740
       - nxp,sc16is741
       - nxp,sc16is750
-- 
2.34.1


