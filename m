Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2837568DD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 18:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbjGQQRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 12:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjGQQQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 12:16:58 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A632BB9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 09:16:55 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R571e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VneLyKX_1689610607;
Received: from 30.25.237.231(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VneLyKX_1689610607)
          by smtp.aliyun-inc.com;
          Tue, 18 Jul 2023 00:16:51 +0800
Message-ID: <548cb723-6bce-4360-75f3-b4ec822bbf2c@linux.alibaba.com>
Date:   Tue, 18 Jul 2023 00:16:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v2] erofs: deprecate superblock checksum feature
To:     Jingbo Xu <jefflexu@linux.alibaba.com>, chao@kernel.org,
        huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org
References: <20230717112703.60130-1-jefflexu@linux.alibaba.com>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230717112703.60130-1-jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/7/17 19:27, Jingbo Xu wrote:
> Later we're going to try the self-contained image verification.
> The current superblock checksum feature has quite limited
> functionality, instead, merkle trees can provide better protection
> for image integrity.
> 
> xxhash is also used in the following xattr name filter feature.  It is
> redundant for one filesystem to rely on two hashing algorithms at the
> same time.
> 
> Since the superblock checksum is a compatible feature, just deprecate
> it now.
> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>

I tend to agree on this since it slightly impacts mount time too:

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang
