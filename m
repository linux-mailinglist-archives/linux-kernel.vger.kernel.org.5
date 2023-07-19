Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2A9759492
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 13:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbjGSLqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 07:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjGSLqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 07:46:42 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA3EC7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 04:46:41 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-3a44cccbd96so2611184b6e.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 04:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689767200; x=1690372000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ME6otyLxcTnhUs57hhVYleHxnbYJHSX9Ee4yUiOzRs=;
        b=bfDZPCpXqTyGypTiE5WSK/W5YC2YusbvqfdNVKutVox1VgF3bBIrXXjlK2WyrWTd7g
         WI7t3V2QvLCbHynicuksqeo7v9ITu9f5VsD0sqRynSdJ0W37idFUaUNxUKtoTMnbr85l
         nFdLyIKTY8YLnAavRlKBfDc6kGLPoWJBd3AwnlWKO38a3jcB7fmwVivZe+5p4lpTvshe
         LKEXKySsldxZfS323owuZBicyIN10o3zpf++dSv4cgrH2tUUEQvQAs4p6uc8qHP98pqj
         FbCRSPkA4/WFT4J0hn1vIW8v3HblhWJjEw3TGh8gSBO8hoGPWok9nDjY6EKIh53jqMVl
         QArA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689767200; x=1690372000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1ME6otyLxcTnhUs57hhVYleHxnbYJHSX9Ee4yUiOzRs=;
        b=BXzULGjBHdcx35wkcdKJmNkEe4MgQ+NWP/DtqI8uFXu/mB53woZccyqvS4IKBezEO5
         SFjPo6QBUEgURdmfo6w9ZsR9kmzZy7f0hTZq+3V8Qw2dpJfFTyx9GbLdFzFtmWKFCYuj
         tSuIKz6zd/IJzK9GKS3bjdJdXtxTBZE5Y0LWi3B54gjfy3+XHy6VbB5UmMMqmNaq3fVP
         k7JgCs1uKWt6UtelcYTYcv2146sWB59vnxAKzNBmpirxnkmNerH+iT+jyV+zktrOtWR4
         xIEWf4zbElCrpH7sHG+mGyv3b7FabHY9eB0KKvixkbLWkkKomhI/4Pip/6n0CEdYpc71
         9uUA==
X-Gm-Message-State: ABy/qLagyasRStvceAvqdwpzHVN4Q9EDWEYJ8Rhqy8QH8apftjy39zWF
        yfPY2jR7kXFclxaYFOM5Ess5cWrSgj7Hd21LXxs=
X-Google-Smtp-Source: APBJJlH2OUxOQR7ymge5q4j1nZv6AHaffTXi3NSkW/1m6Vb7/Ka+RTR3WwW7m2ZhYHi1dIPWqnYthwJ26HJvskvL0Dg=
X-Received: by 2002:a05:6808:1910:b0:3a1:efe6:13c5 with SMTP id
 bf16-20020a056808191000b003a1efe613c5mr2650975oib.44.1689767200253; Wed, 19
 Jul 2023 04:46:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230713071713.5762-1-xuewen.yan@unisoc.com>
In-Reply-To: <20230713071713.5762-1-xuewen.yan@unisoc.com>
From:   Xuewen Yan <xuewen.yan94@gmail.com>
Date:   Wed, 19 Jul 2023 19:46:29 +0800
Message-ID: <CAB8ipk8JW+Y-SOMXfEo+w5YKPfXjnsM9HPLe+SdCqEAiDMycxQ@mail.gmail.com>
Subject: Re: [PATCH] pid: Add the judgment of whether ns is NULL in the find_pid_ns
To:     Xuewen Yan <xuewen.yan@unisoc.com>
Cc:     brauner@kernel.org, jack@suse.cz, keescook@chromium.org,
        peterz@infradead.org, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, di.shen@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all

Is there any comment about this patch?

Thanks!

On Thu, Jul 13, 2023 at 3:58=E2=80=AFPM Xuewen Yan <xuewen.yan@unisoc.com> =
wrote:
>
> There is no the judgment of whether namspace is NULL in find_pid_ns.
> But there is a corner case when ns is null, for example: if user
> call find_get_pid when current is in exiting, the following stack would
> set thread_id be null:
> release_task
>     __exit_signal(p);
>         __unhash_process(tsk, group_dead);
>               detach_pid(p, PIDTYPE_PID);
>                   __change_pid(task, type, NULL);
>
> If user call find_get_pid at now, in find_vpid function, the
> task_active_pid_ns would return NULL. As a result, it would be
> error when access the ns in find_pid_ns.
>
> So add the judgment of whether ns is NULL in the find_pid_ns to
> prevent this case happen.
>
> Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> ---
>  kernel/pid.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/kernel/pid.c b/kernel/pid.c
> index 6a1d23a11026..d4a9cb6f3eb9 100644
> --- a/kernel/pid.c
> +++ b/kernel/pid.c
> @@ -308,6 +308,9 @@ void disable_pid_allocation(struct pid_namespace *ns)
>
>  struct pid *find_pid_ns(int nr, struct pid_namespace *ns)
>  {
> +       if (!ns)
> +               return NULL;
> +
>         return idr_find(&ns->idr, nr);
>  }
>  EXPORT_SYMBOL_GPL(find_pid_ns);
> --
> 2.25.1
>
