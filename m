Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0527530B2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 06:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234394AbjGNEu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 00:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232340AbjGNEu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 00:50:26 -0400
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4344726B3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 21:50:24 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VnKIG.z_1689310219;
Received: from 30.221.157.198(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VnKIG.z_1689310219)
          by smtp.aliyun-inc.com;
          Fri, 14 Jul 2023 12:50:20 +0800
Message-ID: <82251dbb-6fb2-63a5-d15b-ba68ec75b4b2@linux.alibaba.com>
Date:   Fri, 14 Jul 2023 12:50:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH] erofs: deprecate superblock checksum feature
Content-Language: en-US
To:     Gao Xiang <hsiangkao@linux.alibaba.com>, chao@kernel.org,
        huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, pratikshinde320@gmail.com
References: <20230714033832.111740-1-jefflexu@linux.alibaba.com>
 <8a896983-ec76-d705-b4af-b34ffe529a81@linux.alibaba.com>
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <8a896983-ec76-d705-b4af-b34ffe529a81@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/14/23 12:29 PM, Gao Xiang wrote:
> 
> 
> On 2023/7/14 11:38, Jingbo Xu wrote:
>> Later we're going to introduce fs-verity based verification for the
>> whole image.  Make the superblock checksum feature deprecated.
> 
> I'd suggest that
> 
> 
> "Later we're going to try the self-contained image verification.
>  The current superblock checksum feature has quite limited
>  functionality, instead, merkle trees can provide better protection
>  for image integrity.
> 
>  Since the superblock checksum is a compatible feature, just
>  deprecate now. "
>  

Yeah, another concern is that xxhash is used in the following xattr name
filter feature [1] which is on the way.  It may be redundant to use two
hashing algorithms for one filesystem.


[1]
https://lore.kernel.org/all/20230714031034.53210-1-jefflexu@linux.alibaba.com/

-- 
Thanks,
Jingbo
