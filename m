Return-Path: <linux-kernel+bounces-144543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ADBB8A4797
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 07:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED69A1F21AFC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 05:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 692356139;
	Mon, 15 Apr 2024 05:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="COA6bK+U"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF5C33C5;
	Mon, 15 Apr 2024 05:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713158975; cv=none; b=Lvr2KOsQcA5BKCzgBYZnO+laeTvVyGdeGufJWcOSWcimI1641DNfweNsj/RqMLIA9Fg8O1+G5PUfIktrhYl5xTw1M3gPjkq9UDJWKogBxVx0tQPUZACRTGvhTOhafoWgaGwyuFFPq6+fcfEKKb+akm7bIV2QrO437w20ysh8Szs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713158975; c=relaxed/simple;
	bh=UpCMuHkepQajdVg62XPJny0xX87yZKEpf4poRd7fJeg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S2U8RwHGhmAD244VWTkUO1jk8ZVHpyxWC1UCNBCHQbusPvKDbxkAprzNEd88wn9VQQ16Q45xhGS/AtMpnwEdnmQ0yME92OJdbgHDVm/9+2Co0GqxEwrR+yyyddsROUT+w0MI0/yR3UDCbNaHgnrCXc5gUOH4LVqCGPKYm6WsmHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=COA6bK+U; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2a528e7f2b6so1947192a91.0;
        Sun, 14 Apr 2024 22:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713158973; x=1713763773; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oH9+g2LiJ7hE+BmM60E94BIQlPkF9NnGngny+sqtXio=;
        b=COA6bK+Umr3eZObrZDY8r3IIZIJHD4mGWlyu6DCfV2a9YxlISwVn74BRRoJhFB0QuJ
         icc/nSc3uPjqs4rO6rhvE2DcovfE/WPmPt6eIoUFwz9ktoqXQ8PejQeofmZurpMtDae4
         VE3SacsLC2fmRyx2mCoYGHMPQvnxLiK6R0KIMQLPFhTLlUotzseJmZQeDwC30uvlYhgr
         K6RPk7hj3/MGwIlHTiI1taI48hIzv3ouGcKo9zBONb4Rt0ydaMw9TYYM76t5+4tb4CKF
         2FbGDTi2IOMSSRB71WaYa+k05VZ1ItZBp0w2w/UgtHLcTcya2di/eLfTJAFiRrxKEgPe
         /YPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713158973; x=1713763773;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oH9+g2LiJ7hE+BmM60E94BIQlPkF9NnGngny+sqtXio=;
        b=po6vxasDBr9aFVaitt47plxDeX1yGHKdxr2kEbLbKjHa3zXNG3SSe2edtIP6x39RIl
         nk/ZyYW9XOxaey81hznHMUo4ltX6DWB2xxItV7A9kNNYP7WH5o7kSwx/kpAFjBd1kX0D
         k45OidE3BnyJlbFyVUz6kAkonUtZXPPEvqPEgQaO3byfeFqzlvPyRf+KwC8FyImIM+w9
         tk2L/kYF78klOWm7EZ+Qey9WT7+eYMkJJg2d5AGjMTumZa3mZpdwP4FnGJ6gp3rQvMhI
         hFREIDNRdBGfR+Pk0BpgXWiinuM4eZDiQlzL0XoWiJMOo/ULqcVo9cP81tPH3xD3liev
         ljkA==
X-Forwarded-Encrypted: i=1; AJvYcCXrrxmf0nR5NQEwF+M7Nngd8V3EEUZS7x8w3iwR/Q8cx4d8M2vJGtqUhZYYRWP69YFFpFTlnURBVdIhJZ+S/iJNOaPDG6ScaGl6D/HhE8KIU2lfpRPJpg8G00oPdQriffnsbaXIROGMQ3He8Z9lLS9tI0A/kXVcGjMR0iEhRew6
X-Gm-Message-State: AOJu0Yyt5G7KLsVOPu/JqkwtdFEFeMNwi51jqtrQ/uAuSrc/4EaPKbfL
	Go8Zcq6Z5haj/ADtIiyX89ni0zFca5x4y1+io5b/a1Y+mIczaad+HyoZk57gT7xD4Sl7n0wbrkk
	GVC73WdljcMh4EleWXfKrJlqBW2o=
X-Google-Smtp-Source: AGHT+IHKH/DnDVNEyAUbf+ZobgfwfRon2sOSX7mDNvX2ZdhP8EGjIUYn6XK+AMsRNq8Av1nvSCIFf8pqDvmocgj5FcM=
X-Received: by 2002:a17:90a:c205:b0:2a5:2177:9b41 with SMTP id
 e5-20020a17090ac20500b002a521779b41mr6463184pjt.22.1713158973331; Sun, 14 Apr
 2024 22:29:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329133458.323041-2-valla.francesco@gmail.com>
 <20240329133458.323041-3-valla.francesco@gmail.com> <CAMZ6RqKLaYb+8EaeoFMHofcaBT5G2-qdqSb4do73xrgMvWMZaA@mail.gmail.com>
 <9f5ad308-f2a0-47be-85f3-d152bc98099a@hartkopp.net> <CAMZ6RqKGKcYd4hAM8AVV72t78H-Kt92NXowx6Q+YCw=AuSxKuw@mail.gmail.com>
 <64586257-3cf6-4c10-a30b-200b1ecc5e80@hartkopp.net>
In-Reply-To: <64586257-3cf6-4c10-a30b-200b1ecc5e80@hartkopp.net>
From: Vincent Mailhol <vincent.mailhol@gmail.com>
Date: Mon, 15 Apr 2024 14:29:21 +0900
Message-ID: <CAMZ6RqKJH-Qmh4uXHj5Opj4PxDX=JDEBRR8gzsCuQ6pKHz1MfA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] Documentation: networking: document ISO 15765-2:2016
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Francesco Valla <valla.francesco@gmail.com>, Marc Kleine-Budde <mkl@pengutronix.de>, 
	linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, fabio@redaril.me
Content-Type: text/plain; charset="UTF-8"

On Mon. 15 Apr. 2024 at 05:22, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
> On 14.04.24 06:03, Vincent Mailhol wrote:
> >
> > This doesn't remove the fact that I think that this naming convention
> > is stupid because of the RAS syndrome, but I acknowledge that CAN CC
> > is now the official denomination and thus, that we should adopt it in
> > our documentation as well.
> >
>
> ;-)
>
>
> >>> Add a space between ISO and the number. Also, update the year:
> >>>
> >>>     ISO 15765-2:2024
> >>>
> >>
> >> Interesting! Didn't know there's already a new version.
> >>
> >> Will check this out whether we really support ISO 15765-2:2024 ...
> >>
> >> Do you have the standard at hand right now or should we leave this as
> >> ISO15765-2:2016 until we know?
> >
> > I have access to the newer revisions. But I never really invested time
> > into reading that standard (neither the 2016 nor the 2024 versions).
> >
> > Regardless, here is a verbatim extract from the Foreworld section of
> > ISO 15765-2:2024
> >
> >    This fourth edition cancels and replaces the third edition (ISO
> >    15765-2:2016), which has been technically revised.
> >
> >    The main changes are as follows:
> >
> >      - restructured the document to achieve compatibility with OSI
> >        7-layers model;
> >
> >      - introduced T_Data abstract service primitive interface to
> >        achieve compatibility with ISO 14229-2;
> >
> >      - moved all transport layer protocol-related information to Clause 9;
> >
> >      - clarification and editorial corrections
> >
>
> Yes, I've checked the release notes on the ISO website too.
> This really looks like editorial stuff that has nothing to do with the
> data protocol and its segmentation.

This is also my feeling. Short story, I think it is reasonable to
quote ISO 15765-2:2024 instead of ISO 15765-2:2016 in this document.

> >>>
> >>> Here, I would suggest the C99 designated field initialization:
> >>>
> >>>     struct sockaddr_can addr = {
> >>>             .can_family = AF_CAN;
> >>>             .can_ifindex = if_nametoindex("can0");
> >>>             .tp.tx_id = 0x18DA42F1 | CAN_EFF_FLAG;
> >>>             .tp.rx_id = 0x18DAF142 | CAN_EFF_FLAG;
> >>>     };
> >
> > Typo in my previous message: the designated initializers are not
> > separated by colon ";" but by comma ",". So it should have been:
> >
> >    struct sockaddr_can addr = {
> >          .can_family = AF_CAN,
> >          .can_ifindex = if_nametoindex("can0"),
> >          .tp.tx_id = 0x18DA42F1 | CAN_EFF_FLAG,
> >          .tp.rx_id = 0x18DAF142 | CAN_EFF_FLAG,
> >    };
> >
> >>> Well, this is just a suggestion, feel free to reject it if you do not like it.
> >>
> >> At least I don't like it.
> >>
> >> These values are usually interactively given on the command line:
> >>
> >>   >            .can_ifindex = if_nametoindex("can0");
> >>   >            .tp.tx_id = 0x18DA42F1 | CAN_EFF_FLAG;
> >>   >            .tp.rx_id = 0x18DAF142 | CAN_EFF_FLAG;
> >>
> >> So have it in a static field initialization leads to a wrong path IMO.
> >
> > There is no such limitation that C99 designated initializers should
> > only work with variables which have static storage duration. In my
> > suggested example, nothing is static.
> >
> > I see this as the same thing as below example:
> >
> >    int foo(void);
> >
> >    int bar()
> >    {
> >            int i = foo();
> >    }
> >
> >    int baz()
> >    {
> >            int i;
> >
> >            i = foo();
> >    }
> >
> > In bar(), the fact that the variable i is initialized at declaration
> > does not mean that it is static. In both examples, the variable i uses
> > automatic storage duration.
> >
> > Here, my preference goes to bar(), but I recognize that baz() is also
> > perfectly fine. Replace the int type by the struct sockaddr_can type
> > and the scalar initialization by designated initializers and you
> > should see the connection.
>
> Oh, sorry. Maybe I expressed myself wrong.
>
> IMHO your way to work with an initializer is correct from the C standpoint.
>
> But I think this is pretty unusual for a code example when an
> application programmer starts to work with ISO-TP.
>
> You usually get most of these values from the command line an fill the
> struct _by hand_ - and not with a static initialization.
>
> That was my suggestion.

OK. I get your point of view, which I think is a fair argument. So
let's keep it as is.

Just to conclude the debate, in real life, how to write it would
depend on the situation.

You may for example receive the values as function parameters:

  static int tp_bind(const char* ifname, canid_t rx_id, canid_t tx_id)
  {
          int s;
          struct sockaddr_can addr = {
                  .can_family = AF_CAN,
                  .can_ifindex = if_nametoindex(ifname),
                  .tp.rx_id = rx_id,
                  .tp.tx_id = tx_id,
          };
          int ret;

          s = socket(PF_CAN, SOCK_DGRAM, CAN_ISOTP);
          if (s < 0)
                  exit(1);

          ret = bind(s, (struct sockaddr *)&addr, sizeof(addr));
          if (ret < 0)
                  exit(1);

          return s;
  }

Or, if you get the values from the command line, you could have an
hybrid approach:

          int s;
          struct sockaddr_can addr = {
                  .can_family = AF_CAN,
          };
          char ifname[IF_NAMESIZE];
          canid_t rx_id, tx_id;
          int ret;

          /* Parse command line and fill ifname, rx_id and tx_id */
          addr.can_ifindex = if_nametoindex(ifname);
          addr.tp.rx_id = rx_id;
          addr.tp.tx_id = tx_id;

          s = socket(PF_CAN, SOCK_DGRAM, CAN_ISOTP);
          if (s < 0)
                  exit(1);

          ret = bind(s, (struct sockaddr *)&addr, sizeof(addr));
          if (ret < 0)
                  exit(1);

In the end, there is not enough context to decide which one is best.
And, I diverged too much. Francesco, keep the original.

> >
> > ** Different topic **
> >
> > While replying on this, I encountered something which made me worry a bit:
> >
> > The type of sockaddr_can.can_ifindex is a signed int:
> >
> >    https://elixir.bootlin.com/linux/latest/source/include/uapi/linux/can.h#L243
> >
> > But if_nametoindex() returns an unsigned int:
> >
> >     https://man7.org/linux/man-pages/man3/if_nametoindex.3.html
> >
> > Shouldn't sockaddr_can.can_ifindex also be declared as an unsigned int?
> >
>
> The if_index derives from struct netdevice.if_index
>
> https://elixir.bootlin.com/linux/v6.8.6/source/include/linux/netdevice.h#L2158
>
> which is an int.

Ack.

> I don't think this would have an effect in real world to change
> sockaddr_can.can_ifindex to an unsigned int.
>
> I wonder if it is more critical to existing user space code to change it
> to unsigned int or to leave it as-is ...

The only impact is the warnings if compiled with the zealous flags
which warn on conversion between signed and unsigned, which would
normally be a sufficient reason to change. But, I understand that this
if_index is also a signed int at other locations in the kernel, so
let's keep it as such in our code.

> Best regards,
> Oliver

