Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60D087C9889
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 12:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjJOKDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 06:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjJOKD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 06:03:29 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6981DF
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 03:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1697364200;
        bh=Q/bzuX+XRukXINWRk6WjTJ0Dsx+nhlcsHcO34kFVNyE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=neT1iSdEvJEcD8Pn72Ik6GoscWZUJeCY38+sefDfpP/cZ/H9negXKQfnF+Xdp/jrL
         XzLx3TVEfz6NA4T16Ur8c5kFIPjVBJMT4BGYBdZ+Z3cud75R4KoVY0d3WV5ZZfW7wT
         J3YtJqEkOGoncq3HX3EfKUCrRmjHyOBGsgyJ+/Fi5ETCR07+WTSkeg6ANyBwonK9yN
         vRWsxK2S5N9gA0qXYntot79FAtWjCvgzxej+HkNanHkeoGqio0YETIIFqn2h5gBjJk
         41K7/mZQhAkYeW1JKRgNj4Z83/mYwegZkZiagoWAdHcZag4KANCc+hzSvDxgHI16lZ
         zYt4YnDHCr9vw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4S7bRD1Djwz4wnw;
        Sun, 15 Oct 2023 21:03:20 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <066caa6d9480365da9b8ed83692d7101e10ac5f8.1695657339.git.christophe.leroy@csgroup.eu>
References: <066caa6d9480365da9b8ed83692d7101e10ac5f8.1695657339.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/85xx: Fix math emulation exception
Message-Id: <169736402375.957740.5992745074331848586.b4-ty@ellerman.id.au>
Date:   Sun, 15 Oct 2023 21:00:23 +1100
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

On Mon, 25 Sep 2023 17:55:51 +0200, Christophe Leroy wrote:
> Booting mpc85xx_defconfig kernel on QEMU leads to:
> 
> Bad trap at PC: fe9bab0, SR: 2d000, vector=800
> awk[82]: unhandled trap (5) at 0 nip fe9bab0 lr fe9e01c code 5 in libc-2.27.so[fe5a000+17a000]
> awk[82]: code: 3aa00000 3a800010 4bffe03c 9421fff0 7ca62b78 38a00000 93c10008 83c10008
> awk[82]: code: 38210010 4bffdec8 9421ffc0 7c0802a6 <fc00048e> d8010008 4815190d 93810030
> Trace/breakpoint trap
> WARNING: no useful console
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/85xx: Fix math emulation exception
      https://git.kernel.org/powerpc/c/8e8a12ecbc86700b5e1a3596ce2b3c43dafad336

cheers
