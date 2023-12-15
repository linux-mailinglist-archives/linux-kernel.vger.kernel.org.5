Return-Path: <linux-kernel+bounces-398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2B9814084
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 04:15:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC5652838A6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 03:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59731879;
	Fri, 15 Dec 2023 03:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O0JkgWCa"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E5C63A9;
	Fri, 15 Dec 2023 03:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3ba00fe4e98so213694b6e.2;
        Thu, 14 Dec 2023 19:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702610094; x=1703214894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7/HJAB1d28KOAsQBHPrBrzzCpyYZA+5xVpuQkAUAjns=;
        b=O0JkgWCaUdZeVzVdG13DFjFd9uxnLClOdkZobvvqgESnjQ6hbTCQFQ36ANz08q/zte
         bMAmLFcXedxIUEV/5ahN2yexGwsxC1YSj66VXQ4r3DU8Dv0uMxfeM+/78+9wc48Z/5/G
         skSh0J4+pvDFNjyF/hEyTs60H1aVwojGXweDvncTwW8eBpUAcEavHFszoo/f/66/BPGn
         pBIzDAfPlAXEeniYRmiM5lHZle6eNTVS+n61U+bKU4gu6mDWzZAYd8UwQN/H5qy5cE/N
         q9VtVSeRcxhDtvKlFce3c84zPYBDoavomSG9dg+Ok8hz1mUNHlQbJrOcLAbFQJG/AgS6
         YI0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702610094; x=1703214894;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7/HJAB1d28KOAsQBHPrBrzzCpyYZA+5xVpuQkAUAjns=;
        b=PTpUpuoRqRNSdL3Guxt5tBpi9p6qrxAJ861EHzM2uQtcDlWf6rHfWP5/f5X42GHvfO
         AFO7MTL74eButkiCBry43JsiGaW/O/Wne88eLSLI7uLZFpsGdpakkZg8n3uWvDYdSr1d
         mn2rv2D7ZRr3vlP2Xcomkvbe5ncK4OH8ndHx9zDNlgmp+fSKRr1LWNc8zqn2RQl3iTL1
         PVfrOTikNKcVMOV2J91j29t/shB6SGYyBMnANP0Hvcz2aksxNJe51qjzsdJpcGSUy95h
         VcUjp50Ma3wBybdQRtoBq9/5yrTxSYpPF2/XkVgNLjHcdbutKRaoEIpFOOCkFCyg892D
         lyuw==
X-Gm-Message-State: AOJu0YwgSbSJ0Y6FcnH1wdIyTl7AXW1dtsm846YT56DrtfW7JWa18Y88
	i5F2Y9ig76d1Rj9uWE1cjrFbKaODUD6TpVhz
X-Google-Smtp-Source: AGHT+IFOL1swHqcpjjcSBJRiQmTzIdDg+kyDaywAGt2uLO+o7QjNWfqRzXrtLS1C7dmsQAnbi3D72Q==
X-Received: by 2002:a05:6808:3022:b0:3b8:b063:825a with SMTP id ay34-20020a056808302200b003b8b063825amr12760002oib.92.1702610093592;
        Thu, 14 Dec 2023 19:14:53 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:38f6:9fa2:8e5a:fd25:71c:8c44])
        by smtp.gmail.com with ESMTPSA id p18-20020a056a000b5200b006ce835b77d9sm12552214pfo.20.2023.12.14.19.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 19:14:53 -0800 (PST)
From: Ghanshyam Agrawal <ghanshyam1898@gmail.com>
To: perex@perex.cz,
	tiwai@suse.com
Cc: Ghanshyam Agrawal <ghanshyam1898@gmail.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] sound: pci: au88x0: fixed spelling mistakes in au88x0_core.c
Date: Fri, 15 Dec 2023 08:41:44 +0530
Message-Id: <20231215031144.521359-1-ghanshyam1898@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Multiple spelling mistakes were reported by codespell.
They were fixed.

Signed-off-by: Ghanshyam Agrawal <ghanshyam1898@gmail.com>
---
 sound/pci/au88x0/au88x0_core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/pci/au88x0/au88x0_core.c b/sound/pci/au88x0/au88x0_core.c
index f217c02dfdfa..e5d867637336 100644
--- a/sound/pci/au88x0/au88x0_core.c
+++ b/sound/pci/au88x0/au88x0_core.c
@@ -1195,7 +1195,7 @@ static int vortex_adbdma_bufshift(vortex_t * vortex, int adbdma)
 				VORTEX_ADBDMA_BUFBASE + (((adbdma << 2) + pp) << 2),
 				snd_pcm_sgbuf_get_addr(dma->substream,
 				dma->period_bytes * p));
-			/* Force write thru cache. */
+			/* Force write through cache. */
 			hwread(vortex->mmio, VORTEX_ADBDMA_BUFBASE +
 			       (((adbdma << 2) + pp) << 2));
 		}
@@ -1237,7 +1237,7 @@ static void vortex_adbdma_resetup(vortex_t *vortex, int adbdma) {
 			VORTEX_ADBDMA_BUFBASE + (((adbdma << 2) + pp) << 2),
 			snd_pcm_sgbuf_get_addr(dma->substream,
 					       dma->period_bytes * p));
-		/* Force write thru cache. */
+		/* Force write through cache. */
 		hwread(vortex->mmio, VORTEX_ADBDMA_BUFBASE + (((adbdma << 2)+pp) << 2));
 	}
 }
@@ -1466,7 +1466,7 @@ static int vortex_wtdma_bufshift(vortex_t * vortex, int wtdma)
 				(((wtdma << 2) + pp) << 2),
 				snd_pcm_sgbuf_get_addr(dma->substream,
 						       dma->period_bytes * p));
-			/* Force write thru cache. */
+			/* Force write through cache. */
 			hwread(vortex->mmio, VORTEX_WTDMA_BUFBASE +
 			       (((wtdma << 2) + pp) << 2));
 		}
@@ -1854,7 +1854,7 @@ vortex_connection_mixin_mix(vortex_t * vortex, int en, unsigned char mixin,
 		vortex_mix_disableinput(vortex, mix, mixin, a);
 }
 
-// Connect absolut address to mixin.
+// Connect absolute address to mixin.
 static void
 vortex_connection_adb_mixin(vortex_t * vortex, int en,
 			    unsigned char channel, unsigned char source,
@@ -1880,7 +1880,7 @@ vortex_connection_src_src_adbdma(vortex_t * vortex, int en,
 			ADB_DMA(adbdma));
 }
 
-// mix to absolut address.
+// mix to absolute address.
 static void
 vortex_connection_mix_adb(vortex_t * vortex, int en, unsigned char ch,
 			  unsigned char mix, unsigned char dest)
-- 
2.25.1


