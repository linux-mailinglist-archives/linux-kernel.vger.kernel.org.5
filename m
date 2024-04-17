Return-Path: <linux-kernel+bounces-148993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6FD58A8A34
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 19:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20DBF1C239E5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC43172772;
	Wed, 17 Apr 2024 17:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="XCTh1WsG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="inT51Q5R"
Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6DC17166F;
	Wed, 17 Apr 2024 17:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713375098; cv=none; b=aJfxxvcTt2nHL3/wdZ0MHAxlqZFmMKbJ+P6lbDi3ci5sfJ9EKMl/BE0dpfe9Ag91irZ7DLEklQwHhw+5oT2/qS6rJ1MNNZCWSIa1mEnKxeMkc9pRrrjWuwgYa38fxcDYyMPOuSSoDzQi9pKhnqP+apo6avZH1uwRfqX2Ofo6/8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713375098; c=relaxed/simple;
	bh=wO4+zecjacYU614piFeSaVyXG3E3j3lSRVKYXk0fH8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mwp6Qr1UwbvOjm7JsSdpXTrUkahBS8lIJ/Lt4bo7AeWWqOyplvrgsPn/7Mz+RMSVlYU0Oy6DBY1zz9WyMHrayVmme67Ee0mqvQjfwlRXcSMQ5xo5Sv+wCPV50UxIKcdRnCrQmXoWsCEB53+URdLvzxQ9I0URoBtdJDP+hhphEN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=XCTh1WsG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=inT51Q5R; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 81A891380240;
	Wed, 17 Apr 2024 13:31:34 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 17 Apr 2024 13:31:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1713375094; x=
	1713461494; bh=8PaLecGiVuq16/Fn0qwhMRkqDVyOGQRBV6HYgL9CGPM=; b=X
	CTh1WsG7m7CeWuQXzC6O9miHFzw7D7qogV4q3SIgTXTOezHTWs4TYFVbNOiLpK5P
	ZUZWne6ullHLdyoYENd4KYt7U4FFn6tseiMHLfBu9jCay5g/vd35WjCLprlv+HPG
	o1BJ2Om3QJ1y0L3/VEu1mkYfnApBMjRtJ5yxuBfm4AnSo6+N6z0hTrd9D3O2ndW+
	b/6DMztpxkqmRZJ56D/Fk8qVYub/LVySUt5NUgVPmu2qZETJQbZxMyirDJB7dfPJ
	AGuddqf5AltN/eSyWCW87w3pemY2hfuCidZ6arGaGGO3pxSUM/5Bz+im8BreGyC3
	kijRMeqE2gEAdaAKgXeQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1713375094; x=
	1713461494; bh=8PaLecGiVuq16/Fn0qwhMRkqDVyOGQRBV6HYgL9CGPM=; b=i
	nT51Q5R7oQKSCArWg0YNMpfyKJd/hHShDzSR5iBBiJSTZfmnJq2URZk0Y7Z56inP
	1ccdyRP7RWYVW/Yb5fSp0zy9odDDVZL23rMQSxVS16zzwwc9W/BX3lAJ2sRVPJ9l
	AnDEQlPMGv9yHj42TnP4PdKrfAvoWxEFrnZJyGDg5WOyQuCOF4ge5ZQ4h5BCc1gE
	cT94rw14Ju92fYhGNW5zDyjL7UJlsPbPj0UZG6GzswUoSAy7PBsmGxlfqOvQbFml
	V3PDAHCkcTgeUPaUf2oOaozkumj85CBDbXHyrDA1Mo99runo23Laxe2FbvQk3iqT
	TB1MXnSPcvdFEYKZQmi2w==
X-ME-Sender: <xms:dQcgZs1GaO8wFZORwAr9ER0AaLtl5hCeguG8FWhtqVTS96PdJK9bUg>
    <xme:dQcgZnFv9PFpLKjcIpS52r2TOHD9Yhmnecogu6MnXAC6dSteqpnSqJFfhT9vLmWxS
    v2U5aAqWQ6OQLRFxtM>
X-ME-Received: <xmr:dQcgZk5Rv1Kbraruuit6HhsxwsOARvhgXziO3Tzv_G_KPaABLO8bGw1OjrVz0xb82QuYBlM3JVlTpKc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudejkedguddufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecuogetfedtuddqtdduucdludehmdenucfjughrpe
    fhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforghrkhcurfgvrghr
    shhonhcuoehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggrqeenucggtf
    frrghtthgvrhhnpeeftddvjeefleffvefhgfejjeehudetteeigeeugfekhffhgeejudeu
    teehgfdvffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggr
X-ME-Proxy: <xmx:dQcgZl0eTftfbUvV4Lr_MX6HrJCK76DQZlR3mIGILAscmwz3HYhOtg>
    <xmx:dQcgZvE_HSkPxXMcOj2vjJTJ59RPZfNK5pcS14FcaLp2nKOsetZQyw>
    <xmx:dQcgZu9b-Tn6iuMj60uX8orR2c2XdD1vaIH2AQ9rohDE5OhISJVrRA>
    <xmx:dQcgZklwtiy87DmNQrUdELgU1_LhUML2k7Xw2C7-OknebeLQ_wAerA>
    <xmx:dgcgZn-wh5Rgj-EAYdZUoim25eoR5ycRkplYNwrxIEAj2zc4xo4r9qs7>
Feedback-ID: ibe194615:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Apr 2024 13:31:33 -0400 (EDT)
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
Subject: [PATCH v2 1/4] platform/x86: thinkpad_acpi: simplify known_ev handling
Date: Wed, 17 Apr 2024 13:31:06 -0400
Message-ID: <20240417173124.9953-1-mpearson-lenovo@squebb.ca>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <mpearson-lenovo@squebb.ca>
References: <mpearson-lenovo@squebb.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Modify how known_ev event is handled in preparation for adding new keycode
range.

Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
---
Changes in v2: 
 - New addition to series based on recommendations from review.
 - Note previous input patch was dropped so in numbering gets replaced by this.

 drivers/platform/x86/thinkpad_acpi.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 82429e59999d..3b48d893280f 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -4026,6 +4026,7 @@ static void hotkey_notify(struct ibm_struct *ibm, u32 event)
 
 		send_acpi_ev = true;
 		ignore_acpi_ev = false;
+		known_ev = false;
 
 		switch (hkey >> 12) {
 		case 1:
@@ -4051,8 +4052,6 @@ static void hotkey_notify(struct ibm_struct *ibm, u32 event)
 				/* FIXME: kick libata if SATA link offline */
 				known_ev = true;
 				break;
-			default:
-				known_ev = false;
 			}
 			break;
 		case 4:
@@ -4078,11 +4077,8 @@ static void hotkey_notify(struct ibm_struct *ibm, u32 event)
 				tpacpi_send_radiosw_update();
 				send_acpi_ev = 0;
 				known_ev = true;
-				break;
 			}
-			fallthrough;	/* to default */
-		default:
-			known_ev = false;
+			break;
 		}
 		if (!known_ev) {
 			pr_notice("unhandled HKEY event 0x%04x\n", hkey);
-- 
2.44.0


