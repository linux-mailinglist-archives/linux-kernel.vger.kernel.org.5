Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7B0C7BF477
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 09:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442502AbjJJHiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 03:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442506AbjJJHiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 03:38:10 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CEBBBA
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 00:38:07 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40666aa674fso50392135e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 00:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696923485; x=1697528285; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3D2a9Ctr+Q9TJYBiJbcCpXlcV+g7qpk+StQ+UleKGIM=;
        b=FJ62qhy9XySA2f52QkAlOuYWFVuRQeaGz4n6J3aOlajq/r94KBLOs/cindnBu7Y7AP
         XOHpyqdJ2CEMxU8kgISIZdnP3Gb947CgcPTPJHQpyi/0CYJ6ioWcFEKeZgv2AuFeNGKH
         2gY8xC7ujAfvqBevAtqezBqPECujhxuCJ6pBgeKo5zF1rkvjrCgWo7C7JixsVGR/Ua9X
         0WN2P4d6BpfyBhp79PTK9rcNju4wTsccfLwFlsQGGsGUxwn75fXR9Ag4uVZzB29ORh9X
         UERygVYWYTkR6zuY0JETljsmgEdvSBdlaXhW7XTa4nTW0y4ubxgCpgY3Wcz9WkoJekAi
         jDDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696923485; x=1697528285;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3D2a9Ctr+Q9TJYBiJbcCpXlcV+g7qpk+StQ+UleKGIM=;
        b=slQgO0u0+Z76mEP0++GsQffg00Ibtd2tIRSrXPWV8C5BheDwHbpyJ5dCgzNoHNir9F
         ILkwggCrXsIzA413JIIxJS2q1e7MZmzLLFO6koUImhzBYLxuvL6D5o11xnbl0LI2ym45
         sb76OziMgYlgo8lsfa41W5Pz+KHBUM7NCtmQHX01Yq1PEkkb7W1fa7nVtLiL43xLmj0z
         Wy1hq47ierPsHSLwCYP4uOkZvecL04/ru3QD/oKqj2s7h7LELDe0Xbdo8I4ChKk67nVr
         OGKPBES/nj67SmeliX8d2akcVtcD6nhPANyvVuq3eXNleI+0o1YEJsDWrvmJI0feiAeV
         YW7g==
X-Gm-Message-State: AOJu0YxUEEYmKWxkxG+uxqlSLr8Wx/UOdXy6D78dX1PRDYBU+zM4L0yx
        gtR74cPdgVKk/f86RPRJ2uo=
X-Google-Smtp-Source: AGHT+IGx9ZfOqcQgF4Ls/3epQAef1b2EPcF/VtMMh4FBnry8F0fv4/rW4Y468+mNqhFbe+x1xYA6kQ==
X-Received: by 2002:a7b:cc95:0:b0:3fe:f726:4a94 with SMTP id p21-20020a7bcc95000000b003fef7264a94mr15467134wma.14.1696923485080;
        Tue, 10 Oct 2023 00:38:05 -0700 (PDT)
Received: from gmail.com (1F2EF237.nat.pool.telekom.hu. [31.46.242.55])
        by smtp.gmail.com with ESMTPSA id 9-20020a05600c020900b003feea62440bsm13176606wmi.43.2023.10.10.00.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 00:38:04 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Tue, 10 Oct 2023 09:38:02 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     yang.yang29@zte.com.cn
Cc:     surenb@google.com, peterz@infradead.org, hannes@cmpxchg.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org,
        juri.lelli@redhat.com
Subject: Re: [PATCH linux-next v2 1/4] sched/psi: Change update_triggers() to
 a 'void' function
Message-ID: <ZST/WggW4hSVs9d4@gmail.com>
References: <CAJuCfpFabCn8gcuLV322RKC=xzVm0C+64HQP+CkFNJZ4VO42ZA@mail.gmail.com>
 <202310101109350209198@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202310101109350209198@zte.com.cn>
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
> Update_triggers() always returns now + group->rtpoll_min_period, and the
> return value is only used by psi_rtpoll_work(), so change update_triggers()
> to a void function, let group->rtpoll_next_update = now +
> group->rtpoll_min_period directly.
> 
> This will avoid unnecessary function return value passing & simplifies
> the function.
> 
> Suggested-by: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
> ---
>  kernel/sched/psi.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> index 1d0f634725a6..fec8aab096a8 100644
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -434,7 +434,7 @@ static u64 window_update(struct psi_window *win, u64 now, u64 value)
>  	return growth;
>  }
> 
> -static u64 update_triggers(struct psi_group *group, u64 now, bool *update_total,
> +static void update_triggers(struct psi_group *group, u64 now, bool *update_total,
>  						   enum psi_aggregators aggregator)
>  {
>  	struct psi_trigger *t;
> @@ -503,8 +503,6 @@ static u64 update_triggers(struct psi_group *group, u64 now, bool *update_total,
>  		/* Reset threshold breach flag once event got generated */
>  		t->pending_event = false;
>  	}
> -
> -	return now + group->rtpoll_min_period;
>  }
> 
>  static u64 update_averages(struct psi_group *group, u64 now)
> @@ -706,7 +704,8 @@ static void psi_rtpoll_work(struct psi_group *group)
>  	}
> 
>  	if (now >= group->rtpoll_next_update) {
> -		group->rtpoll_next_update = update_triggers(group, now, &update_total, PSI_POLL);
> +		group->rtpoll_next_update = now + group->rtpoll_min_period;
> +		update_triggers(group, now, &update_total, PSI_POLL);

This step is wrong. The equivalent transformation when removing a return value is:

	x = fn(y); // fn(y) returns 'z'

to:

	fn(y);
	x = z;

not:

	x = z;
	fn(y);

...

Furthermore, I already applied the correct #1 patch to the scheduler tree, see:

  e03dc9fa0663 ("sched/psi: Change update_triggers() to a 'void' function")

... which tree is at:

  git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core

So please send the remaining patch on top of that.

Thanks,

	Ingo
