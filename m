Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E80E27C48F4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 07:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345197AbjJKFCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 01:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjJKFCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 01:02:42 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2195B94
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 22:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=C3fVR7GTlfdUXnLMxvWGevoZsOznQVvCM6R81FX5GEE=; b=1Nf2Nh6ah+dtCnj54GZzsO46mo
        HsgS8YrWoZzNC8lyH/yQvS8RTtlr73cr4VmbkWuBvMbXANSa9JL9NicsbSWAUJSDD4Lbd9VH6XKJG
        dM49rNT/J83vz2s5TvP6T6SN9sDPRJvhSRKgjWWWUKYM6d4HfHLaqEczKT5WiC0D0DsO/RKzdotsV
        TkjyV6qIPMIpfeRObCGrQmm2b8WleDb46L/x1+n/KIh/TPpFTtLdPrpYrjRyCh8oT6zbGbXofvfrC
        xankMVkq+JH4ZWVI5ZjUzAGCh55Sbzfr8EORZnMfVU2hlqJZTddhaRG825zG+SY9R5BlmNWMtsYlb
        5KAsHH8g==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qqRMj-00EntP-2h;
        Wed, 11 Oct 2023 05:02:37 +0000
Message-ID: <5839134f-c430-4a14-8cc4-5c36c30a3891@infradead.org>
Date:   Tue, 10 Oct 2023 22:02:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] stacktrace: remove kernel-doc warnings
Content-Language: en-US
To:     Zhu Wang <wangzhu9@huawei.com>, linux-kernel@vger.kernel.org
References: <20230731113221.215800-1-wangzhu9@huawei.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230731113221.215800-1-wangzhu9@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

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

Please resend your patch and Cc: Andrew Morton on it
so that it can be merged.

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
