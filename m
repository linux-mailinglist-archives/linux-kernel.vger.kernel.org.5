Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE2C4754D50
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 06:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjGPEcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 00:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjGPEcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 00:32:33 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C5E194
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 21:32:31 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R3XPT1c0ZzBHXgq
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 12:32:29 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689481949; x=1692073950; bh=xBqQ8RrtpjxGaqUbrdAplKRwJil
        9/d/wO5QQxP+8MIo=; b=TW8X2kb0wGv9r+NwjdQ7C/cP0ShIKK2y7yiPmTOufxa
        pPwOCoCMLIQ3VZhsXO468Z2LBqzL4XskBabIU/b3H88+t30vYIP0NN+yb0530Bs6
        fcrQjyHw28wiOcUr1EXVRTCmPQuXPRs4a7iooEnH8eWSF+VSTX3mPkpvZ14V6PkI
        Cm2iI8zP8pfhiZHhHMbVe5sb7Xxi08iw3/x/WTVb6f8A5U6RZo1cw6fRYe51JIEH
        ytjA3HNQ1RdB+WCDihovglczQ/u8CA7CX9EusjPQATTQ9jFBVmbV3wPCbjozEeXG
        w7n4k1vcmP7MZ6fWTHfLAl7iXks8QSHeCwqoU2ngULw==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id SF33a3LSkrWi for <linux-kernel@vger.kernel.org>;
        Sun, 16 Jul 2023 12:32:29 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R3XPS5vtmzBHXgf;
        Sun, 16 Jul 2023 12:32:28 +0800 (CST)
MIME-Version: 1.0
Date:   Sun, 16 Jul 2023 12:32:28 +0800
From:   wuyonggang001@208suo.com
To:     sathya.prakash@broadcom.com, sreekanth.reddy@broadcom.com,
        suganath-prabu.subramani@broadcom.com
Cc:     linux-scsi@vger.kernel.org, MPT-FusionLinux.pdl@broadcom.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: message: fusion: Modify Format
In-Reply-To: <20230716042651.12582-1-zhanglibing@cdjrlc.com>
References: <20230716042651.12582-1-zhanglibing@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <f4c6415590fdeb514fbcb3f3beb82375@208suo.com>
X-Sender: wuyonggang001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following checkpatch error(s):

ERROR: "scsi_cmnd * SCpnt" should be "scsi_cmnd *SCpnt"
ERROR: "MPT_SCSI_HOST   * hd" should be "MPT_SCSI_HOST   *hd"

Signed-off-by: Yonggang Wu <wuyonggang001@208suo.com>
---
  drivers/message/fusion/mptscsih.c | 4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/message/fusion/mptscsih.c 
b/drivers/message/fusion/mptscsih.c
index 2bc17087d17d..60323f73337e 100644
--- a/drivers/message/fusion/mptscsih.c
+++ b/drivers/message/fusion/mptscsih.c
@@ -1861,7 +1861,7 @@ mptscsih_dev_reset(struct scsi_cmnd * SCpnt)
   *    Returns SUCCESS or FAILED.
   **/
  int
-mptscsih_bus_reset(struct scsi_cmnd * SCpnt)
+mptscsih_bus_reset(struct scsi_cmnd *SCpnt)
  {
      MPT_SCSI_HOST    *hd;
      int         retval;
@@ -1913,7 +1913,7 @@ mptscsih_bus_reset(struct scsi_cmnd * SCpnt)
  int
  mptscsih_host_reset(struct scsi_cmnd *SCpnt)
  {
-    MPT_SCSI_HOST *  hd;
+    MPT_SCSI_HOST   *hd;
      int              status = SUCCESS;
      MPT_ADAPTER    *ioc;
      int        retval;
