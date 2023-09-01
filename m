Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B61878F6DC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 03:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348114AbjIABvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 21:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348084AbjIABvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 21:51:00 -0400
Received: from sonic317-21.consmr.mail.gq1.yahoo.com (sonic317-21.consmr.mail.gq1.yahoo.com [98.137.66.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 255D410C0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 18:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.ca; s=s2048; t=1693533054; bh=L9REntYF/zXAO2oNaev964whRRHFPl/mlPOd/OADDHw=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=AGkEX1KHoYHChGKtF2ml9G2VCUMmRekcDy5oCZRC1G2jVB8U1wZ9Jzuff7/AvxbB0QHOpRLxY9aQSyZgyvc5gdDDSjSw1rSYRLoGoweR0bW9YgZ5xEyUxdPPyxrQvf0zCtYJTkWsTjPEhM5pGes8yJ8HkXD7Qo4XHIX1qTF1RcxeXR/AqCYRvaNzbgtL12LbYg3gbfAuIrd/DtM784ukmi5BYEWJ0dESgxh1y1mt9gmZN98PjeXmIjnZTDoDCqYFCSl8skTr0Ep6KHG4rbIsQ07pmw2fWdM5Nr8d+xpRc9DCHZa2Gce3SYd2gh2/g9LxfhhVN+HVw9ffK3yUYMf+Jg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1693533054; bh=uHmsxUahEC/sSzEpEqCS0VZhAW34DZH+lRe0lWX4A2j=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=pNPXbhEZsCXyI6iDTwc2bRzDkwoiFFqT3zWgQ/WCKgiSlOQA/jA3huqw6e7u9POMuRHsSEwACqJtr/pT/T3OpcOcMc2o9VDgYUpvi580AqJOrv1SJ8Y9sNvZ5zG4rNM/O+sm1yqFEbuJiQ3Au23i8fox1cmJda8eE1EdY60OK8pAOu2WFv5IEO4COF8keXZ1qt3/HFJJHOCr2TroYUUoNlUVcCJGcJXF7Gnu/4jiJkmSB7IHD+S20QpjEUAPRk+px/qIbyEA5rewimmLqoQCSpHGzy24a4LyzhxojsGliRZt+FGf+t5qEmzEONZGnYZajGcoExhUbo74dbLoJHPmEw==
X-YMail-OSG: mhv9CEsVM1ngUOHx2I4hFOAbi6zk.LviGJcgIMu1s2wNbIzxMlIJXWNg.cBAtlc
 EIyZ6jd.lcYwki6LrXwRv0BQ3iSBVa4bVszKOzf9JUU_mmbJsob.Yy3UTXbXjBT3SJUar5DSII93
 oSC6eh2Mmw4agTX3B66CAoKTbLfhKp_HqCm1hrLoFsjrcupbrgM9Lyy61Hc7Ou.goohNd4_XBHAh
 hZJ2yx64v9M.jWg0rLI7uZJ2RLdDcvYKzVqvjHDwtkrP5aUwtVKXs6Mh_qRUtwSePRvt45HgimAq
 qT9OfGyt_9BYUGXW_cvwlcLUjWQtJXU3.yj0TviUiaM3GEGazuNc5Je8XVspz6P205ijE7efbXiZ
 haTEH._eg60IFFvqNxi3.lIY8d5YIhSlT0Ja_vKOb89eRz68_R1n3Ajd1GIPBUByrr0L1xJSoQr8
 ThUK0TkQUquhL6_Z2GWbaZU4iM_kUtkFo.OnRlr5OJstfUFyphb3C6HO0VEvs2t_5.BrNlCwXh7m
 9_Gk49lXuvhlbVYOJwLJCI.ZXE.VXnLQgwo3E4SfCygX4tQeKHc71dguRfAUcCXfQmDItuJ60Vz5
 gjg8WxYFpbzA00maUQnt2TwM2Tm5gFmG.yW7HfKp7mB388v3ru.F0XKQJiI0chwfjhAmt3XbQazk
 uphun0kSx_4nhJ5wStCnyMEEHXTxDwBYEeyaOKqY38Sex7sCH_0BZu.jLnghHQPnmwPJW2DI34Vk
 qTm2Gks4BdUI4IAr.j9jl.PTar5vPVOoBS4Upw6hM3kp.vj20SvpxYeDRhGUXTVJu1Twz_eeSTtX
 aiArfkKQppfzzaEay9jayG2WmI3jF_PAlnOpsRX9P6lQ4DWiEXOAsHrREmEdN07lFYU7sjqYI2WL
 dj7yGsB5.xUiYNRO6WSULjbI3s.NPrDC1D7ekTubCzCuvD.bYVwUq5F_2IjfDkAmId951_aMPuYI
 IKVccdToZoci7asYyiNIQ4T1rRHvbRcDX36BkQRqCPW_exVIi16mTmW9SxiAg2bARiASPBCQWr9U
 zGDN7wfkrPOh89K8v08pbEimr65Pkj7on.9fUuBXbcTTNijxjx3uy5_ZYjYuI9OpP81il8dOPLMV
 u6jMRWTBeWqYK90wwRHkgqLQa1rln3uthfeGHp9O_0McYpq9AaKM7pNUk.z9qFWNgg5XECkoVEpr
 PsV9wDWNxgrYocTRkOLskV3y_zrdTzKYilKZ8frsPY1RMlujdMdH5FhwoHHWqzBpoGlUSxglwYn_
 VyIRvaEStZBgS_pOUncH.e3E4qG1aUXDIZyPnU0Rc2fDUQVZid1k47LiS2xe6boj66NpkoB729Ga
 3F5CJcHJsO5_bR0sFM9bP.3MpDJqtSu3w9waaObTxsVptNlmtFsFIoX1Uo7Pa99mp.9wQ5JGYBzE
 .lhudm9_AJ70gdkxawVZV.Huty5iM9xPJOUnzARLa4G1lLJnf1RmNW4munmzvM1GU9hCO1z8d4.p
 eIDrz7J.jLWLQ1uCVwmI9xRQMBUeZcySbIwDbxg5rdHlQCKuzKtppaHNg.7o6ttufE.UlRjrV5Ta
 G7iUjKMYfDDixlldGMfN3vRQSAL5YMxHiYLlWeG0TppNHYlVolAGukY3zjJQbBKH2unTDTQ3xFPM
 z3UDOjF04D1lY1JhU2NU8pGoztovPAbjvTduPfOu6BT7WPMTpOenbBUY.q0SW7SH1Hu2X6FRMzjQ
 b6FSUOIKokwDwHiYkSXF7xnw7HZS.HF74jcR2cPwwdCMCeXodPVRbRfXhnWwouurFA3AN1bLpYDM
 pZOm3gGGswMW5aF5gRore3_C2FTyuN0.kFFbmEzrEQfhISAP60f1jq4rosohcZwDg.O4usW_GyOM
 bn0eD3N0lAflbJjp2PmNzlv_7t2_Q3oLLO.bkcS_S.zQl4XHB4nr63747Jrdw8sWu7vUG2XcD.Nw
 4lpXyNkRlmVUMK.KL3.o_HXk3558vVzT5TPFjB3VOsDzXTSsP3mepu5lJpgK.m781fcQJTv1uW3P
 f5Cpl0ENOAwrcMok3ubfNyg7fon7RvOAO1IB4pVo.JqAgePvWazcI6vkX3MC83efSbYDZWhwg8WO
 3QhAkhl1l__3U8edkmz5kWF1.r7CkqrLvFh7S6N4eLST17GtTE5CdTyJHEQRQepuJw7cdg_pINZH
 7YGjQ5ZurdJh71z4xT9EAhgiA0ODy1BRT_4_YNDMN0xtqRsLLAHpG6EG7lZH188Xu88UYF7zH7mI
 s6mdpzsLncvSsnG6TmgwTZyJf_r4SzMrXwuZ1mYdYbdUEh26tcZH_yqH5tu6KRKJGb0dVPc4Ce2y
 65a8xxGmYEg--
X-Sonic-MF: <earl.chew@yahoo.ca>
X-Sonic-ID: 0e6098cb-68d3-439e-ae37-b02668ef0725
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.gq1.yahoo.com with HTTP; Fri, 1 Sep 2023 01:50:54 +0000
Received: by hermes--production-bf1-865889d799-k5x9p (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 818f3a9de4db3b338def2b96e6235333;
          Fri, 01 Sep 2023 01:50:50 +0000 (UTC)
Received: from localhost.lan ([127.0.0.1]:51082 helo=localhost.localdomain)
        by postbox.timberdragon.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.95.0)
        (envelope-from <earl.chew@yahoo.ca>)
        id 1qbtJ9-000Ozs-SH;
        Thu, 31 Aug 2023 18:50:47 -0700
From:   Earl Chew <earl.chew@yahoo.ca>
To:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     peter@hurleysoftware.com, earl.chew@yahoo.ca
Subject: [PATCH 2/3] tty: Serialise racing tiocspgrp() callers
Date:   Thu, 31 Aug 2023 18:50:30 -0700
Message-Id: <20230901015030.2469062-3-earl.chew@yahoo.ca>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230831143645.2298799-1-earl_chew@yahoo.com>
References: <20230831143645.2298799-1-earl_chew@yahoo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only lock tty->ctrl.lock once when processing requests
in tiocspgrp() to serialise concurrent changes. Since
the introduction of tty->ctrl.lock in commit 47f86834bbd4
(redo locking of tty->pgrp), tiocspgrp() has acquired the
lock twice: first to check the process group, and next to
change the process group. In the rare case of multiple
callers, all can pass the process group check before each
taking turns to update the process group.

Signed-off-by: Earl Chew <earl.chew@yahoo.ca>
---
 drivers/tty/tty_jobctrl.c | 40 +++++++++++++++++++++++++++++----------
 1 file changed, 30 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/tty_jobctrl.c b/drivers/tty/tty_jobctrl.c
index aba721a3c..462fdf7b2 100644
--- a/drivers/tty/tty_jobctrl.c
+++ b/drivers/tty/tty_jobctrl.c
@@ -30,19 +30,24 @@ static int is_ignored(int sig)
  *
  *	Locking: ctrl.lock
  */
-int __tty_check_change(struct tty_struct *tty, int sig)
+static int __tty_check_change_locked(struct tty_struct *tty, int sig,
+				     spinlock_t *ctrl_lock)
 {
 	unsigned long flags;
 	struct pid *pgrp, *tty_pgrp;
 	int ret = 0;
 
+	BUG_ON(ctrl_lock && (
+	       ctrl_lock != &tty->ctrl.lock || !spin_is_locked(ctrl_lock)));
+
 	if (current->signal->tty != tty)
 		return 0;
 
 	rcu_read_lock();
 	pgrp = task_pgrp(current);
 
-	spin_lock_irqsave(&tty->ctrl.lock, flags);
+	if (!ctrl_lock)
+		spin_lock_irqsave(&tty->ctrl.lock, flags);
 	tty_pgrp = tty->ctrl.pgrp;
 
 	if (tty_pgrp && pgrp != tty_pgrp) {
@@ -57,7 +62,8 @@ int __tty_check_change(struct tty_struct *tty, int sig)
 			ret = -ERESTARTSYS;
 		}
 	}
-	spin_unlock_irqrestore(&tty->ctrl.lock, flags);
+	if (!ctrl_lock)
+		spin_unlock_irqrestore(&tty->ctrl.lock, flags);
 	rcu_read_unlock();
 
 	if (!tty_pgrp)
@@ -66,9 +72,19 @@ int __tty_check_change(struct tty_struct *tty, int sig)
 	return ret;
 }
 
+static int tty_check_change_locked(struct tty_struct *tty, spinlock_t *locked)
+{
+	return __tty_check_change_locked(tty, SIGTTOU, locked);
+}
+
+int __tty_check_change(struct tty_struct *tty, int sig)
+{
+	return __tty_check_change_locked(tty, sig, 0);
+}
+
 int tty_check_change(struct tty_struct *tty)
 {
-	return __tty_check_change(tty, SIGTTOU);
+	return tty_check_change_locked(tty, 0);
 }
 EXPORT_SYMBOL(tty_check_change);
 
@@ -489,12 +505,7 @@ static int tiocspgrp(struct tty_struct *tty, struct tty_struct *real_tty, pid_t
 {
 	struct pid *pgrp;
 	pid_t pgrp_nr;
-	int retval = tty_check_change(real_tty);
-
-	if (retval == -EIO)
-		return -ENOTTY;
-	if (retval)
-		return retval;
+	int retval;
 
 	if (get_user(pgrp_nr, p))
 		return -EFAULT;
@@ -502,6 +513,15 @@ static int tiocspgrp(struct tty_struct *tty, struct tty_struct *real_tty, pid_t
 		return -EINVAL;
 
 	spin_lock_irq(&real_tty->ctrl.lock);
+	retval = tty_check_change_locked(real_tty, &real_tty->ctrl.lock);
+
+	if (retval == -EIO) {
+		retval = -ENOTTY;
+		goto out_unlock_ctrl;
+        }
+	if (retval)
+		goto out_unlock_ctrl;
+
 	if (!current->signal->tty ||
 	    (current->signal->tty != real_tty) ||
 	    (real_tty->ctrl.session != task_session(current))) {
-- 
2.39.1

