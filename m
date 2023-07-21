Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB99875D6B3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 23:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjGUVki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 17:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjGUVkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 17:40:37 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76BDE3A85
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 14:40:35 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5774335bb2aso28872127b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 14:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1689975634; x=1690580434;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1l7ane1OFS+DsoXNZ3U+AZ4KjgV57iMuNiejIQehSc4=;
        b=FSYL0es3zGYgPSbiIbE7QW63J5pU/Pp1sjBqc2fV7aNAMjPq8/ibss0ZDcKuCz0WIG
         W/pDwheI4n0hlntSOBzbMjuRyUCHn6J1UpZM0i7jacmbpZVhwD+bwXYSZzGaFwphlXxq
         mHOmwpGrQGKTdhU5PkDumCCubMwIFJBn7X46RallzhPKlwFEfXGUV4lHshAGTEFnJPAZ
         7DpFyuDA12HPI8B8H1kFrbriPMQOIB6Fx6+2ImvM21lGje2l0zK5WEF6BdLcO2mfIzUl
         lwkWo19C1XELSkBimTW40s1NN/p5NVBEuw68hDplm+NuuKpleUFzO7ma6Wphsn1x+N4c
         jxPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689975634; x=1690580434;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1l7ane1OFS+DsoXNZ3U+AZ4KjgV57iMuNiejIQehSc4=;
        b=GTvuPWoY2Vq/AmxkMh9VaOWDrJzItwaqB9MvaEAveCXnu9Tn4KrFG77ZmhIcQGwAql
         xfCD/J8JnfuSSqlJ7ZPKMhFFzGaJj+JORdyG2B+UyDUYZnUP4pZx0+Dtttm4EhWpUbqs
         bFg0U3pJXx87fPOn8SgMCN//QEoKQAZCW/U44qy4MIp4K0XF+DkrKEdn7+MXjgh3owji
         zjF2xIOOsPM9M3AVRz1bsshqL13GzejEqfHcMytEEse2MQftHZCxKQdZADhZ3S61ywrG
         sA/66Md+mbgSzjCXxaF5HULwUho8HCwB8wlED+quh7GVS9+e3Kp4MzrTbLGSIVoAUQyy
         +T1w==
X-Gm-Message-State: ABy/qLZU81u+z/Zu4/YL62+whmQNr/wUzFL3IeQwY24k5xXhlgvdD93q
        QN0Os+1sft6BiEQ+C/hkGD9nYl43vtIxGVf1fS4A
X-Google-Smtp-Source: APBJJlE7LB25GxeesqatrOlBcbG6723uMfnR2JDVAgGbF3gS9RIs3WyGqLCBTpgzBVkejDj4mmTAPOgV3lme6IdNwMQ=
X-Received: by 2002:a0d:ddd4:0:b0:577:2cac:cd49 with SMTP id
 g203-20020a0dddd4000000b005772caccd49mr1343753ywe.1.1689975634601; Fri, 21
 Jul 2023 14:40:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230629195535.2590-1-casey@schaufler-ca.com> <20230629195535.2590-3-casey@schaufler-ca.com>
 <9b09c571-9288-73e1-18c5-9023b909a5d9@digikod.net> <b711f8b4-f624-bb2b-1caf-90c674245135@schaufler-ca.com>
In-Reply-To: <b711f8b4-f624-bb2b-1caf-90c674245135@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 21 Jul 2023 17:40:23 -0400
Message-ID: <CAHC9VhRY1_tdLVnFGK4ZxRDEs+JKJWD3VR+iHrcrm9Psmbowtg@mail.gmail.com>
Subject: Re: [PATCH v12 02/11] LSM: Maintain a table of LSM attribute data
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 3:42=E2=80=AFPM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
> On 7/11/2023 8:35 AM, Micka=C3=ABl Sala=C3=BCn wrote:
> > On 29/06/2023 21:55, Casey Schaufler wrote:
> >> As LSMs are registered add their lsm_id pointers to a table.
> >> This will be used later for attribute reporting.
> >>
> >> Determine the number of possible security modules based on
> >> their respective CONFIG options. This allows the number to be
> >> known at build time. This allows data structures and tables
> >> to use the constant.
> >>
> >> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> >> Reviewed-by: Kees Cook <keescook@chromium.org>
> >> Reviewed-by: Serge Hallyn <serge@hallyn.com>
> >> ---
> >>   include/linux/security.h |  2 ++
> >>   security/security.c      | 37 +++++++++++++++++++++++++++++++++++++
> >>   2 files changed, 39 insertions(+)

...

> >> diff --git a/security/security.c b/security/security.c
> >> index e56714ef045a..5a699e47478b 100644
> >> --- a/security/security.c
> >> +++ b/security/security.c
> >> @@ -521,6 +546,18 @@ void __init security_add_hooks(struct
> >> security_hook_list *hooks, int count,
> >>   {
> >>       int i;
> >>   +    /*
> >> +     * A security module may call security_add_hooks() more
> >> +     * than once during initialization, and LSM initialization
> >> +     * is serialized. Landlock is one such case.
> >> +     * Look at the previous entry, if there is one, for duplication.
> >> +     */
> >> +    if (lsm_active_cnt =3D=3D 0 || lsm_idlist[lsm_active_cnt - 1] !=
=3D
> >> lsmid) {
> >
> > Isn't it possible to have interleaved security_add_hooks() calls?
>
> The initialization is serial and interleaving isn't possible.
>
> >> +        if (lsm_active_cnt >=3D LSM_CONFIG_COUNT)
> >> +            panic("%s Too many LSMs registered.\n", __func__);
> >
> > I'm not sure we should panic, but from a security point of view it is
> > critical enough=E2=80=A6
>
> It's possible this should be a BUG() instance, but the panic() more
> closely resembles what's nearby in the code.

I think the panic() call is okay.  If something is so horribly broken
that we hit this case we have little option but to panic the system as
booting with the LSM controls busted in such a way is very not good.

There are probably those that would object to the above statement, but
those people aren't likely to be building a kernel with any LSMs in
the first place.

--=20
paul-moore.com
