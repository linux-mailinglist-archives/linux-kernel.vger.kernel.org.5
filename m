Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA8397FBB0D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 14:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344971AbjK1NOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 08:14:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344975AbjK1NOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 08:14:31 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B0DA10DC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 05:14:37 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-50bba1dd05fso886275e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 05:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701177276; x=1701782076; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D3lzwLwPre7wvnqsdFYx09a6rbeV9XRoBcce+xZPKf0=;
        b=RNTpJRNcNnEb5YFU00RErkxk3Q938Q0YMiV1OCgISy7pscuhklxpap21xy+bca9FuX
         EufNZX45lM5ALVc3We2A//Qhxc3tdyo1A+oQdrpJnJb6dMFAX3h8y2RGSAdLkhlEFZm8
         IZGENb7cXFoWZS/4ZIB6c6WQt6Uk5HsspDVuM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701177276; x=1701782076;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D3lzwLwPre7wvnqsdFYx09a6rbeV9XRoBcce+xZPKf0=;
        b=blVl8FoJMwatdmNRUE8AibJ7expNfgFMWFVeZdTfiabuwc4SJyyWHx79PTdoiJVM54
         +flNOl2m56YXgXWwpqKSTeXizDo4vpGBPLTvym8l4J60kF1VeJgHngHm4+VVoOWDTsbK
         9Jrb1sQlNGEU0PGf1JYBUoQQNT4LIKVyq6aPM9Sy4s70zhggo8224BXGHe9Jnz4EIRSY
         ShyqtsXR8+bvsFprimE8B/CysbCqjA1DqieMydT9jEV5S00MhpLMN3s3k088X1e8RCxw
         2xJ17oXxtIObnNkK5NnRDsGjY2cquGgktkRi1wp1dy32SWm8kA5ladMgSxLFtb9TjH0V
         Tjjg==
X-Gm-Message-State: AOJu0Yw73xR1sD4mk8Au67OAZ7x+h5+lwRFVkrtrUaq4lGRpkut6Che4
        7X0ZY8xtARPIijNvRsaPh4Kxdw==
X-Google-Smtp-Source: AGHT+IE0Vi+lZpGWrs8F+Q6TthkcHLrt1LW8Dss/9F153YJg4v3hb9ZeesPR9HQID+L/IE0mA2CkQQ==
X-Received: by 2002:ac2:5619:0:b0:507:9f51:acee with SMTP id v25-20020ac25619000000b005079f51aceemr9291885lfd.22.1701177275725;
        Tue, 28 Nov 2023 05:14:35 -0800 (PST)
Received: from google.com ([83.142.187.84])
        by smtp.gmail.com with ESMTPSA id k9-20020ac24f09000000b0050ba6e480fdsm1352362lfr.248.2023.11.28.05.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 05:14:35 -0800 (PST)
Date:   Tue, 28 Nov 2023 14:14:29 +0100
From:   Dmytro Maluka <dmaluka@chromium.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Sean Paul <seanpaul@chromium.org>,
        Arun Easi <aeasi@marvell.com>, Daniel Wagner <dwagner@suse.de>
Subject: Re: [RFC][PATCH] tracing: Allow creating instances with specified
 system events
Message-ID: <ZWXntcHNflkbrxd7@google.com>
References: <20231127174108.3c331c9c@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127174108.3c331c9c@gandalf.local.home>
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 05:41:08PM -0500, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> A trace instance may only need to enable specific events. As the eventfs
> directory of an instance currently creates all events which adds overhead,
> allow internal instances to be created with just the events in systems
> that they care about. This currently only deals with systems and not
> individual events, but this should bring down the overhead of creating
> instances for specific use cases quite bit.
> 
> The qla2xxx instance could just enable the systems it cares about, but that
> should be a separate patch.
> 
> Note that kprobes and synthetic events created after the creation of these
> instances, will be added to these instances, but those that are created
> before the creation of the instance will not be included.

This limitation will cause (unrelated) events created by modules that
are insmoded after creating the instance to be also added to the
instance. Why not filter those as well?

Besides that, the change looks nice to me.

> Note, this may also be useful for creating instances in the eventfs, but
> I'm not sure how to do this there. I could add a deliminator:
> 
>   mkdir /sys/kernel/tracing/instances/foo::sched,timer
> 
> But if a tool already uses "::" as a deliminator, then this will break it.
> I could just have it work if all the events after the deliminator exist.
> 
>   Thoughts?
> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  drivers/scsi/qla2xxx/qla_os.c       |  2 +-
>  include/linux/trace.h               |  4 ++--
>  kernel/trace/trace.c                | 22 ++++++++++++--------
>  kernel/trace/trace.h                |  3 ++-
>  kernel/trace/trace_boot.c           |  2 +-
>  kernel/trace/trace_events.c         | 31 ++++++++++++++++++++++++++---
>  samples/ftrace/sample-trace-array.c |  2 +-
>  7 files changed, 49 insertions(+), 17 deletions(-)
