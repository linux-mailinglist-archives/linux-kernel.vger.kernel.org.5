Return-Path: <linux-kernel+bounces-164223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59FF58B7AE1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E159282250
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F90517B516;
	Tue, 30 Apr 2024 15:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j1uLVydq"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200A0175540;
	Tue, 30 Apr 2024 15:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714489230; cv=none; b=kNMQLTUE4rv56BaRXs2g7uxqtBXXm8IrKwHSBHQhl0j0ruzyJjEbGd4pmIGFtn4UkcRH/0awYEnIPpsDTG1hFXI6ZiNYyt/ygE354PyuKtOdLEv18YJTTHwRjHLk9HJySz32cQPh0mneR0BL6mSN4k03htyttTtgCMlTOePKhag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714489230; c=relaxed/simple;
	bh=Bl5wLPnJI1JHo3f5cnzQ5WKuWkR/lGPU4SVSe6nFHGY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CQasTdOFZFfbwfJIzFQbpr/IOfrRJfTebJDZIBoegqsmWWClplQXZc8XaoPn3otxWjVicPSXieauN5lmtc7umhT4sVLegR5bZo8vpbeKw7nvjujBUFGaXqKanq+6NDHj76gVeu4qD/FeGoy+/q81Q8imor1V6PrCGYYf6kYf4Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j1uLVydq; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2a2d0ca3c92so4109360a91.0;
        Tue, 30 Apr 2024 08:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714489228; x=1715094028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VPL3ZB5Fq5UNxhyYtLV/2F8lUrWQmHSxp7PRPwMffcw=;
        b=j1uLVydqzvREIMAXNMkGT6qMoLJ4eA4YU83fc+Doa81b3jxnlaw5l0BeNJJuenRJNm
         BGvFSJ/93f6syMHI3T4rpwXbRB5lvvrQmgr1QBVOidaCULF5yCK4cUja7A6YOTZS8yKx
         7kbCZLjOb4q0TUwKRg5sVAsk0CAvaHBABOFeCgCB7DZlFT1if+20naIhUK6HfzEvkCUg
         KNQjT7HAQ9dNgKMRQz+t1vdbkPd/Ra+vRagatBNkeiz4K61y3iMXSSHszUElgC8cW8TF
         YDYoO76QtxQW1R9ohBbA31elBeec/THG/8HBp1csRDhRawVUqXrBHU8E7R1sTyhO3G9g
         nnhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714489228; x=1715094028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VPL3ZB5Fq5UNxhyYtLV/2F8lUrWQmHSxp7PRPwMffcw=;
        b=PcPs5oCXBK6DIQYnu668CXgB5LtxjOuNQVVQVk5ISmFcIdT1DsrbC0oZFa1cRmwVPN
         FZYHSqrXAYcvJ8dta+JUmHCb06EI02rZsVrq40LiRuBUo2l9gTYIXXGCNOogKYUjewZn
         RgaaCBR3avCFNbGDbzfDmq3NPEhzFfprjQ18avUKdTbyatFPUmcn0nSllHfcSK+HNTT5
         QDj/0FQ101THgwJD3hCIEAMDm1EyAErZ7yNWaiG1qjuxyAnTCdZlCV631Dm/FA3HsmoR
         arynRiT3zgEmy9POX6gDNM7VXybFjiI/E4UBcg/Xll3PUCncOYK244yVVPiUNfQIbW9k
         L2SQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmtcJBYXHh+tnfJnhXAiUs1/AaqpfJpLSOWYBmttEOjS/p7zaG2oygPW/ia/DifJLzEqaj5YTIQPodhd7xUHNTHSTB8lXvrOYfiRGxWXrkMHCm8DqdgkskxalchRqtZsNacGiiwgD82/VB6TL3rouDTRDUgs5o0e17Z/hupb7nO9WRZP8y8wcj6LE=
X-Gm-Message-State: AOJu0Yw6A5HtJqLKZuMXyVcdrg8eRVZWXIP1AAVaMKLZ+z+P6AQdGBYt
	q8XQi6gnBKuhycZB7lPedlvy2G/+TCnRjOh69WZRI+Ip2Wkuef3i
X-Google-Smtp-Source: AGHT+IFgQEbg1gkKzEhlYyY2m5VcLF8An4CeFnqdezOOlXf2bek5mntgf1VMrEYl6lE5Rohe0v8ICg==
X-Received: by 2002:a17:90a:5283:b0:2b1:be71:15d0 with SMTP id w3-20020a17090a528300b002b1be7115d0mr4231238pjh.22.1714489228128;
        Tue, 30 Apr 2024 08:00:28 -0700 (PDT)
Received: from prasmi.domain.name ([103.219.60.80])
        by smtp.gmail.com with ESMTPSA id r6-20020a17090a5c8600b002ade3490b4asm15428745pji.22.2024.04.30.08.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 08:00:27 -0700 (PDT)
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
Subject: [PATCH v3 3/3] mmc: renesas_sdhi: Add compatible string for RZ/G2L family, RZ/G3S, and RZ/V2M SoCs
Date: Tue, 30 Apr 2024 15:59:37 +0100
Message-Id: <20240430145937.133643-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240430145937.133643-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240430145937.133643-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2->v3
- Collected the RB

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


