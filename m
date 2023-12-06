Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F358B8066E4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 07:01:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376779AbjLFF6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 00:58:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376863AbjLFF6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 00:58:16 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 749EBD49
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 21:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=d3EMvhOd/gkgySUbvhifBSOZgHXqJpdkJdfMLFJiduw=; b=ck/rQmiZQL2DrfqNtfcK28gLF7
        E7hHCqXBCO0GytNzNvuMCq4St+7MfGB2Ca3zot1qt6d2yClAob28r2Vuy/CDJHyOCzUkUmLQaPRPI
        47S8JcskLx3RFrhIwc/kq+1bfypx8EeqJU9xADLyuot6X+MR02c3i8jSBm96Xcux1XKr6ANXm45Pm
        SnrKtYturV8P3RevMoXfFuGajDm51o3buUEuc7izCVYgBh+N+Q4SF5apPk2LM+I7iqXUFr/TXd2oP
        bp5aDzTtC1fnjKE8c9DSU5tnoHjtgk6pNPDA3y9JI0tv78i+sDa9wgE42xDPRhFhkqgQmdX31AkGp
        g6qJEIMw==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1rAkvN-0098pS-33;
        Wed, 06 Dec 2023 05:58:21 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Johannes Thumshirn <morbidrsa@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] mcb: core: fix kernel-doc warnings
Date:   Tue,  5 Dec 2023 21:58:21 -0800
Message-ID: <20231206055821.17284-1-rdunlap@infradead.org>
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

Correct function comments to prevent warnings from
scripts/kernel-doc.

mcb-core.c:270: warning: Function parameter or member 'carrier' not described in 'mcb_alloc_bus'
mcb-core.c:336: warning: expecting prototype for mcb_bus_put(). Prototype was for mcb_bus_get() instead
mcb-core.c:463: warning: Function parameter or member 'mem' not described in 'mcb_release_mem'
mcb-core.c:463: warning: Excess function parameter 'dev' description in 'mcb_release_mem'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Johannes Thumshirn <morbidrsa@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mcb/mcb-core.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff -- a/drivers/mcb/mcb-core.c b/drivers/mcb/mcb-core.c
--- a/drivers/mcb/mcb-core.c
+++ b/drivers/mcb/mcb-core.c
@@ -263,6 +263,7 @@ static void mcb_free_bus(struct device *
 
 /**
  * mcb_alloc_bus() - Allocate a new @mcb_bus
+ * @carrier: generic &struct device for the carrier device
  *
  * Allocate a new @mcb_bus.
  */
@@ -327,7 +328,7 @@ void mcb_release_bus(struct mcb_bus *bus
 EXPORT_SYMBOL_NS_GPL(mcb_release_bus, MCB);
 
 /**
- * mcb_bus_put() - Increment refcnt
+ * mcb_bus_get() - Increment refcnt
  * @bus: The @mcb_bus
  *
  * Get a @mcb_bus' ref
@@ -455,7 +456,7 @@ EXPORT_SYMBOL_NS_GPL(mcb_request_mem, MC
 
 /**
  * mcb_release_mem() - Release memory requested by device
- * @dev: The @mcb_device that requested the memory
+ * @mem: The memory resource to be released
  *
  * Release memory that was prior requested via @mcb_request_mem().
  */
