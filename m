Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A982877AA0A
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 18:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232440AbjHMQaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 12:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232509AbjHMQ3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 12:29:44 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 707C8AB;
        Sun, 13 Aug 2023 09:29:30 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-686ed1d2594so3616220b3a.2;
        Sun, 13 Aug 2023 09:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691944166; x=1692548966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H3fh5w4FwWZTDTm/uhWhJzy4jRPbHsATKbpeq93KCug=;
        b=f6CsLVYZ8tjFIUANO9vu8bmE6VcpkraBEO7d9lNdR+aQaZoKzmUK6/1i6rXnXNgxNQ
         LjIMAJMKCRNx+SBQ7T7c3GKaNLwO45ThB0BStFeLOey2KmyfU86tP43Mil0g3piZE5Nd
         mlCaeTn8aroXjI1PRiMucJp3T4negMQ6BGo22g6PaMEvsnxfEHOB7XoT8ODj9WEab7Cs
         xNVQgtAZoM4VdrHo9hajhlH0/oL+Ty39psBRU98QhMVrgTjOTFms4xqPqTuUfaDmghYt
         vkViBOA1iwzaHeKtqnxlZf/xPcWjQDvYff7xHu0WWg5NhYlUYgcZwszU0n5b9WkLd7ce
         WKPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691944166; x=1692548966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H3fh5w4FwWZTDTm/uhWhJzy4jRPbHsATKbpeq93KCug=;
        b=Yivj4iWV/N1atpH1w1+0+N5FlQplSj2IE/ZruB3zxkdj5bCzBIyUeotNIt9G22ShAN
         YhbBOsZAzPODmHUvZxYWgQxGXPHnyVoKbZsSesWoPm7zkLSfC4LKUDZET+NBNPEaNzpM
         GpdV8oVqEW9wvkksldYbhzaDtCkx1+Cfszr99+Rnd7JYwuo+1YwefAQlE40m6c4PeH0q
         0ynwfXfL2NYNChM2O6ccOuxBp64Ja2dwoTuMzGnPbpB0yOMuECFhKgLsDd9n+JPZ9YyS
         w1PYAkQwlj9TfWD4lLmruypcm0xvJ3aQlcjsp/roX6ppSfNi4UV77Oa2jD3seqAbnzdK
         CbOA==
X-Gm-Message-State: AOJu0YxiohWSg9CI7DPp4iUIzpmnRyhhUWWbrVAkPIXeN0d44fwY2jPZ
        1NZdG9LfQxglaKK5BA8FhAE=
X-Google-Smtp-Source: AGHT+IFxaBlh11CAWNlHaS1u4LvmYMw8By1PBBY8lR29AZQqmUg7BO6m2Lkgbf7lU6PEtMpCS54ruw==
X-Received: by 2002:a17:903:32c8:b0:1bc:2abb:4e98 with SMTP id i8-20020a17090332c800b001bc2abb4e98mr9397371plr.21.1691944166562;
        Sun, 13 Aug 2023 09:29:26 -0700 (PDT)
Received: from ubuntu777.domain.name (36-228-78-6.dynamic-ip.hinet.net. [36.228.78.6])
        by smtp.gmail.com with ESMTPSA id e30-20020a63371e000000b0056595ead4c9sm2629952pga.33.2023.08.13.09.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Aug 2023 09:29:26 -0700 (PDT)
From:   Min-Hua Chen <minhuadotchen@gmail.com>
To:     Hu Haowen <src.res@email.cn>, Jonathan Corbet <corbet@lwn.net>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        linux-doc-tw-discuss@lists.sourceforge.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Min-Hua Chen <minhuadotchen@gmail.com>
Subject: [PATCH v2 2/3] docs: sparse: convert sparse.txt to RST
Date:   Mon, 14 Aug 2023 00:29:14 +0800
Message-Id: <20230813162915.39577-3-minhuadotchen@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230813162915.39577-1-minhuadotchen@gmail.com>
References: <20230813162915.39577-1-minhuadotchen@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Documentation/translations/zh_TW/dev-tools/sparse.txt
to
Documentation/translations/zh_TW/dev-tools/sparse.rst

[1] https://lore.kernel.org/lkml/bfab7c5b-e4d3-d8d9-afab-f43c0cdf26cf@infradead.org/

Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Suggested-by: Jonathan Corbet <corbet@lwn.net>
Suggested-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Min-Hua Chen <minhuadotchen@gmail.com>

---

change since v1:
1. change subject to convert sparse.txt to RST
2. add Suggested-by tag to credit Randy
---
 .../translations/zh_TW/dev-tools/{sparse.txt => sparse.rst}     | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename Documentation/translations/zh_TW/dev-tools/{sparse.txt => sparse.rst} (99%)

diff --git a/Documentation/translations/zh_TW/dev-tools/sparse.txt b/Documentation/translations/zh_TW/dev-tools/sparse.rst
similarity index 99%
rename from Documentation/translations/zh_TW/dev-tools/sparse.txt
rename to Documentation/translations/zh_TW/dev-tools/sparse.rst
index 6d2d088b1060..553a3ce82d2e 100644
--- a/Documentation/translations/zh_TW/dev-tools/sparse.txt
+++ b/Documentation/translations/zh_TW/dev-tools/sparse.rst
@@ -27,7 +27,7 @@ Copyright 2006 Bob Copeland <me@bobcopeland.com>
 使用 sparse 工具做類型檢查
 ~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-"__bitwise" 是一種類型屬性，所以你應該這樣使用它：
+"__bitwise" 是一種類型屬性，所以你應該這樣使用它::
 
         typedef int __bitwise pm_request_t;
 
-- 
2.34.1

