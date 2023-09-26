Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3625D7AE79E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 10:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233900AbjIZIOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 04:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231398AbjIZIOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 04:14:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B92A6101
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 01:13:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87DD9C433C8;
        Tue, 26 Sep 2023 08:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695716034;
        bh=pKML1Q84Z5SEjVT09kSvwqPgs9xlFPfVVJN4cdzzSiI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=WTZoA1A8l5GpeHggQBfByHd8MQSCG+dENDaAe1zxWoBY1epfBYB/7vbP7rzTPeYOD
         EC83++RQYMu2YtgMQJIJ4FlscHLj/Pnx+KBJY7ZU1hYTYZQskF6W1xUE6jddFG2sil
         RjdI/NBF7VfPZKF+DF5kAAYwImHD7Cp3BWh56L2eg3ial5iARtjJCojyVxWf+2pgOC
         VMC8tf3O9rncz8iS4uUb2PorvgNYXjFi04o0iwlGENge74rpp9Yb+sNlRLj2ngYXLg
         nROBqpk5n9J7/Z1XMUmzjfgbKA1idMdZaSLB5DlKyjCDcNC09aaUBSjGHWlIZkOHVX
         wnLlzppIhj9kw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/9] accel/habanalabs/gaudi: remove unused structure definition
Date:   Tue, 26 Sep 2023 11:13:40 +0300
Message-Id: <20230926081345.240927-4-ogabbay@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230926081345.240927-1-ogabbay@kernel.org>
References: <20230926081345.240927-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct gaudi_nic_status is not used anywhere in the code.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../habanalabs/include/gaudi/gaudi_fw_if.h    | 32 -------------------
 1 file changed, 32 deletions(-)

diff --git a/drivers/accel/habanalabs/include/gaudi/gaudi_fw_if.h b/drivers/accel/habanalabs/include/gaudi/gaudi_fw_if.h
index 2dba02757d37..a2547f306750 100644
--- a/drivers/accel/habanalabs/include/gaudi/gaudi_fw_if.h
+++ b/drivers/accel/habanalabs/include/gaudi/gaudi_fw_if.h
@@ -44,38 +44,6 @@ struct eq_nic_sei_event {
 	__u8 pad[6];
 };
 
-/*
- * struct gaudi_nic_status - describes the status of a NIC port.
- * @port: NIC port index.
- * @bad_format_cnt: e.g. CRC.
- * @responder_out_of_sequence_psn_cnt: e.g NAK.
- * @high_ber_reinit_cnt: link reinit due to high BER.
- * @correctable_err_cnt: e.g. bit-flip.
- * @uncorrectable_err_cnt: e.g. MAC errors.
- * @retraining_cnt: re-training counter.
- * @up: is port up.
- * @pcs_link: has PCS link.
- * @phy_ready: is PHY ready.
- * @auto_neg: is Autoneg enabled.
- * @timeout_retransmission_cnt: timeout retransmission events
- * @high_ber_cnt: high ber events
- */
-struct gaudi_nic_status {
-	__u32 port;
-	__u32 bad_format_cnt;
-	__u32 responder_out_of_sequence_psn_cnt;
-	__u32 high_ber_reinit;
-	__u32 correctable_err_cnt;
-	__u32 uncorrectable_err_cnt;
-	__u32 retraining_cnt;
-	__u8 up;
-	__u8 pcs_link;
-	__u8 phy_ready;
-	__u8 auto_neg;
-	__u32 timeout_retransmission_cnt;
-	__u32 high_ber_cnt;
-};
-
 struct gaudi_cold_rst_data {
 	union {
 		struct {
-- 
2.34.1

