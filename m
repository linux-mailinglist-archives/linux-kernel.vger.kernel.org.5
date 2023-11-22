Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10FE97F413D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 10:08:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343572AbjKVJIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 04:08:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235123AbjKVJHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 04:07:49 -0500
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D942684;
        Wed, 22 Nov 2023 01:04:55 -0800 (PST)
X-UUID: a7243eea2bb4484da5eecc3a6a940782-20231122
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:30d706e5-2215-47f0-ba78-3b214e0a0653,IP:10,
        URL:0,TC:0,Content:-5,EDM:0,RT:19,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,AC
        TION:release,TS:9
X-CID-INFO: VERSION:1.1.32,REQID:30d706e5-2215-47f0-ba78-3b214e0a0653,IP:10,UR
        L:0,TC:0,Content:-5,EDM:0,RT:19,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:9
X-CID-META: VersionHash:5f78ec9,CLOUDID:14b15960-c89d-4129-91cb-8ebfae4653fc,B
        ulkID:2311221523287WIPHSL6,BulkQuantity:4,Recheck:0,SF:64|66|24|17|19|44|1
        02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,COL
        :0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-UUID: a7243eea2bb4484da5eecc3a6a940782-20231122
X-User: chentao@kylinos.cn
Received: from [172.21.13.26] [(116.128.244.171)] by mailgw
        (envelope-from <chentao@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 188473119; Wed, 22 Nov 2023 17:04:50 +0800
Message-ID: <37452b03-9c24-42a7-bb4f-ed19f622f0ef@kylinos.cn>
Date:   Wed, 22 Nov 2023 17:04:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ipv6: Correct/silence an endian warning in
 ip6_multipath_l3_keys
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, jkbs@redhat.com,
        kunwu.chan@hotmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231122071924.8302-1-chentao@kylinos.cn>
 <ZV2sWSRzZhy4klrq@infradead.org>
From:   Kunwu Chan <chentao@kylinos.cn>
In-Reply-To: <ZV2sWSRzZhy4klrq@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,
Thanks for your reply.
I also can't guarantee that it's the right thing to do. Just wanted to 
dispel this warning. If you have any better way, please let me know.


On 2023/11/22 15:23, Christoph Hellwig wrote:
> On Wed, Nov 22, 2023 at 03:19:24PM +0800, Kunwu Chan wrote:
>> net/ipv6/route.c:2332:39: warning: incorrect type in assignment (different base types)
>> net/ipv6/route.c:2332:39:    expected unsigned int [usertype] flow_label
>> net/ipv6/route.c:2332:39:    got restricted __be32
> 
> Can you expain why you think the __force cast is the correct thing to do
> here?
