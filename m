Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12000755119
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 21:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbjGPTmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 15:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjGPTmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 15:42:49 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C9610F
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 12:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1689536566;
        bh=H5pt+y6pcwX39WqrqaNgBbqvV2os5H+dMqLl8EyOF6s=;
        h=From:Date:Subject:To:Cc:From;
        b=A9hIkOJncP9i6MGRUbnBk/j3T5R0iA1nw+reEsMgDa5GdZAvmsDZhIa7C6+bKtEeP
         hSG7qsGyNUCtw7j3/T7WrEhG54hEuWJae3a0759SbR258McIeRqY+Z9sylKVBJgVyr
         Ra7t0l5KLmZWnAGicfEiR/Om9iZQjwDHv8YNlgCI=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Sun, 16 Jul 2023 21:42:36 +0200
Subject: [PATCH] pgpkeys: use full keyid to trust Linus' key
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230716-keyid-v1-1-bf14426a8279@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIACtItGQC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2MDc0Mz3ezUyswUXYskgzRTAzMLyxQjYyWg2oKi1LTMCrA50bG1tQAe+TZ
 OVwAAAA==
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689536565; l=906;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=H5pt+y6pcwX39WqrqaNgBbqvV2os5H+dMqLl8EyOF6s=;
 b=fHp58NK+ihG4SNoxviGM9C69gymzd/OueJZiiw/5oP9vRKv5q/5uQ0JakqmdsbTJ1PjmvSBbR
 Rbh3HRdGjomCijXQzbKOPNY9wGJMyadoa09gvbp83RPjMQqt9PvyDyb
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

It's possible for fingerprints to collide.
To avoid that people accidentally trust an impersonated key document the
full key fingerprint.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 source/pgpkeys.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/source/pgpkeys.rst b/source/pgpkeys.rst
index 78ba703ff42b..d036686c51dc 100644
--- a/source/pgpkeys.rst
+++ b/source/pgpkeys.rst
@@ -41,7 +41,7 @@ First, you should assign full trust to Linus's key (after importing it
 into your keyring)::
 
     $ gpg --import keys/79BE3E4300411886.asc
-    $ gpg --edit-key 79BE3E4300411886
+    $ gpg --edit-key ABAF11C65A2970B130ABE3C479BE3E4300411886
     gpg> trust
     gpg> 4
     gpg> q

---
base-commit: 8196a3c298d9b1f11be305c87eb890f44f7c8cc5
change-id: 20230716-keyid-8b0f50689d23

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

