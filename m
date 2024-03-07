Return-Path: <linux-kernel+bounces-95727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B721D8751C7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 15:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 683991F26208
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3889D12EBE1;
	Thu,  7 Mar 2024 14:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aKTV4t7B"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E040512DDB3;
	Thu,  7 Mar 2024 14:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709821473; cv=none; b=dc+9Sa6a18dSuVJRaQLwOwmrbRbuVcrqzy+vVXKzxTGVodwbQji0gwapTykruhx03N1yNCJ79ee7iwDcuj8pdL5T/wRZK3kCNODkD1xWizpaCdMBaFqYMEv6vbOyanqCPR+wLOfW7o2HUMWkSSLWJhfenB0KcdoFRgRzxZnHAHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709821473; c=relaxed/simple;
	bh=xg1eOt0wglIkaWOSwgLrDSJpQ58XHwZw41RAzy80U4A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j9+YqdHhgn+Snn5C/AW4/CLRUWJmp7TcrH4u9xsO5bAortyPO09zFgnkBhItDklI1e8Fg7ZRRix0bJenr16u0ijYNEgkI90yyxdb2REHehNNL7KJs4IDSUHc6y459CjGzyXZvySMa+W5VtLoi145GMuvr2hUVcuQtic1bsJCd/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aKTV4t7B; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5682360e095so269047a12.1;
        Thu, 07 Mar 2024 06:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709821470; x=1710426270; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yMrD5Wxs5PDkGXlVNDeOqSMgdbBP8Z7tpc4n9PJoZbA=;
        b=aKTV4t7BIknIZvmH+S4QztIn1wAyhKXVolMSsYEYClnI/NaWO5gtO3k873ShQ0zxbZ
         7bosmtFl6vIMyDJb7gLzIASKV6nGxlf9N9LWRjTgO0Bmha2ZrCnqxkLBKr1ZzH9+T3j8
         fwxPre/BtAE01MzYN4d89tLG1Thfx99UXzaqY56jPrTgQoRK5zIXBqKEX3LXPcdOycsG
         K95liKQkO3pz3h5iSDmt1kUj2j2g9gxN190vwHh4cH2OwXBgN1j4U91TDPA2LDRFcQtA
         rgPDsPXTBs9DR8jjd8TxxGn9kKmQelNGgY4/D9NawJ8YZNSI7pVpbOL9ReGGm51Aofh5
         3wfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709821470; x=1710426270;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yMrD5Wxs5PDkGXlVNDeOqSMgdbBP8Z7tpc4n9PJoZbA=;
        b=LSZJ+zg9dyb1QKME6o9TwMF6ai6zOYTRf2ANmqdtVQSXyWb1/IRujUlcyyBcD7Zfax
         I+nG/N+4p+/LJ7EJeQVzC8w8B5AVSUiYHepGi6GTH39sbeV6s/NQRpzLOxIWh4zCP6TQ
         IqEv22dA3ZOG1h3IO56nBVusAFEAgfv5ETYkIB58bnqJIAw+hjOG/o/uQWNIpqKHmM/t
         elVsNpIsUZ4MjoSNshW9GUPOnJyY1Qt9tYDgX0PXgdpDxfFl739MM41f5D7EanErEZTI
         VoBtU8Snjy+mx6Hz7TGZTS5nFtRY22pyApC5oml3ki/RUdRRj3nJWY82N6+fuibRm18A
         sixA==
X-Forwarded-Encrypted: i=1; AJvYcCWfDi66S8nHPqo22NUh4OwlIjFfHTPARO3SpmZAr3QWUT7PgVu9k1T8u2DtmpYSh7vqP6Qz5MicR+Wrqm6Vhyb4bTieTeVP4aa+yOhYsyp0WuLs6u2hfHVw6AdGMarxPsJ04emW0grHiY+hLqiIe6+FxTTfbSjT2/hm
X-Gm-Message-State: AOJu0YzxEsob8wgqsqbu/aNopwRLRmPtas6YzkC8ydUzT7GLdjn+QJok
	eFuD/KBqCKiJiFust7pSWC0kZllMtvghhnBjvRyxpKQDcSttKrE2
X-Google-Smtp-Source: AGHT+IF79HyHdzTafjL8+9TtPINyr42uAy7otPI6ux6UmL68GF21GqJYuOJCvMPYHkWDwpo0mgCzMw==
X-Received: by 2002:a17:906:4818:b0:a45:2fc4:f25d with SMTP id w24-20020a170906481800b00a452fc4f25dmr8617282ejq.12.1709821469653;
        Thu, 07 Mar 2024 06:24:29 -0800 (PST)
Received: from pc-de-david.. ([2a04:cec0:102e:977f:c5e6:aa78:de82:531])
        by smtp.gmail.com with ESMTPSA id me12-20020a170906aecc00b00a45af5df0f3sm2371653ejb.112.2024.03.07.06.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 06:24:29 -0800 (PST)
From: David Gouarin <dgouarin@gmail.com>
To: 
Cc: david.gouarin@thalesgroup.com,
	David Gouarin <dgouarin@gmail.com>,
	Madalin Bucur <madalin.bucur@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Camelia Groza <camelia.groza@nxp.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH net v2] dpaa_eth: fix XDP queue index
Date: Thu,  7 Mar 2024 15:24:02 +0100
Message-Id: <20240307142402.906681-1-dgouarin@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ZeiNxaq3jzloO9l6@boxer>
References: <ZeiNxaq3jzloO9l6@boxer>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make it possible to bind a XDP socket to a queue id.
The DPAA FQ Id was passed to the XDP program in the XDP packet metadata
which made it unusable with bpf_map_redirect.
Instead of the DPAA FQ Id, initialise the XDP rx queue with the channel id.

Fixes: d57e57d0cd04 ("dpaa_eth: add XDP_TX support")

Signed-off-by: David Gouarin <dgouarin@gmail.com>
---
v2: add Fixes: in description
---
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
index dcbc598b11c6..988dc9237368 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
@@ -1154,7 +1154,7 @@ static int dpaa_fq_init(struct dpaa_fq *dpaa_fq, bool td_enable)
 	if (dpaa_fq->fq_type == FQ_TYPE_RX_DEFAULT ||
 	    dpaa_fq->fq_type == FQ_TYPE_RX_PCD) {
 		err = xdp_rxq_info_reg(&dpaa_fq->xdp_rxq, dpaa_fq->net_dev,
-				       dpaa_fq->fqid, 0);
+				       dpaa_fq->channel, 0);
 		if (err) {
 			dev_err(dev, "xdp_rxq_info_reg() = %d\n", err);
 			return err;
-- 
2.34.1


