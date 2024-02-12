Return-Path: <linux-kernel+bounces-62309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A18851E5D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 21:06:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C874FB24E7B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 20:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14A74D9FC;
	Mon, 12 Feb 2024 20:04:47 +0000 (UTC)
Received: from mx.skole.hr (mx1.hosting.skole.hr [161.53.165.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFC347F57;
	Mon, 12 Feb 2024 20:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.53.165.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707768287; cv=none; b=LvdYBcFKfghwVQ9HaP27/kk47Ui6xB1qcg7iNHm/Bf1QNkFN1LMNqpQ4U8NKX/WDzlwgYLeh9pVsyDXKZQPx23iSlrLSfmfSVqd6wQtYxM7W/XQk7mjt3qf3pjEkRPEtZhN8Heeht9aqGg+nl5YB7YEIQs35emHrNOYYH19WMtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707768287; c=relaxed/simple;
	bh=H5SASPixAqUHq3Nu5xj+/KLu5M1naq1Am/HTSAj4Qig=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=pBzFbEGdbC1e5zYEsONwjw5BJ53WFpHwNNR4BoqbmKGsKv8at5HUoVJvYKOX7YkLwJ6Upi5tLo+h87HKvOc1PAc42Ah+Ii3QidoVQifgTlUBHjb+fX6ekFR8Vt6nMpMFy0vKk6L18zh7+KkNPBXr4k+Z60G44ugg5NbX/BxaUwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skole.hr; spf=pass smtp.mailfrom=skole.hr; arc=none smtp.client-ip=161.53.165.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skole.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=skole.hr
Received: from mx1.hosting.skole.hr (localhost.localdomain [127.0.0.1])
	by mx.skole.hr (mx.skole.hr) with ESMTP id E072683BA7;
	Mon, 12 Feb 2024 21:04:36 +0100 (CET)
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Subject: [PATCH 0/2] leds: expresswire: Fix dependencies
Date: Mon, 12 Feb 2024 21:03:24 +0100
Message-Id: <20240212-expresswire-deps-v1-0-685ad10cd693@skole.hr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAIx5ymUC/x2MQQqAIBQFrxJ/naBWYF0lWki+6m8q/FCCePek5
 TDMZBJEhtDUZIp4WPg6K5i2ofXw5w7FoTJZbXttjVVId4TIyxEq4BYFNw5wwTv4jmpW9cbpX85
 LKR8kQUMcYgAAAA==
To: Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>, 
 Daniel Thompson <daniel.thompson@linaro.org>, 
 Linus Walleij <linus.walleij@linaro.org>, Arnd Bergmann <arnd@arndb.de>
Cc: Flavio Suligoi <f.suligoi@asem.it>, Hans de Goede <hdegoede@redhat.com>, 
 Jianhua Lu <lujianhua000@gmail.com>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 Helge Deller <deller@gmx.de>, Jingoo Han <jingoohan1@gmail.com>, 
 Karel Balej <balejk@matfyz.cz>, dri-devel@lists.freedesktop.org, 
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-leds@vger.kernel.org, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=675;
 i=duje.mihanovic@skole.hr; h=from:subject:message-id;
 bh=H5SASPixAqUHq3Nu5xj+/KLu5M1naq1Am/HTSAj4Qig=;
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBlynmgj96tx0yxiCk6LRKUNqTO/ibINXBCd6K5R
 Kv13Nu7/QWJAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZcp5oAAKCRCaEZ6wQi2W
 4UtOD/9CIR17mjfkoT3abEQNFhCVDJXwkykj/eV70cTOXmLHQYJqogh+3EJOfkyCEG8Xg5jDGx1
 jRe5pKs4RXoKgOpZNN7dZ9PlGpJdTc+cW4IxpbBrAlVqKltFH5x1OBOiQgrObxnTOqe4q6u5rfB
 cW2nW8fTnLL+pFOupFa+onY+wNLeRyDXXh0/dJPEdBsDIMVzxX8VZdXN4aKbTTViXvHWWiRFljP
 cknU797dHb6Tf1K+/Dq4XgVMqCYPpQJxkgyDql9hiSuQSaYlQUc+nf0RjFOHL4NreWQX+jtipxG
 9pUAdh5AcoDVUp+PhT9giIZUSPKGaBlsnomNN2BcP4uCXh9OOleOgPzuk7yEGhnXb4/EgxrIMxx
 TVUkyYUFqQpMvAN2OlsG1roXKQm1ow/yODTY7y0Cst46f41R8n/pZ2HJ6E9UjBLG/S5P21wc7k6
 eD0ghlPYG5knL3dk9VD0npSPY9PmD13y0ixup6J1GfROEtWMdWmyUBnplvpSjdVOACrSGRSW/LO
 lL+YEx2Ccc+KBme2eTZYjkdtggldwF9XpDGCHmaoTKO8YoxNCj2A4dMOWyFPBuEVek3gsq0l1qE
 WxD0CWMpkokK8LnYySyUvjyLTrikpqRSUWiTTuQqrVZytxuihgUP+iiVQOee5y0AtWyexIron7X
 kS/qxZVpmhMJHFw==
X-Developer-Key: i=duje.mihanovic@skole.hr; a=openpgp;
 fpr=53DF9D4D9C3FE110FB362D789A119EB0422D96E1

LEDS_EXPRESSWIRE does not depend on NEW_LEDS in practice but still does
in Kconfig. Fix up its Kconfig entry to reflect this and fix a Kconfig
warning.

Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
---
Duje Mihanović (2):
      Revert "leds: Only descend into leds directory when CONFIG_NEW_LEDS is set"
      leds: expresswire: don't depend on NEW_LEDS

 drivers/Makefile     |  2 +-
 drivers/leds/Kconfig | 10 ++++++----
 2 files changed, 7 insertions(+), 5 deletions(-)
---
base-commit: ae00c445390b349e070a64dc62f08aa878db7248
change-id: 20240212-expresswire-deps-e895e8da8ea3

Best regards,
-- 
Duje Mihanović <duje.mihanovic@skole.hr>



