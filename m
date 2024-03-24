Return-Path: <linux-kernel+bounces-112854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62BFF887F08
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 22:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03313B213B0
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 21:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467E63D994;
	Sun, 24 Mar 2024 21:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="Xv1PQDAa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tIXQnmSo"
Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7631B18EA8;
	Sun, 24 Mar 2024 21:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711314520; cv=none; b=CV8y5m/2sBccP29iYOAiUIfvGm8DLdZxpj5CAKqBILoqLlnIZD6b7TqkMKSpKuT0GmdYTrQFehnz3Y8PkC33XRFlRV+wnU/MK0M/dqmdvz9R/utJpU6/HAeWbxDR/dBpKbH0XLUCjrCAnL7+9FWekdlKnXy+rzUKqpejTbCz+K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711314520; c=relaxed/simple;
	bh=g6WupTb5dbnL6Xg9TbYvNK6CI2ilfhW0pZM7alLeiRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Aw6PRtmyphNzZhT4rSop30P1LnyJJNrTBSySgbiZSPtTEbjV/k1nG+0dhrKhLofJzNargzQ8xijPAPq60b022ghJnA4TtY/UzuoKPVl5tH7RfV4tsOB3/4PR62KtuABftfMA7WMQNrEIqqCadsSiWiAd9uPbtLmGi2hyx3PR6Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=Xv1PQDAa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tIXQnmSo; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 95FD311400FF;
	Sun, 24 Mar 2024 17:08:37 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sun, 24 Mar 2024 17:08:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1711314517; x=
	1711400917; bh=htD7Xc/EdF+0+xuTojpID1s7Z/g8szPikEsSNl9QK4E=; b=X
	v1PQDAa87vYZtlhCdr3oMr7hfMiDnB89+TG5GUhKLECL3PYa1RA5T2QZnYYyjDNE
	xXW10F0Z3fjEffKgulh7IqWRQfmZNi5ZA1Jxpy2kFtMv5fIak9DeJvDmhUssawu8
	b2TOWNR4fE1mxCXgGpgka2QtL0EMw61iGMHFhN96uFEwO3nV9KIl/tpahl3HtCBG
	+DF+RCyQPjarj7FuUbaRdW/qKptCNjF7SKvF8DUrV7zlii+jva7U/L/22c/ToXj1
	wZKxwh/ZX3tz/TPCgDnMmmGM/g4l6aKMe93zP0Cw5RFPz/qayd6TNM2AGdq5gxt+
	xQHs8Wmi22dI5flAnwRKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1711314517; x=
	1711400917; bh=htD7Xc/EdF+0+xuTojpID1s7Z/g8szPikEsSNl9QK4E=; b=t
	IXQnmSodIWj9KeSSIvelemGDk4kfHZAmPdxTEBrHvZLB0ZIQecaDDSShgGzN+IL1
	RHU+ydpGCY2lgDMMX/ndd4eTVxfrMC6tCLnMJDLFdbDSvmVy3Fd5eamknqWHLH59
	RUKl8kBDc7GsOVzITTIIXSDQ2HNVUFillNIBamwcYnMQljpJzqAB9ZRtr2zsZvL/
	AO5CxYHuUtXfYnaj9lvlwCAgDNf1FYZXAcuXgl2yuMPisRDBBLZLChwbkVuhgJf1
	9tCzkzhXM1iqsc7cWGfA7vus5izM1LrDlfF0mDAFU92zEZ5RT8BAC49ura1x3yF2
	b6eW++LyOYvSm0gR66vpA==
X-ME-Sender: <xms:VZYAZvqvBPfiJ2SXZYFaJ4UOdwPhNVutreTEGc3Dpyy_VarbpIySEA>
    <xme:VZYAZpqlh7GbzUL6n-bAhYga6v4MHbHw1AcGOG9erwLn7O_q8vQtidCehXygPPKA3
    QSWrA1ldhhNzxxQvOE>
X-ME-Received: <xmr:VZYAZsM24qKaFODb0YTz8pH3sTZAFcKBUoJWobW6C6YO6dlVsecgfAAq8g12>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddtjedgudegkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecuogetfedtuddqtdduucdludehmdenucfjughrpe
    fhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforghrkhcurfgvrghr
    shhonhcuoehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggrqeenucggtf
    frrghtthgvrhhnpeeftddvjeefleffvefhgfejjeehudetteeigeeugfekhffhgeejudeu
    teehgfdvffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggr
X-ME-Proxy: <xmx:VZYAZi7vK3IBIws3FvTm77jleA98ggtz3eCya9rEnJTF5vT67wKDBg>
    <xmx:VZYAZu7uQ7TP28-0C1dx9rUQzxlUT1TssiR-BmZuv3lwWi4gZLhqDQ>
    <xmx:VZYAZqgr5fHPthcfctxM4JUF33q-AuvzMGZd4ZL9Zemv4hsNBYbBTw>
    <xmx:VZYAZg4YSkXRzU53LSyEhrhJFaf7NKyX4VnEC2eX2SqUBtx253IX6Q>
    <xmx:VZYAZhJT-3BbQx8bvU4I8Sk2_wTsjIUIID_iiOVXquNuoW3gE3KDPg>
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
Subject: [PATCH 3/4] platform/x86: thinkpad_acpi: Support for system debug info hotkey
Date: Sun, 24 Mar 2024 17:08:00 -0400
Message-ID: <20240324210817.192033-4-mpearson-lenovo@squebb.ca>
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

New Lenovo platforms are adding the FN+N key to generate system debug
details that support can use for collecting important details on any
customer cases for Windows.
Add the infrastructure so we can do the same on Linux by generating a
SYS_DEBUG_INFO keycode to userspace.

Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Signed-off-by: Nitin Joshi <njoshi1@lenovo.com>
---
 drivers/platform/x86/thinkpad_acpi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 2bbb32c898e9..854ce971bde2 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -1787,6 +1787,7 @@ enum {	/* hot key scan codes (derived from ACPI DSDT) */
 	TP_ACPI_HOTKEYSCAN_NOTIFICATION_CENTER,
 	TP_ACPI_HOTKEYSCAN_PICKUP_PHONE,
 	TP_ACPI_HOTKEYSCAN_HANGUP_PHONE,
+	TP_ACPI_HOTKEYSCAN_SYS_DEBUG_INFO = 81,
 
 	/* Hotkey keymap size */
 	TPACPI_HOTKEY_MAP_LEN
@@ -3337,6 +3338,9 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 		KEY_NOTIFICATION_CENTER,	/* Notification Center */
 		KEY_PICKUP_PHONE,		/* Answer incoming call */
 		KEY_HANGUP_PHONE,		/* Decline incoming call */
+		KEY_UNKNOWN,			/* AMT Toggle (event), 0x31A */
+		KEY_UNKNOWN, KEY_UNKNOWN,
+		KEY_SYS_DEBUG_INFO,             /* System debug info, 0x31D */
 		},
 	};
 
-- 
2.44.0


