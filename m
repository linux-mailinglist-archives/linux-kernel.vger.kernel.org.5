Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B74AF80F436
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 18:16:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232979AbjLLRQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 12:16:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232546AbjLLRQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 12:16:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0FCF99
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 09:16:20 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C55EC433C8;
        Tue, 12 Dec 2023 17:16:17 +0000 (UTC)
Date:   Tue, 12 Dec 2023 17:16:15 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Alexander Potapenko <glider@google.com>
Cc:     will@kernel.org, pcc@google.com, andreyknvl@gmail.com,
        andriy.shevchenko@linux.intel.com, aleksander.lobakin@intel.com,
        linux@rasmusvillemoes.dk, yury.norov@gmail.com,
        alexandru.elisei@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, eugenis@google.com,
        syednwaris@gmail.com, william.gray@linaro.org
Subject: Re: [PATCH v9 1/4] arm64: mte: implement CONFIG_ARM64_MTE_COMP
Message-ID: <ZXiVX5FAWZqHfr7m@arm.com>
References: <20231113105234.32058-1-glider@google.com>
 <20231113105234.32058-2-glider@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113105234.32058-2-glider@google.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2023 at 11:52:30AM +0100, Alexander Potapenko wrote:
> The config implements the algorithm compressing memory tags for ARM MTE
> during swapping.
> 
> The algorithm is based on RLE and specifically targets buffers of tags
> corresponding to a single page. In many cases a buffer can be compressed
> into 63 bits, making it possible to store it without additional memory
> allocation.
> 
> Suggested-by: Evgenii Stepanov <eugenis@google.com>
> Signed-off-by: Alexander Potapenko <glider@google.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

> +void mte_tags_to_ranges(u8 *tags, u8 *out_tags, unsigned short *out_sizes,
> +			size_t *out_len)
> +{
[...]
> +}
> +EXPORT_SYMBOL_NS(mte_tags_to_ranges, MTECOMP);

I may have asked before, what the reason for EXPORT_SYMBOL_NS? Is it for
the kunit tests? Otherwise we don't expect those to be accessed from
modules.

-- 
Catalin
