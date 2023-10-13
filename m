Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0A6C7C7D17
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 07:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjJMFjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 01:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjJMFja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 01:39:30 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D8B6B7;
        Thu, 12 Oct 2023 22:39:27 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-4064876e8b8so20061675e9.0;
        Thu, 12 Oct 2023 22:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697175566; x=1697780366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rhiR8ucYsoNpcwMY4pa9jdkIqcioe4I+QXtN4eqyp3A=;
        b=FQCA/PcQ2GyIi9yR6s7DCOcU91BFSHmXoRVnTtGZrsCydq9Af9BR1nK9jMqRgttll1
         OW1jKuipxF8RZCk5dra14/gsvq3DSN8lGmEiUTbCNPhBHo6J7Vn+6jbR4IvgsvElFJj1
         /C4fjEGCCUVJafOUweRDo2J7n6HRv5zZMYdRJb8twVfMCqcpiemreVTklPLW9nmixriH
         aphSEYKNX/i/YR979Pavx+UQPOtRT6exe5coOI1Zn/mZoBiTPHlCZmotC8LAQjAqinrx
         bpJDQVhb132SR0Yr+0o6vluCmvTs6Aywk3+rD1pWIJU9d9u1WjDEkr59mxxWZYpPBKVQ
         IPFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697175566; x=1697780366;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rhiR8ucYsoNpcwMY4pa9jdkIqcioe4I+QXtN4eqyp3A=;
        b=vwr8FULl24Xkn8Y6C55BMAAz/CMEKw+mMsPvSoG13vV/rxLJozXpDnsiFWpXyZ0KP4
         iZCOcj3lwFPVeuHPetD0Mcl01Kq3iX8z/ZgzIbgXKOyytfZfSrdjoJz0mmiNoTirH+re
         /2xHjFJYJJPa/LpvaPSfLeDwK+2yjGQDmwiiXvTKai2hYhE4mag83cBP3+A3f4/SzHRK
         p2qbBWXH/9MdJuxkelwTm0wsdGOgBRvXgcaaFQGgdOzXFdejYtCEINzt8xGFsYL5zQLD
         5tBpfagQcOF3Vw90PerNccFp+5Hbz52DZ0TjAcw4RKQwPGEESOck3NZt8AfE0YhSix4P
         DZYQ==
X-Gm-Message-State: AOJu0YxPW4q2LvG9ovKoGfGOufZ0cptKc4frnEJKn4Zfy9c/wSqhgJ1E
        PuD8LWyKQaDEt3N9QoEGOrA=
X-Google-Smtp-Source: AGHT+IGDAmYHJOkaLyRGFo/Kg7znzL6lE/DOYjgFNI3em9D51zNaiFaLRegV51zNgbIqptwTmLvq+w==
X-Received: by 2002:a05:600c:259:b0:403:b64:ad0a with SMTP id 25-20020a05600c025900b004030b64ad0amr21411651wmj.26.1697175565528;
        Thu, 12 Oct 2023 22:39:25 -0700 (PDT)
Received: from dreambig.dreambig.corp ([58.27.187.115])
        by smtp.gmail.com with ESMTPSA id r3-20020a05600c298300b0040641ce36a8sm258650wmd.1.2023.10.12.22.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 22:39:25 -0700 (PDT)
From:   Muhammad Muzammil <m.muzzammilashraf@gmail.com>
To:     davem@davemloft.net
Cc:     sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Muhammad Muzammil <m.muzzammilashraf@gmail.com>
Subject: [PATCH] arch: sparc: vdso: vdso2c.c: Fixed 'instead' typo
Date:   Fri, 13 Oct 2023 10:39:20 +0500
Message-Id: <20231013053920.11606-1-m.muzzammilashraf@gmail.com>
X-Mailer: git-send-email 2.25.1
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

Fixed 'instead' typo

Signed-off-by: Muhammad Muzammil <m.muzzammilashraf@gmail.com>
---
 arch/sparc/vdso/vdso2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/vdso/vdso2c.c b/arch/sparc/vdso/vdso2c.c
index dc81240aab6f..1ae1e5e0e206 100644
--- a/arch/sparc/vdso/vdso2c.c
+++ b/arch/sparc/vdso/vdso2c.c
@@ -192,7 +192,7 @@ int main(int argc, char **argv)
 
 	/*
 	 * Figure out the struct name.  If we're writing to a .so file,
-	 * generate raw output insted.
+	 * generate raw output instead.
 	 */
 	name = strdup(argv[3]);
 	namelen = strlen(name);
-- 
2.27.0

