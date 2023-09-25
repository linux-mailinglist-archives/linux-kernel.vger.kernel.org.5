Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27CE57ACF90
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 07:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbjIYFn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 01:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjIYFny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 01:43:54 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B00BDA
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 22:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=cTJgEzpgfN5ep0AVXrfoyqbXaUcnTxXPQGsCBbpaanQ=; b=hDGr/73HcfsSm+p98MMIdcUR68
        ER5cm5acuIVpYVNSppftCSNMlsTnscEp4xT8ssv5GmHAz6MqgcS+DV1vqDFQKLo36M/7+rYsKVwH1
        8aPFaVgybEWh34HnCJE/f1DoqTFIeYzhx/3949KfW/LaoTIVHN8DU632I5OUUt6HHq8879vHSTfTe
        WpMdpWNPWitZXrWrfUi0cDGe85LLlXuP+LcGaG2rmzAUIgxvz5YKGrbzwWx/UlSihaeEMI8t6cUfm
        Ird3/ST1UeeLjLxp6J//dEY6IRZ66mqUl9sy9YyxnKA/8UlMYeMpVdmuWf1CPm89ixVrFV5EiEuYj
        tRY3adhA==;
Received: from [2601:1c2:980:9ec0::9fed] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qkeNn-00DNqY-2d;
        Mon, 25 Sep 2023 05:43:47 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] gnss: tell what GNSS means
Date:   Sun, 24 Sep 2023 22:43:46 -0700
Message-ID: <20230925054346.18065-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.42.0
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

Tell users what GNSS means in the Kconfig prompt.

Fixes: 2b6a44035143 ("gnss: add GNSS receiver subsystem")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gnss/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/drivers/gnss/Kconfig b/drivers/gnss/Kconfig
--- a/drivers/gnss/Kconfig
+++ b/drivers/gnss/Kconfig
@@ -4,7 +4,7 @@
 #
 
 menuconfig GNSS
-	tristate "GNSS receiver support"
+	tristate "GNSS (Global Navigation Satellite System) receiver support"
 	help
 	  Say Y here if you have a GNSS receiver (e.g. a GPS receiver).
 
