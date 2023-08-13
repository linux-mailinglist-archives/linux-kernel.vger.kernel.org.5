Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6F977AA09
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 18:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbjHMQ35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 12:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232491AbjHMQ3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 12:29:41 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0654911A;
        Sun, 13 Aug 2023 09:29:26 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-686bc261111so2366048b3a.3;
        Sun, 13 Aug 2023 09:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691944164; x=1692548964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9DmxFHXC1C0iktfuyQUeeT9djuPKgjaBZaXtzx74Xe4=;
        b=qUXx1zVeSKareDZRDsA20sAS/DQ21LzIW/axOPFTTRcZlwdyTiQyiKry+l+MP3dP00
         j3+P+V58I6alBeVs/2/hMOhYCiq+opMZjsVy8cX6FUhA7SCmgTe9rjDlAUr0Mx5qvU09
         0GniQHesASR4F+0o8PhieS7/pe689zfBc8CpkA8MCQEowv0XuMzUEcqaV65XbZZ0pluE
         PrDper8Ps3LBVwNIi/WwG94xXH67AjoC0jo18XCKlpBtn3dpwYqoBUJGrdUjHx8/D8T2
         PEFLVrBJ1yf6uelC/Hu48FEgpwnzAN6649+2cCQqKM4Y6GPwff7FobmQGHpwjvFfiyNW
         gSqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691944164; x=1692548964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9DmxFHXC1C0iktfuyQUeeT9djuPKgjaBZaXtzx74Xe4=;
        b=HpO1d2df2Y38VlRzIKS8fEa24mb5rIO2mmWtDrtGk7H+VYY3hYvfL/rJib3xw+EISH
         LMo6nUSS3z3zhsXE2dsaKfmzGYhdtWI0zFDUMwSeTaNKNb6ubXPd0z6nh16zdiWQbVR0
         gMMTTP4MJBxQeNYaxOITHI88sE8rWsFN+nHB1nfo8HSkasS6jlZtShw8rqbMYFTXkVtv
         4m+B+68RBKibMl/FAe40cWJGjqeRmmYWyuOqqj0EvQMw+aWciIIBFEUgqT9yn2g/uq8Z
         2D9lmntEXRamYXIwcS5Qh0n2CVwphzQBJQZDu9K17XOmlKZbuBHRnYiWi8K7lm6b2xrT
         xgYw==
X-Gm-Message-State: AOJu0Ywv/hXaJqW73oTH3J+FqltiJmcUOCUFQuywkkt3d0xLOmLd9p7g
        Lzso3rxHe8YenP+M8RxTieQ=
X-Google-Smtp-Source: AGHT+IEkEThiGbWUmPE/QUJSnzywB50+wB30T0R7c4K98bIeBBOd+G1v/t0tqskgfifKOyj8xHvCAg==
X-Received: by 2002:a05:6a00:16cb:b0:682:f529:6d69 with SMTP id l11-20020a056a0016cb00b00682f5296d69mr8345743pfc.7.1691944163938;
        Sun, 13 Aug 2023 09:29:23 -0700 (PDT)
Received: from ubuntu777.domain.name (36-228-78-6.dynamic-ip.hinet.net. [36.228.78.6])
        by smtp.gmail.com with ESMTPSA id e30-20020a63371e000000b0056595ead4c9sm2629952pga.33.2023.08.13.09.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Aug 2023 09:29:23 -0700 (PDT)
From:   Min-Hua Chen <minhuadotchen@gmail.com>
To:     Hu Haowen <src.res@email.cn>, Jonathan Corbet <corbet@lwn.net>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        linux-doc-tw-discuss@lists.sourceforge.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Min-Hua Chen <minhuadotchen@gmail.com>
Subject: [PATCH v2 1/3] docs: sparse: move TW sparse.txt to TW dev-tools
Date:   Mon, 14 Aug 2023 00:29:13 +0800
Message-Id: <20230813162915.39577-2-minhuadotchen@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230813162915.39577-1-minhuadotchen@gmail.com>
References: <20230813162915.39577-1-minhuadotchen@gmail.com>
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

Follow Randy's advice [1] to move
Documentation/translations/zh_TW/sparse.txt
to
Documentation/translations/zh_TW/dev-tools/sparse.txt

[1] https://lore.kernel.org/lkml/bfab7c5b-e4d3-d8d9-afab-f43c0cdf26cf@infradead.org/

Cc: Randy Dunlap <rdunlap@infradead.org>
Suggested-by: Randy Dunlap <rdunlap@infradead.org>
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Min-Hua Chen <minhuadotchen@gmail.com>
---
 Documentation/translations/zh_TW/{ => dev-tools}/sparse.txt | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename Documentation/translations/zh_TW/{ => dev-tools}/sparse.txt (100%)

diff --git a/Documentation/translations/zh_TW/sparse.txt b/Documentation/translations/zh_TW/dev-tools/sparse.txt
similarity index 100%
rename from Documentation/translations/zh_TW/sparse.txt
rename to Documentation/translations/zh_TW/dev-tools/sparse.txt
-- 
2.34.1

