Return-Path: <linux-kernel+bounces-37833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B615F83B631
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 01:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CCB11F25D9F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 00:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64987468;
	Thu, 25 Jan 2024 00:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="xjWq5tfe"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2392F53
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 00:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706143505; cv=none; b=FynOHkYlOQVg87CXxukQeTJLkyOJgbSw5dUKln/V2YDB0gChADvBCvZdRalSa91FUxdwK2XVJl8WXBGR3MkRxrKVW5Sqd0XjET1qvdLdMZkRp0HSesBYKlIdlHi3GWYOrZO2YnNNSgzbt9/cgQBrMwZFwxGswqM+Y7/rMR9eNOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706143505; c=relaxed/simple;
	bh=2eGNH3j0YLOxCmtxUHhLi9cpLT1ISgov9fgQcmnnWZc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aKKz2saEbvpqT74hJjypF/wA3bm6MRTKLdA3TyU+OKJu1xRjWsvYBOWsud3M7BRRo4YOFvaDdBWZv8+G2FjPazfDDHTHsa4XKD9DMVJXJt7MtSfGuHyodwFSveQP95+J9eFxa2vNKmFH7TBcQihLIfQKuvhyOn0sN5bIn3z+OSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--abhishekpandit.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xjWq5tfe; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--abhishekpandit.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1d70716596fso22165945ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 16:45:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706143504; x=1706748304; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WnyE7vd5MB883kb2E9oxEXRhVE+r8xyTcTs/TTmQ4aQ=;
        b=xjWq5tfeyE2IaHdWL6/Z5X7zBUdsMvFOAmP1TmoHADO6MIg4eaIRCCwM2tXRV8f2P+
         WzdQKe15V/qFQxHCLrteOWkJNcJm5+F6SMtdf7kreXdy0ZRp7jGNoxRP0KHv1H40D4Zh
         e1XbIwTqyiCGFbE9Tt5y2HYSFeRMUP+nUGeJYkO3jMQwZjj3IO2tlLER4ke2NhzYlVoS
         1X475c2eC7pLO63GliUHf4gp/TefKeFsMHFTfiPHhrE9ikfFWHdacXxiCoKwTlJUr68R
         NWsYRdWem4WT06oTAKyrrQYqy8U7nfR05s4io4ibIBIPS73xhEIkV7knQD8cC/Xs8L6s
         Kn/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706143504; x=1706748304;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WnyE7vd5MB883kb2E9oxEXRhVE+r8xyTcTs/TTmQ4aQ=;
        b=uE2XueomyVF7CCQLq4RjTls5s9YM5bq1b0jAxtEV0OJEe9Is8ycyKbJPs40XQ8Y5Wn
         8efgtY0k/5qyqsUyM2Ruw2/m9BW3y7xO7PFiF5j9AwaOLHw3N5ZUS1ythpiuMahPr/1I
         iNz+J4Q0nUDaay4TtpeoR0yQ9hgpyPsPM6amTLWtxoekZrBfFKKX+jlS3T+L2uXZJ09i
         6Neo3aprdYnatskTY81BtOVHiBnFjrLvDOwlfwFQIUe43b75BM0bKE2eqfN4OyoA3dy7
         4AOi9PiHFAKK8UT8XnSsIG+WCImwg0ldUWSjqHdxmOnEDUFJy+Ih4EsYRSTF0Ld6O/jO
         djew==
X-Gm-Message-State: AOJu0Yybo7LylRm7VjVvVBliVfzCXZzeKNxV+CwKHQSANk82vMogqDM3
	2BYswHnTTMPjtc9Ar2wA9p6x48Cvn5YcLwDRcOtgxV0JQW2nRmfmG1bO3n3skDw1Ud+xEgzpNgh
	fIZJ9UeUsv0/SBJ9kDH9kgHG9QkUqwcXwsQ==
X-Google-Smtp-Source: AGHT+IFHwvG9PbgCAfstJwAj76TAyCbjuczX5Ux1LFlG3ZFn9X19IgI0L6hvvwhdkRBu/VqpT3HHJaZaeMxz7U7YyOBMvA==
X-Received: from abps.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:9b4])
 (user=abhishekpandit job=sendgmr) by 2002:a17:903:200b:b0:1d7:7cbc:f41b with
 SMTP id s11-20020a170903200b00b001d77cbcf41bmr997pla.12.1706143503574; Wed,
 24 Jan 2024 16:45:03 -0800 (PST)
Date: Wed, 24 Jan 2024 16:44:53 -0800
In-Reply-To: <20240125004456.575891-1-abhishekpandit@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240125004456.575891-1-abhishekpandit@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240124164443.v2.2.I3d909e3c9a200621e3034686f068a3307945fd87@changeid>
Subject: [PATCH v2 2/3] usb: typec: ucsi: Update connector cap and status
From: Abhishek Pandit-Subedi <abhishekpandit@google.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-usb@vger.kernel.org
Cc: jthies@google.com, pmalani@chromium.org, 
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Rajaram Regupathy <rajaram.regupathy@intel.com>, Saranya Gopal <saranya.gopal@intel.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>

Update the data structures for ucsi_connector_capability and
ucsi_connector_status to UCSIv3.

Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---
Connector status has several unaligned bitfields (16-bit) that result in
difficult to maintain macros. It may be better if we simply re-define
these structs as u8[] and add bit range macros to access and cast these
values.

i.e.
struct ucsi_connector_status {
  u8 raw_data[18];

..
\#define UCSI_CONSTAT_CONNECTOR_STATUS          FIELD(u16, 15, 0)
\#define UCSI_CONSTAT_BCD_PD_VER_OPER_MODE      FIELD(u16, 85, 70)
}

GET_UCSI_FIELD(con->status, UCSI_CONSTAT_CONNECTOR_STATUS);
SET_UCSI_FIELD(con->status, UCSI_CONSTAT_CONNECTOR_STATUS, 0);

I didn't find a clear example of an existing mechanism to do this. Would
love some pointers here if it already exists and some feedback from the
maintainer if this is a direction you want to go.


(no changes since v1)

 drivers/usb/typec/ucsi/ucsi.h | 50 ++++++++++++++++++++++++++++++++---
 1 file changed, 46 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
index bec920fa6b8a..94b373378f63 100644
--- a/drivers/usb/typec/ucsi/ucsi.h
+++ b/drivers/usb/typec/ucsi/ucsi.h
@@ -3,6 +3,7 @@
 #ifndef __DRIVER_USB_TYPEC_UCSI_H
 #define __DRIVER_USB_TYPEC_UCSI_H
 
+#include <asm-generic/unaligned.h>
 #include <linux/bitops.h>
 #include <linux/device.h>
 #include <linux/power_supply.h>
@@ -214,9 +215,29 @@ struct ucsi_connector_capability {
 #define UCSI_CONCAP_OPMODE_USB2			BIT(5)
 #define UCSI_CONCAP_OPMODE_USB3			BIT(6)
 #define UCSI_CONCAP_OPMODE_ALT_MODE		BIT(7)
-	u8 flags;
+	u32 flags;
 #define UCSI_CONCAP_FLAG_PROVIDER		BIT(0)
 #define UCSI_CONCAP_FLAG_CONSUMER		BIT(1)
+#define UCSI_CONCAP_FLAG_SWAP_TO_DFP		BIT(2)
+#define UCSI_CONCAP_FLAG_SWAP_TO_UFP		BIT(3)
+#define UCSI_CONCAP_FLAG_SWAP_TO_SRC		BIT(4)
+#define UCSI_CONCAP_FLAG_SWAP_TO_SINK		BIT(5)
+#define UCSI_CONCAP_FLAG_EX_OP_MODE(_f_) \
+	(((_f_) & GENMASK(13, 6)) >> 6)
+#define   UCSI_CONCAP_EX_OP_MODE_USB4_GEN2	BIT(0)
+#define   UCSI_CONCAP_EX_OP_MODE_EPR_SRC	BIT(1)
+#define   UCSI_CONCAP_EX_OP_MODE_EPR_SINK	BIT(2)
+#define   UCSI_CONCAP_EX_OP_MODE_USB4_GEN3	BIT(3)
+#define   UCSI_CONCAP_EX_OP_MODE_USB4_GEN4	BIT(4)
+#define UCSI_CONCAP_FLAG_MISC_CAPS(_f_) \
+	(((_f_) & GENMASK(17, 14)) >> 14)
+#define   UCSI_CONCAP_MISC_CAP_FW_UPDATE	BIT(0)
+#define   UCSI_CONCAP_MISC_CAP_SECURITY		BIT(1)
+#define UCSI_CONCAP_FLAG_REV_CURR_PROT_SUPPORT	BIT(18)
+#define UCSI_CONCAP_FLAG_PARTNER_PD_MAJOR_REV(_f_) \
+	(((_f_) & GENMASK(20, 19)) >> 19)
+#define UCSI_CONCAP_FLAG_PARTNER_PD_MAJOR_REV_AS_BCD(_f_) \
+	(UCSI_CONCAP_FLAG_PARTNER_PD_MAJOR_REV(_f_) << 8)
 } __packed;
 
 struct ucsi_altmode {
@@ -276,15 +297,36 @@ struct ucsi_connector_status {
 #define   UCSI_CONSTAT_PARTNER_TYPE_DEBUG	5
 #define   UCSI_CONSTAT_PARTNER_TYPE_AUDIO	6
 	u32 request_data_obj;
-	u8 pwr_status;
-#define UCSI_CONSTAT_BC_STATUS(_p_)		((_p_) & GENMASK(2, 0))
+
+	u8 pwr_status[3];
+#define UCSI_CONSTAT_BC_STATUS(_p_)		((_p_[0]) & GENMASK(1, 0))
 #define   UCSI_CONSTAT_BC_NOT_CHARGING		0
 #define   UCSI_CONSTAT_BC_NOMINAL_CHARGING	1
 #define   UCSI_CONSTAT_BC_SLOW_CHARGING		2
 #define   UCSI_CONSTAT_BC_TRICKLE_CHARGING	3
-#define UCSI_CONSTAT_PROVIDER_CAP_LIMIT(_p_)	(((_p_) & GENMASK(6, 3)) >> 3)
+#define UCSI_CONSTAT_PROVIDER_CAP_LIMIT(_p_)	(((_p_[0]) & GENMASK(5, 2)) >> 2)
 #define   UCSI_CONSTAT_CAP_PWR_LOWERED		0
 #define   UCSI_CONSTAT_CAP_PWR_BUDGET_LIMIT	1
+#define UCSI_CONSTAT_PROVIDER_PD_VERSION_OPER_MODE(_p_)	\
+	((get_unaligned_le32(_p_) & GENMASK(21, 6)) >> 6)
+#define UCSI_CONSTAT_ORIENTATION(_p_)		(((_p_[2]) & GENMASK(6, 6)) >> 6)
+#define   UCSI_CONSTAT_ORIENTATION_DIRECT	0
+#define   UCSI_CONSTAT_ORIENTATION_FLIPPED	1
+#define UCSI_CONSTAT_SINK_PATH_STATUS(_p_)	(((_p_[2]) & GENMASK(7, 7)) >> 7)
+#define   UCSI_CONSTAT_SINK_PATH_DISABLED	0
+#define   UCSI_CONSTAT_SINK_PATH_ENABLED	1
+	u8 pwr_readings[9];
+#define UCSI_CONSTAT_REV_CURR_PROT_STATUS(_p_)	((_p_[0]) & 0x1)
+#define UCSI_CONSTAT_PWR_READING_VALID(_p_)	(((_p_[0]) & GENMASK(1, 1)) >> 1)
+#define UCSI_CONSTAT_CURRENT_SCALE(_p_)		(((_p_[0]) & GENMASK(4, 2)) >> 2)
+#define UCSI_CONSTAT_PEAK_CURRENT(_p_) \
+	((get_unaligned_le32(_p_) & GENMASK(20, 5)) >> 5)
+#define UCSI_CONSTAT_AVG_CURRENT(_p_) \
+	((get_unaligned_le32(&(_p_)[2]) & GENMASK(20, 5)) >> 5)
+#define UCSI_CONSTAT_VOLTAGE_SCALE(_p_) \
+	((get_unaligned_le16(&(_p_)[4]) & GENMASK(8, 5)) >> 5)
+#define UCSI_CONSTAT_VOLTAGE_READING(_p_) \
+	((get_unaligned_le32(&(_p_)[5]) & GENMASK(16, 1)) >> 1)
 } __packed;
 
 /* -------------------------------------------------------------------------- */
-- 
2.43.0.429.g432eaa2c6b-goog


