Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4DD751AC5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233900AbjGMIE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233552AbjGMIEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:04:44 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 675B03A81
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 01:02:48 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R1nBz3PbZzBL4kD
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 16:02:19 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689235339; x=1691827340; bh=oL3xOkn7E3MUOt4JI0gh3HeTNGG
        0L2ucZwS9lYLtuEA=; b=TE4UVTEkDYWk5WrMLKW++RkRGpIdRSFoo2fTqfcxgC2
        HLDCgN2TMMaPPESJF6hiD3qxE/x8kL0FjJvMUz9Ffos+WpO1dPYidNTN57m3wxvT
        Y0fEEEp/vLX/l1XdSclGFxzZQNQ7i5PBsdmjlJrHwXUKNnr+FXavnP7XltaOoCxT
        I4h9mr4f/uk7Are4RY6Q8vBGNCkJJfT5t7dq7UlkDt6T6VtJfnP8ybvZdCzk6rd5
        zYhmTWl3u3D9xsSy+HZTaP1+RAqruie9u1TzMja2d5wR6mYSkYtvgZNvMsEEqSTT
        BiARIc4n9ohyUhd6UxLH3rB2c09XX924lD/wOVT09qw==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id yly3phc4yQmI for <linux-kernel@vger.kernel.org>;
        Thu, 13 Jul 2023 16:02:19 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R1nBz15qnzBJDhy;
        Thu, 13 Jul 2023 16:02:19 +0800 (CST)
MIME-Version: 1.0
Date:   Thu, 13 Jul 2023 16:02:19 +0800
From:   hexingwei001@208suo.com
To:     sammy@sammy.net, geert@linux-m68k.org
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: [PATCH] m68k: sun3: idprom: ERROR: "foo* bar" should be "foo *bar"
In-Reply-To: <20230713080020.72931-1-panzhiai@cdjrlc.com>
References: <20230713080020.72931-1-panzhiai@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <9dc7423a9e54f849212f21a59074ffb4@208suo.com>
X-Sender: hexingwei001@208suo.com
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

Fix one occurrences of the checkpatch.pl error:
ERROR: "foo* bar" should be "foo *bar"

Signed-off-by: Xingwei He <hexingwei001@208suo.com>
---
  arch/m68k/sun3/idprom.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/m68k/sun3/idprom.c b/arch/m68k/sun3/idprom.c
index 1ace5353d78f..a4c5cd072c87 100644
--- a/arch/m68k/sun3/idprom.c
+++ b/arch/m68k/sun3/idprom.c
@@ -83,7 +83,7 @@ static void __init display_system_type(unsigned char 
machtype)
      prom_halt();
  }

-void sun3_get_model(unsigned char* model)
+void sun3_get_model(unsigned char *model)
  {
      register int i;
