Return-Path: <linux-kernel+bounces-19949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 427DC827742
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 19:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D05AB284A8A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 18:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC1256B82;
	Mon,  8 Jan 2024 18:17:07 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6324156777;
	Mon,  8 Jan 2024 18:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ccbf8cbf3aso27160801fa.3;
        Mon, 08 Jan 2024 10:17:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704737823; x=1705342623;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZTbnmv//8S6AoGwmpmf7bKm2BZ2V4fg+EHVTPs33yVA=;
        b=Zk2kuCIQoehaLfx7CSBho0Tc1NPiPflvOYvqZKIR0vOkj0/o4WD8TO5XODbH+8NHfw
         caZu9OtXSZ23uh4/i3SCvfC4CNg9tyjMBMDYP3enEtDmB+BKdxDCtylZSM7Wr5jUosM5
         5LdQlTYn2VX+V26USd0ed6ZbuFSHC+hksfuwr/YYuhmLopPhYPt0ZGRS4SMVOHYdTwm2
         IbOjruJ9vKidMQBX6Hh8WPMjm71y5O44OiY4955sAT22B/C20HS4FbMZCsqHdhtc89s4
         fjBfF1C+brDPxF2kOLyf7rxoiSzyexKl3sHY/0gLcdYm0iO/IG4F9c5y3ONXYraALIGH
         AS4g==
X-Gm-Message-State: AOJu0Yz+NpmT97Bio1IYgoV/HQHzJ1AdHlN42Usqvo9zC9Wg+ZRgrwIs
	SdsCEG/PdJ75jNUfXW9nTdQ=
X-Google-Smtp-Source: AGHT+IG/YKMNWq9Ur9N/wASmN0Xl3EdEs2BMrhUl9KbhdT7qB2KLXiVpvQS9WcC8+noseq7/jC5QQg==
X-Received: by 2002:a2e:9347:0:b0:2cc:2b43:566c with SMTP id m7-20020a2e9347000000b002cc2b43566cmr1779053ljh.14.1704737823369;
        Mon, 08 Jan 2024 10:17:03 -0800 (PST)
Received: from localhost (fwdproxy-lla-007.fbsv.net. [2a03:2880:30ff:7::face:b00c])
        by smtp.gmail.com with ESMTPSA id a1-20020aa7cf01000000b00552d45bd8e7sm90125edy.77.2024.01.08.10.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 10:17:03 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Alexander Couzens <lynxis@fe80.eu>,
	Daniel Golle <daniel@makrotopia.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org (open list:ARM/Mediatek SoC support),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC support),
	linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC support)
Subject: [PATCH net-next 10/10] net: fill in MODULE_DESCRIPTION()s for PCS Layer
Date: Mon,  8 Jan 2024 10:16:10 -0800
Message-Id: <20240108181610.2697017-11-leitao@debian.org>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240108181610.2697017-1-leitao@debian.org>
References: <20240108181610.2697017-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
Add descriptions to the LynxI PCS MediaTek's SoC.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/pcs/pcs-mtk-lynxi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/pcs/pcs-mtk-lynxi.c b/drivers/net/pcs/pcs-mtk-lynxi.c
index 8501dd365279..4f63abe638c4 100644
--- a/drivers/net/pcs/pcs-mtk-lynxi.c
+++ b/drivers/net/pcs/pcs-mtk-lynxi.c
@@ -303,4 +303,5 @@ void mtk_pcs_lynxi_destroy(struct phylink_pcs *pcs)
 }
 EXPORT_SYMBOL(mtk_pcs_lynxi_destroy);
 
+MODULE_DESCRIPTION("MediaTek SGMII library for LynxI");
 MODULE_LICENSE("GPL");
-- 
2.39.3


