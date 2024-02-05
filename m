Return-Path: <linux-kernel+bounces-52930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9735849E7E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:36:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75F9C28CEF7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C98945947;
	Mon,  5 Feb 2024 15:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Je6psvHr"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127903A1CF;
	Mon,  5 Feb 2024 15:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707147318; cv=none; b=Nf8NrMvWFQuvBYdc1/is6pUVd0NGwMeVENdpwXrsM5gJWMA36MG8xtwcY4gUZ8cPV9SbBDnApXwTq584+7SvE2Ha6A5ZxMlixx2Ignpc8jwv/bNmZFZMxkLIVWaK28/cGdJ4LYk6MnXefBFtHbK0sHfLgDHC6BruhmiBapqLbus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707147318; c=relaxed/simple;
	bh=F69lXcW+BMK3xWuWKAunG1z8qeZUfL/FLTg148TbGsU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=peSqYQvHzGCjNJrtdL+TIOvA0KxRVmCWGQd8PbfRLn5IOX6PCD3aNnLDSuBPMZXF1+jbqfdHw2mjTjXlrtiuRjv7uKJmO1O0JIB70g83vqvjYMNtrySOEds+aANQ9yszwm1adLjgpMMk9a6/rt6E0igrNs7YJItXLXX3QFAJMtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Je6psvHr; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6C32F20010;
	Mon,  5 Feb 2024 15:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707147314;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GbsWh/XsZeOFv6yit27z5l5/TqUISO3EzDeBeQy/R68=;
	b=Je6psvHrJ9MCiX4Z7guNm8f0H31MFCdLInAkLRPKVMic9pynQmaM8hj8U3uXOeU9MENs0p
	FQu5p9GT5Oct0bQUGtqSVn9aYOlhDqFgSeBBtgC7SJf5EOd2Yd4GlwzfnDa+GiiH0/4Wly
	cvjmoU9Znm/PfnLKMircaVMj3sFoJRh45OWUvv5jWqy1X4p2HHml7I5USL2LtrBiGkMnHS
	wvG/Fnea6cfgWD5Ukkw26fPHvO6sRI7rYdZ56y8Xg/ro8GaDV8CUqBvb5Vvu1cvyQTM2FZ
	7LF3CXw//gJDydBkHqV/vfx/Xk5q161zwdRSBTBpm3sfO/2sN4VarCk4XZikqA==
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Paul Burton <paulburton@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mips@vger.kernel.org,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Vladimir  Kondratiev <vladimir.kondratiev@mobileye.com>,
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	=?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	Arnd Bergmann <arnd@arndb.de>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
	Serge Semin <fancer.lancer@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v7 08/14] dt-bindings: mips: cpu: Add I-Class I6500 Multiprocessor Core
Date: Mon,  5 Feb 2024 16:34:54 +0100
Message-ID: <20240205153503.574468-9-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240205153503.574468-1-gregory.clement@bootlin.com>
References: <20240205153503.574468-1-gregory.clement@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: gregory.clement@bootlin.com

The MIPS Warrior I-class I6500 was announced by Imagination
Technologies in 2016 and is used in the Mobileye SoC EyeQ5.

Acked-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 Documentation/devicetree/bindings/mips/cpus.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mips/cpus.yaml b/Documentation/devicetree/bindings/mips/cpus.yaml
index 9bc47868d28b6..a85137add6689 100644
--- a/Documentation/devicetree/bindings/mips/cpus.yaml
+++ b/Documentation/devicetree/bindings/mips/cpus.yaml
@@ -23,6 +23,7 @@ properties:
       - brcm,bmips4380
       - brcm,bmips5000
       - brcm,bmips5200
+      - img,i6500
       - ingenic,xburst-fpu1.0-mxu1.1
       - ingenic,xburst-fpu2.0-mxu2.0
       - ingenic,xburst-mxu1.0
-- 
2.43.0


