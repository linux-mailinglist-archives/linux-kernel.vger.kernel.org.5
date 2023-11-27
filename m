Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5127F9D5C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 11:24:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232925AbjK0KYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 05:24:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232919AbjK0KY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 05:24:28 -0500
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 375E8136
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 02:24:34 -0800 (PST)
Received: by mail-vs1-xe2f.google.com with SMTP id ada2fe7eead31-462c6f436e4so1299133137.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 02:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701080673; x=1701685473; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cdp8QAZn1D8I/rEQSBUvbPEDzykyHAXvOt5qwyXf2M0=;
        b=sCHbsyJBxRCafQdmiXaSwhMVaqbAI4baQbQyjX8X47txRm8s/rZ9Svgf60rvD8bERK
         Kyaeebaao3UoiyMeKKDQNxZ1rlDXGgOqWq60DiJ1VY5BPIuQ7Z42pJVbL9sjHkhh0tLG
         vhsGBMUaGo05YuIK3r7DB04eUKxs6BfDzfh6nOCygt7EPMTUwJi58F1Ml7ahwk+qwVbc
         cB2WmWJU8Ugn3hrXKUmEfGsfhu4PpFDiuOlcnVIGaG3xWqMcBXXZeicHAnaMY/hSWIGw
         O+13y+hNqD6NT/Kv94FzA4MoC8N8miENBsFxGPC6BpeKb5u0raHy8pgI+rFO4Zg/g7t3
         MqYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701080673; x=1701685473;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cdp8QAZn1D8I/rEQSBUvbPEDzykyHAXvOt5qwyXf2M0=;
        b=lqbbGm/EC5mxlrTyqLXPIX8ZB2UXimSD7jM+UtPDrGInpP+pi4xwnVBwz5ZrocLPUH
         fHsFIsYITCFLKWZfxbuAVLKKMBNyhaeLsnyHctvGJNcY8BWB9kv5jiRp0VjuNaCnWHSq
         bRGqqA+spQkTlGCZ+hQ0KBu8VqZXh/bNtVLC/UMszz66Do+L7x7ywMgYyG94OnCdUxfg
         UuDF8HfWejJOnD84zR+ZQ9ybmiSjORupkxzaRZ0vTCn61WbJ/gtEQjlTGBJFvUokEhmu
         7WFx7ExYxxTPFmn9LsgY+ARG/51ANvIcHH4mdAG36EJ0JVt4y3sh1oxAifnJbHFHc8Ez
         Zm+Q==
X-Gm-Message-State: AOJu0YxezNz7yZcrDks6UqnHw0yIZ5WZnRwduy4dHLE6JrIiCQXaYI02
        kPAce/8roaQA9s0YK6EEhLkW3xbmOfrOS8lAv6FUWg==
X-Google-Smtp-Source: AGHT+IGVgRALVFNM2U4HPGezSL7BWKq/nblzK1PIlq8pxjAGxKwRm1tQiB7qPihapLMbC+3QEHZXW4jBJTAFWIsKKEI=
X-Received: by 2002:a05:6102:3e95:b0:45f:4e67:4423 with SMTP id
 m21-20020a0561023e9500b0045f4e674423mr15393245vsv.0.1701080673247; Mon, 27
 Nov 2023 02:24:33 -0800 (PST)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 27 Nov 2023 15:54:22 +0530
Message-ID: <CA+G9fYt0LLXtjSz+Hkf3Fhm-kf0ZQanrhUS+zVZGa3O+Wt2+vg@mail.gmail.com>
Subject: Powerpc: maple_defconfig: kernel/rtas_pci.c:46:5: error: no previous
 prototype for function 'rtas_read_config' [-Werror,-Wmissing-prototypes]
To:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        lkft-triage@lists.linaro.org,
        clang-built-linux <llvm@lists.linux.dev>,
        regressions@lists.linux.dev,
        open list <linux-kernel@vger.kernel.org>
Cc:     Benjamin Gray <bgray@linux.ibm.com>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Dan Carpenter <dan.carpenter@linaro.org>
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

Following Powerpc maple_defconfig and other builds failed with gcc-13 / 8
and clang toolchains on Linux next-20231127 tag.

  build:
    * gcc-8-cell_defconfig
    * gcc-8-maple_defconfig
    * gcc-8-tinyconfig
    * gcc-13-tinyconfig
    * gcc-13-cell_defconfig
    * gcc-13-maple_defconfig
    * clang-17-cell_defconfig
    * clang-17-tinyconfig
    * clang-17-maple_defconfig
    * clang-nightly-cell_defconfig
    * clang-nightly-maple_defconfig
    * clang-nightly-tinyconfig

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build logs:
-----------
arch/powerpc/kernel/rtas_pci.c:46:5: error: no previous prototype for
function 'rtas_read_config' [-Werror,-Wmissing-prototypes]
   46 | int rtas_read_config(struct pci_dn *pdn, int where, int size, u32 *val)
      |     ^
arch/powerpc/kernel/rtas_pci.c:46:1: note: declare 'static' if the
function is not intended to be used outside of this translation unit
   46 | int rtas_read_config(struct pci_dn *pdn, int where, int size, u32 *val)
      | ^
      | static
arch/powerpc/kernel/rtas_pci.c:98:5: error: no previous prototype for
function 'rtas_write_config' [-Werror,-Wmissing-prototypes]
   98 | int rtas_write_config(struct pci_dn *pdn, int where, int size, u32 val)
      |     ^
arch/powerpc/kernel/rtas_pci.c:98:1: note: declare 'static' if the
function is not intended to be used outside of this translation unit
   98 | int rtas_write_config(struct pci_dn *pdn, int where, int size, u32 val)
      | ^
      | static
2 errors generated.
make[5]: *** [scripts/Makefile.build:243:
arch/powerpc/kernel/rtas_pci.o] Error 1

steps to reproduce:

# tuxmake --runtime podman --target-arch powerpc --toolchain clang-17
--kconfig maple_defconfig LLVM=1 LLVM_IAS=0
LD=powerpc64le-linux-gnu-ld



Links:
  - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20231127/testrun/21324129/suite/build/test/clang-17-maple_defconfig/log
  - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20231127/testrun/21324129/suite/build/test/clang-17-maple_defconfig/history/
  - https://storage.tuxsuite.com/public/linaro/lkft/builds/2Yk9XaK95NuGJL9barjaXrOWxib/

--
Linaro LKFT
https://lkft.linaro.org
