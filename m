Return-Path: <linux-kernel+bounces-84109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 11AE386A277
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 23:30:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0D3BB307ED
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 22:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D80C157E99;
	Tue, 27 Feb 2024 22:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FUYXUvVc"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18FE155307
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 22:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709071932; cv=none; b=h3P5xSWq0ovhVDSBGEJvPUU6dzs/4BYg0bEWxSkvopWboisbRs1dF/lvLoBE3WWzR3dh2bR1GadcVJQb+MHwjZCvfC4UsS6zGhMsjMrjhQTsAlRotXph9jsDKcPN5yPMrkg1y2cjIXsPA1IR7WR8z2TI+PrrNcLaebDWWI0nPcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709071932; c=relaxed/simple;
	bh=fmnSLnIUWlgp5ur85n+HDFL+jupuhUG/KRlYbWXGjS4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gujgkEbEvDQ2u13Zrw91SwBFCU5x4fBhPdqGl+prd0Ld9lxM4uy34wMa/5QRmLeANbdBs6gEymhd3tH80cOe0KaJgWNcNP9NjDYuqT6XY09KgGII726vkPsIvArbSyNvrXjst1sdaCuS5OJmQYMDuQ1Totdli+xTjV9+Hu2xDhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FUYXUvVc; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-33d28468666so4164426f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 14:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709071929; x=1709676729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ByFJ4T1AQt6fR81lqN9Fb0sA+BvqHSN66dpmEs3Guqc=;
        b=FUYXUvVcnS66yLrxP40xhUuj4OximJ+foG2+xa80LQ3wtHty+kF3nJLaNPVg3oi2XR
         EFj6rGZPmGT1GRfNf3+fxsVw1Yi5hNNbmm4troMqoANNx+PN3J0TpJX1BQ3LExu0nv74
         UrqRWQkyhDDKJDC3Zs2VV0bpz4HAJ8Tw7RADjVKb3jLyU5LHVm+j7XzLepZwyHURZLyB
         rpUckKjpmwYE4QLRyvGl0E7eqlCGsXAx7kwfICE7dPTRl3+PhG1F0ggeBOsvzpam4Qqf
         WHoqa3t1L6lWB8IbxhFJnH5kuipYUpHEg0RTsDW90HwXdj4ZzOYT+RZYJd7USUAwN5km
         RHZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709071929; x=1709676729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ByFJ4T1AQt6fR81lqN9Fb0sA+BvqHSN66dpmEs3Guqc=;
        b=tZzrysozlHf2CJu95jo/jcskBflhQheloyajPMlaZWI9BY2XKli5LU1uv2Bfel1DyY
         nqUoKBtqqR2rScNr+DesunPP0JDDjMTmVb5dbzm6zMPrUspPqek/Nf9tvg46j0GYoWYf
         Vdar3BUModa7UdlpBW9VZ2YiAb60JmB98TBYo1UiLYE467AqI7+FIyEQUCs99uBYy0uB
         Jk/gdzUEXuRjSTJN5R87wbAqnyJkdic9QXW43O/lDKRQuowsWf25EfYUYSyJimolFIYr
         ovVoAv+WjvcpUm/l5kg5sL7oST8/z74Fph+S6p4itxZupvYLZRjir2Ff51fPL89d0rOR
         90Ug==
X-Forwarded-Encrypted: i=1; AJvYcCVKwuCVeLNZr/gfR+znHXv0y/cQWDqpkOhB5/Aa7rXm58zb2pTCNgorSdeicV+K5hR7ROWCcv6daftlXtR1KvU7J9YLMOXeKcCCDaLA
X-Gm-Message-State: AOJu0Yztc7RwoFXWfV2Hj0XRz6CcOrKY7lZu4P+enOkpJeusussfSY1u
	dhwavN1xbl8pcdgdkT/dkW/R6yLlZsThiV5SawRlmS/02O4FCngzpgLsK5aF
X-Google-Smtp-Source: AGHT+IHMmJVD4LN67PcarP83AwzBhWjbWB/PCHvqO5lApmrXQwqa2moqO0MgtL0r6vTnezo7LI9m1w==
X-Received: by 2002:adf:c6c8:0:b0:33d:f3c5:c793 with SMTP id c8-20020adfc6c8000000b0033df3c5c793mr1801355wrh.16.1709071929418;
        Tue, 27 Feb 2024 14:12:09 -0800 (PST)
Received: from YOGA.local ([2a06:c701:736b:f200:73a5:2235:8954:9b7c])
        by smtp.gmail.com with ESMTPSA id o8-20020a056000010800b0033d202abf01sm12415560wrx.28.2024.02.27.14.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 14:12:08 -0800 (PST)
From: Shahar Avidar <ikobh7@gmail.com>
To: gregkh@linuxfoundation.org,
	luca.ceresoli@bootlin.com,
	benjamin.tissoires@redhat.com,
	elder@linaro.org,
	andriy.shevchenko@linux.intel.com,
	robh@kernel.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] staging: pi433: Remove a duplicated F_OSC define
Date: Wed, 28 Feb 2024 00:12:01 +0200
Message-Id: <20240227221204.534131-3-ikobh7@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240227221204.534131-1-ikobh7@gmail.com>
References: <20240227221204.534131-1-ikobh7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

F_OSC is already defined & only used by rf69.c source file.

Signed-off-by: Shahar Avidar <ikobh7@gmail.com>
---
 drivers/staging/pi433/rf69.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/pi433/rf69.h b/drivers/staging/pi433/rf69.h
index 78fa0b8bab8b..52e43a909b03 100644
--- a/drivers/staging/pi433/rf69.h
+++ b/drivers/staging/pi433/rf69.h
@@ -12,7 +12,6 @@
 #include "rf69_registers.h"
 
 /* NOTE: Modifying FREQUENCY value impacts CE certification */
-#define F_OSC		32000000	/* Hz */
 #define FREQUENCY	433920000	/* Hz */
 #define FIFO_SIZE	66		/* bytes */
 #define FIFO_THRESHOLD	15		/* bytes */
-- 
2.34.1


