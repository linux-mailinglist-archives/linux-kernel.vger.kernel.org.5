Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4479D776661
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 19:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233210AbjHIRWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 13:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233076AbjHIRWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 13:22:31 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0EA2683;
        Wed,  9 Aug 2023 10:22:28 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-3a76cbd4bbfso9057b6e.3;
        Wed, 09 Aug 2023 10:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691601747; x=1692206547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HGa/E1EozA1ONh5cNmJYBRSriG6HQN403JbmkXULwlo=;
        b=QHkxL4RrQNx9OFCHyFpBvsk44awf/Vq6clj94licRmVmCjiBfLy9cpQdUOx9HGPA1o
         AS9veoNcWrXJsy+wJBJRurQ/z2luyCbWDxJrfPQQrpSyov9+HP2LZZ8LRt5pupuwbwVW
         LPUGX2gk6DVrH6qJP30yCFAZu/ik4PJfYn4mNUUxcU58HAO4MiY/dFWVOithnvHr+i43
         rfvuOtzwlH3NaoL4gdgCryaVJSl8zRasS/12R1b0Jb0qPrz/14ae3gD7koXARt+Tuw4s
         I36gTT2G9ZHSpGs42n9V1DqUhWa0Dc6Av1xCKgaQF3BH69//oYAKCbt6a5tywhyYMWEY
         4WkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691601747; x=1692206547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HGa/E1EozA1ONh5cNmJYBRSriG6HQN403JbmkXULwlo=;
        b=iN+nxmTUfQjBPBHd/hE6wcRoAc2zsMWthDdUiSdoDT6B20Nz8yLne/yC9JbLVuqNmE
         Q9G9+PZQavolllKDQJDD6nQCTkVPRDFYyukxrfUZH6mHzRqnCwRt4Prvr+klDgetKV5s
         S77T8D7G32/IqqX8VlDX7YTMTx9+sqveWZs12PLEdCi28GuEPHVqXIHDehSBnk1h250x
         YwGVe6USdXexj6YF/Or6W0ttd7rHUjEKxsxyUeFVAzx5saBc5kCLIXtWvBlG18lvixBr
         O+Y/V8fIQZ0VEQzCr+oxEaVOrosGN84cUbUy/fPhTqW3ftBvAXtiyWmpKvOC8fPjB/f5
         6qrA==
X-Gm-Message-State: AOJu0YzlekPtBhj00MZPz5wOHv9o5GFAtC1KK/RQLFEobSEs2c/f+tm6
        LZp6/skhfnrmezYoFi56Ul8=
X-Google-Smtp-Source: AGHT+IGVYM4ayxgJYOFMMrI8a+sb9DiES6iTlzPS37y2LsQJG2LZjievm2hKR9+m5X436P5IfivuQQ==
X-Received: by 2002:aca:1c06:0:b0:3a1:e85f:33c3 with SMTP id c6-20020aca1c06000000b003a1e85f33c3mr3190053oic.50.1691601747196;
        Wed, 09 Aug 2023 10:22:27 -0700 (PDT)
Received: from f38.eng.vmware.com ([66.170.99.1])
        by smtp.googlemail.com with ESMTPSA id a1-20020a17090abe0100b00268040bbc6asm1739080pjs.4.2023.08.09.10.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 10:22:26 -0700 (PDT)
From:   Shreenidhi Shedi <yesshedi@gmail.com>
To:     dhowells@redhat.com, dwmw2@infradead.org,
        gregkh@linuxfoundation.org, masahiroy@kernel.org,
        nathan@kernel.org, ndesaulniers@google.com, nicolas@fjasle.eu
Cc:     yesshedi@gmail.com, linux-kernel@vger.kernel.org,
        sshedi@vmware.com, linux-kbuild@vger.kernel.org
Subject: [PATCH v9 7/7] sign-file: fix do while styling issue
Date:   Wed,  9 Aug 2023 22:52:10 +0530
Message-ID: <20230809172211.343677-8-yesshedi@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809172211.343677-1-yesshedi@gmail.com>
References: <20230809172211.343677-1-yesshedi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reported by checkpatch.

Signed-off-by: Shreenidhi Shedi <yesshedi@gmail.com>
---
 scripts/sign-file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/sign-file.c b/scripts/sign-file.c
index e8dfbdd3eea3..0c95275c4564 100644
--- a/scripts/sign-file.c
+++ b/scripts/sign-file.c
@@ -147,7 +147,7 @@ static void drain_openssl_errors(void)
 		if (__cond) {				\
 			errx(1, fmt, ## __VA_ARGS__);	\
 		}					\
-	} while(0)
+	} while (0)
 
 static const char *key_pass;
 
-- 
2.41.0

