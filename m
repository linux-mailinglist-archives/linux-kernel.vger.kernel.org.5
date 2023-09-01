Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1F578F6D9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 03:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348105AbjIABvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 21:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348089AbjIABu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 21:50:59 -0400
Received: from sonic308-8.consmr.mail.gq1.yahoo.com (sonic308-8.consmr.mail.gq1.yahoo.com [98.137.68.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C9CAE7A
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 18:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.ca; s=s2048; t=1693533053; bh=cEUQvr2uTGSCKhdlqhEVI5tYhjMFaTNt2CV/uM0iRuc=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=rY5p6qBpJ5PYkPnuBMaZk6GGzKsnZc15ZQQIdqpM3j7QR+vVaDYdP0rXpkCMhO+5VZNkmvf+6Dt6tuceIwpC+1FU55n403RVFh3wZd1XnANnCnk/PYBLlWuSQkuB5RCldocm+l/besA+p8CtgmeoDomhIKUOTH1y4mlg2O6xOORiEKHowyzehUBw5Om2woDWuMUgSGFjfptc1Yxk9ooMiy0HOiBpeGRa4fnXtLB8bhBoFHv37Pj8DQTWMlON14qss6e/MgY49Fb/KPvHXf+JK7Voh3Piu1TN63WfT/nQ7U7Ej2wuvgJdt04tyqfU1mZrLgdT0C1pU48UWlF93BZjbg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1693533053; bh=CXQ1jKtsRfDEoC/Z7UAU3D7S8Rbq7YhrY4GRQ3ZeFng=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=PDsJDUCjNUO1Rx1/o9D+VWYduh3rq0MD3tly3sQL4JvNXhE9bKSdL4enMXcBC+njJgZFOUMU/u8p410+WahxDCcHas2QIHw0ZgGfMT20lAUMU2Df2GnRwbppu3JU2W3tRItWILDEKHB4/AT3Z0Yxft0+x1XVnjO0gL8PfYPJoZhHP/+qwjp7T1DKprN9UGVKeijBU5Yq3DUBvB70mvejlMD306H4JRKTMg8vAhVOGmPW1zBlA4d6KIncruoby7rUw5IE/Is2fShVpunCzEx9aKnmheazsxQ7NFsse0PvwPKKvSjoK4OkWxIraCDViv0NI8V+4WSXpk6UMuohaAnwVA==
X-YMail-OSG: g.pW6K0VM1kJv.jN1MAYmHsFhP1azUPOBMFT3RvuTvEKdblctVXPPux58N8UU.i
 umC1iqb.PvPAJUR7LuHe0PLfBvnyFzbs_JfGJo.n7TPxqEEY9zUYx.zpOSCCkPJ2EPcSf7i0Xd7E
 6XuuqyinOYaZcrffNHane9og4gTjSXeiKuyJ.8W4WjzvRb3hu6oGJpIicDHMpHloaH10sWYVGLFm
 HVx_5wOO9elqfjIQaCJ8A9zxBZYCFWYA8FptbZ15nUdAqDnwLuXFYKbrBhdu1FdaAEUP0xcAvhha
 ONhl5Zg0srMdq2mPA7yvsUEOitoSOSUM7KibfH7HpVj0Qd.UYq3HG18rafPTPLPGm738RtlQOepC
 wI0efHLAGBXs62y31OZCXWLA5ysj3L1r2j1RPiY1_irqNcbFRqYbgch_L8av8bZWmMAoskpVTGat
 kl8SbEpns6T_Zqq6Tl0044KpzSa.O2WzYSCJ370DiIRU6oTc2YPZg7HSGAPzE_wdtMI4OPlNVacr
 p3mHwEt0DdCLqbGnVjqrNW8PDiFLkNB_KC2cVfQOAatVy2lkxgcCTxhu0Y5Z9mmWcNGlPhqu0moA
 d5Hza1ku6hWYyZRTBD5wrRwp8LZ6RQQbCpFdLC_mV5pJ9o7cjB5zJhUEFnJyNySnVOaNVGIZ7mxn
 NbGIxFcdBQxmRn_Zjd3XYWmiH9BcdgdilYHbzoe3O8BxQEI.Fs70xbfSOHhadUxe4oYCEH8r5Fmr
 IdiA5_eEwL8wvkHJV3VPHvuxLe_UCp0RuRLlpb69V44o23uG_fp00J7cvEMe8SP8D9384GtP2qcq
 0CYDYul3ERBZNyd_iif8AZ9.Yr.L0JJpCgi3CVea595AtVvlGHEbkG_sT7syiqstseewqScn_eMI
 aJN_JJ1G9OszqV47z9F2uBh5PNoTNOHYIRHDvfJKNcFFLlsmdhHL5CZYuqMPIEtI3NuUTcueM7B6
 _kX5izxCvIGlltD9vIueghNAmji9etcuceaMXXWCDeEcKtvcsjLk4vJuj05zwgZCJlQMjZFX8H0o
 Jv07pbgQ2m_qNNNefXb7eb.orjU3sg2rRw7kpP0gtgNMDN.JkKKJxjxIDEDxmGy1PERwpNDi3Nk7
 euKvskU.A812CKyjoMdR5915i1QEz3zk3af2d_Ojl6n_vhq7xr90M8T4Uc_ya27TB8cTAzrQcWUH
 91w5af_WmZZvW15N.s4YhfQSCXdKNTe0eKy98qV7HZ8XWG4_Rf7DTyMbVXDrN.UB79RmR0fMV6HG
 M.tlQQQGLRQM.1Ra0KMDFmFRmCItOC.5LSfhCMk6t1o4Db5qKHansx8PLmI0xh8A2jKMsxai4IlY
 hx1FFPe98QjCF8GWxRr3Ofg8IXa_C58_G4TMARwrBo6r0fuH2N1XuoEon_7rtoQbCSEC7dL5Pl6W
 sSzXYPtcRJtDkWfnpGsKWCy.BDpu2Z1q_jXIHiwT3cI9A_HapcruxtXp8btmkH.EGX8dBMvdfwdb
 vXPSXqLdUpyizOWcW1mQb.gAgVQtY7i3fZkBbhKZSnv2dX1SgR1TKuCCl2h.qqevRbd2wLn5lnSD
 srH2bwy5OvolkuwMAeQi_Xznrd4PfSr4PprYI57bqq31apst2.SJNg61CCh3U1BCF1gALdtNW5qE
 YKfUqTdBtUKfnFrRXqlX7gqNKmUYXxojYGVccHlJIGvtxLp2dFBJ0ET9r0lBQ1mQZyFdXlKPQ9_0
 o0cTawP8sbQf7tfebcQGYIN.NjXeFRvTXTsYDyIqJZzJCzLmKlIEYJR4jV4ldRkBWlA5gGH2oQEN
 uHqxEmAQ_bX3hAlSzR0B_qC7zgjb50rwHMosHkRvyq8As2QblTxlI50xik5Xdv_LONe9Gw1EUKCc
 jrwU41Pe0U3RDC00VBdO1K0NE7EmJnj0EIYKMGPKTgVVcvuhQTJAkGtlzSJozVbpk1wM33ddmAGf
 CqWy84_ab3WU4uRA24KfS.pUUN0tuAISYG2ZGT0NgutVvxM4JbHx6lRguPKfXtLmYSbZJBWA2diO
 bewnVIEh2K9M3JOSGhgfcMLbHRCl3UBh377STlQE9WSRs6QwfH4VNk6SShY6qsNaoFDc3gHtyfMU
 lC9ggiKTn0RdBmBvEDOv2h5OvW4IQkr0M4kxSZ2dKCRIJrav2dwyeA1s2l.MFYgndPTiY7mRMxH_
 oxvU382kdDQFUCACpUsA4rIi3P4nnXiMsOXR0OZaaHYi207nNmt_kpUACCUt2tDeOXjPSd95wllm
 2pfkDbc3sE7fl17QSNHc5rfN8h04ojcPVVZ6jOtRW3dqstFhNFjOSueQTjzt63.3ZXPUZgIKyAWI
 b4LLPmqFz
X-Sonic-MF: <earl.chew@yahoo.ca>
X-Sonic-ID: 65bcbf08-331b-40f3-9a98-7e527f8885fe
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.gq1.yahoo.com with HTTP; Fri, 1 Sep 2023 01:50:53 +0000
Received: by hermes--production-gq1-6b7c87dcf5-x8vcl (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 60da8287d086a81e38515550bd7ddf20;
          Fri, 01 Sep 2023 01:50:48 +0000 (UTC)
Received: from localhost.lan ([127.0.0.1]:51082 helo=localhost.localdomain)
        by postbox.timberdragon.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.95.0)
        (envelope-from <earl.chew@yahoo.ca>)
        id 1qbtJ9-000Ozs-FL;
        Thu, 31 Aug 2023 18:50:47 -0700
From:   Earl Chew <earl.chew@yahoo.ca>
To:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     peter@hurleysoftware.com, earl.chew@yahoo.ca
Subject: [PATCH 1/3] tty: Fix __tty_check_change() and tiocspgrp() race
Date:   Thu, 31 Aug 2023 18:50:29 -0700
Message-Id: <20230901015030.2469062-2-earl.chew@yahoo.ca>
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

Restore the use of tty->ctrl.lock to cover both checking
current->task_pgrp() and sending kill_pgrp(). This coverage
was lost for SIGTTIN as part of commit 2812d9e9fd94
(tty: Combine SIGTTOU/SIGTTIN handling). In rare cases,
job control shells using tcsetpgrp() and SIGCONT to move
a background job to the foreground could find the new
foreground job stopping almost immediately due to SIGTTIN
or SIGTTOU.

Signed-off-by: Earl Chew <earl.chew@yahoo.ca>
---
 drivers/tty/tty_jobctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/tty_jobctrl.c b/drivers/tty/tty_jobctrl.c
index 0d04287da..aba721a3c 100644
--- a/drivers/tty/tty_jobctrl.c
+++ b/drivers/tty/tty_jobctrl.c
@@ -44,7 +44,6 @@ int __tty_check_change(struct tty_struct *tty, int sig)
 
 	spin_lock_irqsave(&tty->ctrl.lock, flags);
 	tty_pgrp = tty->ctrl.pgrp;
-	spin_unlock_irqrestore(&tty->ctrl.lock, flags);
 
 	if (tty_pgrp && pgrp != tty_pgrp) {
 		if (is_ignored(sig)) {
@@ -58,6 +57,7 @@ int __tty_check_change(struct tty_struct *tty, int sig)
 			ret = -ERESTARTSYS;
 		}
 	}
+	spin_unlock_irqrestore(&tty->ctrl.lock, flags);
 	rcu_read_unlock();
 
 	if (!tty_pgrp)
-- 
2.39.1

