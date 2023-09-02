Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEE3379053F
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 07:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351547AbjIBFZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 01:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351541AbjIBFZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 01:25:23 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA01C180;
        Fri,  1 Sep 2023 22:25:19 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6bca3311b4fso2195604a34.0;
        Fri, 01 Sep 2023 22:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693632318; x=1694237118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KFoQ1P3RZsvjJDmcT2AlLGhdYrSSPHfWfcPWm8WWHjY=;
        b=gDNFPF3XRdnQ9avn1ZD9djp1JqXkQPTqtGnFrVx4O/ED+oPVLmNmyRM9Bq95/r6MpR
         r30uFhcXkaztwGgZo8pP3xiAxt+nWVNwRrQU6NAa0PyrHfTeIPL/2rmt8mSTfu1u38rY
         wDuN+WM831srxZDWpZ46ZWwPCkRPOsVwSAOFis3+98z9fxiAgnacbcE2OlOI7ppmCavc
         SFYewUzpSaPHvzWiLAOe6uvbX5ZdbqsRRMcCGdGyFC9Vu26wWfQ3hh0bFjphulKMuNrD
         yV6KoTLLysXqziyzjZP3ebN2ixlGL9LV/nRqvE4h9ontlaKmHxwsisjH6tSQi55M2bmk
         s26w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693632318; x=1694237118;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KFoQ1P3RZsvjJDmcT2AlLGhdYrSSPHfWfcPWm8WWHjY=;
        b=D4NLoj/6gagQiu4Wv5IFqN17rruDy8hzcbFV8XCp1En5S5ZAsiUYN7yBz3dB3KX8Me
         wZu6HuDiM4TBhtgl4EJa8o7v1nprGG38difqqoVAKwy7xdyJ5wdUl60H5RbhHUiwc9cY
         YoCYJSrF3oRzBvijSI7/V/qK6x6ZCNVY0KgXJuNvjwleW+eVf3vqQZT3rLvhe+unJng2
         iycRPxXcpC7e/lBb70jLgMd7BvZqbW9zf04W3eYRdVRITgd3ij88/KfiE0KTK9n3dmRw
         TsebTDAdCTEM06ghX8pfO7l69Rh/G+ycjWD9i9Nb4RihohoVpzi1tpF4YeC7kmMgwk9D
         lO/A==
X-Gm-Message-State: AOJu0Yzfzo5Bys4sycWWYXoEv5jkYxGDneUol2Ge0NDnYXjXJXjpOMrr
        gaYbG3v9lYkeIhkdCFXADAc=
X-Google-Smtp-Source: AGHT+IH4ibxeTyahNsmUPqIhANnp40SDRqfd2ny/Xu+BNV8kxI6K2s1sX0MKWZaDMxQjf7GJQpUb5w==
X-Received: by 2002:a9d:7f83:0:b0:6bd:701:6928 with SMTP id t3-20020a9d7f83000000b006bd07016928mr4811445otp.3.1693632318465;
        Fri, 01 Sep 2023 22:25:18 -0700 (PDT)
Received: from ubuntu777.domain.name (36-228-78-250.dynamic-ip.hinet.net. [36.228.78.250])
        by smtp.gmail.com with ESMTPSA id b15-20020a63714f000000b0056c24c2e23dsm3708320pgn.25.2023.09.01.22.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 22:25:17 -0700 (PDT)
From:   Min-Hua Chen <minhuadotchen@gmail.com>
To:     Hu Haowen <src.res@email.cn>, Jonathan Corbet <corbet@lwn.net>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        linux-doc-tw-discuss@lists.sourceforge.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Min-Hua Chen <minhuadotchen@gmail.com>
Subject: [PATCH v3 0/3] convert TW translation sparse.txt to RST
Date:   Sat,  2 Sep 2023 13:25:09 +0800
Message-Id: <20230902052512.12184-1-minhuadotchen@gmail.com>
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

---

Change since v1:
1. change subject to convert sparse.txt to RST
2. add Suggested-by tag to credit Randy

Change since v2:
rebase to next-20230831

-- 
2.34.1

