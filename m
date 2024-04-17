Return-Path: <linux-kernel+bounces-148995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32FAC8A8A37
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 19:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2FB82828A4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A85B172BAB;
	Wed, 17 Apr 2024 17:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="gHIjITaq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Sq6Ra274"
Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A78217167E;
	Wed, 17 Apr 2024 17:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713375099; cv=none; b=BmOQP3GXQdDOizQTJD2ldlsQKBRe4GT8mc1cbUvdVB/gPj1gQROsYQRpjZf2rxWNdDeBKVq1FlupZhWB6RbwnsVW3c4qHX4rW8W6+McRm1zT7FjjegsGrH6niM2IOioZxW0z0thsc3OLR4Wcb4so+PhWk6ZaLvJMjum95VMOFts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713375099; c=relaxed/simple;
	bh=0JAHJiBAOZAwICYmCaHzyi8YM+hQp8n1NB8LRVAqEtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a/PDfYdPb/vmi2R7HlVF/RYby2+N8b+FWdYxziS7MHgarJJOvwmbkQ40TapmJkjGdYLPhjFc1k6He6Txt1WkKf5Se6dsra8b0SoX/Toe4HuAc+Kpa0KP2s3K7+b3/U+hVwj12yIYBGmJlBEyTNJH+5mS8l5H9D7TzA024wrNiic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=gHIjITaq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Sq6Ra274; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id A1049138018C;
	Wed, 17 Apr 2024 13:31:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 17 Apr 2024 13:31:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1713375096; x=
	1713461496; bh=SYwB9sIOejL6LQqFoRXrJ2e291n7cnRoAR//09q6alM=; b=g
	HIjITaqGmgxzjcSsqZ5eMyEO4d79+zifVs0fL2PAeHvSkVHBfFrB6HBXpvLvtv4I
	FsbmSdwGAgwlQTXVhUfjgsIKGoOMgigxk+oBoDmKT41WgXKhCVE0C5H8IC1/m7l8
	gINOx4wmNcBOecRC76AfOHkO/N31qPWOinFo/udBbXyG1HzRUsHO1nabXFrMqOp7
	a5yEKzZAd9dSALhRPI/rgt3cZixoCVwEc21MySD9Wb4jgjFnL9r1HKXiZx+9zW3W
	kiAuZptu5TrKBYZKW3Cj/OoxWcOKbKG+ZDdfQ4L6tHMoXVYj+y7pCNbLJRYjLUr8
	q79wX5mghooSpGC6rnH0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1713375096; x=
	1713461496; bh=SYwB9sIOejL6LQqFoRXrJ2e291n7cnRoAR//09q6alM=; b=S
	q6Ra274NNPz4HODcAH1XBmQKuvlVCPdm5yrDbo//JzgGs1XAZO5L0s3KFfeIlCy+
	uOJOzfGvnNSR9T11x+GEe5llQWetx/45U9OWTT37tBJ+Rs6J8r78+6DznzT/cHo/
	efFhy0IUg8nsyN9ZnMT5j2NuD9w6t/uolI3RlZI7tp4KmilIbsm+KZ7OajOSacec
	qM4Q/d8T3CwkLZVe+tsgBCCJztBNO7N3wuFTXu3DxSEVZJI1kOeLF+8Qj1gSSfVZ
	dzOJPHHAl6Th7W/sk0yeSW5MMfWKINNURZp5P/5SRGVr6dhSKkB+oVCuYU3d7QLF
	8JqbVHsjS+kH7yJBMiRiQ==
X-ME-Sender: <xms:eAcgZoA0Y43IYpl7CYzzrBGQaAS3ksV8Nmz8l88YN7FI453jvodJlA>
    <xme:eAcgZqh2XgKWzw47mURMOuSKLSyLIBCL3-20hQwXeN_Y2Ku1LYZ4b4ScCy1h0RBIb
    8nOoA_vJUg3lMshyms>
X-ME-Received: <xmr:eAcgZrnNE-sIHVtmwasQgOlhA_e_0svil4CTLetuTKuHvp-UBaRy1A-boUwpXQDxfCAfO7ihRE3PXDs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudejkedguddufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecuogetfedtuddqtdduucdludehmdenucfjughrpe
    fhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforghrkhcurfgvrghr
    shhonhcuoehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggrqeenucggtf
    frrghtthgvrhhnpeeftddvjeefleffvefhgfejjeehudetteeigeeugfekhffhgeejudeu
    teehgfdvffenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggr
X-ME-Proxy: <xmx:eAcgZuw5sjvssJ8kM3TiuWV4231Yj5GSz83eSQI6TILWUKTfs4TEEg>
    <xmx:eAcgZtR1wNRuACSXxqzBVmucJS6va9K-FXUlmIlBJQaQeHYpi7Sxqw>
    <xmx:eAcgZpY_JXhL5oCb4xiHOZqI3TWvna1IPN06x_Gdc_PMumteMCsB9w>
    <xmx:eAcgZmRo4sPwx_bZ71cfkGo0s5vtLB6fY5Ge9UfI-J6-q8KnKd-FEQ>
    <xmx:eAcgZiIlQPq608KYQYiBra9DYp7l_jw7CaeplKiWXyAC6J2KUzu-jI6Q>
Feedback-ID: ibe194615:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Apr 2024 13:31:35 -0400 (EDT)
From: Mark Pearson <mpearson-lenovo@squebb.ca>
To: mpearson-lenovo@squebb.ca
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	hmh@hmh.eng.br,
	ibm-acpi-devel@lists.sourceforge.net,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	njoshi1@lenovo.com,
	vsankar@lenovo.com,
	peter.hutterer@redhat.com
Subject: [PATCH v2 3/4] platform/x86: thinkpad_acpi: Support for system debug info hotkey
Date: Wed, 17 Apr 2024 13:31:08 -0400
Message-ID: <20240417173124.9953-3-mpearson-lenovo@squebb.ca>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240417173124.9953-1-mpearson-lenovo@squebb.ca>
References: <mpearson-lenovo@squebb.ca>
 <20240417173124.9953-1-mpearson-lenovo@squebb.ca>
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
SYS_VENDOR keycode to userspace.

Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Signed-off-by: Nitin Joshi <njoshi1@lenovo.com>
---
Changes in v2: 
 - Improved comments on keycodes in init function.
 - Filled in missing gaps

 drivers/platform/x86/thinkpad_acpi.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 6d04d45e8d45..a2f21e958d39 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -1789,6 +1789,10 @@ enum {	/* hot key scan codes (derived from ACPI DSDT) */
 	TP_ACPI_HOTKEYSCAN_NOTIFICATION_CENTER,
 	TP_ACPI_HOTKEYSCAN_PICKUP_PHONE,
 	TP_ACPI_HOTKEYSCAN_HANGUP_PHONE,
+	TP_ACPI_HOTKEYSCAN_AMT_TOGGLE,
+	TP_ACPI_HOTKEYSCAN_CAMERA_SHUTTER,
+	TP_ACPI_HOTKEYSCAN_DOUBLETAP_TOGGLE,
+	TP_ACPI_HOTKEYSCAN_SYS_DEBUG_INFO,
 	TP_ACPI_HOTKEYSCAN_DOUBLETAP,
 
 	/* Hotkey keymap size */
@@ -3340,6 +3344,10 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 		KEY_NOTIFICATION_CENTER,	/* Notification Center */
 		KEY_PICKUP_PHONE,		/* Answer incoming call */
 		KEY_HANGUP_PHONE,		/* Decline incoming call */
+		KEY_UNKNOWN,			/* AMT_TOGGLE handled in driver, 0x31a */
+		KEY_UNKNOWN,			/* Camera Shutter Switch, 0X31b */
+		KEY_UNKNOWN,			/* DOUBLETAP_TOGGLE, 0x31c */
+		KEY_VENDOR,                     /* System debug info, 0x31D */
 		KEY_PROG1,                      /* Trackpoint doubletap */
 		},
 	};
-- 
2.44.0


