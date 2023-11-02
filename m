Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD5187DEA8F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 03:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348231AbjKBCMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 22:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235187AbjKBCMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 22:12:21 -0400
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D710E124
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 19:12:15 -0700 (PDT)
Message-ID: <01b43a52-12b9-467f-b94d-475510139ba7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1698891134;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vAWiWOvXjBVljWRIB98RnVqpBiCvNH2KjezLYq7iU88=;
        b=MHqR38L4QALY/vkjw74oCa9x2h4ekCCx1PP4h30umOfdg5uG/kLjKLcHJaszlxeHMFS0Y4
        KvFNuLmdCwz9/JFYNOy0neo6qXm+OrxACmqFma8oIQ6yK3pSu3m0q9k9KVUXeP8CYEhVsl
        b/8VOxjM0Luzy4BMr0oOQnuFMLA/OsM=
Date:   Thu, 2 Nov 2023 10:12:08 +0800
MIME-Version: 1.0
Subject: Re: [RFC PATCH v4 8/9] slub: Rename all *unfreeze_partials* functions
 to *put_partials*
Content-Language: en-US
To:     Vlastimil Babka <vbabka@suse.cz>, cl@linux.com, penberg@kernel.org,
        willy@infradead.org
Cc:     rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, roman.gushchin@linux.dev,
        42.hyeyoo@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
References: <20231031140741.79387-1-chengming.zhou@linux.dev>
 <20231031140741.79387-9-chengming.zhou@linux.dev>
 <5e29c6bb-01a2-b010-df7d-525ed9fdbee4@suse.cz>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <5e29c6bb-01a2-b010-df7d-525ed9fdbee4@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/11/1 21:40, Vlastimil Babka wrote:
> On 10/31/23 15:07, chengming.zhou@linux.dev wrote:
>> From: Chengming Zhou <zhouchengming@bytedance.com>
>>
>> Since all partial slabs on the CPU partial list are not frozen anymore,
>> we don't unfreeze when moving cpu partial slabs to node partial list,
>> it's better to rename these functions.
>>
>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> 
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> 
> However I think put_partials_node() is not the best name as it's not
> something specific to a single node. I think __put_partials() would be
> better.

Right, I will change to __put_partials() in v5.

Thanks!
