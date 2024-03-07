Return-Path: <linux-kernel+bounces-95308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A14874C05
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:11:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E10481F22492
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B39C8528D;
	Thu,  7 Mar 2024 10:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QcJQSOW9"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B7982880;
	Thu,  7 Mar 2024 10:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709806224; cv=none; b=Y8tgWjwr20qTqv5DGVS+NXJX+5GBQW5ypY8sXHoDJnggt7tTAdEB5n9kMVJ1hsHkIQxSVSOKixPvjnib3K0kOIWRwAWb88lZ8AESbSDodgCSY5msvG6eieWANzCo0bSiPwxmLxWnxgYuqNPNu1AoOHJfWV8RiYT29nlcB8r0kpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709806224; c=relaxed/simple;
	bh=K1iJV2J/BTqtD74GDRo5soQdK7E9iowDM4Ft7wZ3u2s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cG3hvXTjjl6JjNFfnoPdYMCUZ/GNxxVxDKR/qvQyga3F1IjqfaAd17KCWRgIABDdGx2WkC0Z6HQNjeBUAO4BaAwUgiMUxW15Wk24jNEXLPsZ8vjTe2M9xR8Z7+Xm9JoLLXs15G9w9yawFAm+IDZ6Tk1byVq/jgBT3PdNc0dCuw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QcJQSOW9; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-53fa455cd94so575057a12.2;
        Thu, 07 Mar 2024 02:10:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709806222; x=1710411022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9klzUShdl1Th4vVmkRf+E7tObzdbhSVktHtNOmjs4zA=;
        b=QcJQSOW9UQm+6haOz4TeVorreub23k+1gEu1My4JVaEa3u3W57ZoC47FjZHsc9FGxX
         g8ZwQKa1YdcWHM2WW7wZ5uG53re24g9Q4a5e2jPl+KrR0TrsW1OFZxfAsPJxabOPgpuH
         wg6tcmgb8WA6ZYxjEW5jYH+Vg2teKI0tF+cNmHqJyWD+1CZ33EtictuVX4THI7y54ols
         ZhM2Z1HMgFlw0mBxWcBWC7myQPvCb7uqUN9n+6xutjKOHmsQAvzRBuKeGT0yyN7gLzRk
         c2pS8j9wGkAzH+Pf62qsf0r2AJDUANix9UbkijTVpTc6r5Q2EVOBgsMroXP8IgKSLZTf
         MZzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709806222; x=1710411022;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9klzUShdl1Th4vVmkRf+E7tObzdbhSVktHtNOmjs4zA=;
        b=G2HQGPnqaAPChLE0t3Kv8VQ+cYutMNOnVGlu8zBQvLvOIc7ayPxgyPGXDew+rrLA/Z
         efQQoTQVVYpPPY+r4E4G3812h8Y/180Lhcf3vI/6H+9kwwVYdK19eeeQ9dDtvAVaIaiF
         ETQpZ6RIBXTdak3sg6ntTSNXbbbLkwcQ3Ri0q/8pcOt6oNK3eW4EZ16zw8NwZE2lrFLA
         /NrN6jkAttR6iVjdItn1+ABboweXL0B6AfWN82sS36bIRODiOCIppgvl1BxdmHYLHVUK
         24NjYTY1wQla9D2Nl9pNqGr8llWPz7X51xzsl4bZV1amuOBM98OvsfT6dzvdZKiMcJnx
         zj6w==
X-Forwarded-Encrypted: i=1; AJvYcCViIyh34gMeqqs+IE2xBmRP29YNezyNBhNtmbtfu2NCadIqWbnU3LdtGYSkKt0tF2VV1msiAlfEDho8acr64AFewqZCwdf72YGI4enh
X-Gm-Message-State: AOJu0Yxmi3mJYtZcWo9vNdWfx/Gsfocqubepmf+xxThp6F3J9woe4ggf
	IHI9VMOxMfcVCEX9FIWGroOt/Qak5+gOJ9a076JE0BWRZc1f7CAJK/pMRHhihZA=
X-Google-Smtp-Source: AGHT+IGSsCR9Y0+boOJqmX1VdwWmHP+AENSr4Y9AzhPil2LVB/v+p1unI6eHHvdsfz55TgGBrvH3DA==
X-Received: by 2002:a17:90a:d70b:b0:29a:b5ab:a0fb with SMTP id y11-20020a17090ad70b00b0029ab5aba0fbmr15399445pju.23.1709806221805;
        Thu, 07 Mar 2024 02:10:21 -0800 (PST)
Received: from toolbox.iitism.net ([103.15.228.94])
        by smtp.gmail.com with ESMTPSA id qe5-20020a17090b4f8500b0029b82593a6csm1193364pjb.0.2024.03.07.02.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 02:10:21 -0800 (PST)
From: Ayush Singh <ayushdevel1325@gmail.com>
To: linux-doc@vger.kernel.org
Cc: Ayush Singh <ayushdevel1325@gmail.com>,
	linux-kernel@vger.kernel.org,
	krzysztof.kozlowski@linaro.org,
	corbet@lwn.net,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2] docs: w1: Remove w1_gpio_platform_data
Date: Thu,  7 Mar 2024 15:40:09 +0530
Message-ID: <20240307101010.403609-1-ayushdevel1325@gmail.com>
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

Fixes: 9c0a5b3f9e55 ("w1: gpio: Don't use platform data for driver data")

Signed-off-by: Ayush Singh <ayushdevel1325@gmail.com>
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
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


