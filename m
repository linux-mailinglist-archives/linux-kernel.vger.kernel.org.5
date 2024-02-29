Return-Path: <linux-kernel+bounces-86741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA10C86CA0D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 14:19:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F3BD1F22F02
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 13:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D817E11B;
	Thu, 29 Feb 2024 13:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="DA307nsL";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="DA307nsL"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF631DFE3;
	Thu, 29 Feb 2024 13:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709212745; cv=none; b=tkBsGH9vW59zesz5KPZGqMxdLKlJK+yDl5hjeoudD3y+uvsXzFtm/sTbtD5stVrI/lBN655C4WPjjjPOBjzEYYRIFH+xya/TwhX3dnKLht2OBU0fixjcAk1PoIgkqy8W+26qghzRacKxqNeBYbVz2knemWN+5TXLKG65ss84Srs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709212745; c=relaxed/simple;
	bh=ftMktD3pCFTnpyLcc5TiO5qk07HSjVHQ7MHGcD+s7Wo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J7p6kIDKBhaO7pK9zWPZW1Jo+96Ke7Ahg7SkQ6gQeg3NxPx67VBJ1al+HQ/JWC6Qh1BGvseNGA1L7v5p2LwIjhC2ORTiDoM43/X580zzB3KG7O+U72aLf10AnH7z5G1ANJOQiJVu6zs1YWqgwNzAzdt+rA8xHiKaYAYvmJBD2v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=DA307nsL; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=DA307nsL; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9D97022807;
	Thu, 29 Feb 2024 13:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1709212735; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yG40N0lNsl+2yNQD0AbqRVz2p0LrcwZf0KyDHikEEKQ=;
	b=DA307nsLaKcv8JPrfNrzJwUEZow2NGMu77YnPa52gGGqrdufFPl4UzAGvU/0CmtVMa3obp
	rUn3r/louQB4MW/no92Nny7/onMziABPQ1Jdff550ycpTLqlGu+YN4zgEM+9GLRZ9g4qBV
	VUvpLwzvmfJ1rKch8MnE/sDX8A8wE70=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1709212735; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yG40N0lNsl+2yNQD0AbqRVz2p0LrcwZf0KyDHikEEKQ=;
	b=DA307nsLaKcv8JPrfNrzJwUEZow2NGMu77YnPa52gGGqrdufFPl4UzAGvU/0CmtVMa3obp
	rUn3r/louQB4MW/no92Nny7/onMziABPQ1Jdff550ycpTLqlGu+YN4zgEM+9GLRZ9g4qBV
	VUvpLwzvmfJ1rKch8MnE/sDX8A8wE70=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 5067013A42;
	Thu, 29 Feb 2024 13:18:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id ULAvET+E4GWPKQAAn2gu4w
	(envelope-from <oneukum@suse.com>); Thu, 29 Feb 2024 13:18:55 +0000
From: Oliver Neukum <oneukum@suse.com>
To: gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Oliver Neukum <oneukum@suse.com>
Subject: [PATCH] usb: typec: pd: no opencoding of FIELD_GET
Date: Thu, 29 Feb 2024 14:17:33 +0100
Message-ID: <20240229131851.16148-2-oneukum@suse.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240229131851.16148-1-oneukum@suse.com>
References: <20240229131851.16148-1-oneukum@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=DA307nsL
X-Spamd-Result: default: False [2.69 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 2.69
X-Rspamd-Queue-Id: 9D97022807
X-Spam-Level: **
X-Spam-Flag: NO
X-Spamd-Bar: ++

If we have a neat macro, at least new code should
use it.

Signed-off-by: Oliver Neukum <oneukum@suse.com>
---
 include/linux/usb/pd_vdo.h   |  5 +++--
 include/linux/usb/typec_dp.h | 11 ++++++-----
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/include/linux/usb/pd_vdo.h b/include/linux/usb/pd_vdo.h
index c09c5a12e273..5c48e8a81403 100644
--- a/include/linux/usb/pd_vdo.h
+++ b/include/linux/usb/pd_vdo.h
@@ -7,6 +7,7 @@
 #define __LINUX_USB_PD_VDO_H
 
 #include "pd.h"
+#include <linux/bitfield.h>
 
 /*
  * VDO : Vendor Defined Message Object
@@ -188,7 +189,7 @@
  * <5:3>   :: Alternate modes
  * <2:0>   :: USB highest speed
  */
-#define PD_VDO_UFP_DEVCAP(vdo)	(((vdo) & GENMASK(27, 24)) >> 24)
+#define PD_VDO_UFP_DEVCAP(vdo)	FIELD_GET(GENMASK(27, 24), vdo)
 
 /* UFP VDO Version */
 #define UFP_VDO_VER1_2		2
@@ -247,7 +248,7 @@
  * <21:5>  :: Reserved
  * <4:0>   :: Port number
  */
-#define PD_VDO_DFP_HOSTCAP(vdo)	(((vdo) & GENMASK(26, 24)) >> 24)
+#define PD_VDO_DFP_HOSTCAP(vdo)	FIELD_GET(GENMASK(26, 24), vdo)
 
 #define DFP_VDO_VER1_1		1
 #define HOST_USB2_CAPABLE	BIT(0)
diff --git a/include/linux/usb/typec_dp.h b/include/linux/usb/typec_dp.h
index 1f358098522d..f2da264d9c14 100644
--- a/include/linux/usb/typec_dp.h
+++ b/include/linux/usb/typec_dp.h
@@ -3,6 +3,7 @@
 #define __USB_TYPEC_DP_H
 
 #include <linux/usb/typec_altmode.h>
+#include <linux/bitfield.h>
 
 #define USB_TYPEC_DP_SID	0xff01
 /* USB IF has not assigned a Standard ID (SID) for VirtualLink,
@@ -67,21 +68,21 @@ enum {
 #define   DP_CAP_UFP_D			1
 #define   DP_CAP_DFP_D			2
 #define   DP_CAP_DFP_D_AND_UFP_D	3
-#define DP_CAP_DP_SIGNALLING(_cap_)	(((_cap_) & GENMASK(5, 2)) >> 2)
+#define DP_CAP_DP_SIGNALLING(_cap_)	FIELD_GET(GENMASK(5, 2), _cap_)
 #define   DP_CAP_SIGNALLING_HBR3	1
 #define   DP_CAP_SIGNALLING_UHBR10	2
 #define   DP_CAP_SIGNALLING_UHBR20	3
 #define DP_CAP_RECEPTACLE		BIT(6)
 #define DP_CAP_USB			BIT(7)
-#define DP_CAP_DFP_D_PIN_ASSIGN(_cap_)	(((_cap_) & GENMASK(15, 8)) >> 8)
-#define DP_CAP_UFP_D_PIN_ASSIGN(_cap_)	(((_cap_) & GENMASK(23, 16)) >> 16)
+#define DP_CAP_DFP_D_PIN_ASSIGN(_cap_)	FIELD_GET(GENMASK(15, 8), _cap_)
+#define DP_CAP_UFP_D_PIN_ASSIGN(_cap_)	FIELD_GET(GENMASK(23, 16), _cap_)
 /* Get pin assignment taking plug & receptacle into consideration */
 #define DP_CAP_PIN_ASSIGN_UFP_D(_cap_) ((_cap_ & DP_CAP_RECEPTACLE) ? \
 			DP_CAP_UFP_D_PIN_ASSIGN(_cap_) : DP_CAP_DFP_D_PIN_ASSIGN(_cap_))
 #define DP_CAP_PIN_ASSIGN_DFP_D(_cap_) ((_cap_ & DP_CAP_RECEPTACLE) ? \
 			DP_CAP_DFP_D_PIN_ASSIGN(_cap_) : DP_CAP_UFP_D_PIN_ASSIGN(_cap_))
 #define DP_CAP_UHBR_13_5_SUPPORT	BIT(26)
-#define DP_CAP_CABLE_TYPE(_cap_)	(((_cap_) & GENMASK(29, 28)) >> 28)
+#define DP_CAP_CABLE_TYPE(_cap_)	FIELD_GET(GENMASK(29, 28), _cap_)
 #define   DP_CAP_CABLE_TYPE_PASSIVE	0
 #define   DP_CAP_CABLE_TYPE_RE_TIMER	1
 #define   DP_CAP_CABLE_TYPE_RE_DRIVER	2
@@ -116,7 +117,7 @@ enum {
 
 /* Helper for setting/getting the pin assignment value to the configuration */
 #define DP_CONF_SET_PIN_ASSIGN(_a_)	((_a_) << 8)
-#define DP_CONF_GET_PIN_ASSIGN(_conf_)	(((_conf_) & GENMASK(15, 8)) >> 8)
+#define DP_CONF_GET_PIN_ASSIGN(_conf_)	FIELD_GET(GENMASK(15, 8), _conf_)
 #define DP_CONF_UHBR13_5_SUPPORT	BIT(26)
 #define DP_CONF_CABLE_TYPE_MASK		GENMASK(29, 28)
 #define DP_CONF_CABLE_TYPE_SHIFT	28
-- 
2.43.2


