Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65597758211
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 18:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbjGRQ0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 12:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjGRQ0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 12:26:44 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7BF0B5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 09:26:42 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R548c0hmkzBR9tR
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 00:26:40 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689697598; x=1692289599; bh=SLU3iS6tJ/RTW6wvW6E+YKtlFng
        YjCe5o2r64kZZSSw=; b=kepxSG1dTanWeQIMtt9dzfRp4n/o/s5jpAikHX2DYZ2
        zZzFJXhWre4IxfbSUfDFRxxT28FAPuSbG+MouvU6erHJp1wXTlFnQcTDDfJ7bjkB
        Kb0noFM1sIb8XwM7prvpUr/nr5SJZvkv4rpi3bkb45N0tL56L09xav2Jr+Q4bqQa
        IQVVPT5dVKH8s8bV0hvaHs0YYR9YreGdQYuR4vGYKTiDn+3SOgKhzTEarvlD0KxP
        jaY6V/++FaJ7QpFa+r6/qZzH1V37BtwfFLLvAqTVvexZ6GhpNqUI4X1THo8WrFBl
        82Vhggf6+72HDlzc5x8MmPsdpzid8PLQsEEeR2ZF0jQ==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id igmbOlPXCrAN for <linux-kernel@vger.kernel.org>;
        Wed, 19 Jul 2023 00:26:38 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R548Z63XJzBR9tP;
        Wed, 19 Jul 2023 00:26:38 +0800 (CST)
MIME-Version: 1.0
Date:   Wed, 19 Jul 2023 00:26:38 +0800
From:   pangzizhen001@208suo.com
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/tty: Fix typos in comments
In-Reply-To: <ffa4ee5ba65722fe52481638ab20e068@208suo.com>
References: <20230718162025.64358-1-wangjianli@cdjrlc.com>
 <ffa4ee5ba65722fe52481638ab20e068@208suo.com>
User-Agent: Roundcube Webmail
Message-ID: <23fa2aeabdb1bdd0a30969edcc99bbad@208suo.com>
X-Sender: pangzizhen001@208suo.com
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

Delete duplicate word "the"

Signed-off-by: Zizhen Pang <pangzizhen001@208suo.com>
---
  drivers/tty/n_gsm.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index b411a26cc092..e8cd1e07eafe 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -1148,7 +1148,7 @@ static void __gsm_data_queue(struct gsm_dlci 
*dlci, struct gsm_msg *msg)
   *
   *    Add data to the transmit queue and try and get stuff moving
   *    out of the mux tty if not already doing so. Take the
- *    the gsm tx lock and dlci lock.
+ *    gsm tx lock and dlci lock.
   */

  static void gsm_data_queue(struct gsm_dlci *dlci, struct gsm_msg *msg)
