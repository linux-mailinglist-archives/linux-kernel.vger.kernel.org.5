Return-Path: <linux-kernel+bounces-89612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D16D886F2AD
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 23:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 666C71F21D1B
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 22:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F734AEE5;
	Sat,  2 Mar 2024 22:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YbuDlEox"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C000B4176C
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 22:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709417708; cv=none; b=AwanMP1qETtc/JLwQ26ohS2sgl2vEBzgSD2z/lSXHPYENsfjSzqHSU2QUmoRCeG5p9EfdtH6TS/h8W4jlJAsUKgZZVLvgJ25Qo2SFdtYAI0/T9DkQPh89Kk+4+EeDWtI25P7N0pC7jf3vrumUw8CQjka9wTO2cDIoDsKatxAcvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709417708; c=relaxed/simple;
	bh=hPV1W9NNCdPmUe/gre4zixpiDH0DuSLGUPz541ul5bA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kS6AAfOcOxf4WsOtYADT0+0rUGzpW+kai/UdK/9g5nxfsvnKz2tQKlMJ6j//xWCjYvpLEAqSMveu4AcA8PPew5qeS6TAvn7wgNX1K59o6VoMlLa3ROHbEht2r2QXANJt6bvfUsIkCsWXX13tJ5BE+fB0ehEaYWwiF65ZT2vNZG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YbuDlEox; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-51326436876so3264624e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 02 Mar 2024 14:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709417705; x=1710022505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bJIX0deRA6RFRMpGp+Bsyln5k9lSvt9jo763ilTvMpc=;
        b=YbuDlEoxp7t5zSAwUZhjTGU4UvWKJhFfRYExNksSp+i6+p7xUNSrDEf0NCPl78JrTR
         jDVN1DgU/RSnF47FIqPJRWSUoGpmFotpptJGhvS9DG98m+RLIStg6aUjf5urt+7LEyAL
         BWN2YfRVWS3Yttuo2y+vMWtehOqCt5BZzNBu1/UY1UhuLV/ZHqo2YR6y0MwWvwxLSJuw
         cjd4AmirdlPP2M9PrpKCXTgIqbhZmGVFjaLCudzkp/lVXGhGLHZm0TTqqvE+ykvdIMH6
         pFJZ1NJ9+VvhnVElT4TmuVjK+ehd02FruFtXv1OikNUhXMVW4cpKKbg7DpVZVxnufMpT
         URTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709417705; x=1710022505;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bJIX0deRA6RFRMpGp+Bsyln5k9lSvt9jo763ilTvMpc=;
        b=NlQV/DPx19MSPonPO6FHNlIpdPIpCgqnN9SXgE1HWSO1llm4emMPX+qp9plgwY+q3t
         NS4KdgDu64hRE58fkVWfyKO7IZy6CFCSpRmbVzDOrDhJ2ZbCxaY6+OoGFboLXCKVifbX
         McV9Ul/jFcXE8v1anE8DLwf1tu25IOW6UEmblFdH6BT9W63OMbZzI3HHxEhTdBOyd4oj
         CVqeQ1svABRRcJLMV8VcyCmtrQDEH02g0F/mHD5A4iyhAjVH7UfMx0YkRdKuWvA7FXgW
         IOpMkPBAbuWe6WgPLDZ/Qd6w9d/TtYZXQYPIFevsPvEeYw9W3tB/KK5DdrV+4HunYtYw
         CpLw==
X-Gm-Message-State: AOJu0Yy1WzmpURWFztG/tKvtKlQNl86Fev7m70N+m+FN4AGuebZDtiHy
	9HCDh4WMMaIzhI5O2X5u0quOGpbL6SjD/KZU6gjpfSCZJtCh6ZLq
X-Google-Smtp-Source: AGHT+IGX1rOU+9w1Eo79CHkqn1XHgAtvHUGw0KG5VmcYkiGwpH2Z5E/Hmi8gIMo7SU+eNx9sZ/RJ1g==
X-Received: by 2002:a05:6512:1599:b0:513:17a4:c8c1 with SMTP id bp25-20020a056512159900b0051317a4c8c1mr4803546lfb.49.1709417704690;
        Sat, 02 Mar 2024 14:15:04 -0800 (PST)
Received: from localhost.localdomain (c83-255-24-248.bredband.tele2.se. [83.255.24.248])
        by smtp.googlemail.com with ESMTPSA id a23-20020a195f57000000b0051333e2f55dsm648975lfj.159.2024.03.02.14.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Mar 2024 14:15:04 -0800 (PST)
From: Jonathan Bergh <bergh.jonathan@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	Jonathan Bergh <bergh.jonathan@gmail.com>
Subject: [PATCH] staging: vme_user: Ensure blank lines after variable declarations and fix misaligned */ comment formatting issues
Date: Sat,  2 Mar 2024 23:14:54 +0100
Message-Id: <20240302221454.141649-1-bergh.jonathan@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fixes the following issues:
 * Ensures a blank line after declarations
 * Ensures */ is aligned with its correct opening /*

Signed-off-by: Jonathan Bergh <bergh.jonathan@gmail.com>
---
 drivers/staging/vme_user/vme_tsi148.h | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/vme_user/vme_tsi148.h b/drivers/staging/vme_user/vme_tsi148.h
index 4dd224d0b86e..674d83325e42 100644
--- a/drivers/staging/vme_user/vme_tsi148.h
+++ b/drivers/staging/vme_user/vme_tsi148.h
@@ -34,6 +34,7 @@ struct tsi148_driver {
 	void __iomem *base;	/* Base Address of device registers */
 	wait_queue_head_t dma_queue[2];
 	wait_queue_head_t iack_queue;
+
 	void (*lm_callback[4])(void *);	/* Called in interrupt handler */
 	void *lm_data[4];
 	void *crcsr_kernel;
@@ -691,8 +692,7 @@ static const int TSI148_GCSR_MBOX[4] = { TSI148_GCSR_MBOX0,
 
 #define TSI148_LCSR_VMCTRL_RMWEN       BIT(20)	/* RMW Enable */
 
-#define TSI148_LCSR_VMCTRL_ATO_M       (7 << 16)	/* Master Access Time-out Mask
-						 */
+#define TSI148_LCSR_VMCTRL_ATO_M       (7 << 16)	/* Master Access Time-out Mask*/
 #define TSI148_LCSR_VMCTRL_ATO_32      (0 << 16)	/* 32 us */
 #define TSI148_LCSR_VMCTRL_ATO_128     BIT(16)	/* 128 us */
 #define TSI148_LCSR_VMCTRL_ATO_512     (2 << 16)	/* 512 us */
@@ -753,8 +753,7 @@ static const int TSI148_GCSR_MBOX[4] = { TSI148_GCSR_MBOX0,
 #define TSI148_LCSR_VCTRL_DLT_16384    (0xB << 24)	/* 16384 VCLKS */
 #define TSI148_LCSR_VCTRL_DLT_32768    (0xC << 24)	/* 32768 VCLKS */
 
-#define TSI148_LCSR_VCTRL_NERBB        BIT(20)	/* No Early Release of Bus Busy
-						 */
+#define TSI148_LCSR_VCTRL_NERBB        BIT(20)	/* No Early Release of Bus Busy*/
 
 #define TSI148_LCSR_VCTRL_SRESET       BIT(17)	/* System Reset */
 #define TSI148_LCSR_VCTRL_LRESET       BIT(16)	/* Local Reset */
-- 
2.40.1


