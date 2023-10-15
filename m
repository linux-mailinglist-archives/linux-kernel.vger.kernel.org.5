Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD7B7C98CE
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 13:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjJOL14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 07:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjJOL1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 07:27:53 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60679C5
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 04:27:52 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5a84204e7aeso13912817b3.0
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 04:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697369271; x=1697974071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v7ir7MAeCxuydH35Tr35csIS6YonhaPinnnXnjQUiNE=;
        b=f7uMt3FIZaCXmZW6sYgUrlus0UeApEfZbRqkmOHQ+Q1DPjzeJeiRE/R1DzTU4yT71l
         3aUW19T/XRMoNfXQaMIBxKUprVBa25Pn3vbyStQy8J4EremR1BT5aMPFTcx2fuyQexJ0
         12+MXxuwRFu9k+tZDStW6lh8hlYwYhEo47qi4ZJRNSnG+ilEy80YJt9G2jokrtR22IHp
         b70d+RooE9UigYcByRlIJxQikIcAUFbFHBy80jo8kHYLubIzGetkYIR6eW6C/i9Zfmbs
         5mZWqwPQV20MFH0k1c3bEnSvCF/y2SzulhU1BgD//7ajG2N1N6oJCXC3tPU6zGYxJ4kb
         xSeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697369271; x=1697974071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v7ir7MAeCxuydH35Tr35csIS6YonhaPinnnXnjQUiNE=;
        b=FRAUeD4xcouJWeZkFNITCe04ctWpEFSfSN35yFRAGZE7AFB4pV80+407VwYqb879UM
         Bxrg2mOdghcRtg5AX6KNHeprhSK+Dh+jYO9qAF11pfGI/Ypj2xQudlr+pJANRkGAGa5v
         7fLqMl5nPIgBTbPviItZybCdJq92R6tFO3a0mHsuNHnjvKiv9bSkgLNN6743AvkR77Lb
         c5hLO5spMypQ24uYwozqDN/vRzuZvjvGmi9TJP9TfBFdYEYYD+M3BN7vt3yc8p3UnnFO
         SV1MtAtM+WeD4gnhi1pXcMi1dxP19bj5t2UCmcXoKiZhQCF/8di0m+hgm4dkiBcklxrl
         mJuQ==
X-Gm-Message-State: AOJu0YxnmX8HeXbYTL5cUoW8JtjD4Y0JHKmFmxHcxSxkSz/82qauro3X
        By5lgNeLqdfRLTKm0vD+TmQ=
X-Google-Smtp-Source: AGHT+IFcE2PgdBj9vA0T4zOBQwYkgLlsRHFJfDYxrV9KMLi9Kdu+kvqWNNMtV8IrigqTTmKnYCh2hw==
X-Received: by 2002:a0d:eb46:0:b0:5a7:b972:a5c0 with SMTP id u67-20020a0deb46000000b005a7b972a5c0mr18945390ywe.3.1697369271317;
        Sun, 15 Oct 2023 04:27:51 -0700 (PDT)
Received: from gilbert-PC ([105.112.18.68])
        by smtp.gmail.com with ESMTPSA id h128-20020a0dde86000000b005925c896bc3sm1333765ywe.53.2023.10.15.04.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Oct 2023 04:27:50 -0700 (PDT)
From:   Gilbert Adikankwu <gilbertadikankwu@gmail.com>
To:     gregkh@linuxfoundation.org, outreachy@lists.linux.dev
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Gilbert Adikankwu <gilbertadikankwu@gmail.com>
Subject: [PATCH 1/6] staging: rtl8192u: Align descendant arguments
Date:   Sun, 15 Oct 2023 12:24:47 +0100
Message-Id: <76218d7a14d7f70c4a1b2f1140a69ac7364f1aef.1697367161.git.gilbertadikankwu@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1697367161.git.gilbertadikankwu@gmail.com>
References: <cover.1697367161.git.gilbertadikankwu@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Align descendant arguments to the open parenthesis as per the "Linux
Kernel coding style" in Documentation/process/coding-style.rst

Mute the following checkpatch error:

CHECK: Alignment should match open parenthesis

Signed-off-by: Gilbert Adikankwu <gilbertadikankwu@gmail.com>
---
 drivers/staging/rtl8192u/r8180_93cx6.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8180_93cx6.c b/drivers/staging/rtl8192u/r8180_93cx6.c
index 2527cea60e3e..1453a0307eb4 100644
--- a/drivers/staging/rtl8192u/r8180_93cx6.c
+++ b/drivers/staging/rtl8192u/r8180_93cx6.c
@@ -114,7 +114,7 @@ int eprom_read(struct net_device *dev, u32 addr)
 	ret = 0;
 	/* enable EPROM programming */
 	write_nic_byte_E(dev, EPROM_CMD,
-		       (EPROM_CMD_PROGRAM << EPROM_CMD_OPERATING_MODE_SHIFT));
+			 (EPROM_CMD_PROGRAM << EPROM_CMD_OPERATING_MODE_SHIFT));
 	force_pci_posting(dev);
 	udelay(EPROM_DELAY);
 
@@ -165,6 +165,6 @@ int eprom_read(struct net_device *dev, u32 addr)
 
 	/* disable EPROM programming */
 	write_nic_byte_E(dev, EPROM_CMD,
-		       (EPROM_CMD_NORMAL << EPROM_CMD_OPERATING_MODE_SHIFT));
+			 (EPROM_CMD_NORMAL << EPROM_CMD_OPERATING_MODE_SHIFT));
 	return ret;
 }
-- 
2.34.1

