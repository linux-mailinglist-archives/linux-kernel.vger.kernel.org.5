Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7010A78E3C7
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 02:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344899AbjHaAMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 20:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345041AbjHaAMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 20:12:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70320CD2;
        Wed, 30 Aug 2023 17:12:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 13ABDB8212A;
        Thu, 31 Aug 2023 00:12:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AB14C433CA;
        Thu, 31 Aug 2023 00:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693440749;
        bh=LKbULXMgbDL2vsGKUpqOR2SUqLelDscSHdr1xJHh9eY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QmHiD/tSJMM9tTtxOzVchxvZwWdFBIKtOPcTkggQioP3qsbL+oO11ThCw5gkNOv45
         MJMEy6vpM7dZ+WeXJmBMHlkGq60PYQdkVjTIDQjM1ZxfP3vLZaYYkX905H91MrZvIs
         5J3e7XV56ZvF03u+9EhiIccUapNg2AWIRFYXYUKsi11s4jvS0Qbe4TFCbf/0H7ik4k
         GocemrLAnCFYsl5MtJESdHaRp+vOnx+qVo8paU5hkQdatneqBpCszQJLQ7z0nXWKhT
         uMfAeLr9rf6RcWUutYPQt0wf7bmWIrRR4/ZdJWEnTqoj/7FG/7SmBsKQMpA34AsNZK
         C/AwNYWmtU9xw==
Date:   Thu, 31 Aug 2023 09:12:23 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Ross Zwisler <zwisler@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ross Zwisler <zwisler@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-media@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: Re: [PATCH] visl: use canonical ftrace path
Message-Id: <20230831091223.40252af58605862f9ef5726b@kernel.org>
In-Reply-To: <20230829204600.3210276-2-zwisler@kernel.org>
References: <20230829204600.3210276-2-zwisler@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks!

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
> -- 
> 2.42.0.rc2.253.gd59a3bf2b4-goog
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
