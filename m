Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 665557B7375
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 23:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241264AbjJCVkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 17:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232084AbjJCVkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 17:40:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 721E6A1;
        Tue,  3 Oct 2023 14:40:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F2EDC433C8;
        Tue,  3 Oct 2023 21:40:23 +0000 (UTC)
Date:   Tue, 3 Oct 2023 17:41:29 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ross Zwisler <zwisler@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ross Zwisler <zwisler@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: Re: [PATCH] visl: use canonical ftrace path
Message-ID: <20231003174129.11c79c18@gandalf.local.home>
In-Reply-To: <20230829204600.3210276-2-zwisler@kernel.org>
References: <20230829204600.3210276-2-zwisler@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Could this go through the linux-media tree, or if you give it an Ack, I'll
take it through the tracing tree.

-- Steve


On Tue, 29 Aug 2023 14:46:01 -0600
Ross Zwisler <zwisler@kernel.org> wrote:

> From: Ross Zwisler <zwisler@google.com>
> 
> The canonical location for the tracefs filesystem is at /sys/kernel/tracing.
> 
> But, from Documentation/trace/ftrace.rst:
> 
>   Before 4.1, all ftrace tracing control files were within the debugfs
>   file system, which is typically located at /sys/kernel/debug/tracing.
>   For backward compatibility, when mounting the debugfs file system,
>   the tracefs file system will be automatically mounted at:
> 
>   /sys/kernel/debug/tracing
> 
> Update the visl decoder driver documentation to use this tracefs path.
> 
> Signed-off-by: Ross Zwisler <zwisler@google.com>
> ---
>  Documentation/admin-guide/media/visl.rst | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/admin-guide/media/visl.rst b/Documentation/admin-guide/media/visl.rst
> index 7d2dc78341c9..4328c6c72d30 100644
> --- a/Documentation/admin-guide/media/visl.rst
> +++ b/Documentation/admin-guide/media/visl.rst
> @@ -78,7 +78,7 @@ The trace events are defined on a per-codec basis, e.g.:
>  
>  .. code-block:: bash
>  
> -        $ ls /sys/kernel/debug/tracing/events/ | grep visl
> +        $ ls /sys/kernel/tracing/events/ | grep visl
>          visl_fwht_controls
>          visl_h264_controls
>          visl_hevc_controls
> @@ -90,13 +90,13 @@ For example, in order to dump HEVC SPS data:
>  
>  .. code-block:: bash
>  
> -        $ echo 1 >  /sys/kernel/debug/tracing/events/visl_hevc_controls/v4l2_ctrl_hevc_sps/enable
> +        $ echo 1 >  /sys/kernel/tracing/events/visl_hevc_controls/v4l2_ctrl_hevc_sps/enable
>  
>  The SPS data will be dumped to the trace buffer, i.e.:
>  
>  .. code-block:: bash
>  
> -        $ cat /sys/kernel/debug/tracing/trace
> +        $ cat /sys/kernel/tracing/trace
>          video_parameter_set_id 0
>          seq_parameter_set_id 0
>          pic_width_in_luma_samples 1920

