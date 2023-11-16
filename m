Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D49E7EDB18
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 06:16:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbjKPFQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 00:16:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjKPFQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 00:16:47 -0500
X-Greylist: delayed 7361 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 15 Nov 2023 21:16:43 PST
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E39BEA9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 21:16:43 -0800 (PST)
Message-ID: <9dfbc7ce-49cc-4519-88cf-93d6b72e5ff6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1700111801;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8j/xxx3Ow28uXIiT4hsoM+04dPycL4vVSYm73xYPFAY=;
        b=fV8F4q5t5hh7h24d7bU0o1bWZTS+MOK3/tAqiXgt6+mjZcrfemOPyZm0/LFrj0kBgHBOwO
        WbfkagNrdf2dXoLdRs3vTYLtccXBLcCCn56fMBmJiiA0DxTh35FRzHW4ecXYWhOTL02HwF
        gh6NzQAnUeoOuHAQhyXidtXLYVLM9LU=
Date:   Thu, 16 Nov 2023 00:16:34 -0500
MIME-Version: 1.0
Subject: Re: [PATCH 3/3] bpf: bpf_iter_task_next: use next_task(kit->task)
 rather than next_task(kit->pos)
Content-Language: en-GB
To:     Oleg Nesterov <oleg@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     Chuyi Zhou <zhouchuyi@bytedance.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kui-Feng Lee <kuifeng@fb.com>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
References: <20231114163239.GA903@redhat.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20231114163239.GA903@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/14/23 11:32 AM, Oleg Nesterov wrote:
> This looks more clear and simplifies the code. While at it, remove the
> unnecessary initialization of pos/task at the start of bpf_iter_task_new().
>
> Note that we can even kill kit->task, we can just use pos->group_leader,
> but I don't understand the BUILD_BUG_ON() checks in bpf_iter_task_new().

Let us keep kit->task, which is used in later function
bpf_iter_task_next(). The patch looks good to me.

>
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>

