Return-Path: <linux-kernel+bounces-14210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A156F82191B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 10:50:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B322C1C21A2B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 09:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75CB0C8C4;
	Tue,  2 Jan 2024 09:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v38KX5fS"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6347BD2E5
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 09:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5534180f0e9so93747a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 01:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704189010; x=1704793810; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lcssTpZeKS0H5snwHIk3Knj/FZuQ1L/o3NwJ2ay7zAA=;
        b=v38KX5fSOLTYLvHfltkMHlcQ2MSzEBekmJ4qAgNwk3Px64BgNuut5qCiL7lDtySPkV
         9xXqGiUQVhSFm+VvUwwEHyxgOUuLBhanrw7xgurR/wo+327svU5SvZGqDBN0CYssU1Nk
         +mDrkO6ZJptxF4z6nVfUZIP6ttmv3ZrVBfoiNtStwIalXNlXOTsrByzQhcny5dkxBu7C
         G8zjCA2gvLG1ZOi+mcS+iDDgDQAjwFLbpNZ89TRnfKxZD7zESTKwaXgmfSw1i/MQ+gFo
         7pg/UvUqkj0VNGxj/Ay7tNIhRcqpFllaxW5p6w6ct48Nfkn8GZC/nzi4c/985U40IOBl
         rzMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704189010; x=1704793810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lcssTpZeKS0H5snwHIk3Knj/FZuQ1L/o3NwJ2ay7zAA=;
        b=Nqb0VTghmdKdhuoVrlVHKXDiUKoyHKpt+kYq7+Gy/zkwrYMykEwzgFxItuRIFexozU
         j5mnXDruKOc4KALCbz7B0gV1AeIXC4dRhzBHaB1VC9i0kkTAjNGFWxmQe1cRZsrZMPvE
         JL00j3vG7A/NC2SdPLLoGca/NjzvcNRIgTkh74rKtQUybCWIK0wyH1l4j+cU8uAKwhrw
         FLmitHVtU1IiFQghxBzrcjhUjbY4We58trlKmEUvY/kgbeGyM01BJ2q9/KfhcmOEW2hn
         K60uUcHpn8QbelCV8gaTr5525zIEBS01xco0+TqIdFnxNxmibwtjVGXecrKMzdyqinlW
         I4oQ==
X-Gm-Message-State: AOJu0YynTVxbdgDugMn0QYT15HaThLZ5lw0O5lTItwBVEwPvPMlwDxhT
	pDloPbJjF58UcyiZ5yQuiA6yAHmCoWeQrC84TIl8Hq8q5QYu
X-Google-Smtp-Source: AGHT+IHMPVe8XdoIT7EeONd4rJpwqw5IdmoQZvNke+XmJB40T2QlGXWdTT9hQ0a1uFx2tN4PCdC1/7/37rYD0Bv5nuY=
X-Received: by 2002:a50:bacb:0:b0:553:b7c6:1e47 with SMTP id
 x69-20020a50bacb000000b00553b7c61e47mr956532ede.2.1704189009453; Tue, 02 Jan
 2024 01:50:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <MN2PR12MB44863139E562A59329E89DBEB982A@MN2PR12MB4486.namprd12.prod.outlook.com>
 <CANn89iKvG5cTNROyBF32958BzATfXysh4zLk5nRR6fgi08vumA@mail.gmail.com>
 <MN2PR12MB4486457FC77205D246FC834AB98BA@MN2PR12MB4486.namprd12.prod.outlook.com>
 <CANn89i+e2TcvSU1EgrVZRUoEmZ5NDauXd3=kEkjpsGjmaypHOw@mail.gmail.com>
 <cdf72778-a314-467d-8ac8-163d2007fd70@leemhuis.info> <20231227083339.GA6849@unreal>
In-Reply-To: <20231227083339.GA6849@unreal>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 2 Jan 2024 10:49:58 +0100
Message-ID: <CANn89iK_Q38g1ieEb1MVvmVgiKQxmv9Hzngu_pCcXcwGs7cPLQ@mail.gmail.com>
Subject: Re: Bug report connect to VM with Vagrant
To: Leon Romanovsky <leon@kernel.org>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>, Shachar Kagan <skagan@nvidia.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "kuba@kernel.org" <kuba@kernel.org>, 
	Jason Gunthorpe <jgg@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>, Ido Kalir <idok@nvidia.com>, 
	Topaz Uliel <topazu@nvidia.com>, Shirly Ohnona <shirlyo@nvidia.com>, 
	Ziyad Atiyyeh <ziyadat@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 27, 2023 at 9:33=E2=80=AFAM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> On Fri, Dec 15, 2023 at 10:55:05AM +0100, Linux regression tracking (Thor=
sten Leemhuis) wrote:
> > On 08.12.23 11:49, Eric Dumazet wrote:
> > > On Thu, Dec 7, 2023 at 2:03=E2=80=AFPM Shachar Kagan <skagan@nvidia.c=
om> wrote:
> > >>>> On Thu, Nov 30, 2023 at 2:55=E2=80=AFPM Shachar Kagan <skagan@nvid=
ia.com> wrote:
> > >>>>
> > >>>> I have an issue that bisection pointed at this patch:
> > >>>> commit 0a8de364ff7a14558e9676f424283148110384d6
> > >>>> tcp: no longer abort SYN_SENT when receiving some ICMP
> > >>>
> > >>> Please provide tcpdump/pcap captures.
> > >>>
> > >>>  It is hard to say what is going on just by looking at some applica=
tion logs.
> > >>
> > >> I managed to capture the tcpdump of =E2=80=98Vagrant up=E2=80=99 ste=
p over old kernel and new kernel where this step fails. Both captures are a=
ttached.
> > >> The tcpdump is filtered by given IP of the nested VM.
> > >
> > > I do not see any ICMP messages in these files, can you get them ?
> > >
> > > Feel free to continue this exchange privately, no need to send MB
> > > email to various lists.
> >
> > Here this thread died, so I assume this turned out to be not a
> > regression at all or something like that? If not please speak up!
>
> No, it wasn't fixed and/or reverted. Right now, Vagrant is broken and
> all our regressions around nested VM functionality doesn't run.
>
> Eric, can you please revert the bisected patch while you are continuing
> your offline discussion with Shachar?
>

This is not how things work.

I have not received any evidence yet, only partial packet dumps with
no ICMP messages that could be related to the 'Vagrant issue'

Patch is adhering to the RFC.

If an application wants to have fast reaction to ICMP, it must use
appropriate socket options instead of relying on a prior
implementation detail.

