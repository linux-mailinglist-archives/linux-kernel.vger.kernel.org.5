Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7162751ACC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233960AbjGMIHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232068AbjGMIHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:07:00 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95CA2359C
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 01:04:47 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R1nFl6wBRzBR7bq
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 16:04:43 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689235483; x=1691827484; bh=2JVYblZCrFwU34WRxN06J14YbJS
        7761l1AYPk7MTpyU=; b=yym5ghBw0UIYAOI3WefkDLsoVKDNmP9Q3vbcPa+cOC2
        CceONwxmRcxG1aYcqkXn71lEnRJ1xfkDrxpIrxxZJ0aIQ2Kf9YaVIdgyrjJa6HL/
        /5Qt8ghYe6nuXbNo7ggSRqzc7W2f7BaLBrRbB6EeLuv0MdS9tZp6j9v8eUlcfzvL
        Bj1ZI36pHP7iZVGX/VpZlNQr+RJEBX555e/8YrTTmAZDYVfbW/a8O4MPX6psLot7
        PS6lnlcrY8XGxJBbi0UMdgUoNHmdH1O6ugWzi6jUGmcZqUTQxvYTJ7Bz2EOShcQf
        bW7PX1DLYJNpLrFvTe7Zdr7D6iuzHDEo1vY48r0A82g==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 3R-3StqnYgdc for <linux-kernel@vger.kernel.org>;
        Thu, 13 Jul 2023 16:04:43 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R1nFl4f1mzBJDhy;
        Thu, 13 Jul 2023 16:04:43 +0800 (CST)
MIME-Version: 1.0
Date:   Thu, 13 Jul 2023 16:04:43 +0800
From:   hanyu001@208suo.com
To:     richard.henderson@linaro.org, ink@jurassic.park.msu.ru
Cc:     linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] alpha: kernel: space required after that ','
In-Reply-To: <tencent_E4D5629822712868D089ED4E87CF3C205206@qq.com>
References: <tencent_E4D5629822712868D089ED4E87CF3C205206@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <220676d36f87a4cca94ed871ca818bf4@208suo.com>
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

arch/alpha/kernel/core_cia.c:387: ERROR: space required after that ',' 
(ctx:VxV)

Signed-off-by: maqimei <2433033762@qq.com>
---
  arch/alpha/kernel/core_cia.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/alpha/kernel/core_cia.c b/arch/alpha/kernel/core_cia.c
index 12926e9..2779441 100644
--- a/arch/alpha/kernel/core_cia.c
+++ b/arch/alpha/kernel/core_cia.c
@@ -384,7 +384,7 @@ struct pci_ops cia_pci_ops =
      *(vip)CIA_IOC_TB_TAGn(5) = 0;
      *(vip)CIA_IOC_TB_TAGn(6) = 0;
      *(vip)CIA_IOC_TB_TAGn(7) = 0;
-    *(vip)CIA_IOC_TBn_PAGEm(0,0) = pte0;
+    *(vip)CIA_IOC_TBn_PAGEm(0, 0) = pte0;
      *(vip)CIA_IOC_TBn_PAGEm(0,1) = 0;
      *(vip)CIA_IOC_TBn_PAGEm(0,2) = 0;
      *(vip)CIA_IOC_TBn_PAGEm(0,3) = 0;
