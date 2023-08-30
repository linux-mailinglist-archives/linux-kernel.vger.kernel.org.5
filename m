Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2D4078E1B5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 23:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243554AbjH3V4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 17:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243541AbjH3V4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 17:56:43 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A91895;
        Wed, 30 Aug 2023 14:56:19 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id e9e14a558f8ab-34bae82b2ffso821355ab.1;
        Wed, 30 Aug 2023 14:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693432517; x=1694037317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EZEwMbaCVyaLIfxuj5Unnl9VhZcfo9P9ZpGHH411u8s=;
        b=TlqVbt9ijicRB1BZRO2riCcy3mdQaumVww2MX0SH9/1ZfrL4yh1FgNJxOZeYCjZ/Lb
         hUmP0LkRAUV+WkTBcNrwDN+KuFQzhKjP1m696vvCqr/WJVIZKT6FMmlhlGYr5UhitcBM
         q6L8+GePVKKhAjpFFamPK4fmFTbxlP0TTwLmaaBaftoE/mZrc/BEkwJUu4iIhyezZ1vZ
         Fvw5UjfZ27ClzujyqP2oFakSXyMciIxBsgd2F/KhhNTYkGytPCMddmGqaBZpJPpp608w
         hxw0qwaJZBuA9yQk/eg08a6CVI25WgyyTwdOzFQjaTibf+T7dfW6SLKa8KwfTlKaq/Ld
         ehSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693432517; x=1694037317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EZEwMbaCVyaLIfxuj5Unnl9VhZcfo9P9ZpGHH411u8s=;
        b=HF+pR88CQqEs95e9UlGhQ3ay09WzOwgw+IknmLHBGanjJDmaKtacFU9sdIM3UVXo3j
         fZRWWA0WgVjuq8SlTLDshg1s/72H9+u/U1YUrea19NRPMf8Sd5IiKIXcwcv2WvXcnXDQ
         9ZZY/sv1HugwuQEPMpg/CGcL0OsgQEYGXTRMlWIbdx4zS/69/YNXC4w8jeCyzrjIng1N
         Q7EAYDGcj3E9Cwm0RMhOU1SPNQwoCU9uaXeVbOYh/zz/OU7+MUdCUG7cu1U+yHMCiA8Y
         jRPWsxyb6xRxg+0SNxR5QHkMT+bEVzMAe1phjNxobkR7vk6a/BPLCCwc1AwhLGA0Uo+/
         xDLw==
X-Gm-Message-State: AOJu0YwIj8JDL/fOpgcjGsVeAUnlJqNMVn4u71RlMSqnhc+liA1TUiJJ
        /pA3ADTlqfoQb8PBGru4PU4=
X-Google-Smtp-Source: AGHT+IEuh4ZymI9ePYmxpZ+Ps4CAcxYRzl8D4tGfNtuA8+ZCoskmH6nx/RuzghiJJQSuWfb+mrfE+w==
X-Received: by 2002:a05:6e02:df2:b0:34d:f32c:1d8f with SMTP id m18-20020a056e020df200b0034df32c1d8fmr3693713ilj.17.1693432516637;
        Wed, 30 Aug 2023 14:55:16 -0700 (PDT)
Received: from azeems-kspp.c.googlers.com.com (161.74.123.34.bc.googleusercontent.com. [34.123.74.161])
        by smtp.gmail.com with ESMTPSA id v8-20020a92c6c8000000b0034ab6f53e23sm50527ilm.28.2023.08.30.14.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 14:55:16 -0700 (PDT)
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
To:     Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>
Cc:     linux-hardening@vger.kernel.org,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        ocfs2-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 2/2] ocfs2: Replace strlcpy with strscpy
Date:   Wed, 30 Aug 2023 21:54:26 +0000
Message-ID: <20230830215426.4181755-3-azeemshaikh38@gmail.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
In-Reply-To: <20230830215426.4181755-1-azeemshaikh38@gmail.com>
References: <20230830215426.4181755-1-azeemshaikh38@gmail.com>
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

strlcpy() reads the entire source buffer first.
This read may exceed the destination size limit.
This is both inefficient and can lead to linear read
overflows if a source string is not NUL-terminated [1].
In an effort to remove strlcpy() completely [2], replace
strlcpy() here with strscpy().

Direct replacement is assumed to be safe here since
it's ok for `kernel_param_ops.get()` to return -errno [3].
This changes the behavior such that instead of silently ignoring the
case when sizeof(@buffer) < DLMFS_CAPABILITIES, we now return error.

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
[2] https://github.com/KSPP/linux/issues/89
[3] https://elixir.bootlin.com/linux/v6.5/source/include/linux/moduleparam.h#L52

Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
---
 fs/ocfs2/dlmfs/dlmfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ocfs2/dlmfs/dlmfs.c b/fs/ocfs2/dlmfs/dlmfs.c
index 33e529de93b2..b001eccdd2f3 100644
--- a/fs/ocfs2/dlmfs/dlmfs.c
+++ b/fs/ocfs2/dlmfs/dlmfs.c
@@ -80,7 +80,7 @@ static int param_set_dlmfs_capabilities(const char *val,
 static int param_get_dlmfs_capabilities(char *buffer,
 					const struct kernel_param *kp)
 {
-	return strlcpy(buffer, DLMFS_CAPABILITIES,
+	return strscpy(buffer, DLMFS_CAPABILITIES,
 		       strlen(DLMFS_CAPABILITIES) + 1);
 }
 static const struct kernel_param_ops dlmfs_capabilities_ops = {
--
2.42.0.283.g2d96d420d3-goog

