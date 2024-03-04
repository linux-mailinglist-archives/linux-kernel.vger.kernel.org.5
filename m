Return-Path: <linux-kernel+bounces-90868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A2B9870640
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 16:53:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C3ADB2DE8F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 15:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E650E54916;
	Mon,  4 Mar 2024 15:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i97N6omr"
Received: from mail-lj1-f195.google.com (mail-lj1-f195.google.com [209.85.208.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67131B273;
	Mon,  4 Mar 2024 15:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709566915; cv=none; b=OB/Q1FXJ99ZmrOdNwc9SVZnsGBqO80IfbF5HnwwUTbI545M47Yj0tPTgtXFoPl518LZsgOSVYWUDUXVH+qEIKtmd0Z0leKAVmfx8Qk4vs2nb/e0jPhBGYc6RpNpW0y6iHiJiGNGG5LPgr8ztgCx805f+7u60uI+gZxzs0tzVORI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709566915; c=relaxed/simple;
	bh=nmgrGwP2FRbrLoWBmRS5x9C72hF8cIBesBJn1r2098M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BuiPaTyUGb8bkhYFWwTi1LYpFXxUN2ZkSiYLcWGPESyyPreq7zDHn+JuEDa9V9jNjj6qscuNfUXLDMw8R9Dr8sFGtzKCTsPxGk29sTAngRSsTbuoa3jvWBD+qA1Ao+ED8U6u1ZV/ZmkszJA5M18x/SVh1UfdSc1/yaf12G55c98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i97N6omr; arc=none smtp.client-ip=209.85.208.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f195.google.com with SMTP id 38308e7fff4ca-2d28051376eso61695851fa.0;
        Mon, 04 Mar 2024 07:41:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709566912; x=1710171712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f4PpAK9wgHKNb8TpkpaUMCm8ieWupfA38sdT7J3+Wdk=;
        b=i97N6omrBsQzx/8oydtsCV1QUf6mbb9peHcxn5eIf0aL02PB337W25H41y7mlgci0u
         g4wBt1NbU5aYMXEKC9Ma2PYiH1MmrxqqXEGdjk4gU2d2qbVwXy8NcbkcdBDBAp6vFZHx
         6sFNRidmmL/JQIDL+miL6fqVdw67rzO4q6SKrS3EpuCa8HRNT2BglAKEIX4djc9Zb5at
         8RwmYMA4xRUilSLjhLknMgguqn9jguctMG+z7Y7beDxWHOkgH/d1CglO21VC528HGRZO
         P/YiJSVVevhcU4ADCBA5wllhv+ykL7Zhp/8UT+wFILFTyUmtfpKmhtv3XGlqL6uVww0T
         De2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709566912; x=1710171712;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f4PpAK9wgHKNb8TpkpaUMCm8ieWupfA38sdT7J3+Wdk=;
        b=qNQYtLPM7fFgnW0Y8RpgfRk36dXclZLplXlVYuBzAHrhxD7PnkG/O03Jcow/5NQIGG
         /mLWDqfwHTIUGufNgSUbCwbOe8/4fMESviv6wxMvO0Q+WLNrsSMIGLogDs0CtdOwez+I
         aKPfKgGWw/ByppNVenv6rDvGxqTfnnxTIgMUnF44M3iijlgcROLujdKSBTnAbi8WqG72
         DhhGascdkwYECunak8r+GEumMd5lPDI9sfpIqmttEVO/gYVikYffCHWSNPmRIgl9eTrJ
         a0CmK3MbqgJ18a4Gjewo6qto9T5/QdudX928wW3rkRYhQu4ITN+tcS1McZq7yvL9P2rx
         6AQA==
X-Forwarded-Encrypted: i=1; AJvYcCWggF50C9hWX2PGYYnlm7VsxUVEYhg/tsDc8F4xfcQaa0tPdjDD3jR35qaAkn6C6SVs570bj0EJ3q9vkQ/V5QTm1o3nHRVXrymvsUJB8VUPHnVdbjsBgToab17UOC6TDQsjck1W
X-Gm-Message-State: AOJu0YxeKfymrI2lFMzXsExTcxj03ilp0TkdvReSPvX990fpyRn/E1GI
	Q0+pnhpZ22sFfrXVcG3TXWv/TMYW8HQchuwEAIaQXq6kUkN8XZLu
X-Google-Smtp-Source: AGHT+IHw99FoIBXf9Te3aSumB+nAQ8X7inGiv8OvoeDNS0nl8G9w5mYZq0s6XwO/R7nQ6EgQwRa6ug==
X-Received: by 2002:a2e:bb94:0:b0:2d3:4c74:10cf with SMTP id y20-20020a2ebb94000000b002d34c7410cfmr4930703lje.24.1709566911536;
        Mon, 04 Mar 2024 07:41:51 -0800 (PST)
Received: from localhost ([2001:470:5139::fb2])
        by smtp.gmail.com with ESMTPSA id l27-20020a05600c1d1b00b00412c7b91ef0sm11681501wms.37.2024.03.04.07.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 07:41:51 -0800 (PST)
From: tobias.jakobi.compleo@gmail.com
To: Woojung Huh <woojung.huh@microchip.com>
Cc: UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Tobias Jakobi (Compleo)" <tobias.jakobi.compleo@gmail.com>
Subject: [PATCH] net: dsa: microchip: fix register write order in ksz8_ind_write8()
Date: Mon,  4 Mar 2024 16:41:35 +0100
Message-Id: <20240304154135.161332-1-tobias.jakobi.compleo@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Tobias Jakobi (Compleo)" <tobias.jakobi.compleo@gmail.com>

This bug was noticed while re-implementing parts of the kernel
driver in userspace using spidev. The goal was to enable some
of the errata workarounds that Microchip describes in their
errata sheet [1].

Both the errata sheet and the regular datasheet of e.g. the KSZ8795
imply that you need to do this for indirect register accesses:
- write a 16-bit value to a control register pair (this value
  consists of the indirect register table, and the offset inside
  the table)
- either read or write an 8-bit value from the data storage
  register (indicated by REG_IND_BYTE in the kernel)

The current implementation has the order swapped. It can be
proven, by reading back some indirect register with known content
(the EEE register modified in ksz8_handle_global_errata() is one of
these), that this implementation does not work.

Private discussion with Oleksij Rempel of Pengutronix has revealed
that the workaround was apparantly never tested on actual hardware.

[1] https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/ProductDocuments/Errata/KSZ87xx-Errata-DS80000687C.pdf

Signed-off-by: Tobias Jakobi (Compleo) <tobias.jakobi.compleo@gmail.com>
---
 drivers/net/dsa/microchip/ksz8795.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz8795.c b/drivers/net/dsa/microchip/ksz8795.c
index 61b71bcfe396..c3da97abce20 100644
--- a/drivers/net/dsa/microchip/ksz8795.c
+++ b/drivers/net/dsa/microchip/ksz8795.c
@@ -49,9 +49,9 @@ static int ksz8_ind_write8(struct ksz_device *dev, u8 table, u16 addr, u8 data)
 	mutex_lock(&dev->alu_mutex);
 
 	ctrl_addr = IND_ACC_TABLE(table) | addr;
-	ret = ksz_write8(dev, regs[REG_IND_BYTE], data);
+	ret = ksz_write16(dev, regs[REG_IND_CTRL_0], ctrl_addr);
 	if (!ret)
-		ret = ksz_write16(dev, regs[REG_IND_CTRL_0], ctrl_addr);
+		ret = ksz_write8(dev, regs[REG_IND_BYTE], data);
 
 	mutex_unlock(&dev->alu_mutex);
 
-- 
2.34.1


