Return-Path: <linux-kernel+bounces-146536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C679C8A66AF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 11:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DF5D1F22403
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 09:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C9384D05;
	Tue, 16 Apr 2024 09:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="a8WPsd9C";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Bg8lTRxi"
Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4636685286;
	Tue, 16 Apr 2024 09:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713258271; cv=none; b=c6x2f8t9PmH+TTMF0jGklBOiNuet/liASwyvvo59aM+YrFGrI/+LaKNjUKCoY161ktqO/vAxSWhqStSFIm17IPhqFJECI0VE3zh6WeZsWUck72H+BrSwAa9+XSoecIUsFQbcXUM1irm5pHwk2s4koKBYsVUCilD6j/WjkMXKDyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713258271; c=relaxed/simple;
	bh=HxVQ221L/vE0HrOBV6Jo6DE05cBEweUIncG5yctBRHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cUN30ybdAcAx4QjApHBV+6pJSts3sFh+EJrV7N1AXlUQWWm5TijdNFTvzv9o68q2x6ko4+5+LEw4teBO5DhIIO0TGFe4xknCtf3EE/lTAq48ffazpKiIfY5FryoUOi4f0YwWw/8m0XK8/vPluH4wHRu1cb1I1WjHlFw6G9r6B0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=a8WPsd9C; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Bg8lTRxi; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id 6D770138024B;
	Tue, 16 Apr 2024 05:04:25 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 16 Apr 2024 05:04:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1713258265; x=
	1713344665; bh=GsqUmpQqoITRUAlXnLehmMF3/uSTge8CmrgzI81ADtE=; b=a
	8WPsd9Ct2TBdjU+tdE6YXYLpi4sfzWu+jzoJ7hO8brt8fm5LhqUu71b8jWnsqDUN
	Xqwkg+rB401fxJDVtVNG5Uujc6T5fSP881kavcZBZuio4I1htOe5orwjLIOGWQp9
	ODgnzkDlfGMWqnpN6Wkb2FNqmlmYLGrh9bEove/t6UEOYdXyhQShmKWOUoU4atpr
	7ZkB+Sx5wAPNRUc1bUCtt8IYldvFkWq2emUh/IkZ8CYO+2B7I6wdfsBWd/3Hw/5U
	Yzeutmletq9oAQyFPQ776AGLk3TlFwCRsQI8d8g216AWflcqNhrTJrMYwIHCCg0g
	dILROqXVczEvd+6YRvnsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1713258265; x=
	1713344665; bh=GsqUmpQqoITRUAlXnLehmMF3/uSTge8CmrgzI81ADtE=; b=B
	g8lTRxiooDCle04+5TRbpC70cUqvX9M1JK8/WrWxuodEU19RKZg9lnP5G+4hoMSk
	j+9g25gJVR9af37bnKVEofegQQHp+jtb75sO4MWP+LOMBfuowseoVUhebUXcSdJP
	565FtLIajBkMdCZFFfhWx+C+ax1KGq2PCqaF+uN5tAdYzvL3misMFFAmFKd9jSKl
	3pHqf2MiBuoyDJh8Bx0dzvTuGPmJAqu+9mwLnIYnzbIavcQqzBbh0hxB4b6aT2jw
	Kqt13WZ4OhA2BfYd0hHp4JESZz1GEsw5o9bJMdJuSb/lLRjaiOiS4zTTiCOef+3d
	NSrnA/AcOlYWz+cZgVyjQ==
X-ME-Sender: <xms:GT8eZglkh4kDKGH48iYd_SnWBAc3Z99aW-rI1brAOiRo5qP7LEenSA>
    <xme:GT8eZv3Jx4D9KY-xBT-hbY3VYyVmzyBfYtzE487ELO4FlwPj1ctk7P1QS3tno0nU2
    L_BZ-GLMRaLH-FFwJc>
X-ME-Received: <xmr:GT8eZuqmJud4zZBirtueLHswfOeH5v9KvJMzulKZRQ90vxP-bZ2AZWxDce4S>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudejgedguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehl
    jhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfetfedugfetudeuheetjefhue
    fggfelleetvdevtefhueeujeefvdegleevhefgnecuvehluhhsthgvrhfuihiivgepuden
    ucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:GT8eZsm5BjZJjJvoqa-FHFW0FC6-qrBVydhTUA9v7EUbJLYsoJNtJw>
    <xmx:GT8eZu10V9s6iBhSmpHUNjFVYV_BPUmxZtGaL33-19ujBoibdCL1-g>
    <xmx:GT8eZjtTrMhumwCWLV3QDWMGaKX4zroJ7Tt6i4RPaxr0OwcZ7xFfaw>
    <xmx:GT8eZqUDKJtPBJ8_he7U1vf_QvHGCyR6lsar6TrXkKh1Gs-rl36ukA>
    <xmx:GT8eZhSCNjEOqBkDHNTK0mrG6p5fk33RQ4rPxTuYPvEQUsyZkU-yLjEf>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Apr 2024 05:04:22 -0400 (EDT)
From: "Luke D. Jones" <luke@ljones.dev>
To: jikos@kernel.org
Cc: benjamin.tissoires@redhat.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH 3/4] HID: asus: add ROG Ally N-Key ID and keycodes
Date: Tue, 16 Apr 2024 21:04:01 +1200
Message-ID: <20240416090402.31057-4-luke@ljones.dev>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240416090402.31057-1-luke@ljones.dev>
References: <20240416090402.31057-1-luke@ljones.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A handful of buttons on the ROG Ally are not actually part of the xpad
device and are instead keyboard keys (a typical use of the MCU that asus
uses). We attach a group of F<num> key codes which aren't used much and
which the handheld community has already accepted as defaults here.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 drivers/hid/hid-asus.c | 8 +++++++-
 drivers/hid/hid-ids.h  | 1 +
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 18062f9804fb..61820f7a6b25 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -847,7 +847,10 @@ static int asus_input_mapping(struct hid_device *hdev,
 		case 0xb3: asus_map_key_clear(KEY_PROG3);	break; /* Fn+Left next aura */
 		case 0x6a: asus_map_key_clear(KEY_F13);		break; /* Screenpad toggle */
 		case 0x4b: asus_map_key_clear(KEY_F14);		break; /* Arrows/Pg-Up/Dn toggle */
-
+		case 0xa5: asus_map_key_clear(KEY_F15);		break; /* ROG Ally left back */
+		case 0xa6: asus_map_key_clear(KEY_F16);		break; /* ROG Ally QAM button */
+		case 0xa7: asus_map_key_clear(KEY_F17);		break; /* ROG Ally ROG long-press */
+		case 0xa8: asus_map_key_clear(KEY_F18);		break; /* ROG Ally ROG long-press-release */
 
 		default:
 			/* ASUS lazily declares 256 usages, ignore the rest,
@@ -1239,6 +1242,9 @@ static const struct hid_device_id asus_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
 	    USB_DEVICE_ID_ASUSTEK_ROG_NKEY_KEYBOARD3),
 	  QUIRK_USE_KBD_BACKLIGHT | QUIRK_ROG_NKEY_KEYBOARD },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
+	    USB_DEVICE_ID_ASUSTEK_ROG_NKEY_ALLY),
+	  QUIRK_USE_KBD_BACKLIGHT | QUIRK_ROG_NKEY_KEYBOARD },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
 	    USB_DEVICE_ID_ASUSTEK_ROG_CLAYMORE_II_KEYBOARD),
 	  QUIRK_ROG_CLAYMORE_II_KEYBOARD },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 8376fb5e2d0b..f1e508a7ef06 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -208,6 +208,7 @@
 #define USB_DEVICE_ID_ASUSTEK_ROG_NKEY_KEYBOARD	0x1866
 #define USB_DEVICE_ID_ASUSTEK_ROG_NKEY_KEYBOARD2	0x19b6
 #define USB_DEVICE_ID_ASUSTEK_ROG_NKEY_KEYBOARD3	0x1a30
+#define USB_DEVICE_ID_ASUSTEK_ROG_NKEY_ALLY		0x1abe
 #define USB_DEVICE_ID_ASUSTEK_ROG_CLAYMORE_II_KEYBOARD	0x196b
 #define USB_DEVICE_ID_ASUSTEK_FX503VD_KEYBOARD	0x1869
 
-- 
2.44.0


