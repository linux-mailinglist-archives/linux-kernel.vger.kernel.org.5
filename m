Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3D667B1757
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 11:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbjI1J1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 05:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbjI1J1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 05:27:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 199791B6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 02:27:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4432DC433C8;
        Thu, 28 Sep 2023 09:27:17 +0000 (UTC)
Date:   Thu, 28 Sep 2023 10:27:14 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Patrick Wang <patrick.wang.shcn@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] mm/kmemleak: fix print format of pointer in
 pr_debug()
Message-ID: <ZRVG8jSgjJ7pR9b/@arm.com>
References: <20230927035923.1425340-1-liushixin2@huawei.com>
 <20230927035923.1425340-4-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927035923.1425340-4-liushixin2@huawei.com>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2023 at 11:59:23AM +0800, Liu Shixin wrote:
> With 0x%p, the pointer will be hashed and print (____ptrval____) instead.
> And with 0x%pa, the pointer can be successfully printed but with duplicate
> prefixes, which looks like:
> 
>  kmemleak: kmemleak_free(0x(____ptrval____))
>  kmemleak: kmemleak_free_part_phys(0x0x0000000a1af86000)
> 
> Use %pa instead of 0x%p or 0x%pa to print the pointer, and use 0x%px for
> __percpu pointer to prevent crash. Then the print will be like:

Why not %px in all cases?

-- 
Catalin
