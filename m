Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0742875AB40
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 11:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbjGTJrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 05:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbjGTJq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 05:46:57 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA4AC46A6;
        Thu, 20 Jul 2023 02:43:24 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4fb77f21c63so867738e87.2;
        Thu, 20 Jul 2023 02:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689846203; x=1690451003;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DhzN4qcCsXrBpHBz7GecFneSOqYVBbg2vRpxqza4atk=;
        b=R0uk7n9H4QRbDY75AOIL55xFhZJc3quqJrlQe9yBxWnYtPe1vx4CrXdpDhxJQ4+Tv7
         /Hf3XmBgoHeCA414NXsttQZs7TTyFA5yfEXLhZjB5QWETq+70O1Lp2w8aj4Six7yMRdk
         /1b95eH9nKFrTzN2yBWUvPAAjMKCinMLZYFMyIgFocZVSolFcblbOF/oyc77A1x5T6Nc
         HUmRLZ6dIuAs5m945/a8nJaBKeYQ0JxUu2C5ApryyPbEa1hOjUXShwt6pyDGovrMcsOi
         8O5i/seeNAZb4AXacxCetyHr8sGzcgXChcRaYDbbEYsAGTeDW3c09j2MR3UGPNlBenP0
         lJhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689846203; x=1690451003;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DhzN4qcCsXrBpHBz7GecFneSOqYVBbg2vRpxqza4atk=;
        b=LtWf2nHtE9q0ReFE8DsSDaerirnA5yCY2pSFKSELOdCVBoEui3+hSyYYTZQiSnyN7r
         Hu7U/woY16n9ewpQz5lLePOpHOIKMB+RfJyc3fiQmfxyNJOTG3NLK+G/htNRJ1cJm/Wt
         f0olEAuuFZ8yfr1GFrZ2ME9QgW+MqNqPWvF0yQpZkpw8DjeBAnM2lCBfJGphR0PFWJ5A
         FTDK924xQcNpWGeZZvQ0qh67qwdGKTzQVgL0In4BALeNRZXjqDms8x4ES/A4Ed3r7oWK
         Xes4qVDfYcMTVh0GkOGxqHE5PO2GwciCOQeFrWsJV8M57aKRvLMQhaOJmdcQJSY/hJjM
         5C2Q==
X-Gm-Message-State: ABy/qLYU+tcZfD6e5Q5CyFJo11H7eMoU6iCbQr4zh6535cYf+spDA+i7
        +CDjf3nED7JPqRVFBt2B5gQ=
X-Google-Smtp-Source: APBJJlFEX9pibdR1e+6fRVOrpfAnUm08G0crM+2MIHDpBWy+r0Xk0zxxXVd5dIwAGZICk/3NsxouOw==
X-Received: by 2002:a19:6705:0:b0:4fb:780d:2a49 with SMTP id b5-20020a196705000000b004fb780d2a49mr1592371lfc.5.1689846202847;
        Thu, 20 Jul 2023 02:43:22 -0700 (PDT)
Received: from lukas-virtualBox.synapse.com ([94.42.83.62])
        by smtp.gmail.com with ESMTPSA id t28-20020ac243bc000000b004fb8603f6e0sm122441lfl.12.2023.07.20.02.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 02:43:22 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     David Howells <dhowells@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-afs@lists.infradead.org, linux-doc@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] afs: Documentation: correct reference to CONFIG_AFS_FS
Date:   Thu, 20 Jul 2023 11:43:01 +0200
Message-Id: <20230720094301.9888-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 0795e7c031c4 ("[AFS]: Update the AFS fs documentation.") adds a new
section listing the build configuration options that need to be enabled for
the AFS file system.

The documentation refers to CONFIG_AFS, but the option is called
CONFIG_AFS_FS, since the beginning of Linux's git history.

Refer to the config option with the correct name.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 Documentation/filesystems/afs.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/filesystems/afs.rst b/Documentation/filesystems/afs.rst
index ca062a7f8ee2..f15ba388bbde 100644
--- a/Documentation/filesystems/afs.rst
+++ b/Documentation/filesystems/afs.rst
@@ -44,7 +44,7 @@ options::
 
 	CONFIG_AF_RXRPC		- The RxRPC protocol transport
 	CONFIG_RXKAD		- The RxRPC Kerberos security handler
-	CONFIG_AFS		- The AFS filesystem
+	CONFIG_AFS_FS		- The AFS filesystem
 
 Additionally, the following can be turned on to aid debugging::
 
-- 
2.34.1

