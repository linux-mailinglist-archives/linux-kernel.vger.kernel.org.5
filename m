Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D05D782AED
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 15:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235552AbjHUNwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 09:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235585AbjHUNwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 09:52:10 -0400
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48CDD10E
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 06:52:04 -0700 (PDT)
Received: by mail-ua1-x92c.google.com with SMTP id a1e0cc1a2514c-79a10807b4fso1036250241.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 06:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692625923; x=1693230723;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7DMvDXB2k6+AbrdhdkHJ/XB86AMGB7xb0Ezbn7WAlNw=;
        b=SeArUD9jqncDCi5AobrC4EKlTl4unjyBWOuzgGjuNG1EdNFY/4x47bGTtYx6Q8xaZb
         t8tWtoC3mu8/oe6/+k4+qkTocYzwH3h14SWXxr+w1OhvB7MR7etgzmDAr8pg7hQex1hj
         SF2SaGm7MwoRIONvu5CcC2e4tE2cwFHms1ISnaWvSVOTwW+qtWXjT3ceVk/ecTNpUGdw
         xfzM3KPyTQAeC3soCVxLJcQPqEKQCLieQ1OqrApxzHZSxZZ9sDtAhuo7Wq3M5kg+faCb
         Mc+Wo4rKWndmbModFMk/xAyY0UGM/KGcyHR/C6mo30l+B4ASd4OOj/Z8cVRXdqH0FkJT
         jVhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692625923; x=1693230723;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7DMvDXB2k6+AbrdhdkHJ/XB86AMGB7xb0Ezbn7WAlNw=;
        b=dQXmD8ZugRQZGI+kNMrxKguOE7UNfjEX7rYO2HsE2bA8oJzi4XUOTxrwuqfaIUTZ9T
         gayg3P3gN+TY2LGW5TDzTrkkd5iLSd3A8aArpo25hiEZpd07iZhJMYTRAqG9gT7/Sf6D
         6LKItyGb/NFKuXrUqb2ZA6rhY8kc267we0tn+G52rpt3rzO4X0vGSrxs+vc394stiXVB
         DIOzVSOBXq4T18feJM50/B8vWqkDJhFUARkIIVBpes1+mjbHdMXX/DgI18IkRZtfSdLo
         2b/xNhLbueZewxCbaadoVca/8pAzsjgz3qOJEFkF42eP7YThG/C4W+sRXToV6TDj05G4
         N6vQ==
X-Gm-Message-State: AOJu0YwcFLDfkaKtG8725SRrobNbmDhc9FM12FQJqpmdNOvz1AxeEofq
        o3GW7pVfSzr8UvOQGtIE6vpC3G7v1bf8HjowvAX7uQ==
X-Google-Smtp-Source: AGHT+IHJYha+6wVZ4QRVAf0iayKUmBS8wsPnI5ar076fcn0KaGGb/MngAUY0k7zm+LVQSeRE8E9HnAsK0eBQu0c6UUM=
X-Received: by 2002:a05:6102:282b:b0:447:5ed3:cb21 with SMTP id
 ba11-20020a056102282b00b004475ed3cb21mr4746191vsb.28.1692625923288; Mon, 21
 Aug 2023 06:52:03 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 21 Aug 2023 19:21:52 +0530
Message-ID: <CA+G9fYtdRe5x=mS4Xonb+ZZsArO2o7vuNL+qJsv5DkNvcirQbA@mail.gmail.com>
Subject: clang-17: selftests: sgx: clang: error: -z noexecstack: 'linker'
 input unused [-Werror,-Wunused-command-line-argument]
To:     clang-built-linux <llvm@lists.linux.dev>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, lkft-triage@lists.linaro.org
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently we have updated the toolchain clang-17 version.

While building selftests sgx following warnings / errors noticed on the
Linux next with clang-17.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

sgx/main.o
clang: error: -z noexecstack: 'linker' input unused
[-Werror,-Wunused-command-line-argument]

Links:
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2UHhSg0TPLhjp9Uq9EFceoQd0VL/

Steps to reproduce:
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2UHhSg0TPLhjp9Uq9EFceoQd0VL/tuxmake_reproducer.sh

tuxmake --runtime podman --target-arch x86_64 --toolchain clang-17
--kconfig https://storage.tuxsuite.com/public/linaro/lkft/builds/2UHhSg0TPLhjp9Uq9EFceoQd0VL/config
LLVM=1 LLVM_IAS=1 debugkernel cpupower headers kernel kselftest
modules


--
Linaro LKFT
https://lkft.linaro.org
