Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C44B37E82F4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 20:44:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345605AbjKJTeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 14:34:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235926AbjKJTdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 14:33:45 -0500
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC3AD8250
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 23:01:13 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0Vw3f-CZ_1699599668;
Received: from 30.97.48.251(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vw3f-CZ_1699599668)
          by smtp.aliyun-inc.com;
          Fri, 10 Nov 2023 15:01:09 +0800
Message-ID: <c674a55d-a7b7-74bf-f843-61b8cd9df3a8@linux.alibaba.com>
Date:   Fri, 10 Nov 2023 15:01:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v2] erofs: simplify erofs_read_inode()
To:     Ferry Meng <mengferry@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <20231109111822.17944-1-mengferry@linux.alibaba.com>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20231109111822.17944-1-mengferry@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-13.2 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/11/9 19:18, Ferry Meng wrote:
> After commit 1c7f49a76773 ("erofs: tidy up EROFS on-disk naming"),
> there is a unique `union erofs_inode_i_u` so that we could parse
> the union directly.
> 
> Besides, it also replaces `inode->i_sb` with `sb` for simplicity.
> 
> Signed-off-by: Ferry Meng <mengferry@linux.alibaba.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang
