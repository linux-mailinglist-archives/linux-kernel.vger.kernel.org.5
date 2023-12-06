Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0508066E8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 07:01:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376864AbjLFF7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 00:59:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376768AbjLFF73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 00:59:29 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F36C71A5
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 21:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=2RhN/R0YtQaRZfvdX9T+5bKdAJ94ubAzV2OGwtbT7fA=; b=hsHYmFgDYL2PjaTEKgfj9KAeOF
        ri4R7T/MbVbm+8WsHaq0dgIfH5ohWwJLtHPZABjUUmVOCXDz3BhegPiW06ZC3BcJC3I4MU9n9BlOF
        OhqHFUzh57RiTS79yYMqNEKmuU98ghwcYCVw88i4UcDJl5bMM59SnTmKtcjWRxqW/zPPtYeGlqwTE
        cbr8uFGYK1DDWAmCWp0z/4B8YFFD/bcnYVrr3GNvfTn4QxztS0bGHharOHdnX1RjUoL/hC2FQ+tyx
        0E9v7XAXFboV5nZkeKvQyZo1dvBQjgLC9TXMGsmZQWa++yT8k5QXlYxHVE6vqv4fMO7S+GY+JvyT6
        pGbTlr/g==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1rAkwZ-0098zJ-0w;
        Wed, 06 Dec 2023 05:59:35 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>, Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, ntb@lists.linux.dev
Subject: [PATCH] NTB: epf: don't misuse kernel-doc marker
Date:   Tue,  5 Dec 2023 21:59:34 -0800
Message-ID: <20231206055934.24079-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use "/*" instead of "/**" for common C comments to prevent warnings
from scripts/kernel-doc.

ntb_hw_epf.c:15: warning: expecting prototype for Host side endpoint driver to implement Non(). Prototype was for NTB_EPF_COMMAND() instead

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jon Mason <jdmason@kudzu.us>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Allen Hubbe <allenbh@gmail.com>
Cc: ntb@lists.linux.dev
---
 drivers/ntb/hw/epf/ntb_hw_epf.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
--- a/drivers/ntb/hw/epf/ntb_hw_epf.c
+++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/**
+/*
  * Host side endpoint driver to implement Non-Transparent Bridge functionality
  *
  * Copyright (C) 2020 Texas Instruments
