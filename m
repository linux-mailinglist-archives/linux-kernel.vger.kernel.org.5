Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 344EB804445
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 02:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376273AbjLEBuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 20:50:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjLEBun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 20:50:43 -0500
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11129B4
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 17:50:49 -0800 (PST)
Message-ID: <d639b4e3-e12a-47e8-9b03-2398b076fdbf@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1701741047;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x/Ql7aByCzkyBc9Mo8qY8s+MUwFzsPU9axcZHcBsgXs=;
        b=Pb2P/HzLMJzVbCdffBXxcdJdG9S7trwdBJy1DwyDetgijIeDOp0EKX4qwHSAHo3Xpp8wRo
        GWTsFZfR51AQiOhLC0xCB/oubGrLShfD7e3bDPVRP3LZsmt16BTCXQT9uNW1svgfpKEe2q
        NVhoS5bQPHPnP1VRmXL6BCGRWQ6bhOE=
Date:   Tue, 5 Dec 2023 09:50:39 +0800
MIME-Version: 1.0
Subject: Re: [PATCH for-next v7 0/7] On-Demand Paging on SoftRoCE
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Cc:     linux-rdma@vger.kernel.org, leon@kernel.org, zyjzyj2000@gmail.com,
        linux-kernel@vger.kernel.org, rpearsonhpe@gmail.com,
        yangx.jy@fujitsu.com, lizhijian@fujitsu.com, y-goto@fujitsu.com
References: <cover.1699503619.git.matsuda-daisuke@fujitsu.com>
 <20231205001139.GA2772824@nvidia.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20231205001139.GA2772824@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2023/12/5 8:11, Jason Gunthorpe 写道:
> On Thu, Nov 09, 2023 at 02:44:45PM +0900, Daisuke Matsuda wrote:
>>
>> Daisuke Matsuda (7):
>>    RDMA/rxe: Always defer tasks on responder and completer to workqueue
>>    RDMA/rxe: Make MR functions accessible from other rxe source code
>>    RDMA/rxe: Move resp_states definition to rxe_verbs.h
>>    RDMA/rxe: Add page invalidation support
>>    RDMA/rxe: Allow registering MRs for On-Demand Paging
>>    RDMA/rxe: Add support for Send/Recv/Write/Read with ODP
>>    RDMA/rxe: Add support for the traditional Atomic operations with ODP
> 
> What is the current situation with rxe? I don't recall seeing the bugs
> that were reported get fixed?

Exactly. A problem is reported in the link 
https://www.spinics.net/lists/linux-rdma/msg120947.html

It seems that a variable 'entry' set but not used 
[-Wunused-but-set-variable]

And ODP is an important feature. Should we suggest to add a test case 
about this ODP in rdma-core to verify this ODP feature?

Zhu Yanjun

> 
> I'm reluctant to dig a deeper hold until it is done?
> 
> Thanks,
> Jason

