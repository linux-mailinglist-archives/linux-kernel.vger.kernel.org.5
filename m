Return-Path: <linux-kernel+bounces-5244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B904C818869
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 14:13:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 347D6B21B44
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 13:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D151947B;
	Tue, 19 Dec 2023 13:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T57k6Odz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E913D18EAE
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 13:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702991601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=km7B8rqaE4cuU/tTleclsqdvPEhf+k+mxhpbemw2EX0=;
	b=T57k6Odz0Z6WkJZ8S8c8fE0woEG97zhE/Tc76OSaDgkfQroQp30UWntmy9geURNWvJSFqB
	RpofuFlPqyrN1Ia1PGqW4AeoZmCotBecLBKe+HhHpORJ8Y1xmrfBcpctaEwNN3a08D/iDd
	Ma5/wluMF9Y6qmc9Te5YThBB5BVZfC0=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-d2ByGnZBNqumcJXH87GYug-1; Tue, 19 Dec 2023 08:13:19 -0500
X-MC-Unique: d2ByGnZBNqumcJXH87GYug-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-55376255452so163603a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 05:13:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702991598; x=1703596398;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=km7B8rqaE4cuU/tTleclsqdvPEhf+k+mxhpbemw2EX0=;
        b=Hn/lP8vHIV3qHt7QSkqXX8Nt7gLqTqlEpi+hwrwIEd2Tr/jWPfKBtVYjvWLkMYtQO/
         UAebsNAJ8Y6GhFDLULTpnYOuDD8auLp91LMMOQ3+IStCoCcXn9VjcZDabl7KQHHLw8ls
         5XGQEniSUap7l1Kd93IsVppFfxucUVhlplI89HxP2MS9r+UYP1K1UYFDbic+7byclovV
         VAEshZb4OLudTjgzy05Tvtgj1hRoOphkPW53MUfHmJpwEvXXJZeXGgdgKbjIACRli7vv
         kLyTz9yg4Pp+sgyp0aLxBdbw7LalGenz9KkpxGYjaGkbz1PE+sOwyjqV8+oNgyJdkWGc
         OEfA==
X-Gm-Message-State: AOJu0Yzi5QcV6zKTAjGxc4lu9zdV1y4jXFbyUW7x7i3sBp5c1VymoqEn
	Fy6SEE2Bewv0NYBm5qX0uwbolZd1v/+4t9UVh8sadZ5sg0nriTkfkt15WsJ6ZCVIPDfCteHFlPr
	ZDU5YRTYUvdENBdHC8MWErH1B
X-Received: by 2002:a50:bb06:0:b0:553:46ed:3133 with SMTP id y6-20020a50bb06000000b0055346ed3133mr4788662ede.1.1702991598494;
        Tue, 19 Dec 2023 05:13:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFX7NdkRkDyz3rtbTezhATyr8w4xOSNOVYLoMis2BKCtC036UmtsA1NZo8sFvhhWAFmr++Kig==
X-Received: by 2002:a50:bb06:0:b0:553:46ed:3133 with SMTP id y6-20020a50bb06000000b0055346ed3133mr4788654ede.1.1702991598147;
        Tue, 19 Dec 2023 05:13:18 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-246-245.dyn.eolo.it. [146.241.246.245])
        by smtp.gmail.com with ESMTPSA id b8-20020aa7df88000000b00553686b8749sm1645162edy.39.2023.12.19.05.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 05:13:17 -0800 (PST)
Message-ID: <e1e15554bfa5cfc8048d6074eedbc83c4d912c98.camel@redhat.com>
Subject: Re: [PATCH] net: Do not break out of sk_stream_wait_memory() with
 TIF_NOTIFY_SIGNAL
From: Paolo Abeni <pabeni@redhat.com>
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>, Marc Kleine-Budde
	 <mkl@pengutronix.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, Jens Axboe <axboe@kernel.dk>, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 kernel@pengutronix.de
Date: Tue, 19 Dec 2023 14:13:16 +0100
In-Reply-To: <87cyv2wj4e.fsf@pengutronix.de>
References: <20231023121346.4098160-1-s.hauer@pengutronix.de>
	 <addf492843338e853f7fda683ce35050f26c9da0.camel@redhat.com>
	 <20231026070310.GY3359458@pengutronix.de>
	 <8404022493c5ceda74807a3407e5a087425678e2.camel@redhat.com>
	 <20231027120432.GB3359458@pengutronix.de>
	 <20231117-starter-unvisited-d10f0314ae76-mkl@pengutronix.de>
	 <87cyv2wj4e.fsf@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2023-12-19 at 12:00 +0100, Steffen Trumtrar wrote:
> On 2023-11-17 at 11:43 +01, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>=20
> > [[PGP Signed Part:Undecided]]
> > On 27.10.2023 14:04:32, Sascha Hauer wrote:
> > > On Thu, Oct 26, 2023 at 10:49:18AM +0200, Paolo Abeni wrote:
> > > > On Thu, 2023-10-26 at 09:03 +0200, Sascha Hauer wrote:
> > > > > On Tue, Oct 24, 2023 at 03:56:17PM +0200, Paolo Abeni wrote:
> > > > > > On Mon, 2023-10-23 at 14:13 +0200, Sascha Hauer wrote:
> > > > > > > It can happen that a socket sends the remaining data at close=
() time.
> > > > > > > With io_uring and KTLS it can happen that sk_stream_wait_memo=
ry() bails
> > > > > > > out with -512 (-ERESTARTSYS) because TIF_NOTIFY_SIGNAL is set=
 for the
> > > > > > > current task. This flag has been set in io_req_normal_work_ad=
d() by
> > > > > > > calling task_work_add().
> > > > > > >=20
> > > > > > > It seems signal_pending() is too broad, so this patch replace=
s it with
> > > > > > > task_sigpending(), thus ignoring the TIF_NOTIFY_SIGNAL flag.
> > > > > >=20
> > > > > > This looks dangerous, at best. Other possible legit users setti=
ng
> > > > > > TIF_NOTIFY_SIGNAL will be broken.
> > > > > >=20
> > > > > > Can't you instead clear TIF_NOTIFY_SIGNAL in io_run_task_work()=
 ?
> > > > >=20
> > > > > I don't have an idea how io_run_task_work() comes into play here,=
 but it
> > > > > seems it already clears TIF_NOTIFY_SIGNAL:
> > > > >=20
> > > > > static inline int io_run_task_work(void)
> > > > > {
> > > > >         /*
> > > > >          * Always check-and-clear the task_work notification sign=
al. With how
> > > > >          * signaling works for task_work, we can find it set with=
 nothing to
> > > > >          * run. We need to clear it for that case, like get_signa=
l() does.
> > > > >          */
> > > > >         if (test_thread_flag(TIF_NOTIFY_SIGNAL))
> > > > >                 clear_notify_signal();
> > > > > 	...
> > > > > }
> > > >=20
> > > > I see, io_run_task_work() is too late, sk_stream_wait_memory() is
> > > > already woken up.
> > > >=20
> > > > I still think this patch is unsafe. What about explicitly handling =
the
> > > > restart in tls_sw_release_resources_tx() ? The main point is that s=
uch
> > > > function is called by inet_release() and the latter can't be re-
> > > > started.
> > >=20
> > > I don't think there's anything I can do in tls_sw_release_resources_t=
x().
> > > When entering this function TIF_NOTIFY_SIGNAL is not (yet) set. It ge=
ts
> > > set at some point while tls_sw_release_resources_tx() is running. I f=
ind
> > > it set when tls_tx_records() returns with -ERESTARTSYS. I tried clear=
ing
> > > TIF_NOTIFY_SIGNAL then and called tls_tx_records() again, but that do=
esn't
> > > work.
> >=20
> > Seems the discussion got stuck, what are the blocking points?
>=20
> Ping!
>=20
> Any pointers on how to get this sorted out?

I raised the point if this patch could be dangerous outside of the
specific scenario and I did not get any reply to that.

To be more explicit: why this will not cause user-space driven
connect() from missing relevant events? Why this is needed only here
and not in all the many others event loops waiting for signals? Why
can't the issue be addressed in any place more closely tied to the
scenario, e.g. io_uring or ktls?

Thanks

Paolo



