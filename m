Return-Path: <linux-kernel+bounces-94616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D535874230
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 22:50:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A354B219D0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 21:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39AE1B81B;
	Wed,  6 Mar 2024 21:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=risingedge.co.za header.i=@risingedge.co.za header.b="UsPsRiTv"
Received: from outgoing6.flk.host-h.net (outgoing6.flk.host-h.net [188.40.0.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591FF2FB2;
	Wed,  6 Mar 2024 21:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.0.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709761832; cv=none; b=BKZmGSkZSms1DFzCMk064FFmOfukHL7cNAyxnnnslhZI9ZzO1X0pHo8H5QxxQIHowHsGmXaqutUGLco0CSpXLWPqonke0+SRK9b8RdaJ/uwf05i7SBN5nRMq3QDfbfVV0FYCxJDJMlHNAZkixjJ5+4BvDLWlOwQ/Mrt4wmknhGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709761832; c=relaxed/simple;
	bh=jTLu/CskI1DpNPy9Pf4ohMoqztsAevuZ1PuhJaJV/t4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YjlAnWcR4YDvE7DtHMlvkLwFWZ254TtKMng0ZQ1cLr80xOs4FZDdMq+u04vkeA6HjjFHDuaiZgWHFD5IdhI6Mum6B/Htx/2cD1e+MkumXpbLL0RhXnWmywfXIHQo7kOyWUrz86udT9vq6WFBTTeinBQYNk8CHGIyGySQs0sTNKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=risingedge.co.za; spf=pass smtp.mailfrom=risingedge.co.za; dkim=pass (2048-bit key) header.d=risingedge.co.za header.i=@risingedge.co.za header.b=UsPsRiTv; arc=none smtp.client-ip=188.40.0.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=risingedge.co.za
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=risingedge.co.za
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=risingedge.co.za; s=xneelo; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:reply-to:sender:bcc
	:content-type; bh=VpSsgGhBR4FyYxEHKoURzmKgm4LkFv8WoyeKAG8oCW8=; b=UsPsRiTvYIn
	ONbx1DqucGDf7Chz692IAbQp8V9Bl519eP2W4rVQVL0a7P2kiYUdeaC29BCW3kCxo+y/AFMp72mMq
	K+LlWXSJziXzZg1hFqVNtSep8PQAeYNg+vAyvqU1LTbA8AXtRmPd/+jgEmGVmuVthbXCN5+/l8nYo
	w87JnPyZOMXid3mB71NXsD6awQZKkNOwdL6JzFhyemSW6u4P2/Sye88T1eYD/Y8yOeBbyKxH79RIf
	q9jhvFddz0waPbWqHr4ynUn+6BPApoV5ztTpUdH320fTntyURH8QCp1jw1sonrE15sEBBuR2pq/h9
	BceqntpkkD6+EUXNInookCA==;
Received: from www31.flk1.host-h.net ([188.40.1.173])
	by antispam2-flk1.host-h.net with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <justin.swartz@risingedge.co.za>)
	id 1rhxc4-0088az-M9; Wed, 06 Mar 2024 22:11:41 +0200
Received: from [41.144.0.96] (helo=localhost.localdomain)
	by www31.flk1.host-h.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <justin.swartz@risingedge.co.za>)
	id 1rhxc3-0005PR-QU; Wed, 06 Mar 2024 22:11:40 +0200
From: Justin Swartz <justin.swartz@risingedge.co.za>
To: =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
	Sergio Paracuellos <sergio.paracuellos@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Justin Swartz <justin.swartz@risingedge.co.za>,
	linux-mips@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 2/2] mips: dts: ralink: mt7621: add serial1 and serial2 nodes
Date: Wed,  6 Mar 2024 22:10:44 +0200
Message-Id: <20240306201045.1475-2-justin.swartz@risingedge.co.za>
In-Reply-To: <20240306201045.1475-1-justin.swartz@risingedge.co.za>
References: <20240306201045.1475-1-justin.swartz@risingedge.co.za>
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
X-SpamExperts-Outgoing-Evidence: SB/global_tokens (0.00758473274125)
X-Recommended-Action: accept
X-Filter-ID: Pt3MvcO5N4iKaDQ5O6lkdGlMVN6RH8bjRMzItlySaT8C6SK0vybqcYHmQCnhqJHcPUtbdvnXkggZ
 3YnVId/Y5jcf0yeVQAvfjHznO7+bT5wCPRB8bAzJcv2cv+UqiTTc2+CpNcmBnO4XM3Sck4bwNogU
 WCl1nkLBzZX0KuJ9bXiS85Z42w/+2OBolTNFbPomXFWCX8oNdggW7HE9XDTdSejrkEpbuUvwMvHx
 3T+KSG//gbuP7hnUK8NQdLwsVWKIFDZRrTGv3rxiw9tFrqFSCFNiLZt/QXQnOBRD+jq1HsKsDh/6
 Srgk2K3gr1VBfJbChkYH6fbrypLNrde+UooQVNLReLErukdelEOHUIpaBbp5GdnsN8+UvimwMinK
 0+Txhz2u9qvrL2PODYgMZQApJXOjDLkqunZ9NcY2bHZn7CfFscMZZf3sCkN20I5vMh4akiObI7Kj
 vK7X04QEin24qbfMFd8eGjnYW8aSH5qj4ujh/13psIvqSqJFa1CcANErDW/w69saM9prk3jNnHtn
 nuEt/J9wDZeQfiNOYsLDFBdwYt2XtlLzy7G7T4kla0JNnAWQx3FS11bhwUa9HCIwKB+TroNcRY33
 oNmH4nRQzHQazgY7lmveanvOdQzf6IMJ3345q/s6ySNrGnXycmhg3BNVdpEcm8g/6PJN7TvsruKC
 n3oZFShGuGVczvnnMQuyLtBcNrQxKZYuPe8bdCyw79zlPbqLQkZr26Lcxdvj8cqI+CogZdOhX7v3
 ClXzrmMECwtAGwNe0eOvXAXd2nqZdzIUka7Uq615Mik1qzcz30/jNv+A51L2swh0gYW0eVWShle6
 F/kpBdN+oWjoATjEFDwcaiz0R34rhTN+GTbl4uS+pZovX9cex7Ac4fawcerGI7TrGXpM/B/M0BZd
 PfIU1BX7pZc1sE3vsz58auH/srM2fgZ9JmgLbj7sqoEiwv7LCxIiAE5ODMnmwjvj2589zjbyZCiM
 WpBpW8YvoIIqmZcWhL/r/eFjMjJnMHeiAPOVK0T+c9pM0FteOLwuqFxkZtxbXpCgbiKBsA+Ddi6m
 awd1jemntr2PrMOTF1fDnHo5A9JQxMw0XtBqT5kbx7zuprmKeJENT1oiQUtfU17WEZPRHu1+r6ov
 Q/IKaojN7gdb+Glhdb8DP7Iz3Z0Qa+VGiF/lfNRtaK1t4SnssY938wKgOC3c9GkW+OmRHU05XGuW
 g+VcQ3bZb7F7k2CvWvw8dbdRONqsj33t0is+SdoOwsk2luZvMBiCgALm/XUigxDlb5qgpERsDkCX
 BgcGBwKlYailDNhe7w2QIanZ/NegoJ79AXUnIiEEoyCaZXMG8LAkbJoO2tY/Mg5ClXd30oBm8U++
 JlmpaolH3tK93iPfP9/LMV7rNH+khni30uZSXlsmCOj6IY0UX9+ySU70SxRmHXLYM3A6BXfvel8O
 EFDbU51Q2S43vcWL3lM20b9wQESc+PquLiZOpxiedGbqX4nzL9MgCv99rrli2UQdOGeuQqV2IVXB
 o/3R5VqqcOmERbjE+D5FzT0EaduWMjGSdmMR5Ch1HY0a4RW7JP9zvdSGB9tIDxuFtg36jUhUk8/b
 P2/Mw1j9lmNQqiIAMR1SEszVdPY4ocfmWv3Fe9Iziczdq+A=
X-Report-Abuse-To: spam@antispamquarantine.host-h.net

Add serial1 and serial2 nodes to define the existence of
UART1 and UART2.

Signed-off-by: Justin Swartz <justin.swartz@risingedge.co.za>
---
 arch/mips/boot/dts/ralink/mt7621.dtsi | 38 +++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/mips/boot/dts/ralink/mt7621.dtsi b/arch/mips/boot/dts/ralink/mt7621.dtsi
index dca415fdd..2069249c8 100644
--- a/arch/mips/boot/dts/ralink/mt7621.dtsi
+++ b/arch/mips/boot/dts/ralink/mt7621.dtsi
@@ -128,6 +128,44 @@ serial0: serial@c00 {
 			pinctrl-0 = <&uart1_pins>;
 		};
 
+		serial1: serial@d00 {
+			status = "disabled";
+
+			compatible = "ns16550a";
+			reg = <0xd00 0x100>;
+
+			clocks = <&sysc MT7621_CLK_UART2>;
+
+			interrupt-parent = <&gic>;
+			interrupts = <GIC_SHARED 27 IRQ_TYPE_LEVEL_HIGH>;
+
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			no-loopback-test;
+
+			pinctrl-names = "default";
+			pinctrl-0 = <&uart2_pins>;
+		};
+
+		serial2: serial@e00 {
+			status = "disabled";
+
+			compatible = "ns16550a";
+			reg = <0xe00 0x100>;
+
+			clocks = <&sysc MT7621_CLK_UART3>;
+
+			interrupt-parent = <&gic>;
+			interrupts = <GIC_SHARED 28 IRQ_TYPE_LEVEL_HIGH>;
+
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			no-loopback-test;
+
+			pinctrl-names = "default";
+			pinctrl-0 = <&uart3_pins>;
+		};
+
 		spi0: spi@b00 {
 			status = "disabled";
 
-- 


