Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 996277CE1EA
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 17:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344886AbjJRP55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 11:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344849AbjJRP5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 11:57:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 128B7118
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 08:57:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79F62C433C7;
        Wed, 18 Oct 2023 15:57:52 +0000 (UTC)
Date:   Wed, 18 Oct 2023 16:57:50 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Patrick Wang <patrick.wang.shcn@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/7] mm: kmemleak: use mem_pool_free() to free object
Message-ID: <ZTAAftQF8ReYAHlF@arm.com>
References: <20231018102952.3339837-1-liushixin2@huawei.com>
 <20231018102952.3339837-6-liushixin2@huawei.com>
 <ZS_-MBDKXR9qFXDb@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZS_-MBDKXR9qFXDb@arm.com>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 04:48:06PM +0100, Catalin Marinas wrote:
> On Wed, Oct 18, 2023 at 06:29:50PM +0800, Liu Shixin wrote:
> > The kmemleak object is allocated by mem_pool_alloc(), which
> > could be from slab or mem_pool[], so it's not suitable using
> > __kmem_cache_free() to free the object, use __mem_pool_free()
> > instead.
> > 
> > Fixes: 0647398a8c7b ("mm: kmemleak: simple memory allocation pool for kmemleak objects")
> > Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> 
> Could you please reorder this patch before the previous one? If you
> added a Fixes tag, we may want a cc stable as well (as for the other
> patches with a Fixes tag) and it makes more sense to backport it on its
> own without the __create_object() split. Otherwise:

Ah, ignore this. If we want a cc stable, the whole thing needs
backporting, including the split which is essential for the subsequent
fix.

> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

-- 
Catalin
