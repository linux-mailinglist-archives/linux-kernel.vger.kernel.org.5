Return-Path: <linux-kernel+bounces-51169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D510B848748
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 16:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29EABB25E11
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 15:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9C45F559;
	Sat,  3 Feb 2024 15:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IiSxBKWJ"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD5B5FEF3
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 15:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706975869; cv=none; b=lUy8WVaywV4rX8wYUfTbWmwUAlbkNsB8i8EwMtiFdV7TCiUTE/CBAi/LUlhCnlj4GPJY8Q9A4uTf6XcHWMHvDsQd4P/rU/PPN3aWD9tox/bXFkrcc7wc8g4SPHa2eCB5ZqAVOSv29EFBV+4wnBNA0ViJInvDzljqMcLB+w3FEVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706975869; c=relaxed/simple;
	bh=EMLMaQafnS3CAe1nMISgnqibmIzrnjMGlXitF4nbEHA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I0rYh3z0yPy3b/f9FQLQECzgM0MF3Kx6ccan2cKvRxLtrh2U/7pKFhKeAmmOhhPfdTBVFdX61BMKeOP6WkihuU5ikhTLephMt+5/yHmBbokKM+/zIYTsRyEg5MvK5vHHO+Wo01P9WCZbtnconB8IAHNTKioTOmHU2HWByPNgv40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IiSxBKWJ; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40e80046246so9719685e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 03 Feb 2024 07:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706975864; x=1707580664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hZCT6OjYsMaULLI1fgh6iScJYEzlNMPCM/rL6OtvtM8=;
        b=IiSxBKWJ31f2ogbd1VnSvAwbgCmOHzN4mYGGKnH4wjMtdiXwTsBD7TrNJtrYMVZEeC
         J40b6ego57pBosx3R3aO2gqu56HObviicDVKjSfxOoZNUiNo8orOvR8K/Sq9GPTKnSyz
         m8m7PYx7Y6bc3/bOKRgUwJkD0X8wbYdV+NX1x0El6EVOL4KqTfEJjdBDtuq+9HkIBWqD
         VWxe4hYEflyOL9PJXVcHiw65CIZbSWQkj95mmb3wDosA/Z5m9S50i5YYICy1a2bkYoRo
         SeHks9BlcjnelWz+USMRDlTTBISGwn21T0PuX63+ikg6sm/m6m1fQRt10xwfB6iSx+6a
         uRvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706975864; x=1707580664;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hZCT6OjYsMaULLI1fgh6iScJYEzlNMPCM/rL6OtvtM8=;
        b=I6MKuUGdhluAJrucn13IUccESW7/4DKmRiOvfIfN2omsyNrOk2NMtfF1OazWKKIZIo
         Ft+qmYdR2YzY27+cQbKjtPF+dS9aA5Ctr689ZxRTLY/OmYuEJNDMOa9OzLVau+5Yf0lS
         dYmxyikwBYydceaeff5Dj3fQtIJbL18rESo1F1D1IiaifR90G1gY8U/u4iFTrsyVfY7r
         YXs1bghpQk12ok66dRUF9CzR2gLKQtTDaNkYb5q1lUb7PWgnzNGJ7G0pmhzqv4xigQDV
         20j6Jp4QGFDOmBxWirQJy5SCdmyLPLQxBiv7xCQtALvdTlwB5R6k1bnQXzmlceZuD7JQ
         RDtw==
X-Gm-Message-State: AOJu0Yx7hVw+1uWgEh2ZtmSDjhnknBWskcV+wlk2ZVmv1lvsyT/8IcFu
	xcEsCgrv/aLIeI4q+ScT4+PgblYs7LGlt7fZBhPk4tj9gvzzrJtf
X-Google-Smtp-Source: AGHT+IH5HsG4VISceq3egzbmfsc2W21mX/VOhtPutNIBnDUUojXD/b5FtubWSofHVkOoLzbpnyvTrw==
X-Received: by 2002:a05:600c:19cb:b0:40e:cca6:d82f with SMTP id u11-20020a05600c19cb00b0040ecca6d82fmr1087717wmq.16.1706975863986;
        Sat, 03 Feb 2024 07:57:43 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVI+yCXzsNgmA4PJuPsfeB7g1OjK0E6jCLbsIrdxSycOQ8vbWCXSIwTiKrLNH1iWcbkDIlhzNvprdhZHJHLsviWJt+xMDvE44yhXZ+pOnqKyayyAc+/OTHk33mn6JjJT+VbS0uSvRVdx55ipzsrTsNAyt1YYrrEq8/aMuORVQQtKWw+nqweWkr5d5scbFMAzM2hKjiyU4o+
Received: from loveone ([151.82.19.83])
        by smtp.gmail.com with ESMTPSA id n8-20020a05600c500800b0040fd1629443sm1791196wmr.18.2024.02.03.07.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Feb 2024 07:57:43 -0800 (PST)
From: Ettore Forgiarini <ettorenigma@gmail.com>
To: gregkh@linuxfoundation.org
Cc: richardcochran@gmail.com,
	ozlinux@hotmail.com,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Ettore Forgiarini <ettorenigma@gmail.com>
Subject: [PATCH] Staging: octeon: octeon-stubs: fixed a type coding style issue
Date: Sat,  3 Feb 2024 16:57:02 +0100
Message-ID: <20240203155702.835279-1-ettorenigma@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change all the uint*_t to the preferred u* types

Signed-off-by: Ettore Forgiarini <ettorenigma@gmail.com>
---
 drivers/staging/octeon/octeon-stubs.h | 1746 ++++++++++++-------------
 1 file changed, 873 insertions(+), 873 deletions(-)

diff --git a/drivers/staging/octeon/octeon-stubs.h b/drivers/staging/octeon/octeon-stubs.h
index 3e7b92cd2e35..de333d6718d2 100644
--- a/drivers/staging/octeon/octeon-stubs.h
+++ b/drivers/staging/octeon/octeon-stubs.h
@@ -43,144 +43,144 @@
 #define CVMX_POW_WQ_INT_PC		0

 union cvmx_pip_wqe_word2 {
-	uint64_t u64;
+	u64 u64;
 	struct {
-		uint64_t bufs:8;
-		uint64_t ip_offset:8;
-		uint64_t vlan_valid:1;
-		uint64_t vlan_stacked:1;
-		uint64_t unassigned:1;
-		uint64_t vlan_cfi:1;
-		uint64_t vlan_id:12;
-		uint64_t pr:4;
-		uint64_t unassigned2:8;
-		uint64_t dec_ipcomp:1;
-		uint64_t tcp_or_udp:1;
-		uint64_t dec_ipsec:1;
-		uint64_t is_v6:1;
-		uint64_t software:1;
-		uint64_t L4_error:1;
-		uint64_t is_frag:1;
-		uint64_t IP_exc:1;
-		uint64_t is_bcast:1;
-		uint64_t is_mcast:1;
-		uint64_t not_IP:1;
-		uint64_t rcv_error:1;
-		uint64_t err_code:8;
+		u64 bufs:8;
+		u64 ip_offset:8;
+		u64 vlan_valid:1;
+		u64 vlan_stacked:1;
+		u64 unassigned:1;
+		u64 vlan_cfi:1;
+		u64 vlan_id:12;
+		u64 pr:4;
+		u64 unassigned2:8;
+		u64 dec_ipcomp:1;
+		u64 tcp_or_udp:1;
+		u64 dec_ipsec:1;
+		u64 is_v6:1;
+		u64 software:1;
+		u64 L4_error:1;
+		u64 is_frag:1;
+		u64 IP_exc:1;
+		u64 is_bcast:1;
+		u64 is_mcast:1;
+		u64 not_IP:1;
+		u64 rcv_error:1;
+		u64 err_code:8;
 	} s;
 	struct {
-		uint64_t bufs:8;
-		uint64_t ip_offset:8;
-		uint64_t vlan_valid:1;
-		uint64_t vlan_stacked:1;
-		uint64_t unassigned:1;
-		uint64_t vlan_cfi:1;
-		uint64_t vlan_id:12;
-		uint64_t port:12;
-		uint64_t dec_ipcomp:1;
-		uint64_t tcp_or_udp:1;
-		uint64_t dec_ipsec:1;
-		uint64_t is_v6:1;
-		uint64_t software:1;
-		uint64_t L4_error:1;
-		uint64_t is_frag:1;
-		uint64_t IP_exc:1;
-		uint64_t is_bcast:1;
-		uint64_t is_mcast:1;
-		uint64_t not_IP:1;
-		uint64_t rcv_error:1;
-		uint64_t err_code:8;
+		u64 bufs:8;
+		u64 ip_offset:8;
+		u64 vlan_valid:1;
+		u64 vlan_stacked:1;
+		u64 unassigned:1;
+		u64 vlan_cfi:1;
+		u64 vlan_id:12;
+		u64 port:12;
+		u64 dec_ipcomp:1;
+		u64 tcp_or_udp:1;
+		u64 dec_ipsec:1;
+		u64 is_v6:1;
+		u64 software:1;
+		u64 L4_error:1;
+		u64 is_frag:1;
+		u64 IP_exc:1;
+		u64 is_bcast:1;
+		u64 is_mcast:1;
+		u64 not_IP:1;
+		u64 rcv_error:1;
+		u64 err_code:8;
 	} s_cn68xx;

 	struct {
-		uint64_t unused1:16;
-		uint64_t vlan:16;
-		uint64_t unused2:32;
+		u64 unused1:16;
+		u64 vlan:16;
+		u64 unused2:32;
 	} svlan;
 	struct {
-		uint64_t bufs:8;
-		uint64_t unused:8;
-		uint64_t vlan_valid:1;
-		uint64_t vlan_stacked:1;
-		uint64_t unassigned:1;
-		uint64_t vlan_cfi:1;
-		uint64_t vlan_id:12;
-		uint64_t pr:4;
-		uint64_t unassigned2:12;
-		uint64_t software:1;
-		uint64_t unassigned3:1;
-		uint64_t is_rarp:1;
-		uint64_t is_arp:1;
-		uint64_t is_bcast:1;
-		uint64_t is_mcast:1;
-		uint64_t not_IP:1;
-		uint64_t rcv_error:1;
-		uint64_t err_code:8;
+		u64 bufs:8;
+		u64 unused:8;
+		u64 vlan_valid:1;
+		u64 vlan_stacked:1;
+		u64 unassigned:1;
+		u64 vlan_cfi:1;
+		u64 vlan_id:12;
+		u64 pr:4;
+		u64 unassigned2:12;
+		u64 software:1;
+		u64 unassigned3:1;
+		u64 is_rarp:1;
+		u64 is_arp:1;
+		u64 is_bcast:1;
+		u64 is_mcast:1;
+		u64 not_IP:1;
+		u64 rcv_error:1;
+		u64 err_code:8;
 	} snoip;

 };

 union cvmx_pip_wqe_word0 {
 	struct {
-		uint64_t next_ptr:40;
-		uint8_t unused;
+		u64 next_ptr:40;
+		u8 unused;
 		__wsum hw_chksum;
 	} cn38xx;
 	struct {
-		uint64_t pknd:6;        /* 0..5 */
-		uint64_t unused2:2;     /* 6..7 */
-		uint64_t bpid:6;        /* 8..13 */
-		uint64_t unused1:18;    /* 14..31 */
-		uint64_t l2ptr:8;       /* 32..39 */
-		uint64_t l3ptr:8;       /* 40..47 */
-		uint64_t unused0:8;     /* 48..55 */
-		uint64_t l4ptr:8;       /* 56..63 */
+		u64 pknd:6;        /* 0..5 */
+		u64 unused2:2;     /* 6..7 */
+		u64 bpid:6;        /* 8..13 */
+		u64 unused1:18;    /* 14..31 */
+		u64 l2ptr:8;       /* 32..39 */
+		u64 l3ptr:8;       /* 40..47 */
+		u64 unused0:8;     /* 48..55 */
+		u64 l4ptr:8;       /* 56..63 */
 	} cn68xx;
 };

 union cvmx_wqe_word0 {
-	uint64_t u64;
+	u64 u64;
 	union cvmx_pip_wqe_word0 pip;
 };

 union cvmx_wqe_word1 {
-	uint64_t u64;
+	u64 u64;
 	struct {
-		uint64_t tag:32;
-		uint64_t tag_type:2;
-		uint64_t varies:14;
-		uint64_t len:16;
+		u64 tag:32;
+		u64 tag_type:2;
+		u64 varies:14;
+		u64 len:16;
 	};
 	struct {
-		uint64_t tag:32;
-		uint64_t tag_type:2;
-		uint64_t zero_2:3;
-		uint64_t grp:6;
-		uint64_t zero_1:1;
-		uint64_t qos:3;
-		uint64_t zero_0:1;
-		uint64_t len:16;
+		u64 tag:32;
+		u64 tag_type:2;
+		u64 zero_2:3;
+		u64 grp:6;
+		u64 zero_1:1;
+		u64 qos:3;
+		u64 zero_0:1;
+		u64 len:16;
 	} cn68xx;
 	struct {
-		uint64_t tag:32;
-		uint64_t tag_type:2;
-		uint64_t zero_2:1;
-		uint64_t grp:4;
-		uint64_t qos:3;
-		uint64_t ipprt:6;
-		uint64_t len:16;
+		u64 tag:32;
+		u64 tag_type:2;
+		u64 zero_2:1;
+		u64 grp:4;
+		u64 qos:3;
+		u64 ipprt:6;
+		u64 len:16;
 	} cn38xx;
 };

 union cvmx_buf_ptr {
 	void *ptr;
-	uint64_t u64;
+	u64 u64;
 	struct {
-		uint64_t i:1;
-		uint64_t back:4;
-		uint64_t pool:3;
-		uint64_t size:16;
-		uint64_t addr:40;
+		u64 i:1;
+		u64 back:4;
+		u64 pool:3;
+		u64 size:16;
+		u64 addr:40;
 	} s;
 };

@@ -189,16 +189,16 @@ struct cvmx_wqe {
 	union cvmx_wqe_word1 word1;
 	union cvmx_pip_wqe_word2 word2;
 	union cvmx_buf_ptr packet_ptr;
-	uint8_t packet_data[96];
+	u8 packet_data[96];
 };

 union cvmx_helper_link_info {
-	uint64_t u64;
+	u64 u64;
 	struct {
-		uint64_t reserved_20_63:44;
-		uint64_t link_up:1;	    /**< Is the physical link up? */
-		uint64_t full_duplex:1;	    /**< 1 if the link is full duplex */
-		uint64_t speed:18;	    /**< Speed of the link in Mbps */
+		u64 reserved_20_63:44;
+		u64 link_up:1;	    /**< Is the physical link up? */
+		u64 full_duplex:1;	    /**< 1 if the link is full duplex */
+		u64 speed:18;	    /**< Speed of the link in Mbps */
 	} s;
 };

@@ -262,921 +262,921 @@ enum cvmx_pow_tag_type {
 };

 union cvmx_ipd_ctl_status {
-	uint64_t u64;
+	u64 u64;
 	struct cvmx_ipd_ctl_status_s {
-		uint64_t reserved_18_63:46;
-		uint64_t use_sop:1;
-		uint64_t rst_done:1;
-		uint64_t clken:1;
-		uint64_t no_wptr:1;
-		uint64_t pq_apkt:1;
-		uint64_t pq_nabuf:1;
-		uint64_t ipd_full:1;
-		uint64_t pkt_off:1;
-		uint64_t len_m8:1;
-		uint64_t reset:1;
-		uint64_t addpkt:1;
-		uint64_t naddbuf:1;
-		uint64_t pkt_lend:1;
-		uint64_t wqe_lend:1;
-		uint64_t pbp_en:1;
-		uint64_t opc_mode:2;
-		uint64_t ipd_en:1;
+		u64 reserved_18_63:46;
+		u64 use_sop:1;
+		u64 rst_done:1;
+		u64 clken:1;
+		u64 no_wptr:1;
+		u64 pq_apkt:1;
+		u64 pq_nabuf:1;
+		u64 ipd_full:1;
+		u64 pkt_off:1;
+		u64 len_m8:1;
+		u64 reset:1;
+		u64 addpkt:1;
+		u64 naddbuf:1;
+		u64 pkt_lend:1;
+		u64 wqe_lend:1;
+		u64 pbp_en:1;
+		u64 opc_mode:2;
+		u64 ipd_en:1;
 	} s;
 	struct cvmx_ipd_ctl_status_cn30xx {
-		uint64_t reserved_10_63:54;
-		uint64_t len_m8:1;
-		uint64_t reset:1;
-		uint64_t addpkt:1;
-		uint64_t naddbuf:1;
-		uint64_t pkt_lend:1;
-		uint64_t wqe_lend:1;
-		uint64_t pbp_en:1;
-		uint64_t opc_mode:2;
-		uint64_t ipd_en:1;
+		u64 reserved_10_63:54;
+		u64 len_m8:1;
+		u64 reset:1;
+		u64 addpkt:1;
+		u64 naddbuf:1;
+		u64 pkt_lend:1;
+		u64 wqe_lend:1;
+		u64 pbp_en:1;
+		u64 opc_mode:2;
+		u64 ipd_en:1;
 	} cn30xx;
 	struct cvmx_ipd_ctl_status_cn38xxp2 {
-		uint64_t reserved_9_63:55;
-		uint64_t reset:1;
-		uint64_t addpkt:1;
-		uint64_t naddbuf:1;
-		uint64_t pkt_lend:1;
-		uint64_t wqe_lend:1;
-		uint64_t pbp_en:1;
-		uint64_t opc_mode:2;
-		uint64_t ipd_en:1;
+		u64 reserved_9_63:55;
+		u64 reset:1;
+		u64 addpkt:1;
+		u64 naddbuf:1;
+		u64 pkt_lend:1;
+		u64 wqe_lend:1;
+		u64 pbp_en:1;
+		u64 opc_mode:2;
+		u64 ipd_en:1;
 	} cn38xxp2;
 	struct cvmx_ipd_ctl_status_cn50xx {
-		uint64_t reserved_15_63:49;
-		uint64_t no_wptr:1;
-		uint64_t pq_apkt:1;
-		uint64_t pq_nabuf:1;
-		uint64_t ipd_full:1;
-		uint64_t pkt_off:1;
-		uint64_t len_m8:1;
-		uint64_t reset:1;
-		uint64_t addpkt:1;
-		uint64_t naddbuf:1;
-		uint64_t pkt_lend:1;
-		uint64_t wqe_lend:1;
-		uint64_t pbp_en:1;
-		uint64_t opc_mode:2;
-		uint64_t ipd_en:1;
+		u64 reserved_15_63:49;
+		u64 no_wptr:1;
+		u64 pq_apkt:1;
+		u64 pq_nabuf:1;
+		u64 ipd_full:1;
+		u64 pkt_off:1;
+		u64 len_m8:1;
+		u64 reset:1;
+		u64 addpkt:1;
+		u64 naddbuf:1;
+		u64 pkt_lend:1;
+		u64 wqe_lend:1;
+		u64 pbp_en:1;
+		u64 opc_mode:2;
+		u64 ipd_en:1;
 	} cn50xx;
 	struct cvmx_ipd_ctl_status_cn58xx {
-		uint64_t reserved_12_63:52;
-		uint64_t ipd_full:1;
-		uint64_t pkt_off:1;
-		uint64_t len_m8:1;
-		uint64_t reset:1;
-		uint64_t addpkt:1;
-		uint64_t naddbuf:1;
-		uint64_t pkt_lend:1;
-		uint64_t wqe_lend:1;
-		uint64_t pbp_en:1;
-		uint64_t opc_mode:2;
-		uint64_t ipd_en:1;
+		u64 reserved_12_63:52;
+		u64 ipd_full:1;
+		u64 pkt_off:1;
+		u64 len_m8:1;
+		u64 reset:1;
+		u64 addpkt:1;
+		u64 naddbuf:1;
+		u64 pkt_lend:1;
+		u64 wqe_lend:1;
+		u64 pbp_en:1;
+		u64 opc_mode:2;
+		u64 ipd_en:1;
 	} cn58xx;
 	struct cvmx_ipd_ctl_status_cn63xxp1 {
-		uint64_t reserved_16_63:48;
-		uint64_t clken:1;
-		uint64_t no_wptr:1;
-		uint64_t pq_apkt:1;
-		uint64_t pq_nabuf:1;
-		uint64_t ipd_full:1;
-		uint64_t pkt_off:1;
-		uint64_t len_m8:1;
-		uint64_t reset:1;
-		uint64_t addpkt:1;
-		uint64_t naddbuf:1;
-		uint64_t pkt_lend:1;
-		uint64_t wqe_lend:1;
-		uint64_t pbp_en:1;
-		uint64_t opc_mode:2;
-		uint64_t ipd_en:1;
+		u64 reserved_16_63:48;
+		u64 clken:1;
+		u64 no_wptr:1;
+		u64 pq_apkt:1;
+		u64 pq_nabuf:1;
+		u64 ipd_full:1;
+		u64 pkt_off:1;
+		u64 len_m8:1;
+		u64 reset:1;
+		u64 addpkt:1;
+		u64 naddbuf:1;
+		u64 pkt_lend:1;
+		u64 wqe_lend:1;
+		u64 pbp_en:1;
+		u64 opc_mode:2;
+		u64 ipd_en:1;
 	} cn63xxp1;
 };

 union cvmx_ipd_sub_port_fcs {
-	uint64_t u64;
+	u64 u64;
 	struct cvmx_ipd_sub_port_fcs_s {
-		uint64_t port_bit:32;
-		uint64_t reserved_32_35:4;
-		uint64_t port_bit2:4;
-		uint64_t reserved_40_63:24;
+		u64 port_bit:32;
+		u64 reserved_32_35:4;
+		u64 port_bit2:4;
+		u64 reserved_40_63:24;
 	} s;
 	struct cvmx_ipd_sub_port_fcs_cn30xx {
-		uint64_t port_bit:3;
-		uint64_t reserved_3_63:61;
+		u64 port_bit:3;
+		u64 reserved_3_63:61;
 	} cn30xx;
 	struct cvmx_ipd_sub_port_fcs_cn38xx {
-		uint64_t port_bit:32;
-		uint64_t reserved_32_63:32;
+		u64 port_bit:32;
+		u64 reserved_32_63:32;
 	} cn38xx;
 };

 union cvmx_ipd_sub_port_qos_cnt {
-	uint64_t u64;
+	u64 u64;
 	struct cvmx_ipd_sub_port_qos_cnt_s {
-		uint64_t cnt:32;
-		uint64_t port_qos:9;
-		uint64_t reserved_41_63:23;
+		u64 cnt:32;
+		u64 port_qos:9;
+		u64 reserved_41_63:23;
 	} s;
 };

 typedef struct {
-	uint32_t dropped_octets;
-	uint32_t dropped_packets;
-	uint32_t pci_raw_packets;
-	uint32_t octets;
-	uint32_t packets;
-	uint32_t multicast_packets;
-	uint32_t broadcast_packets;
-	uint32_t len_64_packets;
-	uint32_t len_65_127_packets;
-	uint32_t len_128_255_packets;
-	uint32_t len_256_511_packets;
-	uint32_t len_512_1023_packets;
-	uint32_t len_1024_1518_packets;
-	uint32_t len_1519_max_packets;
-	uint32_t fcs_align_err_packets;
-	uint32_t runt_packets;
-	uint32_t runt_crc_packets;
-	uint32_t oversize_packets;
-	uint32_t oversize_crc_packets;
-	uint32_t inb_packets;
-	uint64_t inb_octets;
-	uint16_t inb_errors;
+	u32 dropped_octets;
+	u32 dropped_packets;
+	u32 pci_raw_packets;
+	u32 octets;
+	u32 packets;
+	u32 multicast_packets;
+	u32 broadcast_packets;
+	u32 len_64_packets;
+	u32 len_65_127_packets;
+	u32 len_128_255_packets;
+	u32 len_256_511_packets;
+	u32 len_512_1023_packets;
+	u32 len_1024_1518_packets;
+	u32 len_1519_max_packets;
+	u32 fcs_align_err_packets;
+	u32 runt_packets;
+	u32 runt_crc_packets;
+	u32 oversize_packets;
+	u32 oversize_crc_packets;
+	u32 inb_packets;
+	u64 inb_octets;
+	u16 inb_errors;
 } cvmx_pip_port_status_t;

 typedef struct {
-	uint32_t packets;
-	uint64_t octets;
-	uint64_t doorbell;
+	u32 packets;
+	u64 octets;
+	u64 doorbell;
 } cvmx_pko_port_status_t;

 union cvmx_pip_frm_len_chkx {
-	uint64_t u64;
+	u64 u64;
 	struct cvmx_pip_frm_len_chkx_s {
-		uint64_t reserved_32_63:32;
-		uint64_t maxlen:16;
-		uint64_t minlen:16;
+		u64 reserved_32_63:32;
+		u64 maxlen:16;
+		u64 minlen:16;
 	} s;
 };

 union cvmx_gmxx_rxx_frm_ctl {
-	uint64_t u64;
+	u64 u64;
 	struct cvmx_gmxx_rxx_frm_ctl_s {
-		uint64_t pre_chk:1;
-		uint64_t pre_strp:1;
-		uint64_t ctl_drp:1;
-		uint64_t ctl_bck:1;
-		uint64_t ctl_mcst:1;
-		uint64_t ctl_smac:1;
-		uint64_t pre_free:1;
-		uint64_t vlan_len:1;
-		uint64_t pad_len:1;
-		uint64_t pre_align:1;
-		uint64_t null_dis:1;
-		uint64_t reserved_11_11:1;
-		uint64_t ptp_mode:1;
-		uint64_t reserved_13_63:51;
+		u64 pre_chk:1;
+		u64 pre_strp:1;
+		u64 ctl_drp:1;
+		u64 ctl_bck:1;
+		u64 ctl_mcst:1;
+		u64 ctl_smac:1;
+		u64 pre_free:1;
+		u64 vlan_len:1;
+		u64 pad_len:1;
+		u64 pre_align:1;
+		u64 null_dis:1;
+		u64 reserved_11_11:1;
+		u64 ptp_mode:1;
+		u64 reserved_13_63:51;
 	} s;
 	struct cvmx_gmxx_rxx_frm_ctl_cn30xx {
-		uint64_t pre_chk:1;
-		uint64_t pre_strp:1;
-		uint64_t ctl_drp:1;
-		uint64_t ctl_bck:1;
-		uint64_t ctl_mcst:1;
-		uint64_t ctl_smac:1;
-		uint64_t pre_free:1;
-		uint64_t vlan_len:1;
-		uint64_t pad_len:1;
-		uint64_t reserved_9_63:55;
+		u64 pre_chk:1;
+		u64 pre_strp:1;
+		u64 ctl_drp:1;
+		u64 ctl_bck:1;
+		u64 ctl_mcst:1;
+		u64 ctl_smac:1;
+		u64 pre_free:1;
+		u64 vlan_len:1;
+		u64 pad_len:1;
+		u64 reserved_9_63:55;
 	} cn30xx;
 	struct cvmx_gmxx_rxx_frm_ctl_cn31xx {
-		uint64_t pre_chk:1;
-		uint64_t pre_strp:1;
-		uint64_t ctl_drp:1;
-		uint64_t ctl_bck:1;
-		uint64_t ctl_mcst:1;
-		uint64_t ctl_smac:1;
-		uint64_t pre_free:1;
-		uint64_t vlan_len:1;
-		uint64_t reserved_8_63:56;
+		u64 pre_chk:1;
+		u64 pre_strp:1;
+		u64 ctl_drp:1;
+		u64 ctl_bck:1;
+		u64 ctl_mcst:1;
+		u64 ctl_smac:1;
+		u64 pre_free:1;
+		u64 vlan_len:1;
+		u64 reserved_8_63:56;
 	} cn31xx;
 	struct cvmx_gmxx_rxx_frm_ctl_cn50xx {
-		uint64_t pre_chk:1;
-		uint64_t pre_strp:1;
-		uint64_t ctl_drp:1;
-		uint64_t ctl_bck:1;
-		uint64_t ctl_mcst:1;
-		uint64_t ctl_smac:1;
-		uint64_t pre_free:1;
-		uint64_t reserved_7_8:2;
-		uint64_t pre_align:1;
-		uint64_t null_dis:1;
-		uint64_t reserved_11_63:53;
+		u64 pre_chk:1;
+		u64 pre_strp:1;
+		u64 ctl_drp:1;
+		u64 ctl_bck:1;
+		u64 ctl_mcst:1;
+		u64 ctl_smac:1;
+		u64 pre_free:1;
+		u64 reserved_7_8:2;
+		u64 pre_align:1;
+		u64 null_dis:1;
+		u64 reserved_11_63:53;
 	} cn50xx;
 	struct cvmx_gmxx_rxx_frm_ctl_cn56xxp1 {
-		uint64_t pre_chk:1;
-		uint64_t pre_strp:1;
-		uint64_t ctl_drp:1;
-		uint64_t ctl_bck:1;
-		uint64_t ctl_mcst:1;
-		uint64_t ctl_smac:1;
-		uint64_t pre_free:1;
-		uint64_t reserved_7_8:2;
-		uint64_t pre_align:1;
-		uint64_t reserved_10_63:54;
+		u64 pre_chk:1;
+		u64 pre_strp:1;
+		u64 ctl_drp:1;
+		u64 ctl_bck:1;
+		u64 ctl_mcst:1;
+		u64 ctl_smac:1;
+		u64 pre_free:1;
+		u64 reserved_7_8:2;
+		u64 pre_align:1;
+		u64 reserved_10_63:54;
 	} cn56xxp1;
 	struct cvmx_gmxx_rxx_frm_ctl_cn58xx {
-		uint64_t pre_chk:1;
-		uint64_t pre_strp:1;
-		uint64_t ctl_drp:1;
-		uint64_t ctl_bck:1;
-		uint64_t ctl_mcst:1;
-		uint64_t ctl_smac:1;
-		uint64_t pre_free:1;
-		uint64_t vlan_len:1;
-		uint64_t pad_len:1;
-		uint64_t pre_align:1;
-		uint64_t null_dis:1;
-		uint64_t reserved_11_63:53;
+		u64 pre_chk:1;
+		u64 pre_strp:1;
+		u64 ctl_drp:1;
+		u64 ctl_bck:1;
+		u64 ctl_mcst:1;
+		u64 ctl_smac:1;
+		u64 pre_free:1;
+		u64 vlan_len:1;
+		u64 pad_len:1;
+		u64 pre_align:1;
+		u64 null_dis:1;
+		u64 reserved_11_63:53;
 	} cn58xx;
 	struct cvmx_gmxx_rxx_frm_ctl_cn61xx {
-		uint64_t pre_chk:1;
-		uint64_t pre_strp:1;
-		uint64_t ctl_drp:1;
-		uint64_t ctl_bck:1;
-		uint64_t ctl_mcst:1;
-		uint64_t ctl_smac:1;
-		uint64_t pre_free:1;
-		uint64_t reserved_7_8:2;
-		uint64_t pre_align:1;
-		uint64_t null_dis:1;
-		uint64_t reserved_11_11:1;
-		uint64_t ptp_mode:1;
-		uint64_t reserved_13_63:51;
+		u64 pre_chk:1;
+		u64 pre_strp:1;
+		u64 ctl_drp:1;
+		u64 ctl_bck:1;
+		u64 ctl_mcst:1;
+		u64 ctl_smac:1;
+		u64 pre_free:1;
+		u64 reserved_7_8:2;
+		u64 pre_align:1;
+		u64 null_dis:1;
+		u64 reserved_11_11:1;
+		u64 ptp_mode:1;
+		u64 reserved_13_63:51;
 	} cn61xx;
 };

 union cvmx_gmxx_rxx_int_reg {
-	uint64_t u64;
+	u64 u64;
 	struct cvmx_gmxx_rxx_int_reg_s {
-		uint64_t minerr:1;
-		uint64_t carext:1;
-		uint64_t maxerr:1;
-		uint64_t jabber:1;
-		uint64_t fcserr:1;
-		uint64_t alnerr:1;
-		uint64_t lenerr:1;
-		uint64_t rcverr:1;
-		uint64_t skperr:1;
-		uint64_t niberr:1;
-		uint64_t ovrerr:1;
-		uint64_t pcterr:1;
-		uint64_t rsverr:1;
-		uint64_t falerr:1;
-		uint64_t coldet:1;
-		uint64_t ifgerr:1;
-		uint64_t phy_link:1;
-		uint64_t phy_spd:1;
-		uint64_t phy_dupx:1;
-		uint64_t pause_drp:1;
-		uint64_t loc_fault:1;
-		uint64_t rem_fault:1;
-		uint64_t bad_seq:1;
-		uint64_t bad_term:1;
-		uint64_t unsop:1;
-		uint64_t uneop:1;
-		uint64_t undat:1;
-		uint64_t hg2fld:1;
-		uint64_t hg2cc:1;
-		uint64_t reserved_29_63:35;
+		u64 minerr:1;
+		u64 carext:1;
+		u64 maxerr:1;
+		u64 jabber:1;
+		u64 fcserr:1;
+		u64 alnerr:1;
+		u64 lenerr:1;
+		u64 rcverr:1;
+		u64 skperr:1;
+		u64 niberr:1;
+		u64 ovrerr:1;
+		u64 pcterr:1;
+		u64 rsverr:1;
+		u64 falerr:1;
+		u64 coldet:1;
+		u64 ifgerr:1;
+		u64 phy_link:1;
+		u64 phy_spd:1;
+		u64 phy_dupx:1;
+		u64 pause_drp:1;
+		u64 loc_fault:1;
+		u64 rem_fault:1;
+		u64 bad_seq:1;
+		u64 bad_term:1;
+		u64 unsop:1;
+		u64 uneop:1;
+		u64 undat:1;
+		u64 hg2fld:1;
+		u64 hg2cc:1;
+		u64 reserved_29_63:35;
 	} s;
 	struct cvmx_gmxx_rxx_int_reg_cn30xx {
-		uint64_t minerr:1;
-		uint64_t carext:1;
-		uint64_t maxerr:1;
-		uint64_t jabber:1;
-		uint64_t fcserr:1;
-		uint64_t alnerr:1;
-		uint64_t lenerr:1;
-		uint64_t rcverr:1;
-		uint64_t skperr:1;
-		uint64_t niberr:1;
-		uint64_t ovrerr:1;
-		uint64_t pcterr:1;
-		uint64_t rsverr:1;
-		uint64_t falerr:1;
-		uint64_t coldet:1;
-		uint64_t ifgerr:1;
-		uint64_t phy_link:1;
-		uint64_t phy_spd:1;
-		uint64_t phy_dupx:1;
-		uint64_t reserved_19_63:45;
+		u64 minerr:1;
+		u64 carext:1;
+		u64 maxerr:1;
+		u64 jabber:1;
+		u64 fcserr:1;
+		u64 alnerr:1;
+		u64 lenerr:1;
+		u64 rcverr:1;
+		u64 skperr:1;
+		u64 niberr:1;
+		u64 ovrerr:1;
+		u64 pcterr:1;
+		u64 rsverr:1;
+		u64 falerr:1;
+		u64 coldet:1;
+		u64 ifgerr:1;
+		u64 phy_link:1;
+		u64 phy_spd:1;
+		u64 phy_dupx:1;
+		u64 reserved_19_63:45;
 	} cn30xx;
 	struct cvmx_gmxx_rxx_int_reg_cn50xx {
-		uint64_t reserved_0_0:1;
-		uint64_t carext:1;
-		uint64_t reserved_2_2:1;
-		uint64_t jabber:1;
-		uint64_t fcserr:1;
-		uint64_t alnerr:1;
-		uint64_t reserved_6_6:1;
-		uint64_t rcverr:1;
-		uint64_t skperr:1;
-		uint64_t niberr:1;
-		uint64_t ovrerr:1;
-		uint64_t pcterr:1;
-		uint64_t rsverr:1;
-		uint64_t falerr:1;
-		uint64_t coldet:1;
-		uint64_t ifgerr:1;
-		uint64_t phy_link:1;
-		uint64_t phy_spd:1;
-		uint64_t phy_dupx:1;
-		uint64_t pause_drp:1;
-		uint64_t reserved_20_63:44;
+		u64 reserved_0_0:1;
+		u64 carext:1;
+		u64 reserved_2_2:1;
+		u64 jabber:1;
+		u64 fcserr:1;
+		u64 alnerr:1;
+		u64 reserved_6_6:1;
+		u64 rcverr:1;
+		u64 skperr:1;
+		u64 niberr:1;
+		u64 ovrerr:1;
+		u64 pcterr:1;
+		u64 rsverr:1;
+		u64 falerr:1;
+		u64 coldet:1;
+		u64 ifgerr:1;
+		u64 phy_link:1;
+		u64 phy_spd:1;
+		u64 phy_dupx:1;
+		u64 pause_drp:1;
+		u64 reserved_20_63:44;
 	} cn50xx;
 	struct cvmx_gmxx_rxx_int_reg_cn52xx {
-		uint64_t reserved_0_0:1;
-		uint64_t carext:1;
-		uint64_t reserved_2_2:1;
-		uint64_t jabber:1;
-		uint64_t fcserr:1;
-		uint64_t reserved_5_6:2;
-		uint64_t rcverr:1;
-		uint64_t skperr:1;
-		uint64_t reserved_9_9:1;
-		uint64_t ovrerr:1;
-		uint64_t pcterr:1;
-		uint64_t rsverr:1;
-		uint64_t falerr:1;
-		uint64_t coldet:1;
-		uint64_t ifgerr:1;
-		uint64_t reserved_16_18:3;
-		uint64_t pause_drp:1;
-		uint64_t loc_fault:1;
-		uint64_t rem_fault:1;
-		uint64_t bad_seq:1;
-		uint64_t bad_term:1;
-		uint64_t unsop:1;
-		uint64_t uneop:1;
-		uint64_t undat:1;
-		uint64_t hg2fld:1;
-		uint64_t hg2cc:1;
-		uint64_t reserved_29_63:35;
+		u64 reserved_0_0:1;
+		u64 carext:1;
+		u64 reserved_2_2:1;
+		u64 jabber:1;
+		u64 fcserr:1;
+		u64 reserved_5_6:2;
+		u64 rcverr:1;
+		u64 skperr:1;
+		u64 reserved_9_9:1;
+		u64 ovrerr:1;
+		u64 pcterr:1;
+		u64 rsverr:1;
+		u64 falerr:1;
+		u64 coldet:1;
+		u64 ifgerr:1;
+		u64 reserved_16_18:3;
+		u64 pause_drp:1;
+		u64 loc_fault:1;
+		u64 rem_fault:1;
+		u64 bad_seq:1;
+		u64 bad_term:1;
+		u64 unsop:1;
+		u64 uneop:1;
+		u64 undat:1;
+		u64 hg2fld:1;
+		u64 hg2cc:1;
+		u64 reserved_29_63:35;
 	} cn52xx;
 	struct cvmx_gmxx_rxx_int_reg_cn56xxp1 {
-		uint64_t reserved_0_0:1;
-		uint64_t carext:1;
-		uint64_t reserved_2_2:1;
-		uint64_t jabber:1;
-		uint64_t fcserr:1;
-		uint64_t reserved_5_6:2;
-		uint64_t rcverr:1;
-		uint64_t skperr:1;
-		uint64_t reserved_9_9:1;
-		uint64_t ovrerr:1;
-		uint64_t pcterr:1;
-		uint64_t rsverr:1;
-		uint64_t falerr:1;
-		uint64_t coldet:1;
-		uint64_t ifgerr:1;
-		uint64_t reserved_16_18:3;
-		uint64_t pause_drp:1;
-		uint64_t loc_fault:1;
-		uint64_t rem_fault:1;
-		uint64_t bad_seq:1;
-		uint64_t bad_term:1;
-		uint64_t unsop:1;
-		uint64_t uneop:1;
-		uint64_t undat:1;
-		uint64_t reserved_27_63:37;
+		u64 reserved_0_0:1;
+		u64 carext:1;
+		u64 reserved_2_2:1;
+		u64 jabber:1;
+		u64 fcserr:1;
+		u64 reserved_5_6:2;
+		u64 rcverr:1;
+		u64 skperr:1;
+		u64 reserved_9_9:1;
+		u64 ovrerr:1;
+		u64 pcterr:1;
+		u64 rsverr:1;
+		u64 falerr:1;
+		u64 coldet:1;
+		u64 ifgerr:1;
+		u64 reserved_16_18:3;
+		u64 pause_drp:1;
+		u64 loc_fault:1;
+		u64 rem_fault:1;
+		u64 bad_seq:1;
+		u64 bad_term:1;
+		u64 unsop:1;
+		u64 uneop:1;
+		u64 undat:1;
+		u64 reserved_27_63:37;
 	} cn56xxp1;
 	struct cvmx_gmxx_rxx_int_reg_cn58xx {
-		uint64_t minerr:1;
-		uint64_t carext:1;
-		uint64_t maxerr:1;
-		uint64_t jabber:1;
-		uint64_t fcserr:1;
-		uint64_t alnerr:1;
-		uint64_t lenerr:1;
-		uint64_t rcverr:1;
-		uint64_t skperr:1;
-		uint64_t niberr:1;
-		uint64_t ovrerr:1;
-		uint64_t pcterr:1;
-		uint64_t rsverr:1;
-		uint64_t falerr:1;
-		uint64_t coldet:1;
-		uint64_t ifgerr:1;
-		uint64_t phy_link:1;
-		uint64_t phy_spd:1;
-		uint64_t phy_dupx:1;
-		uint64_t pause_drp:1;
-		uint64_t reserved_20_63:44;
+		u64 minerr:1;
+		u64 carext:1;
+		u64 maxerr:1;
+		u64 jabber:1;
+		u64 fcserr:1;
+		u64 alnerr:1;
+		u64 lenerr:1;
+		u64 rcverr:1;
+		u64 skperr:1;
+		u64 niberr:1;
+		u64 ovrerr:1;
+		u64 pcterr:1;
+		u64 rsverr:1;
+		u64 falerr:1;
+		u64 coldet:1;
+		u64 ifgerr:1;
+		u64 phy_link:1;
+		u64 phy_spd:1;
+		u64 phy_dupx:1;
+		u64 pause_drp:1;
+		u64 reserved_20_63:44;
 	} cn58xx;
 	struct cvmx_gmxx_rxx_int_reg_cn61xx {
-		uint64_t minerr:1;
-		uint64_t carext:1;
-		uint64_t reserved_2_2:1;
-		uint64_t jabber:1;
-		uint64_t fcserr:1;
-		uint64_t reserved_5_6:2;
-		uint64_t rcverr:1;
-		uint64_t skperr:1;
-		uint64_t reserved_9_9:1;
-		uint64_t ovrerr:1;
-		uint64_t pcterr:1;
-		uint64_t rsverr:1;
-		uint64_t falerr:1;
-		uint64_t coldet:1;
-		uint64_t ifgerr:1;
-		uint64_t reserved_16_18:3;
-		uint64_t pause_drp:1;
-		uint64_t loc_fault:1;
-		uint64_t rem_fault:1;
-		uint64_t bad_seq:1;
-		uint64_t bad_term:1;
-		uint64_t unsop:1;
-		uint64_t uneop:1;
-		uint64_t undat:1;
-		uint64_t hg2fld:1;
-		uint64_t hg2cc:1;
-		uint64_t reserved_29_63:35;
+		u64 minerr:1;
+		u64 carext:1;
+		u64 reserved_2_2:1;
+		u64 jabber:1;
+		u64 fcserr:1;
+		u64 reserved_5_6:2;
+		u64 rcverr:1;
+		u64 skperr:1;
+		u64 reserved_9_9:1;
+		u64 ovrerr:1;
+		u64 pcterr:1;
+		u64 rsverr:1;
+		u64 falerr:1;
+		u64 coldet:1;
+		u64 ifgerr:1;
+		u64 reserved_16_18:3;
+		u64 pause_drp:1;
+		u64 loc_fault:1;
+		u64 rem_fault:1;
+		u64 bad_seq:1;
+		u64 bad_term:1;
+		u64 unsop:1;
+		u64 uneop:1;
+		u64 undat:1;
+		u64 hg2fld:1;
+		u64 hg2cc:1;
+		u64 reserved_29_63:35;
 	} cn61xx;
 };

 union cvmx_gmxx_prtx_cfg {
-	uint64_t u64;
+	u64 u64;
 	struct cvmx_gmxx_prtx_cfg_s {
-		uint64_t reserved_22_63:42;
-		uint64_t pknd:6;
-		uint64_t reserved_14_15:2;
-		uint64_t tx_idle:1;
-		uint64_t rx_idle:1;
-		uint64_t reserved_9_11:3;
-		uint64_t speed_msb:1;
-		uint64_t reserved_4_7:4;
-		uint64_t slottime:1;
-		uint64_t duplex:1;
-		uint64_t speed:1;
-		uint64_t en:1;
+		u64 reserved_22_63:42;
+		u64 pknd:6;
+		u64 reserved_14_15:2;
+		u64 tx_idle:1;
+		u64 rx_idle:1;
+		u64 reserved_9_11:3;
+		u64 speed_msb:1;
+		u64 reserved_4_7:4;
+		u64 slottime:1;
+		u64 duplex:1;
+		u64 speed:1;
+		u64 en:1;
 	} s;
 	struct cvmx_gmxx_prtx_cfg_cn30xx {
-		uint64_t reserved_4_63:60;
-		uint64_t slottime:1;
-		uint64_t duplex:1;
-		uint64_t speed:1;
-		uint64_t en:1;
+		u64 reserved_4_63:60;
+		u64 slottime:1;
+		u64 duplex:1;
+		u64 speed:1;
+		u64 en:1;
 	} cn30xx;
 	struct cvmx_gmxx_prtx_cfg_cn52xx {
-		uint64_t reserved_14_63:50;
-		uint64_t tx_idle:1;
-		uint64_t rx_idle:1;
-		uint64_t reserved_9_11:3;
-		uint64_t speed_msb:1;
-		uint64_t reserved_4_7:4;
-		uint64_t slottime:1;
-		uint64_t duplex:1;
-		uint64_t speed:1;
-		uint64_t en:1;
+		u64 reserved_14_63:50;
+		u64 tx_idle:1;
+		u64 rx_idle:1;
+		u64 reserved_9_11:3;
+		u64 speed_msb:1;
+		u64 reserved_4_7:4;
+		u64 slottime:1;
+		u64 duplex:1;
+		u64 speed:1;
+		u64 en:1;
 	} cn52xx;
 };

 union cvmx_gmxx_rxx_adr_ctl {
-	uint64_t u64;
+	u64 u64;
 	struct cvmx_gmxx_rxx_adr_ctl_s {
-		uint64_t reserved_4_63:60;
-		uint64_t cam_mode:1;
-		uint64_t mcst:2;
-		uint64_t bcst:1;
+		u64 reserved_4_63:60;
+		u64 cam_mode:1;
+		u64 mcst:2;
+		u64 bcst:1;
 	} s;
 };

 union cvmx_pip_prt_tagx {
-	uint64_t u64;
+	u64 u64;
 	struct cvmx_pip_prt_tagx_s {
-		uint64_t reserved_54_63:10;
-		uint64_t portadd_en:1;
-		uint64_t inc_hwchk:1;
-		uint64_t reserved_50_51:2;
-		uint64_t grptagbase_msb:2;
-		uint64_t reserved_46_47:2;
-		uint64_t grptagmask_msb:2;
-		uint64_t reserved_42_43:2;
-		uint64_t grp_msb:2;
-		uint64_t grptagbase:4;
-		uint64_t grptagmask:4;
-		uint64_t grptag:1;
-		uint64_t grptag_mskip:1;
-		uint64_t tag_mode:2;
-		uint64_t inc_vs:2;
-		uint64_t inc_vlan:1;
-		uint64_t inc_prt_flag:1;
-		uint64_t ip6_dprt_flag:1;
-		uint64_t ip4_dprt_flag:1;
-		uint64_t ip6_sprt_flag:1;
-		uint64_t ip4_sprt_flag:1;
-		uint64_t ip6_nxth_flag:1;
-		uint64_t ip4_pctl_flag:1;
-		uint64_t ip6_dst_flag:1;
-		uint64_t ip4_dst_flag:1;
-		uint64_t ip6_src_flag:1;
-		uint64_t ip4_src_flag:1;
-		uint64_t tcp6_tag_type:2;
-		uint64_t tcp4_tag_type:2;
-		uint64_t ip6_tag_type:2;
-		uint64_t ip4_tag_type:2;
-		uint64_t non_tag_type:2;
-		uint64_t grp:4;
+		u64 reserved_54_63:10;
+		u64 portadd_en:1;
+		u64 inc_hwchk:1;
+		u64 reserved_50_51:2;
+		u64 grptagbase_msb:2;
+		u64 reserved_46_47:2;
+		u64 grptagmask_msb:2;
+		u64 reserved_42_43:2;
+		u64 grp_msb:2;
+		u64 grptagbase:4;
+		u64 grptagmask:4;
+		u64 grptag:1;
+		u64 grptag_mskip:1;
+		u64 tag_mode:2;
+		u64 inc_vs:2;
+		u64 inc_vlan:1;
+		u64 inc_prt_flag:1;
+		u64 ip6_dprt_flag:1;
+		u64 ip4_dprt_flag:1;
+		u64 ip6_sprt_flag:1;
+		u64 ip4_sprt_flag:1;
+		u64 ip6_nxth_flag:1;
+		u64 ip4_pctl_flag:1;
+		u64 ip6_dst_flag:1;
+		u64 ip4_dst_flag:1;
+		u64 ip6_src_flag:1;
+		u64 ip4_src_flag:1;
+		u64 tcp6_tag_type:2;
+		u64 tcp4_tag_type:2;
+		u64 ip6_tag_type:2;
+		u64 ip4_tag_type:2;
+		u64 non_tag_type:2;
+		u64 grp:4;
 	} s;
 	struct cvmx_pip_prt_tagx_cn30xx {
-		uint64_t reserved_40_63:24;
-		uint64_t grptagbase:4;
-		uint64_t grptagmask:4;
-		uint64_t grptag:1;
-		uint64_t reserved_30_30:1;
-		uint64_t tag_mode:2;
-		uint64_t inc_vs:2;
-		uint64_t inc_vlan:1;
-		uint64_t inc_prt_flag:1;
-		uint64_t ip6_dprt_flag:1;
-		uint64_t ip4_dprt_flag:1;
-		uint64_t ip6_sprt_flag:1;
-		uint64_t ip4_sprt_flag:1;
-		uint64_t ip6_nxth_flag:1;
-		uint64_t ip4_pctl_flag:1;
-		uint64_t ip6_dst_flag:1;
-		uint64_t ip4_dst_flag:1;
-		uint64_t ip6_src_flag:1;
-		uint64_t ip4_src_flag:1;
-		uint64_t tcp6_tag_type:2;
-		uint64_t tcp4_tag_type:2;
-		uint64_t ip6_tag_type:2;
-		uint64_t ip4_tag_type:2;
-		uint64_t non_tag_type:2;
-		uint64_t grp:4;
+		u64 reserved_40_63:24;
+		u64 grptagbase:4;
+		u64 grptagmask:4;
+		u64 grptag:1;
+		u64 reserved_30_30:1;
+		u64 tag_mode:2;
+		u64 inc_vs:2;
+		u64 inc_vlan:1;
+		u64 inc_prt_flag:1;
+		u64 ip6_dprt_flag:1;
+		u64 ip4_dprt_flag:1;
+		u64 ip6_sprt_flag:1;
+		u64 ip4_sprt_flag:1;
+		u64 ip6_nxth_flag:1;
+		u64 ip4_pctl_flag:1;
+		u64 ip6_dst_flag:1;
+		u64 ip4_dst_flag:1;
+		u64 ip6_src_flag:1;
+		u64 ip4_src_flag:1;
+		u64 tcp6_tag_type:2;
+		u64 tcp4_tag_type:2;
+		u64 ip6_tag_type:2;
+		u64 ip4_tag_type:2;
+		u64 non_tag_type:2;
+		u64 grp:4;
 	} cn30xx;
 	struct cvmx_pip_prt_tagx_cn50xx {
-		uint64_t reserved_40_63:24;
-		uint64_t grptagbase:4;
-		uint64_t grptagmask:4;
-		uint64_t grptag:1;
-		uint64_t grptag_mskip:1;
-		uint64_t tag_mode:2;
-		uint64_t inc_vs:2;
-		uint64_t inc_vlan:1;
-		uint64_t inc_prt_flag:1;
-		uint64_t ip6_dprt_flag:1;
-		uint64_t ip4_dprt_flag:1;
-		uint64_t ip6_sprt_flag:1;
-		uint64_t ip4_sprt_flag:1;
-		uint64_t ip6_nxth_flag:1;
-		uint64_t ip4_pctl_flag:1;
-		uint64_t ip6_dst_flag:1;
-		uint64_t ip4_dst_flag:1;
-		uint64_t ip6_src_flag:1;
-		uint64_t ip4_src_flag:1;
-		uint64_t tcp6_tag_type:2;
-		uint64_t tcp4_tag_type:2;
-		uint64_t ip6_tag_type:2;
-		uint64_t ip4_tag_type:2;
-		uint64_t non_tag_type:2;
-		uint64_t grp:4;
+		u64 reserved_40_63:24;
+		u64 grptagbase:4;
+		u64 grptagmask:4;
+		u64 grptag:1;
+		u64 grptag_mskip:1;
+		u64 tag_mode:2;
+		u64 inc_vs:2;
+		u64 inc_vlan:1;
+		u64 inc_prt_flag:1;
+		u64 ip6_dprt_flag:1;
+		u64 ip4_dprt_flag:1;
+		u64 ip6_sprt_flag:1;
+		u64 ip4_sprt_flag:1;
+		u64 ip6_nxth_flag:1;
+		u64 ip4_pctl_flag:1;
+		u64 ip6_dst_flag:1;
+		u64 ip4_dst_flag:1;
+		u64 ip6_src_flag:1;
+		u64 ip4_src_flag:1;
+		u64 tcp6_tag_type:2;
+		u64 tcp4_tag_type:2;
+		u64 ip6_tag_type:2;
+		u64 ip4_tag_type:2;
+		u64 non_tag_type:2;
+		u64 grp:4;
 	} cn50xx;
 };

 union cvmx_spxx_int_reg {
-	uint64_t u64;
+	u64 u64;
 	struct cvmx_spxx_int_reg_s {
-		uint64_t reserved_32_63:32;
-		uint64_t spf:1;
-		uint64_t reserved_12_30:19;
-		uint64_t calerr:1;
-		uint64_t syncerr:1;
-		uint64_t diperr:1;
-		uint64_t tpaovr:1;
-		uint64_t rsverr:1;
-		uint64_t drwnng:1;
-		uint64_t clserr:1;
-		uint64_t spiovr:1;
-		uint64_t reserved_2_3:2;
-		uint64_t abnorm:1;
-		uint64_t prtnxa:1;
+		u64 reserved_32_63:32;
+		u64 spf:1;
+		u64 reserved_12_30:19;
+		u64 calerr:1;
+		u64 syncerr:1;
+		u64 diperr:1;
+		u64 tpaovr:1;
+		u64 rsverr:1;
+		u64 drwnng:1;
+		u64 clserr:1;
+		u64 spiovr:1;
+		u64 reserved_2_3:2;
+		u64 abnorm:1;
+		u64 prtnxa:1;
 	} s;
 };

 union cvmx_spxx_int_msk {
-	uint64_t u64;
+	u64 u64;
 	struct cvmx_spxx_int_msk_s {
-		uint64_t reserved_12_63:52;
-		uint64_t calerr:1;
-		uint64_t syncerr:1;
-		uint64_t diperr:1;
-		uint64_t tpaovr:1;
-		uint64_t rsverr:1;
-		uint64_t drwnng:1;
-		uint64_t clserr:1;
-		uint64_t spiovr:1;
-		uint64_t reserved_2_3:2;
-		uint64_t abnorm:1;
-		uint64_t prtnxa:1;
+		u64 reserved_12_63:52;
+		u64 calerr:1;
+		u64 syncerr:1;
+		u64 diperr:1;
+		u64 tpaovr:1;
+		u64 rsverr:1;
+		u64 drwnng:1;
+		u64 clserr:1;
+		u64 spiovr:1;
+		u64 reserved_2_3:2;
+		u64 abnorm:1;
+		u64 prtnxa:1;
 	} s;
 };

 union cvmx_pow_wq_int {
-	uint64_t u64;
+	u64 u64;
 	struct cvmx_pow_wq_int_s {
-		uint64_t wq_int:16;
-		uint64_t iq_dis:16;
-		uint64_t reserved_32_63:32;
+		u64 wq_int:16;
+		u64 iq_dis:16;
+		u64 reserved_32_63:32;
 	} s;
 };

 union cvmx_sso_wq_int_thrx {
-	uint64_t u64;
+	u64 u64;
 	struct {
-		uint64_t iq_thr:12;
-		uint64_t reserved_12_13:2;
-		uint64_t ds_thr:12;
-		uint64_t reserved_26_27:2;
-		uint64_t tc_thr:4;
-		uint64_t tc_en:1;
-		uint64_t reserved_33_63:31;
+		u64 iq_thr:12;
+		u64 reserved_12_13:2;
+		u64 ds_thr:12;
+		u64 reserved_26_27:2;
+		u64 tc_thr:4;
+		u64 tc_en:1;
+		u64 reserved_33_63:31;
 	} s;
 };

 union cvmx_stxx_int_reg {
-	uint64_t u64;
+	u64 u64;
 	struct cvmx_stxx_int_reg_s {
-		uint64_t reserved_9_63:55;
-		uint64_t syncerr:1;
-		uint64_t frmerr:1;
-		uint64_t unxfrm:1;
-		uint64_t nosync:1;
-		uint64_t diperr:1;
-		uint64_t datovr:1;
-		uint64_t ovrbst:1;
-		uint64_t calpar1:1;
-		uint64_t calpar0:1;
+		u64 reserved_9_63:55;
+		u64 syncerr:1;
+		u64 frmerr:1;
+		u64 unxfrm:1;
+		u64 nosync:1;
+		u64 diperr:1;
+		u64 datovr:1;
+		u64 ovrbst:1;
+		u64 calpar1:1;
+		u64 calpar0:1;
 	} s;
 };

 union cvmx_stxx_int_msk {
-	uint64_t u64;
+	u64 u64;
 	struct cvmx_stxx_int_msk_s {
-		uint64_t reserved_8_63:56;
-		uint64_t frmerr:1;
-		uint64_t unxfrm:1;
-		uint64_t nosync:1;
-		uint64_t diperr:1;
-		uint64_t datovr:1;
-		uint64_t ovrbst:1;
-		uint64_t calpar1:1;
-		uint64_t calpar0:1;
+		u64 reserved_8_63:56;
+		u64 frmerr:1;
+		u64 unxfrm:1;
+		u64 nosync:1;
+		u64 diperr:1;
+		u64 datovr:1;
+		u64 ovrbst:1;
+		u64 calpar1:1;
+		u64 calpar0:1;
 	} s;
 };

 union cvmx_pow_wq_int_pc {
-	uint64_t u64;
+	u64 u64;
 	struct cvmx_pow_wq_int_pc_s {
-		uint64_t reserved_0_7:8;
-		uint64_t pc_thr:20;
-		uint64_t reserved_28_31:4;
-		uint64_t pc:28;
-		uint64_t reserved_60_63:4;
+		u64 reserved_0_7:8;
+		u64 pc_thr:20;
+		u64 reserved_28_31:4;
+		u64 pc:28;
+		u64 reserved_60_63:4;
 	} s;
 };

 union cvmx_pow_wq_int_thrx {
-	uint64_t u64;
+	u64 u64;
 	struct cvmx_pow_wq_int_thrx_s {
-		uint64_t reserved_29_63:35;
-		uint64_t tc_en:1;
-		uint64_t tc_thr:4;
-		uint64_t reserved_23_23:1;
-		uint64_t ds_thr:11;
-		uint64_t reserved_11_11:1;
-		uint64_t iq_thr:11;
+		u64 reserved_29_63:35;
+		u64 tc_en:1;
+		u64 tc_thr:4;
+		u64 reserved_23_23:1;
+		u64 ds_thr:11;
+		u64 reserved_11_11:1;
+		u64 iq_thr:11;
 	} s;
 	struct cvmx_pow_wq_int_thrx_cn30xx {
-		uint64_t reserved_29_63:35;
-		uint64_t tc_en:1;
-		uint64_t tc_thr:4;
-		uint64_t reserved_18_23:6;
-		uint64_t ds_thr:6;
-		uint64_t reserved_6_11:6;
-		uint64_t iq_thr:6;
+		u64 reserved_29_63:35;
+		u64 tc_en:1;
+		u64 tc_thr:4;
+		u64 reserved_18_23:6;
+		u64 ds_thr:6;
+		u64 reserved_6_11:6;
+		u64 iq_thr:6;
 	} cn30xx;
 	struct cvmx_pow_wq_int_thrx_cn31xx {
-		uint64_t reserved_29_63:35;
-		uint64_t tc_en:1;
-		uint64_t tc_thr:4;
-		uint64_t reserved_20_23:4;
-		uint64_t ds_thr:8;
-		uint64_t reserved_8_11:4;
-		uint64_t iq_thr:8;
+		u64 reserved_29_63:35;
+		u64 tc_en:1;
+		u64 tc_thr:4;
+		u64 reserved_20_23:4;
+		u64 ds_thr:8;
+		u64 reserved_8_11:4;
+		u64 iq_thr:8;
 	} cn31xx;
 	struct cvmx_pow_wq_int_thrx_cn52xx {
-		uint64_t reserved_29_63:35;
-		uint64_t tc_en:1;
-		uint64_t tc_thr:4;
-		uint64_t reserved_21_23:3;
-		uint64_t ds_thr:9;
-		uint64_t reserved_9_11:3;
-		uint64_t iq_thr:9;
+		u64 reserved_29_63:35;
+		u64 tc_en:1;
+		u64 tc_thr:4;
+		u64 reserved_21_23:3;
+		u64 ds_thr:9;
+		u64 reserved_9_11:3;
+		u64 iq_thr:9;
 	} cn52xx;
 	struct cvmx_pow_wq_int_thrx_cn63xx {
-		uint64_t reserved_29_63:35;
-		uint64_t tc_en:1;
-		uint64_t tc_thr:4;
-		uint64_t reserved_22_23:2;
-		uint64_t ds_thr:10;
-		uint64_t reserved_10_11:2;
-		uint64_t iq_thr:10;
+		u64 reserved_29_63:35;
+		u64 tc_en:1;
+		u64 tc_thr:4;
+		u64 reserved_22_23:2;
+		u64 ds_thr:10;
+		u64 reserved_10_11:2;
+		u64 iq_thr:10;
 	} cn63xx;
 };

 union cvmx_npi_rsl_int_blocks {
-	uint64_t u64;
+	u64 u64;
 	struct cvmx_npi_rsl_int_blocks_s {
-		uint64_t reserved_32_63:32;
-		uint64_t rint_31:1;
-		uint64_t iob:1;
-		uint64_t reserved_28_29:2;
-		uint64_t rint_27:1;
-		uint64_t rint_26:1;
-		uint64_t rint_25:1;
-		uint64_t rint_24:1;
-		uint64_t asx1:1;
-		uint64_t asx0:1;
-		uint64_t rint_21:1;
-		uint64_t pip:1;
-		uint64_t spx1:1;
-		uint64_t spx0:1;
-		uint64_t lmc:1;
-		uint64_t l2c:1;
-		uint64_t rint_15:1;
-		uint64_t reserved_13_14:2;
-		uint64_t pow:1;
-		uint64_t tim:1;
-		uint64_t pko:1;
-		uint64_t ipd:1;
-		uint64_t rint_8:1;
-		uint64_t zip:1;
-		uint64_t dfa:1;
-		uint64_t fpa:1;
-		uint64_t key:1;
-		uint64_t npi:1;
-		uint64_t gmx1:1;
-		uint64_t gmx0:1;
-		uint64_t mio:1;
+		u64 reserved_32_63:32;
+		u64 rint_31:1;
+		u64 iob:1;
+		u64 reserved_28_29:2;
+		u64 rint_27:1;
+		u64 rint_26:1;
+		u64 rint_25:1;
+		u64 rint_24:1;
+		u64 asx1:1;
+		u64 asx0:1;
+		u64 rint_21:1;
+		u64 pip:1;
+		u64 spx1:1;
+		u64 spx0:1;
+		u64 lmc:1;
+		u64 l2c:1;
+		u64 rint_15:1;
+		u64 reserved_13_14:2;
+		u64 pow:1;
+		u64 tim:1;
+		u64 pko:1;
+		u64 ipd:1;
+		u64 rint_8:1;
+		u64 zip:1;
+		u64 dfa:1;
+		u64 fpa:1;
+		u64 key:1;
+		u64 npi:1;
+		u64 gmx1:1;
+		u64 gmx0:1;
+		u64 mio:1;
 	} s;
 	struct cvmx_npi_rsl_int_blocks_cn30xx {
-		uint64_t reserved_32_63:32;
-		uint64_t rint_31:1;
-		uint64_t iob:1;
-		uint64_t rint_29:1;
-		uint64_t rint_28:1;
-		uint64_t rint_27:1;
-		uint64_t rint_26:1;
-		uint64_t rint_25:1;
-		uint64_t rint_24:1;
-		uint64_t asx1:1;
-		uint64_t asx0:1;
-		uint64_t rint_21:1;
-		uint64_t pip:1;
-		uint64_t spx1:1;
-		uint64_t spx0:1;
-		uint64_t lmc:1;
-		uint64_t l2c:1;
-		uint64_t rint_15:1;
-		uint64_t rint_14:1;
-		uint64_t usb:1;
-		uint64_t pow:1;
-		uint64_t tim:1;
-		uint64_t pko:1;
-		uint64_t ipd:1;
-		uint64_t rint_8:1;
-		uint64_t zip:1;
-		uint64_t dfa:1;
-		uint64_t fpa:1;
-		uint64_t key:1;
-		uint64_t npi:1;
-		uint64_t gmx1:1;
-		uint64_t gmx0:1;
-		uint64_t mio:1;
+		u64 reserved_32_63:32;
+		u64 rint_31:1;
+		u64 iob:1;
+		u64 rint_29:1;
+		u64 rint_28:1;
+		u64 rint_27:1;
+		u64 rint_26:1;
+		u64 rint_25:1;
+		u64 rint_24:1;
+		u64 asx1:1;
+		u64 asx0:1;
+		u64 rint_21:1;
+		u64 pip:1;
+		u64 spx1:1;
+		u64 spx0:1;
+		u64 lmc:1;
+		u64 l2c:1;
+		u64 rint_15:1;
+		u64 rint_14:1;
+		u64 usb:1;
+		u64 pow:1;
+		u64 tim:1;
+		u64 pko:1;
+		u64 ipd:1;
+		u64 rint_8:1;
+		u64 zip:1;
+		u64 dfa:1;
+		u64 fpa:1;
+		u64 key:1;
+		u64 npi:1;
+		u64 gmx1:1;
+		u64 gmx0:1;
+		u64 mio:1;
 	} cn30xx;
 	struct cvmx_npi_rsl_int_blocks_cn38xx {
-		uint64_t reserved_32_63:32;
-		uint64_t rint_31:1;
-		uint64_t iob:1;
-		uint64_t rint_29:1;
-		uint64_t rint_28:1;
-		uint64_t rint_27:1;
-		uint64_t rint_26:1;
-		uint64_t rint_25:1;
-		uint64_t rint_24:1;
-		uint64_t asx1:1;
-		uint64_t asx0:1;
-		uint64_t rint_21:1;
-		uint64_t pip:1;
-		uint64_t spx1:1;
-		uint64_t spx0:1;
-		uint64_t lmc:1;
-		uint64_t l2c:1;
-		uint64_t rint_15:1;
-		uint64_t rint_14:1;
-		uint64_t rint_13:1;
-		uint64_t pow:1;
-		uint64_t tim:1;
-		uint64_t pko:1;
-		uint64_t ipd:1;
-		uint64_t rint_8:1;
-		uint64_t zip:1;
-		uint64_t dfa:1;
-		uint64_t fpa:1;
-		uint64_t key:1;
-		uint64_t npi:1;
-		uint64_t gmx1:1;
-		uint64_t gmx0:1;
-		uint64_t mio:1;
+		u64 reserved_32_63:32;
+		u64 rint_31:1;
+		u64 iob:1;
+		u64 rint_29:1;
+		u64 rint_28:1;
+		u64 rint_27:1;
+		u64 rint_26:1;
+		u64 rint_25:1;
+		u64 rint_24:1;
+		u64 asx1:1;
+		u64 asx0:1;
+		u64 rint_21:1;
+		u64 pip:1;
+		u64 spx1:1;
+		u64 spx0:1;
+		u64 lmc:1;
+		u64 l2c:1;
+		u64 rint_15:1;
+		u64 rint_14:1;
+		u64 rint_13:1;
+		u64 pow:1;
+		u64 tim:1;
+		u64 pko:1;
+		u64 ipd:1;
+		u64 rint_8:1;
+		u64 zip:1;
+		u64 dfa:1;
+		u64 fpa:1;
+		u64 key:1;
+		u64 npi:1;
+		u64 gmx1:1;
+		u64 gmx0:1;
+		u64 mio:1;
 	} cn38xx;
 	struct cvmx_npi_rsl_int_blocks_cn50xx {
-		uint64_t reserved_31_63:33;
-		uint64_t iob:1;
-		uint64_t lmc1:1;
-		uint64_t agl:1;
-		uint64_t reserved_24_27:4;
-		uint64_t asx1:1;
-		uint64_t asx0:1;
-		uint64_t reserved_21_21:1;
-		uint64_t pip:1;
-		uint64_t spx1:1;
-		uint64_t spx0:1;
-		uint64_t lmc:1;
-		uint64_t l2c:1;
-		uint64_t reserved_15_15:1;
-		uint64_t rad:1;
-		uint64_t usb:1;
-		uint64_t pow:1;
-		uint64_t tim:1;
-		uint64_t pko:1;
-		uint64_t ipd:1;
-		uint64_t reserved_8_8:1;
-		uint64_t zip:1;
-		uint64_t dfa:1;
-		uint64_t fpa:1;
-		uint64_t key:1;
-		uint64_t npi:1;
-		uint64_t gmx1:1;
-		uint64_t gmx0:1;
-		uint64_t mio:1;
+		u64 reserved_31_63:33;
+		u64 iob:1;
+		u64 lmc1:1;
+		u64 agl:1;
+		u64 reserved_24_27:4;
+		u64 asx1:1;
+		u64 asx0:1;
+		u64 reserved_21_21:1;
+		u64 pip:1;
+		u64 spx1:1;
+		u64 spx0:1;
+		u64 lmc:1;
+		u64 l2c:1;
+		u64 reserved_15_15:1;
+		u64 rad:1;
+		u64 usb:1;
+		u64 pow:1;
+		u64 tim:1;
+		u64 pko:1;
+		u64 ipd:1;
+		u64 reserved_8_8:1;
+		u64 zip:1;
+		u64 dfa:1;
+		u64 fpa:1;
+		u64 key:1;
+		u64 npi:1;
+		u64 gmx1:1;
+		u64 gmx0:1;
+		u64 mio:1;
 	} cn50xx;
 };

 union cvmx_pko_command_word0 {
-	uint64_t u64;
+	u64 u64;
 	struct {
-		uint64_t total_bytes:16;
-		uint64_t segs:6;
-		uint64_t dontfree:1;
-		uint64_t ignore_i:1;
-		uint64_t ipoffp1:7;
-		uint64_t gather:1;
-		uint64_t rsp:1;
-		uint64_t wqp:1;
-		uint64_t n2:1;
-		uint64_t le:1;
-		uint64_t reg0:11;
-		uint64_t subone0:1;
-		uint64_t reg1:11;
-		uint64_t subone1:1;
-		uint64_t size0:2;
-		uint64_t size1:2;
+		u64 total_bytes:16;
+		u64 segs:6;
+		u64 dontfree:1;
+		u64 ignore_i:1;
+		u64 ipoffp1:7;
+		u64 gather:1;
+		u64 rsp:1;
+		u64 wqp:1;
+		u64 n2:1;
+		u64 le:1;
+		u64 reg0:11;
+		u64 subone0:1;
+		u64 reg1:11;
+		u64 subone1:1;
+		u64 size0:2;
+		u64 size1:2;
 	} s;
 };

 union cvmx_ciu_timx {
-	uint64_t u64;
+	u64 u64;
 	struct cvmx_ciu_timx_s {
-		uint64_t reserved_37_63:27;
-		uint64_t one_shot:1;
-		uint64_t len:36;
+		u64 reserved_37_63:27;
+		u64 one_shot:1;
+		u64 len:36;
 	} s;
 };

 union cvmx_gmxx_rxx_rx_inbnd {
-	uint64_t u64;
+	u64 u64;
 	struct cvmx_gmxx_rxx_rx_inbnd_s {
-		uint64_t status:1;
-		uint64_t speed:2;
-		uint64_t duplex:1;
-		uint64_t reserved_4_63:60;
+		u64 status:1;
+		u64 speed:2;
+		u64 duplex:1;
+		u64 reserved_4_63:60;
 	} s;
 };

@@ -1194,12 +1194,12 @@ static inline void cvmx_fau_atomic_write32(enum cvmx_fau_reg_32 reg,
 					   int32_t value)
 { }

-static inline uint64_t cvmx_scratch_read64(uint64_t address)
+static inline u64 cvmx_scratch_read64(u64 address)
 {
 	return 0;
 }

-static inline void cvmx_scratch_write64(uint64_t address, uint64_t value)
+static inline void cvmx_scratch_write64(u64 address, u64 value)
 { }

 static inline int cvmx_wqe_get_grp(struct cvmx_wqe *work)
@@ -1207,7 +1207,7 @@ static inline int cvmx_wqe_get_grp(struct cvmx_wqe *work)
 	return 0;
 }

-static inline void *cvmx_phys_to_ptr(uint64_t physical_address)
+static inline void *cvmx_phys_to_ptr(u64 physical_address)
 {
 	return (void *)(uintptr_t)(physical_address);
 }
@@ -1230,12 +1230,12 @@ static inline int cvmx_helper_get_interface_index_num(int ipd_port)
 static inline void cvmx_fpa_enable(void)
 { }

-static inline uint64_t cvmx_read_csr(uint64_t csr_addr)
+static inline u64 cvmx_read_csr(u64 csr_addr)
 {
 	return 0;
 }

-static inline void cvmx_write_csr(uint64_t csr_addr, uint64_t val)
+static inline void cvmx_write_csr(u64 csr_addr, u64 val)
 { }

 static inline int cvmx_helper_setup_red(int pass_thresh, int drop_thresh)
@@ -1243,13 +1243,13 @@ static inline int cvmx_helper_setup_red(int pass_thresh, int drop_thresh)
 	return 0;
 }

-static inline void *cvmx_fpa_alloc(uint64_t pool)
+static inline void *cvmx_fpa_alloc(u64 pool)
 {
 	return NULL;
 }

-static inline void cvmx_fpa_free(void *ptr, uint64_t pool,
-				 uint64_t num_cache_lines)
+static inline void cvmx_fpa_free(void *ptr, u64 pool,
+				 u64 num_cache_lines)
 { }

 static inline int octeon_is_simulation(void)
@@ -1257,11 +1257,11 @@ static inline int octeon_is_simulation(void)
 	return 1;
 }

-static inline void cvmx_pip_get_port_status(uint64_t port_num, uint64_t clear,
+static inline void cvmx_pip_get_port_status(u64 port_num, u64 clear,
 					    cvmx_pip_port_status_t *status)
 { }

-static inline void cvmx_pko_get_port_status(uint64_t port_num, uint64_t clear,
+static inline void cvmx_pko_get_port_status(u64 port_num, u64 clear,
 					    cvmx_pko_port_status_t *status)
 { }

@@ -1362,12 +1362,12 @@ static inline struct cvmx_wqe *cvmx_pow_work_request_sync(cvmx_pow_wait_t wait)
 }

 static inline int cvmx_spi_restart_interface(int interface,
-					cvmx_spi_mode_t mode, int timeout)
+					     cvmx_spi_mode_t mode, int timeout)
 {
 	return 0;
 }

-static inline void cvmx_fau_async_fetch_and_add32(uint64_t scraddr,
+static inline void cvmx_fau_async_fetch_and_add32(u64 scraddr,
 						  enum cvmx_fau_reg_32 reg,
 						  int32_t value)
 { }
@@ -1380,12 +1380,12 @@ static inline union cvmx_gmxx_rxx_rx_inbnd cvmx_spi4000_check_speed(int interfac
 	return r;
 }

-static inline void cvmx_pko_send_packet_prepare(uint64_t port, uint64_t queue,
+static inline void cvmx_pko_send_packet_prepare(u64 port, u64 queue,
 						cvmx_pko_lock_t use_locking)
 { }

-static inline cvmx_pko_status_t cvmx_pko_send_packet_finish(uint64_t port,
-		uint64_t queue, union cvmx_pko_command_word0 pko_command,
+static inline cvmx_pko_status_t cvmx_pko_send_packet_finish(u64 port,
+		u64 queue, union cvmx_pko_command_word0 pko_command,
 		union cvmx_buf_ptr packet, cvmx_pko_lock_t use_locking)
 {
 	return 0;
@@ -1405,9 +1405,9 @@ static inline int cvmx_wqe_get_qos(struct cvmx_wqe *work)
 static inline void cvmx_wqe_set_grp(struct cvmx_wqe *work, int grp)
 { }

-static inline void cvmx_pow_work_submit(struct cvmx_wqe *wqp, uint32_t tag,
+static inline void cvmx_pow_work_submit(struct cvmx_wqe *wqp, u32 tag,
 					enum cvmx_pow_tag_type tag_type,
-					uint64_t qos, uint64_t grp)
+					u64 qos, u64 grp)
 { }

 #define CVMX_ASXX_RX_CLK_SETX(a, b)	((a) + (b))
--
2.43.0


