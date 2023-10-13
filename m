Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5F0D7C8D46
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 20:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjJMSrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 14:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJMSrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 14:47:07 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81CA783
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 11:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1697222820;
        bh=8yBBEzFFAzVcOIvUA5gtnp4TxupG+UE7WaCSaPk+ECE=;
        h=Message-ID:Subject:From:To:Date:From;
        b=MrEdor7c3ctnoL7m98z75RBzozEzxLHU6/M64AOGSEujgYS03tIp5O4WPHzQp0OMV
         0Zn+HqaDLHifmv6Ff+hQ2WMB3OTPngA4q2pXjGNQ5mPqfmPbxvJ0mOZeS0sY9RJV3B
         nCZ0hqmlmFWqdHtVays8TutvOuEQ0YTR7w3HSzlc=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id D251F1281817;
        Fri, 13 Oct 2023 14:47:00 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id Q8W5I6It-XSO; Fri, 13 Oct 2023 14:47:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1697222820;
        bh=8yBBEzFFAzVcOIvUA5gtnp4TxupG+UE7WaCSaPk+ECE=;
        h=Message-ID:Subject:From:To:Date:From;
        b=MrEdor7c3ctnoL7m98z75RBzozEzxLHU6/M64AOGSEujgYS03tIp5O4WPHzQp0OMV
         0Zn+HqaDLHifmv6Ff+hQ2WMB3OTPngA4q2pXjGNQ5mPqfmPbxvJ0mOZeS0sY9RJV3B
         nCZ0hqmlmFWqdHtVays8TutvOuEQ0YTR7w3HSzlc=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id C033E128138F;
        Fri, 13 Oct 2023 14:46:59 -0400 (EDT)
Message-ID: <81d665ccd17999d96d698c0d897e11c992a4de21.camel@HansenPartnership.com>
Subject: [GIT PULL] SCSI fixes for 6.6-rc5
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Fri, 13 Oct 2023 14:46:58 -0400
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A single tiny fix in the ufs driver core correcting the reversed logic
in an error message.

The patch is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

The short changelog is:

Peter Wang (1):
      scsi: ufs: core: Correct clear TM error log

And the diffstat:

 drivers/ufs/core/ufshcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

With full diff below.

James

---

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index c2df07545f96..8382e8cfa414 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -6895,7 +6895,7 @@ static int ufshcd_clear_tm_cmd(struct ufs_hba *hba, int tag)
 			mask, 0, 1000, 1000);
 
 	dev_err(hba->dev, "Clearing task management function with tag %d %s\n",
-		tag, err ? "succeeded" : "failed");
+		tag, err < 0 ? "failed" : "succeeded");
 
 out:
 	return err;

