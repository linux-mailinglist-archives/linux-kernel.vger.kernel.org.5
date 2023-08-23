Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB33E785757
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 14:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234630AbjHWMDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 08:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232284AbjHWMDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 08:03:48 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFAD6E63
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 05:03:45 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RW4cY3vbjz4wy3;
        Wed, 23 Aug 2023 22:03:41 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Maninder Singh <maninder1.s@samsung.com>,
        Hugh Dickins <hughd@google.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230809131024.2039647-1-arnd@kernel.org>
References: <20230809131024.2039647-1-arnd@kernel.org>
Subject: Re: [PATCH 1/2] powerpc: mark more local variables as volatile
Message-Id: <169279175547.797584.1233962438367558067.b4-ty@ellerman.id.au>
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

On Wed, 09 Aug 2023 15:10:08 +0200, Arnd Bergmann wrote:
> A while ago I created a2305e3de8193 ("powerpc: mark local variables
> around longjmp as volatile") in order to allow building powerpc with
> -Wextra enabled on gcc-11.
> 
> I tried this again with gcc-13 and found two more of the same issues,
> presumably based on slightly different optimization paths being taken
> here:
> 
> [...]

Applied to powerpc/next.

[1/2] powerpc: mark more local variables as volatile
      https://git.kernel.org/powerpc/c/0f7ce21ab5209426b00636636a5f2d9008738654
[2/2] powerpc: xmon: remove unused variables
      https://git.kernel.org/powerpc/c/ef73dcaa31217c79adc548bf9045afb40ac75b82

cheers
