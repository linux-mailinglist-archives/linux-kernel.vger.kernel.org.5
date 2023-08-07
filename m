Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF8857720A2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 13:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbjHGLQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 07:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbjHGLQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 07:16:19 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7469A35B1;
        Mon,  7 Aug 2023 04:15:00 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6877eb31261so3085420b3a.1;
        Mon, 07 Aug 2023 04:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691406811; x=1692011611;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HGa/E1EozA1ONh5cNmJYBRSriG6HQN403JbmkXULwlo=;
        b=W5NONcAa53RYBrRsow+PWQqRgcGYe+SPRzGizcFTxMGTDCbJxO9kTJLoWYLv/h2PrQ
         XtdZF1EbSWyzTBiKD7OSWg1tvoW0G5z1VDNIGXylWvZ4PcB81M1XifZ0xBRBXI3vyXAj
         OFsejLaYVpqM71t/DvrAAey0cC3eVvpO6Vqub/oTvfOvKiZKlENSau5Zly0QGepwo6DX
         kM1d4cXVWe7L47hBcj8xo2jKowaxwEe/caU9gWCKv4URQbi9L2bPDtkS8unCsS8n1NRn
         0OyhcR6uwQ1V9y365+xRIj1nAVPbYBc5zlYJuJ/in5uU95LaCnXcUhHtkVrhoAhvyZvc
         kLDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691406811; x=1692011611;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HGa/E1EozA1ONh5cNmJYBRSriG6HQN403JbmkXULwlo=;
        b=IdqR38UNJKNtgn0UF+o2EIxfE2D7wvb2Hip34y/B8e7RIQdHawll0tPIL6YrxzGaMz
         oBx+oFloU7UOcYrQalKZOFsIqLfIyCRkk19ROpbC1s82gji4EpYZj9YsysugstxPQeRL
         5YcpYNFzHoGd1fp2UOvfGM+5IjpelaA/HpsyfJRi8wu2xA/hzMbBvY6zzMJDyrtWYA+G
         iN9ygrLuDUJdTZPd96xquyfy2ePx6KkRmqG5d7cZ4nUvVYYBDPkgzP5h7BDDtRTSxC0s
         /rIlN2Dr7kQkvXN9OGJ2mABQtxsNGP01G5RpVvSGpUOMg8QWTle/+j5zG9P4trI35jt9
         UsOA==
X-Gm-Message-State: AOJu0YwSNRK6jT0+CEHm20xVHhLW6JNUIFc9Ck1OFgCMQ5oDrCiUCLfj
        PGto+gJy+aS2bpy0ZWZWEc4=
X-Google-Smtp-Source: AGHT+IGOKi9NZosuGYSGmWIhoAOLuLv9OD9JdBKrKUaVtumn/F8c5tQTBVWMf6D5fdvs4ksf1a/6kA==
X-Received: by 2002:a05:6a00:1816:b0:672:264c:e8cf with SMTP id y22-20020a056a00181600b00672264ce8cfmr11441118pfa.7.1691406811440;
        Mon, 07 Aug 2023 04:13:31 -0700 (PDT)
Received: from f38.eng.vmware.com ([66.170.99.1])
        by smtp.googlemail.com with ESMTPSA id 4-20020aa79144000000b00660d80087a8sm5939173pfi.187.2023.08.07.04.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 04:13:31 -0700 (PDT)
From:   Shreenidhi Shedi <yesshedi@gmail.com>
To:     dhowells@redhat.com, dwmw2@infradead.org,
        gregkh@linuxfoundation.org, masahiroy@kernel.org,
        nathan@kernel.org, ndesaulniers@google.com, nicolas@fjasle.eu
Cc:     yesshedi@gmail.com, linux-kernel@vger.kernel.org,
        sshedi@vmware.com, linux-kbuild@vger.kernel.org
Subject: [PATCH v8 7/8] sign-file: fix do while styling issue
Date:   Mon,  7 Aug 2023 16:43:15 +0530
Message-ID: <20230807111316.315836-8-yesshedi@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230807111316.315836-1-yesshedi@gmail.com>
References: <20230807111316.315836-1-yesshedi@gmail.com>
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

