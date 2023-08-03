Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5991E76E759
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 13:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234753AbjHCLua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 07:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233397AbjHCLu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 07:50:28 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC3A72D71
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 04:50:25 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b9d3dacb33so12899981fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 04:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1691063424; x=1691668224;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Zvyb10HDvsmh+PexnOEBZlHH3rP9KoiW9BC4wjGKsao=;
        b=QeScwRi//A1jNaEUeYj5foywBnwP6HelKlyGy8Tgmf3z1pxNVnrXaZ1C2Wp/4aVUdo
         swtwpJ0I4lhU14S0EoXxZRLhiV4VY+raPCHnlNpt9ATC1z072uVLdZWjMNbf3LT195zB
         jPcrVnUQ2Z51IkL1NDuQ7TtW0kp7FijA54eck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691063424; x=1691668224;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zvyb10HDvsmh+PexnOEBZlHH3rP9KoiW9BC4wjGKsao=;
        b=EDrZVzWqt9BUml+J2IhiOjDV1YVcKXsNQOrNEts6nOsSpKOqeZpyfbC4mzVilyjbMm
         YSyd5sK9LIzTnCsscwWtxXOgyC65+cAmosP7L3/i6jM+ueCTSbbkVYIBTjlleZVzScrn
         UfrI4OqCFwbW+zUEhUnGr4C0hB1SyKI6nUpr+BFhNgZhSxZI9mH/5vggFgfkaJGTBv/0
         mu5rbo00vMiy08ULOaCY+ewMsieefCW6MIDZ9RMPfL/Q/LPASWT1bG88ed9WvICa9F4L
         hiSonkC5unGrt8Mhtpg35xn5WYKBw6PHAw/vtY9rO8VXpIbH9vXxD46OPZ3yX9GRC64E
         3ABg==
X-Gm-Message-State: ABy/qLar1eabbMCilzsgTX+5pKzCjpUF5tHri2bOa84VIvXmUXX3CdnP
        SF7tgfFX+NS5lfkqzLUNxMZ3dMaqgHQJ1YUcfBc=
X-Google-Smtp-Source: APBJJlGwbUglL8O3IawIZHfPTYamp3cCcpel03ST5mVDQTcFhbH/+sQLiP+zJ7r17bPOQpLvosAtbQ==
X-Received: by 2002:a2e:9295:0:b0:2b6:9afe:191c with SMTP id d21-20020a2e9295000000b002b69afe191cmr7405750ljh.7.1691063423715;
        Thu, 03 Aug 2023 04:50:23 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id n21-20020a170906689500b009944e955e19sm10339968ejr.30.2023.08.03.04.50.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 04:50:23 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] scripts/setlocalversion: clean up stale comment
Date:   Thu,  3 Aug 2023 13:50:20 +0200
Message-Id: <20230803115020.2280542-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nobody has complained since 2a73cce2dad3 ("scripts/setlocalversion:
remove mercurial, svn and git-svn supports"), so let's also clean up
the header comment accordingly.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 scripts/setlocalversion | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/setlocalversion b/scripts/setlocalversion
index bbb6c7d545f4..e07795d1763b 100755
--- a/scripts/setlocalversion
+++ b/scripts/setlocalversion
@@ -2,7 +2,7 @@
 # SPDX-License-Identifier: GPL-2.0
 #
 # This scripts adds local version information from the version
-# control systems git, mercurial (hg) and subversion (svn).
+# control system git.
 #
 # If something goes wrong, send a mail the kernel build mailinglist
 # (see MAINTAINERS) and CC Nico Schottelius
-- 
2.37.2

