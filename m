Return-Path: <linux-kernel+bounces-51755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D90E848EF4
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 16:36:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 283761C21205
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 15:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0012260C;
	Sun,  4 Feb 2024 15:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ToE5dGez"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48257225CD
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 15:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707061000; cv=none; b=S6m7TILc3OtnqJJm5MKBNh6eftUdSYl1iE/fGhSKLwfisFctfymWF9XQk1UTIG/7HUVOjnuEq5+qnpMoiVvdOy6Mubf9vvswmAX7PwScKPURn+XIi31UOGNhccBWQLNzpFgkQDwS+hbF1rV0XTCD0030DgCfq21bZ2oO3Nzd2zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707061000; c=relaxed/simple;
	bh=jlHr85lx7ijYMM8DzNwyv4cHSz4lBYQQJ33L5PJPNg4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oQlb8LZ2pE4OP5OZcqzuJot2sEi4AarlwKmx6ibFNFAEu+KFUO2rNp1ul0AbDQ++rrOpGnOuJDT9Bo4WJhoSsbG3XCuw4PkefrgCZcpStzeKR1QClrbcZ/CPYLLNF2Cq7/zGFz/HCXf9cy5W84kEdbJPkvXJBEGxwMewAKi2vfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ToE5dGez; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a26f73732c5so537907966b.3
        for <linux-kernel@vger.kernel.org>; Sun, 04 Feb 2024 07:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707060996; x=1707665796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pC/gomlpxxczil2N1iiBnIyiwHQVcSqITV0Ca4lVoU0=;
        b=ToE5dGeza8kMXhNjLOowUGjcCcCKJ3DXZnTEi+0ua265nJKbQ8sXsyQVveK35/dG1n
         N5LhbkcoI7Z3iVyQgDhPBxAVcz7PgV7qkwWppkass0iaX2l6rbc/wTYSNnTjfOU4TPpb
         bQKHhN/4SBaZ86B7WOd7rFjClm77B/hCAmiT/bnN78pfoR+nbqDketmxOwXIHqym+TGM
         u0yroMcsuVaBzkC3/dKLDTduDyxkDSenx0xxdcx2xcX70wGuoG3MJe/HaoM7mgS2Jv4E
         Po/re6qv4SxmrnwRc3hRlWOs/XFkTNZkqIgwvxlkzUxHxymR92P9+MtYd6PtAJBQ11Ck
         pSyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707060996; x=1707665796;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pC/gomlpxxczil2N1iiBnIyiwHQVcSqITV0Ca4lVoU0=;
        b=htsrXu2MfnNrWqX+9A9Un+GDEEdM26ujoBCWyhYUyFpkYgfzrwuUrXA3jq1OnhOERo
         XlCzmuP3iGC67ASssaNpwQ+2gBJqWSOMSNEq6SmG14uMLErDFBq1Y7ga6/bGXFONGyU2
         hz4FmPh/fPDEL/5gF+mcRZA2lCuQJI8eDG4CHgRYcmE4cnWJ5zKmy7u5fuGhGHcNKbyo
         d//iedW5a6v5cabdq0d5Q/rp3RNxoevWBeujiM3xGemajuomBk48Ti0UcZT0fbGImfnP
         wY7kKvjy4tW66s2tplJ/MjYn0UMohzDdPZL34jgANqtlvztIceGwSrlalNyFc2ctXUqi
         yVmw==
X-Gm-Message-State: AOJu0Yz/q5MYc85ReqsP8NKB/4EnJ8sCnpAUClXOhO7ez5Iptl7+bVPM
	Vr47aUaD+UtH4UbmV+BwbX8rXnFO8uL0A9VX1Hcympw2LGETi0q2
X-Google-Smtp-Source: AGHT+IFdBuVyXqFvF/TXMXY6Uw4DNtlBY8k0apmNTvQ5iD/YbDjGfBFUuVySCt5h15zhCK8CfoqQDw==
X-Received: by 2002:a17:906:408b:b0:a36:3edb:aeac with SMTP id u11-20020a170906408b00b00a363edbaeacmr7598355ejj.17.1707060996186;
        Sun, 04 Feb 2024 07:36:36 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWr5SEVMZ24V/xXf0kQ+LPdFpKIqt2nR7Xx5TqExVovQ3mTwa8JyjoF5+I7diHpLb9YYznErXapxXriI/xQUu7RiGQo+kCV2T20efSSSEG+nBW/7fT8hJm7tu5G0+SK9icLbgQh9ZYNi6RSYafVprV8PL7jqWwHZQftOFDZWMd0SSt2StIqFUMP+ikB68aLJUTyTqVaU6v/
Received: from loveone ([151.82.70.227])
        by smtp.gmail.com with ESMTPSA id kq8-20020a170906abc800b00a30cd599285sm3239159ejb.223.2024.02.04.07.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 07:36:35 -0800 (PST)
From: Ettore Forgiarini <ettorenigma@gmail.com>
To: gregkh@linuxfoundation.org
Cc: richardcochran@gmail.com,
	ozlinux@hotmail.com,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Ettore Forgiarini <ettorenigma@gmail.com>
Subject: [PATCH 2/2] Staging: octeon: octeon-stubs: remove all typedef
Date: Sun,  4 Feb 2024 16:36:03 +0100
Message-ID: <20240204153603.1373700-1-ettorenigma@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Removed all typedef so the code conform with code style

Signed-off-by: Ettore Forgiarini <ettorenigma@gmail.com>
---
 drivers/staging/octeon/octeon-stubs.h | 48 +++++++++++++--------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/staging/octeon/octeon-stubs.h b/drivers/staging/octeon/octeon-stubs.h
index de333d6718d2..7c769f2d42fb 100644
--- a/drivers/staging/octeon/octeon-stubs.h
+++ b/drivers/staging/octeon/octeon-stubs.h
@@ -213,14 +213,14 @@ enum cvmx_fau_op_size {
 	CVMX_FAU_OP_SIZE_64 = 3
 };
 
-typedef enum {
+enum cvmx_spi_mode_t {
 	CVMX_SPI_MODE_UNKNOWN = 0,
 	CVMX_SPI_MODE_TX_HALFPLEX = 1,
 	CVMX_SPI_MODE_RX_HALFPLEX = 2,
 	CVMX_SPI_MODE_DUPLEX = 3
-} cvmx_spi_mode_t;
+};
 
-typedef enum {
+enum cvmx_helper_interface_mode_t {
 	CVMX_HELPER_INTERFACE_MODE_DISABLED,
 	CVMX_HELPER_INTERFACE_MODE_RGMII,
 	CVMX_HELPER_INTERFACE_MODE_GMII,
@@ -231,20 +231,20 @@ typedef enum {
 	CVMX_HELPER_INTERFACE_MODE_PICMG,
 	CVMX_HELPER_INTERFACE_MODE_NPI,
 	CVMX_HELPER_INTERFACE_MODE_LOOP,
-} cvmx_helper_interface_mode_t;
+};
 
-typedef enum {
+enum cvmx_pow_wait_t {
 	CVMX_POW_WAIT = 1,
 	CVMX_POW_NO_WAIT = 0,
-} cvmx_pow_wait_t;
+};
 
-typedef enum {
+enum cvmx_pko_lock_t {
 	CVMX_PKO_LOCK_NONE = 0,
 	CVMX_PKO_LOCK_ATOMIC_TAG = 1,
 	CVMX_PKO_LOCK_CMD_QUEUE = 2,
-} cvmx_pko_lock_t;
+};
 
-typedef enum {
+enum cvmx_pko_status_t {
 	CVMX_PKO_SUCCESS,
 	CVMX_PKO_INVALID_PORT,
 	CVMX_PKO_INVALID_QUEUE,
@@ -252,7 +252,7 @@ typedef enum {
 	CVMX_PKO_NO_MEMORY,
 	CVMX_PKO_PORT_ALREADY_SETUP,
 	CVMX_PKO_CMD_QUEUE_INIT_ERROR
-} cvmx_pko_status_t;
+};
 
 enum cvmx_pow_tag_type {
 	CVMX_POW_TAG_TYPE_ORDERED   = 0L,
@@ -384,7 +384,7 @@ union cvmx_ipd_sub_port_qos_cnt {
 	} s;
 };
 
-typedef struct {
+struct cvmx_pip_port_status_t {
 	u32 dropped_octets;
 	u32 dropped_packets;
 	u32 pci_raw_packets;
@@ -407,13 +407,13 @@ typedef struct {
 	u32 inb_packets;
 	u64 inb_octets;
 	u16 inb_errors;
-} cvmx_pip_port_status_t;
+};
 
-typedef struct {
+struct cvmx_pko_port_status_t {
 	u32 packets;
 	u64 octets;
 	u64 doorbell;
-} cvmx_pko_port_status_t;
+};
 
 union cvmx_pip_frm_len_chkx {
 	u64 u64;
@@ -1258,14 +1258,14 @@ static inline int octeon_is_simulation(void)
 }
 
 static inline void cvmx_pip_get_port_status(u64 port_num, u64 clear,
-					    cvmx_pip_port_status_t *status)
+					    struct cvmx_pip_port_status_t *status)
 { }
 
 static inline void cvmx_pko_get_port_status(u64 port_num, u64 clear,
-					    cvmx_pko_port_status_t *status)
+					    struct cvmx_pko_port_status_t *status)
 { }
 
-static inline cvmx_helper_interface_mode_t cvmx_helper_interface_get_mode(int
+static inline enum cvmx_helper_interface_mode_t cvmx_helper_interface_get_mode(int
 								   interface)
 {
 	return 0;
@@ -1342,11 +1342,11 @@ static inline unsigned int cvmx_get_core_num(void)
 }
 
 static inline void cvmx_pow_work_request_async_nocheck(int scr_addr,
-						       cvmx_pow_wait_t wait)
+						       enum cvmx_pow_wait_t wait)
 { }
 
 static inline void cvmx_pow_work_request_async(int scr_addr,
-					       cvmx_pow_wait_t wait)
+					       enum cvmx_pow_wait_t wait)
 { }
 
 static inline struct cvmx_wqe *cvmx_pow_work_response_async(int scr_addr)
@@ -1356,13 +1356,13 @@ static inline struct cvmx_wqe *cvmx_pow_work_response_async(int scr_addr)
 	return wqe;
 }
 
-static inline struct cvmx_wqe *cvmx_pow_work_request_sync(cvmx_pow_wait_t wait)
+static inline struct cvmx_wqe *cvmx_pow_work_request_sync(enum cvmx_pow_wait_t wait)
 {
 	return (void *)(unsigned long)wait;
 }
 
 static inline int cvmx_spi_restart_interface(int interface,
-					     cvmx_spi_mode_t mode, int timeout)
+					     enum cvmx_spi_mode_t mode, int timeout)
 {
 	return 0;
 }
@@ -1381,12 +1381,12 @@ static inline union cvmx_gmxx_rxx_rx_inbnd cvmx_spi4000_check_speed(int interfac
 }
 
 static inline void cvmx_pko_send_packet_prepare(u64 port, u64 queue,
-						cvmx_pko_lock_t use_locking)
+						enum cvmx_pko_lock_t use_locking)
 { }
 
-static inline cvmx_pko_status_t cvmx_pko_send_packet_finish(u64 port,
+static inline enum cvmx_pko_status_t cvmx_pko_send_packet_finish(u64 port,
 		u64 queue, union cvmx_pko_command_word0 pko_command,
-		union cvmx_buf_ptr packet, cvmx_pko_lock_t use_locking)
+		union cvmx_buf_ptr packet, enum cvmx_pko_lock_t use_locking)
 {
 	return 0;
 }
-- 
2.43.0


