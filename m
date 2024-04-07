Return-Path: <linux-kernel+bounces-134552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19AFA89B2EF
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 18:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8B40282591
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 16:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70BC93A267;
	Sun,  7 Apr 2024 16:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="hnwqhEAT"
Received: from out203-205-221-235.mail.qq.com (out203-205-221-235.mail.qq.com [203.205.221.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2571EEE0;
	Sun,  7 Apr 2024 16:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712507333; cv=none; b=QIKpMZlyszVlmGWwWg7sxyvPXn6OKKtUuq2ZSnwSbicg15mPUeDUTn5BxzbolF1S7HsOhgjI8x/MkiVnUbYuv5N1NirlSB2yYYT5wdc3Fs4DJx3+TYusJp3Ayuf+b/noGXz6dMl9W7ab06IaJi+NQF9+w4vc6M63ipjJ8mi+WRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712507333; c=relaxed/simple;
	bh=wXV3PZPgCplDPzdxK8lDx5Fnt0zaJ4scVK+3RKlTX+Y=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=DUAURTybT1j+aH1gdYzKUTnTdQXQNIjIdqWnmyFzmmr/+TOfop3IDomAwN8r191MaafuLud9OXQna3FM9FMSn/Owb1CAmEzmiJPsgFCNXUoKA9fmg/JIB6X3LpDqMg6/G5vPxE0ZpTIOrXoYG4Bhw4x758dj++/jSP08cEyYJps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=hnwqhEAT; arc=none smtp.client-ip=203.205.221.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1712507322; bh=sxK2uMITViuWCRH/HETWDTh3a/M4c3Sxsj5q2qzVrG0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hnwqhEATw8fnz07DknXAyDTRPZ8Pp2mzcn2dFmsTqLmalxSpmBCY9MbJ7IsEWP3vR
	 jgts84IeDWsLLYzqxheODmmVPk/BbIslcuFsHTEUjAvsEFtv2cx9eJCHmGpwt1Fulw
	 DEHn2PfrPMnNZ3AZ4yBBk4lhXH5d5EwYloMoRagg=
Received: from cyy-pc.lan ([240e:379:225a:6d00:f878:7a6f:5832:7f4d])
	by newxmesmtplogicsvrsza1-0.qq.com (NewEsmtp) with SMTP
	id 726A94B5; Mon, 08 Apr 2024 00:28:38 +0800
X-QQ-mid: xmsmtpt1712507318tnhd39v60
Message-ID: <tencent_D0AEA0AC3695230C6E548C6DC843632F5F06@qq.com>
X-QQ-XMAILINFO: NMGzQWUSIfvTF2H89VCD5B5MquUUEi5HN2UvR+mZmWRrk2sUssVu8QvS6kZ7RJ
	 zFrw3scCVIf/ghuubj8+9YuqgIU/r08+2DFdTA+0J8jpQuwbv67FTaPbJePkfGkB8P0nqzg+nz1d
	 tivUeoDBVl8RmRRKaxfGXSVX7b49gij49y2cqVGRxfog6/i/d2qm8Te6mjFjAzx2X6qpknBCV5Z2
	 HCRSfRsPuMIIBEQxaSEbpFJlvjQO+YvGFvGjzCFRAHDby4DzNAx55FKxPGLzUYf8CbhY0IEN8aO+
	 UfX7JtFrEGQSfTqVVCCPokppeYGuzXvCIyYIZuTr4rrfWwTXd9j0vTg+qeYV1Jxgq/tNrhdnsv7o
	 Ip6mjXqdcRr31mo7C7SaWC9ow8mi5CDCX9Jbph3sIQKWhCUj5yiJ6zqqL/sIifhePNkCZztvbbcU
	 cRsTGi9IAMr0K/GRD8FCDPzuWKNGbu2H6IBhfXvyZ+uohd1H42F+PthZnzq/Sgk67WAB/SeGu83N
	 +XBjC2VjnShFIy2qN6YvnOwpnP87zjJZTqfpYKfZezF+upY2Urhyy5pf9k7I+JrlsMl9eZbNHQQA
	 u+gF5HlYWB1holPx5Oyxc8nFN+t5cQYppKOcezbjJKOHAjWEqDJV22lMBiizc5JyWAIeIgak5pJc
	 zklC8x1QW0oZF+KaFrjtkyyt3VWQpoPHoMnrzhAozWHSb7yUMC1qGlpAFkiznqRqn7BWDt1AuwoC
	 wLLZ8zLBCa/zVWmxxYwTvMXTkJK7GmAWYDGjd+z35XNljAONGvs45YZ5/4xdhaluGnZrIiEwJyGW
	 4QmaMLPNb9Vytd6b88fbpNSfGOIQPgYXJQiodFYRXu46xz/fpZwx10FkCn6zLboqxHTNaEfN1Bbx
	 pKYuCxvy+FInj6VtekOIFeR2QmHT0kUstrAFwVpzDoSlkI961OAc4A53l/T9qwlYzivIW/+Jcbp0
	 IPkodqxInigjj2wjySU324ivj1pNOXPU59e1XNMIBwg3X2pT+leCJJUaplhZn6eingyEQxVUOXOC
	 245G3A2viNTnaPdOvNVlyV5Lmja80=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: Yangyu Chen <cyy@cyyself.name>
To: linux-riscv@lists.infradead.org
Cc: Conor Dooley <conor@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Guo Ren <guoren@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yangyu Chen <cyy@cyyself.name>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH RESEND v8 1/6] dt-bindings: riscv: Add T-HEAD C908 compatible
Date: Mon,  8 Apr 2024 00:28:30 +0800
X-OQ-MSGID: <20240407162835.3199788-1-cyy@cyyself.name>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <tencent_22BA0425B4DF1CA1713B62E4423C1BFBF809@qq.com>
References: <tencent_22BA0425B4DF1CA1713B62E4423C1BFBF809@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The thead,c908 is a RISC-V CPU core from T-HEAD Semiconductor which used
in Canaan Kendryte K230 SoC.

Signed-off-by: Yangyu Chen <cyy@cyyself.name>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Guo Ren <guoren@kernel.org>
---
 Documentation/devicetree/bindings/riscv/cpus.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
index d87dd50f1a4b..d067f2a468ee 100644
--- a/Documentation/devicetree/bindings/riscv/cpus.yaml
+++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
@@ -47,6 +47,7 @@ properties:
               - sifive,u74
               - sifive,u74-mc
               - thead,c906
+              - thead,c908
               - thead,c910
               - thead,c920
           - const: riscv
-- 
2.43.0


