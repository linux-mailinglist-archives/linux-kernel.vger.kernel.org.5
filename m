Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAAEB78A12E
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 21:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbjH0TeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 15:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbjH0Tdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 15:33:43 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF48C6
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 12:33:41 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 46e09a7af769-6bcb5df95c5so1987604a34.1
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 12:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693164820; x=1693769620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/20+iwj0/ojxdHziUbJdhTIbwFYLS/pRXm/vh5r0p/M=;
        b=n7gDIZcHScRkiLo3acl/wrvq5YfwwrGwTqxZoKkB2Uy3HMqT5EdyV9+tkFDXiyL7Jd
         Xb3dARxo8dEgLMuZhXh0C9KhIGwwreQm0s6dfnx71yZChDFd6gUekr9sa4DnQ7cR+tdF
         YmKBsN+pCwG8stSsUJkJQY4g3Aidp3FyuLFZUqix1dE81emRFVynlyadP2P/85BM/dlS
         aJULY4Yyd6/61cScYiVsNoMlQLjnxWmlmpjhbJw+NuSSl4DzweaoJka8xlgVNSrhr2mh
         Epy0koj4mBuU3nU5NPq2j721jMpk6G29lxvoV5E0DDtr1oQOFGLBk2QiUmaWJ7x3Sqkm
         PbIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693164820; x=1693769620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/20+iwj0/ojxdHziUbJdhTIbwFYLS/pRXm/vh5r0p/M=;
        b=Wh8ECopBxp8b6OS43ZSAm7u0A3Oe0gvoU6VUsUuluab16a4nadGM/BLJIuk7Y05qSP
         tDqDsvT7477STp3A0wh7rSidxGsf6ggL2dWmLcLEPMd4Fc7Fuw0i4qvSyjnLAIsSdM/T
         6I8WWpr1xTeauFCzmPQEbEDHirKQc4vN6UJkT4K8rhJ7FIEjyWVQpvOYR/dW/19Gpy06
         /r0p9yJuVUBPox2+xfZA5A6RlYeY/UiclU0Og1EC3aF+dJ/SGSZcpfRLOsEARLReBpQl
         VZ6/z1/IXfCleSxTPYur2sryuEx3CK5E47qmiepPZnQyZRK+I5aGJPdxJNFYQcTms0ZD
         vaqA==
X-Gm-Message-State: AOJu0YwFxszxWcgfk5W50juJjr6ueeIfsSdlqL7zytzn9Ysb0ukFs1We
        sa3mG8qR39pTFj9yCmRdIUE=
X-Google-Smtp-Source: AGHT+IEiVP+3qqTfR+XZhNVQz1/UXBZ50Tq6C9y/m451idHcVF1aaktlVYg5CAQZ8FkiodDkCjMARA==
X-Received: by 2002:a05:6830:114e:b0:6b9:182b:cccc with SMTP id x14-20020a056830114e00b006b9182bccccmr11305146otq.33.1693164820405;
        Sun, 27 Aug 2023 12:33:40 -0700 (PDT)
Received: from alolivei-thinkpadt480s.gru.csb ([2804:14c:bf20:82ea:8c7c:b784:3f92:988a])
        by smtp.gmail.com with ESMTPSA id l8-20020a9d7348000000b006b96384ba1csm1640272otk.77.2023.08.27.12.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 12:33:40 -0700 (PDT)
From:   Alexon Oliveira <alexondunkan@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     martyn@welchs.me.uk, manohar.vanga@gmail.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Alexon Oliveira <alexondunkan@gmail.com>
Subject: [PATCH v4 2/4] staging: vme_user: fix check lines not ending with '(' in vme_fake.c
Date:   Sun, 27 Aug 2023 16:32:52 -0300
Message-ID: <9f3e2facdc4d5e612dc00830c2da0fb19c20f2c5.1693164540.git.alexondunkan@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1693164540.git.alexondunkan@gmail.com>
References: <cover.1693164540.git.alexondunkan@gmail.com>
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

Fixed all CHECK: Lines should not end with a '('
as reported by checkpatch to adhere to the Linux kernel
coding-style guidelines.

Signed-off-by: Alexon Oliveira <alexondunkan@gmail.com>
---

Changes in v2:
- Fixed summary phrase with tags to indicate commit order
in the patch series, noted by Greg KH

Changes in v3:
- Sent patch series in a single email thread, noted by Nam Cao

Changes in v4:
- Versioning the patch series with the forgotten information
about the changes in the previous versions, noted by Greg KH

 drivers/staging/vme_user/vme_fake.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/vme_user/vme_fake.c b/drivers/staging/vme_user/vme_fake.c
index a88d2c8a785b..dbaf050f88e5 100644
--- a/drivers/staging/vme_user/vme_fake.c
+++ b/drivers/staging/vme_user/vme_fake.c
@@ -403,8 +403,7 @@ static void fake_lm_check(struct fake_driver *bridge, unsigned long long addr,
 				if (((lm_base + (8 * i)) <= addr) &&
 				    ((lm_base + (8 * i) + 8) > addr)) {
 					if (bridge->lm_callback[i])
-						bridge->lm_callback[i](
-							bridge->lm_data[i]);
+						bridge->lm_callback[i](bridge->lm_data[i]);
 				}
 			}
 		}
-- 
2.41.0

