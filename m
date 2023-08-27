Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD9B789D43
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 13:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbjH0LeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 07:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjH0Ldp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 07:33:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16860130
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 04:33:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A68436131F
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 11:33:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4260C433C8;
        Sun, 27 Aug 2023 11:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693136022;
        bh=dn+6Ju7C1qSnnp4Ka6O4z8Z2HJccKQcgqygWMKBW1Eo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f/0ddGtyG7ooqoZlO8Bzd5esdF/lIhLdB04VnSQ5/bLQHEtPvB4IFwIiPnmncVtkS
         JyggTk0o0FpbRNblVCr28OGp3bOqCERqTlTym1ly75A9rYbmr1d0J7DlowM2M3aeOg
         0pJmIXr4N8NPBIjXeMHBnee5kPG0avFbZbuzCFAaZrg7ASh05RWdW4kLUX2P6nMnfO
         FwBZYmhqj/WzmxAvjQ10L86FnuWV3+jJIYyIrI6xPH4PyaZCVHhQihbGOk7Sx4XBl1
         JdGRgILuZ4BgBygQ+1reBdQMrUnO81J8CjOzA1Vh4+B2q6Q3bdWES9QrGbeYt6ko28
         tK0gL0QKpWMFA==
Date:   Sun, 27 Aug 2023 19:21:50 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] riscv: errata: improve T-Head CMO
Message-ID: <ZOsxzuABhEnAZXHE@xhacker>
References: <20230827090813.1353-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230827090813.1353-1-jszhang@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 27, 2023 at 05:08:11PM +0800, Jisheng Zhang wrote:
> This is a renew of Icenowy patch series[1], patch1 is necessary to
> make T-Head C910 powered SoCs CMO work correctly. patch2 is to name
> those instructions following thead-extension-spec.

Original series:
https://lore.kernel.org/linux-riscv/20230103062610.69704-1-uwu@icenowy.me/

> 
> Icenowy Zheng (2):
>   riscv: errata: fix T-Head dcache.cva encoding
>   riscv: errata: prefix T-Head mnemonics with th.
> 
>  arch/riscv/include/asm/errata_list.h | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> -- 
> 2.40.1
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
