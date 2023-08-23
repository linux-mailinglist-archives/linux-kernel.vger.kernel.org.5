Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F188D78576A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 14:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234750AbjHWMEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 08:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234675AbjHWMED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 08:04:03 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1927EE67
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 05:03:57 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RW4cq5LxTz4x2X;
        Wed, 23 Aug 2023 22:03:55 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <0a667b7c2e05d3cf41ecd38f33cc334083a61c8d.1692282396.git.christophe.leroy@csgroup.eu>
References: <0a667b7c2e05d3cf41ecd38f33cc334083a61c8d.1692282396.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v2] powerpc/47x: Remove early_init_mmu_47x() to fix no previous prototype
Message-Id: <169279175576.797584.1515002714869080486.b4-ty@ellerman.id.au>
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

On Thu, 17 Aug 2023 16:26:44 +0200, Christophe Leroy wrote:
> 4xx/iss476-smp_defconfig leads to:
> 
>   CC      arch/powerpc/mm/nohash/tlb.o
> arch/powerpc/mm/nohash/tlb.c:322:13: error: no previous prototype for 'early_init_mmu_47x' [-Werror=missing-prototypes]
>   322 | void __init early_init_mmu_47x(void)
>       |             ^~~~~~~~~~~~~~~~~~
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/47x: Remove early_init_mmu_47x() to fix no previous prototype
      https://git.kernel.org/powerpc/c/ed05c71a574235aec3418d2b5c94f24ae84cc2db

cheers
