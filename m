Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52C8278DAB5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237829AbjH3Sg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244593AbjH3NYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 09:24:51 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04653137
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 06:24:49 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-68a402c1fcdso3871290b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 06:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1693401888; x=1694006688; darn=vger.kernel.org;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ook+FTkyICrUjBd7fQtOEeWleupa/6WExjctivOBh1U=;
        b=2RP8mU8NdBaLiOObsoh3v+iPsHK2HY64d13hNc67WskPUqd80rDzSCYEkeuqWjw7Zy
         hbNkugKXgOf+6qtFHWmnZpsWFYbmX6LfKDsiR3Ks/HEw2iEI2QrwlsG0S1tfV4XZBD16
         dAIAUIvF/aHpQng8cVbRdR1Ew70Rjm8OS79tUduDXIK6BTizYsZyqJQ9nSYA9ELg70vL
         /CWxgL/zZKGSNPSn8Trm642BHeXMbKJ4nFsO0SQD4I833xDMnjw838UgpiOoS622WHug
         afli5K93KaRW30lmC93iAmAqdV/fjswFfgBVAYE690vWhgLpa23oDVHHbDpq8sNE//LS
         DGTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693401888; x=1694006688;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ook+FTkyICrUjBd7fQtOEeWleupa/6WExjctivOBh1U=;
        b=WrmkGG7g2ZHneuyeqsRwiS1kiakEQZiBI1/zp7Ay/SCS1lMHi7C6G+KRWwlpC/gMRi
         z0V6TjZct2Q5Yi6WheqirogrcgJx77ApTAY2oxCDm6Hp5YJepRTG+JKbmVz7pMP1maSf
         vpiogfjq2Nz5PnI0TRvH7tx2NDsEBnYNosiitF7pOCx3BJlYEZFPg3X0v9wgQICOSOjZ
         ddzPnTfFbG1HR1dO3WiqRuftxjuB/KehQ7UmLHoMpQcJTvjMqU1B62fixyxLS496M/W9
         gZbVIZeva+QI5YyOdXw/OUr+S3l5f6OHXwHYScoKI3ZerBjZR2G74mMKtIMT7aJ9N6pI
         rZiw==
X-Gm-Message-State: AOJu0YxH0+FZNs3RxF14guMWcDSTDwoj1p8UXf/+cl4XPx/jzEr5jF4y
        Nlaxip2t0scFhgfVopLpbGfLy01EPSmNkurwJCo=
X-Google-Smtp-Source: AGHT+IFxZTjAILqNa3f3RrZLF9BvSy4qVQtIlHlGVAYql2Bunt7iMjjyBJzDwiPBLi6U8zBDpWImyQ==
X-Received: by 2002:a05:6a21:7781:b0:131:f3a:4020 with SMTP id bd1-20020a056a21778100b001310f3a4020mr2505730pzc.33.1693401888044;
        Wed, 30 Aug 2023 06:24:48 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id n26-20020aa7905a000000b00687375d9135sm10082581pfo.4.2023.08.30.06.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 06:24:47 -0700 (PDT)
In-Reply-To: <20230727160356.3874-1-jszhang@kernel.org>
References: <20230727160356.3874-1-jszhang@kernel.org>
Subject: Re: [PATCH] riscv: enable DEBUG_FORCE_FUNCTION_ALIGN_64B
Message-Id: <169340187985.2480.18103495945853549626.b4-ty@rivosinc.com>
Date:   Wed, 30 Aug 2023 06:24:39 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-901c5
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jisheng Zhang <jszhang@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 28 Jul 2023 00:03:56 +0800, Jisheng Zhang wrote:
> Allow to force all function address 64B aligned as it is possible for
> other architectures. This may be useful when verify if performance
> bump is caused by function alignment changes.
> 
> Before commit 1bf18da62106 ("lib/Kconfig.debug: add ARCH dependency
> for FUNCTION_ALIGN option"), riscv supports enabling the
> DEBUG_FORCE_FUNCTION_ALIGN_64B option, but after that commit, each
> arch needs to claim the support explicitly. I tried the config file in
> [1] for both RV64 and RV32, I can't reproduce the build error as [1],
> there is no reason for not allowing to enforce this function alignment.
> 
> [...]

Applied, thanks!

[1/1] riscv: enable DEBUG_FORCE_FUNCTION_ALIGN_64B
      https://git.kernel.org/palmer/c/74f438e75483

Best regards,
-- 
Palmer Dabbelt <palmer@rivosinc.com>

