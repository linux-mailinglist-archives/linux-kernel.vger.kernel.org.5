Return-Path: <linux-kernel+bounces-94503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD258740BB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 20:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F9381C20F95
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 19:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C7413E7ED;
	Wed,  6 Mar 2024 19:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FK0egf06"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755C713E7C9;
	Wed,  6 Mar 2024 19:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709754414; cv=none; b=nWg8KS12EZTRXZQDyQxCvY9DrnM2B8RBmKodNxJuXSbsMeEhREVR7omO5wkVy/yHRaeZREtxNnHofmQuG9mdTGOXKHvM2C86MtoEPs542QP8GAd6/HmvUPNHE85LQ+EyMDCWSD9FKi1Of2kGpHGI711TCRvlnaqdbh9vXQMSLC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709754414; c=relaxed/simple;
	bh=wUTa+nYvfPqqyd43TGJnbwD17Ps9aDuArvWOCzhqf6I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CuIYuqHV5NTRY0ZrmmJkIjP4RvcfUIF4R0gsOUUDvxLtB05R0Etqbw9wFo6EjUNrgPStaUjsftZNEKuNZydZ0yeH0Cn0xAhZ9YY+gNiY1jKdwAIfWXB7GltqMRhd9zuD34NWkCFpc7QVP784dSeBtJY8tO5040kFfvi4pkIUIpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FK0egf06; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1dc29f1956cso867995ad.0;
        Wed, 06 Mar 2024 11:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709754412; x=1710359212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wSGOkP6UKU31uWhJWy9bI2TO/pdNl9a82TrBlyBc6js=;
        b=FK0egf06/tlGtlWO2VrfF0Q39I+VR3klIUXRatrf7EUTg4lG+gUCnQfwC2tn/YHez/
         KRTqERJW1/xDwYtmP69OX/lvVSfs/SRknVmisI4VgHkAcgE5FV9NKQc2Tr13iGWQLSSS
         azi2ImLDihKDUudsXJmtnDa0tal3aaffYxtWOgnl3mZUgmUURKoxu3Prfb1UDUm6soyJ
         8onFqdmXCFespo/UaCvQUCjbFyFl3Dbb8aHdpMUVXDjL/oFFmAmxzRwCKJ1HSAbxFzCZ
         FA4BLSTtus/LweWR4fA7WTXrV4wCU9BD/YdHXHAm9moox06bhYYidl9VpK5SJEcIwibj
         v+GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709754412; x=1710359212;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wSGOkP6UKU31uWhJWy9bI2TO/pdNl9a82TrBlyBc6js=;
        b=sr8qwdvEG+hAaPXJ4j2bfnAngYrvcjoESc48EUVnxjid8CnUR3IXmQgrGhcfgS6LBg
         aqx83I/LDrZy14F3Mfh9opCktthB342VGPHGjKr74Agdk41p7rfT2IhWYTszC4hSyMu7
         wV0ozT74q4aNxnPMLXNiJADCLnPkyVFCB0zRWqGxms82GiUbeeN5bY7mLvU8tWtfM3a8
         3YRyT17Z5E2/BMLNt/R4iFMR97zKANQWfxZcu7VDJrxLqE1L9cm2a4wb6IoiQrHOXPCS
         IPLgBFUd+dbY4AjNjloHoJNNi2zpF3C/9Cp8h/YUuFCPcUe0PtXxDl31JdFYlDB8jCBk
         PLow==
X-Forwarded-Encrypted: i=1; AJvYcCVxyFkW+hgbl3syS+bFddcTv4zgWTt/CmvYoyW41/SSS23Hou0pg7TvWbpkR9EGqr1fTC53dXykWbggs93LUGgaxGj3k+kHZT9qIDYG
X-Gm-Message-State: AOJu0Ywp6n25UZ8xxGR5clLURWSLXsk1BXtxhwVbiITTQA2tn/d48ZKM
	woLmXfVqvD6ypjboVFNH91SpA33H5stbT/0StmGeZ/FqYr6fTyrJsP8SzAqIyXU=
X-Google-Smtp-Source: AGHT+IEjS1I6OLLAzByEfL8dzWTxJBG2nAxxy99Y2jRUZrkeNNwehA2uNYgnOdg/83joHtRSf03+cA==
X-Received: by 2002:a17:902:db02:b0:1dc:90a7:660b with SMTP id m2-20020a170902db0200b001dc90a7660bmr7813671plx.9.1709754412131;
        Wed, 06 Mar 2024 11:46:52 -0800 (PST)
Received: from toolbox.iitism.net ([103.15.228.94])
        by smtp.gmail.com with ESMTPSA id 12-20020a170902c20c00b001dbab519ce7sm12939928pll.212.2024.03.06.11.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 11:46:51 -0800 (PST)
From: Ayush Singh <ayushdevel1325@gmail.com>
To: linux-doc@vger.kernel.org
Cc: Ayush Singh <ayushdevel1325@gmail.com>,
	linux-kernel@vger.kernel.org,
	krzysztof.kozlowski@linaro.org,
	corbet@lwn.net
Subject: [PATCH] docs: w1: Remove w1_gpio_platform_data
Date: Thu,  7 Mar 2024 01:16:26 +0530
Message-ID: <20240306194629.356001-1-ayushdevel1325@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

`linux/w1-gpio.h` was removed in a previous patch and should no longer be
needed for using w1 gpio.

- Removal Patch: https://lore.kernel.org/all/cover.1701727212.git.u.kleine-koenig@pengutronix.de/

Signed-off-by: Ayush Singh <ayushdevel1325@gmail.com>
---
 Documentation/w1/masters/w1-gpio.rst | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/Documentation/w1/masters/w1-gpio.rst b/Documentation/w1/masters/w1-gpio.rst
index 15236605503b..5d7eebc291bb 100644
--- a/Documentation/w1/masters/w1-gpio.rst
+++ b/Documentation/w1/masters/w1-gpio.rst
@@ -20,7 +20,6 @@ Example (mach-at91)
 ::
 
   #include <linux/gpio/machine.h>
-  #include <linux/w1-gpio.h>
 
   static struct gpiod_lookup_table foo_w1_gpiod_table = {
 	.dev_id = "w1-gpio",
@@ -30,14 +29,9 @@ Example (mach-at91)
 	},
   };
 
-  static struct w1_gpio_platform_data foo_w1_gpio_pdata = {
-	.ext_pullup_enable_pin	= -EINVAL,
-  };
-
   static struct platform_device foo_w1_device = {
 	.name			= "w1-gpio",
 	.id			= -1,
-	.dev.platform_data	= &foo_w1_gpio_pdata,
   };
 
   ...
-- 
2.44.0


