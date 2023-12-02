Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28938801EA0
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 22:22:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbjLBVHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 16:07:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLBVHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 16:07:30 -0500
Received: from out203-205-221-210.mail.qq.com (out203-205-221-210.mail.qq.com [203.205.221.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8C0107;
        Sat,  2 Dec 2023 13:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1701551252;
        bh=VWfb+Oof5K+/qAsblEllhoGVJptKMJhsPx5j7DgelbA=;
        h=From:To:Cc:Subject:Date;
        b=eTNUBpMirTPOzb168hbFitzXTV0rCuYP3RNp7TQ699xf/TP0G149xq/fh+TzEhw2W
         ttoSB1Wu/Voo1l05NZAU4hLpE2r9S5maaUD3aRE5V1/nue6H9Jv9SO/Yl/b5tGlj7f
         FmpG1Gn9nyPAss5b7GFryhRqSwcj2RuVW8XZBrF4=
Received: from rm-workspace.. ([116.128.244.171])
        by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
        id 1DBA2603; Sun, 03 Dec 2023 05:07:27 +0800
X-QQ-mid: xmsmtpt1701551247thbhr8aak
Message-ID: <tencent_03EDD0CAFBF93A9667CFCA1B68EDB4C4A109@qq.com>
X-QQ-XMAILINFO: MmPNY57tR1XnAJhBNiCUAVr9YIJBvy1yMV2dHgPMD1aC0rNbkcD/tg5g7ycdRu
         0mHJ7BGScmA71+pO1OwAngMhGWsaOXnWSxo+r4wg71Zgy8KUwOp/rwr8ty/ACUvltuOBciBk0PKy
         nXhP5DcExj+LrbechxpBcb1T+8+ZgQnFeE+TkZt92z43sZD5a5DCS8OrjMdpAzWmfPjZVQQ4tyfG
         VuHwz2QO3zoTUipwD6YVud2a9rXkleFS1hHCm7U2/jUgdZFVpAX4h8MyhfTdKQkr+V5i+mTYPZ3D
         tPOKDnjGt/huw9eGT8FPYKXJNYHu8tRaZXNbFpbPb8aDHMloxOojPaasdi8moPTGTYj3r/iR0f32
         VJBbtCenwpGwtxngQGZ+q8Is5DOrWTFCz+eWl36wR3/LHisef6LhIn3/4Tqi0Be/xLp/IJVi1h7i
         ZjejXM7M/QXvl77i721HncndbuIyIUYWMxfgFv99BnXnBdi9suHIE+R6xWLcPgWYjuYExvKVj5fO
         sF5a8ePLTV5KpczPzTsfrF1Sug+79Ba6n6DKiyBUzAfdL2eV0FLhkWdFXnIBtsFOsJFLKGhQxmCw
         tGduW+ME3Eg/lEOW1jYQrhHG9+USxxiFkmsUsK64F2qQuRiHVX9/He4sxm1j4YQQuqdZN8yFmlGA
         n7heHIrj/gf/xPR7XdcH+WV0iwVv4a46Z01tPWElvxZU2sQpwurZhqb1cBDa5vfOoGPiZyhjWLbj
         DodoSyTJtiBnqu7Sa8Ko4aXeToHOLsOTFUUOcNddYdgx/u6h1/EgPEvL8OQKnOZnMkZWNsMvbqru
         csVo/mKA670PsRZVQwxfEmHerPHWL2gkJAYLW+0lE34bd1cOAIvM90l9KQQQq4P8QcOkp/+Futd+
         J3MY6Kfh64dyVjuEWgLYb3cpBUjiiHhzvrnzVdVx8DK3pTEZkP7mG9DawYTBKYBkLGNONyYTWCpX
         rr+yFjaqCdcvTo9iuekP3KTNtGqD9lUIqg8DizK6ZndwSh0ZRnAeobrvaA+NW8
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From:   chenxiaosongemail@foxmail.com
To:     trond.myklebust@hammerspace.com, anna@kernel.org,
        chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de,
        kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        chenxiaosongemail@foxmail.com, chenxiaosong@kylinos.cn,
        liuzhengyuan@kylinos.cn, huhai@kylinos.cn, liuyun01@kylinos.cn
Subject: [PATCH] NFSv4, NFSD: move enum nfs_cb_opnum4 to include/linux/nfs4.h
Date:   Sat,  2 Dec 2023 21:07:25 +0000
X-OQ-MSGID: <20231202210725.706925-1-chenxiaosongemail@foxmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChenXiaoSong <chenxiaosong@kylinos.cn>

Callback operations enum is defined in client and server, move it to
common header file.

Signed-off-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
---
 fs/nfs/callback.h      | 19 -------------------
 fs/nfsd/nfs4callback.c | 26 +-------------------------
 include/linux/nfs4.h   | 22 ++++++++++++++++++++++
 3 files changed, 23 insertions(+), 44 deletions(-)

diff --git a/fs/nfs/callback.h b/fs/nfs/callback.h
index ccd4f245cae2..0279b78b5fc9 100644
--- a/fs/nfs/callback.h
+++ b/fs/nfs/callback.h
@@ -19,25 +19,6 @@ enum nfs4_callback_procnum {
 	CB_COMPOUND = 1,
 };
 
-enum nfs4_callback_opnum {
-	OP_CB_GETATTR = 3,
-	OP_CB_RECALL  = 4,
-/* Callback operations new to NFSv4.1 */
-	OP_CB_LAYOUTRECALL  = 5,
-	OP_CB_NOTIFY        = 6,
-	OP_CB_PUSH_DELEG    = 7,
-	OP_CB_RECALL_ANY    = 8,
-	OP_CB_RECALLABLE_OBJ_AVAIL = 9,
-	OP_CB_RECALL_SLOT   = 10,
-	OP_CB_SEQUENCE      = 11,
-	OP_CB_WANTS_CANCELLED = 12,
-	OP_CB_NOTIFY_LOCK   = 13,
-	OP_CB_NOTIFY_DEVICEID = 14,
-/* Callback operations new to NFSv4.2 */
-	OP_CB_OFFLOAD = 15,
-	OP_CB_ILLEGAL = 10044,
-};
-
 struct nfs4_slot;
 struct cb_process_state {
 	__be32			drc_status;
diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 92bc109dabe6..30aa241038eb 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -31,6 +31,7 @@
  *  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
+#include <linux/nfs4.h>
 #include <linux/sunrpc/clnt.h>
 #include <linux/sunrpc/xprt.h>
 #include <linux/sunrpc/svc_xprt.h>
@@ -101,31 +102,6 @@ static int decode_cb_fattr4(struct xdr_stream *xdr, uint32_t *bitmap,
 	return 0;
 }
 
-/*
- *	nfs_cb_opnum4
- *
- *	enum nfs_cb_opnum4 {
- *		OP_CB_GETATTR		= 3,
- *		  ...
- *	};
- */
-enum nfs_cb_opnum4 {
-	OP_CB_GETATTR			= 3,
-	OP_CB_RECALL			= 4,
-	OP_CB_LAYOUTRECALL		= 5,
-	OP_CB_NOTIFY			= 6,
-	OP_CB_PUSH_DELEG		= 7,
-	OP_CB_RECALL_ANY		= 8,
-	OP_CB_RECALLABLE_OBJ_AVAIL	= 9,
-	OP_CB_RECALL_SLOT		= 10,
-	OP_CB_SEQUENCE			= 11,
-	OP_CB_WANTS_CANCELLED		= 12,
-	OP_CB_NOTIFY_LOCK		= 13,
-	OP_CB_NOTIFY_DEVICEID		= 14,
-	OP_CB_OFFLOAD			= 15,
-	OP_CB_ILLEGAL			= 10044
-};
-
 static void encode_nfs_cb_opnum4(struct xdr_stream *xdr, enum nfs_cb_opnum4 op)
 {
 	__be32 *p;
diff --git a/include/linux/nfs4.h b/include/linux/nfs4.h
index c11c4db34639..ef8d2d618d5b 100644
--- a/include/linux/nfs4.h
+++ b/include/linux/nfs4.h
@@ -869,4 +869,26 @@ enum {
 	RCA4_TYPE_MASK_OTHER_LAYOUT_MAX	= 15,
 };
 
+enum nfs_cb_opnum4 {
+	OP_CB_GETATTR = 3,
+	OP_CB_RECALL  = 4,
+
+	/* Callback operations new to NFSv4.1 */
+	OP_CB_LAYOUTRECALL  = 5,
+	OP_CB_NOTIFY        = 6,
+	OP_CB_PUSH_DELEG    = 7,
+	OP_CB_RECALL_ANY    = 8,
+	OP_CB_RECALLABLE_OBJ_AVAIL = 9,
+	OP_CB_RECALL_SLOT   = 10,
+	OP_CB_SEQUENCE      = 11,
+	OP_CB_WANTS_CANCELLED = 12,
+	OP_CB_NOTIFY_LOCK   = 13,
+	OP_CB_NOTIFY_DEVICEID = 14,
+
+	/* Callback operations new to NFSv4.2 */
+	OP_CB_OFFLOAD = 15,
+
+	OP_CB_ILLEGAL = 10044,
+};
+
 #endif
-- 
2.34.1

