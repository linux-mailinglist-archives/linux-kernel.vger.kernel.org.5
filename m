Return-Path: <linux-kernel+bounces-102518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3046687B32E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 22:03:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17372B24A3B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 21:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3244524DF;
	Wed, 13 Mar 2024 21:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pv4xYCTN"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E373548790;
	Wed, 13 Mar 2024 21:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710363796; cv=none; b=j9KviomTfd2fQDJAfgou6BztGHVyldlC464JUk+ZwkZPR7KNyCdeZwr60RzC8IRJoP1/QVQFG+EXcrPhGaQwc1o/SjPEhoheIzxPsjnLeoEvaWrV91yBWh3I0Mb6PI4HKpeWleT/AX/Xj/lD6+HRY35lqXNkiSZEThJ7p4BXbsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710363796; c=relaxed/simple;
	bh=ACHEgKTAg8x+dFZtHmiOZ6ed6ZmBbNNAKl8EfWjZ23w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FMAwItaHycHNny1fR1/Ray+vWC8Encf8q+g+0pcSIKe8QZS/OYI2mlQsZd8QdaNuHRSSpzSNARriQj5eP0TAP8Iq4Dh2cYioV1ng+JNoGg6Bz4ag8iWERrQ/BDj8txkBnNnn88/x6ibkEyg8qhDDbRokBI9GosYKFYcN6IeH26I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jessamine.co.uk; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pv4xYCTN; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jessamine.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-33e8b957a89so162213f8f.0;
        Wed, 13 Mar 2024 14:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710363792; x=1710968592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=tq4hB9Jc+RQGEXfo3JGmKPue/SQ5+ustCJP256hctDU=;
        b=Pv4xYCTNMsagRTeGESdLh602XzXI5JzVcwz8k4DII3Zy2c52+An90eKH0riwJay2F9
         mexQj49KoQwc51avqqSz6f4vcBOSGkUWgGB7mMA2z7+i91LQIhe3BpAsiWEmsodK4mRz
         R+HMb4M0n8Bk2hCutouYiJScVr2it0AlZRRveTSDmDmajLxnkHw6jL/CShNrWw4jds9K
         7llR9Soon2BJigq1ZBwDBNlhvRk2zk6SQdD/mOw3N6K5Px8QY9lG35ExyCYyDiG7neNS
         TprBl7IM4H9t3O1pXI+O1nXz7NqvyGAaECMgis8b1uzejWd0n6mrIgZ2kw0fQj5SyAo1
         BzCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710363792; x=1710968592;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tq4hB9Jc+RQGEXfo3JGmKPue/SQ5+ustCJP256hctDU=;
        b=IDapoNVVg9NeqWoWJLbOHzHKMWTUvOXP/q8RmYuvXsGlNqOtsrRV3V07w6EBCJyXxq
         4NzTXderV0ivkfRXVZtXu8pXHYkPru2E64Pu18SuiaUDxjPzOejrZjJQAPhhrdFrf90f
         KNyubwY8EKx3RuV+GTC/KBUwErgxyLohNM4J/EplfmQ5XXtONVsymH6QIm7ec6R0VyTb
         z2Tzomrx2tK8mdCVCp9qq4MoKdvheOhvlBA//FHsxH5BKsfZN3TcP+NawxqhGj1pdK8/
         W4Z4/b09F3cy3fvR4l1dKq0nzsq5n/36B0zxtQXgAKH3Afqh7iRehUmLnrbYcymuqy4K
         1M8A==
X-Forwarded-Encrypted: i=1; AJvYcCXi4KDPUNZ9J6PayL4C9/FgDbauV8Wv1yTZ5piGKqIdRlF5YQ4/l6MhEBdk2bIAn6ozgDQN+8nl2uMISBY06y6oJttpOV+rCHSmzXPJBn/nV3HvdU6pWV3ZwA+HKjQucQBwui9BiH3A
X-Gm-Message-State: AOJu0YzYNg4WAs9p94hOYRe8klzyKlhjzbbSVMdfNdxnPkE+x0OxX9gc
	N6pO992wcNGBL3CqS2W+2d2Delj4UEu+bbeKTcg98SO3bBuhFcM5
X-Google-Smtp-Source: AGHT+IFu4TelxqjAnGpxw9XNTbNBA19n/8DkVrVe8h754sX3c/i3QT50GNsGDIpqpSbb3P+DCJTECw==
X-Received: by 2002:adf:f386:0:b0:33e:96c1:3da6 with SMTP id m6-20020adff386000000b0033e96c13da6mr2397535wro.65.1710363792111;
        Wed, 13 Mar 2024 14:03:12 -0700 (PDT)
Received: from localhost.localdomain (munkyhouse.force9.co.uk. [84.92.42.80])
        by smtp.gmail.com with ESMTPSA id d16-20020adfa410000000b0033e87c6bcb2sm31712wra.8.2024.03.13.14.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 14:03:11 -0700 (PDT)
Sender: Adam Butcher <adam.jessaminenet@gmail.com>
From: Adam Butcher <adam@jessamine.co.uk>
To: broonie@kernel.org,
	benjamin@bigler.one,
	carlos.song@nxp.com,
	s.hauer@pengutronix.de,
	shawnguo@kernel.org,
	stefanmoring@gmail.com
Cc: kernel@pengutronix.de,
	linux-imx@nxp.com,
	linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org,
	adam@jessamine.co.uk
Subject: [PATCH v2] spi: spi-imx: fix off-by-one in mx51 CPU mode burst length
Date: Wed, 13 Mar 2024 20:58:19 +0000
Message-ID: <20240313210258.5990-1-adam@jessamine.co.uk>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Adam Butcher <adam@jessamine.co.uk>

992e1211dc91 ("spi: imx: fix the burst length at DMA mode and CPU mode")
corrects three cases of setting the ECSPI burst length but erroneously
leaves the in-range CPU case one bit to big (in that field a value of
0 means 1 bit).  The effect was that transmissions that should have been
8-bit bytes appeared as 9-bit causing failed communication with SPI
devices.

Link: https://lore.kernel.org/all/20240201105451.507005-1-carlos.song@nxp.com/
Link: https://lore.kernel.org/all/20240204091912.36488-1-carlos.song@nxp.com/
Fixes: 992e1211dc91 ("spi: imx: fix the burst length at DMA mode and CPU mode")
Signed-off-by: Adam Butcher <adam@jessamine.co.uk>
---

This is a cleaned up version of my earlier emails after the mess webmail
and I made of the previous re-address.  The patch itself is no different,
but I've moved the discussion part here and sent with git send-email so
hopefully no more issues.

The original patch submission up to v4 (first link above) did not contain
the bug that this patch fixes.  It was introduced in the v5 update (second
link).

---
 drivers/spi/spi-imx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 7c1fcd5ed52f7..100552e6c56bc 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -743,8 +743,8 @@ static int mx51_ecspi_prepare_transfer(struct spi_imx_data *spi_imx,
 				ctrl |= (MX51_ECSPI_CTRL_MAX_BURST * BITS_PER_BYTE - 1)
 						<< MX51_ECSPI_CTRL_BL_OFFSET;
 			else
-				ctrl |= spi_imx->count / DIV_ROUND_UP(spi_imx->bits_per_word,
-						BITS_PER_BYTE) * spi_imx->bits_per_word
+				ctrl |= (spi_imx->count / DIV_ROUND_UP(spi_imx->bits_per_word,
+						BITS_PER_BYTE) * spi_imx->bits_per_word - 1)
 						<< MX51_ECSPI_CTRL_BL_OFFSET;
 		}
 	}
-- 
2.43.0

