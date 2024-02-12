Return-Path: <linux-kernel+bounces-61638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF698514CF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:21:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98724B23BC9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 014814594F;
	Mon, 12 Feb 2024 13:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GKpcq2Eg"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2601E41A85
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 13:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707743667; cv=none; b=fTQ4oVs/KuW4HB8dck5357icHg0YhGyb9zJct/xEUKDz62yujvL6vju5nEWIbgTZnoqobzEVDLi2duCanmQACiwGo57bCag+HM1qDfBvQ4TNyVdWEDjvqra5IsQ0yE7J4bKhRJ30Bu+Md2symOmeI68n0Z6XcleT3Bam7mHNfFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707743667; c=relaxed/simple;
	bh=EduHQTMkW7M9PuCv7DD8a87vLU/tqTiTdiEeV+xNUlQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=endy3QSiGbQjk4+hEdF+Ci0IJC9AwdNLZDtqYAT8V5OV97ZuwyAlX+IVJUgt6MJcCVzqoQfgDOHAV+Q/9AHuT/+jriQZwxy6R1FPmuXGQgAIhrQkAXxq846r82RgIROaQw1XoPqwyADEAeMlWTyEl5JkPfLOH1ocrEdTUgmYMmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--panikiel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GKpcq2Eg; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--panikiel.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-40fb505c97aso19809445e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 05:14:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707743663; x=1708348463; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C857fcvjN2Q61CMGefzqTDLbKskpX9Jvk37xAZm0WZQ=;
        b=GKpcq2EgIwaLGMey1DaJ8Lju3zH/tPZ/MWdR39oo5oS00nvHzSNityNdG7ic42oxOA
         BhUPKreq8Yws8iciCOxUJN3Ok/52gQk3fuVhmRFpFyFw2y0hsmnp7qtWelA8FEQhPLo9
         wyFJmN4IcPi8+Lyh2MwJ2hegGPoO0zJjp7rJ6qWneoGTF/4Vym5/VqGoAgYAr6NRQbxi
         9jpRz5rCDxryOvWh3wN9VuGrsm2UHTBeMjbvcumRqJNz3ApDT30L4ux5m5lAeyYpFmHW
         6CJURSVZnsL2k6t7XsvIRkbHo/SqxM6k1nR2ENJBwN/I1/ha0h65ys8x1vfNYklsKufz
         b0eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707743663; x=1708348463;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=C857fcvjN2Q61CMGefzqTDLbKskpX9Jvk37xAZm0WZQ=;
        b=XNjPW+MD2nOabm0iQK2+k5mXXWYfZm4FlHk5oqDkxD5M7PR1EnO89iRRyUx/Wars+D
         780SJkjt1dlOd6FcTRWrp6iW0Z/Qs3Av6VNdQzvXPgzkLqvZDRNDWZFOIvm1oHKaxNtr
         ERHwqc8VZfE9avxc/2O6IVZmn38DGEz6Z0hgWSWo+WyR+4JAzGc4i9LO1+fUnxsa+R68
         3yOp/mgAhQXCaDOK3z8VtLokrpD8DbWM2etJr0MlBhavYt7C/YhJaEHEFx8FVcXLJuJ4
         AjVUX4B9EyntGPOWEhZy3gPUXnaO9TahSFJAFFmCy2zL/+rZi7yNX01Ytqe42UGazKfQ
         dXFw==
X-Forwarded-Encrypted: i=1; AJvYcCUwbBUzjH7v9bgwY5njrxrp3PSKbY0VXtDJBclSerK+dLIHRetBRS2K29KKcfCl2LBm5N8x5yI96oLqlmOAEhndnHj3aw9+83Jz+qHM
X-Gm-Message-State: AOJu0YzR0vsIcmJz8x6QN5v1SFlfdXabbF+a94KOVO2FpEAfOT3jxgnG
	D+fJw7kRm3o3xIw33DhnjGJVjNuIm8UdDgGr+Ha4+QLwgBosNMl3eyo3KZp+tVphDWZaAmq9sQK
	0UHm+4NhC+w==
X-Google-Smtp-Source: AGHT+IG5xi/ZS1yrFRFK1RW2aagwmX6KzFfQ5/5hjVdtE12WQdvMnvFrXJog3nKIuyfDcEXqGAW89Ra+zqrGCw==
X-Received: from szatan.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2d83])
 (user=panikiel job=sendgmr) by 2002:a5d:5a1a:0:b0:33b:1da0:a7cb with SMTP id
 bq26-20020a5d5a1a000000b0033b1da0a7cbmr36157wrb.4.1707743663594; Mon, 12 Feb
 2024 05:14:23 -0800 (PST)
Date: Mon, 12 Feb 2024 13:13:17 +0000
In-Reply-To: <20240212131323.2162161-1-panikiel@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240212131323.2162161-1-panikiel@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240212131323.2162161-4-panikiel@google.com>
Subject: [PATCH 3/9] drm/dp_mst: Move DRM-independent structures to separate header
From: "=?UTF-8?q?Pawe=C5=82=20Anikiel?=" <panikiel@google.com>
To: airlied@gmail.com, akpm@linux-foundation.org, conor+dt@kernel.org, 
	daniel@ffwll.ch, dinguyen@kernel.org, hverkuil-cisco@xs4all.nl, 
	krzysztof.kozlowski+dt@linaro.org, maarten.lankhorst@linux.intel.com, 
	mchehab@kernel.org, mripard@kernel.org, robh+dt@kernel.org, 
	tzimmermann@suse.de
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	chromeos-krk-upstreaming@google.com, ribalda@chromium.org, 
	"=?UTF-8?q?Pawe=C5=82=20Anikiel?=" <panikiel@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Move structures describing MST sideband messages into a separate header
so that non-DRM code can use them.

Signed-off-by: Pawe=C5=82 Anikiel <panikiel@google.com>
---
 include/drm/display/drm_dp_mst.h        | 238 ++++++++++++++++++++++++
 include/drm/display/drm_dp_mst_helper.h | 232 +----------------------
 2 files changed, 239 insertions(+), 231 deletions(-)
 create mode 100644 include/drm/display/drm_dp_mst.h

diff --git a/include/drm/display/drm_dp_mst.h b/include/drm/display/drm_dp_=
mst.h
new file mode 100644
index 000000000000..4e398bfd3ee3
--- /dev/null
+++ b/include/drm/display/drm_dp_mst.h
@@ -0,0 +1,238 @@
+/* SPDX-License-Identifier: MIT */
+
+#ifndef _DRM_DP_MST_H_
+#define _DRM_DP_MST_H_
+
+#include <linux/types.h>
+
+struct drm_dp_nak_reply {
+	u8 guid[16];
+	u8 reason;
+	u8 nak_data;
+};
+
+struct drm_dp_link_address_ack_reply {
+	u8 guid[16];
+	u8 nports;
+	struct drm_dp_link_addr_reply_port {
+		bool input_port;
+		u8 peer_device_type;
+		u8 port_number;
+		bool mcs;
+		bool ddps;
+		bool legacy_device_plug_status;
+		u8 dpcd_revision;
+		u8 peer_guid[16];
+		u8 num_sdp_streams;
+		u8 num_sdp_stream_sinks;
+	} ports[16];
+};
+
+struct drm_dp_remote_dpcd_read_ack_reply {
+	u8 port_number;
+	u8 num_bytes;
+	u8 bytes[255];
+};
+
+struct drm_dp_remote_dpcd_write_ack_reply {
+	u8 port_number;
+};
+
+struct drm_dp_remote_dpcd_write_nak_reply {
+	u8 port_number;
+	u8 reason;
+	u8 bytes_written_before_failure;
+};
+
+struct drm_dp_remote_i2c_read_ack_reply {
+	u8 port_number;
+	u8 num_bytes;
+	u8 bytes[255];
+};
+
+struct drm_dp_remote_i2c_read_nak_reply {
+	u8 port_number;
+	u8 nak_reason;
+	u8 i2c_nak_transaction;
+};
+
+struct drm_dp_remote_i2c_write_ack_reply {
+	u8 port_number;
+};
+
+struct drm_dp_query_stream_enc_status_ack_reply {
+	/* Bit[23:16]- Stream Id */
+	u8 stream_id;
+
+	/* Bit[15]- Signed */
+	bool reply_signed;
+
+	/* Bit[10:8]- Stream Output Sink Type */
+	bool unauthorizable_device_present;
+	bool legacy_device_present;
+	bool query_capable_device_present;
+
+	/* Bit[12:11]- Stream Output CP Type */
+	bool hdcp_1x_device_present;
+	bool hdcp_2x_device_present;
+
+	/* Bit[4]- Stream Authentication */
+	bool auth_completed;
+
+	/* Bit[3]- Stream Encryption */
+	bool encryption_enabled;
+
+	/* Bit[2]- Stream Repeater Function Present */
+	bool repeater_present;
+
+	/* Bit[1:0]- Stream State */
+	u8 state;
+};
+
+#define DRM_DP_MAX_SDP_STREAMS 16
+struct drm_dp_allocate_payload {
+	u8 port_number;
+	u8 number_sdp_streams;
+	u8 vcpi;
+	u16 pbn;
+	u8 sdp_stream_sink[DRM_DP_MAX_SDP_STREAMS];
+};
+
+struct drm_dp_allocate_payload_ack_reply {
+	u8 port_number;
+	u8 vcpi;
+	u16 allocated_pbn;
+};
+
+struct drm_dp_connection_status_notify {
+	u8 guid[16];
+	u8 port_number;
+	bool legacy_device_plug_status;
+	bool displayport_device_plug_status;
+	bool message_capability_status;
+	bool input_port;
+	u8 peer_device_type;
+};
+
+struct drm_dp_remote_dpcd_read {
+	u8 port_number;
+	u32 dpcd_address;
+	u8 num_bytes;
+};
+
+struct drm_dp_remote_dpcd_write {
+	u8 port_number;
+	u32 dpcd_address;
+	u8 num_bytes;
+	u8 *bytes;
+};
+
+#define DP_REMOTE_I2C_READ_MAX_TRANSACTIONS 4
+struct drm_dp_remote_i2c_read {
+	u8 num_transactions;
+	u8 port_number;
+	struct drm_dp_remote_i2c_read_tx {
+		u8 i2c_dev_id;
+		u8 num_bytes;
+		u8 *bytes;
+		u8 no_stop_bit;
+		u8 i2c_transaction_delay;
+	} transactions[DP_REMOTE_I2C_READ_MAX_TRANSACTIONS];
+	u8 read_i2c_device_id;
+	u8 num_bytes_read;
+};
+
+struct drm_dp_remote_i2c_write {
+	u8 port_number;
+	u8 write_i2c_device_id;
+	u8 num_bytes;
+	u8 *bytes;
+};
+
+struct drm_dp_query_stream_enc_status {
+	u8 stream_id;
+	u8 client_id[7];	/* 56-bit nonce */
+	u8 stream_event;
+	bool valid_stream_event;
+	u8 stream_behavior;
+	u8 valid_stream_behavior;
+};
+
+/* this covers ENUM_RESOURCES, POWER_DOWN_PHY, POWER_UP_PHY */
+struct drm_dp_port_number_req {
+	u8 port_number;
+};
+
+struct drm_dp_enum_path_resources_ack_reply {
+	u8 port_number;
+	bool fec_capable;
+	u16 full_payload_bw_number;
+	u16 avail_payload_bw_number;
+};
+
+/* covers POWER_DOWN_PHY, POWER_UP_PHY */
+struct drm_dp_port_number_rep {
+	u8 port_number;
+};
+
+struct drm_dp_query_payload {
+	u8 port_number;
+	u8 vcpi;
+};
+
+struct drm_dp_resource_status_notify {
+	u8 port_number;
+	u8 guid[16];
+	u16 available_pbn;
+};
+
+struct drm_dp_query_payload_ack_reply {
+	u8 port_number;
+	u16 allocated_pbn;
+};
+
+struct drm_dp_sideband_msg_req_body {
+	u8 req_type;
+	union ack_req {
+		struct drm_dp_connection_status_notify conn_stat;
+		struct drm_dp_port_number_req port_num;
+		struct drm_dp_resource_status_notify resource_stat;
+
+		struct drm_dp_query_payload query_payload;
+		struct drm_dp_allocate_payload allocate_payload;
+
+		struct drm_dp_remote_dpcd_read dpcd_read;
+		struct drm_dp_remote_dpcd_write dpcd_write;
+
+		struct drm_dp_remote_i2c_read i2c_read;
+		struct drm_dp_remote_i2c_write i2c_write;
+
+		struct drm_dp_query_stream_enc_status enc_status;
+	} u;
+};
+
+struct drm_dp_sideband_msg_reply_body {
+	u8 reply_type;
+	u8 req_type;
+	union ack_replies {
+		struct drm_dp_nak_reply nak;
+		struct drm_dp_link_address_ack_reply link_addr;
+		struct drm_dp_port_number_rep port_number;
+
+		struct drm_dp_enum_path_resources_ack_reply path_resources;
+		struct drm_dp_allocate_payload_ack_reply allocate_payload;
+		struct drm_dp_query_payload_ack_reply query_payload;
+
+		struct drm_dp_remote_dpcd_read_ack_reply remote_dpcd_read_ack;
+		struct drm_dp_remote_dpcd_write_ack_reply remote_dpcd_write_ack;
+		struct drm_dp_remote_dpcd_write_nak_reply remote_dpcd_write_nack;
+
+		struct drm_dp_remote_i2c_read_ack_reply remote_i2c_read_ack;
+		struct drm_dp_remote_i2c_read_nak_reply remote_i2c_read_nack;
+		struct drm_dp_remote_i2c_write_ack_reply remote_i2c_write_ack;
+
+		struct drm_dp_query_stream_enc_status_ack_reply enc_status;
+	} u;
+};
+
+#endif
diff --git a/include/drm/display/drm_dp_mst_helper.h b/include/drm/display/=
drm_dp_mst_helper.h
index 9b19d8bd520a..61add6f6accd 100644
--- a/include/drm/display/drm_dp_mst_helper.h
+++ b/include/drm/display/drm_dp_mst_helper.h
@@ -23,6 +23,7 @@
 #define _DRM_DP_MST_HELPER_H_
=20
 #include <linux/types.h>
+#include <drm/display/drm_dp_mst.h>
 #include <drm/display/drm_dp_helper.h>
 #include <drm/drm_atomic.h>
 #include <drm/drm_fixed.h>
@@ -248,237 +249,6 @@ struct drm_dp_mst_branch {
 	u8 guid[16];
 };
=20
-
-struct drm_dp_nak_reply {
-	u8 guid[16];
-	u8 reason;
-	u8 nak_data;
-};
-
-struct drm_dp_link_address_ack_reply {
-	u8 guid[16];
-	u8 nports;
-	struct drm_dp_link_addr_reply_port {
-		bool input_port;
-		u8 peer_device_type;
-		u8 port_number;
-		bool mcs;
-		bool ddps;
-		bool legacy_device_plug_status;
-		u8 dpcd_revision;
-		u8 peer_guid[16];
-		u8 num_sdp_streams;
-		u8 num_sdp_stream_sinks;
-	} ports[16];
-};
-
-struct drm_dp_remote_dpcd_read_ack_reply {
-	u8 port_number;
-	u8 num_bytes;
-	u8 bytes[255];
-};
-
-struct drm_dp_remote_dpcd_write_ack_reply {
-	u8 port_number;
-};
-
-struct drm_dp_remote_dpcd_write_nak_reply {
-	u8 port_number;
-	u8 reason;
-	u8 bytes_written_before_failure;
-};
-
-struct drm_dp_remote_i2c_read_ack_reply {
-	u8 port_number;
-	u8 num_bytes;
-	u8 bytes[255];
-};
-
-struct drm_dp_remote_i2c_read_nak_reply {
-	u8 port_number;
-	u8 nak_reason;
-	u8 i2c_nak_transaction;
-};
-
-struct drm_dp_remote_i2c_write_ack_reply {
-	u8 port_number;
-};
-
-struct drm_dp_query_stream_enc_status_ack_reply {
-	/* Bit[23:16]- Stream Id */
-	u8 stream_id;
-
-	/* Bit[15]- Signed */
-	bool reply_signed;
-
-	/* Bit[10:8]- Stream Output Sink Type */
-	bool unauthorizable_device_present;
-	bool legacy_device_present;
-	bool query_capable_device_present;
-
-	/* Bit[12:11]- Stream Output CP Type */
-	bool hdcp_1x_device_present;
-	bool hdcp_2x_device_present;
-
-	/* Bit[4]- Stream Authentication */
-	bool auth_completed;
-
-	/* Bit[3]- Stream Encryption */
-	bool encryption_enabled;
-
-	/* Bit[2]- Stream Repeater Function Present */
-	bool repeater_present;
-
-	/* Bit[1:0]- Stream State */
-	u8 state;
-};
-
-#define DRM_DP_MAX_SDP_STREAMS 16
-struct drm_dp_allocate_payload {
-	u8 port_number;
-	u8 number_sdp_streams;
-	u8 vcpi;
-	u16 pbn;
-	u8 sdp_stream_sink[DRM_DP_MAX_SDP_STREAMS];
-};
-
-struct drm_dp_allocate_payload_ack_reply {
-	u8 port_number;
-	u8 vcpi;
-	u16 allocated_pbn;
-};
-
-struct drm_dp_connection_status_notify {
-	u8 guid[16];
-	u8 port_number;
-	bool legacy_device_plug_status;
-	bool displayport_device_plug_status;
-	bool message_capability_status;
-	bool input_port;
-	u8 peer_device_type;
-};
-
-struct drm_dp_remote_dpcd_read {
-	u8 port_number;
-	u32 dpcd_address;
-	u8 num_bytes;
-};
-
-struct drm_dp_remote_dpcd_write {
-	u8 port_number;
-	u32 dpcd_address;
-	u8 num_bytes;
-	u8 *bytes;
-};
-
-#define DP_REMOTE_I2C_READ_MAX_TRANSACTIONS 4
-struct drm_dp_remote_i2c_read {
-	u8 num_transactions;
-	u8 port_number;
-	struct drm_dp_remote_i2c_read_tx {
-		u8 i2c_dev_id;
-		u8 num_bytes;
-		u8 *bytes;
-		u8 no_stop_bit;
-		u8 i2c_transaction_delay;
-	} transactions[DP_REMOTE_I2C_READ_MAX_TRANSACTIONS];
-	u8 read_i2c_device_id;
-	u8 num_bytes_read;
-};
-
-struct drm_dp_remote_i2c_write {
-	u8 port_number;
-	u8 write_i2c_device_id;
-	u8 num_bytes;
-	u8 *bytes;
-};
-
-struct drm_dp_query_stream_enc_status {
-	u8 stream_id;
-	u8 client_id[7];	/* 56-bit nonce */
-	u8 stream_event;
-	bool valid_stream_event;
-	u8 stream_behavior;
-	u8 valid_stream_behavior;
-};
-
-/* this covers ENUM_RESOURCES, POWER_DOWN_PHY, POWER_UP_PHY */
-struct drm_dp_port_number_req {
-	u8 port_number;
-};
-
-struct drm_dp_enum_path_resources_ack_reply {
-	u8 port_number;
-	bool fec_capable;
-	u16 full_payload_bw_number;
-	u16 avail_payload_bw_number;
-};
-
-/* covers POWER_DOWN_PHY, POWER_UP_PHY */
-struct drm_dp_port_number_rep {
-	u8 port_number;
-};
-
-struct drm_dp_query_payload {
-	u8 port_number;
-	u8 vcpi;
-};
-
-struct drm_dp_resource_status_notify {
-	u8 port_number;
-	u8 guid[16];
-	u16 available_pbn;
-};
-
-struct drm_dp_query_payload_ack_reply {
-	u8 port_number;
-	u16 allocated_pbn;
-};
-
-struct drm_dp_sideband_msg_req_body {
-	u8 req_type;
-	union ack_req {
-		struct drm_dp_connection_status_notify conn_stat;
-		struct drm_dp_port_number_req port_num;
-		struct drm_dp_resource_status_notify resource_stat;
-
-		struct drm_dp_query_payload query_payload;
-		struct drm_dp_allocate_payload allocate_payload;
-
-		struct drm_dp_remote_dpcd_read dpcd_read;
-		struct drm_dp_remote_dpcd_write dpcd_write;
-
-		struct drm_dp_remote_i2c_read i2c_read;
-		struct drm_dp_remote_i2c_write i2c_write;
-
-		struct drm_dp_query_stream_enc_status enc_status;
-	} u;
-};
-
-struct drm_dp_sideband_msg_reply_body {
-	u8 reply_type;
-	u8 req_type;
-	union ack_replies {
-		struct drm_dp_nak_reply nak;
-		struct drm_dp_link_address_ack_reply link_addr;
-		struct drm_dp_port_number_rep port_number;
-
-		struct drm_dp_enum_path_resources_ack_reply path_resources;
-		struct drm_dp_allocate_payload_ack_reply allocate_payload;
-		struct drm_dp_query_payload_ack_reply query_payload;
-
-		struct drm_dp_remote_dpcd_read_ack_reply remote_dpcd_read_ack;
-		struct drm_dp_remote_dpcd_write_ack_reply remote_dpcd_write_ack;
-		struct drm_dp_remote_dpcd_write_nak_reply remote_dpcd_write_nack;
-
-		struct drm_dp_remote_i2c_read_ack_reply remote_i2c_read_ack;
-		struct drm_dp_remote_i2c_read_nak_reply remote_i2c_read_nack;
-		struct drm_dp_remote_i2c_write_ack_reply remote_i2c_write_ack;
-
-		struct drm_dp_query_stream_enc_status_ack_reply enc_status;
-	} u;
-};
-
 /* msg is queued to be put into a slot */
 #define DRM_DP_SIDEBAND_TX_QUEUED 0
 /* msg has started transmitting on a slot - still on msgq */
--=20
2.43.0.687.g38aa6559b0-goog


