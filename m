Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1C979EBC7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 16:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241602AbjIMO5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 10:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241462AbjIMO5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 10:57:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A214AC;
        Wed, 13 Sep 2023 07:57:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7CF6C433C7;
        Wed, 13 Sep 2023 14:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694617030;
        bh=b+BCOH6t1rTcaGA2JrOlmpGV1UIgp43vRNpFdldrGEA=;
        h=From:Date:Subject:To:Cc:From;
        b=b33vD0ESdeN6ammU7Dx4578slT6MXU6jFf7csmnvP14DnIXjjwfahBTJow25SkFky
         NKj1IXoj4JgduRvT5GOC4i6ezwQVHH+pi77zjhYrdUplC2RupegXos4obhVE7rTu+X
         zo/B1A0DDO1X006G4VyKt2TOuibMar7kaKqY3p/+lLRd3PHSbNTw79XJI4jHuOaAVE
         cMAC27432bPo/pDZABk1v09FRYB8wYcrBVY5RZhsow7xXIYRxGlimYQL4CujdAIyWJ
         GYNOljfn9kufYJCXpgt4D84J0AiEqAU4asWIu0gzFa+vhJdFutXLymaH6y9juaTrDi
         i60XbvZw+pKTg==
From:   Mark Brown <broonie@kernel.org>
Date:   Wed, 13 Sep 2023 15:56:27 +0100
Subject: [PATCH] docs: submitting-patches: Suggest a longer expected time
 for responses
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230913-submitting-patches-delay-v1-1-a2d48c5ca205@kernel.org>
X-B4-Tracking: v=1; b=H4sIAJrNAWUC/x3MQQqDQAxA0atI1gY0Cq1eRVxkxlQDdZTJWCri3
 Tt0+Rb/X2ASVQz64oIoHzXdQkZdFuAXDrOgTtlAFTVVVxPa4VZNScOMOye/iOEkbz6RO6LWMbn
 Hs4Wc71Fe+v2vh/G+f0SYsJhqAAAA
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Javier Martinez Canillas <javier@dowhile0.org>,
        workflows@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-034f2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1768; i=broonie@kernel.org;
 h=from:subject:message-id; bh=b+BCOH6t1rTcaGA2JrOlmpGV1UIgp43vRNpFdldrGEA=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlAc3DDvS2E/2DB7QDbpWSPlIEsW2nLvundEuS/vZ+
 sE9JOVKJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZQHNwwAKCRAk1otyXVSH0JEoB/
 4xru4ddDRvEyGfznPTLPx2e7tTRp20E/1t/7wcn3lgtpqHY+/tKTmuJnA/t/PmOLmq/gKFGxMotBcp
 RiCA3y/GLoRPU/cavNsSyge9rt41YtbsZf1xbKGfGWa1nzIz8Pc86Gkg4W6UgcVokEAxzWNVk34d4Q
 k+P3VNG9TlSWqz7QBDFYcRl8gE3qZJzk73cLYfhsBO3m0P+NXAY6tPXdZIchEx8e+HzQ3k4xntcA3+
 nNKOGyZaXZUmlXp6NGx+q7DNtANubCVXBVvqDy2HvEiingZ5eNXolq7D/BiWksQOrLj8av7a8C7/Ms
 cGTRV9P2f86eioP+HwkJKiN1faIFms
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While some subsystems do typically have very fast turnaround times on
review this is far from standard over the kernel and is likely to set
unrealistic expectations for submitters.  Tell submitters to expect 2-3
weeks instead, this will cover more of the kernel.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/process/submitting-patches.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
index efac910e2659..3fcfa029c9b3 100644
--- a/Documentation/process/submitting-patches.rst
+++ b/Documentation/process/submitting-patches.rst
@@ -366,10 +366,10 @@ busy people and may not get to your patch right away.
 
 Once upon a time, patches used to disappear into the void without comment,
 but the development process works more smoothly than that now.  You should
-receive comments within a week or so; if that does not happen, make sure
-that you have sent your patches to the right place.  Wait for a minimum of
-one week before resubmitting or pinging reviewers - possibly longer during
-busy times like merge windows.
+receive comments within a few weeks (typically 2-3); if that does not
+happen, make sure that you have sent your patches to the right place.
+Wait for a minimum of one week before resubmitting or pinging reviewers
+- possibly longer during busy times like merge windows.
 
 It's also ok to resend the patch or the patch series after a couple of
 weeks with the word "RESEND" added to the subject line::

---
base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
change-id: 20230912-submitting-patches-delay-a9224ba2b784

Best regards,
-- 
Mark Brown <broonie@kernel.org>

