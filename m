Return-Path: <linux-kernel+bounces-117659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 350FA88AE21
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:27:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D106F1F3EF8F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C0413BC0A;
	Mon, 25 Mar 2024 17:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W+HUSgdd"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B0A2579
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 17:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711389272; cv=none; b=hAGIV9SCMjfwEVjRu1MxCMiP5e9R/P5xXlhpsZ0GkKOcYJ2kdHWIUr8sTSCysDr9ROdc2ZgyKNoi/oXa/aLASAUOUnz3lhFg3qQq/tkH4ItvcOn0VrB9nArSl/dMi6PM9SPoMS/cXK/gE+g4YPoY6CmoEoud9ol9PtuNJjUQFmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711389272; c=relaxed/simple;
	bh=phl1On+LvXNW/Nrgaz1L3HLhaynxmPpRJ+BBZHYNgxg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Go/Zk2D4z5fU1lAoA7JWCv92b+y0fdbPCbOMyt31H8s1QrX43GrWiF1p2VgyYeDhLDf3kUgrnAeKkF3Mf6N+hpa4fi8GERcHgu51kdoOUrjAi4C9m+SJGBxApH+WrMe7LrLWO8T94FwS0WqnQeUpUfopmLExEwvFGWxpuhZ8djI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W+HUSgdd; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6e6afb754fcso4096834b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 10:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711389270; x=1711994070; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9TkK+lBWZC2qMtGl3T55LQPQa+j5LeFf4SEKJP2BMMU=;
        b=W+HUSgddaNGSVN619Mn47DTH/QmsZkUFDRLsReOSujMvqd4Gj4ZJrWFb3FXoZmuly1
         h0+4EcI3bELJyBE0KYZoEhQ9GhkLI3KfUQreaY+c70QONXi2bGBTc73SRubiv6qnwbZK
         uhcP4tWNvuyY0BmcHYcYizvw28ANZjW4sWpTCt7Lv8c8AKB4V06Al0fUlAMewfPflxrW
         +fNPWy1ywnuF5rYejj81blPDJJWvuucG2deSe6uR3T4uQmFonx8/xhaeVBbxEOIidl7U
         Pru43kBN0uInak96ipAvyaFAMwRvcbb7FtC/t/s8ZXUJ+fBWoLx08LxaEzXZW4UWSdbA
         gC1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711389270; x=1711994070;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9TkK+lBWZC2qMtGl3T55LQPQa+j5LeFf4SEKJP2BMMU=;
        b=LePy2A5x33t/DxlRkmAZ3a4BuYec077nrRY1edJVqwT0P+6arDklJyLeNeYfR98HAo
         3VwqSPwk9/vgKHxHPO0/b4KpRpew/4spYqovgwbNQMrvVG/tQQGdsG1jO32W5vYmG3rJ
         KiNwnPb/uL2CBddOxFfgbWSCve5j6Csazj1ehlCQiXMrciMxQlD1XJYfsZf8yWAgi3yQ
         TNMJkpZZpcKLO+ikhz3XyfcaRj7BfGEJbCReiW7kZzw81arysPYDmfwO+somV5h5P5Ph
         yFQ341I6m4JeiYZOcDAJY7ceEyHjp2JIurGAm++mlwzkZ5o64YF7vOB9SFZTPtQYEC3O
         eBQA==
X-Forwarded-Encrypted: i=1; AJvYcCX8roAvLyuCAeGojLFhcTwpFLFQ7Rb5dZhaWJ3Jo4mpjyBznmR5fgx17aqbOdfzkoua+tkab0ll0ZhU1Gwypx53Ve2hxHiQwBMGDG23
X-Gm-Message-State: AOJu0YxHCK2je36kmHhyj8xaivPJLlO3yYb3bg7KYlV8XedAT3wNuNLF
	vZZe/feMaaYn0KplxayNGhPJYvNS5Q0QjteNlHOzhJDlYnYFQ8j/K+WRf2B3aL4=
X-Google-Smtp-Source: AGHT+IFOYQ46Q+aH3AoS2orxN+nBAUNQs114gA8KXkmqBBX74wgY9DnhTi54l10sDWWUqFval1fAYg==
X-Received: by 2002:a05:6a20:f20:b0:1a3:4c97:23a2 with SMTP id fl32-20020a056a200f2000b001a34c9723a2mr7261292pzb.20.1711389269778;
        Mon, 25 Mar 2024 10:54:29 -0700 (PDT)
Received: from ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx ([103.6.158.65])
        by smtp.gmail.com with ESMTPSA id k20-20020a63f014000000b005d8b89bbf20sm5983671pgh.63.2024.03.25.10.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 10:54:29 -0700 (PDT)
Date: Mon, 25 Mar 2024 23:24:24 +0530
From: Ayush Tiwari <ayushtiw0110@gmail.com>
To: Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Cc: outreachy@lists.linux.dev
Subject: [PATCH] staging: rtl8712: Fix instances of lines ending with '('
Message-ID: <ZgG6UC1Fiac7pDfa@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Fix instances of lines ending with '(' to address checkpatch warning
"lines should not add with a '(' " and conform to common kernel coding
style.

Signed-off-by: Ayush Tiwari <ayushtiw0110@gmail.com>
---
 drivers/staging/rtl8712/rtl871x_ioctl_rtl.h | 123 +++++++-------------
 1 file changed, 41 insertions(+), 82 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl871x_ioctl_rtl.h b/drivers/staging/rtl8712/rtl871x_ioctl_rtl.h
index 7c0b880ac686..70d48e6b4112 100644
--- a/drivers/staging/rtl8712/rtl871x_ioctl_rtl.h
+++ b/drivers/staging/rtl8712/rtl871x_ioctl_rtl.h
@@ -18,92 +18,51 @@
 #include "drv_types.h"
 
 /*************** oid_rtl_seg_01_01 **************/
-uint oid_rt_get_signal_quality_hdl(
-			struct oid_par_priv *poid_par_priv);/*84*/
-uint oid_rt_get_small_packet_crc_hdl(
-			struct oid_par_priv *poid_par_priv);
-uint oid_rt_get_middle_packet_crc_hdl(
-			struct oid_par_priv *poid_par_priv);
-uint oid_rt_get_large_packet_crc_hdl(
-			struct oid_par_priv *poid_par_priv);
-uint oid_rt_get_tx_retry_hdl(
-			struct oid_par_priv *poid_par_priv);
-uint oid_rt_get_rx_retry_hdl(
-			struct oid_par_priv *poid_par_priv);
-uint oid_rt_get_rx_total_packet_hdl(
-			struct oid_par_priv *poid_par_priv);
-uint oid_rt_get_tx_beacon_ok_hdl(
-			struct oid_par_priv *poid_par_priv);
-uint oid_rt_get_tx_beacon_err_hdl(
-			struct oid_par_priv *poid_par_priv);
-uint oid_rt_get_rx_icv_err_hdl(
-			struct oid_par_priv *poid_par_priv);/*93*/
-uint oid_rt_set_encryption_algorithm_hdl(
-			struct oid_par_priv *poid_par_priv);
-uint oid_rt_get_preamble_mode_hdl(
-			struct oid_par_priv *poid_par_priv);
-uint oid_rt_get_ap_ip_hdl(
-			struct oid_par_priv *poid_par_priv);
-uint oid_rt_get_channelplan_hdl(
-			struct oid_par_priv *poid_par_priv);
-uint oid_rt_set_channelplan_hdl(
-			struct oid_par_priv *poid_par_priv);
-uint oid_rt_set_preamble_mode_hdl(
-			struct oid_par_priv *poid_par_priv);
-uint oid_rt_set_bcn_intvl_hdl(
-			struct oid_par_priv *poid_par_priv);
-uint oid_rt_dedicate_probe_hdl(
-			struct oid_par_priv *poid_par_priv);
-uint oid_rt_get_total_tx_bytes_hdl(
-			struct oid_par_priv *poid_par_priv);
-uint oid_rt_get_total_rx_bytes_hdl(
-			struct oid_par_priv *poid_par_priv);
-uint oid_rt_current_tx_power_level_hdl(
-			struct oid_par_priv *poid_par_priv);
-uint oid_rt_get_enc_key_mismatch_count_hdl(
-			struct oid_par_priv *poid_par_priv);
-uint oid_rt_get_enc_key_match_count_hdl(
-			struct oid_par_priv *poid_par_priv);
-uint oid_rt_get_channel_hdl(
-			struct oid_par_priv *poid_par_priv);
-uint oid_rt_get_hardware_radio_off_hdl(
-			struct oid_par_priv *poid_par_priv);
-uint oid_rt_get_key_mismatch_hdl(
-			struct oid_par_priv *poid_par_priv);
-uint oid_rt_supported_wireless_mode_hdl(
-			struct oid_par_priv *poid_par_priv);
-uint oid_rt_get_channel_list_hdl(
-			struct oid_par_priv *poid_par_priv);
-uint oid_rt_get_scan_in_progress_hdl(
-			struct oid_par_priv *poid_par_priv);
-uint oid_rt_forced_data_rate_hdl(
-			struct oid_par_priv *poid_par_priv);
-uint oid_rt_wireless_mode_for_scan_list_hdl(
-			struct oid_par_priv *poid_par_priv);
-uint oid_rt_get_bss_wireless_mode_hdl(
-			struct oid_par_priv *poid_par_priv);
-uint oid_rt_scan_with_magic_packet_hdl(
-			struct oid_par_priv *poid_par_priv);
+uint oid_rt_get_signal_quality_hdl(struct oid_par_priv *poid_par_priv); /*84*/
+uint oid_rt_get_small_packet_crc_hdl(struct oid_par_priv *poid_par_priv);
+uint oid_rt_get_middle_packet_crc_hdl(struct oid_par_priv *poid_par_priv);
+uint oid_rt_get_large_packet_crc_hdl(struct oid_par_priv *poid_par_priv);
+uint oid_rt_get_tx_retry_hdl(struct oid_par_priv *poid_par_priv);
+uint oid_rt_get_rx_retry_hdl(struct oid_par_priv *poid_par_priv);
+uint oid_rt_get_rx_total_packet_hdl(struct oid_par_priv *poid_par_priv);
+uint oid_rt_get_tx_beacon_ok_hdl(struct oid_par_priv *poid_par_priv);
+uint oid_rt_get_tx_beacon_err_hdl(struct oid_par_priv *poid_par_priv);
+uint oid_rt_get_rx_icv_err_hdl(struct oid_par_priv *poid_par_priv); /*93*/
+uint oid_rt_set_encryption_algorithm_hdl(struct oid_par_priv *poid_par_priv);
+uint oid_rt_get_preamble_mode_hdl(struct oid_par_priv *poid_par_priv);
+uint oid_rt_get_ap_ip_hdl(struct oid_par_priv *poid_par_priv);
+uint oid_rt_get_channelplan_hdl(struct oid_par_priv *poid_par_priv);
+uint oid_rt_set_channelplan_hdl(struct oid_par_priv *poid_par_priv);
+uint oid_rt_set_preamble_mode_hdl(struct oid_par_priv *poid_par_priv);
+uint oid_rt_set_bcn_intvl_hdl(struct oid_par_priv *poid_par_priv);
+uint oid_rt_dedicate_probe_hdl(struct oid_par_priv *poid_par_priv);
+uint oid_rt_get_total_tx_bytes_hdl(struct oid_par_priv *poid_par_priv);
+uint oid_rt_get_total_rx_bytes_hdl(struct oid_par_priv *poid_par_priv);
+uint oid_rt_current_tx_power_level_hdl(struct oid_par_priv *poid_par_priv);
+uint oid_rt_get_enc_key_mismatch_count_hdl(struct oid_par_priv *poid_par_priv);
+uint oid_rt_get_enc_key_match_count_hdl(struct oid_par_priv *poid_par_priv);
+uint oid_rt_get_channel_hdl(struct oid_par_priv *poid_par_priv);
+uint oid_rt_get_hardware_radio_off_hdl(struct oid_par_priv *poid_par_priv);
+uint oid_rt_get_key_mismatch_hdl(struct oid_par_priv *poid_par_priv);
+uint oid_rt_supported_wireless_mode_hdl(struct oid_par_priv *poid_par_priv);
+uint oid_rt_get_channel_list_hdl(struct oid_par_priv *poid_par_priv);
+uint oid_rt_get_scan_in_progress_hdl(struct oid_par_priv *poid_par_priv);
+uint oid_rt_forced_data_rate_hdl(struct oid_par_priv *poid_par_priv);
+uint oid_rt_wireless_mode_for_scan_list_hdl(struct oid_par_priv *poid_par_priv);
+uint oid_rt_get_bss_wireless_mode_hdl(struct oid_par_priv *poid_par_priv);
+uint oid_rt_scan_with_magic_packet_hdl(struct oid_par_priv *poid_par_priv);
 
 /**************  oid_rtl_seg_01_03 section start **************/
-uint oid_rt_ap_get_associated_station_list_hdl(
-			struct oid_par_priv *poid_par_priv);
-uint oid_rt_ap_switch_into_ap_mode_hdl(
-			struct oid_par_priv *poid_par_priv);
-uint oid_rt_ap_supported_hdl(
-			struct oid_par_priv *poid_par_priv);
-uint oid_rt_ap_set_passphrase_hdl(
-			struct oid_par_priv *poid_par_priv);
+uint oid_rt_ap_get_associated_station_list_hdl(struct oid_par_priv *poid_par_priv);
+uint oid_rt_ap_switch_into_ap_mode_hdl(struct oid_par_priv *poid_par_priv);
+uint oid_rt_ap_supported_hdl(struct oid_par_priv *poid_par_priv);
+uint oid_rt_ap_set_passphrase_hdl(struct oid_par_priv *poid_par_priv);
 /* oid_rtl_seg_01_11 */
-uint oid_rt_pro_rf_write_registry_hdl(
-			struct oid_par_priv *poid_par_priv);
-uint oid_rt_pro_rf_read_registry_hdl(
-			struct oid_par_priv *poid_par_priv);
+uint oid_rt_pro_rf_write_registry_hdl(struct oid_par_priv *poid_par_priv);
+uint oid_rt_pro_rf_read_registry_hdl(struct oid_par_priv *poid_par_priv);
 /***************  oid_rtl_seg_03_00 section start **************/
-uint oid_rt_get_connect_state_hdl(
-			struct oid_par_priv *poid_par_priv);
-uint oid_rt_set_default_key_id_hdl(
-			struct oid_par_priv *poid_par_priv);
+uint oid_rt_get_connect_state_hdl(struct oid_par_priv *poid_par_priv);
+uint oid_rt_set_default_key_id_hdl(struct oid_par_priv *poid_par_priv);
 
 #endif
 
-- 
2.40.1


