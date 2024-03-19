Return-Path: <linux-kernel+bounces-107737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED328800FD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 16:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCF78281BDB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 15:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6777651BB;
	Tue, 19 Mar 2024 15:46:21 +0000 (UTC)
Received: from albert.telenet-ops.be (albert.telenet-ops.be [195.130.137.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96411823D9
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 15:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710863181; cv=none; b=c2IrUIs9L9zXx3hYSWwnS80cj2Rj/5a931cu7hClySJ5kRIVw2YvYMGSDbE1JiGYPiA+pl9VlovsTfK1g8bscwQMZzY0ha90NpCiinExwL3lenDbaIMUaRVPn0kuq1uyvsF8lTa8Gh1s4fJLvbbgv3eYOgrMNqXP3wLb/lue2j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710863181; c=relaxed/simple;
	bh=COltmYJO1++YuiN/+fIts00RxSIor65frAGKOCNQkDQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YTXTxxUKX88PNKkCnGr8kxrpR4vj+Q82wX9oS3EyUywkH1CrPKQe1rg6n8HglnspRsELkgDKE2dAn+KOV5JLwtIRMTfY07N1IW3rkNftu3mE/B2jKDxIxmGLRlSbSIyWTCVr3wL2ScLDdAjCPmrBiSWBSHjMCSZ7Cv9k2t6q3ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:76d0:2bff:fec8:549])
	by albert.telenet-ops.be with bizsmtp
	id 0fmA2C00A0SSLxL06fmAcF; Tue, 19 Mar 2024 16:46:12 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rmbev-00468l-FR;
	Tue, 19 Mar 2024 16:46:08 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rmbfE-000pFY-Cp;
	Tue, 19 Mar 2024 16:46:08 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Cc: devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 2/3] dt-bindings: timer: renesas,tmu: Add RZ/G1 support
Date: Tue, 19 Mar 2024 16:46:04 +0100
Message-Id: <aee943078c91e6c627f33a62c7cd2b73320a1dc5.1710862701.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1710862701.git.geert+renesas@glider.be>
References: <cover.1710862701.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document support for the Timer Unit (TMU) on RZ/G1 SoCs.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/devicetree/bindings/timer/renesas,tmu.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/timer/renesas,tmu.yaml b/Documentation/devicetree/bindings/timer/renesas,tmu.yaml
index 8df9d4718cf82a28..7670ec74eabdf4c3 100644
--- a/Documentation/devicetree/bindings/timer/renesas,tmu.yaml
+++ b/Documentation/devicetree/bindings/timer/renesas,tmu.yaml
@@ -23,6 +23,11 @@ properties:
       - enum:
           - renesas,tmu-r8a73a4  # R-Mobile APE6
           - renesas,tmu-r8a7740  # R-Mobile A1
+          - renesas,tmu-r8a7742  # RZ/G1H
+          - renesas,tmu-r8a7743  # RZ/G1M
+          - renesas,tmu-r8a7744  # RZ/G1N
+          - renesas,tmu-r8a7745  # RZ/G1E
+          - renesas,tmu-r8a77470 # RZ/G1C
           - renesas,tmu-r8a774a1 # RZ/G2M
           - renesas,tmu-r8a774b1 # RZ/G2N
           - renesas,tmu-r8a774c0 # RZ/G2E
-- 
2.34.1


