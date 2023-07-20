Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1291C75AB5B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 11:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbjGTJsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 05:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbjGTJrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 05:47:43 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7411630E2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 02:44:49 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R677x2NGkzBRDsS
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 17:44:45 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :subject:to:from:date:mime-version; s=dkim; t=1689846284; x=
        1692438285; bh=qGOeHgtDBHsSHC3uATnAbr19YDqR8PrzwbEe7cIQD6Y=; b=q
        SOOgrvE9L1WGf7zl9GpN+soQ8HG3e3eT3s7Bw9Mbfvc/iCYLfDO6DYFqtZcjxh28
        y6gEQAnk8zgB4dfttkwmAVA3bQwbjjCT6vYgrabB4DBFxvBOC2xVXbwElSqG7J+G
        CfDmNjj/3RMAMxM3A7LS4ErOsQQ3oL11egiIfmddaKlgngsRNiROLgYo7loLjEEo
        rybko3Yq6xIgkLmSugdqyYHceHWwpVD+mEmrGN2yrqG9C1sMhEZhYrd/MpTB5UFk
        cNBzYCiP2lJi37LZJyt0MjSNWeCA1RseczWYotktKlE9lPdg9S8Dmm3/wOCJiklB
        SUU9yfWUFDZiD2Jz1bbJg==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id wCKaxB0_fyDO for <linux-kernel@vger.kernel.org>;
        Thu, 20 Jul 2023 17:44:44 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R677w53TPzBRDrZ;
        Thu, 20 Jul 2023 17:44:44 +0800 (CST)
MIME-Version: 1.0
Date:   Thu, 20 Jul 2023 17:44:44 +0800
From:   zhangyongle001@208suo.com
To:     linux-m68k@lists.linux-m68k.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] m68k: Fix the following checkpatch error:
User-Agent: Roundcube Webmail
Message-ID: <4994ede231971e39e3b7f51844d8868a@208suo.com>
X-Sender: zhangyongle001@208suo.com
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

ERROR: that open brace { should be on the previous line
ERROR: that open brace { should be on the previous line
ERROR: else should follow close brace '}'

Signed-off-by: zhangyongle <zhangyongle001@208suo.com >
---
  arch/m68k/bvme6000/config.c | 7 ++-----
  1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/m68k/bvme6000/config.c b/arch/m68k/bvme6000/config.c
index 3a1d90e399e0..6bc33d5d4d73 100644
--- a/arch/m68k/bvme6000/config.c
+++ b/arch/m68k/bvme6000/config.c
@@ -290,8 +290,7 @@ int bvme6000_hwclk(int op, struct rtc_time *t)

  	rtc->msr = 0x40;	/* Ensure clock and real-time-mode-register
  				 * are accessible */
-	if (op)
-	{	/* Write.... */
+	if (op) {	/* Write.... */
  		rtc->t0cr_rtmr = t->tm_year%4;
  		rtc->bcd_tenms = 0;
  		rtc->bcd_sec = bin2bcd(t->tm_sec);
@@ -303,9 +302,7 @@ int bvme6000_hwclk(int op, struct rtc_time *t)
  		if (t->tm_wday >= 0)
  			rtc->bcd_dow = bin2bcd(t->tm_wday+1);
  		rtc->t0cr_rtmr = t->tm_year%4 | 0x08;
-	}
-	else
-	{	/* Read....  */
+	} else {	/* Read....  */
  		do {
  			t->tm_sec  = bcd2bin(rtc->bcd_sec);
  			t->tm_min  = bcd2bin(rtc->bcd_min);
-- 
2.40.1

