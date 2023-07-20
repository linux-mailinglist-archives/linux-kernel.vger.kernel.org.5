Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F80975B3CA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 18:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbjGTQGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 12:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjGTQGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 12:06:16 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26ABACE
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 09:06:16 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R6Hc42RMSzBRDt0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 00:06:12 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689869171; x=1692461172; bh=JDPE0gY2EAQkPsdOqBvmm0/vLJD
        5CubpDsaJaKXZx1A=; b=1WSa2No1l0KZmow4Fdyqpya+iRUGjHYtjeHzTKSmqB4
        PZeggS0ybvA4/tZyCySf/CgzD6fpoIoF/iDCi7GuCgA6gld1+FvAIKTCCvDf46Mz
        x5x1F7RAxeaiVZbkj1tNPR9Kr965eqECvxBZCgTBc7Fm37lowIfqyLhgnXDvevJ5
        J3XgnHQ28ghRvLrZLV0JzC44uZhAxLqd9s+xz9RVW+2QX6bXXLJvkaCLA5E6WGpM
        Yip41T3p15HwPuwBsBpsK3o37bOauA7+YIYpRf6tc1/26vNyIz7kKpIuCuHJilij
        sJ/nYmePfZJHApfqA5yOmcKTgkjH4vBlmaoA/88wPGA==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id e0EfisCcE8k6 for <linux-kernel@vger.kernel.org>;
        Fri, 21 Jul 2023 00:06:11 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R6Hc32BnPzBHXgs;
        Fri, 21 Jul 2023 00:06:11 +0800 (CST)
MIME-Version: 1.0
Date:   Fri, 21 Jul 2023 00:06:11 +0800
From:   pangzizhen001@208suo.com
To:     oliver@neukum.org, aliakc@web.de, lenehan@twibble.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/scsi: Fix typos in comments
In-Reply-To: <20230720160417.4434-1-wangjianli@cdjrlc.com>
References: <20230720160417.4434-1-wangjianli@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <0dbfe7a07c205bde3fc60408ce7aa55a@208suo.com>
X-Sender: pangzizhen001@208suo.com
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

Delete duplicate word "the"

Signed-off-by: Zizhen Pang <pangzizhen001@208suo.com>
---
  drivers/scsi/dc395x.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/dc395x.c b/drivers/scsi/dc395x.c
index c8e86f8a631e..077e76407c58 100644
--- a/drivers/scsi/dc395x.c
+++ b/drivers/scsi/dc395x.c
@@ -2052,7 +2052,7 @@ static void data_in_phase0(struct AdapterCtlBlk 
*acb, struct ScsiReqBlk *srb,
          /*
           * KG: We should wait for the DMA FIFO to be empty ...
           * but: it would be better to wait first for the SCSI FIFO and 
then the
-         * the DMA FIFO to become empty? How do we know, that the 
device not already
+         * DMA FIFO to become empty? How do we know, that the device 
not already
           * sent data to the FIFO in a MsgIn phase, eg.?
           */
          if (!(DC395x_read8(acb, TRM_S1040_DMA_FIFOSTAT) & 0x80)) {
