Return-Path: <linux-kernel+bounces-86749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E559886CA2F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 14:24:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FE8D287286
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 13:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C7E7E572;
	Thu, 29 Feb 2024 13:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="U5ZsFTaU";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="U5ZsFTaU"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699A760EDC;
	Thu, 29 Feb 2024 13:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709213048; cv=none; b=nwa1KVhcQTZLX/aFWoHehdxTEkxoRO1WqxeJFcIilTVj8OqfwXkmZ8FkTX9ZN+9MlqcqKTsaGanJ9bj5wsAy3NZFCfuzTp4zEK/lXkdnSdpc2NlyGgkFfb6xdm0O1I0pH0XspzcTc8t/CSzMfJzPHt48G2PvcszLfnVD7TJmpcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709213048; c=relaxed/simple;
	bh=Q9+orAmFLG17dvDtjMr//cybKCoz7oGiZrMvtW87CE4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ATg1lyg4wjVd5d6OeZlMqwhBvBho7fr0OihCgmcGK0gni1iETJJv13TJ/fD0zE3YPO0yH6yCzhSqiOdkfwfiWNOkyXuzFi/Fbxos2idK77w0uMFs+Eu9OwxRTuPHXMf9Jn7M3eg9q2ItgAayQnTnhGvhwfrq7y2GimLycYqNCo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=U5ZsFTaU; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=U5ZsFTaU; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AF79B1F7F1;
	Thu, 29 Feb 2024 13:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1709213044; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=PNKmKlt9G8O0/nkgk81lSnxP1WfxcnRFC/vWBacHFgg=;
	b=U5ZsFTaUUkjQPM+V78Id7jp+hYyXg3iyOmLojLP82ChhJZxlmZyhhZfxjawUofyId/qWtK
	iGa/EWKILesOCT9de+6e9cgOHsm+OpbhQD9EDuMCSfMapaPL6Qo1U/A+PZbjCgMjkjRttu
	67iDwDxQV0PR2jIo4HpyY1jaP+dMl/8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1709213044; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=PNKmKlt9G8O0/nkgk81lSnxP1WfxcnRFC/vWBacHFgg=;
	b=U5ZsFTaUUkjQPM+V78Id7jp+hYyXg3iyOmLojLP82ChhJZxlmZyhhZfxjawUofyId/qWtK
	iGa/EWKILesOCT9de+6e9cgOHsm+OpbhQD9EDuMCSfMapaPL6Qo1U/A+PZbjCgMjkjRttu
	67iDwDxQV0PR2jIo4HpyY1jaP+dMl/8=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 5C25E13451;
	Thu, 29 Feb 2024 13:24:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id nul8E3SF4GWxKgAAn2gu4w
	(envelope-from <oneukum@suse.com>); Thu, 29 Feb 2024 13:24:04 +0000
From: Oliver Neukum <oneukum@suse.com>
To: gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mika.westerberg@linux.intel.com
Cc: Oliver Neukum <oneukum@suse.com>
Subject: [PATCH] thunderbolt: no opencoding FIELD_GET
Date: Thu, 29 Feb 2024 14:23:57 +0100
Message-ID: <20240229132401.3270-1-oneukum@suse.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [2.98 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.92)[94.55%]
X-Spam-Level: **
X-Spam-Score: 2.98
X-Spam-Flag: NO

We have a macro. It should be used.

Signed-off-by: Oliver Neukum <oneukum@suse.com>
---
 include/linux/usb/typec_tbt.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/linux/usb/typec_tbt.h b/include/linux/usb/typec_tbt.h
index c7a2153bd6f5..fa97d7e00f5c 100644
--- a/include/linux/usb/typec_tbt.h
+++ b/include/linux/usb/typec_tbt.h
@@ -3,6 +3,7 @@
 #define __USB_TYPEC_TBT_H
 
 #include <linux/usb/typec_altmode.h>
+#include <linux/bitfield.h>
 
 #define USB_TYPEC_VENDOR_INTEL		0x8087
 /* Alias for convenience */
@@ -25,7 +26,7 @@ struct typec_thunderbolt_data {
 
 /* TBT3 Device Discover Mode VDO bits */
 #define TBT_MODE			BIT(0)
-#define TBT_ADAPTER(_vdo_)		(((_vdo_) & BIT(16)) >> 16)
+#define TBT_ADAPTER(_vdo_)		FIELD_GET(BIT(16), _vdo_)
 #define   TBT_ADAPTER_LEGACY		0
 #define   TBT_ADAPTER_TBT3		1
 #define TBT_INTEL_SPECIFIC_B0		BIT(26)
@@ -35,12 +36,12 @@ struct typec_thunderbolt_data {
 #define TBT_SET_ADAPTER(a)		(((a) & 1) << 16)
 
 /* TBT3 Cable Discover Mode VDO bits */
-#define TBT_CABLE_SPEED(_vdo_)		(((_vdo_) & GENMASK(18, 16)) >> 16)
+#define TBT_CABLE_SPEED(_vdo_)		FIELD_GET(GENMASK(18, 16), _vdo_)
 #define   TBT_CABLE_USB3_GEN1		1
 #define   TBT_CABLE_USB3_PASSIVE	2
 #define   TBT_CABLE_10_AND_20GBPS	3
-#define TBT_CABLE_ROUNDED_SUPPORT(_vdo_) \
-					(((_vdo_) & GENMASK(20, 19)) >> 19)
+#define TBT_CABLE_ROUNDED_SUPPORT(_vdo_) FIELD_GET(GENMASK(20, 19), _vdo_)
+
 #define   TBT_GEN3_NON_ROUNDED                 0
 #define   TBT_GEN3_GEN4_ROUNDED_NON_ROUNDED    1
 #define TBT_CABLE_OPTICAL		BIT(21)
-- 
2.43.2


