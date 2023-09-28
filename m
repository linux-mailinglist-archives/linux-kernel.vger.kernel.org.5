Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4F27B1D59
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 15:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232645AbjI1NHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 09:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232126AbjI1NHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 09:07:19 -0400
Received: from sonic305-20.consmr.mail.gq1.yahoo.com (sonic305-20.consmr.mail.gq1.yahoo.com [98.137.64.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1FE4198
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 06:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.ca; s=s2048; t=1695906436; bh=0uYxSCUmeN1rwvUTUZ2yOlvAsifAJYV7MUA5++fq0fk=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=glWhCkaVxtt6JEK20DzC7F/6zvd6intLm2j/3iVWr4HDG9y+CJ79G2+3vgb/opXLwiXIiJlxJ29oTRHRLCIYBBTIWsLWi+sc1A0xBtiOpkjc3xkVyJZLl0KOcPVSUP6Co2lFOJAny3AWWZ8Z+DiW4GYUo61dZmwpnEb4vClxajjysKd8GAA100LoiL66kY4hvAWKqjrA/ahL/FnOvKiszhnJbDOaYt4DpVTuAVncXFAEed8x/7yv3VnA0hQEdGY/QiYlvHyZOA16KbiCufM7YrS63hiAJw4gyjt0btSuH/Im7pDMiSGqXUY9qunhMtrsHgpkr+PARcRdO2zSDWyXzw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1695906436; bh=+eh19m8DJjetJ3idHXwuUz/nHNN3iXgy/uIkqOrDkc2=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=DqBXGbHyAQiOb8fhgfZ4HN0Ak3ioIIh04h8bIeJ6EghF/02UHV0EKzdEDzYCviD5hOo7VSJFpA7dyIjDxvaDehq7F8ajVZZaqJ6kxQ0lnwcne1I4b8P4Fni5445xIuWYZemZQFUoEDwxHv/XXJjTJTE8pYRK48chIKEsbiMUjI3967B0Y59878E/XYJygad0lMSYjR3jOmroZ4OjFvD3cyI8971fUS0JaciyahOZqVMft10GuwpqazTnU1GBzKBE7cbtuFM3zvISoG3KJodumdOp3HhGwLGwJpXheATZrxYkfcDCTsBSeOIpc9BHz285u+2VxACSHu03l87G9ovvKQ==
X-YMail-OSG: wkbDK3oVM1khKDOzLee.9_GQO5PD3jUvyfcmBWVO2BDYi.gPzrIIpRzywAwPg.k
 p6cyK5aZ1CJbMXSWY.lmjclhvwyCX4g1_6QLpIm8ix956jprO5EJKrySKFNj2niEqbWQjr2KKLFT
 6UKfncSsNX5eODzCOxYfpMX6M27zmPB_KrJWWVPN8yCewhNOV2yxF.EC0uGwQDezUFrtVH4yiCH0
 EtI7oD88d3Y7c6gXSbzD4y1GawmKBQjaPgW_Zg92qahooQlMKbDejAoSbtYoDWodgLvdCwzLTOiu
 sNLtTEtH0O.Ew7iNOGDaXvbfQRO1qXCi37.OhMT42Fhul9a0bhek9ByW3X2fkOZvnbXYboaLNIY5
 LHScV7RFLLd9EINQAomK9DIGs4VtVyZ0Rj1eoOHax.K1vzwShgtyb_DoptL5ZaDmdL2az_VWA15c
 JcW23h8aSa_y28cHhJuHnv1BXlDn5RKQDmCJ1ir5muX6iqgLTMHV.MuoqXNoBqebx4_YZVg0NyUY
 fIMw_uRMCzcZ9Pd.MUY3BlXO.doZzdbp0BKwfsn3yiJUvePHvDwqnTW28xj7uY8h1DjyqNxzqJC1
 YI4svJCMuxEREAYmVEZC5hENF9undjgTIcRYBomiwsVxwn7CFrjRrDMoeU_PBrMgFX32LH5bU.S2
 YOgDICRSs13v_wKgWXNSlpI84kjjt1xFxpfySbpwM9mn39hzUjG_qQMTGIDByQsRRPtP9N5L1CVW
 vryJBMJGQpZvQl0FLcMl_Uf9droJv1nq52wVc4B7E6gUKtjQ.0fRU8N9XHPSryp2b1NEjG_VEyVK
 SWpZSBhjk.5BkqkYPbo0urgO0ni4g08uGiTC03iItplGXDBBWWKPH9Ktb8MYouozLU_Sy0V9iMkl
 Z47WJmJsNIB5rlvnO1uKM3lePu9F1Hz8fxkESCguMrSVXx6SnviVqon7y1jEnszezmzzVhP0AVMd
 D82KqWpsMhWxbNMX4ojfd6KDzdO1r1C6uWOLPZvBae1vvPkHR7VtpfqxxeUwnfPWX.v5UsLaOSCj
 T6T1la8HfR_JK.KI8OBB8CHMCJc6_JviINX4HisRvjkFlGo0WMSZFNs.Eqgcj31_b5V9l82kOy90
 x4IhaWqwNMLuk9rGtJckbP9ymnx7_io2SFp7KVpe8B5X9W4ZYr2Jt.Bx3m7NGjaZr2L8YP7Q0MXI
 tH21JwHZtts3f1F3N.H28uqAKMi5mrR55qUarRd6Ppvplz_VedwndIVISvCR1aJNB_K3VLOGplh0
 JehTsoxzFQ0ZlsnNMY6XnP3Nhlv5EpGLiol5SkdEX8NW6KU4iOmZvxSHUQtemAdrS_J7pYGcJv3s
 sNMQhshUAau30GNbCUAGpS82FBAuU5JLgh6hTHm0_Wl1z1MWBgBC1zOOpSZaQCrsCHkXIOgdyC3u
 ULDQqEXMwHhfbppJZx2ssnnS3RY2wBT9zl6x.xOsaWA7GQbausqGmcqXXZx._w06hYcyygQop6wL
 3FfRTThBiYNspwvdqr4jjGElEZ4fXt_aJMA0HtNsT_fmgAE7q4GwTaGGCy5.01A7yHO1ArZxPvXQ
 N9hK_Sy.IRP3DhUWMlUi.atCzojQR1ewnch.zu10O8X0bXjJYIeJe7g2kgVLYbW2KHRMTBlXeFnZ
 Iex8INk_Ysqe0M_H9EtL4UVTFa0qLgQWE7f1anQy626TLZ.GMqEyVBFEDbikrwv3b_tr0E0XDRBc
 GJGi7HQyzaI4hIGp9cpmisl9njAF43YRgnO3yv2Bx56WvcMorK3Buc3WWHPOMJ_KUD3Itcz5apll
 o4yofQdRo4ldesYT5_Yq6DOtFJ_Po04sBU1ka91svGk_6XzM7qw_VBygZK4XopHxmGtzFSRZdLiX
 Xr35GrX_c2hEoGnowpjlz5XJ7VhbCE9qCh4mOmx94E90rupLnRD8qhPm1tsAPI2HCh.GXLOUaYl2
 bz5NSguvG4ef1ns8SmGUyDSMFxiY2OmuIBQivIchN57fFtHGe_QmN9Nh6aZsUgJ.nnnSY1aBKUo2
 xO0YEhS3kLtbd14j4ZXryQlY6CQ8KQtm3pZfo6axY6H3Whu2qMzA90gkX_ejg3ZESfDvX6ptyqL3
 bxNkfY8DO1Aw6VIwWzxiuEW0N1XjIoQhWBaBZjv02djv1GrU77RwxE6OK3FHU32py__SSTvy6Wdd
 Tdnx7yLMCOWzBtGVfYrXQKDAgcjBXV0xDGBMMTFXb1jIueccbxe9vndRYT_wRKM5H_LboZRAyiCG
 i1DiirsJ6RZrb4j_KGQeVyunxLkHEbZBmBko8Q.xJrX8nAfp1EjT.WqJvb3MLVxV3ys3hd0jYkML
 4k5C.
X-Sonic-MF: <earl.chew@yahoo.ca>
X-Sonic-ID: 55d4a9ad-4c71-4bad-8a26-6fddd571f55c
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.gq1.yahoo.com with HTTP; Thu, 28 Sep 2023 13:07:16 +0000
Received: by hermes--production-ne1-5b56858476-lphgp (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 82903ebb22bd0c45e3c9b96810013fb9;
          Thu, 28 Sep 2023 13:07:15 +0000 (UTC)
Received: from localhost.lan ([127.0.0.1]:52224 helo=localhost.localdomain)
        by postbox.timberdragon.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.95.0)
        (envelope-from <earl.chew@yahoo.ca>)
        id 1qlqjZ-000fEn-4T;
        Thu, 28 Sep 2023 06:07:13 -0700
From:   Earl Chew <earl.chew@yahoo.ca>
To:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     peter@hurleysoftware.com, earl.chew@yahoo.ca
Subject: [PATCH v2 3/3] tty: Move task_pgrp() after tty->ctrl.lock for consistency
Date:   Thu, 28 Sep 2023 06:06:59 -0700
Message-Id: <20230928130658.4045344-4-earl.chew@yahoo.ca>
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

Refactor __tty_check_change_locked() for consistency
with __proc_set_tty() which calls task_pgrp() after
tty->ctrl.lock is acquired.

In addition, spin_lock_irqsave() can block, while
task_pgrp() cannot block. Fetching the process
group immediately before it is used reduces the
window for inconsistency, and improves clarity.

Signed-off-by: Earl Chew <earl.chew@yahoo.ca>
---
 drivers/tty/tty_jobctrl.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/tty_jobctrl.c b/drivers/tty/tty_jobctrl.c
index da028aadf..e82ffd875 100644
--- a/drivers/tty/tty_jobctrl.c
+++ b/drivers/tty/tty_jobctrl.c
@@ -44,13 +44,13 @@ static int __tty_check_change_locked(struct tty_struct *tty, int sig,
 	if (current->signal->tty != tty)
 		return 0;
 
-	rcu_read_lock();
-	pgrp = task_pgrp(current);
-
 	if (!ctrl_lock)
 		spin_lock_irqsave(&tty->ctrl.lock, flags);
 	tty_pgrp = tty->ctrl.pgrp;
 
+	rcu_read_lock();
+	pgrp = task_pgrp(current);
+
 	if (tty_pgrp && pgrp != tty_pgrp) {
 		if (is_ignored(sig)) {
 			if (sig == SIGTTIN)
@@ -63,9 +63,9 @@ static int __tty_check_change_locked(struct tty_struct *tty, int sig,
 			ret = -ERESTARTSYS;
 		}
 	}
+	rcu_read_unlock();
 	if (!ctrl_lock)
 		spin_unlock_irqrestore(&tty->ctrl.lock, flags);
-	rcu_read_unlock();
 
 	if (!tty_pgrp)
 		tty_warn(tty, "sig=%d, tty->pgrp == NULL!\n", sig);
-- 
2.39.1

