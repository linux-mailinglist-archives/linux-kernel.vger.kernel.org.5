Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD4DD785764
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 14:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234600AbjHWMEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 08:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234660AbjHWMDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 08:03:55 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A341E72
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 05:03:53 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RW4cl5wZcz4x2D;
        Wed, 23 Aug 2023 22:03:51 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kernel test robot <lkp@intel.com>
In-Reply-To: <3d72efd39f986ee939d068af69fdce28bd600766.1691568093.git.christophe.leroy@csgroup.eu>
References: <3d72efd39f986ee939d068af69fdce28bd600766.1691568093.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/radix: Move some functions into #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
Message-Id: <169279175547.797584.10395628134457071142.b4-ty@ellerman.id.au>
Date:   Wed, 23 Aug 2023 21:55:55 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 09 Aug 2023 10:01:43 +0200, Christophe Leroy wrote:
> With skiboot_defconfig, Clang reports:
> 
>   CC      arch/powerpc/mm/book3s64/radix_tlb.o
> arch/powerpc/mm/book3s64/radix_tlb.c:419:20: error: unused function '_tlbie_pid_lpid' [-Werror,-Wunused-function]
> static inline void _tlbie_pid_lpid(unsigned long pid, unsigned long lpid,
>                    ^
> arch/powerpc/mm/book3s64/radix_tlb.c:663:20: error: unused function '_tlbie_va_range_lpid' [-Werror,-Wunused-function]
> static inline void _tlbie_va_range_lpid(unsigned long start, unsigned long end,
>                    ^
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/radix: Move some functions into #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
      https://git.kernel.org/powerpc/c/4a9dd8f292efd614f0a18452e6474fe19ae17b47

cheers
