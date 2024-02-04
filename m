Return-Path: <linux-kernel+bounces-51720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91CAD848E94
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 15:46:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 183381F219B9
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 14:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C3B2231F;
	Sun,  4 Feb 2024 14:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=marliere.net header.i=@marliere.net header.b="EU//pie3"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDAC22261A;
	Sun,  4 Feb 2024 14:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707057970; cv=none; b=smKfu9WZjiugZqX167sRBsXKi85OM5Lcuecpb2MoR6CLdemEMhLalXd2Vf6IJPahKw2p4lLvwNsRrRedv0DnThPQ6JRnRmyM1RAyKBKCaWCxb6YIwFaKpULZH2JrKIHfIRvgILeIAk9GoBqupvQHawU3iFTwnx21QbJnlgbJj5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707057970; c=relaxed/simple;
	bh=TWVQeUtiEPT92Q9WFLCYcqlWO1GeqNeUCsVF+Eq2Hw0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=fBUSIpdvxeFd577AQA6yNR29K9chNi7Vz4kiCpZrHtFcGaHsFO86RblkBtEOkIE/cZM+l7lwLDZiuMQoQTBV8bs/vaqedOs3lCpfSkd6E9T4WOE2ZKbABMckpmLJGIVFCiRPFccztfx+v+36s5MvdNF5mtXUI9K9vZrTncSTIQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=fail (0-bit key) header.d=marliere.net header.i=@marliere.net header.b=EU//pie3 reason="key not found in DNS"; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d74045c463so28049345ad.3;
        Sun, 04 Feb 2024 06:46:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707057968; x=1707662768;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LxUHnqUEPBSaX51F80aw+Y1xnfr/HMwfRHXCkVCiw9c=;
        b=peCBEHydlhZTbsdV8QVa9Qui44s0wKvqf4pDyO2cDlMLaQK43ezsmEq9LWnVX+wIQ8
         5l8OUfms0ixWV1L1ZoThOCchHTcgGkf6UrOmq6AnkNpQdKYWh1u9dUtubOvqCpghDExS
         hUj4WOpkdQoZ03sfXdri6nqqZC5OaoBX7zdd5Eja2fxUtnJn6VXyBxJHmEfdegDcrLRY
         Bka5WJoOAGGIModqQmnevl+lj+8QYbjgBFiBvuWg07mBLVFaMVRufNnRmZ59SSP5g7Ri
         BZVONrRJHdJW620a+JY/VjlqRXes/RhA2sJMQ7rTNVc8s/bWK9KbQx5PH32zxyJJ19lc
         rn8w==
X-Gm-Message-State: AOJu0YwFqRvkVNsLEj7acll+cSnaDUCWhw5Rtp17Tqa1wGPNe44HsQOu
	GR2FUqRSAcDt16I0XQvod8Z/joCkA6s9UhzJZki4tVfZTEA6C6CYiF5+jt4un0IP9w==
X-Google-Smtp-Source: AGHT+IGrN35WwWpYwA6OESCT5Z92IvT0vnKTv1mTmLvxqim49d4BcPjrIvL+3J/3C2yVEI5tVYAO4A==
X-Received: by 2002:a17:902:d507:b0:1d9:b3d7:fc44 with SMTP id b7-20020a170902d50700b001d9b3d7fc44mr608214plg.22.1707057968102;
        Sun, 04 Feb 2024 06:46:08 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCW4PvKWxfPp7ft2WZBUrXD4BRE//gsp70J/CIEzrCI6OFphBI909zD3GjphHjgyF7BZEhYuZUM5HBWrj0KCgKwQ7/LuRNh88k3pVgqW2ga4bCqbHe+00m2mrh8VLLObxpaEeRiNnW1y1gnnRTeYvGf8Rg0oRu3CwNCo/nQQY8NojQEXZeBy4Fte27mWXHMedHPQ7tg+GdWr/pG8Iiab/g1EStIkP/zPs+wU6amKMhN0v3ApXu904/HPqyIkwcmtizW5jmG/
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id jz6-20020a170903430600b001d9af77893esm544875plb.58.2024.02.04.06.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 06:46:07 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2023; t=1707057966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LxUHnqUEPBSaX51F80aw+Y1xnfr/HMwfRHXCkVCiw9c=;
	b=EU//pie39SpE58nNs8n1tU61aO+mH++EMkffUZu8sIURu3/RejTO5i716ZMRuBe7p2BdjE
	3aTbv8PNIMoivL7by1mhmrO8r5WMc0ylCTaOzijDYYxOMySV1Ak7zDXDhsrSjKuMJk+PJx
	Rqxmz1Sb3HeV4Lp1rmDBORgAKXpqBQxRuglWu938dsUQQHyzlh0Hkf+uVl+KVDaa5edCPn
	ppDYfGj9FYOyi8mtRxyzsrRSNFoQlsO9kJMc+ViCY0pygnO/U80GEdUIA5Xvfg04dso8om
	Mnd4MBnnzZ87er3A4I7H/C4CJUB0SgbXI2TvlgMiYJ4hB6LkuyBeSetstaBDdA==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sun, 04 Feb 2024 11:46:21 -0300
Subject: [PATCH] arm: s3c64xx: make s3c64xx_subsys const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240204-bus_cleanup-arm-v1-1-41d651dd8411@marliere.net>
X-B4-Tracking: v=1; b=H4sIADyjv2UC/x3MQQqAIBBA0avErBPMpKirRITZVANl4WAE4t2Tl
 m/xfwRGT8jQFxE8PsR0uYyqLMDuxm0oaMkGJZWWSmoxB57sgcaFWxh/irqrWqmxaXC1kKvb40r
 vfxzGlD4q7CcnYQAAAA==
To: Russell King <linux@armlinux.org.uk>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1088; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=TWVQeUtiEPT92Q9WFLCYcqlWO1GeqNeUCsVF+Eq2Hw0=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlv6NL04YUdv87nqZBycEDz7SB3sDXKzwFaVZO0
 I7aNzihEzuJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZb+jSwAKCRDJC4p8Y4ZY
 psuQEACMM0dV32IBqOoFJrhbusS34rxjU7sJeq1mUvbeIFw1cem3UMh/tShfAtM6DfOOuSFJPrE
 YXfdbuvizEYHOZPuvrwbiXvP+dB79Doa0ynBIt/u3ulznesssgfyIKeBQev4hkVs0wUl2EyHad+
 HYXsiLji8wA51mcWTzmiFOY+PksQwXI4FeqiDOPJ60OMRogy1n0NaaNAuRa6a1phjzt1Hw8VXpg
 DnX7gIqlE85iyTGcIHsWXaFMhAKlFNHT0XzPHd0t5+A6vHdR4+wDdF2E1MK/NaTEQddPfHRL7/D
 c5QEedkaORIx6fdmUdPFAia4JHdgIjMJ/g3/580nxkXxkl596pwIrKnsw29EovKkGCSs7zcImZu
 vJ/shKPU3+a/cAOrwLt+g9g5roZpsugvNEjqSvalAxSj7GcMM3hYwyRFM/9W1MA+AailMbj1a+m
 NR0iYEp+p/j09dlomssFPZx+svySwVSRmwx497kABPJkN24a3Zgd+1xmxZpNvI6F2xHcZJMLfOL
 3jUlcKSp4kPrHRYrlerNPZVZorV+z2eYGE/uAygiHW/EbmZyR9tU+L1Le++vTcjNlCq7TbR4fZT
 KA0QTdBuPUcOvX1x/aCnvCKruUfv3+CdWtDgPwIVKPo98oS0GTJdbleCEsRhH/A52OhiY/QSqMT
 yHxuyAJzDHQKfIQ==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Now that the driver core can properly handle constant struct bus_type,
move the s3c64xx_subsys variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 arch/arm/mach-s3c/s3c64xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-s3c/s3c64xx.c b/arch/arm/mach-s3c/s3c64xx.c
index 9f9717874d67..6c70ea7f2931 100644
--- a/arch/arm/mach-s3c/s3c64xx.c
+++ b/arch/arm/mach-s3c/s3c64xx.c
@@ -149,7 +149,7 @@ static struct map_desc s3c_iodesc[] __initdata = {
 	},
 };
 
-static struct bus_type s3c64xx_subsys = {
+static const struct bus_type s3c64xx_subsys = {
 	.name		= "s3c64xx-core",
 	.dev_name	= "s3c64xx-core",
 };

---
base-commit: 8f5b7dbc644d6217a2fd35cb82594b215818eb16
change-id: 20240204-bus_cleanup-arm-391704e66efc

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


