Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE9276BB61
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 19:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234537AbjHARgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 13:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234283AbjHARgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 13:36:36 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C83C10F1;
        Tue,  1 Aug 2023 10:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=t3/TEOMMBqs2aatmdG8Z4OzwuZXTQz0DDq3G1QEeVZ0=; b=xn4P9Q6v+cxfApxHVA9nIEPL59
        XoFVePi8z26u90VblqDo8ZKsMc4U/DPTZRP68ibsrEcq6pP3g/0s3sKfa8oa9J58H+Rhq3KnrgleJ
        6hjJ52UVN20msW7acln7uPOWX2Wgfj9ssfxy52dAyC9hY0K407jhXK7ptNEaWsD0/heV0SMOsPncP
        ujQuF8E1zjeUTy+sWrlYianfi4e3+R7mMuqoeQ+xgOFZee91Fj/ltLieZapt2FvNM6+6lcWh2F9tS
        kvcQgk4/X9ea54a1eLYdm5du7NnHBNsjcGVKTmnCDw0bDVk1xj0mpa3GVRUzG/fB4KrkWlSOkqzCW
        FN32rksw==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qQtII-002w8A-1j;
        Tue, 01 Aug 2023 17:36:27 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Manuel Lauss <manuel.lauss@gmail.com>,
        Yangbo Lu <yangbo.lu@nxp.com>, Joshua Kinard <kumba@gentoo.org>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org (open list),
        linux-mmc@vger.kernel.org, netdev@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-modules@vger.kernel.org
Subject: [PATCH 4/5] rtc: ds1685: use EXPORT_SYMBOL_GPL for ds1685_rtc_poweroff
Date:   Tue,  1 Aug 2023 19:35:43 +0200
Message-Id: <20230801173544.1929519-5-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230801173544.1929519-1-hch@lst.de>
References: <20230801173544.1929519-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ds1685_rtc_poweroff is only used externally via symbol_get, which was
only ever intended for very internal symbols like this one.  Use
EXPORT_SYMBOL_GPL for it so that symbol_get can enforce only being used
on EXPORT_SYMBOL_GPL symbols.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Joshua Kinard <kumba@gentoo.org>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/rtc/rtc-ds1685.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-ds1685.c b/drivers/rtc/rtc-ds1685.c
index 0f707be0eb87fa..04dbf35cf3b706 100644
--- a/drivers/rtc/rtc-ds1685.c
+++ b/drivers/rtc/rtc-ds1685.c
@@ -1432,7 +1432,7 @@ ds1685_rtc_poweroff(struct platform_device *pdev)
 		unreachable();
 	}
 }
-EXPORT_SYMBOL(ds1685_rtc_poweroff);
+EXPORT_SYMBOL_GPL(ds1685_rtc_poweroff);
 /* ----------------------------------------------------------------------- */
 
 
-- 
2.39.2

