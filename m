Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE8C7DC462
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 03:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232458AbjJaCWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 22:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbjJaCWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 22:22:38 -0400
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BECFE6
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 19:22:35 -0700 (PDT)
Message-ID: <d4892376-68a4-4862-b787-37f6113480c4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1698718953;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mNw8ul+I6BQ2X/oU0NkDeNQ5/l80DZzthFkS3oH+jYk=;
        b=expCteQHZceW/SmaSz+BmFkaJAGdNEW1wCgtbeDUk1OT5xzRccWbL5cdW1Xj3Ch8TGa6tg
        3I/Fb1gXzDAWVm7+HbDI2cEtQWOojBhVZr5MbLE79as2L58cPkOYk3Z83ICzgkPAg6C/hw
        ApfKl1WnLf7GiZalw+XhAcP2jTEdNU0=
Date:   Tue, 31 Oct 2023 10:22:01 +0800
MIME-Version: 1.0
Subject: Re: [RFC PATCH v3 4/7] slub: Change get_partial() interfaces to
 return slab
Content-Language: en-US
To:     Vlastimil Babka <vbabka@suse.cz>, cl@linux.com, penberg@kernel.org
Cc:     rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, roman.gushchin@linux.dev,
        42.hyeyoo@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
References: <20231024093345.3676493-1-chengming.zhou@linux.dev>
 <20231024093345.3676493-5-chengming.zhou@linux.dev>
 <2a709f66-41a0-9ab2-9965-6f513f6c0524@suse.cz>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <2a709f66-41a0-9ab2-9965-6f513f6c0524@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/10/31 00:55, Vlastimil Babka wrote:
> On 10/24/23 11:33, chengming.zhou@linux.dev wrote:
>> From: Chengming Zhou <zhouchengming@bytedance.com>
>>
>> We need all get_partial() related interfaces to return a slab, instead
>> of returning the freelist (or object).
>>
>> Use the partial_context.object to return back freelist or object for
>> now. This patch shouldn't have any functional changes.
>>
>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> 
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> 
> I think you could even move patches 3/7 and 4/7 to the front of the series,
> as cleanups that are useful on their own.
> 

Right, I will move these two to the front in the next version.

Thanks!
