Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77053785759
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 14:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234648AbjHWMDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 08:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234512AbjHWMDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 08:03:49 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16AB8E66
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 05:03:46 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RW4cc4jj5z4wy9;
        Wed, 23 Aug 2023 22:03:44 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <e89d9927c926044e54fd056a849785f526c6414f.1692282340.git.christophe.leroy@csgroup.eu>
References: <e89d9927c926044e54fd056a849785f526c6414f.1692282340.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/47x: Add prototype for mmu_init_secondary()
Message-Id: <169279175576.797584.4374265621871502219.b4-ty@ellerman.id.au>
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

On Thu, 17 Aug 2023 16:25:49 +0200, Christophe Leroy wrote:
> A W=1 build of 44x/iss476-smp_defconfig gives:
> 
> arch/powerpc/mm/nohash/44x.c:220:13: error: no previous prototype for 'mmu_init_secondary' [-Werror=missing-prototypes]
>   220 | void __init mmu_init_secondary(int cpu)
>       |             ^~~~~~~~~~~~~~~~~~
> 
> That function is called from head_4xx.S
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/47x: Add prototype for mmu_init_secondary()
      https://git.kernel.org/powerpc/c/b27c1a0a4e62af1fd9d2688bf8156a5d546e4227

cheers
