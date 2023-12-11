Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A38880D4F0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 19:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345208AbjLKSGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 13:06:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345205AbjLKSGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 13:06:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D6F99
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 10:06:40 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1E92C433C8;
        Mon, 11 Dec 2023 18:06:39 +0000 (UTC)
Date:   Mon, 11 Dec 2023 13:07:19 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v2] ring-buffer: Add offset of events in dump on
 mismatch
Message-ID: <20231211130719.771cb5ed@gandalf.local.home>
In-Reply-To: <20231211130614.43ff4462@gandalf.local.home>
References: <20231211130614.43ff4462@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
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

On Mon, 11 Dec 2023 13:06:14 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

>  
>  		case RINGBUF_TYPE_DATA:
>  			ts += event->time_delta;
> -			pr_warn("  [%lld] delta:%d\n", ts, event->time_delta);
> +			pr_warn(" 0x%x:  [%lld] delta:%d\n",
> +				e, ts, event->time_delta);
>  			break;
>  
>  		default:
>  			break;
>  		}
>  	}
> +	pr_warn("expected end:%ld last event actually ended at:%d\n", tail, e);
>  }
>  

Bah, all offsets were in hex, the above was supposed to be in hex too. I
sent out the wrong version.

Will send a v3 with that update.

-- Steve
