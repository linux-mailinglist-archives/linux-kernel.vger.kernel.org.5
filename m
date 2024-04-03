Return-Path: <linux-kernel+bounces-130556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2908979E9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 22:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95B0428432D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF7415697E;
	Wed,  3 Apr 2024 20:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OKKWNDJw"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D135115687B;
	Wed,  3 Apr 2024 20:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712176603; cv=none; b=GIDitObpJF/6QF8TxDP9v0OtN7M2DgYHYGusSQgTW1kNNu0zX7kdVce7UqBdxnmY2v9IWooMKuxevhEVQ1sbo8YA9GvmyUJezR2DeV+kYSB2UsBHkyue9KwddA8O4xoXiVEKGGM7NY0devMtA40fQLVuPN/0vC2ZbShf1RZavjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712176603; c=relaxed/simple;
	bh=ym1B+YotZWSerPjFBcgO+xOuTrBddbeFCi8NmEi2Rhk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W2UHCTBZ10jUiDkSEE2wvmtwG87wZ05DUIVPbDN480+zFdb2oE3GLyGdRWHX76z3G5wVUNNnKDAlC3bdIVKnbSHC69YUGpir4DO3QLxLPxQepDIAQAuIxDsT7Dh0IYZ5iRvxtE82Ins7EK/c0MgCCH4d/5+Su0slGrifWEyHOAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OKKWNDJw; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4148c6132b4so8434615e9.1;
        Wed, 03 Apr 2024 13:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712176599; x=1712781399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jSGypoDfqpqf30JRW1cSjKb3kn4Y8om8katFtm1k9j8=;
        b=OKKWNDJwRYiEQExvMkuDSUAPwJOCPMxVjFNv9oTL0Lm7GX3hZzmvTMCPx56ofZk15G
         Bln8I9UhabF5MSb3s8koii/uw4msU5UHz/HjiYmn986trP1LDWjKd6YmJSa9GMkYgsNJ
         pwxuNio1QRZrI37v7uCI3piEafaOnVlskw3zcSXoCLriYGZA53X2IAlWnnK0jLcUBiyw
         ERJmrUCvzxqzR/x/3Iwci9eqOp35pI720YKVojzIlhk/VZit8Ts8JKnAtRpaXavMjNho
         vvGpBVAdz6immsQ+u/oe+YHqhS7fG29B3W365Nfnpg57GnE6hzBcPgmAfA7FAklytVJY
         aAEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712176599; x=1712781399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jSGypoDfqpqf30JRW1cSjKb3kn4Y8om8katFtm1k9j8=;
        b=M4hhZJyUI7O/91rHrBHHoIeuRcWMSpFa9OpmVX//VUDB0RLBclbcg3ECxuo9Jvz7b3
         nxO6DpdGCKTAGhX4labPMOz/xg21TaUnpLeYsH2O4linHF256yV3QN9FL8ECSJBNRJ9b
         MtdJDCnV1xuQ5Ex4T+g9pTrrQzFy92B9OsbMIRpeSOcp4TDfciWKM3itcGtzsfwsVkzi
         GmPEPu6JZO2kv4YW/pXIUDYGh6XN8Wn0d37M4MQmZFClB7mfCsgRx9OLUXxqwNYR2MjV
         ccC1vBKHrGk+TWbg4szjiv6QdY9nX0nSaaYS9lhfU2eR3KYg6ddKYlDCSO/FXbKHijhT
         zRWg==
X-Forwarded-Encrypted: i=1; AJvYcCXVaCm9b8Jih1NDqjLXl+Ws5msYX1PvSx+B3ocbg1x+vqS12n7Zf9YbEiOT3rjsRcRGMKzU6yTdlSZkm6y5o1PYlgUrRcJz80zxvoxBNGcrszbTMZdGzDLlUQf281cu2vfjDR4ejudLlrihxEdv
X-Gm-Message-State: AOJu0Yw4TBX7N9t02W06NBvdDwhtaudIj7046+AypZUUvVDYw2430xbo
	M4hxiezsY1SxmqDpu90zrzWQh9GOJ56sVAmZ1fZ5phGgFasg9OSFSAZZEwxc
X-Google-Smtp-Source: AGHT+IFyZ/P7OD6dXKo56fesVxWbcmlAoQodU4rrW7wCYbFjzNMLINpZAc8FOrmJHkASHxkvyr9Gjg==
X-Received: by 2002:a5d:5447:0:b0:343:7f4b:6da5 with SMTP id w7-20020a5d5447000000b003437f4b6da5mr2931617wrv.17.1712176599471;
        Wed, 03 Apr 2024 13:36:39 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2500:a01:5eb:3d93:f2b6:25e8])
        by smtp.gmail.com with ESMTPSA id p4-20020a05600c468400b00415f496b9b7sm244910wmo.39.2024.04.03.13.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 13:36:38 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 5/5] riscv: dts: renesas: rzfive-smarc-som: Drop deleting interrupt properties from ETH0/1 nodes
Date: Wed,  3 Apr 2024 21:35:03 +0100
Message-Id: <20240403203503.634465-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240403203503.634465-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240403203503.634465-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Now that we have enabled IRQC support for RZ/Five SoC switch to interrupt
mode for ethernet0/1 PHYs instead of polling mode.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v1->v2
- Included RB tag from Geert
---
 .../riscv/boot/dts/renesas/rzfive-smarc-som.dtsi | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/arch/riscv/boot/dts/renesas/rzfive-smarc-som.dtsi b/arch/riscv/boot/dts/renesas/rzfive-smarc-som.dtsi
index 72d9b6fba526..86b2f15375ec 100644
--- a/arch/riscv/boot/dts/renesas/rzfive-smarc-som.dtsi
+++ b/arch/riscv/boot/dts/renesas/rzfive-smarc-som.dtsi
@@ -7,22 +7,6 @@
 
 #include <arm64/renesas/rzg2ul-smarc-som.dtsi>
 
-#if (!SW_ET0_EN_N)
-&eth0 {
-	phy0: ethernet-phy@7 {
-		/delete-property/ interrupt-parent;
-		/delete-property/ interrupts;
-	};
-};
-#endif
-
-&eth1 {
-	phy1: ethernet-phy@7 {
-		/delete-property/ interrupt-parent;
-		/delete-property/ interrupts;
-	};
-};
-
 &sbc {
 	status = "disabled";
 };
-- 
2.34.1


