Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBC9C7F9DDB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 11:43:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233046AbjK0KnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 05:43:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232976AbjK0KnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 05:43:20 -0500
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F00D10F
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 02:43:26 -0800 (PST)
Received: by mail-ua1-x935.google.com with SMTP id a1e0cc1a2514c-7c47142d595so1924408241.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 02:43:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701081805; x=1701686605; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=R6TSIoz+H8JLiNUcGCIq1Csd5pwnS8su62/9RaC91nk=;
        b=QnbNT5w/x/n6y8y6/4c6UoHMeQctlFvR0X5JJKvPmtk0/M6tgmjkymPdzZS4RHyYpv
         1KKaTlRZXRvIfPG4udxvhbE+s762oyLxh7AJhzRNcfinAJ5rq9E+iA5cEBzIUVRXbHl9
         KDVbEEl7cHNRSRP3rR/IBP45UQs40P2hlW1ILeXZGtHU+bLleF2qJ7iNrNwA7txE5klo
         u8eM4AArfzx6TdfHWY7Og4qFzA2Yuqs2gBANOhogudfnjS5hhxewMc28QxAcyArQA0xq
         nEwFFuNrIbv3mb+fSyVyK4yxnFPfYYGxDChg/GlnUfsATzyenSO/0Qr/PeO4Wlg+kys5
         jh5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701081805; x=1701686605;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R6TSIoz+H8JLiNUcGCIq1Csd5pwnS8su62/9RaC91nk=;
        b=xQg1vVCr1NfSeWQDmE4yVTWbRimg66NCCFX8vGZxGImvJf+cCsB1U7LrFHupcypH4O
         CjdANNVGmJAK1loWeB/Xhq52meQmLmQBDFvQ1HB3vMEz16rAvw0jzFOebUsGstfrZWi7
         k3WwW+UVkoWoojXYRglyx3eLKIMY04YG1i7x/kJcuqh1f/R+k7ly9VLx69ifsARWehqN
         62jTF7/mu49xhcQRA2qnkOd4IQqtJecDrc4Bii3bASyu816BtHgHM0VvOyx8LsmoHwj4
         HDvoIzson+NLmw11beP7GGqTlY2+CjINarVHPoUJmHIf8lUaHEqvIghGaF+cyk3nZmvF
         Rh6w==
X-Gm-Message-State: AOJu0Yz8j3VJyi+Uzxxz6WS2WrG7QQsEqoKhcMwg46fHi1VsJRYdaRk/
        6YrYYlJHPZPyhsS20hax5gFh2zInohdBULe7yRXO9eExQbqOPU39cN0=
X-Google-Smtp-Source: AGHT+IGMKNRQ2wePxRC4PpDnj4YoN1p1HWwhKXLnzyZPaFNOeCXmqVoolj5+388JcmcpA13+Hkz5NYjQyYeR/zR/n8Y=
X-Received: by 2002:a67:cd16:0:b0:462:f13a:286a with SMTP id
 u22-20020a67cd16000000b00462f13a286amr2897810vsl.4.1701081805658; Mon, 27 Nov
 2023 02:43:25 -0800 (PST)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 27 Nov 2023 16:13:14 +0530
Message-ID: <CA+G9fYs6WafDBtSbcLpoyWehQyBPNeX37PvsP6HzSotXr3dYLg@mail.gmail.com>
Subject: lsm_list_modules_test.c:104:22: error: 'LSM_ID_IMA' undeclared (first
 use in this function); did you mean 'LSM_ID_YAMA'?
To:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org, regressions@lists.linux.dev
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        Paul Moore <paul@paul-moore.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>,
        Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following build errors noticed while building selftests lsm tests for x86
with gcc-13 toolchain on Linux next-20231127 tag.

Build log:
------
selftest/lsm/lsm_list_modules_test
lsm_list_modules_test.c: In function 'correct_lsm_list_modules':
lsm_list_modules_test.c:104:22: error: 'LSM_ID_IMA' undeclared (first
use in this function); did you mean 'LSM_ID_YAMA'?
  104 |                 case LSM_ID_IMA:
      |                      ^~~~~~~~~~
      |                      LSM_ID_YAMA
lsm_list_modules_test.c:104:22: note: each undeclared identifier is
reported only once for each function it appears in

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Steps to reproduce:
-----

tuxmake --runtime podman --target-arch x86_64 --toolchain gcc-13  \
 --kconfig https://storage.tuxsuite.com/public/linaro/lkft/builds/2Yk9XptRIQra77bvzZHcgyzkH7w/config
\
       debugkernel cpupower headers kernel kselftest modules

Links:
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20231127/testrun/21324802/suite/build/test/gcc-13-lkftconfig-kselftest/log
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20231127/testrun/21327065/suite/build/test/gcc-13-lkftconfig-kselftest/history/
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20231127/testrun/21324802/suite/build/test/gcc-13-lkftconfig-kselftest/details/


--
Linaro LKFT
https://lkft.linaro.org
