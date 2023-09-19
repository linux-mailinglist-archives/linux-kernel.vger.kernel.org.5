Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B81AB7A5B63
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 09:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231804AbjISHlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 03:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbjISHlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 03:41:00 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D339100
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 00:40:54 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2c008d8fd07so31429721fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 00:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1695109252; x=1695714052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zIZLmfcwEqQKatRYsYmTe5x1vkObbB5a/MorlWyMkXw=;
        b=EEa1kexzwJPZWMVHWnEwZf74yHGR0v9QBwYtSi5U865cQSU+6OgAL6BtnRf/bofOfL
         6EfdogIh6yE3XSL0QmqPKvmBo6M64Nd47TNr8vajvxlmOU7MTP3lmKqSzmE+B0vTjFTE
         sYx8uss4Rls6KTTFti9zCLwEXbynKgUAMI8kwyBdpnfhA+bU6uFQ7Q2/7NggQsxaHGWy
         hJ9g09gAxQ0CHWAUlYKVldwTAZj2UNACQnfnbDlBe6pmVl3f55x0fOLJfe3JHIpYRbDG
         iL3jcFcF/QrhY7iukXFZKvEWArmCYaP+c65gfxgkWWpWotpa54qsWOlODv6AHxxBCPOx
         FioA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695109252; x=1695714052;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zIZLmfcwEqQKatRYsYmTe5x1vkObbB5a/MorlWyMkXw=;
        b=Y7FLlQNIPXYqbB7gHh+Jxjl5BGNhA6IEF0nY61I5sKhGUnTAJ6aCDPRKZuPv0AnTtS
         iyJnQv1j28ZGf5MVMhvhxD03GeEVmpb9Qr2bX+LvSC61nfwcL08QY3VRu9wUzBCI5sUM
         vPlxPAOEr1c7iQ0gJx8PxZPj3kG40m+1lLhx7Z2lMoyD+5WlkR23dDEJSqHxzL+BwZ7x
         Ii23KSOsXDOUyO6nCod7wdFr6FNTLb9+ufZWsvg515XuQtoal/pX5UzkEZC7hTk/niFf
         TTHmkG/iCUrvYyx1BQTsBCJnC1nW41lRpjN7T6H0n8ciE0JNOC0fE8ghto3lWgIo+42i
         L6Gg==
X-Gm-Message-State: AOJu0YzsBSb/hx6hG5J+Mzy1vIzquTB9vNIkyugucnHDqAj712cxZMyr
        j7q9B2tVf4jvrKGO8pTGqD0EYw==
X-Google-Smtp-Source: AGHT+IFESMgia33Unj4qgPgTAu0YapNLJtmXQLw5hb/i0fdDpFD8z/N9ycFzJljSRyh/xRbHoJilbQ==
X-Received: by 2002:a2e:151a:0:b0:2c0:2e1b:5627 with SMTP id s26-20020a2e151a000000b002c02e1b5627mr458469ljd.35.1695109252437;
        Tue, 19 Sep 2023 00:40:52 -0700 (PDT)
Received: from heron.intern.cm-ag (p200300dc6f209c00529a4cfffe3dd983.dip0.t-ipconnect.de. [2003:dc:6f20:9c00:529a:4cff:fe3d:d983])
        by smtp.gmail.com with ESMTPSA id fy20-20020a170906b7d400b009ada9f7217asm7441851ejb.88.2023.09.19.00.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 00:40:52 -0700 (PDT)
From:   Max Kellermann <max.kellermann@ionos.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     Max Kellermann <max.kellermann@ionos.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fs/pipe: remove duplicate "offset" initializer
Date:   Tue, 19 Sep 2023 09:40:44 +0200
Message-Id: <20230919074045.1066796-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This code duplication was introduced by commit a194dfe6e6f6 ("pipe:
Rearrange sequence in pipe_write() to preallocate slot"), but since
the pipe's mutex is locked, nobody else can modify the value
meanwhile.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/pipe.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index 6c1a9b1db907..139190165a1c 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -537,7 +537,6 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 				break;
 			}
 			ret += copied;
-			buf->offset = 0;
 			buf->len = copied;
 
 			if (!iov_iter_count(from))
-- 
2.39.2

