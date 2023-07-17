Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B987755A5D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 05:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbjGQDxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 23:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjGQDxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 23:53:51 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A541B7
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 20:53:49 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R47VM4BSJzBHXhR
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 11:53:47 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689566027; x=1692158028; bh=yO9olHN2kz9V1S952ve2jmRDX9M
        4YZqbbgOGihKzL/A=; b=REPhoOPHoTqFBQEzX6dM7mSVLpypR5zUS8cM1wFcYwE
        x5Hj+YqFsEpoDcgc+CI1mI7avwU3usGjvUeeYxzjo/F/g8QpyYGRWzlnQEkzAwVP
        jaLN/8Hnu/mawhqocZR7smh9xj4reZrlSKsDvsR74At0gxon3hFXSYPIZoC5Uoqc
        PR3Cx4DHEwifrBAdL6FeT1tFe6ord2bsgMenRuuCJWsH5EDnLTsY8C/SttpBZk1X
        aogS49UuYIHP/i3xWiaWR2XLrkyIl0F7kT5YQMGZOgXDrdPX34Z3M+vVYsIC73CZ
        yPpwohXYoWVkRJR8VjXZtcuCjjZGRphXepLCTp/s/hQ==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id W-8ScmObhXOu for <linux-kernel@vger.kernel.org>;
        Mon, 17 Jul 2023 11:53:47 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R47VM0qGMzBHXR9;
        Mon, 17 Jul 2023 11:53:47 +0800 (CST)
MIME-Version: 1.0
Date:   Mon, 17 Jul 2023 11:53:47 +0800
From:   hanyu001@208suo.com
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     netdev@vger.kernel.org, linux-net-drivers@amd.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] falcon: Prefer unsigned int to bare use of unsigned
In-Reply-To: <tencent_17776852D0A5AD5787FB7C0652F0628EE206@qq.com>
References: <tencent_17776852D0A5AD5787FB7C0652F0628EE206@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <17542be887f082df63dbe436f1abcac7@208suo.com>
X-Sender: hanyu001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the checkpatch.pl error:

./drivers/net/ethernet/sfc/falcon/farch.c:274: WARNING: Prefer 'unsigned 
int' to bare use of 'unsigned':

Signed-off-by: maqimei <2433033762@qq.com>
---
  drivers/net/ethernet/sfc/falcon/farch.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/sfc/falcon/farch.c 
b/drivers/net/ethernet/sfc/falcon/farch.c
index c64623c..643ffe1 100644
--- a/drivers/net/ethernet/sfc/falcon/farch.c
+++ b/drivers/net/ethernet/sfc/falcon/farch.c
@@ -271,7 +271,7 @@ static int ef4_alloc_special_buffer(struct ef4_nic 
*efx,
  /* This writes to the TX_DESC_WPTR; write pointer for TX descriptor 
ring */
  static inline void ef4_farch_notify_tx_desc(struct ef4_tx_queue 
*tx_queue)
  {
-    unsigned write_ptr;
+    unsigned int write_ptr;
      ef4_dword_t reg;

      write_ptr = tx_queue->write_count & tx_queue->ptr_mask;
