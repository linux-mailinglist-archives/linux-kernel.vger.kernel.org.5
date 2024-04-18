Return-Path: <linux-kernel+bounces-150166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 312CC8A9B37
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE3F0285CEA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D4715FCED;
	Thu, 18 Apr 2024 13:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b="H0maqJwI"
Received: from forward500c.mail.yandex.net (forward500c.mail.yandex.net [178.154.239.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F75F15E1FE;
	Thu, 18 Apr 2024 13:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713446742; cv=none; b=nozHe7ZF32ekFAziRytf0N4zgEfubZcEVpBPk5UT+v0ikvjDlZwwD/4GXzshcUx3Gf7bEGRYKFi6GP5xXydEWUWd6UbEtDU77ZA3ih1oFuoZa8y6gf00MkLTA12vIJiQqsaCUb9okMGxXxDqqUA25x083DgJ+Kiix1qijrcMNbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713446742; c=relaxed/simple;
	bh=Jg08ugN7crLeraSu3t+b58lZjcn71WokINIQzw7wMhg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WJzGpAafpFApfGwn8BJSXUmtqETCLfWnJVbWX5DvY1FvBzDv2gbry6hqGrXbMivhS5kKwDOOXF35jbbn8eNfiWFTmx8N0gQSZOWM8rnag3gz0rZ37NTHmmGFh2ZM5RUC4urV4iDPjaJ8KGDE63viKcBlEDW3LCCTeREifxkoJJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru; spf=pass smtp.mailfrom=ya.ru; dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b=H0maqJwI; arc=none smtp.client-ip=178.154.239.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ya.ru
Received: from mail-nwsmtp-smtp-production-main-38.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-38.myt.yp-c.yandex.net [IPv6:2a02:6b8:c05:84:0:640:40f8:0])
	by forward500c.mail.yandex.net (Yandex) with ESMTPS id 543B3610E7;
	Thu, 18 Apr 2024 16:25:32 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-38.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id HPFFWsDX0Cg0-gm6CoVTK;
	Thu, 18 Apr 2024 16:25:31 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail;
	t=1713446731; bh=s/N54e29hO90jNvjku5sez2Ii+TUoqQT3STMI5kSKjw=;
	h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=H0maqJwIMOb/0DaFc3IqhxTtwGXzxx2bpWXDvSZShu7w0P5m5GEqsDo79QHQJQMgG
	 1VAorcGf8DnHVIaXN0ibO2nswKPkd5ie+1wSBxcvQDHPHyYs6DdGPy+iktC97Cu8aG
	 ppOG9yysbjQOQ16owczcWOehTW7dwyKMVXvVME1c=
Authentication-Results: mail-nwsmtp-smtp-production-main-38.myt.yp-c.yandex.net; dkim=pass header.i=@ya.ru
From: Konstantin <rilian.la.te@ya.ru>
To: 
Cc: Konstantin <ria.freelander@gmail.com>,
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
Subject: [PATCH 2/3] serial: sc16is7xx: Add bindings documentation for EXAR XR20M1172 UART
Date: Thu, 18 Apr 2024 16:25:04 +0300
Message-Id: <20240418132508.3447800-3-rilian.la.te@ya.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240418132508.3447800-1-rilian.la.te@ya.ru>
References: <20240418132508.3447800-1-rilian.la.te@ya.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Konstantin <ria.freelander@gmail.com>

This patch adds the devicetree documentation for the XR20M1172 UART.

Signed-off-by: Konstantin Pugin <ria.freelander@gmail.com>
---
 Documentation/devicetree/bindings/serial/nxp,sc16is7xx.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.yaml b/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.yaml
index 5dec15b7e7c3..68fe7b11961c 100644
--- a/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.yaml
+++ b/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.yaml
@@ -18,6 +18,7 @@ properties:
       - nxp,sc16is752
       - nxp,sc16is760
       - nxp,sc16is762
+      - exar,xr20m1172
 
   reg:
     maxItems: 1
-- 
2.34.1


