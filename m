Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55A1E807757
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 19:13:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442742AbjLFSNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 13:13:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378448AbjLFSNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 13:13:13 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB364122;
        Wed,  6 Dec 2023 10:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=I7ZFNkd8uHu9jhtoI/cVBVcr54rjvXscjk5fCGNHaqA=; b=hf0lLEXcVio6BQEPxuc2mIYkj6
        YhUjh+92ppTS/VIHbb83RYdnbipVQb6Ctt5l174DoqN2KBHJHvclLkxWcqjb+BMDM/maQGS1oVDst
        XeQaethSYjoVukrtTdDjIxtCRE3PUZep/aVerG4tsS0PmI+3FfP5ZvXgW+G7MyWLyp7+WuoO/bulE
        jnzZIOUSkiyUMRHbGz2yE9TqUjmuFUZ+SFnFCREyJGNkh122Rzjg8mE98PXQzJ2EIeYBtv0xYIV6V
        +G+RZf7SDzxPYr988LJtiAWMvcUWpCC/lwHZQ/wQyLCTRY8YSRJekjAtPGMki09wzr2mF1NpBeqwo
        2mi2FdHQ==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1rAwOc-00B0ny-1I;
        Wed, 06 Dec 2023 18:13:18 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Minda Chen <minda.chen@starfivetech.com>,
        Peter Chen <peter.chen@kernel.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Roger Quadros <rogerq@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Subject: [PATCH] usb: cdns3: starfive: don't misuse /** comment
Date:   Wed,  6 Dec 2023 10:13:17 -0800
Message-ID: <20231206181317.27515-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use a common C comment "/*" instead of "/**" to prevent a warning
from scripts/kernel-doc.

cdns3-starfive.c:23: warning: expecting prototype for cdns3(). Prototype was for USB_STRAP_HOST() instead

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Minda Chen <minda.chen@starfivetech.com>
Cc: Peter Chen <peter.chen@kernel.org>
Cc: Pawel Laszczak <pawell@cadence.com>
Cc: Roger Quadros <rogerq@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org
---
 drivers/usb/cdns3/cdns3-starfive.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/drivers/usb/cdns3/cdns3-starfive.c b/drivers/usb/cdns3/cdns3-starfive.c
--- a/drivers/usb/cdns3/cdns3-starfive.c
+++ b/drivers/usb/cdns3/cdns3-starfive.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/**
+/*
  * cdns3-starfive.c - StarFive specific Glue layer for Cadence USB Controller
  *
  * Copyright (C) 2023 StarFive Technology Co., Ltd.
