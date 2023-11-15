Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B669B7EC92E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 18:03:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232210AbjKORDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 12:03:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjKORDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 12:03:49 -0500
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BEACFA;
        Wed, 15 Nov 2023 09:03:46 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id CA28E40E0032;
        Wed, 15 Nov 2023 17:03:44 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
        reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id asOoiNB63C-s; Wed, 15 Nov 2023 17:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1700067821; bh=an9uHtOOfwZ20jFxIxiszaxxIhJNMZCCPcUQiGwprz8=;
        h=From:To:Cc:Subject:Date:From;
        b=O27Cjsls5UQYxS58yXvaIogJO1qGohBD7U53TNW2ha7d6VCXu7YEavDZ6byiW71tp
         9nqA9Lt81DEaOi9lFKev3P35k2iwSnQFCdoEUORVJFARdYd1LXegMTgHUbfk50Ps6V
         OVXOTJkSl62IiwAwzmOUFwHCpVNACs+I0Sg4fEtZv88nr8DAZsLWayu+R53Se3m0ii
         aP4/Yh7RmKp73FHLLhuE+4SRFlCj3K1Cy/g07qW6e4kAw2Oq5m0tNPo5NoLvSgr+Ei
         saqM6Dnf9kVcftWYm9JRBumRLIRF6YYvkAhMlz1nKfxrIXCLYsD1d+3Iw1n/mJJn34
         QO/662xQaoRQN9K4yEBu3o/F0mwNZtSHJ6aQkBYyvHW17InIOaUBAZCXD8DFIWl7pt
         XAHyN9AjcS9Amlu5uUzqw0KRWXvpHTXJ1ZovnpQoF2Kspb1/aLkMwa7J/ZwnMGUK34
         IciQQZiv3lEj6uMOb1YS7YD9Bx5WwgfzfBd8yjbtJvP0nZUuWohPLQNi0oVZ3DkyWw
         41ySvi07Bi+9XIi3uADbs1BqErHZNmmrSyFMr5yh/GvqChupZNhsUMvPVnAijr3IZy
         DY/erESd5iOrOl3EzesbzVzRcZtTy42r3RnqmwH7QYUUhmtJsLhTCQ0UtPnt1yNKDt
         9JBAoNgEwvyAOYybSFB7RSsc=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2BADE40E0030;
        Wed, 15 Nov 2023 17:03:37 +0000 (UTC)
From:   Borislav Petkov <bp@alien8.de>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     workflows@vger.kernel.org, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] docs: submitting-patches: improve the base commit explanation
Date:   Wed, 15 Nov 2023 18:03:30 +0100
Message-ID: <20231115170330.16626-1-bp@alien8.de>
X-Mailer: git-send-email 2.42.0.rc0.25.ga82fb66fed25
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Borislav Petkov (AMD)" <bp@alien8.de>

After receiving a second patchset this week without knowing which tree
it applies on and trying to apply it on the obvious ones and failing,
make sure the base tree information which needs to be supplied in the
0th message of the patchset is spelled out more explicitly.

Also, make the formulations stronger as this really is a requirement and
not only a useful thing anymore.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 Documentation/process/submitting-patches.rst | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/Documentation/process/submitting-patches.rst b/Documentation=
/process/submitting-patches.rst
index 86d346bcb8ef..66029999b587 100644
--- a/Documentation/process/submitting-patches.rst
+++ b/Documentation/process/submitting-patches.rst
@@ -790,10 +790,14 @@ Providing base tree information
 -------------------------------
=20
 When other developers receive your patches and start the review process,
-it is often useful for them to know where in the tree history they
-should place your work. This is particularly useful for automated CI
-processes that attempt to run a series of tests in order to establish
-the quality of your submission before the maintainer starts the review.
+it is absolutely necessary for them to know what is the base
+commit/branch your work applies on, considering the sheer amount of
+maintainer trees present nowadays. Note again the **T:** entry in the
+MAINTAINERS file explained above.
+
+This is even more important for automated CI processes that attempt to
+run a series of tests in order to establish the quality of your
+submission before the maintainer starts the review.
=20
 If you are using ``git format-patch`` to generate your patches, you can
 automatically include the base tree information in your submission by
@@ -836,6 +840,9 @@ letter or in the first patch of the series and it sho=
uld be placed
 either below the ``---`` line or at the very bottom of all other
 content, right before your email signature.
=20
+Make sure that base commit is in an official maintainer/mainline tree
+and not in some internal, accessible only to you tree - otherwise it
+would be worthless.
=20
 References
 ----------
--=20
2.42.0.rc0.25.ga82fb66fed25

