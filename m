Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EFEB807755
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 19:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379073AbjLFSNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 13:13:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379087AbjLFSNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 13:13:30 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 730D1D5B;
        Wed,  6 Dec 2023 10:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=9Jjhru2ZS2MjwSXGlS5vMOqG5oAjzFFLnSkNdJ/iC7Y=; b=fFMF/HdNhrOgP0tisubvvm+0du
        sSkWPYchdFU+7JZ81vY6FMVW3yepI6GBNfY+NNR7wyoIlrWZJt6wZU80vblBmk6OcQ3xs81SafMTA
        JxTJMZgo8gbFEVLl+GD4lyLD1jmMVQ42mMHDA1nKxouae0DEKk3mIM9OkCpy4859yi9fHpw1tIFch
        NCPunzAZLmxnRtFOlx+zDLfIOq1fUeR+tdqVcPfQC3knFGD/1x9Kr0QJQso33SaSYC2hFsbQJvVb1
        rT/329l9EJarlVw0EyMFnOc7yfWOKuQbYeRPatmOWvRWZLndP63LC1LiMrCEwAvQjanWLnTDsp4s8
        oQb/tGVg==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1rAwOu-00B0qd-0j;
        Wed, 06 Dec 2023 18:13:36 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Subject: [PATCH] usb: fotg210-udc: fix function kernel-doc comments
Date:   Wed,  6 Dec 2023 10:13:35 -0800
Message-ID: <20231206181335.27540-1-rdunlap@infradead.org>
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

Correct kernel-doc comments to prevent warnings from
scripts/kernel-doc.

fotg210-udc.c:1103: warning: Function parameter or member 'g' not described in 'fotg210_vbus_session'
fotg210-udc.c:1103: warning: Excess function parameter '_gadget' description in 'fotg210_vbus_session'
fotg210-udc.c:1103: warning: No description found for return value of 'fotg210_vbus_session'
fotg210-udc.c:1129: warning: No description found for return value of 'fotg210_phy_event'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org
---
 drivers/usb/fotg210/fotg210-udc.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff -- a/drivers/usb/fotg210/fotg210-udc.c b/drivers/usb/fotg210/fotg210-udc.c
--- a/drivers/usb/fotg210/fotg210-udc.c
+++ b/drivers/usb/fotg210/fotg210-udc.c
@@ -1094,10 +1094,10 @@ static int fotg210_udc_stop(struct usb_g
 
 /**
  * fotg210_vbus_session - Called by external transceiver to enable/disable udc
- * @_gadget: usb gadget
+ * @g: usb gadget
  * @is_active: 0 if should disable UDC VBUS, 1 if should enable
  *
- * Returns 0
+ * Returns: %0
  */
 static int fotg210_vbus_session(struct usb_gadget *g, int is_active)
 {
@@ -1122,7 +1122,7 @@ static const struct usb_gadget_ops fotg2
  *
  * Called by the USB Phy when a cable connect or disconnect is sensed.
  *
- * Returns NOTIFY_OK or NOTIFY_DONE
+ * Returns: NOTIFY_OK or NOTIFY_DONE
  */
 static int fotg210_phy_event(struct notifier_block *nb, unsigned long action,
 			     void *data)
