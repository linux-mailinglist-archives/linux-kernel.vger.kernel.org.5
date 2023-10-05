Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95A397BAAB3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 21:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbjJETvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 15:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjJETu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 15:50:59 -0400
X-Greylist: delayed 1698 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 05 Oct 2023 12:50:58 PDT
Received: from stargate.chelsio.com (stargate.chelsio.com [12.32.117.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89CC1CE;
        Thu,  5 Oct 2023 12:50:58 -0700 (PDT)
Received: from [10.193.177.155] (bharat.asicdesigners.com [10.193.177.155] (may be forged))
        by stargate.chelsio.com (8.14.7/8.14.7) with ESMTP id 395JLrPX007891;
        Thu, 5 Oct 2023 12:21:55 -0700
Message-ID: <6a750af0-1de2-3bec-3d52-a4007f3afe92@chelsio.com>
Date:   Fri, 6 Oct 2023 01:58:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 0/5] chelsio: Annotate structs with __counted_by
Content-Language: en-US
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Raju Rangoju <Raju.Rangoju@amd.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-hardening@vger.kernel.org, sourabh.sagar@chelsio.com,
        bharat@chelsio.com
References: <20230929181042.work.990-kees@kernel.org>
 <202309291240.BC52203CB@keescook> <20231002113148.2d6f578b@kernel.org>
From:   Ayush Sawal <ayush.sawal@chelsio.com>
In-Reply-To: <20231002113148.2d6f578b@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/3/2023 12:01 AM, Jakub Kicinski wrote:
> On Fri, 29 Sep 2023 12:44:45 -0700 Kees Cook wrote:
>> On Fri, Sep 29, 2023 at 11:11:44AM -0700, Kees Cook wrote:
>>> Hi,
>>>
>>> This annotates several chelsio structures with the coming __counted_by
>>> attribute for bounds checking of flexible arrays at run-time. For more details,
>>> see commit dd06e72e68bc ("Compiler Attributes: Add __counted_by macro").
>>>
>>> Thanks!
>>>
>>> -Kees
>>>
>>> Kees Cook (5):
>>>    chelsio/l2t: Annotate struct l2t_data with __counted_by
>>>    cxgb4: Annotate struct clip_tbl with __counted_by
>>>    cxgb4: Annotate struct cxgb4_tc_u32_table with __counted_by
>>>    cxgb4: Annotate struct sched_table with __counted_by
>>>    cxgb4: Annotate struct smt_data with __counted_by
>>>
>>>   drivers/net/ethernet/chelsio/cxgb3/l2t.h                | 2 +-
>>>   drivers/net/ethernet/chelsio/cxgb4/clip_tbl.h           | 2 +-
>>>   drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_u32_parse.h | 2 +-
>>>   drivers/net/ethernet/chelsio/cxgb4/l2t.c                | 2 +-
>>>   drivers/net/ethernet/chelsio/cxgb4/sched.h              | 2 +-
>>>   drivers/net/ethernet/chelsio/cxgb4/smt.h                | 2 +-
>>>   6 files changed, 6 insertions(+), 6 deletions(-)
>> Hm, it looks like this is not "Supported" any more? I'm getting bounces
>> from "Raju Rangoju <rajur@chelsio.com>" ...
>>
>> CXGB4 ETHERNET DRIVER (CXGB4)
>> M:      Raju Rangoju <rajur@chelsio.com>
>> L:      netdev@vger.kernel.org
>> S:      Supported
>> W:      http://www.chelsio.com
>> F:      drivers/net/ethernet/chelsio/cxgb4/
> Hi Ayush,
>
> any idea who should be maintaining the Ethernet part of cxgb4
> at this point?

Hi Jakub,

  The current maintainer for cxgb4 driver is Sourabh Sagar 
<sourabh.sagar@chelsio.com>, I have added him in the CC.
  He will update the MAINTAINERS file for cxgb4 driver.

  Thanks,
  Ayush

