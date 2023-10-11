Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB87B7C5EF1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 23:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233569AbjJKVP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 17:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233525AbjJKVPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 17:15:23 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0378790
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 14:15:21 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9ada2e6e75fso45547466b.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 14:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697058919; x=1697663719; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hJF0NDc8Mcux/Il97ezd+yJcINMhCT6dKRS+JP02R0E=;
        b=O13ydFKnoys4C4MLCb60GIRjJOjMRezTEHfgHl4HJ9vG7EGbufHrc7FneCbtZbWlyR
         jbws4iqu5CpJJ9Co2JfnDnOAWt6cINVTnu1MFY/zr85F3hiznVvpo0ra8aWtvc6Aku/S
         LwPAbD+rWLgF/+g+VlmnauwGk7qpReZfb4/VA0nirUHT6isnkNYMb26H1UWCrm/TIKsr
         L5EIVEupfQu/ePAac7d76bruK0M6/2KLIGIEf9gHc2+qdiN3SBwxQ6w5knRfshI19ZQU
         UsBGY0kur4JG2l2QdENOocFUoo35iyL6oTSl/eBb1JyC45QedImNAOKEbIodx3FQeNCZ
         oJoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697058919; x=1697663719;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hJF0NDc8Mcux/Il97ezd+yJcINMhCT6dKRS+JP02R0E=;
        b=Ri00tBC59ZApAS6ZXSvzcMDA16jZMYNhhXypuQWw9cezHB5MeTB6ejcsOhwtVH8tzW
         +kz36j2SQ9jNhaqXBujYJENAxxcC4orvisiX9Ql82lGkhFTUwg6dzF+mCYPBXz1q8itP
         RrhaeX5y/rYcnOL/+ZEHbf+/csJbGKRjJwuOLQdTg0cGHsBMj7UlhoA1+B+tnt50LLVw
         mtWvL+SHG32riS9//esbe9/9tt/AeldUDGByGTnFFd6r3maF/0t1w91LDYZRfbumT4yD
         fE/l0i6VK/H7/kpDNEr/7dfkm3nI747zIZi9qCTLTmlrrBl2JU0LqH5w+G1iGzlPdfsD
         SYOg==
X-Gm-Message-State: AOJu0Yy0pjKNi1W96j6wjNkIrt7hsuh7hWHT81bhUUungvtnF3BiDsNU
        dKPgEGq5yOU/O5IIbJ+Woz8=
X-Google-Smtp-Source: AGHT+IFQIhFCes/MJqKpqWGhUmxgj+ptMtSiHpOT2ZrlMt17PClrTLYBBhOgNkGz76CBJbpU/kjfJA==
X-Received: by 2002:a17:906:18b2:b0:9b2:b992:160f with SMTP id c18-20020a17090618b200b009b2b992160fmr17028101ejf.42.1697058919177;
        Wed, 11 Oct 2023 14:15:19 -0700 (PDT)
Received: from gmail.com (1F2EF405.nat.pool.telekom.hu. [31.46.244.5])
        by smtp.gmail.com with ESMTPSA id re9-20020a170906d8c900b0099b8234a9fesm10213540ejb.1.2023.10.11.14.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 14:15:18 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 11 Oct 2023 23:15:16 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     yang.yang29@zte.com.cn
Cc:     surenb@google.com, peterz@infradead.org, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
        mingo@redhat.com
Subject: Re: [PATCH linux-next v3 2/4] sched/psi: Avoid update triggers and
 rtpoll_total when it is unnecessary
Message-ID: <ZScQZLTssSfq19Jm@gmail.com>
References: <ZST/WggW4hSVs9d4@gmail.com>
 <202310101641075436843@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202310101641075436843@zte.com.cn>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* yang.yang29@zte.com.cn <yang.yang29@zte.com.cn> wrote:

> From: Yang Yang <yang.yang29@zte.com.cn>
> 
> When psimon wakes up and there are no state changes for rtpoll_states,
> it's unnecessary to update triggers and rtpoll_total because the pressures
> being monitored by user had not changed.
> This will help to slightly reduce unnecessary computations of psi.
> 
> Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
> Cc: Zhang Yunkai <zhang.yunkai@zte.com.cn>
> Cc: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> ---
>  kernel/sched/psi.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> index be853f227e40..143f8eb34f9d 100644
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -704,11 +704,12 @@ static void psi_rtpoll_work(struct psi_group *group)
>  	}
> 
>  	if (now >= group->rtpoll_next_update) {
> -		update_triggers(group, now, &update_total, PSI_POLL);
>  		group->rtpoll_next_update = now + group->rtpoll_min_period;
> -		if (update_total)
> +		if (changed_states & group->rtpoll_states) {
> +			update_triggers(group, now, &update_total, PSI_POLL);
>  			memcpy(group->rtpoll_total, group->total[PSI_POLL],
>  				   sizeof(group->rtpoll_total));
> +		}

Yeah, so I believe we may have been talking past each other for past 
versions of this patch: why is this patch modifying the order of the 
modification to group->rtpoll_next_update?

It should do the below sequence, nothing more - see the patch attached 
below. This is basically a combination of patches #2 and #3.

And then the final patch removes the now superfluous 'update_total' 
parameter, which is always true.

Here are the commits I applied to tip:sched/core:

  e03dc9fa0663 sched/psi: Change update_triggers() to a 'void' function
  ...
  80cc1d1d5ee3 sched/psi: Avoid updating PSI triggers and ->rtpoll_total when there are no state changes
  3657680f38cd sched/psi: Delete the 'update_total' function parameter from update_triggers()

I rewrote the changelogs for readability.

Thanks,

	Ingo

===================>
From: Yang Yang <yang.yang29@zte.com.cn>
Date: Tue, 10 Oct 2023 16:41:07 +0800
Subject: [PATCH] sched/psi: Avoid updating PSI triggers and ->rtpoll_total when there are no state changes

When psimon wakes up and there are no state changes for ->rtpoll_states,
it's unnecessary to update triggers and ->rtpoll_total because the pressures
being monitored by the user have not changed.

This will help to slightly reduce unnecessary computations of PSI.

[ mingo: Changelog updates ]

Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Peter Ziljstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/202310101641075436843@zte.com.cn
---
 kernel/sched/psi.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index be853f227e40..79f8db0c6150 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -704,11 +704,12 @@ static void psi_rtpoll_work(struct psi_group *group)
 	}
 
 	if (now >= group->rtpoll_next_update) {
-		update_triggers(group, now, &update_total, PSI_POLL);
-		group->rtpoll_next_update = now + group->rtpoll_min_period;
-		if (update_total)
+		if (changed_states & group->rtpoll_states) {
+			update_triggers(group, now, &update_total, PSI_POLL);
 			memcpy(group->rtpoll_total, group->total[PSI_POLL],
 				   sizeof(group->rtpoll_total));
+		}
+		group->rtpoll_next_update = now + group->rtpoll_min_period;
 	}
 
 	psi_schedule_rtpoll_work(group,
