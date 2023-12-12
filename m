Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3463480F445
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 18:18:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346651AbjLLRSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 12:18:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232817AbjLLRSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 12:18:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F5A99
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 09:18:22 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 426EBC433C8;
        Tue, 12 Dec 2023 17:18:19 +0000 (UTC)
Date:   Tue, 12 Dec 2023 17:18:17 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Alexander Potapenko <glider@google.com>
Cc:     will@kernel.org, pcc@google.com, andreyknvl@gmail.com,
        andriy.shevchenko@linux.intel.com, aleksander.lobakin@intel.com,
        linux@rasmusvillemoes.dk, yury.norov@gmail.com,
        alexandru.elisei@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, eugenis@google.com,
        syednwaris@gmail.com, william.gray@linaro.org
Subject: Re: [PATCH v9 4/4] arm64: mte: implement CONFIG_ARM64_MTE_SWAP_STATS
Message-ID: <ZXiV2R-j0_seVp_i@arm.com>
References: <20231113105234.32058-1-glider@google.com>
 <20231113105234.32058-5-glider@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113105234.32058-5-glider@google.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2023 at 11:52:33AM +0100, Alexander Potapenko wrote:
> Provide a config to collect the usage statistics for ARM MTE tag
> compression. This patch introduces allocation/deallocation counters
> for buffers that were stored uncompressed (and thus occupy 128 bytes of
> heap plus the Xarray overhead to store a pointer) and those that were
> compressed into 8-byte pointers (effectively using 0 bytes of heap in
> addition to the Xarray overhead).
> 
> The counters are exposed to the userspace via
> /sys/kernel/debug/mteswap/stats:
> 
>   # cat /sys/kernel/debug/mteswap/stats
>   8 bytes:      102496 allocations,     67302 deallocations
>   128 bytes:    212234 allocations,     178278 deallocations
>   uncompressed tag storage size:        8851200
>   compressed tag storage size:  4346368
> 
> Suggested-by: Yury Norov <yury.norov@gmail.com>
> Signed-off-by: Alexander Potapenko <glider@google.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
