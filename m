Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23A2D7C630A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 04:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376906AbjJLCtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 22:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347031AbjJLCsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 22:48:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFAF6B8
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 19:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=dn2C8Cozz71rqs8hddppMfXGl+lEpmcUyGJqY+sycQI=; b=QbqT7uTe+dPHV0Gc8HjekXUwO+
        bDNqag6u+9GjHNEkxuLv4+j8oTQSj95QeU66ghLTOu7HcwvFCenT2uAp8Lf1X6D9IF1MyskYAj1l5
        Fn6hc3iK9rvM76LBGwk9KXOj1TeMN4YzP9+JO+P2xTKnGwznl9t5egRIzYcIjxE/hoENnB3WSN4/c
        e1EGgUjayliAYviLavQhebu7B5nl5odvNuquLjHWJlQD3RhHUDAFDzgvqFAxRwGIviSBjR/8AgVfe
        vB6UWitbRXt4wDUQa4gd9bTw1PU7OwEBrNKI5U75Zx2VsWoBoWUJtL45C4ZhIU2U1QOnFaFmvQ3fl
        y6ypWP2w==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qqlkm-00HDiv-1z;
        Thu, 12 Oct 2023 02:48:48 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 4/7] misc: mei: hbm.c: fix kernel-doc warnings
Date:   Wed, 11 Oct 2023 19:48:42 -0700
Message-ID: <20231012024845.29169-5-rdunlap@infradead.org>
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

Fix kernel-doc warnings in hbm.c:

hbm.c:98: warning: No description found for return value of 'mei_hbm_write_message'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Tomas Winkler <tomas.winkler@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/misc/mei/hbm.c |    2 ++
 1 file changed, 2 insertions(+)

diff -- a/drivers/misc/mei/hbm.c b/drivers/misc/mei/hbm.c
--- a/drivers/misc/mei/hbm.c
+++ b/drivers/misc/mei/hbm.c
@@ -91,6 +91,8 @@ static int mei_cl_conn_status_to_errno(e
  * @dev: mei device
  * @hdr: mei header
  * @data: payload
+ *
+ * Return: >=0 on success, <0 on error
  */
 static inline int mei_hbm_write_message(struct mei_device *dev,
 					struct mei_msg_hdr *hdr,
