Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D994A753B0F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 14:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235292AbjGNMdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 08:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235016AbjGNMdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 08:33:38 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC7435A6
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 05:33:02 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-666e6541c98so1792689b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 05:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1689337982; x=1691929982;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YE68fL0Jr5S3VfTwK0LM8IWsYImIMY6y+ghb1IBqp4M=;
        b=flds3MvE+Qif7Y6neo4eB7+7ilvKIxubGB32eZPK6b8eU8WcOYebb1BdscJPwe/9yV
         eJtKU7acv6SMZc6zE0lBGm8N5B+1KOalfSuZVjB2A1C+9uw6z0lcPyrIlbEeoQaoomOT
         fs3Ivd54fJD7QPNbJwfHeBUDN4W1kELdMvXqD+BoGmCn/N4LsaxU7Hzx7xwRb8HxOFgE
         Z9D58I600Jjclc78Nap3TozGkwYs5Ax61lrLRYl5bJTXGAAPxm0jxJ/GLVPGa0Z+lNIb
         0wQNutqqnBWxczWAfguesfPM7XdkIxrk0r2Z80iaN1k/RTqaD3cNWP40NvoMEX5p0vQW
         iBcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689337982; x=1691929982;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YE68fL0Jr5S3VfTwK0LM8IWsYImIMY6y+ghb1IBqp4M=;
        b=j8XnQN2Os937p7c5BTfZR8d8Hl/p7IJj+1hTry7zfnSzd8O/CCtvH/ZBtP1Umhmx8b
         KMNrQJNshsiS+3rgzElTGl7k04jU6Vw0F9kxeAMtUBHFiz75pDmn4ipjscVLrm3SVTRR
         SEYRqd30aE8V2oqr+/D/yjSryMNiabRealEDfQH4/WeivHImM4dSC3i6JZgaZ8kt+LkE
         d56PwP6PWXa+cj0HWjJB1bZn8oZ6/k3ZcgpYbzRr/42rdcGR2lWB1yY/ss4+6NpgdU8x
         LxkT0uD/RnGcAKD1yDCQRsAkEuq1wCA+5Qv2Oj1vO4rpm7RTSyhIQQQI8wetLFp2KFqc
         qNmw==
X-Gm-Message-State: ABy/qLYc5phHkjBNK0yOW/WC1YN55dnuFE9Cto37FDi6bv/A12ArFwiG
        ytsdObRf+/o+56Q3jE357gDzOg==
X-Google-Smtp-Source: APBJJlEm4BD0EWFJ5DJ8KPQnFlj5A2ODdTMlr8mkNgQ865kluLoP9TMbfNDdWInNI01wE15b6O/x5g==
X-Received: by 2002:a05:6a00:24ca:b0:66a:386c:e6a6 with SMTP id d10-20020a056a0024ca00b0066a386ce6a6mr5757501pfv.6.1689337981788;
        Fri, 14 Jul 2023 05:33:01 -0700 (PDT)
Received: from [10.254.16.139] ([139.177.225.225])
        by smtp.gmail.com with ESMTPSA id j5-20020a62e905000000b0068338b6667asm4283272pfh.212.2023.07.14.05.32.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jul 2023 05:33:01 -0700 (PDT)
Message-ID: <152f65f1-5b6d-1795-1bc9-3ea318f0bae0@bytedance.com>
Date:   Fri, 14 Jul 2023 20:32:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: Maple Tree Work
To:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>
References: <20230707163815.ns4kdz7iut5octjv@revolver>
 <463899aa-6cbd-f08e-0aca-077b0e4e4475@bytedance.com>
 <20230712152738.ld7rn5zmmhtc6wkg@revolver>
 <e2fd59b5-8791-0a46-5157-51f93835ef35@bytedance.com>
 <20230713153657.b2xzf6z3yxi6nojn@revolver>
Cc:     Peng Zhang <zhangpeng.00@bytedance.com>,
        maple-tree@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
From:   Peng Zhang <zhangpeng.00@bytedance.com>
In-Reply-To: <20230713153657.b2xzf6z3yxi6nojn@revolver>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/7/13 23:36, Liam R. Howlett 写道:
> * Peng Zhang <zhangpeng.00@bytedance.com> [230713 04:05]:
>>
>>
>> 在 2023/7/12 23:27, Liam R. Howlett 写道:
>>> Dropping Danilo from the Cc..
>>>
>>> I was asked to add linux-mm to the list, so I did that as well.
>>>
>>> If anyone else is interested in seeing the full list, it's on lkml [1] and
>>> the maple-tree list [2].
>>>
>>> Thank you Peng for looking at the list and taking time to think about
>>> the items.
>>>
>>> * Peng Zhang <zhangpeng.00@bytedance.com> [230712 07:49]:
>>>>
>>>>
>>>> 在 2023/7/8 00:38, Liam R. Howlett 写道:
>>>>>     - Fork & Dup tree + Delete DONT_COPY
>>>>>     	This is to optimize dup_mmap() in kernel/fork.c, but other
>>>>> 	users may want faster duplications of a tree.
>>>>> 	This should be faster than building a tree in bulk mode.  The
>>>>> 	idea is to just copy each node and replace the pointers in,
>>>>> 	probably, a BFS order.  Once the leaves are reached, the VMAs
>>>>> 	will be replaced by the copies made in fork, unless DONT_COPY is
>>>>> 	set, in which case the VMA will be deleted from the copied tree.
>>>>> 	DONT_COPY is not common and since the tree isn't visible, all
>>>>> 	nodes should be available for reuse (no RCU worries).
>>>> If DONT_COPY is set, this method will be complicated, because the gaps
>>>> adjacent to it need to be merged, and the gaps of all ancestor nodes need to
>>>> be updated.
>>>
>>> My understanding is that this is a rare event; there aren't many VMAs
>>> marked this way.  The store operation already does all the necessary
>>> work for deleting an entry. The gap tracking is also updated, and that
>>> would only happen if the new gap is larger.  Are you concerned about the
>>> performance/runtime of handling the DONT_COPY in this way?
>> Yes, if no DONT_COPY is set, copying all nodes and replacing the
>> pointers must be the fastest way. I was just thinking if there is
>> a faster way if DONT_COPY exists. Using the store operation to
>> delete unnecessary entries will cause additional overhead sometimes.
>> To give an example:
>>
>> Suppose a leaf node layout of the maple tree is as follows:
>> [VMA1][VMA2][NULL][VMA3]
>>
>> If VMA2 has DONT_COPY set, we need to change the node layout as
>> follows to delete it:
>> [VMA1'][NULL][VMA3']
>>
>> At least we need to copy this node to replace it to make this
>> delete operation, even need to rebalance. However, this is a
>> rare case. In most cases, there is no gap between VMAs, so it
>> will not cause changes in the node layout.
> 
> Remember that at this point, there is no readers so we could edit the
> node without a copy.  It would require new code, but it's just moving
> data left..  The bigger worry is a rebalance, as you said, and that can
> get complicated. We know we have (more than) enough room to store the
> data, but editing in place isn't done in this version of the code.  We
> do allow for node re-use by pushing back onto the mas->alloc, so the
> data requirements won't be too high.  Without any readers, the parent
> pivots could be changed directly between two leaves.
> 
>>>
>>>>
>>>> I have another idea to build a tree, if inserted in order, we only
>>>> insert at the leaf node. All leaf nodes are connected using a linked
>>>> list. In the end we get a linked list with only leaf nodes. Then we
>>>> construct non-leaf nodes layer by layer from bottom to top. I think
>>>> this is also faster than bulk mode. Another advantage of this method
>>>> is that we are applicable to more scenarios, do not need the original
>>>> tree, only need to know the ranges inserted in order. I don't know
>>>> how fast this method is, so we can discuss it.
>>>
>>> What is the advantage of a linked list over just building the tree as
>>> you go?  Considering the non-leaf nodes are just a list of nodes
>>> already, and you will have to do the same work of setting pivots,
>>> allocating nodes, and filling them after you have the linked list.
>>>
>>> What work do you avoid that would make a linked list faster than bulk
>>> insert or a tree copy/replace VMAs?  I was thinking that we could avoid
>>> a lot of the work involved with splitting/pushing and the parent
>>> construction by using memcpy of each node, replace each slot (and
>>> parent) with a new memcpy of the mirrored tree, then have a minimum
>>> amount of modifications to delete the DONT_COPY during the VMA
>>> replacement.  BFS copy would ensure we wouldn't modify the source tree
>>> during VMA replacement and deletion (DONT_COPY).  So the rebalancing (in
>>> bulk insert), pivot calculations, metadata, and gaps are (mostly) saved
>>> by using memcpy.
>> Your analysis is correct.
>>>
>>>   From what I understand from your linked list idea, we would need to
>>> construct the child node by examining each entry and know that a certain
>>> entry is a DONT_COPY (ie: VMA logic would be needed in the maple tree
>>> code or a callback?). We really can't have VMA logic in the maple tree
>>> code, so we could do some sort of loop through the VMAs to add the entry
>>> to the list if desired.
>>>
>>> Once we have a linked list, we still need to figure out each pivot for
>>> the parent (I guess we won't use the last slot so there is a pivot to
>>> check?), and each max gap in each child to construct the upper layers
>>> of the tree.  Is this correct?
>>>
>>> I guess we would still need to adjust the last node to ensure sufficient
>>> entries as well, so as we add items we may need to rebalance the last
>>> leaf with the second-last leaf.
>> Yes, the last two leaves need to check to make sure they have enough
>> items.
>>>
>>> The bulk store currently adjusts the split to favour splitting
>>> left, could you get the same result by strictly filling the nodes?  This
>>> would have to have special handling to rebalance the last one - which we
>>> have a pretty good idea of when it's going to happen as we have a count
>>> (and the DONT_COPY is rare).
>>>
>>> Are you thinking you could compact the tree at the same time to gain
>>> efficiency?
>>>
>>> What would you consider a sufficient packed tree?  It's best to keep
>>> some space around for expansion/contraction.  This works out since, I
>>> think, we would need to keep that last slot free so we have a pivot to
>>> check in your linked list plan. Initial development with strict
>>> split/join rules resulted in a 'jittering' of nodes as the number of
>>> entries in a node shifted just above/below the threshold so we relaxed
>>> the merging of nodes to avoid such a scenario.
>> We can control the number of entries of nodes, for example, let this
>> number be (min + max)/2, so as to avoid making a node too 'dense' or
>> too 'loose'.
> 
> By the way, in the VMA case, we also know the number of VMAs in the
> tree.  Unfortunately, we don't know how many are DONT_COPY VMAs.  I
> wonder if it would be worth while to balance each VMA with its neighbour
> during this operation, at least within one tree level?  It would reduce
> the possibility of a larger rebalance on a DONT_COPY.  It's probably not
> worth it because it would slow down our fast path.
> 
>>>
>>> Let me know if you would like me to put your name beside the Fork & Dup
>>> Tree item in the list of work.
>> You can put my name on this one and I'll do it.
> 
> Sounds good, thanks!
> 
>> I use the method of copying all nodes, so I will implement an interface
>> to get a mirrored tree.
>>
>> But I can't think of a good way to replace old VMAs, it can't be done
>> during the copy tree process, because maybe some VMAs have DONT_COPY
>> flag.
> 
> I think it could be done during the copy, instead of a 'replace' it
> would be a 'delete'.  I think this is why we need to use a BFS-like
> duplication. So once we reach the leaves, then we can modify the tree
> knowing that the above state has already been copied and so it's going
> to be altering a copy of the data and so we are at a point where it can
> be mutated.  You could detect that the lock-step next/insert is out of
> sync and delete the range between the old_mas and the new_mas.
> 
>> It seems that we can only scan all VMAs in the source tree again
>> to update the new tree. We have already traversed the source tree once
>> in the process of copying the tree. Is there any way to avoid traversing
>> it again?
> 
> Well, we haven't visited the VMAs in the copy, but we have visited the
> leaf nodes with all the pointers to the VMAs.  I get what you are
> saying thought, we will have to duplicate the leaves then re-visit the
> leaves to replace the VMAs.  I am not sure we can avoid this since a
> rebalance may occur, and it would be very tricky to rebalance with old
> and new data in the tree - it's probably best to just revisit, at least
> to begin with.
> 
> Depending on how you implement it, you could make the copying of the
> tree end on the first leaf node by using the height of the tree to
> figure out which way to sweep (left to right or right to left) on the
> first level.  Not strictly BFS, but you could end the maple state in the
> correct location to start replacing the VMAs.  Would that work?
> 
> We also have a reverse iterator, so we could just run through the tree
> from the right-most node to the start.
> 
> I was thinking that we would make the first 'duplication store' detect
> an empty tree and duplicate the tree, ending on the left-most leaf and
> then replace the first entry (and possibly delete up to the first
> store).  Each subsequent store would do the same.  We would need a
> 'duplication complete' that would remove any entries beyond the last
> store and rebalance, if necessary.
> 
> Feel free to use some or none of the ideas.  I hope some of this helps
> with what you are trying to work out.  Let me know if you have any more
> questions.
Thank you for providing so much information, I am doing this feature.

Thanks,
Peng
> 
> Thanks,
> Liam
> 
