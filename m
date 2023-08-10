Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B85F2776FEE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 08:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233322AbjHJGD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 02:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjHJGDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 02:03:53 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E86E171D
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 23:03:52 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RLxFF14zzz4wqX;
        Thu, 10 Aug 2023 16:03:45 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230727122720.2558065-1-arnd@kernel.org>
References: <20230727122720.2558065-1-arnd@kernel.org>
Subject: Re: [PATCH] powerpc: address missing-prototypes warnings
Message-Id: <169164734546.180689.4715496668121527837.b4-ty@ellerman.id.au>
Date:   Thu, 10 Aug 2023 16:02:25 +1000
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

On Thu, 27 Jul 2023 14:26:50 +0200, Arnd Bergmann wrote:
> There are a few warnings in powerpc64 defconfig builds after -Wmissing-prototypes
> gets promoted from W=1 to the default warning set:
> 
> arch/powerpc/mm/book3s64/pgtable.c:422:6: error: no previous prototype for 'arch_report_meminfo' [-Werror=missing-prototypes]
> arch/powerpc/mm/init_64.c:311:12: error: no previous prototype for '__vmemmap_free' [-Werror=missing-prototypes]
> arch/powerpc/platforms/cell/ras.c:275:5: error: no previous prototype for 'cbe_sysreset_hack' [-Werror=missing-prototypes]
> arch/powerpc/platforms/cell/spu_manage.c:29:21: error: no previous prototype for 'spu_devnode' [-Werror=missing-prototypes]
> arch/powerpc/platforms/pasemi/time.c:12:17: error: no previous prototype for 'pas_get_boot_time' [-Werror=missing-prototypes]
> arch/powerpc/platforms/powermac/feature.c:1532:13: error: no previous prototype for 'g5_phy_disable_cpu1' [-Werror=missing-prototypes]
> arch/powerpc/platforms/86xx/pic.c:28:13: error: no previous prototype for 'mpc86xx_init_irq' [-Werror=missing-prototypes]
> drivers/pci/pci-sysfs.c:936:13: error: no previous prototype for 'pci_adjust_legacy_attr' [-Werror=missing-prototypes]
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc: address missing-prototypes warnings
      https://git.kernel.org/powerpc/c/54f30b83fe627453082f15d83d7820b28b2d24bb

cheers
