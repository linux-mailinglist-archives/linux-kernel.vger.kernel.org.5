Return-Path: <linux-kernel+bounces-3071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE5D8166EE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 07:55:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54DFD1F22DB8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 06:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A8B79C3;
	Mon, 18 Dec 2023 06:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eFJLIIDE"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E15101E8;
	Mon, 18 Dec 2023 06:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d3b66733a9so1496075ad.2;
        Sun, 17 Dec 2023 22:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702882502; x=1703487302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6sLJbuu7UBEfIkGSNFUZOPei/Q1sobyICLTnqyuxq9Q=;
        b=eFJLIIDEm8jVg6bEIxIfYzRR2DhHgBeKI/esulH9b43+yVh7kU8xIlVPh6VFITma5u
         VEh7U7SLovtDBHS8PU2uv921qUrCVl+7bK0n0RxOk8MDw2e885OYMoKdS8nAt5ARgpKU
         rEjGJHl+77G5TZcvXdf/S+925dQQvEA739QAdLD4bI0BlVYqqqA2ay2U/YY6EVxPf+un
         6ephcm9wxWbPTKqiLRGuWObdf+hfaoUAFAJUXlW3dxXnCjghVtbVA484nJhnjXMSufBT
         h3c5ixuo02lSp+Ce9cln3yNuDgdlI5k6yqwUJT5w1eaEtUE8o4jU/W0ymBFLQ+3vh+nt
         EMqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702882502; x=1703487302;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6sLJbuu7UBEfIkGSNFUZOPei/Q1sobyICLTnqyuxq9Q=;
        b=ob8FJzHWNAvL0XXye9uNmtxZqvW7Vxx8OI1fjjtlrTEV7y7TPjd8fwY5pgnYzPf6wo
         xS+S9mzhNDFFkHBToNVEchhAVzg0sghI/gBPj4JoOzWxpyM1W0dApHdUpiltZ/tS/j4m
         5YSnaiGbhBeEy/tUsnXIpJ/4pfuZLjj+NSJSmP5Rzv6w1Qacqmu7mHzB1op5nVeYe9y3
         o2dL5pYaJbz5JdizkMrTeYF81amCXX88Z+Luc1Z/AaD8lcS9QPvY7XArJQ0IahtAWnox
         8XeCJMKLVAnJD1NMzs7WvgIDIyzrNcEoaY/DjlO7lt2+t/jW9eG2SOwKA/9eDicbxo1R
         WxmQ==
X-Gm-Message-State: AOJu0YysnwwdA/G1HVN5EaOrR0qS7VMc5bQ3fyqE5ZNS607Og3gr2NgH
	gDON1J4wZB9rMNozT2flmwfMmZfRpExHG0nC
X-Google-Smtp-Source: AGHT+IG30+15ZjuA4qLQnFqfc8h8Ih/wWvAEX8uTWLGZfNKq0Sy9R6Ci3UoOy5NSUEExZpkKsVGAkw==
X-Received: by 2002:a17:902:fc4e:b0:1d3:9b9a:2ed9 with SMTP id me14-20020a170902fc4e00b001d39b9a2ed9mr794758plb.9.1702882501599;
        Sun, 17 Dec 2023 22:55:01 -0800 (PST)
Received: from localhost.localdomain ([202.137.218.19])
        by smtp.gmail.com with ESMTPSA id c10-20020a170902aa4a00b001b86dd825e7sm18211742plr.108.2023.12.17.22.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 22:55:01 -0800 (PST)
From: Ghanshyam Agrawal <ghanshyam1898@gmail.com>
To: perex@perex.cz,
	tiwai@suse.com
Cc: Ghanshyam Agrawal <ghanshyam1898@gmail.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: au88x0: fixed a typo
Date: Mon, 18 Dec 2023 12:24:42 +0530
Message-Id: <20231218065442.43523-1-ghanshyam1898@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixed typo in the word communicate

Signed-off-by: Ghanshyam Agrawal <ghanshyam1898@gmail.com>
---
 sound/pci/au88x0/au88x0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/au88x0/au88x0.c b/sound/pci/au88x0/au88x0.c
index eb234153691b..62b10b0e07b1 100644
--- a/sound/pci/au88x0/au88x0.c
+++ b/sound/pci/au88x0/au88x0.c
@@ -10,7 +10,7 @@
  *   Thanks to the ALSA developers, they helped a lot working out
  * the ALSA part.
  *   Thanks also to Sourceforge for maintaining the old binary drivers,
- * and the forum, where developers could comunicate.
+ * and the forum, where developers could communicate.
  *
  * Now at least i can play Legacy DOOM with MIDI music :-)
  */
-- 
2.25.1


