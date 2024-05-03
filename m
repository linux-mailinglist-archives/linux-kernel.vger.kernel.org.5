Return-Path: <linux-kernel+bounces-168242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8AA8BB594
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59A1D2819B2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 21:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F7982C88;
	Fri,  3 May 2024 21:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DFXTUPL9"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FEF6A03F;
	Fri,  3 May 2024 21:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714771374; cv=none; b=Lmnkr36+7fNPZCqiKNlCu9H4sOOFr7iYoUP+hj46EUCLZ2NKsBR/Ij7KCEsBGm08Wjss+JupGg0mvW/zHO23lCnhyuQ1NTHTwx8tkaQRLucRafb8P2DcgeAnMWiwqsHjM+MCvFqeK8dQ+SvbGbdUEsjva4xa+jjGy1AJpNT6pg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714771374; c=relaxed/simple;
	bh=9qSQ+VmyiWaSOayhgLpCBEyLLV7mRD7PthMA2Myu7lo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gK0d4LLQEB5vepGOOMM/+jn6X5d86G4bEuzS8Zip0GvSdxgVXG5pS1x0Ihegrl/7Cqzet8lIDLEePCrMt/bxUCi87lYY1JTS72aGLO/8gTouGCLOEpWBDU8/vAGnDXvrVCdkty98jzQnVFOx+t4gsbhhUCt3+MXZnw0TO15kkKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DFXTUPL9; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-41ba1ba55e8so1515485e9.1;
        Fri, 03 May 2024 14:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714771371; x=1715376171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D4DH3qVraBxAKOkzL2o2RPg8r/hkJCjLZkhJsoaCMpU=;
        b=DFXTUPL91TSdICvfEJd8yZthO57jLX1lqZMtRF85w/OlPs9rK0VF/CyI14JnTE9ZwU
         xIiKN+Z7iP7y0IhqThyH7aQWMVPJHXmIQHdKIt7CiJmW3VXXY+q+feUwj9vDGX4R0NJB
         CdBk2fMZ27rkzTdDJMYkaKU8MI2CN9/aoCcmwBabwqauOyN2q23SAeWiS5tn3vGJfABj
         qjDRI6sksWJvpoCmJfiehz3kgpaFR5j3D9MGuT0JgN1thbc6b8Ohpr+ya9WhIhEVC9FV
         qv5SKR5qrg2Vcab5qtC8Xgf11E0m9vs0s0mOmJ7JxFfbmhV4tBTzFF6bp/5fNLTaNYH5
         0SUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714771371; x=1715376171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D4DH3qVraBxAKOkzL2o2RPg8r/hkJCjLZkhJsoaCMpU=;
        b=GtKLGdOSNNJyWd+2GkvsI7Dzu2zOkyskt/x1hsP/x8nVI3D2xDI8r9h8ssoOw8IM8k
         UvElN1qETDoKIOqRYg3x2jfvhyWmNteGp0q8+tJo4ouDjRjf41RGG23vCVl4fMnNItMu
         vFiVq0hAeB6qM7bovZgzhgxUOezDde8avV7lJQO8DSlwNN/ohxNXoS6EYR4l8STv4lgr
         bYUVBLxece+3rQoGMC9TL45ddWUNe+XZtwDHdprTG3P+gVBF6kRhEpC6oL31n90GAsBj
         Yr4M24s1tX4Fh1W1wvPkgnHODuclOrL9ES6sgJo4nillDcHC821DUJquEgqZEYURS+1B
         RKxw==
X-Forwarded-Encrypted: i=1; AJvYcCUsji81QzBEy4yJQu+YBEdyMMabKchh+zLXr8FnjWxF/EKCSv5Gxo44i/WYRTwM63wwR+RF05XpJqYuCPJ2rDgmOXKkMa8YCNvjzSIZlrL0fkedoBJutFNMG6/9+ASBg5H4SaUGdpznyvl1vr+TxrgKv+BOhpx5CtyG7hXNmDAEDnMo0DY=
X-Gm-Message-State: AOJu0Yy1+EcLF0P7iLXgl+UX66j5IFmVd/n5apQoxYBOyCb39E4Ha8/p
	lcQScU7gYNW+vjMm8uIlOxYCFXabGNJ6DwwXvKrYodKk2/LF3WNP
X-Google-Smtp-Source: AGHT+IFICUxKWewj1Oj9MIAdnwJ1VM4+caohg57tjMLFFlCALs0uLYRjbwSztU8wd0ZS/N7F2bIj+Q==
X-Received: by 2002:a05:600c:500f:b0:41a:446b:10df with SMTP id n15-20020a05600c500f00b0041a446b10dfmr3160241wmr.12.1714771370599;
        Fri, 03 May 2024 14:22:50 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.googlemail.com with ESMTPSA id g7-20020a05600c4ec700b0041902ebc87esm6918729wmq.35.2024.05.03.14.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 14:22:50 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Hauke Mehrtens <hauke@hauke-m.de>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	=?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>,
	linux-mips@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Daniel=20Gonz=C3=A1lez=20Cabanelas?= <dgcbueu@gmail.com>
Subject: [PATCH v2 5/5] mips: bmips: enable RAC on BMIPS4350
Date: Fri,  3 May 2024 23:21:01 +0200
Message-ID: <20240503212139.5811-6-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240503212139.5811-1-ansuelsmth@gmail.com>
References: <20240503212139.5811-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Daniel González Cabanelas <dgcbueu@gmail.com>

The data RAC is left disabled by the bootloader in some SoCs, at least in
the core it boots from.
Enabling this feature increases the performance up to +30% depending on the
task.

Signed-off-by: Daniel González Cabanelas <dgcbueu@gmail.com>
Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
[ rework code and reduce code duplication ]
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 arch/mips/kernel/smp-bmips.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/mips/kernel/smp-bmips.c b/arch/mips/kernel/smp-bmips.c
index a4f84667a901..0f93963c08e4 100644
--- a/arch/mips/kernel/smp-bmips.c
+++ b/arch/mips/kernel/smp-bmips.c
@@ -620,6 +620,23 @@ void bmips_cpu_setup(void)
 		__raw_readl(cbr + BMIPS_RAC_ADDRESS_RANGE);
 		break;
 
+	case CPU_BMIPS4350:
+		u32 rac_addr = BMIPS_RAC_CONFIG_1;
+
+		if (!(read_c0_brcm_cmt_local() & (1 << 31)))
+			rac_addr = BMIPS_RAC_CONFIG;
+
+		/* Enable data RAC */
+		cfg = __raw_readl(bmips_cbr_addr + rac_addr);
+		__raw_writel(cfg | 0xf, bmips_cbr_addr + rac_addr);
+		__raw_readl(bmips_cbr_addr + rac_addr);
+
+		/* Flush stale data out of the readahead cache */
+		cfg = __raw_readl(bmips_cbr_addr + BMIPS_RAC_CONFIG);
+		__raw_writel(cfg | 0x100, bmips_cbr_addr + BMIPS_RAC_CONFIG);
+		__raw_readl(bmips_cbr_addr + BMIPS_RAC_CONFIG);
+		break;
+
 	case CPU_BMIPS4380:
 		/* CBG workaround for early BMIPS4380 CPUs */
 		switch (read_c0_prid()) {
-- 
2.43.0


