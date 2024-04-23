Return-Path: <linux-kernel+bounces-155742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3786C8AF67F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 20:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3C1E287C94
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 18:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB6E1420DF;
	Tue, 23 Apr 2024 18:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JMBZLiws"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CCE13FD80;
	Tue, 23 Apr 2024 18:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713896694; cv=none; b=EdJMiaXmdlioS7ghgfh3aNqFHI68pg+GAJ5/V3WUSW3Mozpgo8rCwg471UMNRuLYDTJe9HjSyqOZPeAf6mXXwCNynfa5zCDy/tNI3zoEbE51ce8q2HI51IRClkGixWLyi2rQ2tMwx4lyYqFSMtcBPMjj9Nv+w3ngNC6qap+l5g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713896694; c=relaxed/simple;
	bh=hZXpn6sncLnJ5BYl3/Govg4131tShNgCwgt31oHiruY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FxzCTAE3pnpXih2NNkRKDLqCIwIBIPUSBz2pcxeaDvyEiRnKmwH7BafsNL/fXCmpy2qaduvNKGGT1J1OP4jKrF8Byl6jrV/ICrL1zd5pxMcj6Xj+7M9hmt4PcQssC1faR9R16Y3sM42QuH+IGfLsMxgwBFYfdoNTJ6hWRqr4MO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JMBZLiws; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-347c197a464so4446507f8f.2;
        Tue, 23 Apr 2024 11:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713896691; x=1714501491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zcXVIv+7e491TfWyKyCBV0/lSX58PoR++IgkI2tjySg=;
        b=JMBZLiwsWHydR7qsWWtkhowsR+DIJdpYxsbXWWC6aDGPNq5ssu//IkTa6THjqME7oN
         DzD8cqbQ4KqvTAKys+erWy7JkfQ7Vqlz/IT4MYTGzY2hAKGCa4iJiPsaznPECbRCyk3T
         EYaI9tQeyNIr11HS7nyCUUzMRJWlxLd8ax1rFbqK0DolD72DezEl+T+bJGTHdR5iJQ70
         vQawv9Lz2AG3HSaeK7ZXl8y4JmxnRM8GorpyaA3eVpviH5+DJKQVPRI8ED2RQNCevhu8
         qH1KNQfajlZocAPa6jY0XM5saVVXfvTivzSH7VDvAWWuKTHGaw9vjrWlztpiZZ2gFzLz
         GMjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713896691; x=1714501491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zcXVIv+7e491TfWyKyCBV0/lSX58PoR++IgkI2tjySg=;
        b=wiAmHeKmijQ7k4sxaNkcoouuLQDAFEM0fZzPss7fwHDAQwp7/yEMGzZittfzw4yGNv
         dAGUfhSB6gVcfnA5suTfo0L9RaDXz58/jvFwwdj4UVh1mwt+bJTeGF3iEGcyuDdh2EFq
         prE4kMxXwTsd8zkny3GD0xV+fFmqQYBDoE2cyCNA1yZR2LEMzNG4YpvKbckFumFG4GGu
         5pI/MZRcyzGky/zQOXqZKXuHQ8ypdrbcsCsB+WEMlfvqmI2wnNxqBTXaBW04CH+P4uiR
         IZ42uImO30ycGPX+/tURapWcHyP0MK2PQrweSEQhQrw6sWjBlVFmNBj+be0zZ4d86tWh
         O9CA==
X-Forwarded-Encrypted: i=1; AJvYcCV/81fXDITFVv9nbFFbaeY6H0Ff31Wp5Xs3fw6DcdRxw5DLXez0dG0y0M/e6UP++kkNGeBwFeY/Z3Yd9rzS1d+9n98WFxNe211FIQnhJdjko6W5LLlxE0028H9mtGtSjW1t41sG8QOc9qZxDSlP9Si8+cJIWsLNEUSLLigAiKd0MVtJr7hbhOMsD1g=
X-Gm-Message-State: AOJu0YxPySssi3LvHapV96Y3F74ndJEzpPPrfV1tTcLBihqboUTgeX+Y
	4ENLqHNuew2g+jB9A4yZ5QvLZnhzp57B1YHLxcrFORzdVifIye9G
X-Google-Smtp-Source: AGHT+IHrSqFS+DEfgEIluSF22QW51LWtQRjCQKd/OwfrumoKw4TonPuRGtLefAcs4+rYI9YrbmNPPQ==
X-Received: by 2002:adf:ec42:0:b0:34b:684e:485d with SMTP id w2-20020adfec42000000b0034b684e485dmr11165wrn.53.1713896691262;
        Tue, 23 Apr 2024 11:24:51 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2500:a01:cef0:9ed3:1428:f85f])
        by smtp.gmail.com with ESMTPSA id t15-20020adfeb8f000000b00349ff2e0345sm15319164wrn.70.2024.04.23.11.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 11:24:50 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-mmc@vger.kernel.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 3/3] mmc: renesas_sdhi: Add compatible string for RZ/G2L family, RZ/G3S, and RZ/V2M SoCs
Date: Tue, 23 Apr 2024 19:24:28 +0100
Message-Id: <20240423182428.704159-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240423182428.704159-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240423182428.704159-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

- RZ/G2UL and RZ/Five ("r9a07g043")
- RZ/G2L(C) ("r9a07g044")
- RZ/V2L ("r9a07g054")
- RZ/G3S ("r9a08g045")
- RZ/V2M ("r9a09g011")

The above SoCs have HS400 disabled and use fixed address mode. Add a
generic compatible 'renesas,rzg2l-sdhi' fallback string for these SoCs,
where fixed_addr_mode and hs400_disabled quirks are applied.

For backward compatibility, compatible string 'renesas,sdhi-r9a09g011' for
RZ/V2M is retained.

Also rename sdhi_quirks_r9a09g011->sdhi_quirks_rzg2l and
of_r9a09g011_compatible->of_rzg2l_compatible to make it generic.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v1->v2
- Updated commit message
- For backward compatibility retained RZ/V2M compat string
---
 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index 53d34c3eddce..422fa63a2e99 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -210,7 +210,7 @@ static const struct renesas_sdhi_quirks sdhi_quirks_r8a77990 = {
 	.manual_tap_correction = true,
 };
 
-static const struct renesas_sdhi_quirks sdhi_quirks_r9a09g011 = {
+static const struct renesas_sdhi_quirks sdhi_quirks_rzg2l = {
 	.fixed_addr_mode = true,
 	.hs400_disabled = true,
 };
@@ -255,9 +255,9 @@ static const struct renesas_sdhi_of_data_with_quirks of_r8a77990_compatible = {
 	.quirks = &sdhi_quirks_r8a77990,
 };
 
-static const struct renesas_sdhi_of_data_with_quirks of_r9a09g011_compatible = {
+static const struct renesas_sdhi_of_data_with_quirks of_rzg2l_compatible = {
 	.of_data = &of_data_rcar_gen3,
-	.quirks = &sdhi_quirks_r9a09g011,
+	.quirks = &sdhi_quirks_rzg2l,
 };
 
 static const struct renesas_sdhi_of_data_with_quirks of_rcar_gen3_compatible = {
@@ -283,7 +283,8 @@ static const struct of_device_id renesas_sdhi_internal_dmac_of_match[] = {
 	{ .compatible = "renesas,sdhi-r8a77970", .data = &of_r8a77970_compatible, },
 	{ .compatible = "renesas,sdhi-r8a77990", .data = &of_r8a77990_compatible, },
 	{ .compatible = "renesas,sdhi-r8a77995", .data = &of_rcar_gen3_nohs400_compatible, },
-	{ .compatible = "renesas,sdhi-r9a09g011", .data = &of_r9a09g011_compatible, },
+	{ .compatible = "renesas,sdhi-r9a09g011", .data = &of_rzg2l_compatible, },
+	{ .compatible = "renesas,rzg2l-sdhi", .data = &of_rzg2l_compatible, },
 	{ .compatible = "renesas,rcar-gen3-sdhi", .data = &of_rcar_gen3_compatible, },
 	{ .compatible = "renesas,rcar-gen4-sdhi", .data = &of_rcar_gen3_compatible, },
 	{},
-- 
2.34.1


