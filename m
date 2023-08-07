Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF102773303
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 00:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbjHGWhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 18:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbjHGWh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 18:37:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B87103
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 15:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=7MAW/3EfF5Hikjt7D2ZtLMqhK/NhvZUefz87+Np/xqI=; b=wAxpqVpx92QhWOELCzLdT3Vu15
        gbjKf6BxCTgbXgzUZi1zt2EVvrNzrIOcxduYudUyRh2aWAkN0AHgSEGtEHHORb9heaobhzAvA0lXP
        gGSTOy46jVQmaajPSFmB97YUC6VfuPm+hGY2O/8aklTf9GYHOAfXvrNwzN/zSbcKnR/uUFFCGZxVK
        I13TXcUcoeXkqnjr2jdsIxlZlh0Vwu0GCCUHJz41qxP4SnqSEZpuB5wjUiPKG/ZOTUf0v9AUVHMXw
        qNFg4zthlpzGJ2ZpF5yyWflK3I+8jQ1lYU0Lmv3wFFnfXas0NpYoe0RE0MFaov0LQtR2PsFG2YUeX
        PoT8nemw==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qT8qg-00101z-1y;
        Mon, 07 Aug 2023 22:37:14 +0000
Message-ID: <a0bde410-a688-fac0-f3d5-2d4261bcd5b5@infradead.org>
Date:   Mon, 7 Aug 2023 15:37:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 2/2] hexdump: add a new dump prefix
 DUMP_PREFIX_ADDRESS_LOW16
Content-Language: en-US
To:     thunder.leizhen@huaweicloud.com, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org
Cc:     Zhen Lei <thunder.leizhen@huawei.com>
References: <20230805072116.1260-1-thunder.leizhen@huaweicloud.com>
 <20230805072116.1260-3-thunder.leizhen@huaweicloud.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230805072116.1260-3-thunder.leizhen@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/5/23 00:21, thunder.leizhen@huaweicloud.com wrote:
> From: Zhen Lei <thunder.leizhen@huawei.com>
> 
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>


Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Thanks.

> ---
>  include/linux/printk.h | 1 +
>  lib/hexdump.c          | 4 ++++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/include/linux/printk.h b/include/linux/printk.h
> index 8ef499ab3c1ed2e..ccad9e8eaaf0c31 100644
> --- a/include/linux/printk.h
> +++ b/include/linux/printk.h
> @@ -704,6 +704,7 @@ extern const struct file_operations kmsg_fops;
>  enum {
>  	DUMP_PREFIX_NONE,
>  	DUMP_PREFIX_ADDRESS,
> +	DUMP_PREFIX_ADDRESS_LOW16,
>  	DUMP_PREFIX_OFFSET
>  };
>  extern int hex_dump_to_buffer(const void *buf, size_t len, int rowsize,
> diff --git a/lib/hexdump.c b/lib/hexdump.c
> index 86cb4cc3eec485a..eb33e477bc96df1 100644
> --- a/lib/hexdump.c
> +++ b/lib/hexdump.c
> @@ -290,6 +290,10 @@ void print_hex_dump(const char *level, const char *prefix_str, int prefix_type,
>  			printk("%s%s%p: %s\n",
>  			       level, prefix_str, ptr + i, linebuf);
>  			break;
> +		case DUMP_PREFIX_ADDRESS_LOW16:
> +			printk("%s%s%04lx: %s\n", level,
> +			       prefix_str, 0xffff & (unsigned long)(ptr + i), linebuf);
> +			break;
>  		case DUMP_PREFIX_OFFSET:
>  			printk("%s%s%0*x: %s\n", level, prefix_str, width, i, linebuf);
>  			break;

-- 
~Randy
