Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9015180A078
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 11:18:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573465AbjLHKSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 05:18:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbjLHKSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 05:18:00 -0500
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A9231732
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 02:18:05 -0800 (PST)
Received: by mail-oo1-xc36.google.com with SMTP id 006d021491bc7-58d956c8c38so937580eaf.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 02:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702030685; x=1702635485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0NmoRHTCNAA7+499JkbNaILAA7b/35IKN2Lx1hQIG3s=;
        b=KXF2AQ59Fi0jagfOvLpUPu0PYkMjscrkMZjs4ncAEagK0RHma78+Vz0G1IZNcbp0qb
         IfBwGDzsFXSbIfOW1xrvp3RP5yBmtFoMYtWRyn8JpB3JPClVRUA5KIDBhX96qtTzebv5
         P+DOTZR0KKR6gr4n/Vfc6OFU8X2V1An4zb3BO4N7TM9VDdcOf0Zv2e73j7mSgY/uIkud
         ZEkla8lLU3ULVTBsN+KWiYYEqwYEFTPoP0nTUL5nFvQ2p4onv0z8KAP2J8HIrNUKZjTe
         UZa2XHE4l5OcnWan2gNkvgicvTwyoDbMpMPdFnFwQACl3ACMreQ5qU/3tCsZpTR+5DQw
         NErw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702030685; x=1702635485;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0NmoRHTCNAA7+499JkbNaILAA7b/35IKN2Lx1hQIG3s=;
        b=ITwB/qeB7H2xI75NVbO1M8TSg1ASd21tntrJjI/df/YF6gtizmziLbdCryzvgLQDth
         29dINqLocdVqxaJl4hmAPoghLBd23d4YgjMF+jULz+iSoG712u/JGMf4GuxivD0BZHhD
         wUunbMlwW2oZBETTsARtniM7DoYXhRRvmsp7dkJ86Rf85zrrMgHOsOwHBR9DCi4VQFzz
         eOW1BjyERU662Pq8mIbbvqmBWl2945CUz164vr6tfcPfZsj4DhWUXvusYVyjt0zEaKYv
         uuwI041/uBT7V4VGKgP1B2BfGhKNUm52jDHrzV6QUySVlxVA2hX4Pz39zsB1+Y3/U1lb
         99lA==
X-Gm-Message-State: AOJu0Yzut+34sF1C1JjkduCXFC8+SvUj02OsuAKTMhMtW4nyogG5TA99
        BJpgUjXT74Jq+PkPns4W9O0xbg==
X-Google-Smtp-Source: AGHT+IGUPMOIa7veeC+WP5/Up7/5mLKPL7gPv1ouzH7ay63AtOjYttMQ4IMHhSTQWYYKskYm9a5FFw==
X-Received: by 2002:a05:6358:2496:b0:170:17ea:f4e8 with SMTP id m22-20020a056358249600b0017017eaf4e8mr3233758rwc.53.1702030684708;
        Fri, 08 Dec 2023 02:18:04 -0800 (PST)
Received: from localhost ([122.172.82.6])
        by smtp.gmail.com with ESMTPSA id k21-20020aa788d5000000b006ce79876f9csm1228840pff.82.2023.12.08.02.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 02:18:04 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        rust-for-linux@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] docs: rust: Clarify that 'rustup override' applies to build directory
Date:   Fri,  8 Dec 2023 15:48:01 +0530
Message-Id: <bf0d4ff21bc25d1ba3a31e49a32bde06dcaf6e44.1702030679.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rustup override is required to be set for the build directory and not
necessarily the kernel source tree (unless the build directory is its
subdir).

Clarify the same in quick-start guide.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 Documentation/rust/quick-start.rst | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/rust/quick-start.rst b/Documentation/rust/quick-start.rst
index f382914f4191..a7a08955fe46 100644
--- a/Documentation/rust/quick-start.rst
+++ b/Documentation/rust/quick-start.rst
@@ -39,8 +39,13 @@ If ``rustup`` is being used, enter the checked out source code directory
 	rustup override set $(scripts/min-tool-version.sh rustc)
 
 This will configure your working directory to use the correct version of
-``rustc`` without affecting your default toolchain. If you are not using
-``rustup``, fetch a standalone installer from:
+``rustc`` without affecting your default toolchain.
+
+Note that the override applies to the build directory (and its sub-directories).
+If the kernel is built with `O=<build directory>`, the override must be set for
+the build directory instead.
+
+If you are not using ``rustup``, fetch a standalone installer from:
 
 	https://forge.rust-lang.org/infra/other-installation-methods.html#standalone
 
-- 
2.31.1.272.g89b43f80a514

