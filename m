Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED57A7B3175
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 13:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232958AbjI2LdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 07:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjI2LdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 07:33:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C4A94;
        Fri, 29 Sep 2023 04:33:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE011C433C7;
        Fri, 29 Sep 2023 11:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695987183;
        bh=ext+jvw1wYtQkqXLamyev8P69HV+CW6d/4Z5KiCqMTg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QEOxmNpBXq8nrAg8/RoyOmmBLqY0ECrXlK6QkmYCZPBFdtNUj8vjAtiqhRLxiz6Hv
         +vtzZReLChWzpZpzsH3MEOYzv3i9Gq29+Zs+wZH/WyKkc5xfUH1QAT0pIUu+oRDnxK
         bOR12gEBo4TZfB80OzxrLCWjJ/HioOBE5nJHrKOiiV1pPV1NstVEgy8n1L1PFoKQuQ
         p+xqKgpCAS5ldtY+89v9MFKEoFjhw5v0vU/ZV3fCfNxPa36nBRuSw7XOjA96/UoHld
         2teBaiOJKqJ///DhEn4CpukRShl+iar2k1IcSg+9kbFMuh0ZC7gmsb29F5LsvFIIgB
         JFgBkXWy9jQzg==
Date:   Fri, 29 Sep 2023 20:32:59 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        kernel-janitors@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing/eprobe: drop unneeded breaks
Message-Id: <20230929203259.74d4ba263b3455172ef37f06@kernel.org>
In-Reply-To: <20230928104334.41215-1-Julia.Lawall@inria.fr>
References: <20230928104334.41215-1-Julia.Lawall@inria.fr>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Sep 2023 12:43:34 +0200
Julia Lawall <Julia.Lawall@inria.fr> wrote:

> Drop break after return.
> 

Good catch! This looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

And

Fixes: 7491e2c44278 ("tracing: Add a probe that attaches to trace events")

> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> 
> ---
>  kernel/trace/trace_eprobe.c |    5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
> index 72714cbf475c..03c851f57969 100644
> --- a/kernel/trace/trace_eprobe.c
> +++ b/kernel/trace/trace_eprobe.c
> @@ -788,12 +788,9 @@ find_and_get_event(const char *system, const char *event_name)
>  		name = trace_event_name(tp_event);
>  		if (!name || strcmp(event_name, name))
>  			continue;
> -		if (!trace_event_try_get_ref(tp_event)) {
> +		if (!trace_event_try_get_ref(tp_event))
>  			return NULL;
> -			break;
> -		}
>  		return tp_event;
> -		break;
>  	}
>  	return NULL;
>  }
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
