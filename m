Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2FE7AE6E9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 09:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233528AbjIZHeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 03:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233448AbjIZHeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 03:34:17 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F143DC
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 00:34:11 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RvrxZ46TCzMlrn;
        Tue, 26 Sep 2023 15:30:26 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 26 Sep 2023 15:34:07 +0800
Message-ID: <57ce70f7-2b5d-384d-d14e-b9e96e3ca636@huawei.com>
Date:   Tue, 26 Sep 2023 15:34:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2 0/2] static_call: Fix two wild-memory-access bugs in
 static_call_del_module()
Content-Language: en-US
To:     <peterz@infradead.org>, <tglx@linutronix.de>,
        <rostedt@goodmis.org>, <mingo@kernel.org>, <jpoimboe@kernel.org>,
        <christophe.leroy@csgroup.eu>, <linux-kernel@vger.kernel.org>
References: <20230915123605.3732345-1-ruanjinjie@huawei.com>
From:   Ruan Jinjie <ruanjinjie@huawei.com>
In-Reply-To: <20230915123605.3732345-1-ruanjinjie@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping.

On 2023/9/15 20:36, Jinjie Ruan wrote:
> In __static_call_init(), any one of the kzalloc fails will cause
> wild-memory-access when traverse the site and subsequent sites in
> static_call_del_module().
> 
> Changes in v2:
> - Add a new patch which fix a a similar problem.
> - Update the commit message and simplify error stack for the first.
> 
> Jinjie Ruan (2):
>   static_call: Fix a wild-memory-access bug in static_call_del_module()
>   static_call: Fix a wild-memory-access bug when
>     static_call_key_sites(key) is true
> 
>  kernel/static_call_inline.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
