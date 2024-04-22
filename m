Return-Path: <linux-kernel+bounces-154056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A768AD6AB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 23:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E6481F21DC1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 21:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C6C445C07;
	Mon, 22 Apr 2024 21:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H8FeMuID"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9093F8F1;
	Mon, 22 Apr 2024 21:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713821440; cv=none; b=NjnXhUigLCTtIJIZSHsTD5Af2gOMwrNMSbtCCo8WXi6Bq+si585PAApbmMGt8/FsYxGJwakGqoyzLVhCZ0xP498fgTgnZKPUCqcAuBWiXqXvB5geTvRJkOrghSziWvn4kcGJjWq+iQSODFPU8vOI/+OFnXV0Okfrhl7EEVZQgmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713821440; c=relaxed/simple;
	bh=OKGocTs3wvb3i/LU9C4kKygbgIvS929FJW/CU8uyACQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IfxwWS4baNIXnNHrSuHONJ+4D608/ndHOvCoESCQl+NFuzAW9Kh6PbLxeVILHoQyuVdStNFJA9gTSRtVs7UH4gUDIhRr4WMuxyTXm8kiZUMo0TA4umTfSQcwVdgk91aikVRJZLiEJ+yxTU0kfdesa+iQpJNifAfqhnDlUGMZxaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H8FeMuID; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-343d1003106so4140392f8f.1;
        Mon, 22 Apr 2024 14:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713821437; x=1714426237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6uD6c0ErLUmH66mx7g4ZxASc8upF0vA5uwn6xXQa6Dg=;
        b=H8FeMuIDprjoX0i9JDD2fIC3Bw+drttPqK2R9GOdKk3+u7TleAXTWf4u6Vmbl3aoGZ
         WeBbcaWvKbYdP5c2oWRaeu6S89HI9EUm+TUf6SJ8NsA2vl7rNpCl/IBasad6wKbXrEQk
         fdk2OCSG+42EOx5CCV2JwjRFdBnQQk4GyuynN8BOwGJN+OuvCUZqdPh+dyHLjRTEMd1v
         aXV9DJWP4d/b4LrW9UVqWMWRuMx8bl/CowMOkmR5pWLjbfWkVMMUMjSv/iralX8zdIaB
         jNi94QyLljHASiLZ3csuwv9l7wiQZLpOC2hb9RH6TZMa09dhidrZaZ6blauVabUNea2D
         aZnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713821437; x=1714426237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6uD6c0ErLUmH66mx7g4ZxASc8upF0vA5uwn6xXQa6Dg=;
        b=IlMG8TuGbtESt9z1Kl4F50rz5eqz2HOtMsZq7wNzZYh1hvoslr1gSHvFqILuLG1ZTW
         MIrWDfYHQr993wu7dvekOndB4rAIoWYH/UYq8M/850XFbVjcPHGm+1TpNkVenZFMNpSa
         g+IKVvs5d6YYEHt7NJdyrkLbufFZR7+B0ftwW1PLmVGc/kppNoo2dqaLQ3t66k/Bg4Wl
         zeeWfub73kdIj3WHXjLWNrh1Pkb/8tFeFcuk+bcUwDmJT9Szg1gnJPkWWo1z6zpTuf51
         HnCkpjOO/Z4uETRkYnJs1sTR/ljzRWF+88v9L8LhnCv8Map3qnAbEGdfIfEF1OF8Idlo
         KdvA==
X-Forwarded-Encrypted: i=1; AJvYcCXTAJQhYxnZPqg0DK60JIf5XQUQlyGRLfjh0ApUZp7W3uR2frep76W6RPz8oJHenzKrbbwM10Lfdw2Ke7i2N9SvLh9daDplGBjEPDNirriyUdc06RKzjMW156j7chCawkgDhraQWq1MBDjJEJebnj3vqyTXRIvcLiFZqwzCFnvXC+Qw4r0ecPOvL9c=
X-Gm-Message-State: AOJu0YzDA618zS5C9U1d51q3OBHe2JpENJMNxKaSWfN37XMh3rdKG5k6
	qRV9v1WIa88uwGU5y1GWRoE0f4Sv5ty1tsHRUSYX6ZA1SfgODEaC
X-Google-Smtp-Source: AGHT+IGVGJkxPueKpI6ONkATXh7YUVlSjFK9KdIYsor40QaumM6HoubFuig4IeeFRxpth0CK7JdN5A==
X-Received: by 2002:adf:f9c7:0:b0:349:d779:3d60 with SMTP id w7-20020adff9c7000000b00349d7793d60mr9568432wrr.57.1713821437219;
        Mon, 22 Apr 2024 14:30:37 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2500:a01:ab0d:124:447c:bf37])
        by smtp.gmail.com with ESMTPSA id n4-20020a5d4844000000b00349f098f4a6sm12886793wrs.53.2024.04.22.14.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 14:30:36 -0700 (PDT)
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
Subject: [PATCH 6/6] arm64: dts: renesas: r9a08g045: Update fallback string for SDHI nodes
Date: Mon, 22 Apr 2024 22:30:06 +0100
Message-Id: <20240422213006.505576-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240422213006.505576-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240422213006.505576-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Use 'renesas,rzg2l-sdhi' as a fallback string for SDHI nodes, where
hs400_disabled and fixed_addr_mode quirks are applied.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a08g045.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
index f5f3f4f4c8d6..2162c247d6de 100644
--- a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
@@ -182,7 +182,7 @@ irqc: interrupt-controller@11050000 {
 		};
 
 		sdhi0: mmc@11c00000  {
-			compatible = "renesas,sdhi-r9a08g045", "renesas,rcar-gen3-sdhi";
+			compatible = "renesas,sdhi-r9a08g045", "renesas,rzg2l-sdhi";
 			reg = <0x0 0x11c00000 0 0x10000>;
 			interrupts = <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
@@ -197,7 +197,7 @@ sdhi0: mmc@11c00000  {
 		};
 
 		sdhi1: mmc@11c10000 {
-			compatible = "renesas,sdhi-r9a08g045", "renesas,rcar-gen3-sdhi";
+			compatible = "renesas,sdhi-r9a08g045", "renesas,rzg2l-sdhi";
 			reg = <0x0 0x11c10000 0 0x10000>;
 			interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>;
@@ -212,7 +212,7 @@ sdhi1: mmc@11c10000 {
 		};
 
 		sdhi2: mmc@11c20000 {
-			compatible = "renesas,sdhi-r9a08g045", "renesas,rcar-gen3-sdhi";
+			compatible = "renesas,sdhi-r9a08g045", "renesas,rzg2l-sdhi";
 			reg = <0x0 0x11c20000 0 0x10000>;
 			interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.34.1


