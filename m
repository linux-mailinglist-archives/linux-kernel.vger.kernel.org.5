Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92B5977F408
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 12:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349939AbjHQKDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 06:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349888AbjHQKDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 06:03:32 -0400
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DECC8173F
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 03:03:30 -0700 (PDT)
Received: by mail-vk1-xa36.google.com with SMTP id 71dfb90a1353d-48b829cbf8dso367843e0c.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 03:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692266610; x=1692871410;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=t7L7oor9hguIJsZ7+KIFg8XeyxoxXJrD2hQ498S73ew=;
        b=vvo1oFDdZVLJAK601uPA0V/ZZtKkHmNyd3aL5YDqjJT+d2or3PHF9bN0c/9qdUB9Hs
         +xudL0/J09I/kida9xeOwalJnKJkNHubq6i0KGVv9lhnliio34la2nMnCiox3e6yL7gm
         9og/kZAwqhixfYyyKEGbRKttVzw8hjGmhYjnBJGS5sDxk8T/nmAz0mymk1Bi/RlGxA5k
         koCghU1xWXRCg8Bt8Q/GHSe6Iwc+yYiPc2HFzRW6IX2uVkTjn+9k+c10hDnzPFwJi2HQ
         4kNXaGRDS5p2Xw5M5bc33kKr7s7FWjpym6eZJUAWOp0kPl/JuYJ/ChS8B2KXxLnW1c04
         chRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692266610; x=1692871410;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t7L7oor9hguIJsZ7+KIFg8XeyxoxXJrD2hQ498S73ew=;
        b=FqIGcdWaslEnLb8g9K9h2yr4xDY06ETnI/2x6lu+pYOJB47AudEk8NmDi8jctMgJiW
         JjE81RaEeDmJVahEKziOT8EOO4vJm0c7rCQSLnzKQmgI699fUHwq34tVY6r4PFT6XeRm
         EKS1uhFqh/mXj2/2hQfpLEvmDb950q3IyHToq/UMguIY931wvQvbPLHtMWBa5IE0YAx0
         ckOpi809c/iyR3uXaPOfejQMO9p2BGj/Ii6VAB+5TXybPt1fgIsAUAx3TWYZi4fjpyQX
         D/TwjA4okCVzhdKf4LGmGvpR73ve8CUTBBYRfTOGkZNBI7AXH2awx86RbEq8Hrqw0+iP
         6nMA==
X-Gm-Message-State: AOJu0Ywj8wwmLRne+mdmazueTsXCYdKE/STnfPwrEhYFn8pBEz9sr4wz
        iAo8TObEjQvxjLx/cvEK4ebvHOdZAYauGs36EIx9UA==
X-Google-Smtp-Source: AGHT+IEtSFu+V1HQS5CtIwMAfU0t+xp9kwVpngqBujbOD7GxgE8fH/zRCeMsU/kV9nlZ3xlX6otyeGckyUcjfPom9LE=
X-Received: by 2002:a1f:41c3:0:b0:489:aaa4:ca26 with SMTP id
 o186-20020a1f41c3000000b00489aaa4ca26mr4754235vka.13.1692266609977; Thu, 17
 Aug 2023 03:03:29 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 17 Aug 2023 15:33:18 +0530
Message-ID: <CA+G9fYvVZmOJvf=+JM8LRGxV6ynCPuPreipCP3+fmti=M+dxwA@mail.gmail.com>
Subject: selftests: arm64: hwcap.c:51:15: error: instruction requires: crc
To:     clang-built-linux <llvm@lists.linux.dev>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org
Cc:     Kristina Martsenko <kristina.martsenko@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While building selftests arm64 following warnings / errors noticed on the
Linux next-20230817 tag ( from next-20230815 )

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build errors:
------------
selftests/arm64/abi/hwcap
hwcap.c:51:15: error: instruction requires: crc
   51 |         asm volatile("crc32w w0, w0, w1");
      |                      ^
<inline asm>:1:2: note: instantiated into assembly here
    1 |         crc32w w0, w0, w1
      |         ^
1 error generated.
make[5]: *** [../../lib.mk:181: selftests/arm64/abi/hwcap] Error 1

Links:
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2U69ue7AaypfY7eRU4UUygecrDx/

Steps to reproduce:
tuxmake --runtime podman --target-arch arm64 --toolchain clang-17
--kconfig https://storage.tuxsuite.com/public/linaro/lkft/builds/2U69ue7AaypfY7eRU4UUygecrDx/config
LLVM=1 LLVM_IAS=1 dtbs dtbs-legacy headers kernel kselftest modules

--
Linaro LKFT
https://lkft.linaro.org
