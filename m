Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2CB7AD72B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 13:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbjIYLoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 07:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjIYLob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 07:44:31 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC3259F;
        Mon, 25 Sep 2023 04:44:24 -0700 (PDT)
Received: from dggpeml500012.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RvLXf0ww1zNngh;
        Mon, 25 Sep 2023 19:40:34 +0800 (CST)
Received: from [10.67.110.218] (10.67.110.218) by
 dggpeml500012.china.huawei.com (7.185.36.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 25 Sep 2023 19:44:22 +0800
Message-ID: <a1ae1bc0-0677-8284-9f18-1171e1dcb175@huawei.com>
Date:   Mon, 25 Sep 2023 19:44:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] tracing: document buffer_size_kb more precisely
Content-Language: en-US
To:     Christian Loehle <christian.loehle@arm.com>, <rostedt@goodmis.org>,
        <mhiramat@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
References: <cee6d5cd-e15b-3bb1-f867-de467d96d6b5@arm.com>
From:   Zheng Yejian <zhengyejian1@huawei.com>
In-Reply-To: <cee6d5cd-e15b-3bb1-f867-de467d96d6b5@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.218]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500012.china.huawei.com (7.185.36.15)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/9/25 18:02, Christian Loehle wrote:
> buffer_size_kb no longer shows the requested amount, but the one that
> is actually used internally for the ring buffer.
> 
> commit 6d98a0f2ac3c ("tracing: Set actual size after ring buffer resize")
> changed the sysfs behavior such that value read will always show the
> actual size, while previously it showed the size that was requested
> through the sysfs interface, even if it was rounded up to fulfill
> the request.
> So the documentation can state that more precisely now.
> 
> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> ---
>   Documentation/trace/ftrace.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
> index 23572f6697c0..2e066b3b6edc 100644
> --- a/Documentation/trace/ftrace.rst
> +++ b/Documentation/trace/ftrace.rst
> @@ -191,7 +191,7 @@ of ftrace. Here is a list of some of the key files:
>   	A few extra pages may be allocated to accommodate buffer management
>   	meta-data. If the last page allocated has room for more bytes
>   	than requested, the rest of the page will be used,
> -	making the actual allocation bigger than requested or shown.
> +	making the actual allocation bigger than requested.

Hi, the actual allocation should still be bigger than shown due to the
loss of accuracy when doing unit conversion from bytes to kilobytes (see
tracing_entries_read()).

--

Thanks,
Zheng Yejian

>   	( Note, the size may not be a multiple of the page size
>   	due to buffer management meta-data. )
>   

