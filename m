Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A32DD7E8B6B
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 16:47:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbjKKPpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 10:45:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbjKKPp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 10:45:28 -0500
X-Greylist: delayed 348 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 11 Nov 2023 07:45:24 PST
Received: from sandeen.net (sandeen.net [63.231.237.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 72B1D3AA6;
        Sat, 11 Nov 2023 07:45:24 -0800 (PST)
Received: from [10.0.0.71] (liberator.sandeen.net [10.0.0.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by sandeen.net (Postfix) with ESMTPSA id 9F63848C731;
        Sat, 11 Nov 2023 09:39:35 -0600 (CST)
DKIM-Filter: OpenDKIM Filter v2.11.0 sandeen.net 9F63848C731
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sandeen.net;
        s=default; t=1699717175;
        bh=j0rUQNp7+k+JUcTe52x69W9xIhdzt2MRqrIL4QneJX0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=OvTVRBMfjxa++uidmOz6iUD7dDnUqru3TTBrtnVHRflOE89DAG3TjMXp8JHKlr2hn
         3Ja+fWmr9J7HRhg3xidXuE7+eI5fgS/eT2eNFThpUyvm5vRprbcu09T6vFR+UsljxH
         3RS5mhT7NyjmaIo78ScT1rslid5BtQ59IH8xaUBL2tIbIhHd3xvOxy8SfO5xWhiKE2
         B6dafLiOsYc4VHzFwLL0Rh8kZf7y0hWocOgpDWqlhpJBdBXZYw6vrjMhHDhxOwb4sy
         991ZbGcJR57ovMq3sDKB77tRr/SJxp1wLvGWVBuKvoxyVmmslFXdBJYnpUhce0fxHC
         2Cl+sI/iJ7Xug==
Message-ID: <b726a650-0568-4972-85cf-ea8858305c3b@sandeen.net>
Date:   Sat, 11 Nov 2023 09:39:34 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xfs: Remove unused function
Content-Language: en-US
To:     "Darrick J. Wong" <djwong@kernel.org>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     Bill O'Donnell <bodonnel@redhat.com>, chandan.babu@oracle.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
References: <20231103073040.649-1-jiapeng.chong@linux.alibaba.com>
 <ZUqPdhc4RQxL8TVB@redhat.com> <20231107204405.GP1205143@frogsfrogsfrogs>
From:   Eric Sandeen <sandeen@sandeen.net>
In-Reply-To: <20231107204405.GP1205143@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/23 2:44 PM, Darrick J. Wong wrote:
> On Tue, Nov 07, 2023 at 01:26:46PM -0600, Bill O'Donnell wrote:
>> On Fri, Nov 03, 2023 at 03:30:40PM +0800, Jiapeng Chong wrote:
>>> The function are defined in the bitmap.c file, but not called
>>> elsewhere, so delete the unused function.
>>>
>>> fs/xfs/scrub/bitmap.c:55:1: warning: unused function 'xbitmap_tree_iter_next'.
>>>
>>> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
>>> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=7137
>>> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
>>
>> Makes sense.
>> Reviewed-by: Bill O'Donnell <bodonnel@redhat.com>
> 
> I disagree -- I added redundant forward declarations here so I wouldn't
> have to go digging through the 150LOC definition of INTERVAL_TREE_DEFINE
> to figure out what helper functions were actually being defined by the
> macro.  They'll trigger compiler errors if the definition of
> INTERVAL_TREE_DEFINE ever drifts away from my understanding of it at the
> time I wrote the code.

And the comment above those declarations say as much, but Jiapeng Chong seems to
be getting a legitimate warning as a result, and AFAICT xbitmap_tree_iter_next
really isn't used in the codebase. Maybe it's worth commenting it out or
#ifdefing it, while leaving it around for reference as you intended?

(I'm sympathetic to the macro-generated function hell, for sure.)

-Eric

> --D
> 
>>
>>
>>> ---
>>>  fs/xfs/scrub/bitmap.c | 4 ----
>>>  1 file changed, 4 deletions(-)
>>>
>>> diff --git a/fs/xfs/scrub/bitmap.c b/fs/xfs/scrub/bitmap.c
>>> index e0c89a9a0ca0..ba4b18e40faa 100644
>>> --- a/fs/xfs/scrub/bitmap.c
>>> +++ b/fs/xfs/scrub/bitmap.c
>>> @@ -48,10 +48,6 @@ static inline struct xbitmap_node *
>>>  xbitmap_tree_iter_first(struct rb_root_cached *root, uint64_t start,
>>>  			uint64_t last);
>>>  
>>> -static inline struct xbitmap_node *
>>> -xbitmap_tree_iter_next(struct xbitmap_node *node, uint64_t start,
>>> -		       uint64_t last);
>>> -
>>>  INTERVAL_TREE_DEFINE(struct xbitmap_node, bn_rbnode, uint64_t,
>>>  		__bn_subtree_last, START, LAST, static inline, xbitmap_tree)
>>>  
>>> -- 
>>> 2.20.1.7.g153144c
>>>
>>
> 

