Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4B4F78F6DB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 03:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348111AbjIABvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 21:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbjIABu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 21:50:59 -0400
Received: from sonic310-22.consmr.mail.gq1.yahoo.com (sonic310-22.consmr.mail.gq1.yahoo.com [98.137.69.148])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A763AE7B
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 18:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.ca; s=s2048; t=1693533054; bh=xQ6nUvXbEV5OIuh+twAx3Bc+69ssp+DeFN3kieK80qY=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=atoRyTaMnIstrnr2q8yG5tWKaWZ0yah7LsBpmTyWV2sao25wEgHa5wzykLXlQOZXarxcrs0/+L61AC1PaYqqTOvVBqU6X2aTb85ABT+J+/n1aqVS8xkDLecE4eT00NZ7CGVLfRUHebtZBUjok9JMoEf/iQudvG0axgwDPPx8gfRkGLxmzMcWILYcUNBt/o93M4QzXIBi6bMsEtfJ+IL2XD0ZU3/N0LdlYY9bHggpZmsQ0O2hNbkc0HR/wz5t8ce/0EkXAf3sKMyBZaDj8SPa9TTHkmF+z5NNqn8UnEXxr7nSxtmwgJoruRzNjyT3QExFB2q3UayUvPvVfASidyFZYw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1693533054; bh=ZNlJEZYnV/JcdhDXRvtqj9hKlWxFjUqeaa14wgvKa0R=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=o5GS6iaVl6KJUHXY4MfZKgtY7UCrlUXnVrenwEXR6FtdXIvJcXv7u1enLvTmRQ4BU6xe2OCbTKcOZENS4BFcGrdvSi+/3eVuYGx5GEZQapHHlyprHV8eSnBkS9Trfv+5kUoLw8y+jqWcOpoNn2qzm6/f8fLWaSLVtU0SRRBIITqGMfJZbbfuxg5vuaSpmBprcznWYU8I+tXeUPTuWNsE1wjBEXUDO141PAS7WFM/TDxjR4JHjV0zwyB4BJ8QpYUqfQ/OX8k4/t2tTm8HdnhbfT4wVnGOwhF8PCBofPSCSekKM7GU6/2NUzRyOY2bSIUfBtOBOUxGV830NFZo4bvOjg==
X-YMail-OSG: dO5vQsUVM1kmSgRXzcrr_CohSXih4SsnS_7Z9UBV45dpgnHf1OP_s0slKiL3ewf
 cXUgNf4h4iHvYGe.95KIdd5E0ip4Zae5x9_fbCEK10AUR6HGkMRblCDrA9bGLGVlz5gZOiGIUFWR
 zenpp7h66Ch0gb7rs9L0Ssb44i10sLNLsBrnjkLQTmMzEraKyWhIyjUuJ.S4945Rf7t5_pu67P5V
 _nn8iiV_BkJa8WbVtKgcFWJKMt6KLncpdcS_3.xPudHjulMD.0cTMHsnHrTz34cAEfMkV90z6U8Z
 5JRAMr6DdZFsksx6jWXsYwV6DKrnXNd.V1GbpiK8zNT.FNgNuTych2dP0amODntlM1dIhYyAIq9M
 KmDmuBykeO5OZcauL8dv2dhtWa0LUfI0NrERACTd4FfyangdxOWWpG3Jul2W0rVWrcm6AvyaOA7o
 pxZaBYNDq0rIZVz51zO9wIah2cl5rRF8xhDC5yE9HZ9fKysj6dndkLQBlmgutBdYE0dFBoqftUpM
 xrYgJm0gLnHZ5mPzi3.OZ4Pnf5WfOmeU004A0chT9Nuaxi7gXK_ZLpURZDVvPF5Mj5984.c0SYjp
 hzGVmUY78hvy3jiKJTxG09EhYJwLJZVUI5GpG9I2_Gje49AIFyyucCvsaN686p6wCtQgJv0r2qYC
 72mJs.U1JV52mqSY6ZxWIUNWMrWQlJNIGSdG4YPWF4puwf9lcKZsKkU035hNsNs61Fvh18vtxxiY
 K8FwJ8b4T2i65Byzae7CLUp1r9aiwN1ogb7g9gf6Fl7JHw79aK5b7PGCQVdFb7kGjIq0cTy6YENf
 jhQp4VMonMjpYtdqSKA.FZSut1hTDAwE88UnX_PJfuWCmzUo_s.AIACpNlvZtILgNFM2C2_1rJxe
 Hgc7e9nf.hp.UH2V8Pgwqpm7s7njRZc77BO7hZHJXORqKNjeqBFJhQBbusl51EnqV5C1OZdgRzjm
 5AKNdd3xqsOVGviWfTU06.Dekab9k4UIi4f4GFVsGURdOTdKTV4siylxS0mlEZjHc0VOpq98za3S
 Ai6Il8XNHbY4eutLN8POnPwQheuWPuN2m3yXSr1a5gByEQM.vnQvrJf8g7TjfBlu7NdBKK2XQlRD
 7_kyrYUrP2rVfeSg0XDJzw7Z1KOdbfECpkIc2OiE.IEWffiYZWl1GfK7PKzwmjZdpXmGjMD9WGB7
 FOjaFi4LY1CbknNeOcbvOyAeSro_zXXMyxdn0juA7FeSKE5spptkIxVCKvLqKcxe9rRaF7IQSj7N
 qKPjdZWQx8hmcC4wuFU3lnQ0WdA.h9.5D6RtRj8JaxraJD9PTBUqaEtW0UCheNNVEVjsoD23JVn.
 a02y5xbaRZn66Swj4Ndh0boDf52zkTdS.MNi2rsX7XvzZmWpxkrLPKvUczTxev00YrCHNckfqFNT
 bAgNzZE1kJ6mEKHQcdHhaTKltG1Xkg89QOzBurtd.5Oa5p0CfBKMMPTliJA1H2nOaw.Y1x7QCkBY
 nJa_xXwvMdrwTwdTeEeUOwJYIX8z4Th2PTGzBh9BQK6Hz6tIpyTAqc0it0pe0_sDlph0C__27zw2
 PmXRy6lPc8BNGJLJQks4ANy3uwmgMSxVRI8PY6hdhtoPQpxyIIbOM6grmyo2fLZXBMmzrWq.orjx
 vYrVuuUSTLA_cfe3AN612XE33LoEcAegK3ReuXqwEjsHOaTjbTf.9TvD3Gj2UNYaEQMtJfIBv.IM
 D2T00I9z0zYcZsSq5YOxyKvX7oVLnFpLtq4m1HMvIfiJVrVL52pQ6hJkkrwEvvGH5TPm5wT8lt5B
 0_j90w_04KynN5fkhjSrIlbcEH0Im8H5PoQeJUETISS7YmkrpqtVUGCYFn3mV1foWzzD_55IY9Iv
 VtW.W3hmGimVOkSr5P7VreWXgDgSADwu5.qOqfrnLTcq_mJIg2WkRZxiEw9xW8IG2GqNWw7OfPIU
 Hja8SDmSb9Wu628someQs0.tc3.pEUGDYMLRt_ZIHAnMHK.PxdP0Lup2.et34TgeCGDg5e.dUyDX
 otfZY6Molo3nzhaIVKa1H6NK7PUB6mK9VUz2gnrhvTWUlyBCan2xDlZSmcueqRC4WZSxlTJxnFnf
 JgMpeN5Ba5dmoBxZffQ7mY7y2Xu4eb1eMYJl0Y6eg3ZNaAOvVaWWmHnnnEBtUyFexqbJzpchyYig
 K9c5pyUGRQRndL.jP0ZvAUxbhJ6ZIcYPxeWQt4Kt4L239bQAgOgrzpQRxTnkuFBV3ikZpb5KLAla
 .OFsPVAvhd8LGFiSo2j97ejmOWSw47bUoRw17EEkcLfI.kTRUxAtBswo9fLYE1YxyB3pRsCGgxTZ
 DubMo6KzNWQ--
X-Sonic-MF: <earl.chew@yahoo.ca>
X-Sonic-ID: 245c4da1-d12e-4875-954e-95b585430925
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.gq1.yahoo.com with HTTP; Fri, 1 Sep 2023 01:50:54 +0000
Received: by hermes--production-ne1-7b767b77cc-c8mvb (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID e0ccd9aaccdbf9fc0b4cd3ed6de08bb8;
          Fri, 01 Sep 2023 01:50:49 +0000 (UTC)
Received: from localhost.lan ([127.0.0.1]:51082 helo=localhost.localdomain)
        by postbox.timberdragon.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.95.0)
        (envelope-from <earl.chew@yahoo.ca>)
        id 1qbtJA-000Ozs-8q;
        Thu, 31 Aug 2023 18:50:48 -0700
From:   Earl Chew <earl.chew@yahoo.ca>
To:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     peter@hurleysoftware.com, earl.chew@yahoo.ca
Subject: [PATCH 3/3] tty: Move task_pgrp() after tty->ctrl.lock for consistency
Date:   Thu, 31 Aug 2023 18:50:31 -0700
Message-Id: <20230901015030.2469062-4-earl.chew@yahoo.ca>
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
index 462fdf7b2..b4d37cad9 100644
--- a/drivers/tty/tty_jobctrl.c
+++ b/drivers/tty/tty_jobctrl.c
@@ -43,13 +43,13 @@ static int __tty_check_change_locked(struct tty_struct *tty, int sig,
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
@@ -62,9 +62,9 @@ static int __tty_check_change_locked(struct tty_struct *tty, int sig,
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

