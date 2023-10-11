Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B39E7C612B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 01:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233885AbjJKXiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 19:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233753AbjJKXiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 19:38:05 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FEF4A9;
        Wed, 11 Oct 2023 16:38:04 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1c735473d1aso3188135ad.1;
        Wed, 11 Oct 2023 16:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697067483; x=1697672283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kKa3yKUit9S94fXMwLxixDACHXme3FUWNxOHBFdZ+K8=;
        b=GNzU5W71UneAUgWBz8Pagi+zsuYHxUBzFILzG1G2jUpfJWTPULzIqtMKRb8lfRUijE
         ulMYgVZebLXEt8S78phFFJGPceaYgNAc0+6RUkilqRmnXWTecYUQU5useTbXlblHIJdF
         0Uvt9oGGAzdo560Cqx7yiifgqxiOqXTZiTnXpb8Xb87WJgcP1E8nth5HDQN0SZhAE2uz
         4YIkzGFeZyiCgd+H4OmHJY3uJu1XB0n2amFskQytWWv2octZrJBCzBkTdhqAP9N63Hqf
         YoCfkJew4+f+8NT3/ks3PbeFu13FZ+51yxj4y54X6qNdnQW8P3MoA63WQtp8zSou0xt3
         zyIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697067483; x=1697672283;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kKa3yKUit9S94fXMwLxixDACHXme3FUWNxOHBFdZ+K8=;
        b=bQv11aO4DJYWFFD13mnU3qiye7FrCfv3+vjrrjMeE8axyXsfpXTuIFt6XyZVRfBl9S
         ZhREvX00Faizjrng9a/yVzzSFhl81G714ZTnrH7+k85Zo7otLuSMpjAcn/UaSexh9v8r
         jRMBcnP7HOpkzhvPBIFa03MFHQdVC3RlENiqmc/Jx11qwvO54QQg4r4+rfSpuURXdu9i
         OYGLVeeX4jt3IHoJTwvZgN3rRSiBX51dksfu4z6S3g3qsPb/Zm2tKA0jhQ/luf0ANzdC
         xTD6jGNF+9fph084RF8ukZr+NUUuIL5dpzN7LA02Jo4s0s1UiDLXqKSVPC/xpwI6KvTY
         OGDQ==
X-Gm-Message-State: AOJu0YwBvEe+9SwFIU4qEl1LXZebdSKtxwCNPUNXhh7rP33rpu59DCoy
        z1poJu967jeeYeK7dz3o4pXO9Cwkh/4=
X-Google-Smtp-Source: AGHT+IFWXzzcYXNDuhCkexqViffDoQajYYi0r0bX7i0HqAWbwYzrgtCys+MCre3yALxBv5OZEWmG/g==
X-Received: by 2002:a17:902:cec7:b0:1c9:9144:574b with SMTP id d7-20020a170902cec700b001c99144574bmr10203365plg.49.1697067482926;
        Wed, 11 Oct 2023 16:38:02 -0700 (PDT)
Received: from ubuntu777.domain.name (36-228-100-211.dynamic-ip.hinet.net. [36.228.100.211])
        by smtp.gmail.com with ESMTPSA id u14-20020a170902e5ce00b001bd28b9c3ddsm408902plf.299.2023.10.11.16.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 16:38:02 -0700 (PDT)
From:   Min-Hua Chen <minhuadotchen@gmail.com>
To:     Hu Haowen <src.res.211@gmail.com>, Jonathan Corbet <corbet@lwn.net>
Cc:     Min-Hua Chen <minhuadotchen@gmail.com>,
        kernel test robot <lkp@intel.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] docs: sparse: add SPDX-License-Identifier
Date:   Thu, 12 Oct 2023 07:37:56 +0800
Message-Id: <20231011233757.181652-1-minhuadotchen@gmail.com>
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

Add SPDX-License-Identifier to fix the checkpatch warning:

WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
\#26: FILE: Documentation/translations/zh_TW/dev-tools/index.rst:1:
+.. include:: ../disclaimer-zh_TW.rst

Signed-off-by: Min-Hua Chen <minhuadotchen@gmail.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202310110859.tumJoXFl-lkp@intel.com/
---
 Documentation/translations/zh_TW/dev-tools/index.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/translations/zh_TW/dev-tools/index.rst b/Documentation/translations/zh_TW/dev-tools/index.rst
index 8f101db5a07f..e2e18a72ef94 100644
--- a/Documentation/translations/zh_TW/dev-tools/index.rst
+++ b/Documentation/translations/zh_TW/dev-tools/index.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 .. include:: ../disclaimer-zh_TW.rst
 
 :Original: Documentation/dev-tools/index.rst
-- 
2.34.1

