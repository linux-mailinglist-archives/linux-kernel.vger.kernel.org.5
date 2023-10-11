Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B49417C4C29
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 09:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345097AbjJKHnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 03:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344909AbjJKHnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 03:43:18 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C46892
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 00:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697010196; x=1728546196;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OQ+dgZ74uqSwdrdLrsBZLIN/BvRV6L3w906L1IfPAV8=;
  b=gXnnlnvwqBx9pS4ZtKEqn4I3A9vejzrwIrYP878iEc0o1dGt6nAglEsf
   sYxkFw4Hf9GBqKPyWD0ZyLFr26OR2+tCKXK2RC2BlvPpl0f4euUB7DGRa
   1nQvtw86gIRgpo/sn076HJ540au3RYKWRnSEfDsMj+YohXRqwU45uNAB4
   BOpKhB5+uVp8Hu7q1/Or8RXnWnlA4B/zfyUhxXJZLu783DYxZTmvXRA3O
   we7SP0Y1CrP0k2uxuzj2l9boSb9BPDKvEQgYOt/HqYEVV4zXwHcUVCw6s
   0+FGOC60toSbjVnNLwlxoqNDy/P8X6IPf/08qqy7pgrK6su9UvPs4hmWv
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="363960736"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="363960736"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 00:43:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="703627087"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="703627087"
Received: from twinkler-lnx.jer.intel.com ([10.12.231.216])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 00:43:14 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next 1/3] mei: docs: use correct structures name in kdoc
Date:   Wed, 11 Oct 2023 10:42:59 +0300
Message-ID: <20231011074301.223879-2-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231011074301.223879-1-tomas.winkler@intel.com>
References: <20231011074301.223879-1-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix misalignment between structures names and their kdoc in hw.h

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/hw.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/mei/hw.h b/drivers/misc/mei/hw.h
index e910302fcd1f6a28c13fa46c..3ad3080519c42521d8643396 100644
--- a/drivers/misc/mei/hw.h
+++ b/drivers/misc/mei/hw.h
@@ -429,7 +429,7 @@ struct mei_bus_message {
 } __packed;
 
 /**
- * struct hbm_cl_cmd - client specific host bus command
+ * struct mei_hbm_cl_cmd - client specific host bus command
  *	CONNECT, DISCONNECT, and FlOW CONTROL
  *
  * @hbm_cmd: bus message command header
@@ -733,7 +733,7 @@ struct hbm_dma_setup_response {
 } __packed;
 
 /**
- * struct mei_dma_ring_ctrl - dma ring control block
+ * struct hbm_dma_ring_ctrl - dma ring control block
  *
  * @hbuf_wr_idx: host circular buffer write index in slots
  * @reserved1: reserved for alignment
-- 
2.41.0

