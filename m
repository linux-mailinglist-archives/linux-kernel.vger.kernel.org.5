Return-Path: <linux-kernel+bounces-89793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D04B86F5BA
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 16:09:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB783B24C13
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 15:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61A667A1E;
	Sun,  3 Mar 2024 15:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GqGnHZgZ"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2552E412;
	Sun,  3 Mar 2024 15:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709478555; cv=none; b=ern8CoRfGXeyEnUsVJV2RautAa+ksFXuReIsy4wM/DQmd/G9sBzk4EnunbuzmeU+JjpKUsynSjKpd5cM65n4LPqNHLvPEnMB3BNX4Uqp6yz9wNx5FyukyftPPwiQ+LaHNMLaaKBU9Pd6ujBM/Z/dEvCqfuxxb57Uei2Gsh166W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709478555; c=relaxed/simple;
	bh=/1wh8J2QS8Yr1f07mrXqDFKaFHq+DR4G9sxTgBBjnD4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YCIkmCDCsXmMfqss/F41uWpbQDOsljV06pc2O8ebNm0Go8sOlShYJOfHpBi5akHB1Rd0K3VZrc+yG3mVwbOhCpbLs15s30X34Js9ydN2J8LrlPeCgsoDDVbsFdjqOzwXDygstKV2C2o4hPxlOQsU5Cbg9WeITq/ekWriWiJb9OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GqGnHZgZ; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d3b93e992aso2240321fa.1;
        Sun, 03 Mar 2024 07:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709478552; x=1710083352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sb9pY7Lk2NLjqbhUMYCC/cMsKMTEm5a/ly9NPqt4Fgk=;
        b=GqGnHZgZJPzkBnNMZifNEDk+oQ+Ui/6WS+TNgMNMcLlkNvETgtakGp3RP97Z56VMLO
         hBIoC2n9B81/CsawGcpms2Ihp3h2s2YihlXaZsNlsydfUutigFOfCg8CRWOlH0DRs3QX
         xMiXJI+47InoqPylcKaVA724iSM+UA3GOnzd7vA2W4LZuqq3P+drBjb7iPTv0rzxNyPz
         uOawtSNQD6Gw0/CJ3rQC2DLunFV9exKg83s6yLd6SVsoDqLPpcp0eLK+7g0wYSRrpEqW
         xF+Q/GNsdeNm9TbVDPiQW09TRowrL8QKsKvdjFKHuLfOZ1BouxRvXdv6XmfvLWyL7bsR
         bSxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709478552; x=1710083352;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sb9pY7Lk2NLjqbhUMYCC/cMsKMTEm5a/ly9NPqt4Fgk=;
        b=EdZg2Ql78x4F5p23rAAhobnKq8D88NSInsZNdf5O+fILwvhpek71b589QdPGQLE7qr
         KdTAD7LgiURpo5Hg4LGmRUcGvzvyplbX/QRpWPNVM/ZRi9LDiwXi1Qt/zRQAWoM5Gt6M
         DHEvNzkfYWe+dRUlfmaFkA0s57xv863BrmloISerkX/aiETlBpSd3nZk3c/n+5lHLG3T
         mglVKJmp3CFie5vQuMOBRSglegrmOo9A8ynGSFPwNmgm5T23h4KL7O25wiflUIC9aOj+
         23NUXzloxGY0MPsKdarlf74yXw5yPMQvSp4vjhOPj6AXnO2oC6Kit+O/+v8VyFXltFeS
         mncw==
X-Forwarded-Encrypted: i=1; AJvYcCV0erWtjJnfyXY2+v+BG3YEWWttXleRe7dLEMMyaRE+dUg40IFrogr3Mre+ny6JRNbD+mSMlvUokWLBLhrokN3oK3KOeDh3+i19fvGSG8Y01/h9f+4Vx2693CXNJ5NhN1FZHDHp
X-Gm-Message-State: AOJu0Yxu82bocolMWt4+2uirZfYrnr9KUHj8EPzVhM2EnXjeqbn+ALho
	L0GjxPrn+SX0gnYZZxqfKVf5C5c0S03XXjRbxEXWAag9nt/L45jkZSxjoxKG
X-Google-Smtp-Source: AGHT+IEi2OTj8hmu9gEBZJ3lG4QhAPESVkfB1q4vWDQtN73NM1xFhqUHERJFdwoZpqIjbnZYVFvE3g==
X-Received: by 2002:a05:651c:1414:b0:2d2:e2b1:4488 with SMTP id u20-20020a05651c141400b002d2e2b14488mr3784348lje.22.1709478551399;
        Sun, 03 Mar 2024 07:09:11 -0800 (PST)
Received: from localhost (dslb-002-205-020-122.002.205.pools.vodafone-ip.de. [2.205.20.122])
        by smtp.gmail.com with ESMTPSA id p3-20020a05640243c300b0055edfb81384sm3543129edc.60.2024.03.03.07.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 07:09:10 -0800 (PST)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] serial: core: only stop transmit when HW fifo is empty
Date: Sun,  3 Mar 2024 16:08:07 +0100
Message-Id: <20240303150807.68117-1-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the circular buffer is empty, it just means we fit all characters to
send into the HW fifo, but not that the hardware finished transmitting
them.

So if we immediately call stop_tx() after that, this may abort any
pending characters in the HW fifo, and cause dropped characters on the
console.

Fix this by only stopping tx when the tx HW fifo is actually empty.

Fixes: 8275b48b2780 ("tty: serial: introduce transmit helpers")
Cc: stable@vger.kernel.org
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
(this is v2 of the bcm63xx-uart fix attempt)

v1 -> v2
* replace workaround with fix for core issue
* add Cc: for stable

I'm somewhat confident this is the core issue causing the broken output
with bcm63xx-uart, and there is no actual need for the UART_TX_NOSTOP.

I wouldn't be surprised if this also fixes mxs-uart for which
UART_TX_NOSTOP was introduced.

If it does, there is no need for the flag anymore.
 include/linux/serial_core.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 55b1f3ba48ac..bb0f2d4ac62f 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -786,7 +786,8 @@ enum UART_TX_FLAGS {
 	if (pending < WAKEUP_CHARS) {					      \
 		uart_write_wakeup(__port);				      \
 									      \
-		if (!((flags) & UART_TX_NOSTOP) && pending == 0)	      \
+		if (!((flags) & UART_TX_NOSTOP) && pending == 0 &&	      \
+		    __port->ops->tx_empty(__port))			      \
 			__port->ops->stop_tx(__port);			      \
 	}								      \
 									      \
-- 
2.34.1


