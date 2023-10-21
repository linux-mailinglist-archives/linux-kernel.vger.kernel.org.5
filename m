Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01BF97D1BB9
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 10:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjJUIOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 04:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjJUIOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 04:14:17 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7022AD51
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 01:14:15 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-507b18cf2e1so2061931e87.3
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 01:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697876053; x=1698480853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LaDo/AZ5mJWewExa2Fcx3J0s43X77Y2qHgqBC0tZ0hA=;
        b=ITXuV+YbuPHWMU99TgBAdJVtjx9kfc876msKQUOKj9/qfqHjq6WjtyIVS6bju+dCl3
         FE3PmDwfy6SSk3/hnF90j3MR7p1d2Sh/rG5MhA/GTTJLoj0ocjJ/2VpOUGI2pLvVKsPF
         xnFIlnL0ryOUnBRrg6cCvfGJmkOJnQRVt3klECrBeMlRcvavv8ceOpq3iBb6eeMuNfrp
         fFkHaZmmTGf3i9onigmIGOsI7wEfnOO0j/CAYi1S08mMGL7i6Uy+JkRElu57aSuKkOKa
         43THauxwVpxTsYAz1Cq/G+HGxgAD+9UXSs67JjR/AS1dDSVxbMpia2ExuffFHHocTp4e
         MijQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697876053; x=1698480853;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LaDo/AZ5mJWewExa2Fcx3J0s43X77Y2qHgqBC0tZ0hA=;
        b=f4H/nAzBwnQPAn+AvFQiJje7n0dbrG7hHv5vHvEgkXCPAgJE3prJO6ZTCEubiR5gH0
         UlwC1uWXQhclzTNMoFrLGYGVKKOzBjvaDvUJfz0WV6SC+Qgul4Q0uJBgFVGvi0fRT04S
         SUfR2Jon2SoYXtp6jVFzpoJ+o/kIUaTx7kq9YNXwXdVHQCwyEEYpPfiGej8y2Zx5DPm6
         YjdAuW4F2p0+6qyQQZ7UONgHpzcaE3Udk83n0BCLNPBrnCCX72dlq/UYbStoM2zDsq/c
         MvBVt7UghYVM1MGEdUYwheI41NYh9FyVZwO1UBI5xROi7ZfD0s1ZFNMv9woxloFbPSCv
         O5Tg==
X-Gm-Message-State: AOJu0YwRTXf7A3qMeJNKzo5kBN73+9NWnFiP3DnoAjSbteeCavpKMnFn
        sOG8au0FY8LtF/uAhR4odSc=
X-Google-Smtp-Source: AGHT+IG58GhLl+DVJffOlmgFsXvV8PN8lOzKaHYt9JVjcH/pk3phh8kifiJg2rc7Jb/NDiW2vj01ag==
X-Received: by 2002:ac2:43ab:0:b0:502:fe11:a68f with SMTP id t11-20020ac243ab000000b00502fe11a68fmr3152581lfl.28.1697876053334;
        Sat, 21 Oct 2023 01:14:13 -0700 (PDT)
Received: from HP-ENVY-Notebook.lan (81-229-94-10-no68.tbcn.telia.com. [81.229.94.10])
        by smtp.googlemail.com with ESMTPSA id g9-20020a056512118900b004fe2a7a2ee2sm755619lfr.160.2023.10.21.01.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Oct 2023 01:14:12 -0700 (PDT)
From:   Jonathan Bergh <bergh.jonathan@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jonathan Bergh <bergh.jonathan@gmail.com>
Subject: [PATCH] staging: octeon: Fix warnings due to introduction of new typedefs
Date:   Sat, 21 Oct 2023 10:14:09 +0200
Message-Id: <20231021081409.67570-1-bergh.jonathan@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes warnings relating to introduction of new typedefs in the
octeon driver. The following changes are made:
 * Update the existing enum and struct definitions to remove the typedefs
 * Update the inline and remaining function implementations to remove
   the typedefs

Signed-off-by: Jonathan Bergh <bergh.jonathan@gmail.com>
---
 drivers/staging/octeon/ethernet.c     |  6 ++--
 drivers/staging/octeon/octeon-stubs.h | 48 +++++++++++++--------------
 2 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/drivers/staging/octeon/ethernet.c b/drivers/staging/octeon/ethernet.c
index 9eee28f2940c..8e1f4b987a25 100644
--- a/drivers/staging/octeon/ethernet.c
+++ b/drivers/staging/octeon/ethernet.c
@@ -201,8 +201,8 @@ EXPORT_SYMBOL(cvm_oct_free_work);
  */
 static struct net_device_stats *cvm_oct_common_get_stats(struct net_device *dev)
 {
-	cvmx_pip_port_status_t rx_status;
-	cvmx_pko_port_status_t tx_status;
+	struct cvmx_pip_port_status rx_status;
+	struct cvmx_pko_port_status tx_status;
 	struct octeon_ethernet *priv = netdev_priv(dev);
 
 	if (priv->port < CVMX_PIP_NUM_INPUT_PORTS) {
@@ -798,7 +798,7 @@ static int cvm_oct_probe(struct platform_device *pdev)
 
 	num_interfaces = cvmx_helper_get_number_of_interfaces();
 	for (interface = 0; interface < num_interfaces; interface++) {
-		cvmx_helper_interface_mode_t imode =
+		enum cvmx_helper_interface_mode imode =
 		    cvmx_helper_interface_get_mode(interface);
 		int num_ports = cvmx_helper_ports_on_interface(interface);
 		int port;
diff --git a/drivers/staging/octeon/octeon-stubs.h b/drivers/staging/octeon/octeon-stubs.h
index 3e7b92cd2e35..cf7f77061eb9 100644
--- a/drivers/staging/octeon/octeon-stubs.h
+++ b/drivers/staging/octeon/octeon-stubs.h
@@ -213,14 +213,14 @@ enum cvmx_fau_op_size {
 	CVMX_FAU_OP_SIZE_64 = 3
 };
 
-typedef enum {
+enum cvmx_spi_mode {
 	CVMX_SPI_MODE_UNKNOWN = 0,
 	CVMX_SPI_MODE_TX_HALFPLEX = 1,
 	CVMX_SPI_MODE_RX_HALFPLEX = 2,
 	CVMX_SPI_MODE_DUPLEX = 3
-} cvmx_spi_mode_t;
+};
 
-typedef enum {
+enum cvmx_helper_interface_mode {
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
+enum cvmx_pow_wait {
 	CVMX_POW_WAIT = 1,
 	CVMX_POW_NO_WAIT = 0,
-} cvmx_pow_wait_t;
+};
 
-typedef enum {
+enum cvmx_pko_lock {
 	CVMX_PKO_LOCK_NONE = 0,
 	CVMX_PKO_LOCK_ATOMIC_TAG = 1,
 	CVMX_PKO_LOCK_CMD_QUEUE = 2,
-} cvmx_pko_lock_t;
+};
 
-typedef enum {
+enum cvmx_pko_status {
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
+struct cvmx_pip_port_status {
 	uint32_t dropped_octets;
 	uint32_t dropped_packets;
 	uint32_t pci_raw_packets;
@@ -407,13 +407,13 @@ typedef struct {
 	uint32_t inb_packets;
 	uint64_t inb_octets;
 	uint16_t inb_errors;
-} cvmx_pip_port_status_t;
+};
 
-typedef struct {
+struct cvmx_pko_port_status {
 	uint32_t packets;
 	uint64_t octets;
 	uint64_t doorbell;
-} cvmx_pko_port_status_t;
+};
 
 union cvmx_pip_frm_len_chkx {
 	uint64_t u64;
@@ -1258,14 +1258,14 @@ static inline int octeon_is_simulation(void)
 }
 
 static inline void cvmx_pip_get_port_status(uint64_t port_num, uint64_t clear,
-					    cvmx_pip_port_status_t *status)
+					    struct cvmx_pip_port_status *status)
 { }
 
 static inline void cvmx_pko_get_port_status(uint64_t port_num, uint64_t clear,
-					    cvmx_pko_port_status_t *status)
+					    struct cvmx_pko_port_status *status)
 { }
 
-static inline cvmx_helper_interface_mode_t cvmx_helper_interface_get_mode(int
+static inline enum cvmx_helper_interface_mode cvmx_helper_interface_get_mode(int
 								   interface)
 {
 	return 0;
@@ -1342,11 +1342,11 @@ static inline unsigned int cvmx_get_core_num(void)
 }
 
 static inline void cvmx_pow_work_request_async_nocheck(int scr_addr,
-						       cvmx_pow_wait_t wait)
+						       enum cvmx_pow_wait wait)
 { }
 
 static inline void cvmx_pow_work_request_async(int scr_addr,
-					       cvmx_pow_wait_t wait)
+					       enum cvmx_pow_wait wait)
 { }
 
 static inline struct cvmx_wqe *cvmx_pow_work_response_async(int scr_addr)
@@ -1356,13 +1356,13 @@ static inline struct cvmx_wqe *cvmx_pow_work_response_async(int scr_addr)
 	return wqe;
 }
 
-static inline struct cvmx_wqe *cvmx_pow_work_request_sync(cvmx_pow_wait_t wait)
+static inline struct cvmx_wqe *cvmx_pow_work_request_sync(enum cvmx_pow_wait wait)
 {
 	return (void *)(unsigned long)wait;
 }
 
 static inline int cvmx_spi_restart_interface(int interface,
-					cvmx_spi_mode_t mode, int timeout)
+					enum cvmx_spi_mode mode, int timeout)
 {
 	return 0;
 }
@@ -1381,12 +1381,12 @@ static inline union cvmx_gmxx_rxx_rx_inbnd cvmx_spi4000_check_speed(int interfac
 }
 
 static inline void cvmx_pko_send_packet_prepare(uint64_t port, uint64_t queue,
-						cvmx_pko_lock_t use_locking)
+						enum cvmx_pko_lock use_locking)
 { }
 
-static inline cvmx_pko_status_t cvmx_pko_send_packet_finish(uint64_t port,
+static inline enum cvmx_pko_status cvmx_pko_send_packet_finish(uint64_t port,
 		uint64_t queue, union cvmx_pko_command_word0 pko_command,
-		union cvmx_buf_ptr packet, cvmx_pko_lock_t use_locking)
+		union cvmx_buf_ptr packet, enum cvmx_pko_lock use_locking)
 {
 	return 0;
 }
-- 
2.40.1

