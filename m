Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 359B27B1D5C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 15:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232691AbjI1NH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 09:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232648AbjI1NHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 09:07:21 -0400
Received: from sonic314-19.consmr.mail.gq1.yahoo.com (sonic314-19.consmr.mail.gq1.yahoo.com [98.137.69.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA69198
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 06:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.ca; s=s2048; t=1695906439; bh=e2KtUh0oKNAe6oDI0AVOcxukZgaoJiw9ioLVuekfuIY=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=LuA/rzrpRTbXCHz34/Vz2AW0tN1TR2xTs2F+TZRCj7zbNvATZsWrrdjCFvX6XT+lK8pDLpxLgZmEp/UgG2QgGBTkNS8fdovwX2G710TebURTXzYQzZuNgxRa5IjrGzd5dY5goFo7h3oUvlf1W+sUge/eIwDXvNcxkXqUNugFKa2Xb2EmKj4Pe9TaM4JAgZRTLai0ZZB5ept6p8I4EEKQ6d9FfymRzHh9N5WP+cMJ3E5+0ZTy9bwELWpeFqKwv/H0SX+vUJOwNLG/idbQ9AgbaUSuwehwM51dVHsgvdNMgqgBE+neL7U6U94EBlPhFIvGQsCPHjR5lS3pUSNGxe0mGw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1695906439; bh=18wWcx4DpHbDYKD0rxIEyXdOtORzeDGAJkqj1ELdoR2=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=IanO4OtK8W7Z+z3kYqelO8BFZ3zo9sbl0Cr7q4iCnVzL+xBaurTYN/B2SnOBclehAWAKAfXA+Cb7BgBemEmBLta11F66NynmvFwPL7oD3YAPJsTXB06wPpY1nK1YHekFrHfXdDPTQhQpbqlAXn7J2AmIZdOcuXRKTU5F4DdRZmePiP2aJaNXrPYTZ/nzrJIlmmNpsHW5ckLgajwzu7NHeRxMPpv1Xdr8CeXfUaEH2dTuTAQ1hvgD4oBblNsjK8/hgZNUzTK2MddLb/ZTPVz0WasL8AhCaVxNe+/LFwlM7OiwNmNWcUVNPdLak82KTBjUsdxSAdRTo41NkY0GnrpmyQ==
X-YMail-OSG: ECoKszUVM1nQr3scqsgy_QSZqT.dag4M3p23TuP3Rxncn3EnCBpzAlF5MegMAYI
 fZqU3HVZ9kwD7ZKJXEfNxRZOwczKZDczxzXGRVbmrK7fKOGxY6iMbPLRC9QqekP5nszhzBXUjcHA
 IEBEPsImVLkq2_wCB14rzaaCgpIuZVl6xghSNSB8NlfSKw06VgCajJJB39ic6PIrd45hvayBjoST
 AIFS2aDZT_CaTJJUcDrJMSgzITzVaE.uqB_tl62wDUW_7n_OcRv4xFaG9mA0a.5ahs3g6FJ104oZ
 SGCi653zOpFQnziriH.6jQ4lIZZvHLMWgJx5RS3FhRXbCdndAErrTUyRzauH2UL.EWXSXjNh052l
 pg__6QibpPk16U1wpLhBFYMEiEAmwArIC8_C8IgeaR1d1IDj63OOJ1Fuc22PzN_FeE9tJuVwYqvQ
 Z7k_t8cxW.QIT5HEugpMCk2P1J3xx9UKeNASaYnKvSnVTL5GTj_I1Tc9vkW2oESNnHsfMtK5xCLt
 TlPsoS.VRyy4HLH.aMb.7WmSQhz64fAjGaLWI53_zrVPPytL6o5iHcdeoYSGsqR9x2GUsndTJk_O
 Y.2LgThAjGg7KD2_CfZV.RMmdHk4ADrDRRSdQhl5KYaHJ1SfO8tgm_We71WdN.2M_UIbpSuWP4Te
 YXse9Nz6fU81uNuDR3BTc6Nmydqmp4aE08l1fPyAQafcsBrVnY6Gsxeq75k8MygIrBZTU91uw4up
 5NQhJfsfJ63W5oSbYSUBLUxVCOcdZQi8jq3MIbjLgS.BpwflQexI5OpHIOgnaLpt_qT1nqH_Ziwh
 H2jdvk7b538f6az08m4UgopEhOhIEEG8_xJyzVT7C8UHcxLwSQM_s9Dik2glA0z44mqUw5MUHX9B
 JRr0r_j8tAi1nbs8lHPr5QSJF4oimg8TPNBAVi4VWsZJL5B5coFbUHZZpVQBP1PT0CRP9tHcjPe1
 9v1YwqVzAuvbWk4HBpaOO7bf8NQdP87A49X49BTEkInF4a5UM8Ivz2l6GB2RXaGA2ACo0tXeC63r
 y6xhxvvpzOkUkUTqQJDKnkrJC2VVXv9GHFx.iH2qGKs9Rv5HU_kCUgRX0EOERJXWBeJgPXheyl8r
 XvVOInsldqKuJ689LrEz1M6IINsiHM3PaOwW2XgNguQ85neek_8Fr7dJUbv1ziX7C7vt_5ASSbpM
 bVcPnuLWqC_fQlqhzhSLongU36vBM49pXGdihxhIVr0HcYGSr0byiSZBX_Y5QeKvjR81Samqud8L
 ayt5R2VRjYU_cFtzMe26rfwxYNrD7qLSu2T3p62WYVKci5vh4vLoDmh7puljNFto1qDCXNrqjcsG
 xOAJ3Xmd74snXnwOpwdQJq_9q80tG.IXSLmN6ehT9J0DX8nJCR2gOLZ2.33Qc2NZ4m1YECRgdHqu
 QccxSwCltEfSQ4KdLW5JUIXRg7.lamqMTLyb7uC1ON_le1eONoUXBnMI2zdau6GYHxrFQJ0uoSBo
 huyNKAfuey5ttJ9awfUHNsAHqmTW0hmTAxtYioUPcWLfxIMCBF0uix96398ShXCeCm11dQ8Pf7th
 9Hyx5t66ZWnyBQg5OUaZHIw1c4PwCjhDcuO6f1vTHfl8X1_zZthlJ2yQRz54ym4aNZ.T482Lwer7
 tKXRwxfgPvYKHbPggs.0bZQIu8PSRD9vmcq_qCzS78HOLY14TVXRVq5pMMVQHJjlZzYEl1_zZG9W
 KTMgXdrAqN3IlkaPhlgRVtaSqDEBEW8XdIv5H_Xq.Zq_TrK23V6YJ2NNatwjTuZJZG25SkwbyTFN
 ADT9On62F5RpxASXVhQWDqZtxBVDsAflQKLt_vHukDQkYl.crNFFml4UX.jJZa_wTe8VbG6JZXIx
 IfpHMz46CZgUYDkxAo51cHmiGgLR9Y00cSp6TRZNeoNZ11IIARowQBJqdUyTUcnBgHwvciMj1m6C
 Ed.VoT_BpfbBWQtljHmgdFO_B6QTm8DAA52ShqvHO_1Izh_003jQfkgU9KmTPuWdZaIj6z2pJFIf
 tODxzVOvi38YXMAAzUMcy5VzirJ2ObNWVadaa_X89fju8DOdCJ_bKIdG_R29V6BVKFe.oJQ1Hr_U
 9I9Y7UWs4nvB9zWB4oJN5XOgNhZEPif9xhRTVDmm8rB9DFwbGanmOvwXlEi_ifWwVoFT1eC1IACJ
 d.FDmrB22y1X6j8qiWgVumOgBtUCQYsyeEPqRi24qheypwnhWefj94IksbQFnW12hrjBXKMb33xW
 Q7tyLbiThO7nKirfUFXf3wA4IIbPsDXsuCcrrabTsFdKvAaovQR33Gkguf0e7R93jCoV8zYmZoVK
 c
X-Sonic-MF: <earl.chew@yahoo.ca>
X-Sonic-ID: bc7e95aa-3df0-4daf-b352-57edcb1227d7
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.gq1.yahoo.com with HTTP; Thu, 28 Sep 2023 13:07:19 +0000
Received: by hermes--production-gq1-56dd58fbdb-b8g5x (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 0b8ff48338d2226adb5aa11552cc6b57;
          Thu, 28 Sep 2023 13:07:14 +0000 (UTC)
Received: from localhost.lan ([127.0.0.1]:52224 helo=localhost.localdomain)
        by postbox.timberdragon.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.95.0)
        (envelope-from <earl.chew@yahoo.ca>)
        id 1qlqjY-000fEn-Nd;
        Thu, 28 Sep 2023 06:07:12 -0700
From:   Earl Chew <earl.chew@yahoo.ca>
To:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     peter@hurleysoftware.com, earl.chew@yahoo.ca,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v2 2/3] tty: Serialise racing tiocspgrp() callers
Date:   Thu, 28 Sep 2023 06:06:58 -0700
Message-Id: <20230928130658.4045344-3-earl.chew@yahoo.ca>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230901015030.2469062-1-earl.chew@yahoo.ca>
References: <20230901015030.2469062-1-earl.chew@yahoo.ca>
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
("redo locking of tty->pgrp"), tiocspgrp() has acquired the
lock twice: first to check the process group, and next to
change the process group. In the rare case of multiple
callers, all can pass the process group check before each
taking turns to update the process group.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202309012304.un7EAdgl-lkp@intel.com/
Closes: https://lore.kernel.org/r/202309011252.ItlD27Mg-lkp@intel.com/

Signed-off-by: Earl Chew <earl.chew@yahoo.ca>
---
 drivers/tty/tty_jobctrl.c | 43 +++++++++++++++++++++++++++++----------
 1 file changed, 32 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/tty_jobctrl.c b/drivers/tty/tty_jobctrl.c
index aba721a3c..da028aadf 100644
--- a/drivers/tty/tty_jobctrl.c
+++ b/drivers/tty/tty_jobctrl.c
@@ -20,9 +20,10 @@ static int is_ignored(int sig)
 }
 
 /**
- *	__tty_check_change	-	check for POSIX terminal changes
+ *	__tty_check_change_locked	-	check for POSIX terminal changes
  *	@tty: tty to check
  *	@sig: signal to send
+ *	@ctrl_lock: &ctrl.lock if already acquired
  *
  *	If we try to write to, or set the state of, a terminal and we're
  *	not in the foreground, send a SIGTTOU.  If the signal is blocked or
@@ -30,19 +31,24 @@ static int is_ignored(int sig)
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
@@ -57,7 +63,8 @@ int __tty_check_change(struct tty_struct *tty, int sig)
 			ret = -ERESTARTSYS;
 		}
 	}
-	spin_unlock_irqrestore(&tty->ctrl.lock, flags);
+	if (!ctrl_lock)
+		spin_unlock_irqrestore(&tty->ctrl.lock, flags);
 	rcu_read_unlock();
 
 	if (!tty_pgrp)
@@ -66,9 +73,19 @@ int __tty_check_change(struct tty_struct *tty, int sig)
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
 
@@ -489,12 +506,7 @@ static int tiocspgrp(struct tty_struct *tty, struct tty_struct *real_tty, pid_t
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
@@ -502,6 +514,15 @@ static int tiocspgrp(struct tty_struct *tty, struct tty_struct *real_tty, pid_t
 		return -EINVAL;
 
 	spin_lock_irq(&real_tty->ctrl.lock);
+	retval = tty_check_change_locked(real_tty, &real_tty->ctrl.lock);
+
+	if (retval == -EIO) {
+		retval = -ENOTTY;
+		goto out_unlock_ctrl;
+	}
+	if (retval)
+		goto out_unlock_ctrl;
+
 	if (!current->signal->tty ||
 	    (current->signal->tty != real_tty) ||
 	    (real_tty->ctrl.session != task_session(current))) {
-- 
2.39.1

