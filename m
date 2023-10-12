Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D18D7C69A5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 11:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235545AbjJLJ2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 05:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235373AbjJLJ2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 05:28:41 -0400
Received: from out-190.mta1.migadu.com (out-190.mta1.migadu.com [IPv6:2001:41d0:203:375::be])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD83FBA
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 02:28:39 -0700 (PDT)
Message-ID: <e7a4f40f-9989-5c1e-bc6a-41606837d49c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1697102917;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w+ZbiEKpKR/7IxtLp0s4sFhIE2lb5aqqkwzkmrZpvEk=;
        b=ubV27hWnZTTjqrXaHxG3aEtMO+m3O0kZ/+VmufEJ0CJrzJ42r4bV49IOELKyM/FLxAOXsT
        eHISFxZ6AEbGforatfopFagl5KX6XOLIUjSl2961O7yOSMLcQbQ1t65ekzkktm6kTwUVx0
        kqMjA7nbmvwCu55EzQxkS3EvjxObxCU=
Date:   Thu, 12 Oct 2023 17:28:31 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v3] memblock: don't run loop in memblock_add_range() twice
Content-Language: en-US
To:     Mike Rapoport <rppt@kernel.org>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20231003163045.191184-1-yajun.deng@linux.dev>
 <20231005051959.GC3303@kernel.org>
 <df623d80-befb-09e0-04eb-3c93ecfa9f2e@linux.dev>
 <20231012092442.GR3303@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yajun Deng <yajun.deng@linux.dev>
In-Reply-To: <20231012092442.GR3303@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/10/12 17:24, Mike Rapoport wrote:
> On Thu, Oct 05, 2023 at 11:20:19PM +0800, Yajun Deng wrote:
>> On 2023/10/5 13:19, Mike Rapoport wrote:
>>
>>> I don't see this micro-optimization is worth the churn and potential bugs.
>>> NAK.
>> There are many handouts that tell people it needs to run twice in
>> memblock_add_range().
>>
>> I think it's time to change this. I'm trying to tell people that running
>> twice is unnecessary.
> It might be unnecessary, but it's still simpler than the solutions you
> proposed. And, again, removing the second loop is not worth the churn and
> potential bugs.
>   


Okay, I got it. Thanks.

