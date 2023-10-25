Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1047D628B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 09:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232829AbjJYH1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 03:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232654AbjJYH1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 03:27:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0388BB
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 00:27:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 549BEC433C7;
        Wed, 25 Oct 2023 07:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698218865;
        bh=OHCzEzIthYtsFmRjwqYLqDLJQoNHQxGwdn/4gsYlYco=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=tVy7heX01oupfPjT2/Ni5AsNmXXmvzGx3m0csV3xk8ovUfuxQ0rTb0Uq5kGXLeSio
         dETsK4pcTzK1jgkquXiejbDpK60fiVGDlBqp9rU4ontKu9+Mjzdsx5HbIsZdX7imG0
         9+wkFzVFxbUIxnxC4m9juYPQhPPbCXl7rit0d4+j1pkNKykoBYHUFMfV6XXpFB+Wg1
         I8MRoqKBprf8HWcB9hEI+cxC/4jhlj/uRdPnBIQ4oAICt8EnkxyMrblQZqgfh9o02H
         4+taBrFSIhC8XzauuGFTfGtBqMiILElOJjAREgPWyqw26D7l/7JH58cSMMQFlQBx0k
         Igg4BItzXkLwQ==
Message-ID: <01ca878e-aeb1-4fb9-adda-47eaa6f07408@kernel.org>
Date:   Wed, 25 Oct 2023 16:27:43 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: boot: Fix creation of loader.bin
Content-Language: en-US
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jisheng Zhang <jszhang@kernel.org>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Song Shuai <songshuaishuai@tinylab.org>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1086025809583809538dfecaa899892218f44e7e.1698159066.git.geert+renesas@glider.be>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <1086025809583809538dfecaa899892218f44e7e.1698159066.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/24/23 23:53, Geert Uytterhoeven wrote:
> When flashing loader.bin for K210 using kflash:
> 
>     [ERROR] This is an ELF file and cannot be programmed to flash directly: arch/riscv/boot/loader.bin
> 
> Before, loader.bin relied on "OBJCOPYFLAGS := -O binary" in the main
> RISC-V Makefile to create a boot image with the right format.  With this
> removed, the image is now created in the wrong (ELF) format.
> 
> Fix this by adding an explicit rule.
> 
> Fixes: 505b02957e74f0c5 ("riscv: Remove duplicate objcopy flag")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Looks OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

