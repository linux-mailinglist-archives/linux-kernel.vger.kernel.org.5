Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34ACC7ACBFB
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 23:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbjIXVF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 17:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjIXVF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 17:05:58 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37428FA
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 14:05:51 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-578a3069f1eso3166170a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 14:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jade-fyi.20230601.gappssmtp.com; s=20230601; t=1695589550; x=1696194350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1GnIZzp6WuCGPnle9pA4KlK6zRfXN3XlScH/Z763Y/k=;
        b=bKVYGmYJV51gR/VlvC9OJ8k3AkaOMPSeSmQps2H6bEjO0IC308dg890c4ncQ8YYrj3
         S6C3orscKRA6DaiG6M0yYOXirJGdEZXSzGx6Zf8nMsxYvtpJMnyPaY7pnhrTJ/Thb9Dn
         Htquj/kl4PMZ+G4rdupJnd6/uno0Rc0CcnVW0FkzeVPOS7fyrDH0yE/pzKdqUR9AfrON
         LwM8f7cNkE+B2KrB5qKryefv+xLRGLlw2HkX/DM/5RzAhFYKkM+rRhVNGhzV3tfc3htl
         lSE4ujm0xR1KMAuk5K4WqkyftXTqNmr1v2hCNq5DiUXcULpi78At6SlntV9E/I0gkQSo
         Chbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695589550; x=1696194350;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1GnIZzp6WuCGPnle9pA4KlK6zRfXN3XlScH/Z763Y/k=;
        b=YFOtLHF8vQQUaZzF5KVV/AFQS52jQ+sSo7HwQIZ4caVv4jI4ZzJfOcaOmtrgZGFvsP
         MKUUoWazazVV/OY7ZGRkkiQSl4OLEQI4ecKidWCqhOhHidN4uphiC3p7ZCdLPzRgg/Xe
         MHEbDzbjtRv9A9D68bxhC6J8ZKFhY37PQ96F3df0tcuJrrO2nvR2u1D+xGDyJJwJ8Cpy
         kjR+MW4KNyVpx1vrv0ZQnj/Ht6PSR1zsBZuY5/XWv7rAza9tf9VT4DO+GXVRC31YcbxV
         p2arhZW9ccG1ihNHTJTEerXLAgX7K3EAPwSH1raP67ZGuD3DVwAqes5ENQgipP3u26lA
         xuOg==
X-Gm-Message-State: AOJu0YzJdiFjRS/5uAAFtmn7aRv5qVhzRAuhP1XR1d2azwY9oHf0l9ar
        KpA0nAc0OSZUq4QsQSs2t7R3hj3cizzS2nCkG7ineuoJ
X-Google-Smtp-Source: AGHT+IGlwNa+HOSFLdxx3g6nRZG8cjmDoOS8ilWZLG/lJdUKHQXogXTFwLbJRcariDQlkFQZsRKTIA==
X-Received: by 2002:a17:90a:bf0a:b0:26f:7555:76 with SMTP id c10-20020a17090abf0a00b0026f75550076mr3002978pjs.11.1695589550600;
        Sun, 24 Sep 2023 14:05:50 -0700 (PDT)
Received: from localhost ([172.103.222.8])
        by smtp.gmail.com with ESMTPSA id bo24-20020a17090b091800b0027476c68cc3sm6686537pjb.22.2023.09.24.14.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Sep 2023 14:05:50 -0700 (PDT)
From:   Jade Lovelace <lists@jade.fyi>
To:     ricky_wu@realtek.com
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, lists@jade.fyi,
        paul.grandperrin@gmail.com, hi@alyssa.is
Subject: RE: [PATCH] misc: rtsx: Fix some platforms can not boot and move the l1ss  judgment to probe
Date:   Sun, 24 Sep 2023 14:05:39 -0700
Message-ID: <20230924210539.2611987-1-lists@jade.fyi>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <37b1afb997f14946a8784c73d1f9a4f5@realtek.com>
References: <37b1afb997f14946a8784c73d1f9a4f5@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have tried this patch out on my machine that was experiencing the=0D
regression and it has been stable for two days. The card reader works=0D
properly and there is nothing funny in dmesg, so I think this=0D
successfully fixes the bug on the Dell XPS 15 9560.=0D
=0D
So:=0D
Tested-By: Jade Lovelace <lists@jade.fyi>=0D
