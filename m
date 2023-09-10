Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CBB2799C86
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 06:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238403AbjIJEIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 00:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232538AbjIJEIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 00:08:22 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE43CC;
        Sat,  9 Sep 2023 21:08:18 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-6493389c56fso19875826d6.2;
        Sat, 09 Sep 2023 21:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694318897; x=1694923697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R3+2PGmoiy9X+KnZrSJrk+Ytx7sq+T9gDzRcG6umpdA=;
        b=f0D7mIr9naX6IZ7qkD8Okxb5UsuxzQsjjYl18TBzEY3w1h7yHkju18pBYJL5Z8C0TH
         TRi2/CcWvQx+ifGZRV5nNu/gkyX9AKe9FO4UMuB2wPTI/GkwnGdloXxQhc5HistfsKZw
         kyOm3LUI40XARcRyG0oke5G01bPcyDnY6NMsBw4sy5Fdlm+PQElvaXI/FhrJ+fu4wxwS
         f6rHCotWFo3nHyeAVsKEmgPpBYPp/FV5ljn+3pvRIf+37j3+4SshAGC9XBnkaWuSCJJ0
         Nui6p5aa3sp8C8oSRC6WP1Xlh2NQcuYklxhQTnXQZA8pj1BGeKXsUIAgiMRXifY3JM4H
         PlbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694318897; x=1694923697;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R3+2PGmoiy9X+KnZrSJrk+Ytx7sq+T9gDzRcG6umpdA=;
        b=uJ3nruH8UAXgmIJ5pAGCJXVR1J1HDqJlJp7wSEp6lpTgONVczCrxq488eO8G37ObI2
         sntwP6NoKInit0mDW+oCdfmiVoAr4LyEcZ+kbLjjGfO/eCUwNGtzsr+aBLR+H2edFm9n
         d/QGL7zr4C7eDYoCSaKzsuedD23CFjODVOyNH4UYtLW758nVJ/F1K95+4UVOEM364CPO
         MPO8qWNYMcwOp0gbzK71MF8V4nrdVk/q+u8LbwVGGXAk9uNEQhrBvxhM6MJujdOJ0Mwj
         CC7GdpCisBbPNTpgDqPXyhm5hs2pPETPIUSQk5ocqutrnWwFEN6iNqrhgq4BWoB8l1zq
         nGJw==
X-Gm-Message-State: AOJu0YxaOcjHCD+kwwpR74aQdNbzA+WVLChPxxsiRbotZr4XyfGUBRMC
        jvBE68IWlzzKnd6Ew2ReUbEpLGIfvDU=
X-Google-Smtp-Source: AGHT+IFpRN/w+o7kLwf6EV95mD6p0bWBb0dzBu0qj07J07d9NCzY08A2Dfe9A2S9ERAtVmPUvUUCvw==
X-Received: by 2002:a05:620a:2551:b0:76f:e93:eb0 with SMTP id s17-20020a05620a255100b0076f0e930eb0mr7610796qko.52.1694318897213;
        Sat, 09 Sep 2023 21:08:17 -0700 (PDT)
Received: from computinator.cable.rcn.com (146-115-147-29.s4891.c3-0.nwt-cbr1.sbo-nwt.ma.cable.rcncustomer.com. [146.115.147.29])
        by smtp.gmail.com with ESMTPSA id q17-20020a05620a039100b0076c9cc1e107sm1631364qkm.54.2023.09.09.21.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Sep 2023 21:08:16 -0700 (PDT)
From:   Oliver Faso <erer1243@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Oliver Faso <erer1243@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] docs/sphinx: Explicitly convert Sphinx paths to str
Date:   Sun, 10 Sep 2023 00:08:06 -0400
Message-ID: <20230910040811.53046-1-erer1243@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sphinx 7.2+ is switching to using pathlib.Path
instead of str to represent paths. This fixes the
current deprecation warnings and eventual breakage.
This conversion will be a no-op when using older
Sphinx versions.

Signed-off-by: Oliver Faso <erer1243@gmail.com>
---
 Documentation/sphinx/kerneldoc.py | 2 +-
 Documentation/sphinx/kfigure.py   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/sphinx/kerneldoc.py b/Documentation/sphinx/kerneldoc.py
index 9395892c7ba3..d26155990ec3 100644
--- a/Documentation/sphinx/kerneldoc.py
+++ b/Documentation/sphinx/kerneldoc.py
@@ -138,7 +138,7 @@ class KernelDocDirective(Directive):
                     lineoffset = int(match.group(1)) - 1
                     # we must eat our comments since the upset the markup
                 else:
-                    doc = env.srcdir + "/" + env.docname + ":" + str(self.lineno)
+                    doc = str(env.srcdir) + "/" + env.docname + ":" + str(self.lineno)
                     result.append(line, doc + ": " + filename, lineoffset)
                     lineoffset += 1
 
diff --git a/Documentation/sphinx/kfigure.py b/Documentation/sphinx/kfigure.py
index cefdbb7e7523..13e885bbd499 100644
--- a/Documentation/sphinx/kfigure.py
+++ b/Documentation/sphinx/kfigure.py
@@ -309,7 +309,7 @@ def convert_image(img_node, translator, src_fname=None):
     if dst_fname:
         # the builder needs not to copy one more time, so pop it if exists.
         translator.builder.images.pop(img_node['uri'], None)
-        _name = dst_fname[len(translator.builder.outdir) + 1:]
+        _name = dst_fname[len(str(translator.builder.outdir)) + 1:]
 
         if isNewer(dst_fname, src_fname):
             kernellog.verbose(app,
-- 
2.42.0

