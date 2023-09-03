Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB373790A56
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 02:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235347AbjICAKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 20:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235314AbjICAKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 20:10:31 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD6CCDD
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 17:10:26 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2bcc14ea414so3819951fa.0
        for <linux-kernel@vger.kernel.org>; Sat, 02 Sep 2023 17:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1693699825; x=1694304625; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yFEmQ5kXTPv/inXJCJuXQh0sse6fWjwxLcH/69wCU2A=;
        b=IUHnMsKXpm4QaSfCpBNqbxRDoBTIMO97y6O1fzgbn/pVC2LZXHubpkm//jv/VNGAU5
         YgypOa5B7JhnZZoaBjftg2WzNigsJgsqPrZ5CafQETTk2hP4JLASoK/02897aWNGk6L/
         KyWIhbuzYdoLy0BZ4duXQ82Kq4L4XSikaWEpo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693699825; x=1694304625;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yFEmQ5kXTPv/inXJCJuXQh0sse6fWjwxLcH/69wCU2A=;
        b=iPuAgVN/cW2BsSld23Iff2jmTCUHlytNAb1gVyLw/ajkQLWkKhiEd9ykaNeFWEbgU1
         tcxLoOPayHutf6VAEHzVJhkVJYBpTSLnl6owql+eg31C0ihyqOGojCjOhKRFqwqZahi/
         Pyc9bwBZD+rSDnprKSAEMGjqjJmj1KkSiiLgL6no++aNoHFnfOBTeOpcyV8LnPeDd0oG
         +b/pQQpcInfL8SnFPqoQlIChmyWknkC72GIaSN5JV1GsmBjFp+evoylJly1RObACS4fJ
         d2DKGUiaePXv7Ta9f/Pnp83KwT6jgXlA83vK7mkkIJcLbZbcLUxlYuemPaQ3u0wDxKgU
         4rZQ==
X-Gm-Message-State: AOJu0Yy2pClQhVswEdz8LY7Tfy7w1nrdSsW4sr+gYWuqCzCU7xvoQ/ci
        RbJ9pBBDQPqWvb0dwfi1b6e7A/ekJyrfXc5ZghWIbQ==
X-Google-Smtp-Source: AGHT+IEOmuXCm8JpDX8x7VbtsPFVgZ7bN6WpGy/rT/Z2VfD1BjviniJqmhx1rCmQUt8GoNIA+FU0izXJWXZQzp2AfUs=
X-Received: by 2002:a2e:95d7:0:b0:2bc:e330:660b with SMTP id
 y23-20020a2e95d7000000b002bce330660bmr4401290ljh.9.1693699825007; Sat, 02 Sep
 2023 17:10:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230831012257.1189964-1-joel@joelfernandes.org>
 <b292cca4-d451-4371-ae2e-9417e0079e84@paulmck-laptop> <CAEXW_YRa0Gd2Gt8LagAyOp_8VwT+ra3N4+DBquUNn_Xmo8o7eg@mail.gmail.com>
 <7bd77573-ded1-432e-8008-4c1cbe1b9eb9@paulmck-laptop> <CAEXW_YTzP90zs8z4UFC52fd_KMkpBba6ujBNnDM5Z6exskJ6tg@mail.gmail.com>
 <e0977773-de90-42bb-a67d-dc16d24764a3@paulmck-laptop>
In-Reply-To: <e0977773-de90-42bb-a67d-dc16d24764a3@paulmck-laptop>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Sat, 2 Sep 2023 20:10:13 -0400
Message-ID: <CAEXW_YSukJ_SSvy731iF9WZ5N9cycHsfzdz+8MKA4Va+1+FW4A@mail.gmail.com>
Subject: Re: [PATCH] rcu/torture: Improve badness extraction from console logs
To:     paulmck@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Shuah Khan <shuah@kernel.org>, rcu@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 2, 2023 at 3:24=E2=80=AFPM Paul E. McKenney <paulmck@kernel.org=
> wrote:
>
[...]
> > > Either way, what I don't want is many megabytes of splats from consol=
e.log
> > > duplicated into console.log.diags, especially in those (admittedly sa=
d)
> > > cases where the console.log file is the largest file in the results
> > > directory.  Are you really going to be reading carefully after (say)
> > > the fifth splat?  ;-)
> >
> > I could limit it to just the first 5, with the existing unlimited
> > summary at the top.
>
> How about limiting the existing summary to (say) 10 lines?  I do not
> recall every caring about more than that.  The only reason that I did
> not ever limit it myself is that the summary is unlikely to be more than
> a few percent of the full console.log.
>
> > Let me know if that works or does not work for you. :-)
>
> I do believe that we might be converging.  ;-)

Ok, so 10 lines of summary (similar to existing), and 10 detailed
splats below that :-).  If that's not Ok, let me know. Otherwise I
will send the new patch soon. Thanks!

 - Joel
