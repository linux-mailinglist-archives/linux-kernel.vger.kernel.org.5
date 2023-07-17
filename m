Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7E2755EEE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 11:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbjGQJD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 05:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjGQJDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 05:03:24 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C3DE55
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 02:03:23 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R4GMX71tbzBR9sn
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 17:03:20 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689584600; x=1692176601; bh=RYD1sskuDzXObzf/CBKl2LLRTRf
        tLipZpITieja7zjw=; b=UdlK60Ir8/jQksFTEty3sOVXZDN6045iH9P/KeNzms/
        eHIsCW0UCA82vS2+5DiMuUNgC4TM8iPJiGd8oCwL1Ph23od0U5dGUnS7wkpBXHtG
        A4udxiFAwo0KC8QiTzylfRkat3wJA/mOIGvb9HxEFCWtS5lxZ5hw4dy5JKFHnn54
        ZuMVLBtO5eCR1QpoBtJ7vCbWtLx9x+jc6/CJHFWPjT/C8u0U6kI9kVukxV+wK43K
        NZ3/sP0710CfA38X0fQsclT6R9L15GdI0+bJZFnId8W1eBWypUTnYGrmDqX2GfXn
        RoSpvrbgF5F/H603Xb2x1DiMLz/esnU7M6m+UaPQ84Q==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id nZQzW2VlsBq3 for <linux-kernel@vger.kernel.org>;
        Mon, 17 Jul 2023 17:03:20 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R4GMX5G35zBHYM6;
        Mon, 17 Jul 2023 17:03:20 +0800 (CST)
MIME-Version: 1.0
Date:   Mon, 17 Jul 2023 17:03:20 +0800
From:   hanyu001@208suo.com
To:     myungjoo.ham@samsung.com, cw00.choi@samsung.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] drivers: extcon: space required after that ','
In-Reply-To: <tencent_5D4E47E7BC2D92FC229E6245684D90B2ED06@qq.com>
References: <tencent_5D4E47E7BC2D92FC229E6245684D90B2ED06@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <25d422c1ac26f0c59ef10a8a2afe057b@208suo.com>
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

./drivers/extcon/extcon.c:321: ERROR: space required after that ',' 
(ctx:VxV)

Signed-off-by: maqimei <2433033762@qq.com>
---
  drivers/extcon/extcon.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
index 6f7a60d..4ef4422 100644
--- a/drivers/extcon/extcon.c
+++ b/drivers/extcon/extcon.c
@@ -318,7 +318,7 @@ static bool is_extcon_property_supported(unsigned 
int id, unsigned int prop)
  }

  static int is_extcon_property_capability(struct extcon_dev *edev,
-                unsigned int id, int index,unsigned int prop)
+                unsigned int id, int index, unsigned int prop)
  {
      struct extcon_cable *cable;
      int type, ret;
