Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B74B57939FA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 12:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238711AbjIFKet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 06:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbjIFKes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 06:34:48 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B86CE2;
        Wed,  6 Sep 2023 03:34:44 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-401da71b85eso33317505e9.1;
        Wed, 06 Sep 2023 03:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693996483; x=1694601283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Pzv/jhWdIYV8f2S0GJB7hfkrab1bo9KaJh3rolVzKd8=;
        b=PcL/mAwlNAGaVfAwmPAO7n5RW5t1tN3L+fr7sn/JDNBQTxcVXshd1U8QqVMWDhrqRV
         CyfvkoRUi40wkquU2k8Q6tVprx3zDbC0xo+O2AfA5V4jYmGfoMESro6N77xfTEq6OPvx
         fr8zJwqEpMiquj2eftVS0m3Gm7gGSal9NcAPc9ogn8YA08TLWPoAyWpvYBJ4GoUb+v32
         hkgqNHE4YLwRC1uaEKiHoFwdeaU6UuCj1/NOAf6YC23pZMaJ7Pv6aUn1zi66/dyTMWvu
         CMI9OYNJ68iNpFqoPZqT3CP+ri+hfJ+IvTLdYdF9cx8PJ/mcLOYQtKR5WkUDFqNxxFut
         pzFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693996483; x=1694601283;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pzv/jhWdIYV8f2S0GJB7hfkrab1bo9KaJh3rolVzKd8=;
        b=eJYZZFmGSBgA7wG7m/E13WuAVr3IyhDh51VCffpYuclNtmR24JHT5xrZm5NiuWgsZz
         YCdbvjr2xJKdViIssxoQGT4kIFL/G3ryibx4q6kdPr1cG2MixgBndHgsVn/ouGCmEm2e
         1bMRE1BMJRKvwN2sqHbe7YiNE0nODXYOo8516PVttSRdPccGg/pgnITw5OQ4RZRroPX4
         DU3xICJl6Xyn0BUqntoiflSEe5OGXiuFkK/ueDAyJDrVC2LaAQJXAGY2h9FTMKbJqlvG
         6pkfhvyk//ygTxzdh3RdXaRdPF3jubrCCdFbf3D4OdTLrVGxm+S7p2ETh5Qp2xhg3+W7
         9XSw==
X-Gm-Message-State: AOJu0Yzok7oQw3cZSwB49snt6dPk6PLNfVP7U3fFh/6QKQJV0STfi9WU
        sItfK9w52w8PTFSjcxnyoqY=
X-Google-Smtp-Source: AGHT+IEIRaeR7VSl/eoJHT+i35SM7lSwnpp17Bb3Dk4ntwPthbFDPph/QSqFhOmy1DYCk4DISQpqSg==
X-Received: by 2002:a05:600c:28b:b0:3fc:e1:24b5 with SMTP id 11-20020a05600c028b00b003fc00e124b5mr1715734wmk.23.1693996482367;
        Wed, 06 Sep 2023 03:34:42 -0700 (PDT)
Received: from lab.hqhome163.com ([194.183.10.152])
        by smtp.googlemail.com with ESMTPSA id f3-20020a7bc8c3000000b00401c595fcc7sm22630243wml.11.2023.09.06.03.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 03:34:41 -0700 (PDT)
From:   "Alessandro Carminati (Red Hat)" <alessandro.carminati@gmail.com>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alessandro Carminati <alessandro.carminati@gmail.com>,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] tools/verification/dot2/dot2k: Delete duplicate imports
Date:   Wed,  6 Sep 2023 10:33:56 +0000
Message-Id: <20230906103356.3916844-1-alessandro.carminati@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The presence of duplicate import lines appears to be a typo.
Removing them.

Signed-off-by: Alessandro Carminati (Red Hat) <alessandro.carminati@gmail.com>
---
 tools/verification/dot2/dot2k | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/verification/dot2/dot2k b/tools/verification/dot2/dot2k
index 9dcd38abe20a..d4d7e52d549e 100644
--- a/tools/verification/dot2/dot2k
+++ b/tools/verification/dot2/dot2k
@@ -15,8 +15,6 @@ if __name__ == '__main__':
     import os
     import platform
     import sys
-    import sys
-    import argparse
 
     parser = argparse.ArgumentParser(description='transform .dot file into kernel rv monitor')
     parser.add_argument('-d', "--dot", dest="dot_file", required=True)
-- 
2.34.1

