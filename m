Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 134B37FB0A7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 04:47:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234535AbjK1Dpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 22:45:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232858AbjK1Dpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 22:45:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6DD1D4E
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 19:45:38 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C698C433C9;
        Tue, 28 Nov 2023 03:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701143138;
        bh=iUs8sHkTZHvgV4m7oQH03SHaVTmkC/+rsFHLswC0zcw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Di770KJ8dOeJ74EzzegGRUa6qD1qCkdQpa96FR991b6MkcaeMI55ukBVgNIgJ74/8
         AQYXl5jzn5x2Y7wEbRqSNQwktyHdtBurg1xytwHOCEvFd2nJPkcoRkB3bJNhZ2KAm7
         gGu9PRlg3UcAmhz+OP9lY/BwvObgK5u83B6ggG4wvjEPmgcMiX9N6d50LSR9jjT6zv
         tL29MNSFkF29D9n/P3hBLvEu98Lb5cEA4aAwZeIgCkR1SkVdr5cBYvfT71b6Z+RImA
         hEz53xmbZz+Lrkoz4vP7FOTH5K9iBLEC+sJlBoRMo97u24ZDrJYBo2iQTJq+GKNWl3
         vdncApXSdj61g==
Date:   Mon, 27 Nov 2023 19:45:36 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jerry Shih <jerry.shih@sifive.com>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, herbert@gondor.apana.org.au,
        davem@davemloft.net, conor.dooley@microchip.com, ardb@kernel.org,
        heiko@sntech.de, phoebe.chen@sifive.com, hongrong.hsu@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org
Subject: Re: [PATCH v2 02/13] RISC-V: hook new crypto subdir into build-system
Message-ID: <20231128034536.GF1463@sol.localdomain>
References: <20231127070703.1697-1-jerry.shih@sifive.com>
 <20231127070703.1697-3-jerry.shih@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127070703.1697-3-jerry.shih@sifive.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 03:06:52PM +0800, Jerry Shih wrote:
> From: Heiko Stuebner <heiko.stuebner@vrull.eu>
> 
> Create a crypto subdirectory for added accelerated cryptography routines
> and hook it into the riscv Kbuild and the main crypto Kconfig.
> 
> Signed-off-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
> Signed-off-by: Jerry Shih <jerry.shih@sifive.com>
> ---
>  arch/riscv/Kbuild          | 1 +
>  arch/riscv/crypto/Kconfig  | 5 +++++
>  arch/riscv/crypto/Makefile | 4 ++++
>  crypto/Kconfig             | 3 +++
>  4 files changed, 13 insertions(+)
>  create mode 100644 arch/riscv/crypto/Kconfig
>  create mode 100644 arch/riscv/crypto/Makefile

Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric
