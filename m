Return-Path: <linux-kernel+bounces-27905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A0982F79A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:26:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4273B23B3D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A746C85071;
	Tue, 16 Jan 2024 19:48:53 +0000 (UTC)
Received: from mx.skole.hr (mx1.hosting.skole.hr [161.53.165.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A168506A;
	Tue, 16 Jan 2024 19:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.53.165.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434533; cv=none; b=rQJnRS/UcxJqBAwpKbMFZ71ulq9zVvT7PDzs9gX/DFMq69yzlXBJH0wtD7dYA7ugCZmz/UcBcD043hufGiQpVH8TbSDWhDwHwubJQ2OTrNSO+Ol5ZS5Yt0JFDC6nD0D4DYBrocpK9pqN+wSZhPGvLYKICTPgRQ5pxL5SdnRRjCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434533; c=relaxed/simple;
	bh=rSJ5ZhtyrJrAkeuu/AG6XH4FyTv+B4s4Tai8QIXErKY=;
	h=Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key; b=X90ctj1FRLZF1LW5CiCKD7VNgVluBEE628fribDZsWyYKRU7NLSgXsmE+qiTBO8c1hIVdeD2ecoX+OSBo67V9s651/V2xtogymwnKFVTmBSoyBspd+haTudFIXE+6BCdXXOEJWCC071ud+UhlkT08g+4zNflu7sHCxNijvUX1i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skole.hr; spf=pass smtp.mailfrom=skole.hr; arc=none smtp.client-ip=161.53.165.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skole.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=skole.hr
Received: from mx1.hosting.skole.hr (localhost.localdomain [127.0.0.1])
	by mx.skole.hr (mx.skole.hr) with ESMTP id 4B9B98B006;
	Tue, 16 Jan 2024 20:48:48 +0100 (CET)
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Date: Tue, 16 Jan 2024 20:48:06 +0100
Subject: [PATCH v2 1/2] ARM: pxa: drop MOUSE_NAVPOINT_PXA27x from defconfig
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240116-navpoint-removal-v2-1-e566806f1009@skole.hr>
References: <20240116-navpoint-removal-v2-0-e566806f1009@skole.hr>
In-Reply-To: <20240116-navpoint-removal-v2-0-e566806f1009@skole.hr>
To: Russell King <linux@armlinux.org.uk>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-input@vger.kernel.org, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=696;
 i=duje.mihanovic@skole.hr; h=from:subject:message-id;
 bh=rSJ5ZhtyrJrAkeuu/AG6XH4FyTv+B4s4Tai8QIXErKY=;
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBlpt1/piXcwVNdLPedExKPOclXewqSVOSsDemwP
 KQA1P7ip3qJAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZabdfwAKCRCaEZ6wQi2W
 4XV6D/sGWlXuAIhlwdgcIo2OH2x2u1nqr2YLJV6Tvw+pag6dxbNgFyag+MC2C9lvK7Xn/2uhbNQ
 GrHpw7VOYwSC6HjNF35ulD8vH+cBXgrPq3VlKaD8JGSUiiOwT3LW57QSrAwYAm29pmaTOs8IGAs
 v6tz4EGBmiacKwa0f4DKPZUgQC39Es7n3xDknZH793Ez2SW9KSx5FGoB0qvbuT+Begmgo2jEBNB
 AkJEPclfXrA46TszchyBcropWKEpbHBztClOVJV9P7VmNXhmHt8/l/hugiiyURPamjbwnPtAV/p
 OtOzjUdu6J3qB8/UlRwy2eaj+7gsxzdWp6A19GFdyvAB+Ippp54Xub3MlFCmUaZODQsUmMqZiGP
 7IFoUysc9hz18vuc2kC0iUoTVHgGloSvg1YFy2omyQhWaTGZle7+CuGefQf8ESzhx7yIgfw08YS
 hYxqLFrCqYsk2QATZ2JVR+14lT/3UllRBVuczPQbTCjxpSxZMsoM6OCQJwN86MOoiknJ5dbiIuz
 z0rb2xaURuvWW0qgCfknGV+jdIfOf8ZrqUeXoC96sE6pU2B3to5LD0RX7oaCDlF3tdNpGKNLExX
 PQiZyVl+JA4xalbrH9mHR+Vhj6hbW8KenQX1VWRqJEKBTIqaGNAAFlgGg6u7PmwXeGPZmkoT0NB
 noKe8uQtPoR1SGA==
X-Developer-Key: i=duje.mihanovic@skole.hr; a=openpgp;
 fpr=53DF9D4D9C3FE110FB362D789A119EB0422D96E1

Drop the Synaptics NavPoint touchpad from pxa_defconfig in preparation
for removal of the driver.

Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
---
 arch/arm/configs/pxa_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/configs/pxa_defconfig b/arch/arm/configs/pxa_defconfig
index b0c3355e2599..7d6d0551a870 100644
--- a/arch/arm/configs/pxa_defconfig
+++ b/arch/arm/configs/pxa_defconfig
@@ -245,7 +245,6 @@ CONFIG_MOUSE_PS2_ELANTECH=y
 CONFIG_MOUSE_SERIAL=m
 CONFIG_MOUSE_CYAPA=m
 CONFIG_MOUSE_ELAN_I2C=m
-CONFIG_MOUSE_NAVPOINT_PXA27x=m
 CONFIG_INPUT_TOUCHSCREEN=y
 CONFIG_TOUCHSCREEN_ADS7846=m
 CONFIG_TOUCHSCREEN_ATMEL_MXT=m

-- 
2.43.0



