Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9E247976C0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240925AbjIGQQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240146AbjIGQPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:15:49 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3726900F;
        Thu,  7 Sep 2023 09:13:51 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id e9e14a558f8ab-34f2d7c1bc8so4423615ab.1;
        Thu, 07 Sep 2023 09:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694103167; x=1694707967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=229tRrHSXoxQdGlKz52ZOwfltW+JYEKB7qFRaZLcAY8=;
        b=F02jVBtH3BtPZg9vlGEgoDJs1RMMbCyuYIyjX+P2OjV6F1HvzhtDho4oZFATWpyMCx
         0nrhP2MS+W+KMTI5/zTAykTwT0aKBlmrukKd61T4Up579J6zc5qr3MfEHML+pKvEEZgd
         tEUjTiIoHQHmY/lYDrZnCtyK++IAeXA/GQ0KuLTfbDtknh3SgM5yUvnpzJhGlUVPrDP9
         UJzHJFsKwhkhICxj5yVmyEyIHv294EUuqek1neWdsA5VJpPFyjZbyb5imZr8hRsac1Xq
         i58tLEO/7pnx6tKo5z3YeG0ehaqoCO4FyCKSAEFz2P5XbTg+5zLntjxv9RfWH9Yj8HD9
         5k6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694103167; x=1694707967;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=229tRrHSXoxQdGlKz52ZOwfltW+JYEKB7qFRaZLcAY8=;
        b=KdZvN2C+g6CquFqtz1nNQE9TTWaPUIGJvBGrexslL4UL/cpFKdJ7lk45W+88naCCdi
         swTYFPGL1D++ChSu6EbvU8tpRjd3edeDmDtnz6tE9laViWJql44N829pS+Znn1mxAQg7
         DXUu8Z/fOdMXM+ZLScy7se+m1iHDhQOeNLJQZ5l+mUf21GZnp6pN6e/3T6OMTdPPz+LJ
         GkERiA+TT7lSZMoUMOsUkj5xQQkUqtbAHJlt5I4CMU7IK0W03/tNXmESXmljrZO5le5M
         V0UWqugphedydruVwTpnJbak6lGbzd8EmoTHijkNP20ViAq5Ff+RA1AqnYe8VMOthZZ7
         Dilg==
X-Gm-Message-State: AOJu0YwI72IeUcx/WtF+tNV1FVTOK5hL7oKJlJLY+2TrNLx/MLAENAYv
        M+Z0AA2/+IAeY2MKrrk37HDZVovoDAc=
X-Google-Smtp-Source: AGHT+IFDeV6B7EiSr4E6KZGhT+Wu/3NBbmvxHfrjLjcTaL2XMpoYF46hBVOIL+JMWVdKmde2D+NX0g==
X-Received: by 2002:a0c:9c41:0:b0:64f:3ed2:c2da with SMTP id w1-20020a0c9c41000000b0064f3ed2c2damr18488068qve.55.1694087806681;
        Thu, 07 Sep 2023 04:56:46 -0700 (PDT)
Received: from localhost.localdomain ([154.16.192.36])
        by smtp.gmail.com with ESMTPSA id h20-20020a0cab14000000b0064f4f9ddc72sm6315624qvb.21.2023.09.07.04.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 04:56:46 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     corbet@lwn.net, workflows@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, jesper.juhl@gmail.com
Subject: [PATCH] Documentation: Process: Add a note about git way of applying patch
Date:   Thu,  7 Sep 2023 17:22:11 +0530
Message-ID: <20230907115420.28642-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cc: jesper.juhl@gmail.com

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 Documentation/process/applying-patches.rst | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/process/applying-patches.rst b/Documentation/process/applying-patches.rst
index c269f5e1a0a3..201b9900bffe 100644
--- a/Documentation/process/applying-patches.rst
+++ b/Documentation/process/applying-patches.rst
@@ -6,6 +6,13 @@ Applying Patches To The Linux Kernel
 Original by:
 	Jesper Juhl, August 2005

+
+.. applying patch by Git::
+
+    You can use the below syntax to patch in git repository
+    git-apply --whitespace=error-all <patchfile>
+
+
 .. note::

    This document is obsolete.  In most cases, rather than using ``patch``
--
2.41.0

