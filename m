Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8A8793B81
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 13:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239996AbjIFLgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 07:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239986AbjIFLgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 07:36:36 -0400
Received: from out-228.mta0.migadu.com (out-228.mta0.migadu.com [IPv6:2001:41d0:1004:224b::e4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E182210D0
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 04:36:27 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1694000186;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cLC3ilm6nlwMIg5uGKAYYbeBdxr5BpYXfFOBlWtkXh8=;
        b=s2+X3QCSIeUe4ujttwJ6scy83JEMzyyuNCLpoDzYNkBUcMUXnhwlVYotVLRbFgPXvRZ1n/
        X1CwCZqTTldwabTkI+kKLKHjuYJnp28rqkNDh98Ha/teuofnJR/h0EyAU5IIPP2oqaHkgG
        dhobFpuHaxWuTX74xPq3rIlPmCYOXQE=
Mime-Version: 1.0
Subject: Re: [v4 3/4] memblock: introduce MEMBLOCK_RSRV_NOINIT flag
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20230906112605.2286994-4-usama.arif@bytedance.com>
Date:   Wed, 6 Sep 2023 19:35:52 +0800
Cc:     Linux-MM <linux-mm@kvack.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        fam.zheng@bytedance.com, liangma@liangbit.com,
        punit.agrawal@bytedance.com
Content-Transfer-Encoding: 7bit
Message-Id: <05DA93DB-84E5-48C3-AA16-F1F2525C8CC8@linux.dev>
References: <20230906112605.2286994-1-usama.arif@bytedance.com>
 <20230906112605.2286994-4-usama.arif@bytedance.com>
To:     Usama Arif <usama.arif@bytedance.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 6, 2023, at 19:26, Usama Arif <usama.arif@bytedance.com> wrote:
> 
> For reserved memory regions marked with this flag,
> reserve_bootmem_region is not called during memmap_init_reserved_pages.
> This can be used to avoid struct page initialization for
> regions which won't need them, for e.g. hugepages with
> HVO enabled.
> 
> Signed-off-by: Usama Arif <usama.arif@bytedance.com>

Acked-by: Muchun Song <songmuchun@bytedance.com>


