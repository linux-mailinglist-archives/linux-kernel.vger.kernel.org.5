Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEF8675BB77
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 02:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjGUAVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 20:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGUAVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 20:21:34 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED0182106
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 17:21:31 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R6VbX3nlDzBRDss
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 08:21:28 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :subject:to:from:date:mime-version; s=dkim; t=1689898886; x=
        1692490887; bh=un8Jvd7FVUGjV+0zYyQPUzYFmFbSBXKGucB5+vzLMbQ=; b=s
        UYQJP1h6DFhf/ihUPyKcqeu26+zELTZWDGSdolsSzsgSI9am0K3KbUf8uCr/5uqK
        zUDMXlS5Sfeqv/M+9WYehJSTT8P58+gOguT/flfJhC0EoxENjRKHMMrU3xpnN49v
        ixbBNQ7zZ2Rx3HoqyQk5aTBKNGdWf0JosYmf9et35Q/MiOS99nmnuEV3FPXu7hvN
        KKqbrlkixBRwe6OWNR0CJhOMo2w/d+GO2Vh7OwmEvSYBgybbUM4fiqiuUB5WwuNG
        V4wvEb3jzXk3y7wKFeONWVj+5bcSQ7mfSAaWMScWKdGqgoZeEbJ0zqFwjJs1dNZg
        sWSZJdnqlWAooCRslm2og==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id VoBiUQXsZWWI for <linux-kernel@vger.kernel.org>;
        Fri, 21 Jul 2023 08:21:26 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R6VbT6w5lzBJqBP;
        Fri, 21 Jul 2023 08:21:25 +0800 (CST)
MIME-Version: 1.0
Date:   Fri, 21 Jul 2023 08:21:21 +0800
From:   zhangyongle001@208suo.com
To:     dinguyen@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] nios2/kernel: RROR: that open brace { should be on the
 previous line
User-Agent: Roundcube Webmail
Message-ID: <a372cb5c4bf5a94d6591629ba38ee060@208suo.com>
X-Sender: zhangyongle001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following checkpatch error:
ERROR: that open brace { should be on the previous line

Signed-off-by: zhangyongle <zhangyongle001@208suo.com>
---
  arch/nios2/kernel/kgdb.c | 3 +--
  1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/nios2/kernel/kgdb.c b/arch/nios2/kernel/kgdb.c
index d0963fcb11b7..0b5ac63e8e0b 100644
--- a/arch/nios2/kernel/kgdb.c
+++ b/arch/nios2/kernel/kgdb.c
@@ -15,8 +15,7 @@

  static int wait_for_remote_debugger;

-struct dbg_reg_def_t dbg_reg_def[DBG_MAX_REG_NUM] =
-{
+struct dbg_reg_def_t dbg_reg_def[DBG_MAX_REG_NUM] = {
  	{ "zero", GDB_SIZEOF_REG, -1 },
  	{ "at", GDB_SIZEOF_REG, offsetof(struct pt_regs, r1) },
  	{ "r2", GDB_SIZEOF_REG, offsetof(struct pt_regs, r2) },
-- 
2.40.1

