Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E47F7BDF14
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 15:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376765AbjJIN0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 09:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376701AbjJIN0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 09:26:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E0C0D6
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 06:26:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD895C433C9;
        Mon,  9 Oct 2023 13:25:59 +0000 (UTC)
Date:   Mon, 9 Oct 2023 14:25:57 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Patrick Wang <patrick.wang.shcn@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] mm/kmemleak: fix print format of pointer in
 pr_debug()
Message-ID: <ZSP/ZR5P/xRiiq7D@arm.com>
References: <20231008023317.3015699-1-liushixin2@huawei.com>
 <20231008023317.3015699-5-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231008023317.3015699-5-liushixin2@huawei.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 08, 2023 at 10:33:17AM +0800, Liu Shixin wrote:
> With 0x%p, the pointer will be hashed and print (____ptrval____) instead.
> And with 0x%pa, the pointer can be successfully printed but with duplicate
> prefixes, which looks like:
> 
>  kmemleak: kmemleak_free(0x(____ptrval____))
>  kmemleak: kmemleak_free_percpu(0x(____ptrval____))
>  kmemleak: kmemleak_free_part_phys(0x0x0000000a1af86000)
> 
> Use 0x%px instead of 0x%p or 0x%pa to print the pointer. Then the print
> will be like:
> 
>  kmemleak: kmemleak_free(0xffff9111c145b020)
>  kmemleak: kmemleak_free_percpu(0x00000000000333b0)
>  kmemleak: kmemleak_free_part_phys(0x0000000a1af80000)
> 
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
