Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26953759AF1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 18:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbjGSQg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 12:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjGSQgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 12:36:22 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C0E5210C
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 09:36:01 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R5WLl6Qh3zBRDrL
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 17:51:59 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689760319; x=1692352320; bh=JYo0arU7Fs6AXz7VRcu/eeuoahL
        OLMHhVOHPhvU9RTE=; b=IwhXS98lTdSxFVnOdE2ShS33E49R3XjpCVojxwPXxrU
        8/Q7n+WVPQvUC2cscPArO60GZqF5c8S4cDjGd2N80f5iShdYZSka3iWb5rr/wSJL
        sG4whSboTMi7vBx+oypEr7FT8wiJrWeytZ0USCT0hkMvS6+xsFl2OvQSfVteMdNk
        IQtV6E3Ix4tuvusMdWOO1ja+CvlXVuxtHDR/jw7VVeaVut+MzdIDXaSUfLZDqGRW
        IhdSgzGVscNFFSk7KwtFpw5ad6M2Ki7780GluwtPr+GHTi17/QVmj5j8lTdDwUL2
        sa/9PxyGi8raDj6ijLkz+5JnmOsi96NOxiKbrir0jDQ==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id KCDWsbJrwgH1 for <linux-kernel@vger.kernel.org>;
        Wed, 19 Jul 2023 17:51:59 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R5WLl4tdSzBRDrD;
        Wed, 19 Jul 2023 17:51:59 +0800 (CST)
MIME-Version: 1.0
Date:   Wed, 19 Jul 2023 17:51:59 +0800
From:   hanyu001@208suo.com
To:     guoren@kernel.org
Cc:     linux-csky@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] csky: abiv2: add require space around that ':'
In-Reply-To: <tencent_347AA81279DC82688A96A0D6F8DC5140AB05@qq.com>
References: <tencent_347AA81279DC82688A96A0D6F8DC5140AB05@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <7c1f0e2a84aac41364913e299d0d070a@208suo.com>
X-Sender: hanyu001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix below checkpatch errors:

./arch/csky/abiv2/inc/abi/entry.h:42: ERROR: spaces required around that 
':' (ctx:VxE)
./arch/csky/abiv2/inc/abi/entry.h:44: ERROR: spaces required around that 
':' (ctx:VxE)

Signed-off-by: Yu Han <hanyu001@208suo.com>
---
  arch/csky/abiv2/inc/abi/entry.h | 4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/csky/abiv2/inc/abi/entry.h 
b/arch/csky/abiv2/inc/abi/entry.h
index 704724154a87..738cf58446c7 100644
--- a/arch/csky/abiv2/inc/abi/entry.h
+++ b/arch/csky/abiv2/inc/abi/entry.h
@@ -39,9 +39,9 @@
      bf      1f
      addi    lr, sp, 152
      br    2f
-1:
+1 :
      mfcr    lr, usp
-2:
+2 :
      stw    lr, (sp, 16)

      stw     a0, (sp, 20)
