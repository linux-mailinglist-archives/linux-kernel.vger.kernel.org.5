Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8CCE80886E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 13:51:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232578AbjLGMoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 07:44:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232648AbjLGMof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 07:44:35 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BACE10DD
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 04:44:40 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SmDVt5l8Cz4xS0;
        Thu,  7 Dec 2023 23:44:38 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Nathan Lynch <nathanl@linux.ibm.com>
Cc:     lkft-triage@lists.linaro.org, Benjamin Gray <bgray@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        clang-built-linux <llvm@lists.linux.dev>,
        regressions@lists.linux.dev,
        Linux Kernel Functional Testing <lkft@linaro.org>
In-Reply-To: <20231127-rtas-pci-rw-config-v1-1-385d29ace3df@linux.ibm.com>
References: <20231127-rtas-pci-rw-config-v1-1-385d29ace3df@linux.ibm.com>
Subject: Re: [PATCH] powerpc/rtas_pci: rename and properly expose config access APIs
Message-Id: <170195271166.2310221.13174919656650959020.b4-ty@ellerman.id.au>
Date:   Thu, 07 Dec 2023 23:38:31 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Nov 2023 18:40:09 -0600, Nathan Lynch wrote:
> The rtas_read_config() and rtas_write_config() functions in
> kernel/rtas_pci.c have external linkage and two users in arch/powerpc:
> the rtas_pci code itself and the pseries platform's "enhanced error
> handling" (EEH) support code.
> 
> The prototypes for these functions in asm/ppc-pci.h have until now
> been guarded by CONFIG_EEH since the only external caller is the
> pseries EEH code. However, this presumably has always generated
> warnings when built with !CONFIG_EEH and -Wmissing-prototypes:
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/rtas_pci: rename and properly expose config access APIs
      https://git.kernel.org/powerpc/c/9be4feb768b86c25da336a6c0f3e3caefd16f1e4

cheers
