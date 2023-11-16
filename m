Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C14057ED9DF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 04:14:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343654AbjKPDOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 22:14:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjKPDOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 22:14:07 -0500
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [IPv6:2001:41d0:203:375::b2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D6B998
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 19:14:04 -0800 (PST)
Message-ID: <c768aae4-1c41-41ef-895d-33556b99dc15@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1700104441;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LVTbIWjaYj/Zzkxn6Ukw8lgVfPfXoOn5/TENdtMr4GY=;
        b=btCmsGt0X6sFafJDU5gd7nnPc2QMLVpFrf6LWdb3nrmMtMuOSwWpcruiVM5Jy1nXiU7ZwM
        nZtGRfjQ6PE3QXk/UOC/NKm6GGwEq/IsL5w6mIimemiQ3+1FwRl9tA8wuc1rTDoOE28kEw
        YvELle5WYIK2ZVjQhlheSAuVK71UnP8=
Date:   Wed, 15 Nov 2023 22:13:52 -0500
MIME-Version: 1.0
Subject: Re: [PATCH 0/3] bpf: kernel/bpf/task_iter.c: don't abuse
 next_thread()
To:     Oleg Nesterov <oleg@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     Chuyi Zhou <zhouchuyi@bytedance.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kui-Feng Lee <kuifeng@fb.com>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
References: <20231114163211.GA874@redhat.com>
Content-Language: en-GB
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20231114163211.GA874@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/14/23 11:32 AM, Oleg Nesterov wrote:
> Compile tested.
>
> Every lockless usage of next_thread() was wrong, bpf/task_iter.c is
> the last user and is no exception.

It would be great if you can give more information in the commit message
about why the usage of next_thread() is wrong in bpf/task_iter.c.
IIUC, some information is presented in :
   https://lore.kernel.org/all/20230824143112.GA31208@redhat.com/

Also, please add 'bpf' in the subject tag ([PATCH bpf 0/3]) to
make it clear the patch should be applied to bpf tree.

>
> Oleg.
> ---
>
>   kernel/bpf/task_iter.c | 29 +++++++++++------------------
>   1 file changed, 11 insertions(+), 18 deletions(-)
>
