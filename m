Return-Path: <linux-kernel+bounces-105958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9668587E6D7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7011B222B7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D273FBB1;
	Mon, 18 Mar 2024 10:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KEIS8HLJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OLHMV/Db"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761863BBDB;
	Mon, 18 Mar 2024 10:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710756468; cv=none; b=KFBkr0D8IuuhU8p+HsyJfy254DZLLIbzQIwmOi4kFjx+5W5UHKRv4Kk99h7G+/H0CtAv44lLu7Y+OY+Ki4V2DW2e/+HZty44DTd9aaiF2cBIDVkp3aztMInF2INeQx8Kfxt2eXvLe8x0Qj2wDxU1YRK2IUa5v5NPIOu2z2LI1Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710756468; c=relaxed/simple;
	bh=tuvXGfgR+1KdCJc2RwcMK9PYrLjYgWA98gR0MQQ6vQs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=YMVZeHIfTepKEhj9yp/JD8iA8XUYC89zU8rX0AwZXNDMwscwzDm6R0YlFQRJYbWL7RDM9vjVaerDTor+p9bW9XKrnFQCHTJZIiTU2NKIRm3PKMl5JsNAFLmE9C9CQ6wYf6YN/zsCgoRh7/N8ebU5HgyK/reeBVF5eg2YQfmOPzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KEIS8HLJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OLHMV/Db; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 18 Mar 2024 10:07:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710756464;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=desXKOgIlCtSTB6AIowYe1dACdqnPFU9uPprgBgjYDo=;
	b=KEIS8HLJTqh6tuhAEwEPDZK89u5qGuvVzm8CwCGl5ij8D6CAseOBXJq8E+/rTRc6EDGk/r
	YFc6pV6c3xEER5GND3KzndLNIhPrwn78fheELAIzOWs5EYoGtvUpzTR17bsOshjvOP3mfS
	G7CVzM69fm32nDbbF6wX1o7FcHTx0AhhOP+TeQoAYTiFc4ISYvvIuL3bRSh+qKSw1BgFon
	qxrIn/UFs1Oz8r8hknnekC/rhMOul2i1sb4U0s40o3Zj5Ur4BUzrkdnLKoNRPMSq2uouDS
	p8tl/jwo+I0GT3JKQHChjVK6KLrN6u670vs+2zCERBwEcMvhVC735ypMKOMTAw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710756464;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=desXKOgIlCtSTB6AIowYe1dACdqnPFU9uPprgBgjYDo=;
	b=OLHMV/DbGob//nHmSn81XRHkRHvxQB3qJ8HQxCDJvojIppsZNMkfANIqEr8b5yNTEDGOMH
	nWgNd2n+0jp5ouDg==
From: "tip-bot2 for Peter Griffin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] dt-bindings: timer: exynos4210-mct: Add
 google,gs101-mct compatible
Cc: Peter Griffin <peter.griffin@linaro.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20231222165355.1462740-2-peter.griffin@linaro.org>
References: <20231222165355.1462740-2-peter.griffin@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171075646409.12214.9777978753222649978.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     f253c9a1aa3360bd6d61407dbfc6ca002855caa3
Gitweb:        https://git.kernel.org/tip/f253c9a1aa3360bd6d61407dbfc6ca002855caa3
Author:        Peter Griffin <peter.griffin@linaro.org>
AuthorDate:    Fri, 22 Dec 2023 16:53:53 
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Mon, 22 Jan 2024 13:11:27 +01:00

dt-bindings: timer: exynos4210-mct: Add google,gs101-mct compatible

Add dedicated google,gs101-mct compatible to the dt-schema for
representing mct timer of the Google Tensor gs101 SoC.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20231222165355.1462740-2-peter.griffin@linaro.org
---
 Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.yaml b/Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.yaml
index 829bd22..774b799 100644
--- a/Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.yaml
+++ b/Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.yaml
@@ -26,6 +26,7 @@ properties:
       - items:
           - enum:
               - axis,artpec8-mct
+              - google,gs101-mct
               - samsung,exynos3250-mct
               - samsung,exynos5250-mct
               - samsung,exynos5260-mct
@@ -127,6 +128,7 @@ allOf:
           contains:
             enum:
               - axis,artpec8-mct
+              - google,gs101-mct
               - samsung,exynos5260-mct
               - samsung,exynos5420-mct
               - samsung,exynos5433-mct

