Return-Path: <linux-kernel+bounces-128030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF98E895530
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A847288B08
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D29B84A35;
	Tue,  2 Apr 2024 13:21:24 +0000 (UTC)
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54E78062A;
	Tue,  2 Apr 2024 13:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.85.9.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712064083; cv=none; b=INORBFMIRaT3oJ0yEAilIIGiKtmNrvdaFCimaGJs0YuKNS/38HGvLU/mVrT4Sz1DGCcDoNMwDXe1eyHAD+EQK4OLWm6gfIa3nc2jQrX90XCX9VbFEw/oCZLhPU4gJof6DUTAS+62UpfcrWD4Z1QKysfpiy1L+ZE1bCUTWl87j+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712064083; c=relaxed/simple;
	bh=sdtIYg3ZdiO4IP9Alix4cpyyxg6EShPVCuhYfIi63w0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Mime-Version:Content-Type; b=HvphE8vgyB1Iw29X+FtuyjHqtINeAr+ng1iRfmJIOiU1H8rOq8Yl2p205MbHCKi7w9TfRWxKQ/e68U6FjoJDh8I8FZs5mP8W7KnYjGHinoZV8oLbzJiAyszUoIVQSTokbl+yE8+loN9R6g3x+Y8xl+CqWs5byB+b1GvQ/93Nc1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu; spf=pass smtp.mailfrom=irl.hu; arc=none smtp.client-ip=95.85.9.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from fedori.lan (51b69867.dsl.pool.telekom.hu [::ffff:81.182.152.103])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 0000000000064387.00000000660C0649.002529B9; Tue, 02 Apr 2024 15:21:12 +0200
From: Gergo Koteles <soyer@irl.hu>
To: Ike Panhc <ike.pan@canonical.com>,
  Hans de Goede <hdegoede@redhat.com>,
  =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
  Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
  Rob Herring <robh@kernel.org>,
  Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
  Conor Dooley <conor+dt@kernel.org>
Cc: platform-driver-x86@vger.kernel.org,
  linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
  devicetree@vger.kernel.org, Gergo Koteles <soyer@irl.hu>
Subject: [PATCH 1/3] dt-bindings: leds: add LED_FUNCTION_FNLOCK
Date: Tue,  2 Apr 2024 15:21:00 +0200
Message-ID: <8ac95e85a53dc0b8cce1e27fc1cab6d19221543b.1712063200.git.soyer@irl.hu>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1712063200.git.soyer@irl.hu>
References: <cover.1712063200.git.soyer@irl.hu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mime-Autoconverted: from 8bit to 7bit by courier 1.0

Newer laptops have FnLock LED.

Add a define for this very common function.

Signed-off-by: Gergo Koteles <soyer@irl.hu>
---
 include/dt-bindings/leds/common.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/leds/common.h b/include/dt-bindings/leds/common.h
index ecea167930d9..d7c980bdf383 100644
--- a/include/dt-bindings/leds/common.h
+++ b/include/dt-bindings/leds/common.h
@@ -46,6 +46,7 @@
 #define LED_FUNCTION_CAPSLOCK "capslock"
 #define LED_FUNCTION_SCROLLLOCK "scrolllock"
 #define LED_FUNCTION_NUMLOCK "numlock"
+#define LED_FUNCTION_FNLOCK "fnlock"
 /*   Obsolete equivalents: "tpacpi::thinklight" (IBM/Lenovo Thinkpads),
      "lp5523:kb{1,2,3,4,5,6}" (Nokia N900) */
 #define LED_FUNCTION_KBD_BACKLIGHT "kbd_backlight"
-- 
2.44.0


