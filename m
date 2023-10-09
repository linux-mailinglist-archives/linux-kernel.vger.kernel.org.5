Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 948007BEB74
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 22:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378545AbjJIUTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 16:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378520AbjJIUTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 16:19:11 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD11DDA;
        Mon,  9 Oct 2023 13:19:04 -0700 (PDT)
Received: from [194.95.143.137] (helo=phil.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1qpwiI-0004zP-2L; Mon, 09 Oct 2023 22:18:50 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-hardening@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] mtd: rawnand: rockchip: Use struct_size()
Date:   Mon, 09 Oct 2023 22:18:49 +0200
Message-ID: <3186469.5fSG56mABF@phil>
In-Reply-To: <481721c2c7fe570b4027dbe231d523961c953d5a.1696146232.git.christophe.jaillet@wanadoo.fr>
References: <481721c2c7fe570b4027dbe231d523961c953d5a.1696146232.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_PASS,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 1. Oktober 2023, 09:44:04 CEST schrieb Christophe JAILLET:
> Use struct_size() instead of hand writing it.
> This is less verbose and more robust.
> 
> While at it, prepare for the coming implementation by GCC and Clang of the
> __counted_by attribute. Flexible array members annotated with __counted_by
> can have their accesses bounds-checked at run-time checking via
> CONFIG_UBSAN_BOUNDS (for array indexing) and CONFIG_FORTIFY_SOURCE (for
> strcpy/memcpy-family functions).
> 
> Also remove a useless comment about the position of a flex-array in a
> structure.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Acked-by: Heiko Stuebner <heiko@sntech.de>


