Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 441EA755C0E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 08:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjGQGqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 02:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjGQGqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 02:46:02 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A281B6;
        Sun, 16 Jul 2023 23:46:00 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4R4CGD0NhYzLnrV;
        Mon, 17 Jul 2023 14:43:32 +0800 (CST)
Received: from [10.174.151.185] (10.174.151.185) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 17 Jul 2023 14:45:56 +0800
Subject: Re: linux-next: build failure after merge of the cgroup tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>, Tejun Heo <tj@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
CC:     Josh Don <joshdon@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20230717113457.527d7483@canb.auug.org.au>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <d9d7faf1-8add-e3f3-75ac-64c7069c4ec8@huawei.com>
Date:   Mon, 17 Jul 2023 14:45:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20230717113457.527d7483@canb.auug.org.au>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/7/17 9:34, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the cgroup tree, today's linux-next build (arm
> multi_v7_defconfig) failed like this:
> 
> kernel/cgroup/cgroup.c: In function 'cgroup_local_stat_show':
> kernel/cgroup/cgroup.c:3699:15: error: implicit declaration of function 'cgroup_tryget_css'; did you mean 'cgroup_tryget'? [-Werror=implicit-function-declaration]
>  3699 |         css = cgroup_tryget_css(cgrp, ss);
>       |               ^~~~~~~~~~~~~~~~~
>       |               cgroup_tryget
> kernel/cgroup/cgroup.c:3699:13: warning: assignment to 'struct cgroup_subsys_state *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
>  3699 |         css = cgroup_tryget_css(cgrp, ss);
>       |             ^
> 
> Caused by commit
> 
>   d1d4ff5d11a5 ("cgroup: put cgroup_tryget_css() inside CONFIG_CGROUP_SCHED")
> 
> interacting with commit
> 
>   677ea015f231 ("sched: add throttled time stat for throttled children")
> 
> from the tip tree.
> 
> I have reverted commit d1d4ff5d11a5 for today.

677ea015f231 ("sched: add throttled time stat for throttled children") use the cgroup_tryget_css again. So I will
re-clean the relevant codes later.

Thanks all.

