Return-Path: <linux-kernel+bounces-23878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C28B82B320
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 17:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EA4B28D021
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 16:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672885100A;
	Thu, 11 Jan 2024 16:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="moGfzBYI"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD8D5025B
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 16:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-553e36acfbaso12699a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 08:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704991055; x=1705595855; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MwE+FOqKzVGunuMnPmDZXXe5C3CxxMmG6JOVjSLFx/g=;
        b=moGfzBYI8sDDjSzcn7WYXGirEV0zthDA+dn8iigdIc5O1Co0wM/80e2IqoEPyMw9Yc
         fcxbAhypOaSDpra3HDtI4VlcZekONnNuyRlZhOkuvb7iitJ2G3BlIGaCEBxxzu+Pe0+0
         ZEVMH+oP+9LkNNZLcutMmmcn7xkEspMxoEgm6YhA/hr5BNHRYDGj8TEILDEgFRatFSSH
         eY9KD1ryeBbFEHVMh5grDI29N0/yNMnBM3fUr+Gk2bro/2LTCuoa7LmYZbkUHF4d0cVF
         BuTK/lpC4wpwfIcYvzxSckyZYtWqXIMsGT79lLpQR0MkKtBPGbqzVXKCOBi3G/2odJsB
         SKbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704991055; x=1705595855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MwE+FOqKzVGunuMnPmDZXXe5C3CxxMmG6JOVjSLFx/g=;
        b=Q5FOcXC3+8t1L8Kub7rhitlmiIEZ43Oi2Sc78DWnWllDJnW7ytACUWNG/TZaf5k/U6
         ACCYPB1iXgQkwdp8MeqTj5oi5VstcqYmGkzOUnwMpJe8EqtxveS5iN3WmYQdiTlYIvDR
         g+XbvxuaupojAnYJLskVRYeGOAPRC1Xu1EMTux1cEp2lMfkgAyYL885E+RdTBgtm21lG
         6D6k+NXuiw++Y8+UO9vNvUljDSxe8ENG9/Otav80Y9CiGp7N2m5Cwp1gILCSXqnDwWJj
         QhBweG7+ZqM1PFtsqZSIIaQ/DmINxJVqCWWGgvSnDRuhil0KwTWwTV+izyhWhpOHQlAr
         Z6Sw==
X-Gm-Message-State: AOJu0YxJRsrXldAhyCHgBaqJZK8WOPfpVdLi75bL6d2yYHCXc/Gf3v1G
	c/V2/BGcuPhc7QheYMDEEDzgJ6UOkdgrPwKqoguQ6pn9GfnO
X-Google-Smtp-Source: AGHT+IF5MfhttaDANKxdOPhA5e+P0Nyb3HfIeqx9XHYYXEBWmMiP4gaR0gmQhDCHbxb20Umb6ruNeMQvLY/KoWx6qbw=
X-Received: by 2002:aa7:c506:0:b0:557:3e55:41e3 with SMTP id
 o6-20020aa7c506000000b005573e5541e3mr134398edq.0.1704991054745; Thu, 11 Jan
 2024 08:37:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104162510.72773-1-urezki@gmail.com> <20240104162510.72773-2-urezki@gmail.com>
 <ZZ2bi5iPwXLgjB-f@google.com> <ZZ5htIcrlpxz5AKM@pc636>
In-Reply-To: <ZZ5htIcrlpxz5AKM@pc636>
From: Kalesh Singh <kaleshsingh@google.com>
Date: Thu, 11 Jan 2024 08:37:22 -0800
Message-ID: <CAC_TJvfe52GRrjHMfvAorC+PtTBRK0hxL9OPoi0SMqDV3XkFZw@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] rcu: Reduce synchronize_rcu() latency
To: Uladzislau Rezki <urezki@gmail.com>
Cc: "Paul E . McKenney" <paulmck@kernel.org>, RCU <rcu@vger.kernel.org>, 
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Hillf Danton <hdanton@sina.com>, Joel Fernandes <joel@joelfernandes.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>, Frederic Weisbecker <frederic@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 1:22=E2=80=AFAM Uladzislau Rezki <urezki@gmail.com>=
 wrote:
>
> Hello, Kalesh!
>
> >
> > Hi Uladzislau,
> >
> > I've tried your patches (v3) on Android with 6.1.43 kernel.
> >
> > The test cycles 10 apps (including camera) sequentially for 100
> > iterations.
> >
> > I've set rcu_normal to override the rcu_expedited in the boot
> > parameters:
> >
> > adb shell cat /proc/cmdline | tr ' ' '\n' | grep rcu
> >
> > rcupdate.rcu_normal=3D1
> > rcupdate.rcu_expedited=3D1
> > rcu_nocbs=3D0-7
> >
> >
> > The configurations are:
> >
> > A - echo 0 >/sys/module/rcutree/parameters/rcu_normal_wake_from_gp
> > B - echo 1 >/sys/module/rcutree/parameters/rcu_normal_wake_from_gp
> >
> > Results:
> >
> > =3D APP LAUNCH TIME =3D
> >                                 delta (B-A)    ratio(%)
> >    overall_app_launch_time(ms)    -11399.00       -6.65
> >
> >
> > =3D=3D camera_launch_time
> >       type  delta(B-A %)  A_count  B_count
> >        HOT         -7.05       99       99
> >       COLD         -6.33        1        1
> >
> >

Hi Uladzislau,

> If i interpret it correctly you also see that this series reduces
> a launch time by 6/7% on your app set. Is that correct?

Yes your understanding is correct.

>
> > =3D=3D=3D Function Latencies =3D=3D=3D
> >
> > Tracing synchronize_rcu_expedited.  Hit Ctrl-C to exit                 =
             Tracing synchronize_rcu_expedited.  Hit Ctrl-C to exit
> >
> >      nsec                : count    distribution                       =
                  nsec                : count    distribution
> >          0 -> 1          : 0        |                                  =
      |               0 -> 1          : 0        |                         =
               |
> >          2 -> 3          : 0        |                                  =
      |               2 -> 3          : 0        |                         =
               |
> >          4 -> 7          : 0        |                                  =
      |               4 -> 7          : 0        |                         =
               |
> >          8 -> 15         : 0        |                                  =
      |               8 -> 15         : 0        |                         =
               |
> >         16 -> 31         : 0        |                                  =
      |              16 -> 31         : 0        |                         =
               |
> >         32 -> 63         : 0        |                                  =
      |              32 -> 63         : 0        |                         =
               |
> >         64 -> 127        : 0        |                                  =
      |              64 -> 127        : 0        |                         =
               |
> >        128 -> 255        : 0        |                                  =
      |             128 -> 255        : 0        |                         =
               |
> >        256 -> 511        : 0        |                                  =
      |             256 -> 511        : 0        |                         =
               |
> >        512 -> 1023       : 0        |                                  =
      |             512 -> 1023       : 0        |                         =
               |
> >       1024 -> 2047       : 0        |                                  =
      |            1024 -> 2047       : 0        |                         =
               |
> >       2048 -> 4095       : 0        |                                  =
      |            2048 -> 4095       : 0        |                         =
               |
> >       4096 -> 8191       : 0        |                                  =
      |            4096 -> 8191       : 0        |                         =
               |
> >       8192 -> 16383      : 0        |                                  =
      |            8192 -> 16383      : 0        |                         =
               |
> >      16384 -> 32767      : 0        |                                  =
      |           16384 -> 32767      : 0        |                         =
               |
> >      32768 -> 65535      : 0        |                                  =
      |           32768 -> 65535      : 0        |                         =
               |
> >      65536 -> 131071     : 0        |                                  =
      |           65536 -> 131071     : 0        |                         =
               |
> >     131072 -> 262143     : 0        |                                  =
      |          131072 -> 262143     : 0        |                         =
               |
> >     262144 -> 524287     : 0        |                                  =
      |          262144 -> 524287     : 0        |                         =
               |
> >     524288 -> 1048575    : 0        |                                  =
      |          524288 -> 1048575    : 0        |                         =
               |
> >    1048576 -> 2097151    : 0        |                                  =
      |         1048576 -> 2097151    : 0        |                         =
               |
> >    2097152 -> 4194303    : 0        |                                  =
      |         2097152 -> 4194303    : 0        |                         =
               |
> >    4194304 -> 8388607    : 871      |**                                =
      |         4194304 -> 8388607    : 1180     |****                     =
               |
> >    8388608 -> 16777215   : 3204     |********                          =
      |         8388608 -> 16777215   : 7020     |*************************=
               |
> >   16777216 -> 33554431   : 15013    |**********************************=
******|        16777216 -> 33554431   : 10952    |*************************=
***************|
> > Exiting trace of synchronize_rcu_expedited                             =
             Exiting trace of synchronize_rcu_expedited
> >
> >
> > Tracing synchronize_rcu.  Hit Ctrl-C to exit                           =
             Tracing synchronize_rcu.  Hit Ctrl-C to exit
> >
> >      nsec                : count    distribution                       =
                  nsec                : count    distribution
> >          0 -> 1          : 0        |                                  =
      |               0 -> 1          : 0        |                         =
               |
> >          2 -> 3          : 0        |                                  =
      |               2 -> 3          : 0        |                         =
               |
> >          4 -> 7          : 0        |                                  =
      |               4 -> 7          : 0        |                         =
               |
> >          8 -> 15         : 0        |                                  =
      |               8 -> 15         : 0        |                         =
               |
> >         16 -> 31         : 0        |                                  =
      |              16 -> 31         : 0        |                         =
               |
> >         32 -> 63         : 0        |                                  =
      |              32 -> 63         : 0        |                         =
               |
> >         64 -> 127        : 0        |                                  =
      |              64 -> 127        : 0        |                         =
               |
> >        128 -> 255        : 0        |                                  =
      |             128 -> 255        : 0        |                         =
               |
> >        256 -> 511        : 0        |                                  =
      |             256 -> 511        : 0        |                         =
               |
> >        512 -> 1023       : 0        |                                  =
      |             512 -> 1023       : 0        |                         =
               |
> >       1024 -> 2047       : 0        |                                  =
      |            1024 -> 2047       : 0        |                         =
               |
> >       2048 -> 4095       : 0        |                                  =
      |            2048 -> 4095       : 0        |                         =
               |
> >       4096 -> 8191       : 0        |                                  =
      |            4096 -> 8191       : 0        |                         =
               |
> >       8192 -> 16383      : 0        |                                  =
      |            8192 -> 16383      : 0        |                         =
               |
> >      16384 -> 32767      : 0        |                                  =
      |           16384 -> 32767      : 0        |                         =
               |
> >      32768 -> 65535      : 0        |                                  =
      |           32768 -> 65535      : 0        |                         =
               |
> >      65536 -> 131071     : 0        |                                  =
      |           65536 -> 131071     : 0        |                         =
               |
> >     131072 -> 262143     : 0        |                                  =
      |          131072 -> 262143     : 0        |                         =
               |
> >     262144 -> 524287     : 0        |                                  =
      |          262144 -> 524287     : 0        |                         =
               |
> >     524288 -> 1048575    : 0        |                                  =
      |          524288 -> 1048575    : 0        |                         =
               |
> >    1048576 -> 2097151    : 0        |                                  =
      |         1048576 -> 2097151    : 0        |                         =
               |
> >    2097152 -> 4194303    : 0        |                                  =
      |         2097152 -> 4194303    : 0        |                         =
               |
> >    4194304 -> 8388607    : 861      |**                                =
      |         4194304 -> 8388607    : 1136     |****                     =
               |
> >    8388608 -> 16777215   : 3111     |********                          =
      |         8388608 -> 16777215   : 6320     |************************ =
               |
> >   16777216 -> 33554431   : 13901    |**********************************=
******|        16777216 -> 33554431   : 10484    |*************************=
***************|
> > Exiting trace of synchronize_rcu                                       =
             Exiting trace of synchronize_rcu
> >
> Who is B and who is A?

Left is A (rcu_normal_wake_from_gp=3D0)  and right is B
(rcu_normal_wake_from_gp=3D1)
>
> >
> > Interestingly I tried the same experiment without rcu_normal=3D1 (leavi=
ng rcu_expedited=3D1):
> >
> > adb shell cat /proc/cmdline | tr ' ' '\n' | grep rcu
> > rcupdate.rcu_expedited=3D1
> > rcu_nocbs=3D0-7
> >
> > In this case I also saw the -6 to -7% decrease in the app launch times
> > but I don't have a good explanation why that would be? (The fucntion
> > latency histograms in this case didn't show any significant difference)=
.
> > Do you have any insight why this may happen?
> >
> When rcu_expedited=3D1 is set and rcu_normal=3D0 is disabled. The
> synchronize_rcu() call is converted into synchronize_rcu_expidited():
>
> <snip>
> void synchronize_rcu(void)
> {
>         unsigned long flags;
>         struct rcu_node *rnp;
>
>         RCU_LOCKDEP_WARN(lock_is_held(&rcu_bh_lock_map) ||
>                          lock_is_held(&rcu_lock_map) ||
>                          lock_is_held(&rcu_sched_lock_map),
>                          "Illegal synchronize_rcu() in RCU read-side crit=
ical section");
>         if (!rcu_blocking_is_gp()) {
>                 if (rcu_gp_is_expedited())
>                         synchronize_rcu_expedited();
>                 else
>                         synchronize_rcu_normal();
>                 return;
>         }
> ...
> <snip>
>
> rcu_gp_is_expidited() is true, so invoke "expedited" version.
>
> I see some concerns in preferring an expedited version as a global
> replacement. First of all it is related to latency sensitive workloads
> because in order to expedite a grace period it sends out IPIs on all
> online CPUs to force them to report a quiescent-state asap. I have not
> investigated yet how it affects such workloads.
>
> Therefore, in your case, you also see a performance boost of your app set=
s.

IIUC the patch shouldn't affect the case? The only difference in A vs
B is rcu_normal_wake_from_gp (both have rcu_expedited=3D1).

Thanks,
Kalesh
>
> Thank you for looking at it!
>
> --
> Uladzislau Rezki

