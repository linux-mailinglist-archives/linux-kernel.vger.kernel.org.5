Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D51DC7C988F
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 12:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjJOKGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 06:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjJOKGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 06:06:10 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05AAFE1
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 03:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1697364366;
        bh=rSmDJMp3G9hK+xqPuXosnrlvSeh7DhdTVC+45IF9gys=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=bUVDli48G2iyqkwvEk+tsRkNE59kH76RMNLUvO8J6ACPVSEVBTVfDFFs7xkdGAQ24
         4+xayPKOk5G8zCbkWKCFqVU2xIsfDdp0PnVm2YVOuvMOCpNwf4REBn775VrRVFyVbK
         4Zg/fpG9RLn+6u2REOFAoRSmAtwb6i90lV0VX4phIPS8k40mVI20voZv8Ohk13n4Mz
         PLEiRWmrUkrewhm/EyVlf73WqU7DIdUZEI/m8Mg6mF2VAazYi+KcyEfpyin1A+SCwZ
         +64UZGK4KaeE54F+gCmD5grE2oQSFWUfmhIuazOzYT/+Qdvg/gsEYibknCyOQBQEVx
         YpItgMs+Rq7WQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4S7bVQ0nYdz4wnx;
        Sun, 15 Oct 2023 21:06:06 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kernel test robot <lkp@intel.com>
In-Reply-To: <5de2998c57f3983563b27b39228ea9a7229d4110.1695385984.git.christophe.leroy@csgroup.eu>
References: <5de2998c57f3983563b27b39228ea9a7229d4110.1695385984.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc: Only define __parse_fpscr() when required
Message-Id: <169736429855.960528.8288813432399517714.b4-ty@ellerman.id.au>
Date:   Sun, 15 Oct 2023 21:04:58 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Sep 2023 14:33:13 +0200, Christophe Leroy wrote:
> Clang 17 reports:
> 
> arch/powerpc/kernel/traps.c:1167:19: error: unused function '__parse_fpscr' [-Werror,-Wunused-function]
> 
> __parse_fpscr() is called from two sites. First call is guarded
> by #ifdef CONFIG_PPC_FPU_REGS
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc: Only define __parse_fpscr() when required
      https://git.kernel.org/powerpc/c/c7e0d9bb9154c6e6b2ac8746faba27b53393f25e

cheers
