Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7342C7C802C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 10:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbjJMI0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 04:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbjJMI0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 04:26:47 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D52C9
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 01:26:45 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-5aaefc07e5cso295039a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 01:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697185605; x=1697790405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rkm4IcvDcpDNyn/dmP3dcHytJ9yQBVbR6NWIK3pDrZM=;
        b=mVoaSgwSZQXPJHkKENd6Lo5eP97Z+DmMYW9vr2pEhCbbFAnqZ7gBiVN2a4NPFYHCCY
         FQWhQ2C/KqvF+Orl1Y0bG9wQS7oNuX1znOn6dFJrh0Xo6QXxtunqNnEGMshhjKcZbGIM
         ea8V3pio81TbBxQmNab/FWmOx/I+mAdwIJoK8YhhGTl/gwYepONAMBFOR8klK37enfj/
         arJm9g6+wIIuv4DNafwu7vIqMeERuLcBi3eRCvYZOjruEdIAfVuNtv5xB6TQg9orzdCt
         jbeptGsRZjWdo5ADnYBA6ZB5wiuBU3iAZsIi4fHGJwqTRnP0PM3MqoIlYzgHi9wFSupP
         qFbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697185605; x=1697790405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rkm4IcvDcpDNyn/dmP3dcHytJ9yQBVbR6NWIK3pDrZM=;
        b=uvAXbPURtO7K93jb3YaVFcli9emq+Y375yCHS33CAi2BNFQe5idDrbsQaJPa/bMIx2
         sbfXhdnNpTiB2V+3A1MyH/gVgLhFXX68IDQQRLBRBsnoSiPjCB18PScmt1sD22wfu2v5
         ENjZ1IPFM1gehBzMd08/T2QqmdRn1J3cI2cVJOch6xCOE+MoE9Hn+ELBVxYL5ri/yeah
         cARj4ROKFO6V2ZSUjk19k1JN0rF5utmN6tcjGHqVmOtmDLPs/cSVPSlTONC4ukaGTN6Z
         yiSyA1fUcffRrK2m5gsCNT5pnQBllmpXHt2VhKv4/1TuT2/M7cEW+ZMOU84seRP72oCw
         QcXA==
X-Gm-Message-State: AOJu0YyL/bhyz5xmkTYM6/G4daBUgSff9czvYN5CLJpn6D/fkUKnUcOb
        Ypgo18hC4nfzz4H+gMKuZzs=
X-Google-Smtp-Source: AGHT+IEnkD3fJTLnpb3gJCiRJN6IeKkhjz9YeEaS+p77uWERLqbdpt8wkEWytRz9aVoL7c4boqudiw==
X-Received: by 2002:a17:90a:f3cc:b0:27d:3296:b3e with SMTP id ha12-20020a17090af3cc00b0027d32960b3emr1629224pjb.41.1697185605061;
        Fri, 13 Oct 2023 01:26:45 -0700 (PDT)
Received: from Negi ([68.181.16.134])
        by smtp.gmail.com with ESMTPSA id c12-20020a170903234c00b001bc59cd718asm3280524plh.278.2023.10.13.01.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 01:26:44 -0700 (PDT)
From:   Soumya Negi <soumya.negi97@gmail.com>
To:     Jonathan Kim <jonathankim@gctsemi.com>,
        Dean ahn <deanahn@gctsemi.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     outreachy@lists.linux.dev, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Soumya Negi <soumya.negi97@gmail.com>
Subject: [PATCH 2/2] tty: gdm724x: Add blank line after declaration
Date:   Fri, 13 Oct 2023 01:26:35 -0700
Message-ID: <3b24ca9976cf873dbaadb499e09d7b545e9db89c.1697184167.git.soumya.negi97@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1697184167.git.soumya.negi97@gmail.com>
References: <cover.1697184167.git.soumya.negi97@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix WARNING: Missing a blank line after declarations
Issue found by checkpatch.pl

Signed-off-by: Soumya Negi <soumya.negi97@gmail.com>
---
 drivers/staging/gdm724x/gdm_tty.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/gdm724x/gdm_tty.c b/drivers/staging/gdm724x/gdm_tty.c
index 4e5cac76db58..0c61eaff6122 100644
--- a/drivers/staging/gdm724x/gdm_tty.c
+++ b/drivers/staging/gdm724x/gdm_tty.c
@@ -160,6 +160,7 @@ static ssize_t gdm_tty_write(struct tty_struct *tty, const u8 *buf, size_t len)
 
 	while (remain) {
 		size_t sending_len = min_t(size_t, MUX_TX_MAX_SIZE, remain);
+
 		gdm->tty_dev->send_func(gdm->tty_dev->priv_dev,
 					(void *)(buf + sent_len),
 					sending_len,
-- 
2.42.0

