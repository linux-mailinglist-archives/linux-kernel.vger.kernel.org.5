Return-Path: <linux-kernel+bounces-27563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F8C282F248
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 17:19:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BBAF286165
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 16:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AABD31C6BB;
	Tue, 16 Jan 2024 16:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vvf0fhuu"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7683B1C69F;
	Tue, 16 Jan 2024 16:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-337b8da1f49so595483f8f.0;
        Tue, 16 Jan 2024 08:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705421929; x=1706026729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NMLlqCh2RRB/p799yyEGysccg2bTaRZ9dL/XaurTxmk=;
        b=Vvf0fhuueBDBk582fkaIq6DpY8AWbl5jHLgyf4rmdaf+2voTdW7pvQGWsm4HFScWSx
         RFYLpbenr0lwpTFWuIdtCRP+OWWZu2NE4d3aw1tnrcx9EfLtHte84LcrpRV6JqgZaY22
         UbSxZyRz3Yy5FU/pI+erQQulfdsB4CSXYidz/7HN1lopfgstPNfIBfwsShTM4I1P1FmN
         K0Zh+x34fc1c8DhZQe/jDWOQ+1bx7dUGmF9HzHCI76oYOzn53o5zdp/XCxBeMofeVPMa
         PuAMN7TQmpPLGZNztDTs6rj28rFfwYK0a2199tHn4g2P39KnCDXB9/tWMOz+Rm+5x159
         rcHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705421929; x=1706026729;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NMLlqCh2RRB/p799yyEGysccg2bTaRZ9dL/XaurTxmk=;
        b=g2MFXKVP9wGZ10Q/Bd5eGCeuzeOxRlAvuDKTx1Rp+WKyLzkFjPhnSzkR5mNGl6T45N
         7mR/t+Fi89ruJFCRWu/CcoOwGTplsEZ1I9bg7PRFehB7GXb+ahGwASCX4wQSdpc1t3ms
         7FSIFqVupUIgmN7URyZQbh/ELmEdtdts3X6TZUBwsbutfEs8X7OicnPOWPZ4ZiDi7IxS
         ZppNAEQ5OYMBE0k/2BT202+H/giJw8eVdcv19IfJTMQAy5Z74IfimK/speF49HCe0++H
         bsZ765fzIvkRLvubNBwP4Mu8mVk0LNoH/IkAWlkcxDOLBEvV1OCrNv91zfovKUjM4vaW
         qfPQ==
X-Gm-Message-State: AOJu0Yw9V3xV5OmQELBpQ2HKlGqgZ9b1rnRG3m9B6Nv7MIwr66vKjlqS
	2DnvLULoyeOsce0BuoRtXSc=
X-Google-Smtp-Source: AGHT+IGg9HcrXY9tosc+ZAXKh6ex/tlbdaBnq5t7i6gTzwXtjgngrhgqq3KD6H+lk5AFWZXSNp++jg==
X-Received: by 2002:a5d:6283:0:b0:337:4fa6:2306 with SMTP id k3-20020a5d6283000000b003374fa62306mr2602699wru.158.1705421928640;
        Tue, 16 Jan 2024 08:18:48 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id r1-20020adfce81000000b0033667867a66sm14956225wrn.101.2024.01.16.08.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 08:18:47 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Lars Povlsen <lars.povlsen@microchip.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	UNGLinuxDriver@microchip.com,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] net: microchip: sparx5: remove redundant store to variable clk_hz
Date: Tue, 16 Jan 2024 16:18:47 +0000
Message-Id: <20240116161847.2317011-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The store to clk_hz is redundant since clk_hz goes out of scope on the
return. Fix this by replacing the *= operator with just * to remove
the store back to clk_hz.

Cleans up clang scan build warning:
warning: Although the value stored to 'clk_hz' is used in the enclosing
expression, the value is never actually read from 'clk_hz'
[deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/net/ethernet/microchip/sparx5/sparx5_sdlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_sdlb.c b/drivers/net/ethernet/microchip/sparx5/sparx5_sdlb.c
index f5267218caeb..d8f49082dbe4 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_sdlb.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_sdlb.c
@@ -31,7 +31,7 @@ int sparx5_sdlb_clk_hz_get(struct sparx5 *sparx5)
 		clk_per_100ps = SPX5_CLK_PER_100PS_DEFAULT;
 
 	clk_hz = (10 * 1000 * 1000) / clk_per_100ps;
-	return clk_hz *= 1000;
+	return clk_hz * 1000;
 }
 
 static int sparx5_sdlb_pup_interval_get(struct sparx5 *sparx5, u32 max_token,
-- 
2.39.2


