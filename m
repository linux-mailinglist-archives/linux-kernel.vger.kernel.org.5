Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 043D277AA07
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 18:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232206AbjHMQ3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 12:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232435AbjHMQ3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 12:29:39 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD5FC3;
        Sun, 13 Aug 2023 09:29:24 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-686f94328a4so2393682b3a.0;
        Sun, 13 Aug 2023 09:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691944161; x=1692548961;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i3hodKyLnJUxeYnuTARHEQzgALmwI1AdwKnKHwRJx/I=;
        b=fUSl9J2vDlUujN4fx8dqBQ+fiAjRUUcL3zEDnXw9SQqjCD55qnbg2Y6yKpsnQWKw6t
         06e+Yi8aEhugmkv39JOzeQZryGGptbh8jdakRc5181J/bQX5wj/SXmxozBozQgZ3Wn9G
         2WIVDs6OdiAXyvfaDqRS6RXj+Q9vkv3On0WZBryBIEXnfu9c+E11TYdlX6YwW/DRMcQe
         ZmWV+SL4NaU/u9B21SdJfOcOuxs4Zaz7/0BdPX2TtXzM396qspxuOaA1oTovEZ3kZ8Oq
         tdGFzMuZbMEbLN54nFq5K+z4eXoEHJJ8zjWi5YxKjG8MDqNCQxMAgig6AuPU6Mg8Z/4+
         V5tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691944161; x=1692548961;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i3hodKyLnJUxeYnuTARHEQzgALmwI1AdwKnKHwRJx/I=;
        b=iMtcw2KyfpYlR8LbCloBFI6LxTcb8aQ/odMCtQDP3qTZagxvw70MjS+ySFPBOSXEOW
         ZymHIB4XXq6Ts0u8FUd+hpawKYL0TkoqXVfgJ38Bt709wZGM+9E8jtLI7ZbhsAkCIOFm
         qYV97rGLZkU0Iq4YTyrIosLV44pco7Gj23P8BKCby0POFEwIbTvT9aHPnX/KTsVQtOGA
         GWVBoOrAdUaqfXjBS0NHuCy8wBn3hblUw8y0xj5hW/3tLl4EtSoO14NNRy4oNXRsX+ge
         JM6HUaSr9AZzurL83e/KXt+mr1ul8Y2iUm2vR3lHGzJthz5DmTgO0gvdgpTBFEkZSJ3G
         meOg==
X-Gm-Message-State: AOJu0YyFhXPquJFxwSEwDfCwhSp3Ctk5uydifacVqhbx50so42Fnt7sm
        ts+8dsj6hBU62AYueXTJaK0=
X-Google-Smtp-Source: AGHT+IEuc9NEzyP/j3YUNIO+Qbc7KjP6EQaKb1mhxUTfiuJOcluGajXHfZZE5rtHt55Y59qp5k8fCg==
X-Received: by 2002:a05:6a00:2283:b0:687:570c:da2d with SMTP id f3-20020a056a00228300b00687570cda2dmr9722359pfe.12.1691944161260;
        Sun, 13 Aug 2023 09:29:21 -0700 (PDT)
Received: from ubuntu777.domain.name (36-228-78-6.dynamic-ip.hinet.net. [36.228.78.6])
        by smtp.gmail.com with ESMTPSA id e30-20020a63371e000000b0056595ead4c9sm2629952pga.33.2023.08.13.09.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Aug 2023 09:29:20 -0700 (PDT)
From:   Min-Hua Chen <minhuadotchen@gmail.com>
To:     Hu Haowen <src.res@email.cn>, Jonathan Corbet <corbet@lwn.net>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        linux-doc-tw-discuss@lists.sourceforge.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Min-Hua Chen <minhuadotchen@gmail.com>
Subject: [PATCH v2 0/3] convert TW translation sparse.txt to RST
Date:   Mon, 14 Aug 2023 00:29:12 +0800
Message-Id: <20230813162915.39577-1-minhuadotchen@gmail.com>
X-Mailer: git-send-email 2.34.1
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

These patches move TW sparse.txt to TW dev-tools and
convert TW sparse.txt to RST, based on [1].
Add the RST to toctree [2].

Randy said [1]:
"
it would be good if someone would update/modify this
sparse.txt file to be in Documentation/translation/zh_TW/dev-tools/
and convert it to sparse.rst (IMO).
"

[1] https://lore.kernel.org/lkml/bfab7c5b-e4d3-d8d9-afab-f43c0cdf26cf@infradead.org/
[2] https://lore.kernel.org/lkml/87a5uxxqf3.fsf@meer.lwn.net/



Min-Hua Chen (3):
  docs: sparse: move TW sparse.txt to TW dev-tools
  docs: sparse: convert sparse.txt to RST
  docs: sparse: add sparse.rst to toctree

 .../translations/zh_TW/dev-tools/index.rst    | 40 +++++++++++++++++++
 .../{sparse.txt => dev-tools/sparse.rst}      |  2 +-
 Documentation/translations/zh_TW/index.rst    |  2 +-
 3 files changed, 42 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/translations/zh_TW/dev-tools/index.rst
 rename Documentation/translations/zh_TW/{sparse.txt => dev-tools/sparse.rst} (99%)

-- 
2.34.1

