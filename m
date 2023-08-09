Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39A9277671A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 20:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbjHISTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 14:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjHISTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 14:19:08 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11213A3;
        Wed,  9 Aug 2023 11:19:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1691605138; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=OiV+vb/8hz5q30vY3EKAd6GRD1/veELDDFzu7WpsaeoTqBcsebwSlf4Xen+EwWXB7/
    e0Jbg2w/mVFM3JCVxzzAapTVmoLKFTUJtRKgxJqU6tlSSTJ/9t+ENGIhN1AqdjuQtv6u
    Umb7O2Ce8MAUIIrMszpO8qXObKl/Magiclx8v/jO8efqA5FNfVRrY38c+RKhElPSIoHa
    4nOdnb5Lz2Lt9WKUNYBckVyyv0xY8z8yDKVO1MczdD1V6HpCxI2S4wJjc0TrGUyD5Q6k
    lBI3FW1XYorh21qmqVf2yeUuxdlWnueTrTWKr7iYegD5rdtSyNKA2wx9G0/xuTVRZ79I
    3dXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1691605138;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=25wQxvsz2tJRkMoBU+Z8a5c7VcMyZjz+ALvQJUrTZe0=;
    b=RmHa7xKePzwSfF+MHnaExXCz3r1vWdBA8SMC9DYITVeFu0EgQs/nMRsEvEGxGRgcKW
    OYWZ4dQ1rAdhRp6XHvdfCU6EXi7NFX+1lBmDXkHlXOix7hZ+YUVLpZSFMW2qdD1+S1Gb
    eouAdSlpRuJhy0QUax0bEWMOqZ3joBxOxdfnrQaNzSzV6D7gi125/+ZdMH/GMbax8W5N
    xt+WO6Drw3BO1KzfcQAjQ7xYbMHs7vCwBT7whjrTJkYo5qT4Ouwb6+7rKztJPl1sB0cq
    E5rYnQ46iG5kRzB3Bk7/nOmJbuSsz9O+LCmnNam+VbPhU4LzBYnS2HnCGNFkcjqTwfIc
    HTVA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1691605138;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=25wQxvsz2tJRkMoBU+Z8a5c7VcMyZjz+ALvQJUrTZe0=;
    b=nU5y4QoXVY6BF7uRKC7iZnSY2BulSdeEIbZQ5iam62PUJh5R8FknT8PpEizViW1ZTB
    twMki0r+YbGHhXqx8HqmQs1oAluyGhFF75bK7Sfm9JHT5Zuzs3IGkF1DcqzIafphhFaj
    4ZHfG06KBY7hv2pajy4rbiIpvPW5hVJ+uHpa9qqoew1Zxu3x73oSxI4rbMEukH3+r609
    OtNSo/2qsUdNnSglA45JZ3vTrs//zV+5GHDaWrFmvWOKZ0O1LfIhXVbzFHWdpWmY8XQE
    uNn1qEHFffIYDW040JTLmwKRJNg/ms7wtwTaPjExtlkC89pp1oTDUDOx/JU0CTLshKN5
    9rDQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1691605138;
    s=strato-dkim-0003; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=25wQxvsz2tJRkMoBU+Z8a5c7VcMyZjz+ALvQJUrTZe0=;
    b=ShC4DrYsnFpnFLOkJMtFk4aqNpPhlimx3vHqCK7YIEP4tCJLRNrjNbJ32fo/JVbyR6
    aFP0PHEDfyIR2Qbb8HDg==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSedrgBzPc9DUyubU4DD1QLj68UeUr1+U1B7WtoHeqrQNqrexjtNBJQI8izfAF0DFZj1zmA=="
Received: from blinux.speedport.ip
    by smtp.strato.de (RZmta 49.6.6 AUTH)
    with ESMTPSA id z12fdaz79IIwh70
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 9 Aug 2023 20:18:58 +0200 (CEST)
From:   Bean Huo <beanhuo@iokpp.de>
To:     alim.akhtar@samsung.com, avri.altman@wdc.com,
        asutoshd@codeaurora.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, stanley.chu@mediatek.com,
        beanhuo@micron.com, bvanassche@acm.org, tomas.winkler@intel.com,
        cang@codeaurora.org, jonghwi.rha@samsung.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] scsi: ufs: core: No need to update UPIU.header.flags and lun in advanced RPMB handler
Date:   Wed,  9 Aug 2023 20:18:47 +0200
Message-Id: <20230809181847.102123-3-beanhuo@iokpp.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230809181847.102123-1-beanhuo@iokpp.de>
References: <20230809181847.102123-1-beanhuo@iokpp.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bean Huo <beanhuo@micron.com>

For advanced RPMB requests, its UPIU package should be fully initialized
in its ufs-bsg-based application, except for task tag. in ufshcd.c,  we
just copy UPIU (with CDB) request as-is.

Signed-off-by: Bean Huo <beanhuo@micron.com>
---
 drivers/ufs/core/ufshcd.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 7f965ac18ee8..446f949154c3 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -7250,9 +7250,7 @@ int ufshcd_advanced_rpmb_req_handler(struct ufs_hba *hba, struct utp_upiu_req *r
 	else
 		ufshcd_prepare_req_desc_hdr(lrbp, &upiu_flags, dir, 0);
 
-	/* update the task tag and LUN in the request upiu */
-	req_upiu->header.flags = upiu_flags;
-	req_upiu->header.lun = UFS_UPIU_RPMB_WLUN;
+	/* update the task tag */
 	req_upiu->header.task_tag = tag;
 
 	/* copy the UPIU(contains CDB) request as it is */
-- 
2.34.1

