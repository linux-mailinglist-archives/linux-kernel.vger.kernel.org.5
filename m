Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8D17EF3BB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 14:33:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbjKQNdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 08:33:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKQNdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 08:33:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14173D56
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 05:33:36 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2016DC433C7;
        Fri, 17 Nov 2023 13:33:34 +0000 (UTC)
Date:   Fri, 17 Nov 2023 08:33:31 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Geliang Tang <geliang.tang@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] samples: Replace strlcpy() with strscpy()
Message-ID: <20231117083331.06f49852@rorschach.local.home>
In-Reply-To: <20231116191510.work.550-kees@kernel.org>
References: <20231116191510.work.550-kees@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Nov 2023 11:15:10 -0800
Kees Cook <keescook@chromium.org> wrote:

> diff --git a/samples/trace_events/trace-events-sample.h b/samples/trace_events/trace-events-sample.h
> index 1c6b843b8c4e..23f923ccd529 100644
> --- a/samples/trace_events/trace-events-sample.h
> +++ b/samples/trace_events/trace-events-sample.h
> @@ -305,7 +305,7 @@ TRACE_EVENT(foo_bar,
>  	),
>  
>  	TP_fast_assign(
> -		strlcpy(__entry->foo, foo, 10);
> +		strscpy(__entry->foo, foo, 10);
>  		__entry->bar	= bar;
>  		memcpy(__get_dynamic_array(list), lst,
>  		       __length_of(lst) * sizeof(int));

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve
