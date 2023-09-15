Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DFD87A2348
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 18:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235486AbjIOQIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 12:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235818AbjIOQHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 12:07:45 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D056CC
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 09:07:40 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-4047ef37f55so1659865e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 09:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694794059; x=1695398859; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z8+9VTkbBAtEYZ5WKhgH4h5UYlHRNkMT6NJfQFUOH+k=;
        b=Z34zDam7CwwkeIJii0YB8uumRYArpS7CoXZUi1vV9nC3kPhhitB6Ww0Id4+XORpiyH
         0QrJG4WSlGqXlOcHneTuqWnMfMBMwLNDCJOwcYHpd6qT0AZh4YHIDygmClZ3LKeNjzDD
         cxSO48blGwKKdOLMkcq+Jti3W3Nh74h7GUE9OpvLY9UWZFonJmaC3uCqUfPDa1OIcxCq
         e1H9oqwW7UQ85Dm9B3CNVYiNY4f/C+ZUYMPMODwqx5if6FlJHfHc3yQflf9Y77FuXO8B
         y/dYzWX9E9XYHVxxEVSgPdIplm0JrBw6WGVGmUXGGzBoEbz/9woZcxcgIBDOOFzUb2z8
         zIuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694794059; x=1695398859;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z8+9VTkbBAtEYZ5WKhgH4h5UYlHRNkMT6NJfQFUOH+k=;
        b=Yg/OaGreeY4vvnvk8v4szixF8syw9VSNLkstyb/I7nKwc4VYaOb3B9qsowijOkUY3s
         fGCM9j2dezDSA7qsGG3ajSyrtGSn312sj0hYIKGq/I2mLWHig76RFgzNa9rQfWHD1z4V
         R43bEXMB6FqQjm7wZDlTf1VNShIpisTKqji8rbGZbU6OJB3uEOnKA/zl/d6czg/LCocf
         HxX8MjmAyVUXPUnzJXc02wwtpwCIrZ00gFRO8aKaxNkBR29Vv+20tyQ9upGqlAZlvieB
         rIqJzFPZ5BxDwMEUZMJgal16JfndMpDFfiXvzEMhnrgiykPh7HWAUj4hakrZAGniV3DW
         ZzKg==
X-Gm-Message-State: AOJu0YycvZS7VUv5qcEvEaDlBmXfvbbhCmxPiFOJC9p0lOmMcHfPaRrm
        /jpQL9LgcJPUy6Z8EJIayxreqpmob9lqfw==
X-Google-Smtp-Source: AGHT+IEMz0Cuk/KznlLMCr55N+i+cr7n6FnthXKQ62l7UkydGt9f+g5SOG+eXXcHV0qRuXdChPvEkg==
X-Received: by 2002:a7b:cd91:0:b0:3fe:d46a:ef4b with SMTP id y17-20020a7bcd91000000b003fed46aef4bmr1918796wmj.1.1694794058704;
        Fri, 15 Sep 2023 09:07:38 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id k8-20020a5d4288000000b00317a29af4b2sm4761826wrq.68.2023.09.15.09.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 09:07:38 -0700 (PDT)
Date:   Fri, 15 Sep 2023 18:07:36 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 07/16] staging: rtl8192e: Remove unused struct rtllib_hdr and
 two enums
Message-ID: <4bdb5e4d604eb3bd46c7853ad6d9a60f6208dd4a.1694792595.git.philipp.g.hortmann@gmail.com>
References: <cover.1694792595.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1694792595.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove struct rtllib_hdr, enum rt_ps_mode and enum fw_cmd_io_type as those
are not used.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtllib.h | 40 -------------------------------
 1 file changed, 40 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 55f96f446f9e..717b74dc005d 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -679,12 +679,6 @@ struct rtllib_pspoll_hdr {
 	u8 ta[ETH_ALEN];
 } __packed;
 
-struct rtllib_hdr {
-	__le16 frame_ctl;
-	__le16 duration_id;
-	u8 payload[];
-} __packed;
-
 struct rtllib_hdr_4addr {
 	__le16 frame_ctl;
 	__le16 duration_id;
@@ -1157,13 +1151,6 @@ enum fsync_state {
 	SW_Fsync
 };
 
-enum rt_ps_mode {
-	eActive,
-	eMaxPs,
-	eFastPs,
-	eAutoPs,
-};
-
 enum ips_callback_function {
 	IPS_CALLBACK_NONE = 0,
 	IPS_CALLBACK_MGNT_LINK_REQUEST = 1,
@@ -1220,33 +1207,6 @@ enum scan_op_backup_opt {
 	SCAN_OPT_MAX
 };
 
-enum fw_cmd_io_type {
-	FW_CMD_DIG_ENABLE = 0,
-	FW_CMD_DIG_DISABLE = 1,
-	FW_CMD_DIG_HALT = 2,
-	FW_CMD_DIG_RESUME = 3,
-	FW_CMD_HIGH_PWR_ENABLE = 4,
-	FW_CMD_HIGH_PWR_DISABLE = 5,
-	FW_CMD_RA_RESET = 6,
-	FW_CMD_RA_ACTIVE = 7,
-	FW_CMD_RA_REFRESH_N = 8,
-	FW_CMD_RA_REFRESH_BG = 9,
-	FW_CMD_RA_INIT = 10,
-	FW_CMD_IQK_ENABLE = 11,
-	FW_CMD_TXPWR_TRACK_ENABLE = 12,
-	FW_CMD_TXPWR_TRACK_DISABLE = 13,
-	FW_CMD_TXPWR_TRACK_THERMAL = 14,
-	FW_CMD_PAUSE_DM_BY_SCAN = 15,
-	FW_CMD_RESUME_DM_BY_SCAN = 16,
-	FW_CMD_RA_REFRESH_N_COMB = 17,
-	FW_CMD_RA_REFRESH_BG_COMB = 18,
-	FW_CMD_ANTENNA_SW_ENABLE = 19,
-	FW_CMD_ANTENNA_SW_DISABLE = 20,
-	FW_CMD_TX_FEEDBACK_CCX_ENABLE = 21,
-	FW_CMD_LPS_ENTER = 22,
-	FW_CMD_LPS_LEAVE = 23,
-};
-
 #define RT_MAX_LD_SLOT_NUM	10
 struct rt_link_detect {
 	u32				NumRecvBcnInPeriod;
-- 
2.42.0

