Return-Path: <linux-kernel+bounces-125825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7535C892CC4
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 20:28:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD168283BE9
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 19:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05FC941A92;
	Sat, 30 Mar 2024 19:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z9Dz1zX7"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB29200D9
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 19:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711826904; cv=none; b=jqWnkSdVzTWEWJuVyP9I4PvZGOHE8uJvUIuHnTFYipxbAc1SNkTceL7NiqtLkO2s3h+ifABrykbe8SVbPebXOMAeruRSHreHMtdyDxjHtuCl0a1rqyTn9G48tZ0WkF/cefs4DqrYk2B7TDoPamYtZ/83J0oCe5MqMZVJ9qpsjvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711826904; c=relaxed/simple;
	bh=7vXKpt5kMvjCw/Bc7RGx8qUv2326+xlY2fMwnqF4N4g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aoNX3Be0K9MQiDMmK4Vg9HknM1CABE/x/tOYHisvDMK+RYmvJ5naegHTztAuniaQ0763RVi0ACnYrmH3MRv4KzzbTJEQqJ3DYxjVnvaWueOWnMN5DLI/S8Lst3v/tzugNv5+w0EXu/bKuDmyA27dTpKob5bdYztT5fako//6UxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z9Dz1zX7; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-513cf9bacf1so3534070e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 12:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711826900; x=1712431700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=srlPnSviOUwCOp87gd3on0IVNQFTAHaOJjEVsmn3f5k=;
        b=Z9Dz1zX7HpqgMm052RpuRSPv0drcZ3DPp1ohf47DzUsHgXofy0E6FkfMl40pHtTXhp
         doDvuUux/Kj6W9pPBX0tLpfX/K7+LpGATgd0HBoQVkyuZqjs8uHwQcZ2UzVSqoNrEYjB
         TvX6hGzHugjT+eWwQPPY7sRlo0xFd/UaQl+JB1j39bd+tGbO9YyQRLyo3UlMkEaMVCGp
         yvCiLroH7IUwtTnVnXhaoS7wrGexyO+DcJg93wvUbOf9kdwYtR6TztnzChTP2SlxNQYO
         5YPUf0CH3eOV5648lhxpmoTADmOhhYYbbkqM+oBxF4Ryuszg4NdTnQWC0QunRW9YJRXW
         MW/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711826900; x=1712431700;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=srlPnSviOUwCOp87gd3on0IVNQFTAHaOJjEVsmn3f5k=;
        b=nmljWOV1kpJOJSNzHJjHqj14L9Sc01Kz/ESSVu534szFAfONrLeOUnynSePEft2cnZ
         pSuiON3CewSfBNi/n9WEJSOhLp1Fx9czq40D9JBMDuX5vRL1qQJTaSKWDymGn/jDxFhj
         hA2SMby9QfWnqBSm3e2WVMjFCCSyWtBEgVda22lDqWm2wm9Rbyo69vR475o5aK7F5EiA
         vczkIsUcmrmHqH1zyi0R0u2juYsau1mbrRYB77f7GwbsI7/XST/lsjJSRssrWir77zMT
         O8clmwaaDuZh7/gmT0TYAljU6cP5hoFRZubIuNyUL5HaS9JUwayfpUcBBhCpHAFlEtA6
         XoVw==
X-Gm-Message-State: AOJu0Yw9D0EWeZSJxDHluO7qx/Z9CZBDqUj7ev1A5ZFoxzvEb1rHB3zD
	XLi1ijaLxIgugETjRdiXQtf4mvcLYfH944PZOMyzfCsVdYOJtAeaCPajM/ZC
X-Google-Smtp-Source: AGHT+IEZJYCyfcR8jAGfDFTKGPYSicuEDHPpmmv3WNj/2Q89aUFk1IiBRX928ctlFdxHkj3sONe3Qw==
X-Received: by 2002:a05:6512:457:b0:513:dae2:dd7e with SMTP id y23-20020a056512045700b00513dae2dd7emr3279642lfk.32.1711826900356;
        Sat, 30 Mar 2024 12:28:20 -0700 (PDT)
Received: from archlinux.. ([5.104.47.249])
        by smtp.gmail.com with ESMTPSA id bi39-20020a0565120ea700b00515ac90f746sm962966lfb.249.2024.03.30.12.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Mar 2024 12:28:20 -0700 (PDT)
From: Dendi777 <starrynightowl2@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Dendi777 <river.blaze@mail.ru>
Subject: [PATCH] Add support microphone from Acer Aspire 315-24p
Date: Sat, 30 Mar 2024 22:28:17 +0300
Message-ID: <20240330192817.2175-1-starrynightowl2@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dendi777 <river.blaze@mail.ru>

---
 sound/soc/amd/yc/acp6x-mach.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 69c68d8e7..332a68cde 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -430,6 +430,14 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "MRID6"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "MDC"),
+			DMI_MATCH(DMI_BOARD_NAME, "Herbag_MDU"),
+		}
+	},
+
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
-- 
2.44.0


