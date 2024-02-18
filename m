Return-Path: <linux-kernel+bounces-70170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B01CF85944A
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 04:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FB9FB20A6F
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 03:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70CA1848;
	Sun, 18 Feb 2024 03:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f1HxYVWo"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6805E15C0;
	Sun, 18 Feb 2024 03:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708225857; cv=none; b=JkSAQ4aNncRaGeJknAWi9ltP6tIcoa8UHIPCiGb7HbtcwrGc9lBFYuDoN31an92Y/8Tc3FQW13E8ays/Z2DQnwYTWtxQVoxMuYAshxM08dq4JqHP+OamlX7UpPbmocNZXCGfn4uMOgeVXYMNmH10EZeHsQU8GY6FpC1IHXJOktM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708225857; c=relaxed/simple;
	bh=/+4TlFWh8lKqTf1az0E4o7ZlHJHLJPmeg3PkaSltrH0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hpyo89bO26iXMDm3wvjYe+j1ddoYw0Nggiiyj2IX+Bl56ELS9oC/RHTUMWLcwmHgp5zVNpFD3qRyzorkQXzVDmGwveT8gA4tH2IeanbrUCTCsZME08gDp6CTphXpvhnaZPeXoDGX+rFpuDTcxifywhKzhwrHPlfeQ4HSRL6yZhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f1HxYVWo; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a3d6d160529so236935166b.0;
        Sat, 17 Feb 2024 19:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708225854; x=1708830654; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FnlDJkdNhI1kCGRl0tLw3fRINrAPP/RmkZJTxoIRS+g=;
        b=f1HxYVWoAhTXT7OdyE0ANqLWciPYCxDBDgbz0pyZGzRT/beyhdCoy9lGdtJ3ExqsB2
         dLrpI/87ZCNBG6HgWe0ZwWGAKs3XM8Vl239ICVf9yn3M6p3wk8pwEFFf5bpYjhkgAd9K
         hKOfUb2zJf8fRrJvkSTTybB36Hm/Za8/ZBpet8kRJvIFs6GJq0PaVXaKDA+AxHzXH69V
         cCO/ifhjQAMJMw7O/WO6hymwTLJfWpmASjRUiQxz3PG9Pd5NqWaIrE4nNBNrEuxn6CdB
         ySUW2hTdEnGjJbkqjNx5wMpIEFUKFKE4u2qkoi07c2bWhuRKub3k+UYTaQHw/vqHSC3k
         hdYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708225854; x=1708830654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FnlDJkdNhI1kCGRl0tLw3fRINrAPP/RmkZJTxoIRS+g=;
        b=GIP3rU6jQL0MPuCictA1MDMwiu66MWGlNW8/RgKKw2kk9j+HvI7mrFHdqRRVYjnSrv
         OKYtnpdH1JTNYgBR3Q91miauEgEMns1EvMERAPVugHi1gFOs4EXCg4gvDuEzHcR9iFv/
         DM3/lfM6871Cnem/3FQOP/Bu51wLNgt6Jl774rbw+CmUVpEaKWpRMPTZTJ6bcFwHATXl
         xEQqk23hTM19ckQZYnVLHBqLQsNHg3nW30DKoW1GCmdcfGcvJoFU80XZnZVzjM6jeB1C
         9Nd9nMBG0dAW9Nbmlypl7Kln1t9XcekEQ9TkBJwqZhr5zdFab2IJZ1ibq684QQdSjzFZ
         p28g==
X-Forwarded-Encrypted: i=1; AJvYcCUQP0CPk7WTzQkr7lwZHLCKzHHut3sGuhI0uZINX9MganEDuHtYfAA8KvNx+AjKYxQhCxI4Oc+fvkP5akF54iwURmh8xCSmueyb+YiVlFv90H+/3xuAK6c+TXsWLMOeg9N2Id6T65pb/w==
X-Gm-Message-State: AOJu0YyTFXuYXq/DVR3/kiGgYNLZyeW/voli/w7LmPzd4HYXCUbyG0fO
	g4/C108caNLemR7FMEC59nOaPLlDny6NJwTTEL6jIWCtX1Jku/uzE3sIYmh0KZh3k/IlLMvA+21
	DL3vbmEqeIu6VnTTmK3CzefSWUQg=
X-Google-Smtp-Source: AGHT+IG6q7s2A+bcCjOyvytvYGlG4/gO5k1DEYbRKOzeuRChC+WCxUsjSbelYM2wcwGqJRX2VDOq/Pv8uOaSbi0euEg=
X-Received: by 2002:a17:906:ca56:b0:a38:9590:cde8 with SMTP id
 jx22-20020a170906ca5600b00a389590cde8mr6974488ejb.73.1708225853615; Sat, 17
 Feb 2024 19:10:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201-imx-mailbox-v6-0-76f4f35b403e@nxp.com>
 <PA4PR04MB941646795F4E19D1EC35134F88522@PA4PR04MB9416.eurprd04.prod.outlook.com>
 <CABb+yY0aM9Dn3LPBqb11vU3Ln4bCCGOBXX77sF499cyb_sXiUA@mail.gmail.com> <DU0PR04MB94170454D64EF65E6774BEAB88522@DU0PR04MB9417.eurprd04.prod.outlook.com>
In-Reply-To: <DU0PR04MB94170454D64EF65E6774BEAB88522@DU0PR04MB9417.eurprd04.prod.outlook.com>
From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Sat, 17 Feb 2024 21:10:42 -0600
Message-ID: <CABb+yY3U5GzvznLDU7pyA1ppfLT50MQKQ3YRXB3rYwr_QwcH-g@mail.gmail.com>
Subject: Re: [PATCH v6 0/4] mailbox: imx: support i.MX95 ELE/V2X MU
To: Peng Fan <peng.fan@nxp.com>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Aisheng Dong <aisheng.dong@nxp.com>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, dl-linux-imx <linux-imx@nxp.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 17, 2024 at 8:10=E2=80=AFPM Peng Fan <peng.fan@nxp.com> wrote:
>
> Hi Jassi,
>
> > Subject: Re: [PATCH v6 0/4] mailbox: imx: support i.MX95 ELE/V2X MU
> >
> > Hi Peng,
> >
> > On Sat, Feb 17, 2024 at 7:38=E2=80=AFPM Peng Fan <peng.fan@nxp.com> wro=
te:
> > >
> > > Hi Jassi
> > >
> > > > Subject: [PATCH v6 0/4] mailbox: imx: support i.MX95 ELE/V2X MU
> > > >
> > > > - Add dt-bindings
> > > > - i.MX95 ELE/V2X use same register layout as i.MX8ULP S4 MU, but
> > > >   the TR/RR num is different. To make code reusable and not add too
> > much
> > > >   macros, add runtime detect number of TR and RR by reading PAR_OFF
> > > >   registers.
> > > > - Add i.MX95 ELE/V2X MU entry in driver
> > >
> > > Ping..
> > >
> > dt bindings and compatibles first need to be acked by dt maintainers.
>
> The bindings has been reviewed by Conor Dooley who listed as maintainer:
> OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS
> M:      Rob Herring <robh+dt@kernel.org>
> M:      Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> M:      Conor Dooley <conor+dt@kernel.org>
>
Ok, I didn't realise we have three maintainers now.

I see no problem other than adding of_platform_populate() and
compatibles in the same patch. They should be separate.

cheers.

