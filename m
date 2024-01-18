Return-Path: <linux-kernel+bounces-30511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B88831FA7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 20:24:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B32621F25319
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 19:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 554E62EB04;
	Thu, 18 Jan 2024 19:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D7SFWs5M";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bkTD2YfB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31E72E648;
	Thu, 18 Jan 2024 19:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705605843; cv=none; b=W/DjtRsv3piqIQUJwt7aYTarmFLyylyLGlVcth9PPBVzuG5TK6fdyevKHQybF/+CiEUVK4DpRweuwteJewOQ7Rj2SMHBfJdPSMof04EUOm4FCx9p2g4krLBf3Xha3B+Olf33c4nFNvd6fhRHcAK7g7MXePeK3c6tCOFe0xTtwbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705605843; c=relaxed/simple;
	bh=tStS/B9KG5gGvBnwX+gfx5AY4hhqpHpzIKSg9h1csDA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=iergX2sN8Y3gFPCKDDBz8a5YfhbD5I8qjXi2+NDr8vWUCdWza5Cmh7LH3mKAuWlXlcpKoTu01Lmi3D6FKoa5qcvuuFWKc5vrNLDczraQ4wrlpOc27ePHksheHZ4boOhdbLcCXyz80AdTzNTTYqWUyqHr5lRWSKUpbD81ENr87ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=D7SFWs5M; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bkTD2YfB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 18 Jan 2024 19:23:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1705605840;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Za10UEWMH8hZGiBS4E3s+Ih2vBf/Xgtyr/VdgtySCYI=;
	b=D7SFWs5MsG1J13BlS1ywykXvzLiAdm0aYfpf1qg+Wn1IOy3DEL3jIBy7kzFXBHybdPXTzf
	nk8cVwGQpOd0QaMZq7ZXyIOKJAMIWKvTk4X2gpNhIXjfHdut5NYJ3DpS2eL7HLblqHwEl1
	CQa3ZkSAfBlLF6oPulHVM8hsscZm5wp7bJBKspNnAdJOElBcV4yU+LKt1/QfVuFe6VJX9W
	FWgOFNhV7uaOpLhwiYIcfil4Z9j2eZ1HUx24Xa5k+5WbSMVeoFHAb8pC5/W5THRtjX86JD
	GBYALtdJKcqlsJmKvtbtJWpeLvlvsfJSQNhC5NTGIGWmv0cXBPcsk147Pqdcdg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1705605840;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Za10UEWMH8hZGiBS4E3s+Ih2vBf/Xgtyr/VdgtySCYI=;
	b=bkTD2YfBVWejomP/fGcy0T/sEv1EgXy/8a6Xm+xF2bEcKJM3NREgXNheax6UVUvtFf7cxf
	DjV8U9vRYJ3PqXCw==
From: "tip-bot2 for Sia Jee Heng" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] dt-bindings: timer: Add StarFive JH8100 clint
Cc: Sia Jee Heng <jeeheng.sia@starfivetech.com>,
 Ley Foon Tan <leyfoon.tan@starfivetech.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20231201121410.95298-4-jeeheng.sia@starfivetech.com>
References: <20231201121410.95298-4-jeeheng.sia@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170560583956.398.10075614859421009889.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     e0cf60151e6317c654c42ba0e8b1fb6ff477489a
Gitweb:        https://git.kernel.org/tip/e0cf60151e6317c654c42ba0e8b1fb6ff477489a
Author:        Sia Jee Heng <jeeheng.sia@starfivetech.com>
AuthorDate:    Fri, 01 Dec 2023 20:14:07 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Wed, 27 Dec 2023 15:37:11 +01:00

dt-bindings: timer: Add StarFive JH8100 clint

Add compatible string for the StarFive JH8100 clint.

Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20231201121410.95298-4-jeeheng.sia@starfivetech.com
---
 Documentation/devicetree/bindings/timer/sifive,clint.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/timer/sifive,clint.yaml b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
index e8be6c4..0125426 100644
--- a/Documentation/devicetree/bindings/timer/sifive,clint.yaml
+++ b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
@@ -33,6 +33,7 @@ properties:
               - sifive,fu540-c000-clint # SiFive FU540
               - starfive,jh7100-clint   # StarFive JH7100
               - starfive,jh7110-clint   # StarFive JH7110
+              - starfive,jh8100-clint   # StarFive JH8100
           - const: sifive,clint0        # SiFive CLINT v0 IP block
       - items:
           - enum:

