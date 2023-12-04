Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9D11802C71
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 08:53:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343559AbjLDHxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 02:53:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234745AbjLDHwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 02:52:47 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989AA1A7;
        Sun,  3 Dec 2023 23:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1701676352;
        bh=iOBuDxNgWayHfZg8ll4jl4+gQO+POEL5ZSXO0IYskQo=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=STO8kui6mbh1g6598MiaxLRX5mQc341d0YjLWS7Nqws1kfRzH1lwxwoSt5ziD1VFK
         aSwpZnNYfLd9cTApCGEXs0XYNCcDuD8ICVixi2JcvAH+kMfhWhB0uQW14hHfUy14Br
         1s7Tge5tpoCyCqnF10AtWRGzNJCAb5+Q0gLsx8Ms=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Mon, 04 Dec 2023 08:52:31 +0100
Subject: [PATCH v2 18/18] sysctl: constify standard sysctl tables
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231204-const-sysctl-v2-18-7a5060b11447@weissschuh.net>
References: <20231204-const-sysctl-v2-0-7a5060b11447@weissschuh.net>
In-Reply-To: <20231204-const-sysctl-v2-0-7a5060b11447@weissschuh.net>
To:     Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Granados <j.granados@samsung.com>
Cc:     linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701676350; l=624;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=iOBuDxNgWayHfZg8ll4jl4+gQO+POEL5ZSXO0IYskQo=;
 b=bcxZcbAl3IUbAiyq3MmFXuykvVpQnzM+YWbExIJXohNBpBz3JEWJo7sT7X/oXLjwCNCq/Uf7w
 /af+RETE8JFBNjQumlPQ165901a6AM1OKKo8JHVeUGKYxVfkiX6XZfN
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recent changes in the sysctl allow sysctl tables to be put into .rodata.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 kernel/sysctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index d60daa4e36fc..e48a60887c7e 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1615,7 +1615,7 @@ int proc_do_static_key(const struct ctl_table *table, int write,
 	return ret;
 }
 
-static struct ctl_table kern_table[] = {
+static const struct ctl_table kern_table[] = {
 	{
 		.procname	= "panic",
 		.data		= &panic_timeout,

-- 
2.43.0

