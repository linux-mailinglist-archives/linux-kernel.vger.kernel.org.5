Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A92377C247
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 23:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232801AbjHNVOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 17:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232871AbjHNVN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 17:13:58 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F73F127
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 14:13:57 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1bc0d39b52cso29208205ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 14:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=threespeedlogic-com.20221208.gappssmtp.com; s=20221208; t=1692047637; x=1692652437;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=80RjFn6Vs8u8C6d+eamI1sRVJOT4DD9HBYJK0U871ow=;
        b=StSdRI130g5YWhrnuDlHl0WSQSZtyttN930OjRq2q2C7omUGsABBKtEmy8LEpdiLjo
         MBfF66CDtQU4A0uwgYCcUluKvFWGuw2TnCCIw77DOVtyuSANpvJhVHMdbGpleW6uI4im
         CMlW/WvXQPo/f+8IsTS3oL0dI++KMzrsQ/swAhe4oO8PR7D0z2Zjfiop6ScaZZD5DzcN
         Mxa891E/WSBVg0RA5/QKMsJc9i1GpdG7sYj2iD4xVK9O2p9/6J7zdBrfdaAbT/b0Vr6A
         DTs8zDnEbrr5p0+m/j5D+WPCrvBshVMrO4QwxmV/XeS6k+85VO/KMewzvvuW3chBuYb2
         SLtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692047637; x=1692652437;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=80RjFn6Vs8u8C6d+eamI1sRVJOT4DD9HBYJK0U871ow=;
        b=bBAVyzeUVohlsHtUyELwg6VPBbfgwSrLhgNdg0+Zj9bnRf+57vh5FvR7QK8dTbThcM
         b8hYhhgmE1lG24ss5B6v1+LEcWvBhC6hptHv/AnY6Gv4jp2MHBEyjfFAPTRQLQWx3KT2
         VAMVWXwBJfE0gdl7O8KnIpx3RHB4nrskTyo5aAFUVFz5ZRu5+IFRihn9VHIvc1V421kT
         5pMZiPpZKoiLdY3rHmbo1S1mzd1CLaAJWu1ISp4pLOvmjjdxo/sniITrfp7Tnfk1eaZJ
         pS3k0aK8I2eOliK1qhIhpFAntD20vAAONzKF/sp9va9gHdutS2fD2TOa9YTjgGLxCMrw
         AqDw==
X-Gm-Message-State: AOJu0YzgtkuYkKgN0tdv7xsRUAvSO5NM2nVxYgX4sH/2vHd5rey/nxdE
        FsEz9zxjPkHSKOcFPW0R6BluHg==
X-Google-Smtp-Source: AGHT+IGOpMNm/sFxLM9qPUz/M8y/sfURY5LBtA4luqBBp8PXIzJ+pHW/oT8tTEI0HMoOnks8NT42hg==
X-Received: by 2002:a17:902:b907:b0:1bb:1523:b2d7 with SMTP id bf7-20020a170902b90700b001bb1523b2d7mr9167832plb.14.1692047636829;
        Mon, 14 Aug 2023 14:13:56 -0700 (PDT)
Received: from localhost.localdomain (d205-250-120-28.bchsia.telus.net. [205.250.120.28])
        by smtp.gmail.com with ESMTPSA id u18-20020a17090341d200b001b05e96d859sm9894883ple.135.2023.08.14.14.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 14:13:56 -0700 (PDT)
From:   Graeme Smecher <gsmecher@threespeedlogic.com>
Cc:     Graeme Smecher <gsmecher@threespeedlogic.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Shay Agroskin <shayagr@amazon.com>,
        Rob Herring <robh@kernel.org>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Marek Majtyka <alardam@gmail.com>, linux-omap@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] net: ti/cpsw_new: Expose the same module parameters as ti/cpsw.
Date:   Mon, 14 Aug 2023 14:13:21 -0700
Message-Id: <20230814211323.3272487-1-gsmecher@threespeedlogic.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "old" CPSW driver (cpsw.c) exports the following module parameters:

	- ti_cpsw.debug_level
	- ti_cpsw.ale_ageout
	- ti_cpsw.rx_packet_max
	- ti_cpsw.descs_pool_size

This patch exposes the same parameters for the "new" CPSW driver:

	- ti_cpsw_new.debug_level
	- ti_cpsw_new.ale_ageout
	- ti_cpsw_new.rx_packet_max
	- ti_cpsw_new.descs_pool_size

It seems like consistency between the two drivers is a reasonable goal.

Signed-off-by: Graeme Smecher <gsmecher@threespeedlogic.com>
---
 drivers/net/ethernet/ti/cpsw_new.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/ethernet/ti/cpsw_new.c b/drivers/net/ethernet/ti/cpsw_new.c
index c61e4e44a78f..6d05ec288792 100644
--- a/drivers/net/ethernet/ti/cpsw_new.c
+++ b/drivers/net/ethernet/ti/cpsw_new.c
@@ -45,9 +45,20 @@
 #include <net/pkt_sched.h>
 
 static int debug_level;
+module_param(debug_level, int, 0);
+MODULE_PARM_DESC(debug_level, "cpsw debug level (NETIF_MSG bits)");
+
 static int ale_ageout = CPSW_ALE_AGEOUT_DEFAULT;
+module_param(ale_ageout, int, 0);
+MODULE_PARM_DESC(ale_ageout, "cpsw ale ageout interval (seconds)");
+
 static int rx_packet_max = CPSW_MAX_PACKET_SIZE;
+module_param(rx_packet_max, int, 0);
+MODULE_PARM_DESC(rx_packet_max, "maximum receive packet size (bytes)");
+
 static int descs_pool_size = CPSW_CPDMA_DESCS_POOL_SIZE_DEFAULT;
+module_param(descs_pool_size, int, 0444);
+MODULE_PARM_DESC(descs_pool_size, "Number of CPDMA CPPI descriptors in pool");
 
 struct cpsw_devlink {
 	struct cpsw_common *cpsw;
-- 
2.39.2

