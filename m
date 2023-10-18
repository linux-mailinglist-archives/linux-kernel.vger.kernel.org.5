Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09A177CE2D1
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 18:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjJRQe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 12:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjJRQe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 12:34:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD95BD
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 09:34:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F75FC433C9;
        Wed, 18 Oct 2023 16:34:24 +0000 (UTC)
Date:   Wed, 18 Oct 2023 17:34:21 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Liu Shixin <liushixin2@huawei.com>,
        Patrick Wang <patrick.wang.shcn@gmail.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/7] mm: kmemleak: use mem_pool_free() to free object
Message-ID: <ZTAJDRPY24prX8pU@arm.com>
References: <20231018102952.3339837-1-liushixin2@huawei.com>
 <20231018102952.3339837-6-liushixin2@huawei.com>
 <ZS_-MBDKXR9qFXDb@arm.com>
 <ZTAAftQF8ReYAHlF@arm.com>
 <20231018092253.a12815afa7db9049f95fc195@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018092253.a12815afa7db9049f95fc195@linux-foundation.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 09:22:53AM -0700, Andrew Morton wrote:
> On Wed, 18 Oct 2023 16:57:50 +0100 Catalin Marinas <catalin.marinas@arm.com> wrote:
> > > Could you please reorder this patch before the previous one? If you
> > > added a Fixes tag, we may want a cc stable as well (as for the other
> > > patches with a Fixes tag) and it makes more sense to backport it on its
> > > own without the __create_object() split. Otherwise:
> > 
> > Ah, ignore this. If we want a cc stable, the whole thing needs
> > backporting, including the split which is essential for the subsequent
> > fix.
> 
> Do we want a cc:stable?  That tag wasn't originally included.
> 
> If so, all seven patches?
> 
> If "not all seven" then can we please have two series, one for the
> backport patches, one for next merge window.

I think we need all 7 if we are to backport them. But we don't need to
cc stable explicitly, we can send them to stable@kernel.org separately
once tested on those stable versions. So, for the mm tree, don't bother
with cc stable.

-- 
Catalin
