Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCE07C6304
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 04:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235271AbjJLCtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 22:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233040AbjJLCsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 22:48:50 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DDD0A9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 19:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Yb5CBcs4CyLblxAoti7+1MYNpg3eCp5q8/+sl9+Lqhw=; b=EDSm8e6oxKRUApFxXxfaQvvJeq
        Lnx6HKfFEw7W4pDYAr4zVdpWDiWrE4iiwsTOzzMvAOSPwC3t+DUi10/0iqgP8ofk+tsCOBQDHQG+X
        X09l3xja0ybA42HZW4mxcVPqOz6lGYR3H0rGtfdc2Ivojo9rI98qFJfgcp+bhIVmsnXp1NnsemvI0
        mAmp6DiFi+KJH91yg1boarQGYzGxziBMt7LKhy414uljQpFOBbWvfGAzgkq2Xkr9T/ZsJr+wgfUq8
        1thBPITJD59yGtbRCMR2B1NIHUWGfAzJo0z5TOYGKc5CcWW3sj7nmOWc9lLf0JgEjBHciOjppopOe
        I5gEWk2A==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qqlkl-00HDiv-3C;
        Thu, 12 Oct 2023 02:48:48 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 1/7] misc: mei: hw.h: fix kernel-doc warnings
Date:   Wed, 11 Oct 2023 19:48:39 -0700
Message-ID: <20231012024845.29169-2-rdunlap@infradead.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231012024845.29169-1-rdunlap@infradead.org>
References: <20231012024845.29169-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix kernel-doc warnings in hw.h:

hw.h:809: warning: missing initial short description on line:
 * struct hbm_client_dma_unmap_request
hw.h:812: warning: contents before sections
hw.h:825: warning: missing initial short description on line:
 * struct hbm_client_dma_response
hw.h:828: warning: contents before sections

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Tomas Winkler <tomas.winkler@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/misc/mei/hw.h |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff -- a/drivers/misc/mei/hw.h b/drivers/misc/mei/hw.h
--- a/drivers/misc/mei/hw.h
+++ b/drivers/misc/mei/hw.h
@@ -806,8 +806,8 @@ struct hbm_client_dma_map_request {
 } __packed;
 
 /**
- * struct hbm_client_dma_unmap_request
- *    client dma unmap request from the host to the firmware
+ * struct hbm_client_dma_unmap_request - client dma unmap request
+ *        from the host to the firmware
  *
  * @hbm_cmd: bus message command header
  * @status: unmap status
@@ -822,8 +822,8 @@ struct hbm_client_dma_unmap_request {
 } __packed;
 
 /**
- * struct hbm_client_dma_response
- *   client dma unmap response from the firmware to the host
+ * struct hbm_client_dma_response - client dma unmap response
+ *        from the firmware to the host
  *
  * @hbm_cmd: bus message command header
  * @status: command status
