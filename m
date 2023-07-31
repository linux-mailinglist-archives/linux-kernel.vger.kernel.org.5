Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6224D76A3E7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 00:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbjGaWIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 18:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbjGaWIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 18:08:02 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5711EA8
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 15:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=S+i7P9n7bLqkeAaOMvWDCEyDanyoELdbLjXybKQwPIs=; b=CVahlpJWQdztGAidN7G4KPfTzx
        iC2zpIOWoSBprIH1WUbUp+1fAqyN7zqN71uNhrTFoJAdYhkGbFoSTOyTg9lkfMx1ojmkfDPNfY67m
        XzeQrQ+AbwFGbJr44dqtaRNBL9usFtoYYqzp9pPSZWsOz7xMLZ5Rg4pxX6oCNqkLII8aUwF0B8axT
        7E13UWAzrM3K2Cj9dt1aQxFXCb9ekDhqmdeyZKnLTiKs++NEDQDr54xRNEJYP9sP5Y+MA6MEqFL0z
        BPc71YFwgfrFW6CV5Nb4TUFpeEnnRtbZd+uuQG4m8EEcNjmNndqGaNadLAY6/cc0JRtezBJGX2l8g
        5qQbMf2g==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qQb3X-00HTHd-0R;
        Mon, 31 Jul 2023 22:07:59 +0000
Message-ID: <01988cf7-991c-1117-56d0-9172c6f673f8@infradead.org>
Date:   Mon, 31 Jul 2023 15:07:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH -next] stacktrace: remove kernel-doc warnings
Content-Language: en-US
To:     Zhu Wang <wangzhu9@huawei.com>, linux-kernel@vger.kernel.org
References: <20230731113221.215800-1-wangzhu9@huawei.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230731113221.215800-1-wangzhu9@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/31/23 04:32, Zhu Wang wrote:
> Remove kernel-doc warnings:
> 
> kernel/stacktrace.c:138: warning: Function parameter or member 'tsk' not
> described in 'stack_trace_save_tsk'
> kernel/stacktrace.c:138: warning: Excess function parameter 'task'
> description in 'stack_trace_save_tsk'
> 
> Signed-off-by: Zhu Wang <wangzhu9@huawei.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  kernel/stacktrace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/stacktrace.c b/kernel/stacktrace.c
> index 9ed5ce989415..f385f1f54152 100644
> --- a/kernel/stacktrace.c
> +++ b/kernel/stacktrace.c
> @@ -126,7 +126,7 @@ EXPORT_SYMBOL_GPL(stack_trace_save);
>  
>  /**
>   * stack_trace_save_tsk - Save a task stack trace into a storage array
> - * @task:	The task to examine
> + * @tsk:	The task to examine
>   * @store:	Pointer to storage array
>   * @size:	Size of the storage array
>   * @skipnr:	Number of entries to skip at the start of the stack trace

-- 
~Randy
