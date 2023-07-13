Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD30A752DC2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 01:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234295AbjGMXHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 19:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233753AbjGMXHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 19:07:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 823FDB4;
        Thu, 13 Jul 2023 16:07:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1AA2161AA2;
        Thu, 13 Jul 2023 23:07:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F691C433C7;
        Thu, 13 Jul 2023 23:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689289635;
        bh=hMfGt2Z9rjG2sHth8GGATcreyZMnvzzWfcb91p9Nqu0=;
        h=From:To:Cc:Subject:Date:From;
        b=qMuqshDZZ3V3SGmCKpjOHdhZ+akz3a5Ep/khCw3GWIk8xXSbf7PPuU5I4oJ/cOdyt
         nTEz2fzHWBpFXUU/Dh++Hf434VjiQs5yeATokxLgTfXqRPtNuCgkwhOBUsRpu+YHBP
         J4Rnoovv7Hu6nr1a/jMeKlkwNHPlI9nGdb9I3OLLwSV5UT0oyTgzYW2/NjPFVe1EHr
         tH9yj0iDO/WsjyvI4UDzon/PwAAmc1PKa0B4u9qybrCvBLzp2R6p0Kn35cgEAciGBJ
         4WXOoGyOocVhlw4BIviSV94li+bHwWX7KbH978PbBLZTw/eZJBdJIEQzJ5RYf8+Dk/
         kGHG/coHNQR7g==
From:   Jakub Kicinski <kuba@kernel.org>
To:     corbet@lwn.net
Cc:     workflows@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH docs v2] MAINTAINERS: treat Documentation/maintainer as process docs
Date:   Thu, 13 Jul 2023 16:07:13 -0700
Message-ID: <20230713230713.1505561-1-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A handful of people got caught out by the recent changes in git
which changed the format of Message-ID and broke our recommended
applyhook for adding lore links.

This was fixed in the docs by commit 2bb19e740e9b ("Documentation:
update git configuration for Link: tag") but it seems like few people
have noticed. Add maintainer directory to the process entry so that
workflows@ gets CCed.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - fix order of entries
v1: https://lore.kernel.org/all/20230712161011.1339829-1-kuba@kernel.org/
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3be1bdfe8ecc..fff7e50948b6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6206,6 +6206,7 @@ DOCUMENTATION PROCESS
 M:	Jonathan Corbet <corbet@lwn.net>
 L:	workflows@vger.kernel.org
 S:	Maintained
+F:	Documentation/maintainer/
 F:	Documentation/process/
 
 DOCUMENTATION REPORTING ISSUES
-- 
2.41.0

