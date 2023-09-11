Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96A3379BCBE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349275AbjIKVdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240841AbjIKOz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 10:55:29 -0400
Received: from out203-205-221-205.mail.qq.com (out203-205-221-205.mail.qq.com [203.205.221.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F16A118
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 07:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1694444118;
        bh=W6nM7/UDdiAqrpjGPNvRU9poeoJlycuMqUU1DG3/VBE=;
        h=From:To:Cc:Subject:Date;
        b=GQfWDN/1dm3vnIPTdaTpc5j55wdc+4KKOI8kZJJHHEKgGxtHk58k1CXi3iuujuLT1
         G4OikxZPhAC9vBtTAjx1cvvAIJ1H0DtO6iUtOpMvc++VZaYZ0VnbMjxtz85H///YJO
         T712KGXm5qGmSlLVJl+mi65R/RLWvseS8FIf4/pA=
Received: from rtoax.lan ([120.245.114.155])
        by newxmesmtplogicsvrszb6-0.qq.com (NewEsmtp) with SMTP
        id DCF3DE64; Mon, 11 Sep 2023 22:55:15 +0800
X-QQ-mid: xmsmtpt1694444115thrge2pa8
Message-ID: <tencent_157A2A1CAF19A3F5885F0687426159A19708@qq.com>
X-QQ-XMAILINFO: MyIXMys/8kCtMYRSom4Xuz+vWkITKDcXtZ3RPgANn8mZ+UPkUHBSOfH5JdTESQ
         dyS2vnpWOKAdbZiEoIw+wM/cRuwLht26+trhW5+X9qqqSU2ZhRo8XHKDsjOtaCaa8GVxBvpsGyNJ
         tRTQd67yj/w/ABpTtwKoJ6nSYLaxUlcM6PHXXaC8lTZxI70YdPhgQQKnROcyfny7lLVeDhSdYFDP
         0l/8NXbYxusW8MaYmFLaR8Oy0o6QR5nthpkFyEOt9NXMjd2t/+0zx4C2aloEBKefzFYZQ58AI4Cb
         69J660ermheGs7pdZ4TCe4AJTHmrzzV2Y6H+i/Ky8aZVdDDrfOSb6lLSQ1r9JXusXtIL8SaBMc1E
         T0FavmzGinkFjlj6eZtJTcmGEIBh47E4KXwSiA3VcyGyep4pfFrapy4KP80FH+0gpKcV7Y1fbGUh
         Fx8C+6Nz2QfTjVYVOfZ6BCzIKcXg79Tlz0WzhI7BXZ/KCjPUmV5RiYdhWjTIjr1G1cFW/gsThc6+
         KjTzEjctT9HZM134wLnOVlPanTEQmBK+Qf8FlDX32axGWrrp4bWf5t8SgmHsZ86dhS31ZJ4I56St
         rkC/Ku8izhoqBVKj1TJBbVmrzfiGva0kqb8aRo2H6ZDYL0e62WzxGn0RALW7h8h8ppCXTFjrPJt5
         wBD/5C0950cjEdXpwdHBjoYIp84gHl0fUysmAzBEdeCQf0dr+UkXVZXG5WJrrOfgfI9QwBXmsXXp
         B6Q8xLRtrGjGPk89bzjbuqHiydRU+94/qm8bsqFLzqthmhJOP6Zcii4uxNW37LjRDGsjQbdFSTQ/
         lqsl4gWNXApNU5VneDG3ESjJ60Ou8FvOmVS1G3O2K3Kx8bpnjdvNU1zJfCm0SLrwBq07PmmrjPSG
         bntXaPGBLyVrnO5aYUDyOEoYakGMaNIGYauCtKvo/OsNeOyzJu2prLjUUobPZ0F4WY2le0TcUREg
         dv+abqG9XNy+vwtaec3tvQRZEguGYJzWSOqzIXcuZhO1ucziivA+HPqbAxnx0cDlUCoB2uciO+vE
         FqtSEYl5OU9UW/Xik7FMBwjITAcGk/deryhQv/8YK7+Za6NKfkcxGrf/a1RqY=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From:   Rong Tao <rtoax@foxmail.com>
To:     akpm@linux-foundation.org, keescook@chromium.org,
        brauner@kernel.org, rongtao@cestc.cn, rtoax@foxmail.com
Cc:     Jeff Xu <jeffxu@google.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] pid: pid_ns_ctl_handler: Remove useless comment
Date:   Mon, 11 Sep 2023 22:55:09 +0800
X-OQ-MSGID: <20230911145510.29246-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rong Tao <rongtao@cestc.cn>

commit 95846ecf9dac("pid: replace pid bitmap implementation with IDR API")
removes 'last_pid' element, and use the idr_get_cursor-idr_set_cursor pair
to set the value of idr, so useless comments should be removed.

Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
 kernel/pid_namespace.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
index 619972c78774..3028b2218aa4 100644
--- a/kernel/pid_namespace.c
+++ b/kernel/pid_namespace.c
@@ -286,12 +286,6 @@ static int pid_ns_ctl_handler(struct ctl_table *table, int write,
 	if (write && !checkpoint_restore_ns_capable(pid_ns->user_ns))
 		return -EPERM;
 
-	/*
-	 * Writing directly to ns' last_pid field is OK, since this field
-	 * is volatile in a living namespace anyway and a code writing to
-	 * it should synchronize its usage with external means.
-	 */
-
 	next = idr_get_cursor(&pid_ns->idr) - 1;
 
 	tmp.data = &next;
-- 
2.41.0

