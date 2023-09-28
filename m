Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80D527B1D5B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 15:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232671AbjI1NH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 09:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232643AbjI1NHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 09:07:21 -0400
Received: from sonic310-20.consmr.mail.gq1.yahoo.com (sonic310-20.consmr.mail.gq1.yahoo.com [98.137.69.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 334A6F5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 06:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.ca; s=s2048; t=1695906437; bh=cEUQvr2uTGSCKhdlqhEVI5tYhjMFaTNt2CV/uM0iRuc=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=spXN1KKQE5sZOoDh28SevecZTw3BuN1bMytu4HjC5fGjzc50peWiE8suxbsFOah4/ez1Zz5gspKS+BY1Or6XGwXVRZLzxXWrwrhEbPjfKJThv4P2+mwx/JvvJV9tAU8IxxUqQEypyE7lmgnb9mFeBrqH4briYdAOxxM7dlNSFuu3IDY1ENtQsbG+Y81jBWb4C9cTxpqUOPDpBhHDLSQeFvEtAQE1vLy3+U5vmEdb0opy9naU67RZjMijj3BWz7qjNwQwILa0IMAbEwVga2J7uBnM5an67umcvNlRGVGBjdTrxDA12Qa/rxGmM/PzG2pui4dYSY6cedZy7kdR3BXmqw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1695906437; bh=J27zA3DcfL8j9pGh7Ri+uBDSu9Q/v79gpE2JJtReOMk=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=Yy97PrtkdqiFUC8nbEJMPMA02l5GjLlqsxy+rkRKD63HmYwQ+EJPB2kc3IQlYUMs07wJ3GIINtq82W6dFtFjKBqXR7lJ2WPiKYfl994yfppukEccaxj2YA2rsOQL8qYvlLUlJ1OzVGQQSo7BfDrJuLoZruNa5vkcYDAckPJMjnxlRvtB+xLnUUvR9+k94u8q0JJhrTdxgqR4Aeylbq6OB0odPIqHAdfcbwcDQuapWAL4AUGDX46urGdUYhyZk3PSFiiyurCOGggpfWSClpbGSxGdcvtZywg65LaM5utCnbJ7w7nDOgNTvCWM3mfTOFMWpeXksax734/+Gwn6lUbuYg==
X-YMail-OSG: x0_5WhsVM1nPQO6tbBPooq0FMfk38jCKmOAzuUe.PoLWEtX8MXMK9qQtV3HkaGu
 ORgFAXmiZCzEfcbMAt3v7ONNRnxkUP2aNpKhubA1EIqFe5lOASbEtth4oKIbP0P6Q5iDaaZk5HSs
 Y1ETV4AfmWuIVzsIzWnpnBAi4fkk7CpnR66PPLSDpnGlNSf9RSWyO3QWy4IQFvNKYpj6hw5HNwol
 q22rtGTSceubfT9jwooGYfvdKxOW.9nb0Nf1oxpoW3JcqHdVkhQap4rwDe8tFaB_oEQuYRMIzE9W
 OuhUMNq15tTSte5ePTBwxJluR8coCYfm9FEE_p6ZgWqZ3Mo8PlAJPt36zsogzoZzh_2p.j.0SeUZ
 oNf9cLmrtpwTDYkY.46TecChYKKkRkntaWt2B8g_15qga.y9RNwVqz5CkmaOCzWKTbtgNHnI7TZD
 xrz6l.IXl4Umdw99g46hPddw4CvwRnm.jPZY7HBm.MVlQgcG7JH8QjyyUkzgloptCWPNwnCaoIpr
 9O7Bs_rTYG7ARpFjaTOIk6iLSfHcBmP4IqgqFCmOWR6BaaHD.3NmgA_uS.FA6BLeOhewrNZ.HXtR
 KoOPoC0giMkatPnglH.b_DJL8DhxLrGI3c4Nqx0_aQYMn8H4MoxnTzwfxPirotXzq5HS9FjIdB9n
 NBiJtNwDTVUTs1ECjYIqc9tsBJuAm7G1X_5odwmorLMMFzdXSGiCrOATuKTWAT8i6mCSnoIJkIoV
 Eh.ICCNYN8Ob73eIO3c8o9tg4LlPEu2xZYaAo_srZyHeK7kk6fUJWgXE1eLJcRqK9W9dkoWJ4.2f
 6E4rsucmrAUKqYxhINhGfSzlMKvDWHlVsBfYcxidV9uRq.M8i9b_CXWq1qUWnhzYObG_l.I2mPVB
 IPb.vXpYtpSceewkGKdbB63.ZaC1MmyDNXS1vT_t2XsHBgAz1TV27DEoW5KGTjBz_wLn6xc1o7v8
 eVtOpiwjiCljhoILXyTndKjT5SKd2hSlcVbpHl_xb061e1YZg1tAEkuDWirZnayVtwnMEMieBGct
 SyS7VeR4UCVQOz5y.RjYSkzVcWyuE0P6sDcCJhwvW8GFoHBH1dQy0n6DTJte8J993jdsRhJuxLO3
 6KJR8yvPF7o.u5Rg3xMmDr8obHJsCKfIJRZjo99e1q81ODe0Fo6_tvU0w_U896W61Wci_fNyBTHH
 FQJh4vkRSCWeKspk.LY4S8oiVFDVyU2Kar7_y3WOTStraIt9sJyMVDqSbMAYly0rmdcThM4xULgg
 8YRfH2RLWl0.iPEyqs4OF3UCabxxJqhJVBj.1usn0QKB82wpx.oTonc8vdLHwgHp_N4zFD.e7xdy
 JdT4F4UtChX9k2b2Ynuwxgs1i3s4St8I8wQ.6wRS4Nilra6dCSloSotINq6KO0itJEgTSOgHz5U5
 yLOXjMHmOu1sPL6FxKSKGj4RRnu5V2kvJ4jRs4kzwKyBRbBAfrsIZbwNk8Sd457vG5QEF6Frqvu1
 hyfH5E09dCvWKqa_cVWoqh.9ZF3Q3FyYqXJ0KT1Fw8PvG0JnKJl5bE89mxHztBKMU_kEEZSZ5OkE
 zjSCbg7W4r.Bjyc97XfvBA.NVebh6LF.0Qml608FfN9aST1L6EiHmPEbhJwnMPo4yuQAI6iLhS6M
 wHmXk6KrKWjsgXzAriPAbN0S1_4tv75_Ir6LtKb9IA4jRO2WonoIGBTLGgX8koRWqdoQleKdEE2m
 Ho_xXbYpu7NdZqoBYwUXvBDWQ394C_dq50BqW7kW2FjX6esqOiHeslhQQdfL7tm0v6BT2qGpKDUP
 jAnYruiUteNJ5ji1iAB9Xu9ATVux5UHvM74P.4OhqP3UWQinQN57vwHEfrgPuefYAN2YKqCfAcj8
 MJMgsKv8kue4Z1dICL6puqY8QwSAqVjK2UCcJEJ5ccJA0NTaozwiQ2SR6_XPdESrkeDBlUHX0MdS
 TNlLp2vIdn_pKhCd07NA7.byFtvJ5HRZK3qbBN1TOX4otZSK6Xz0U8jIUpckdXjDqu.1mTtztpPc
 svsuEQPoCLwgXdAQI5x04L4fZkM5WtnEP1F5M9vhnz1SWnRjRf.EYBvdI3keEdfemS6m7xRINKTU
 BgQXUqiB2SyQC_CW8EHtbyImDdotDl5OyWgLZ8V1o9riozTjCerXlnxDN0Lq7zNjHB48Op4kJyOE
 0wBp.fbIJXfVI25kwUsOibl7GTHL4K54CHmKctnd712jNEF0Kr4Ffr04s4ik5y9.YoVdMOK0eAnU
 QsekPBdmV1rrCh_IAx.oSqz.ITcaFamK6BEU3JOsM715keO.jzG4ngCDhjB8JOVn95Iy1Rgb3pAC
 8.OfB
X-Sonic-MF: <earl.chew@yahoo.ca>
X-Sonic-ID: 57bc30f3-8d27-48a4-9c35-0273c976fd45
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.gq1.yahoo.com with HTTP; Thu, 28 Sep 2023 13:07:17 +0000
Received: by hermes--production-ne1-5b56858476-qngzq (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID cca63ec0d72172f78c3d0254e0e587dc;
          Thu, 28 Sep 2023 13:07:14 +0000 (UTC)
Received: from localhost.lan ([127.0.0.1]:52224 helo=localhost.localdomain)
        by postbox.timberdragon.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.95.0)
        (envelope-from <earl.chew@yahoo.ca>)
        id 1qlqjY-000fEn-Bw;
        Thu, 28 Sep 2023 06:07:12 -0700
From:   Earl Chew <earl.chew@yahoo.ca>
To:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     peter@hurleysoftware.com, earl.chew@yahoo.ca
Subject: [PATCH v2 1/3] tty: Fix __tty_check_change() and tiocspgrp() race
Date:   Thu, 28 Sep 2023 06:06:57 -0700
Message-Id: <20230928130658.4045344-2-earl.chew@yahoo.ca>
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

