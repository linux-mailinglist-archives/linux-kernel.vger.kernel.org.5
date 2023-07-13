Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8C9D751AD1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233758AbjGMIIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234134AbjGMIII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:08:08 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116492721
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 01:05:27 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-26314c2be8eso132969a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 01:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1689235526; x=1691827526;
        h=content-transfer-encoding:in-reply-to:cc:from:references:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rN/8qwy76zPd7jcwocop8ymX24ME9M0c5+UnEHaPKgg=;
        b=RwOTVREkLadhYHCIoXp64lPr//90yJGN8xktT2S027sgWMj24sRzrqp4t7KcmWLTPJ
         8U7LTcLHp7UcfgTxqtigjyKsHv88zWA6gVaf2RI519b5KGEtVr84P8L8/fz8BVz3q17b
         RQVFO6e3wNZZnZGoejhyQrP9rVFae4QTR5qno3G4AQfDzF+xxYkGLlwVN6JPcWX9KiUH
         yl79aAKAq4FGxGxGueBLTbOPsucl8no6vrw3O0UFHOEz8hkcHJXjEMQjrdUNck6RalYB
         N98scDgdzgFEP4vvonApwHbeJ+8FR1xXAUWRxOX7N8GEHT7j/6ggdrdO7GdFZ8t7VOlS
         0r9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689235526; x=1691827526;
        h=content-transfer-encoding:in-reply-to:cc:from:references:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rN/8qwy76zPd7jcwocop8ymX24ME9M0c5+UnEHaPKgg=;
        b=Ybb2tiI1XDBpFpNhdaYlh0w6R8ngdauavw27S84RYTZt1Kl3U8uQDndEaXuH+8gB8j
         xioSnd++DNJdgQUNziK24tvknl/OhT9rExJHWyS6quIJ+ajKJvtpdzxhR3y/B4Uij8IP
         Wcpv3t9GqvWPSiStyXHSROQ7048A/aD85sNRgZZgJohYX0awAEKCDfftbFzjvS/a3z7S
         1JZqtOsF4bX/c7ZcaUiZaaUREHDk8iRQca19J2sjOy4x3i2ZDkjZjXG+oWyepdxh1PEg
         7Ff2IgR1HcS4RdCgSWfQ8zVqRR8r/MVo2NuGYLBf8TLCNExaCLWZrnYyO6OplYhJ4/3D
         FWgw==
X-Gm-Message-State: ABy/qLZ3kftMNu6cxr0FZc3HuUO3Otc2G6czg89fb0Vqd8Wlm7aO3Rh2
        B5a9z4D0vUsQ061ycXgeCAy1KA==
X-Google-Smtp-Source: APBJJlEUmXHImzNaTAChjbaECNHjIaxusMJaWCRRZQnF/Zn13onTjNBr0n3zaaF+PUYG/f3PCz310A==
X-Received: by 2002:a17:90a:1f8f:b0:265:7719:b83e with SMTP id x15-20020a17090a1f8f00b002657719b83emr289414pja.43.1689235526397;
        Thu, 13 Jul 2023 01:05:26 -0700 (PDT)
Received: from [10.254.22.102] ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id ik25-20020a170902ab1900b001b54a88e4a6sm5399609plb.51.2023.07.13.01.05.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 01:05:25 -0700 (PDT)
Message-ID: <e2fd59b5-8791-0a46-5157-51f93835ef35@bytedance.com>
Date:   Thu, 13 Jul 2023 16:05:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: Maple Tree Work
To:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>
References: <20230707163815.ns4kdz7iut5octjv@revolver>
 <463899aa-6cbd-f08e-0aca-077b0e4e4475@bytedance.com>
 <20230712152738.ld7rn5zmmhtc6wkg@revolver>
From:   Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     Peng Zhang <zhangpeng.00@bytedance.com>,
        maple-tree@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
In-Reply-To: <20230712152738.ld7rn5zmmhtc6wkg@revolver>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/7/12 23:27, Liam R. Howlett 写道:
> Dropping Danilo from the Cc..
> 
> I was asked to add linux-mm to the list, so I did that as well.
> 
> If anyone else is interested in seeing the full list, it's on lkml [1] and
> the maple-tree list [2].
> 
> Thank you Peng for looking at the list and taking time to think about
> the items.
> 
> * Peng Zhang <zhangpeng.00@bytedance.com> [230712 07:49]:
>>
>>
>> 在 2023/7/8 00:38, Liam R. Howlett 写道:
>>>    - Fork & Dup tree + Delete DONT_COPY
>>>    	This is to optimize dup_mmap() in kernel/fork.c, but other
>>> 	users may want faster duplications of a tree.
>>> 	This should be faster than building a tree in bulk mode.  The
>>> 	idea is to just copy each node and replace the pointers in,
>>> 	probably, a BFS order.  Once the leaves are reached, the VMAs
>>> 	will be replaced by the copies made in fork, unless DONT_COPY is
>>> 	set, in which case the VMA will be deleted from the copied tree.
>>> 	DONT_COPY is not common and since the tree isn't visible, all
>>> 	nodes should be available for reuse (no RCU worries).
>> If DONT_COPY is set, this method will be complicated, because the gaps
>> adjacent to it need to be merged, and the gaps of all ancestor nodes need to
>> be updated.
> 
> My understanding is that this is a rare event; there aren't many VMAs
> marked this way.  The store operation already does all the necessary
> work for deleting an entry. The gap tracking is also updated, and that
> would only happen if the new gap is larger.  Are you concerned about the
> performance/runtime of handling the DONT_COPY in this way?
Yes, if no DONT_COPY is set, copying all nodes and replacing the
pointers must be the fastest way. I was just thinking if there is
a faster way if DONT_COPY exists. Using the store operation to
delete unnecessary entries will cause additional overhead sometimes.
To give an example:

Suppose a leaf node layout of the maple tree is as follows:
[VMA1][VMA2][NULL][VMA3]

If VMA2 has DONT_COPY set, we need to change the node layout as
follows to delete it:
[VMA1'][NULL][VMA3']

At least we need to copy this node to replace it to make this
delete operation, even need to rebalance. However, this is a
rare case. In most cases, there is no gap between VMAs, so it
will not cause changes in the node layout.
> 
>>
>> I have another idea to build a tree, if inserted in order, we only
>> insert at the leaf node. All leaf nodes are connected using a linked
>> list. In the end we get a linked list with only leaf nodes. Then we
>> construct non-leaf nodes layer by layer from bottom to top. I think
>> this is also faster than bulk mode. Another advantage of this method
>> is that we are applicable to more scenarios, do not need the original
>> tree, only need to know the ranges inserted in order. I don't know
>> how fast this method is, so we can discuss it.
> 
> What is the advantage of a linked list over just building the tree as
> you go?  Considering the non-leaf nodes are just a list of nodes > already, and you will have to do the same work of setting pivots,
> allocating nodes, and filling them after you have the linked list.
> 
> What work do you avoid that would make a linked list faster than bulk
> insert or a tree copy/replace VMAs?  I was thinking that we could avoid
> a lot of the work involved with splitting/pushing and the parent
> construction by using memcpy of each node, replace each slot (and
> parent) with a new memcpy of the mirrored tree, then have a minimum
> amount of modifications to delete the DONT_COPY during the VMA
> replacement.  BFS copy would ensure we wouldn't modify the source tree
> during VMA replacement and deletion (DONT_COPY).  So the rebalancing (in
> bulk insert), pivot calculations, metadata, and gaps are (mostly) saved
> by using memcpy.
Your analysis is correct.
> 
>  From what I understand from your linked list idea, we would need to
> construct the child node by examining each entry and know that a certain
> entry is a DONT_COPY (ie: VMA logic would be needed in the maple tree
> code or a callback?). We really can't have VMA logic in the maple tree
> code, so we could do some sort of loop through the VMAs to add the entry
> to the list if desired.
> 
> Once we have a linked list, we still need to figure out each pivot for
> the parent (I guess we won't use the last slot so there is a pivot to
> check?), and each max gap in each child to construct the upper layers
> of the tree.  Is this correct?
> 
> I guess we would still need to adjust the last node to ensure sufficient
> entries as well, so as we add items we may need to rebalance the last
> leaf with the second-last leaf.
Yes, the last two leaves need to check to make sure they have enough
items.
> 
> The bulk store currently adjusts the split to favour splitting
> left, could you get the same result by strictly filling the nodes?  This
> would have to have special handling to rebalance the last one - which we
> have a pretty good idea of when it's going to happen as we have a count
> (and the DONT_COPY is rare).
> 
> Are you thinking you could compact the tree at the same time to gain
> efficiency?
> 
> What would you consider a sufficient packed tree?  It's best to keep
> some space around for expansion/contraction.  This works out since, I
> think, we would need to keep that last slot free so we have a pivot to
> check in your linked list plan. Initial development with strict
> split/join rules resulted in a 'jittering' of nodes as the number of
> entries in a node shifted just above/below the threshold so we relaxed
> the merging of nodes to avoid such a scenario.
We can control the number of entries of nodes, for example, let this
number be (min + max)/2, so as to avoid making a node too 'dense' or
too 'loose'.
> 
> Let me know if you would like me to put your name beside the Fork & Dup
> Tree item in the list of work.
You can put my name on this one and I'll do it.
I use the method of copying all nodes, so I will implement an interface
to get a mirrored tree.

But I can't think of a good way to replace old VMAs, it can't be done
during the copy tree process, because maybe some VMAs have DONT_COPY
flag. It seems that we can only scan all VMAs in the source tree again
to update the new tree. We have already traversed the source tree once
in the process of copying the tree. Is there any way to avoid traversing
it again?
> 
> [1] https://lore.kernel.org/lkml/20230707163815.ns4kdz7iut5octjv@revolver/
> [2] https://lists.infradead.org/mailman/listinfo/maple-tree
> 
> Thanks,
> Liam
> 
