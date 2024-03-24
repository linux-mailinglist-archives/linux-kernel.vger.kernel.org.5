Return-Path: <linux-kernel+bounces-112853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D41C887F07
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 22:09:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF3311C2105A
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 21:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAAEB3A8D0;
	Sun, 24 Mar 2024 21:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="FABWxOxM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UnZTQ76F"
Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE1C18659;
	Sun, 24 Mar 2024 21:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711314519; cv=none; b=r/DEm3nhj2nZBLJYkZ3CE9nE8mfN5BCDpeqALvRpqcJ/ostFnlLI1Y2tNN2zmm9BUMSj2pdR7Rlg66W3p4jVnl2M5oqPTK+ySOHlgMddGNPHFV7b3YuPoEqgg9I6pOPlI/Ra4169KMe42cw7lfvwIHptEKfAwQVtg1e2xA9gLg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711314519; c=relaxed/simple;
	bh=rifrElzx7wNZyg5yX40vRvlKTRB/AeUIbi3SjlZT/Zk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AC/Zq+Rvbw4CEBOCwFSBEe1eXFvj7WUnhCZkL4Ws3+VWxybIKBjvkgP+1eN6ZXJBP+YWAA5elOk2lIEX4qyzpkbU+g+gndORUtrytUCkJimw38Npe/Nea1xwL/ge3gOtNL/tUzJAZjxwsToa6Zehi5b/tyG7+kR18wDho0QuS/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=FABWxOxM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UnZTQ76F; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id C6F791140105;
	Sun, 24 Mar 2024 17:08:36 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Sun, 24 Mar 2024 17:08:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1711314516; x=
	1711400916; bh=aeOBteVst3EdJ6UR71Pe68DjYvvvoVNomGTQddIcz0M=; b=F
	ABWxOxMaiAaFjfrTIpn8xZ1SlsSP+zN8bbO3cyoB4+bw8ZqYmmh27wQTwhnpT90g
	GuWg+WHa3j5y0sdz6C4TOhFeJPk9FX/6UBPr45QITUvMK3jRRuV3wP1EB4I/ytz3
	mMj6LOdc1aOYVZU4y2MDg4nMg1ifXcXpaV9Etw8veYX9tAGDd3KT/cIe3cEvHZQw
	PRVSHp5+ZchFXBi2Q1nE6XUi+2DinsUdcRil4vKgGhDj44L+Y0UC6QWKa30rtwCn
	ek+Qjvt0I2fWwA1CFsIadEKOUN5gM4yiLWCbaNTqW5F3L8ld63JgTfCrCwNvBrFZ
	zKsOIox3ztQoz/R/y6+ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1711314516; x=
	1711400916; bh=aeOBteVst3EdJ6UR71Pe68DjYvvvoVNomGTQddIcz0M=; b=U
	nZTQ76FfFKZNJu+L4b0fitqZ6J4QNki1q208Gblip6G/yXxvduazhfX16nUdPq5n
	8ezV9RPHRag6nJbEcSWAbKSLsLeuKD/qOypZmGuVh/YBJHoT79wCpNcbv4GGF77m
	+fzPmfaB8XVYc1RVncN66J57mUj3u6CeC4uWvh+myiOdZMbagjuq4pyXW1m5Z22o
	EbkTulzstdZZ3KDLyk9YGAqA6Wf7ULOA0fogbxaepZ3vEgOJWBsfLKIbCzdUgNGq
	ChDSXljhwbJKPqdruS3AAEVEP07jP29N7lfdCj5SAsnb+GOMF46N16q6cpNEucG+
	APgng802rB+/Y0ctueBJg==
X-ME-Sender: <xms:VJYAZlUbvctG-24CBUWo4RHHCz2Pexclvlgxqyh599gEHGKvXLXEDw>
    <xme:VJYAZlkdZdbJaJUYgN_4wUOtcCMjs0JnVsH9dJg4m84ximwHUvjOj4Zj_WyhpSjCk
    YTJQMP4SBbR10LP86U>
X-ME-Received: <xmr:VJYAZhbN11RKmLHUiOw9_gSbAuxbgdoBCJdQrhSMfrstaGqb4YhVoDBrODQP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddtjedgudegkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecuogetfedtuddqtdduucdludehmdenucfjughrpe
    fhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforghrkhcurfgvrghr
    shhonhcuoehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggrqeenucggtf
    frrghtthgvrhhnpeeftddvjeefleffvefhgfejjeehudetteeigeeugfekhffhgeejudeu
    teehgfdvffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggr
X-ME-Proxy: <xmx:VJYAZoWCT2uUUREK9HlbAqjpqNovF5SPNVOT-u2rf-DTtt6M3DnKyA>
    <xmx:VJYAZvnU_QTY6D6ZwvQZ5TjFEktl2q0FMbCpIjMlORWelEzxMaIqtA>
    <xmx:VJYAZlcA3vFkvU_2IFT6aw2OXgvcklqOR4p5EdADNSKVSZVD_0J7nQ>
    <xmx:VJYAZpHgpaSnq1szIYQLn0JGvIDKPgpnwAeD48jPSXWc_XECPdWcsg>
    <xmx:VJYAZplkzV1U5uWVGf_YFXyNluKRHGSbMN5IQQCMR2f40XBhfslVFg>
Feedback-ID: ibe194615:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 24 Mar 2024 17:08:36 -0400 (EDT)
From: Mark Pearson <mpearson-lenovo@squebb.ca>
To: mpearson-lenovo@squebb.ca
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	hmh@hmh.eng.br,
	dmitry.torokhov@gmail.com,
	ibm-acpi-devel@lists.sourceforge.net,
	platform-driver-x86@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	njoshi1@lenovo.com,
	vsankar@lenovo.com,
	peter.hutterer@redhat.com
Subject: [PATCH 2/4] platform/x86: thinkpad_acpi: Support for trackpoint doubletap
Date: Sun, 24 Mar 2024 17:07:59 -0400
Message-ID: <20240324210817.192033-3-mpearson-lenovo@squebb.ca>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240324210817.192033-1-mpearson-lenovo@squebb.ca>
References: <mpearson-lenovo@squebb.ca>
 <20240324210817.192033-1-mpearson-lenovo@squebb.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Lenovo trackpoints are adding the ability to generate a doubletap event.
This handles the doubletap event and sends the KEY_DOUBLECLICK event to
userspace.

Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Signed-off-by: Vishnu Sankar <vsankar@lenovo.com>
---
 drivers/platform/x86/thinkpad_acpi.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 82429e59999d..2bbb32c898e9 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -232,6 +232,7 @@ enum tpacpi_hkey_event_t {
 
 	/* Misc */
 	TP_HKEY_EV_RFKILL_CHANGED	= 0x7000, /* rfkill switch changed */
+	TP_HKEY_EV_TRACKPOINT_DOUBLETAP = 0x8036, /* doubletap on Trackpoint*/
 };
 
 /****************************************************************************
@@ -4081,6 +4082,22 @@ static void hotkey_notify(struct ibm_struct *ibm, u32 event)
 				break;
 			}
 			fallthrough;	/* to default */
+		case 8:
+			/* 0x8036: Trackpoint doubletaps */
+			if (hkey == TP_HKEY_EV_TRACKPOINT_DOUBLETAP) {
+				send_acpi_ev = true;
+				ignore_acpi_ev = false;
+				known_ev = true;
+				/* Send to user space */
+				mutex_lock(&tpacpi_inputdev_send_mutex);
+				input_report_key(tpacpi_inputdev, KEY_DOUBLECLICK, 1);
+				input_sync(tpacpi_inputdev);
+				input_report_key(tpacpi_inputdev, KEY_DOUBLECLICK, 0);
+				input_sync(tpacpi_inputdev);
+				mutex_unlock(&tpacpi_inputdev_send_mutex);
+				break;
+			}
+			fallthrough;	/* to default */
 		default:
 			known_ev = false;
 		}
-- 
2.44.0


