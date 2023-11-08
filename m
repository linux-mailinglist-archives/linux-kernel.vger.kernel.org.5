Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6E897E534B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 11:27:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235492AbjKHK16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 05:27:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233518AbjKHK14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 05:27:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71AD31BD5
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 02:27:54 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3C87C433C7;
        Wed,  8 Nov 2023 10:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699439274;
        bh=jPTCkhBc7PI9MxQBx8eZ6M1FUClONYHAJL7rPOuMKIk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ldiga5qq8VhgdAX6zRPKPVR6J7ovztl6429iDYp8512IacCZgszC+ILd6dOXkfo4v
         t5wfjDd6YBQ5ilv5qwESULiVtvxrBQx176CSYiN6i1sPaJghieI3M1eeMMRoOefqCf
         O+iz2Q5HsPYzw7wCoieoHfeS8i/uuey40FGqT5Ey7fkiqKOKjRh5pmaEjsK+LSN2jS
         Parqy+HpitkBCXQIP3xBPG8ypHcAfcQTw+ngWwR4YeRpkN+yzFew1je/X4E1KyDSU7
         YcEeIiRAgSItLvqJJ6VNflmLmL2IsTXZ/VPvh9vwMZ30c0Fipa9GWEnTB2JFYnZQ19
         sZXk8l/GMb4gg==
Date:   Wed, 8 Nov 2023 19:27:41 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     <j.granados@samsung.com>
Cc:     Joel Granados via B4 Relay 
        <devnull+j.granados.samsung.com@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>, willy@infradead.org,
        josh@joshtriplett.org, Kees Cook <keescook@chromium.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Iurii Zaikin <yzaikin@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <jstultz@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Petr Mladek <pmladek@suse.com>,
        John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Balbir Singh <bsingharora@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH 08/10] kprobes: Remove the now superfluous sentinel
 elements from ctl_table array
Message-Id: <20231108192741.72a341b73270d3c04d6dbc51@kernel.org>
In-Reply-To: <20231107-jag-sysctl_remove_empty_elem_kernel-v1-8-e4ce1388dfa0@samsung.com>
References: <20231107-jag-sysctl_remove_empty_elem_kernel-v1-0-e4ce1388dfa0@samsung.com>
        <20231107-jag-sysctl_remove_empty_elem_kernel-v1-8-e4ce1388dfa0@samsung.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Nov 2023 14:45:08 +0100
Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel.org> wrote:

> From: Joel Granados <j.granados@samsung.com>
> 
> This commit comes at the tail end of a greater effort to remove the
> empty elements at the end of the ctl_table arrays (sentinels) which
> will reduce the overall build time size of the kernel and run time
> memory bloat by ~64 bytes per sentinel (further information Link :
> https://lore.kernel.org/all/ZO5Yx5JFogGi%2FcBo@bombadil.infradead.org/)
> 
> Remove sentinel element from kprobe_sysclts

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,

> 
> Signed-off-by: Joel Granados <j.granados@samsung.com>
> ---
>  kernel/kprobes.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 0c6185aefaef..d049b602dd41 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -968,7 +968,6 @@ static struct ctl_table kprobe_sysctls[] = {
>  		.extra1		= SYSCTL_ZERO,
>  		.extra2		= SYSCTL_ONE,
>  	},
> -	{}
>  };
>  
>  static void __init kprobe_sysctls_init(void)
> 
> -- 
> 2.30.2
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
