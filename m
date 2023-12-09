Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D05A580B106
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 01:32:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574903AbjLIAcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 19:32:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjLIAcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 19:32:43 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3401B1706
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 16:32:50 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-50bf7bc38c0so3023056e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 16:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1702081968; x=1702686768; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yyeQWsRurvy1kSUlcimMxrlcGEVzENPQAsZovUbW9CU=;
        b=fzrp43dWS0xB11xuTfGH8QJvUUnPheNFRpy0eVaHrcdQNfZxrptHGaaVN9JuCOz919
         9GvG8q5ayWMG4l4pMoXlv6MhguHFcfLoVIY7oPFzoWtvnPbfjAIkMtaDa9Yts9KTLbsn
         cWfE9SKvGq47QmXVzZUSGzM+/5ZM65XgxUucy51iVOBk4g0mYjtKzL44U8CtFWIBHXiV
         MmzQP4Z1vaKpPn6dzAYu+Pz0Uj8kQWG5B+CZL2LPAIKMycUMCPVD/o2ZDS8U9JwxfoGT
         tzQrTuT/gqFRymV4A+vyv2hkjG2fBXoWl7byv1thUZvu6K3ERzBX18E8u2KbWH515aIm
         WHAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702081968; x=1702686768;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yyeQWsRurvy1kSUlcimMxrlcGEVzENPQAsZovUbW9CU=;
        b=rxuaqNpo5y/bnw7gijJilq78sij04ET3h04erbijEufbWxbiIDXkZZrLyU60NX4/OT
         Ll3CqSczITaGyR4317ERMaSmiI6iPU9dCrULnfE6q1cJHjQHWxTYnbKerHtputFQBq1Z
         SmlnbxUDgtG895V9uDbgWKkr3MEPdoIsNcyiqphmEmyeXgVt8eRrf6eS8w6NksigDgH2
         8yXHG18m3PDeAgyssyiisvo7UCbD7ejJSXtQ7ZxsAyzd88USeswSjP0366INs/S1yvCw
         Kwzf1T/ZhdIB/Z94dVYlMuTzSBXS6Xzzn25WygaQJ1pItyU6E1oN8trROmoM6yO40Qck
         wYfw==
X-Gm-Message-State: AOJu0YxtQkLQcD9wrV3d0m0tpATSu+nUcd89u67LvUJ9lsj+wSi+Y82R
        nUObKkgzhCKbqLxTuAdCqXxrniWOaxGCUOTFYIUv
X-Google-Smtp-Source: AGHT+IHiU7+GWBiNesjx96WCv+sBFdbAwue/U9alDgwZI6GXgNhi+ti+rnofq0hx08j6xxA56JsHK5GSt9IgRfX/xsk=
X-Received: by 2002:a05:6512:33cc:b0:50b:c467:7ca3 with SMTP id
 d12-20020a05651233cc00b0050bc4677ca3mr364338lfg.22.1702081968383; Fri, 08 Dec
 2023 16:32:48 -0800 (PST)
MIME-Version: 1.0
References: <CAK8ByeK8dGcbxfXghw6=LrhSWLmO0a4XuB8C0nsUc812aoU0Pw@mail.gmail.com>
 <cover.1701993656.git.jim.cromie@gmail.com> <a9030af05886f375beed5f4d75074004fffd896f.1701993656.git.jim.cromie@gmail.com>
In-Reply-To: <a9030af05886f375beed5f4d75074004fffd896f.1701993656.git.jim.cromie@gmail.com>
From:   =?UTF-8?Q?=C5=81ukasz_Bartosik?= <lb@semihalf.com>
Date:   Sat, 9 Dec 2023 01:32:37 +0100
Message-ID: <CAK8ByeLaE1xumns+g6EMYK1weRwBhyEKR8YpYjx4uQqohvPTzg@mail.gmail.com>
Subject: Re: [re: PATCH v2 00/15 - 10/11] dyndbg: move lock,unlock into
 ddebug_change, drop goto
To:     Jim Cromie <jim.cromie@gmail.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        bleung@google.com, contact@emersion.fr, daniel@ffwll.ch,
        dianders@chromium.org, groeck@google.com, jbaron@akamai.com,
        john.ogness@linutronix.de, keescook@chromium.org, pmladek@suse.com,
        ppaalanen@gmail.com, rostedt@goodmis.org, seanpaul@chromium.org,
        sergey.senozhatsky@gmail.com, upstream@semihalf.com,
        vincent.whitchurch@axis.com, yanivt@google.com,
        gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pt., 8 gru 2023 o 01:15 Jim Cromie <jim.cromie@gmail.com> napisa=C5=82(a):
>
> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> ---
>  lib/dynamic_debug.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
>
> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> index fc903e90ea0d..b63429462d69 100644
> --- a/lib/dynamic_debug.c
> +++ b/lib/dynamic_debug.c
> @@ -537,6 +537,8 @@ static int ddebug_change(const struct ddebug_query *q=
uery,
>         struct ddebug_class_map *map =3D NULL;
>         int __outvar valid_class;
>
> +       mutex_lock(&ddebug_lock);
> +
>         /* search for matching ddebugs */
>         list_for_each_entry(dt, &ddebug_tables, link) {
>
> @@ -625,6 +627,7 @@ static int ddebug_change(const struct ddebug_query *q=
uery,
>         if (nfound)
>                 update_tr_default_dst(modifiers);
>
> +       mutex_unlock(&ddebug_lock);
>         return nfound;
>  }
>
> @@ -932,23 +935,17 @@ static int ddebug_exec_query(char *query_string, co=
nst char *modname)
>                 return -EINVAL;
>         }
>
> -       mutex_lock(&ddebug_lock);
> -

I deliberately moved locking here from ddebug_change because
ddebug_parse_flags calls read_T_args (when T flag is present) and this
in turn calls find_tr_instance which uses global bitmap (tr.bmap).
If we add that ddebug_proc_show can be triggered concurrently then it
can lead to trouble.

For example
echo "open usb" > /proc/dynamic_debug/control
echo "module usbcore =3DT:usb" > /proc/dynamic_debug/control   # from one c=
onsole
echo "close usb" > / /proc/dynamic_debug/control
# from another console

and we can end up with an attempt to use closed trace instance"usb"



>         /* check flags 1st (last arg) so query is pairs of spec,val */
>         if (ddebug_parse_flags(words[nwords-1], &modifiers)) {
>                 pr_err("flags parse failed\n");
> -               goto err;
> +               return -EINVAL;
>         }
>
>         /* actually go and implement the change */
>         nfound =3D ddebug_change(&query, &modifiers);
>
> -       mutex_unlock(&ddebug_lock);
>         vpr_info_dq(&query, nfound ? "applied" : "no-match");
>         return nfound;
> -err:
> -       mutex_unlock(&ddebug_lock);
> -       return -EINVAL;
>  }
>
>  /* handle multiple queries in query string, continue on error, return
> --
> 2.43.0
>
