Return-Path: <linux-kernel+bounces-76930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C2285FED0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:11:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70E4228B023
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DFFD15530F;
	Thu, 22 Feb 2024 17:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="M4jtHvnB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3Q+QcESu"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBDC153BF3;
	Thu, 22 Feb 2024 17:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708621872; cv=none; b=ZwuYWLufeoDbx9zHuOA81cp1ZDEQEz+EIIQlXT7AfIuVRsPuKtRfrFARpUqk0EyBvYN724/tZ/pGk/T8w6kMN+zJCfUTeilGSQpKfMCBNxfveHX7E0Xb6MNhwyOq3NVubhpyeGZZD42gpLGfy64KbfbFSdHqMyF4ud9P24rh+MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708621872; c=relaxed/simple;
	bh=fhfHpIMqaM4fbG/FR0K685Bu9Yn3xqdYqITsZ44AMnk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=jwQ9oAblEJO0Gh5U3pJLkwk7PiqijoLlsTXWGofeIJ8SDUTl/IGMu6T+xSLs6Lygg1XdFa+eN1m/KWY+1bULxsT+hbd+M2xar46Wrio0kwf22m4ajLKpDA1UL/c8f903zd4XLTGZ00zsoLefJuFX7JPi2Isco7QhM+Q1OXMP4xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=M4jtHvnB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3Q+QcESu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 22 Feb 2024 17:11:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708621869;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n3l89YakFMzkkqtBwvxDaMLSMPwWErlyVtJW1ihuNxA=;
	b=M4jtHvnBj4ofiBUZoxJJtY/ywqurJzaeVdOWPJy7I7zZ8GWENi3ULhbDC1dLi4k89NRDrw
	pcqFTyWivV5tNRf3dWfCKYY1ItgoPECzqVKIlNRqzFP4F37vA9Q4cd0cDpl2yyfQeG3auJ
	KbQFntU/xT/5m/YmRdKW+YSqf5hFAp0UDkGej1Bma62bBHgDMEUjm3M8vrJpCTbn1v/+JK
	dnlBfWBLo2aPLiNsB20+7WRtgZSBfUjsYuulWnSh/FO6r1veQRS529qGABQdpc1TyO5QH1
	vpChzsQ/0gJ2i2rPkS++ZXiGc7cDA1hzWzveXB1pOV2oUJOqK3LEyvCwy/jyAw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708621869;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n3l89YakFMzkkqtBwvxDaMLSMPwWErlyVtJW1ihuNxA=;
	b=3Q+QcESuYALkzxomIy5YppKh5ITCusauRauQ7Ttx6VEAsv2yi8zaiOxHiwUOJLJUgz7wLq
	Glbtcae63Cv7xGDw==
From: "tip-bot2 for Huqiang Qin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] dt-bindings: interrupt-controller: Add support for
 Amlogic-T7 SoCs
Cc: Huqiang Qin <huqiang.qin@amlogic.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Conor Dooley <conor.dooley@microchip.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240222074640.1866284-2-huqiang.qin@amlogic.com>
References: <20240222074640.1866284-2-huqiang.qin@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170862186891.398.17078043919272703898.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     4a0705bb83d6edc7207e94d8d07ba5e5c27814b8
Gitweb:        https://git.kernel.org/tip/4a0705bb83d6edc7207e94d8d07ba5e5c27814b8
Author:        Huqiang Qin <huqiang.qin@amlogic.com>
AuthorDate:    Thu, 22 Feb 2024 15:46:37 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 22 Feb 2024 18:04:42 +01:00

dt-bindings: interrupt-controller: Add support for Amlogic-T7 SoCs

Update dt-binding document for GPIO interrupt controller
of Amlogic-T7 SoCs.

Signed-off-by: Huqiang Qin <huqiang.qin@amlogic.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Link: https://lore.kernel.org/r/20240222074640.1866284-2-huqiang.qin@amlogic.com

---
 Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.yaml
index 3d06db9..a937447 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.yaml
@@ -36,6 +36,7 @@ properties:
               - amlogic,meson-a1-gpio-intc
               - amlogic,meson-s4-gpio-intc
               - amlogic,c3-gpio-intc
+              - amlogic,t7-gpio-intc
           - const: amlogic,meson-gpio-intc
 
   reg:

