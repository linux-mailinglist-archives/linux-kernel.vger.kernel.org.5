Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1747C75E2D1
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 17:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjGWPNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 11:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjGWPND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 11:13:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173FBAB;
        Sun, 23 Jul 2023 08:13:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A9A2960D56;
        Sun, 23 Jul 2023 15:13:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D25BC433C7;
        Sun, 23 Jul 2023 15:13:00 +0000 (UTC)
Date:   Sun, 23 Jul 2023 11:12:58 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     sunran001@208suo.com
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] include: events: remove spaces after '(' and before ')'
Message-ID: <20230723111258.4e72787a@gandalf.local.home>
In-Reply-To: <7d6b48368594b2f815dff7c5375be638@208suo.com>
References: <20230719030939.18448-1-xujianghui@cdjrlc.com>
        <7d6b48368594b2f815dff7c5375be638@208suo.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jul 2023 11:21:03 +0800
sunran001@208suo.com wrote:

> Fix four occurrences of the checkpatch error:
> 
> ERROR: space prohibited after that open parenthesis '('
> ERROR: space prohibited before that close parenthesis ')'
> 
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>   include/trace/events/nmi.h | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/trace/events/nmi.h b/include/trace/events/nmi.h
> index 18e0411398ba..99abd0bc8ebd 100644
> --- a/include/trace/events/nmi.h
> +++ b/include/trace/events/nmi.h
> @@ -15,9 +15,9 @@ TRACE_EVENT(nmi_handler,
>   	TP_ARGS(handler, delta_ns, handled),
> 
>   	TP_STRUCT__entry(
> -		__field(	void *,		handler	)
> -		__field(	s64,		delta_ns)
> -		__field(	int,		handled	)
> +		__field(void *,	handler)
> +		__field(s64, delta_ns)
> +		__field(int, handled)

NACK!

Which version looks better?

checkpatch.pl fails horribly on TRACE_EVENT macros. DON'T MODIFY THEM!

-- Steve

>   	),
> 
>   	TP_fast_assign(

