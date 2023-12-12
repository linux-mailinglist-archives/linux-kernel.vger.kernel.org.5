Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B768C80EA34
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 12:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346401AbjLLLRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 06:17:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346325AbjLLLRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 06:17:23 -0500
Received: from mx0.infotecs.ru (mx0.infotecs.ru [91.244.183.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C63F3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 03:17:24 -0800 (PST)
Received: from mx0.infotecs-nt (localhost [127.0.0.1])
        by mx0.infotecs.ru (Postfix) with ESMTP id 01A9512012CC;
        Tue, 12 Dec 2023 14:17:22 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs.ru 01A9512012CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infotecs.ru; s=mx;
        t=1702379842; bh=NGgi0dcX52R2Hsj4L3+FbfcgEQzNcKvB9lQQ3MuTsMU=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=yf9uSjnfSWd9Z6nU5qzdpDu1E6K56w8q7WFPFG4TuxgPYtF2JMi4zUfPChAPYr/nA
         8eb0GAF1eTAVW/7Mntf44BrvSbA0Hsrjh/nlAP3kR2IUHPPr9R7KscS7U8/9zzkS4Q
         atAMHnULdGJb873TXYD3d8cZGVwk/8yxi84neSNU=
Received: from msk-exch-02.infotecs-nt (msk-exch-02.infotecs-nt [10.0.7.192])
        by mx0.infotecs-nt (Postfix) with ESMTP id EE62D316EE01;
        Tue, 12 Dec 2023 14:17:21 +0300 (MSK)
From:   Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Daniel Starke <daniel.starke@siemens.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Russ Gorby <russ.gorby@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 5.10 2/3] tty: n_gsm, remove duplicates of parameters
Thread-Topic: [PATCH 5.10 2/3] tty: n_gsm, remove duplicates of parameters
Thread-Index: AQHaLOzGj9Cp/lEMc0uytGwtXjUNjQ==
Date:   Tue, 12 Dec 2023 11:17:21 +0000
Message-ID: <20231212111431.4064760-3-Ilia.Gavrilov@infotecs.ru>
References: <20231212111431.4064760-1-Ilia.Gavrilov@infotecs.ru>
In-Reply-To: <20231212111431.4064760-1-Ilia.Gavrilov@infotecs.ru>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.17.0.10]
x-exclaimer-md-config: 208ac3cd-1ed4-4982-a353-bdefac89ac0a
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-KLMS-Rule-ID: 5
X-KLMS-Message-Action: clean
X-KLMS-AntiSpam-Status: not scanned, disabled by settings
X-KLMS-AntiSpam-Interceptor-Info: not scanned
X-KLMS-AntiPhishing: Clean, bases: 2023/12/12 08:32:00
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, bases: 2023/12/12 02:27:00 #22664189
X-KLMS-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Slaby <jslaby@suse.cz>

commit b93db97e1ca08e500305bc46b08c72e2232c4be1 upstream.

dp, f, and i are only duplicates of gsmld_receive_buf's parameters. Use
the parameters directly (cp, fp, and count) and delete these local
variables.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Link: https://lore.kernel.org/r/20210302062214.29627-41-jslaby@suse.cz
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
---
 drivers/tty/n_gsm.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 7a883a2c0c50..2455f952e0aa 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -2577,27 +2577,24 @@ static void gsmld_receive_buf(struct tty_struct *tt=
y, const unsigned char *cp,
 			      char *fp, int count)
 {
 	struct gsm_mux *gsm =3D tty->disc_data;
-	const unsigned char *dp;
-	char *f;
-	int i;
 	char flags =3D TTY_NORMAL;
=20
 	if (debug & 4)
 		print_hex_dump_bytes("gsmld_receive: ", DUMP_PREFIX_OFFSET,
 				     cp, count);
=20
-	for (i =3D count, dp =3D cp, f =3D fp; i; i--, dp++) {
-		if (f)
-			flags =3D *f++;
+	for (; count; count--, cp++) {
+		if (fp)
+			flags =3D *fp++;
 		switch (flags) {
 		case TTY_NORMAL:
-			gsm->receive(gsm, *dp);
+			gsm->receive(gsm, *cp);
 			break;
 		case TTY_OVERRUN:
 		case TTY_BREAK:
 		case TTY_PARITY:
 		case TTY_FRAME:
-			gsm_error(gsm, *dp, flags);
+			gsm_error(gsm, *cp, flags);
 			break;
 		default:
 			WARN_ONCE(1, "%s: unknown flag %d\n",
--=20
2.39.2
