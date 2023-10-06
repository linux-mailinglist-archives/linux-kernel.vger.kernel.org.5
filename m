Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A18DE7BC063
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 22:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233511AbjJFUbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 16:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233521AbjJFUbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 16:31:50 -0400
Received: from mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8BBAC5
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 13:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1696624306; bh=Y4jHqWVhg8UVkLv5fZyoADZGkDruWn4t1ImjwzaYqSU=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=o2d03Ah7JurwHjIFIbYZgleEMDCXs4WwJhDHNo5OVGZ/pFQiO3mYDlHqU23bnFPpr
         TGdg/OkROzt8n50zqwiEYkUn+yxfXyOsJ3MXBy33PPbTxzaT6qE6eBU967o3t7RBvR
         ZiwCior4gp1GPZJzndxHL0zrdCGzpH3tgKDkvmqQ=
Received: by b221-1.in.mailobj.net [192.168.90.21] with ESMTP
        via ip-20.mailobj.net [213.182.54.20]
        Fri,  6 Oct 2023 22:31:46 +0200 (CEST)
X-EA-Auth: UClDyyuJLMlcEtduCfdeslkp9xbtqk3b1bqHZBK3wuhDdmOuGG+L9YD7aXBERKrUuooUJCZYmnZ6PsfJkhUW2w==
Date:   Sat, 7 Oct 2023 02:01:43 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     linux-kernel@vger.kernel.org, rostedt@goodmis.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        ivan.orlov0322@gmail.com, skhan@linuxfoundation.org,
        Deepak R Varma <drv@mailo.com>
Subject: Re: [PATCH] tracing: Fix minor typos in samples header
Message-ID: <ZSBur4SMqx/oELp0@runicha.com>
References: <ZQN7HiaghPYu4sAl@runicha.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQN7HiaghPYu4sAl@runicha.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 02:59:08AM +0530, Deepak R Varma wrote:
> Following minor corrections in the comments section of the trace
> events sample header file.
>
>    - There are 6 parts of the TRACE_EVENT macro instead of 5 (name,
>      TP_PROTO, TP_ARGS, TP_STRUCT, TP_fast_assign, TP_printk).
>
>    - The example variable for __field_struct type should be the
>      variable name instead of the variable.
>
>    - Improve closing brace alignment to improve readability.
>
> Signed-off-by: Deepak R Varma <drv@mailo.com>
> ---

Hello,
May I request a feedback/status of this patch proposal?

Thank you,
deepak.

>  samples/trace_events/trace-events-sample.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/samples/trace_events/trace-events-sample.h b/samples/trace_events/trace-events-sample.h
> index 1c6b843b8c4e..551ecad212c8 100644
> --- a/samples/trace_events/trace-events-sample.h
> +++ b/samples/trace_events/trace-events-sample.h
> @@ -61,7 +61,7 @@
>  #include <linux/tracepoint.h>
>
>  /*
> - * The TRACE_EVENT macro is broken up into 5 parts.
> + * The TRACE_EVENT macro is broken up into 6 parts.
>   *
>   * name: name of the trace point. This is also how to enable the tracepoint.
>   *   A function called trace_foo_bar() will be created.
> @@ -93,7 +93,7 @@
>   *
>   *         __field_struct(struct bar, foo)
>   *
> - *         __entry->bar.x = y;
> + *         __entry->foo.x = y;
>
>   *   __array: There are three fields (type, name, size). The type is the
>   *         type of elements in the array, the name is the name of the array.
> @@ -410,7 +410,7 @@ TRACE_EVENT_CONDITION(foo_bar_with_cond,
>
>  	TP_STRUCT__entry(
>  		__string(	foo,    foo		)
> -		__field(	int,	bar			)
> +		__field(	int,	bar		)
>  	),
>
>  	TP_fast_assign(
> --
> 2.39.2
>


