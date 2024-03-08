Return-Path: <linux-kernel+bounces-97263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D048767E2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 16:58:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4A0B1C21266
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 15:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7AE40861;
	Fri,  8 Mar 2024 15:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=risingedge.co.za header.i=@risingedge.co.za header.b="ixIfplB3"
Received: from outgoing1.flk.host-h.net (outgoing1.flk.host-h.net [188.40.0.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8351524A1A;
	Fri,  8 Mar 2024 15:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.0.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709913458; cv=none; b=rrqv12axNwIIoWw5H2Mmu3ZfQCWFVM8n90wQakqdBEzP0LS9yUXWemibR8nRyAQrmx8ckRLkYxmSV9Vu06tkXzE/ZmFmIRFTRJYwCfoQaowC7Ueo68ZTvFYH4/UxpZOOB2qeoEn3FtsXGcFJF7SZIPwjHUFq789/K1xsEVP5aQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709913458; c=relaxed/simple;
	bh=VpfafDNeLDnZU8DbCEHy4Mm5/XRPAsA2ZAQoU8vW100=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k4LlrQ8Btv8hK9pmJKDe0xeBBJcU/lyF+e7JoYdhRE24H4f/IupOeOcoOleU5W/ujJ+q4SXiD10km/iWhn2eXjpIgGrjN6xaD3BVuRztSZzrA3PVACouPDboLn4/d8IS02yWBH5owl67jTTiVvdk7I6OX0zgKU7S7D7Wa4VWgJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=risingedge.co.za; spf=pass smtp.mailfrom=risingedge.co.za; dkim=pass (2048-bit key) header.d=risingedge.co.za header.i=@risingedge.co.za header.b=ixIfplB3; arc=none smtp.client-ip=188.40.0.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=risingedge.co.za
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=risingedge.co.za
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=risingedge.co.za; s=xneelo; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:reply-to:sender:bcc
	:content-type; bh=vBKI8grnOpOHijTaMnyCfeyEYcYRwE/b3k1lM8VLtDY=; b=ixIfplB3iKx
	EFPsX8PifpasRP0FJ0EQlkLQUcjdOT9cnywlisHPFlFwCCsfC7R3ZQSnewCIVrh75lyAtX2bt1nEW
	Z7dc/piPTrMH5jc58tLy2lSO1il/b6cwJDpBXLDQK5J0Qd6ghHzpdwHW8eoTmbmANTv9CYcF6TTOg
	S5ttRDZ3lsqs75Iqt6MW7aYiIPO04Go33BByooLfm2k47IWnH0dhgnPnfaZ5yw2jG+W/N+InLEGSF
	9t5JCxmtJK45BjNeXOf40mSQ5rID36x1o5XoJrNHk6fKAbmrDvAvuUC5xeBqNArdyJYSJpJKT2ZAB
	oYBI0Nj2M7hEHUC4qcCczYw==;
Received: from www31.flk1.host-h.net ([188.40.1.173])
	by antispam3-flk1.host-h.net with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <justin.swartz@risingedge.co.za>)
	id 1ricbE-0066Pw-8t; Fri, 08 Mar 2024 17:57:33 +0200
Received: from [41.144.0.96] (helo=localhost.localdomain)
	by www31.flk1.host-h.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <justin.swartz@risingedge.co.za>)
	id 1ricbD-0007Wk-E0; Fri, 08 Mar 2024 17:57:31 +0200
From: Justin Swartz <justin.swartz@risingedge.co.za>
To: =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
	Sergio Paracuellos <sergio.paracuellos@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-mips@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Justin Swartz <justin.swartz@risingedge.co.za>
Subject: [PATCH v3 3/3] mips: dts: ralink: mt7621: add serial1 and serial2 nodes
Date: Fri,  8 Mar 2024 17:56:16 +0200
Message-Id: <20240308155616.11742-4-justin.swartz@risingedge.co.za>
In-Reply-To: <20240308155616.11742-1-justin.swartz@risingedge.co.za>
References: <20240308155616.11742-1-justin.swartz@risingedge.co.za>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: justin.swartz@risingedge.co.za
X-Virus-Scanned: Clear
X-SpamExperts-Domain: risingedge.co.za
X-SpamExperts-Username: 
Authentication-Results: host-h.net; auth=pass (login) smtp.auth=@risingedge.co.za
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: SB/global_tokens (0.00732381222984)
X-Recommended-Action: accept
X-Filter-ID: Pt3MvcO5N4iKaDQ5O6lkdGlMVN6RH8bjRMzItlySaT+SH+3mr1KguFjywS8Q24O2PUtbdvnXkggZ
 3YnVId/Y5jcf0yeVQAvfjHznO7+bT5wCPRB8bAzJcv2cv+UqiTTc2+CpNcmBnO4XM3Sck4bwNogU
 WCl1nkLBzZX0KuJ9bXiS85Z42w/+2OBolTNFbPomXFWCX8oNdggW7HE9XDTdSejrkEpbuUvwMvHx
 3T+KSG//gbuP7hnUK8NQdLwsVWKIFDZRrTGv3rxiw9tFrqFSCFNiLZt/QXQnOBRD+jq1HsKsDh/6
 Srgk2K3gr1VBfJbChkYH6fbrypLNrde+UooQVNLReLErukdelEOHUIpaBbp5GdnsN8+UvimwMinK
 0+Txhz2u9qvrL2PODYgMZQApJXOjDLkqunZ9NcY2bHZn7CfFscMZZf3sCkN20I5vMh4akiObI7Kj
 vK7X04QEin24qbfMFd8eGjnYW8aSH5qj4ujh/13psIvqSqJFa1CcANErDW/w69saM9prk3jNnHtn
 nuEt/J9wDZeQfiNOYsLDFBdwYt2XtlLzy7G7T4kla0JNnAWQx3FS11bhwUa9HCIwKB+TroNcRY33
 oNmH4nRQzHQazgY7lmveanvOdQzf6IMJ3345q/s6ySNrGnXycmhg3LegpHnla2pOekMkVY3GgX5w
 GYjbvhzWX8Co+5c+eruaLtBcNrQxKZYuPe8bdCyw79zlPbqLQkZr26Lcxdvj8cqI+CogZdOhX7v3
 ClXzrmMENhJLl6MBfhzHVBR0wHQZxzIUka7Uq615Mik1qzcz30+tdk6yIuh9K7v+Nq0Cm3JVhle6
 F/kpBdN+oWjoATjEFDwcaiz0R34rhTN+GTbl4uS+pZovX9cex7Ac4fawcerGI7TrGXpM/B/M0BZd
 PfIU1BX7pZc1sE3vsz58auH/srM2fgZ9JmgLbj7sqoEiwv7LCxIiAE5ODMnmwjvj2589zjbyZCiM
 WpBpW8YvoIIqmZcWhL/r/eFjMjJnMHeiAPOVK0T+c9pM0FteOLwuqFxkZtxbXpCgbiKBsA+Ddi6m
 awd1jemntr2PrMOTF1fDnHo5A9JQxMw0XtBqT5kbx7zuprmKeJENT1oiQUtfU17WEZPRHu1+r6ov
 Q/IKaojN7gdb+Glhdb8DP7Iz3Z0Qa+VGiF/lfNRtaK1t4SnssY938wKgOC3c9GkW+OmRHU05XGuW
 g+VcQ3bZb7F7k2CvWvw8dU3nESJ28XTJU7Gvp0Y54KqrVfxkslDLWpMoYEDRSzMkb5qgpERsDkCX
 BgcGBwKlYailDNhe7w2QIanZ/NegoJ79AXUnIiEEoyCaZXMG8LAkbJoO2tY/Mg5ClXd30oBm8U++
 JlmpaolH3tK93iPfP9/Yw4kOlmVPmT/LKBEbhIqMpZhRMd+q6EplQVIDdLCA03LYM3A6BXfvel8O
 EFDbU51Q2S43vcWL3lM20b9wQESc+PquLiZOpxiedGbqX4nzL9MgCv99rrli2UQdOGeuQqV2IVXB
 o/3R5VqqcOmERbjE+D5FzT0EaduWMjGSdmMR5Ch1HY0a4RW7JP9zvdSGB9tIDxuFtg36jUhUk8/b
 P2/Mw1j9lmNQqiIAMR1SEszVdPY4ocfmWv3Fe9Iziczdq+A=
X-Report-Abuse-To: spam@antispamquarantine.host-h.net

Add serial1 and serial2 nodes to define the existence of
the MT7621's second and third UARTs.

Acked-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
Signed-off-by: Justin Swartz <justin.swartz@risingedge.co.za>
---
 arch/mips/boot/dts/ralink/mt7621.dtsi | 40 +++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/mips/boot/dts/ralink/mt7621.dtsi b/arch/mips/boot/dts/ralink/mt7621.dtsi
index 68467fca3..02e1f2491 100644
--- a/arch/mips/boot/dts/ralink/mt7621.dtsi
+++ b/arch/mips/boot/dts/ralink/mt7621.dtsi
@@ -129,6 +129,46 @@ serial0: serial@c00 {
 			pinctrl-0 = <&uart1_pins>;
 		};
 
+		serial1: serial@d00 {
+			compatible = "ns16550a";
+			reg = <0xd00 0x100>;
+
+			reg-io-width = <4>;
+			reg-shift = <2>;
+
+			clocks = <&sysc MT7621_CLK_UART2>;
+
+			interrupt-parent = <&gic>;
+			interrupts = <GIC_SHARED 27 IRQ_TYPE_LEVEL_HIGH>;
+
+			no-loopback-test;
+
+			pinctrl-names = "default";
+			pinctrl-0 = <&uart2_pins>;
+
+			status = "disabled";
+		};
+
+		serial2: serial@e00 {
+			compatible = "ns16550a";
+			reg = <0xe00 0x100>;
+
+			reg-io-width = <4>;
+			reg-shift = <2>;
+
+			clocks = <&sysc MT7621_CLK_UART3>;
+
+			interrupt-parent = <&gic>;
+			interrupts = <GIC_SHARED 28 IRQ_TYPE_LEVEL_HIGH>;
+
+			no-loopback-test;
+
+			pinctrl-names = "default";
+			pinctrl-0 = <&uart3_pins>;
+
+			status = "disabled";
+		};
+
 		spi0: spi@b00 {
 			status = "disabled";
 
-- 


