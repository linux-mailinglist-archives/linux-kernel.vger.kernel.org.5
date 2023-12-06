Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 935F480639C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 01:47:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376335AbjLFAqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 19:46:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376296AbjLFAqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 19:46:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C6EAC
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 16:46:59 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84A3FC433C8;
        Wed,  6 Dec 2023 00:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701823619;
        bh=b5r5GxuYWHo36uh4ovYgu5m135G+N9ZSSwh0htqUnfM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=la+CqPPqfkLVqIiY+xzaHmGFS9CkyQKnrbETqIQqwbah3+lvOql3uSGTnKbd83GLn
         CzuOC3tBU4YX+V8KeKYAKaiAHdqLsvqhqCFg79UNf+B39DvfMCQ6TyyGfa1uXiTgQu
         VlXLmGB/edcKWRAWOUYlFMEIz0IXVwPjs+cKEXvZlGOhgd7iIzfj22r0+1vDGkIRxE
         3LT0+Z1LetBYgNADApH2HDkkJ/mM04ENyOwRyK9PytwjoKUnF7Dgr+OxQzx/IF3oeU
         CpYVPv9ANhxGcLcr/YNz+008+G6UFW1VV5Vd/GgNA57hTptrXjkS++E1NxT5ERcKXq
         5Q8PKY4BV++Wg==
Date:   Tue, 5 Dec 2023 16:46:56 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jerry Shih <jerry.shih@sifive.com>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, herbert@gondor.apana.org.au,
        davem@davemloft.net, conor.dooley@microchip.com, ardb@kernel.org,
        conor@kernel.org, heiko@sntech.de, phoebe.chen@sifive.com,
        hongrong.hsu@sifive.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH v3 00/12] RISC-V: provide some accelerated cryptography
 implementations using vector extensions
Message-ID: <20231206004656.GC1118@sol.localdomain>
References: <20231205092801.1335-1-jerry.shih@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205092801.1335-1-jerry.shih@sifive.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2023 at 05:27:49PM +0800, Jerry Shih wrote:
> This series depend on:
> 2. support kernel-mode vector
> Link: https://lore.kernel.org/all/20230721112855.1006-1-andy.chiu@sifive.com/
> 3. vector crypto extensions detection
> Link: https://lore.kernel.org/lkml/20231017131456.2053396-1-cleger@rivosinc.com/

What's the status of getting these prerequisites merged?

- Eric
