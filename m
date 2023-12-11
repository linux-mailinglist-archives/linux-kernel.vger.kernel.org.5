Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF9480C33D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 09:30:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233950AbjLKIaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 03:30:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbjLKIa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 03:30:28 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EEADEA;
        Mon, 11 Dec 2023 00:30:35 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-54c9116d05fso5835759a12.3;
        Mon, 11 Dec 2023 00:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702283433; x=1702888233; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=18T4h+PgamAj+KI6bp/QSD69CdQrdRYfbgvXoI1RLic=;
        b=P1Zzc6+iFlFAKhDjRlzqpNeEN+vcdQpuMyih03w5wPLWFJ36iIrFb24Eg0vv+HdBk8
         o5VfwLeP2ibW8Cx/5DWeWlgMfIyRjKOMTjdlJo3iztqxEC0qRq7tI6dr2JFWitznFHqa
         8JYvC/UWzj7MsdQqcJ3opByp/AZ7ppYHcIVvquTBTyqVbyba102tBY+KNYXFH2PRZF+l
         sQ+E8oY1gPH3tOBHmGgr0bwYZnoJkgGqJwv8fr5L5vIIjFNEaji8hYqH299DUiXyS5l1
         6fWmvNChqw5IqNl1/aSNmvXQd6CYuK2RBEp+plNOrcTyBeWX5FVSFoMMQwGQ6yeMIFKY
         ygNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702283433; x=1702888233;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=18T4h+PgamAj+KI6bp/QSD69CdQrdRYfbgvXoI1RLic=;
        b=s3efvkK6XYnx4oTz/9d9scCmOMkQaKh+ok+/Y2IbKIoRrXjHem4gc3d2GsLnwyVc6C
         y5Eh0aBqHwLiOAeBufjCG+HCJOjDfWDrPlBJK8t51JgJ9yuNe9iwMwsXHlxwHFKbjaHR
         dpoIOpmNlMB6NihPe8knrOxXJZk9oNnm41L3zuiFmWiwoXbj4nx0X0AERlW9JF5CGZyJ
         EvB++uy4t1Wkx8Qt0uHm5ToOuDMJRkN+Zvp7KaKbpB3d/mZJxl2TFdqQJzn5bklLerDM
         Jy0J745/sBpVLRiGt3Rzihb9cAg0awXnhCYCk6woQN9T5ZkE/nH7V8zO7Kew5LlTtaUy
         FlrA==
X-Gm-Message-State: AOJu0YxI1Sydgsi9g1qr8TzZMQtreztj3UKZvdFslWYJMS7AofCxQKow
        20g4XAZHU/l0Nw2oGxP/st4=
X-Google-Smtp-Source: AGHT+IHwo3tENLZikbGvr+646iwwTYiz4cdrWDuYWM/443fGx/HRWeThopo660yjJ+w35HHx4n/g6A==
X-Received: by 2002:a50:9f84:0:b0:550:e9b8:50a6 with SMTP id c4-20020a509f84000000b00550e9b850a6mr1078124edf.63.1702283432887;
        Mon, 11 Dec 2023 00:30:32 -0800 (PST)
Received: from felia.fritz.box ([2a02:810d:7e40:14b0:187:91eb:e4d:dd96])
        by smtp.gmail.com with ESMTPSA id c28-20020a50f61c000000b0054c5d3486e9sm3564242edn.76.2023.12.11.00.30.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 00:30:32 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Christoph Hellwig <hch@lst.de>,
        "David S . Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH RESEND] sparc: remove obsolete config ARCH_ATU
Date:   Mon, 11 Dec 2023 09:30:29 +0100
Message-Id: <20231211083029.22078-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before consolidation of commit 4965a68780c5 ("arch: define the
ARCH_DMA_ADDR_T_64BIT config symbol in lib/Kconfig"), the config ARCH_ATU
was used to control the state of the config ARCH_DMA_ADDR_T_64BIT. After
this consolidation, the config ARCH_ATU has been without use and effect.

Remove this obsolete config.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---

 arch/sparc/Kconfig | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 49849790e66d..6b4d3182baae 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -112,10 +112,6 @@ config ARCH_PROC_KCORE_TEXT
 config CPU_BIG_ENDIAN
 	def_bool y
 
-config ARCH_ATU
-	bool
-	default y if SPARC64
-
 config STACKTRACE_SUPPORT
 	bool
 	default y if SPARC64
-- 
2.17.1

