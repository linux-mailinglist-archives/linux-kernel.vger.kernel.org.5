Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60A0275E215
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 15:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbjGWNaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 09:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGWNaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 09:30:08 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA4A10C9
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 06:30:03 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b701dee4bfso50385491fa.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 06:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690119002; x=1690723802;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nzYFzRzP7i0c6DYPDuN0yOXQ/LKGeHJaUfK0vwejrvA=;
        b=SuNbWUVBNcoIVYaGMiFhxCT87+Z8Iw8FIsxquqXDTEFGgrzVwzhQYX94n70Q39UsRf
         fjQ6canVSvU3et2bSgbSGipIVkwIQOIvljyPzqKp8gGEjlJGKn6649TzIcP0MV7DkmHy
         jRTvozh6JkyioHu96i/lRKZ5banbq4rd2y0K+sL4WdEIxNEZ72obmFGkDxWJZVrxgxQ+
         te4x2P2Ip8ra7byXZvO9ZoXpHQSY3iJwt++NO+gl5jiucfkZYnq8VhmqZHUYZVTj/z7X
         0YD/7IETFslDT5rtWGCqNXIVTLXEu76U5y/r7FFtyn01qehbH6zdNrP4+ISKdvn/Qtaj
         Kq4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690119002; x=1690723802;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nzYFzRzP7i0c6DYPDuN0yOXQ/LKGeHJaUfK0vwejrvA=;
        b=ljvqFZEqXyFjzN3xYHw43i6l0mbB8KJ3W276eMKfb0hJdDUe0co10lRBgjCFB+H00T
         2YTVOlvdWgeTKdr02AeMFGphHNk0a8L8a/oSeS9mYC0US7glZB+IK1M66EJIoy3GSp5V
         suLbiH17/h+YVJpk3eI46g/B7K1IuYw8tHLA+ZmAB6mZ9qPsX6CgKm2KoaR5YLJDkmJJ
         rkagDAkpamveYh4l0Fu/NH7fO5+55nuUekWz32iEkZ06x5TQeilILo92nja82f7XaQEe
         2oOu4SRz8vdDFCoM9YAgwxjpOU4oxyungU5bw33y1kOHDsOvucRofFyr6DdVme7l6i4M
         KoRQ==
X-Gm-Message-State: ABy/qLakQ+bW21dWKSaWXOhrfymdJhgxqFm4DNayPV7dcYa377i+sHly
        WNygHIrl3auZ1Hkt/ueWtRQ=
X-Google-Smtp-Source: APBJJlHAqctAbylZ7n/HbAQDPO4nE2oqQlTJf+9jf9mG/GvyFj5oahtXRZRQ9VBTpMQxtDaeOFk+jA==
X-Received: by 2002:a2e:9058:0:b0:2b7:4078:13e0 with SMTP id n24-20020a2e9058000000b002b7407813e0mr4742383ljg.43.1690119001589;
        Sun, 23 Jul 2023 06:30:01 -0700 (PDT)
Received: from halip-Pc.42.fr ([93.188.41.70])
        by smtp.gmail.com with ESMTPSA id k15-20020a2e240f000000b002b6eb5db863sm2158270ljk.43.2023.07.23.06.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 06:30:01 -0700 (PDT)
From:   Aleksei Filippov <halip0503@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     halip0503@gmail.com, jfs-discussion@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, shaggy@kernel.org,
        syzbot+5f088f29593e6b4c8db8@syzkaller.appspotmail.com
Subject: [PATCH v3] jfs: validate max amount of blocks before allocation.
Date:   Sun, 23 Jul 2023 16:29:59 +0300
Message-Id: <20230723132959.4945-1-halip0503@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <2023072318-semantic-payee-0162@gregkh>
References: <2023072318-semantic-payee-0162@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexei Filippov <halip0503@gmail.com>

The lack of checking bmp->db_max_freebud in extBalloc() can lead to
shift out of bounds, so this patch prevents undefined behavior, because
bmp->db_max_freebud == -1 only if there is no free space.

Signed-off-by: Aleksei Filippov <halip0503@gmail.com>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-and-tested-by: syzbot+5f088f29593e6b4c8db8@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?id=01abadbd6ae6a08b1f1987aa61554c6b3ac19ff2
---
 fs/jfs/jfs_extent.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/jfs/jfs_extent.c b/fs/jfs/jfs_extent.c
index ae99a7e232ee..a82751e6c47f 100644
--- a/fs/jfs/jfs_extent.c
+++ b/fs/jfs/jfs_extent.c
@@ -311,6 +311,11 @@ extBalloc(struct inode *ip, s64 hint, s64 * nblocks, s64 * blkno)
 	 * blocks in the map. in that case, we'll start off with the
 	 * maximum free.
 	 */
+
+	/* give up if no space left */
+	if (bmp->db_maxfreebud == -1)
+		return -ENOSPC;
+
 	max = (s64) 1 << bmp->db_maxfreebud;
 	if (*nblocks >= max && *nblocks > nbperpage)
 		nb = nblks = (max > nbperpage) ? max : nbperpage;
-- 
2.25.1

Fix commit message.
