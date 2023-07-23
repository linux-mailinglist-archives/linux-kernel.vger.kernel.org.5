Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA2DB75E2D2
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 17:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjGWPNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 11:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbjGWPNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 11:13:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 513BBFE;
        Sun, 23 Jul 2023 08:13:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C570B60DB7;
        Sun, 23 Jul 2023 15:13:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A88A4C433C9;
        Sun, 23 Jul 2023 15:13:18 +0000 (UTC)
Date:   Sun, 23 Jul 2023 11:13:16 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     sunran001@208suo.com
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] napi: remove spaces after '('
Message-ID: <20230723111317.7aadddc0@gandalf.local.home>
In-Reply-To: <f9128b6d2307a4a53904930cae864dcc@208suo.com>
References: <20230719032953.18679-1-xujianghui@cdjrlc.com>
        <f9128b6d2307a4a53904930cae864dcc@208suo.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jul 2023 14:50:11 +0800
sunran001@208suo.com wrote:

> Fix four occurrences of the checkpatch error:
> 
> ERROR: space prohibited after that open parenthesis '('
> 
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>   include/trace/events/napi.h | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/include/trace/events/napi.h b/include/trace/events/napi.h
> index 6678cf8b235b..98fb9e0d2219 100644
> --- a/include/trace/events/napi.h
> +++ b/include/trace/events/napi.h
> @@ -18,10 +18,10 @@ TRACE_EVENT(napi_poll,
>   	TP_ARGS(napi, work, budget),
> 
>   	TP_STRUCT__entry(
> -		__field(	struct napi_struct *,	napi)
> -		__string(	dev_name, napi->dev ? napi->dev->name : NO_DEV)
> -		__field(	int,			work)
> -		__field(	int,			budget)
> +		__field(struct napi_struct *, napi)
> +		__string(dev_name, napi->dev ? napi->dev->name : NO_DEV)
> +		__field(int, work)
> +		__field(int, budget)


NACK!

Which version looks better?

checkpatch.pl fails horribly on TRACE_EVENT macros. DON'T MODIFY THEM!

-- Steve


>   	),
> 
>   	TP_fast_assign(

