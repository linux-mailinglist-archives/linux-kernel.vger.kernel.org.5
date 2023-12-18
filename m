Return-Path: <linux-kernel+bounces-2917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D29E881643A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 03:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C1DB1C20CB0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 02:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26F323A7;
	Mon, 18 Dec 2023 02:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="Q42p60Rn"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F44020E6
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 02:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2cc7087c6c4so4828851fa.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 18:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1702864827; x=1703469627; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YTpv7YoKKoT23nETYSezOT1AFCoo447JfaozaqzS3bc=;
        b=Q42p60Rn4HGfX2wyDy36gyT0Q0qJV7fD//4yHj6GsbJTmGZhjc1FL7pGfNHN8GzAX8
         3fCnFBZqCdqW5GETLHbIi7rHwJdG6gLH1X1smWYtQOcYGdyiksZe0ah/Jnj+zo36D76Y
         rteSZoWYf0WdHhebz/FavcNRRBz3ls+EatgZk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702864827; x=1703469627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YTpv7YoKKoT23nETYSezOT1AFCoo447JfaozaqzS3bc=;
        b=i7ztwGBY5AqZ/smDSRTTbYdCV0HveIA/714n2PtwoN96RhcBvdxP4JGaRPvQMLH9H5
         Rt4MIj5OpGbISU9mzDIfafQlSusP1Lvkg+Qq14R+dCamLFk3km26dgB6wwGHtUDZpGck
         z7xArnBAMkSddd5qVlIuydgk33XCF2D1x298MFUuMQ5PDkBSzIkzrG8CucFDRSWQ+lj6
         zZQsqZ2IEJHODh8iCz6R1XpvessZtT+tyWJAdQmEtlntOvXGueJvx+9rUp8Hr47Me1Zu
         Re0jqWiaxAxDyVpWZgFis3QpDPjEmyhQe/Mei7kj/UX1RBkRZL0gPKcpGeyXYzG64lW4
         7gPg==
X-Gm-Message-State: AOJu0Yx9QndjN9mQsUhjq16HMSi/LmgeQzJHOLxFla7DZoJx/vh3QETr
	t5PeyoxZQWpxKBENqCcXzQGahAJObZdZvGRHIoBuVQ==
X-Google-Smtp-Source: AGHT+IH5xTtYNkhC/MIuueV2S7MYenEkwrSg8kiU2nm4gYQ0Y9FKlr1JQgpfsaID/zMtrOzJrCusMydhFyXo4ZaEzcA=
X-Received: by 2002:a2e:9989:0:b0:2cc:60dc:42bb with SMTP id
 w9-20020a2e9989000000b002cc60dc42bbmr971453lji.68.1702864827297; Sun, 17 Dec
 2023 18:00:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231211015717.1067822-1-joel@joelfernandes.org> <ZX4T4E02hbsgnGBY@localhost.localdomain>
In-Reply-To: <ZX4T4E02hbsgnGBY@localhost.localdomain>
From: Joel Fernandes <joel@joelfernandes.org>
Date: Sun, 17 Dec 2023 21:00:15 -0500
Message-ID: <CAEXW_YQK_ct=kMKSO6XnW1NpSjSAVMiMevL-om_i-au9mpUEyw@mail.gmail.com>
Subject: Re: [PATCH v2] srcu: Improve comments about acceleration leak
To: Frederic Weisbecker <frederic@kernel.org>
Cc: linux-kernel@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Josh Triplett <josh@joshtriplett.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Neeraj Upadhyay <neeraj.iitr10@gmail.com>, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 16, 2023 at 4:17=E2=80=AFPM Frederic Weisbecker <frederic@kerne=
l.org> wrote:
>
> Le Mon, Dec 11, 2023 at 01:57:16AM +0000, Joel Fernandes (Google) a =C3=
=A9crit :
> > The comments added in commit 1ef990c4b36b ("srcu: No need to
> > advance/accelerate if no callback enqueued") are a bit confusing to me.
>
> I know some maintainers who may argue that in the changelog world, the fi=
rst
> person doesn't exist :-)

Heh, that's fair. Ok I can drop the 'to me'. ;-)

>
> > The comments are describing a scenario for code that was moved and is
> > no longer the way it was (snapshot after advancing). Improve the code
> > comments to reflect this and also document by acceleration can never
>
> s/by/why

Ok.

> > fail.
> >
> > Cc: Frederic Weisbecker <frederic@kernel.org>
> > Cc: Neeraj Upadhyay <neeraj.iitr10@gmail.com>
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > ---
> > v1->v2: Fix typo in change log.
> >
> >  kernel/rcu/srcutree.c | 24 ++++++++++++++++++++----
> >  1 file changed, 20 insertions(+), 4 deletions(-)
> >
> > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > index 0351a4e83529..051e149490d1 100644
> > --- a/kernel/rcu/srcutree.c
> > +++ b/kernel/rcu/srcutree.c
> > @@ -1234,11 +1234,20 @@ static unsigned long srcu_gp_start_if_needed(st=
ruct srcu_struct *ssp,
> >       if (rhp)
> >               rcu_segcblist_enqueue(&sdp->srcu_cblist, rhp);
> >       /*
> > -      * The snapshot for acceleration must be taken _before_ the read =
of the
> > -      * current gp sequence used for advancing, otherwise advancing ma=
y fail
> > -      * and acceleration may then fail too.
> > +      * It's crucial to capture the snapshot 's' for acceleration befo=
re
> > +      * reading the current gp_seq that is used for advancing. This is
> > +      * essential because if the acceleration snapshot is taken after =
a
> > +      * failed advancement attempt, there's a risk that a grace period=
 may
> > +      * conclude and a new one may start in the interim. If the snapsh=
ot is
> > +      * captured after this sequence of events, the acceleration snaps=
hot 's'
> > +      * could be excessively advanced, leading to acceleration failure=
.
> > +      * In such a scenario, an 'acceleration leak' can occur, where ne=
w
> > +      * callbacks become indefinitely stuck in the RCU_NEXT_TAIL segme=
nt.
> > +      * Also note that encountering advancing failures is a normal
> > +      * occurrence when the grace period for RCU_WAIT_TAIL is in progr=
ess.
> >        *
> > -      * This could happen if:
> > +      * To see this, consider the following events which occur if
> > +      * rcu_seq_snap() were to be called after advance:
> >        *
> >        *  1) The RCU_WAIT_TAIL segment has callbacks (gp_num =3D X + 4)=
 and the
> >        *     RCU_NEXT_READY_TAIL also has callbacks (gp_num =3D X + 8).
> > @@ -1264,6 +1273,13 @@ static unsigned long srcu_gp_start_if_needed(str=
uct srcu_struct *ssp,
> >       if (rhp) {
> >               rcu_segcblist_advance(&sdp->srcu_cblist,
> >                                     rcu_seq_current(&ssp->srcu_sup->src=
u_gp_seq));
> > +             /*
> > +              * Acceleration can never fail because the state of gp_se=
q used
> > +              * for advancing is <=3D the state of gp_seq used for
> > +              * acceleration.
>
> What do you mean by "state" here?

State means "value at a certain point in time" here.

> If it's the gp_seq number, that doesn't look right.

Uff, I screwed up the comment. I swapped "acceleration" and
"advancing". I should say:

"Acceleration can never fail because the state of gp_seq value used
for acceleration is <=3D the state of gp_seq used for advancing."

Does that sound correct now?

> The situation raising the initial bug also involved a gp_seq used for adv=
ancing <=3D the gp_seq used for acceleration.

Right, which I understand is the bug.

thanks,

 - Joel

