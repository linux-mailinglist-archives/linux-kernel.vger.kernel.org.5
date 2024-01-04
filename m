Return-Path: <linux-kernel+bounces-17326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02676824BCF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 00:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 180B71C2295A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 23:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717C62D05E;
	Thu,  4 Jan 2024 23:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zNQDdKxl"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DC82D054
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 23:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7811d1e68b0so58954685a.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 15:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704410802; x=1705015602; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3DEyAQYhS53N6Au2tNMM9Q2eJCxKU8de5VRSSH8XLx0=;
        b=zNQDdKxl08UucJ+2BtBJAsxGzS3m1nb8lReW1ACtn6AAfVlzIqoOiaA9M/lkKMPPjl
         5KePCHmY4Xowoo1ajnXUEayEHTIFa1RMaRcPfPDUbvmqdVe2d5mmYC3xCwPtJ7vIqara
         ohVwUje5rdCSEyBAmaAer+kyzOUQH6SVrSMn91uhJtB4LkxpeDl61AgDNOa+aON+jni7
         faKa0DivoYKgeTHpg5y4YyMMr2KQNnCjtfHiUUeQkGqsRLlmOogs/ucCVJ4OZGw48dvJ
         0cScZyBuKW5smLuXrYjD1VIHyirwJItBntzNEFwDABAABpSM6tQ2n6ypKXrYcGi2Br0n
         dBGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704410802; x=1705015602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3DEyAQYhS53N6Au2tNMM9Q2eJCxKU8de5VRSSH8XLx0=;
        b=tvz9LyN9hnD9zJ5wYlbDeGecG+YF0quBAVCekBPA5AsZ2n+cnPIBKbdLGeHGTJLkWC
         o9rTD1DVk/6KnQLAS8/4Lw6bezW2bQwfBhBAtZv22kpPd1N+0+FYlCIu5TRrAQOtHkKi
         JFV4ueMHRP7vQLqKC4Nwf4POmGbwpb9asHLeVASp/P6bBSALNTUbrayiZosgac+Dy+Lr
         PHHsSuEQrACmxcvpx8aX6w9/Vqbslk9C0PEpbbF7o4O1CGn3B+vAuXEw3hzq+g3zSAnv
         51jA+JLOCAaPBukcMxPeYFMKeaSLCuN0l2Sjc4fq3Fr2BsSAMLwJBseYF3+vt/g1Ib6V
         A1hQ==
X-Gm-Message-State: AOJu0YwwQyfDxQD92Xi165OID5ErvIE6dSUkGn9o8R21UJYJlsqUwe4x
	BtC6a99U0PFiHcyBPGeIaNV5a3ueFL7ftz6cH+jQcLdTk2YX
X-Google-Smtp-Source: AGHT+IGCYxgHTM7Kk3IU/8To+mH/q1nStuap46wb5qXAdXBKpucrrO3HHEXPCQLMPLxUXwev0nmcdNjg2LNWykiWeN4=
X-Received: by 2002:a05:6214:76a:b0:67f:470e:ed7c with SMTP id
 f10-20020a056214076a00b0067f470eed7cmr1542378qvz.25.1704410802175; Thu, 04
 Jan 2024 15:26:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231221023650.3208767-1-aahila@google.com> <20231221173531.GA1202958@kernel.org>
In-Reply-To: <20231221173531.GA1202958@kernel.org>
From: Aahil Awatramani <aahila@google.com>
Date: Thu, 4 Jan 2024 15:26:30 -0800
Message-ID: <CAGfWUPw2CMEB5+0DPhZME_pZ5EX3zqqEfZhLBqKAHRS1+ua10w@mail.gmail.com>
Subject: Re: [PATCH next] bonding: Extending LACP MUX State Machine to include
 a Collecting State.
To: Simon Horman <horms@kernel.org>
Cc: Mahesh Bandewar <maheshb@google.com>, Jay Vosburgh <j.vosburgh@gmail.com>, 
	Andy Gospodarek <andy@greyhouse.net>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the feedback, I have made the changes you have suggested
moving forward.

On Thu, Dec 21, 2023 at 9:35=E2=80=AFAM Simon Horman <horms@kernel.org> wro=
te:
>
> On Thu, Dec 21, 2023 at 02:36:50AM +0000, Aahil Awatramani wrote:
> > Introduces two new states, AD_MUX_COLLECTING and AD_MUX_DISTRIBUTING in
> > the LACP MUX state machine for separated handling of an initial
> > Collecting state before the Collecting and Distributing state. This
> > enables a port to be in a state where it can receive incoming packets
> > while not still distributing. This is useful for reducing packet loss w=
hen
> > a port begins distributing before its partner is able to collect.
> > Additionally this also brings the 802.3ad bonding driver's implementati=
on
> > closer to the LACP specification which already predefined this behaviou=
r.
> >
> > With this change, 802.3ad mode will use new
> > bond_set_slave_txrx_{enabled|disabled}_flags() set of functions only
> > instead of the earlier one (bond_set_slave_{active|inactive}_flags).
> > Additionally, it adds new functions such as
> > bond_set_slave_tx_disabled_flags and bond_set_slave_rx_enabled_flags to
> > precisely manage the port's collecting and distributing states.
> > Previously, there was no dedicated method to disable TX while keeping R=
X
> > enabled, which this patch addresses.
> >
> > Note that the regular flow process in the kernel's bonding driver remai=
ns
> > unaffected by this patch. The extension requires explicit opt-in by the
> > user (in order to ensure no disruptions for existing setups) via netlin=
k
> > or sysfs support using the new bonding parameter lacp_extended_mux. The
> > default value for lacp_extended_mux is set to 0 so as to preserve exist=
ing
> > behaviour.
> >
> > Signed-off-by: Aahil Awatramani <aahila@google.com>
>
> ...
>
> > @@ -1906,6 +2005,46 @@ static void ad_initialize_port(struct port *port=
, int lacp_fast)
> >       }
> >  }
> >
> > +/**
> > + * ad_enable_collecting - enable a port's receive
> > + * @port: the port we're looking at
> > + * @update_slave_arr: Does slave array need update?
>
> The line above documenting @update_slave_arr
> should be removed as the parameter is not in
> the function definition below.
>
> > + *
> > + * Enable @port if it's in an active aggregator
> > + */
> > +static void ad_enable_collecting(struct port *port)
> > +{
> > +     if (port->aggregator->is_active) {
> > +             struct slave *slave =3D port->slave;
> > +
> > +             slave_dbg(slave->bond->dev, slave->dev,
> > +                       "Enabling collecting on port %d (LAG %d)\n",
> > +                       port->actor_port_number,
> > +                       port->aggregator->aggregator_identifier);
> > +             __enable_collecting_port(port);
> > +     }
> > +}
>
> The above is a pretty minor problem, but the bots are likely
> to complain about it, so please fix it in v2 after waiting
> for feedback from others on this patch.
>
> When posting v2 please target it at the net-next tree.
>
>         Subject: [PATCH net-next v2] ...
>
> --
> pw-bot: changes-requested

