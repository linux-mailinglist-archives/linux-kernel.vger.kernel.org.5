Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A91068092FF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 22:06:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443957AbjLGVGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 16:06:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443936AbjLGVFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 16:05:45 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 134BE1716
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 13:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=0r4nfZqHPYRDR+n8ZIS2wR0AC5uZQeIIwrgxcaNxyuo=; b=0+CB4S6w5xhh+1K/c5OxSyVyNl
        o0iymSgjnk2U1Z5uxRjnjiilkPrDJ86FlxNmJpIQbjMWtGG6CuqMpUs7g4XimCTMHmTpnQfzjDNKw
        AM/AO8mD/PhNroTpaGBYVyC8rNRZJxRqYgPkMHOCtdxh4pq8gxMTotXGk8lbW5hFyyDNax+8MtzlP
        dtHIZQvl4E8SEZB21YjWK0+7oSkpPL6g1JfalihCfyM/jdwhLDyAajnll/8DDxI1AbfD0p/pBOHCS
        b15lPPkX+JiTh87rxHtSW4YeNqVbgPu310yapfAL77ltc3W/QXLlnk8VUFdc98FfMHjZqiNbssn2/
        Fyx/xVHQ==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1rBLZ5-00Duw1-2p;
        Thu, 07 Dec 2023 21:05:47 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, nvdimm@lists.linux.dev
Subject: [PATCH 1/3] nvdimm/btt: fix btt_blk_cleanup() kernel-doc
Date:   Thu,  7 Dec 2023 13:05:43 -0800
Message-ID: <20231207210545.24056-1-rdunlap@infradead.org>
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

Correct the function parameters to prevent kernel-doc warnings:

btt.c:1567: warning: Function parameter or member 'nd_region' not described in 'btt_init'
btt.c:1567: warning: Excess function parameter 'maxlane' description in 'btt_init'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: nvdimm@lists.linux.dev
---
 drivers/nvdimm/btt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/drivers/nvdimm/btt.c b/drivers/nvdimm/btt.c
--- a/drivers/nvdimm/btt.c
+++ b/drivers/nvdimm/btt.c
@@ -1550,7 +1550,7 @@ static void btt_blk_cleanup(struct btt *
  * @rawsize:	raw size in bytes of the backing device
  * @lbasize:	lba size of the backing device
  * @uuid:	A uuid for the backing device - this is stored on media
- * @maxlane:	maximum number of parallel requests the device can handle
+ * @nd_region:	&struct nd_region for the REGION device
  *
  * Initialize a Block Translation Table on a backing device to provide
  * single sector power fail atomicity.
