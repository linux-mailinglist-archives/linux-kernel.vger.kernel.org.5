Return-Path: <linux-kernel+bounces-31351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB33832CF9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 17:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F0621F22B91
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 16:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E8A54BFD;
	Fri, 19 Jan 2024 16:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QcdvfmmW"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A2752F84;
	Fri, 19 Jan 2024 16:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705680879; cv=none; b=PZhxs1GtTcgCn06MQT7SEYPMQyss9VoV2remSPHUGkgoHTHFA7bZkr9Mpg3WBQ7BdXnp+Yh6y+k6qv2yiGkelTjfqa6lRNB+kBqZpaAHKB8YJM84YE4dnnlTRxgXFwv91j22RaTmaj6npV3ApF0IiSYw2TOJUg0KvgwPEz8OolY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705680879; c=relaxed/simple;
	bh=B7zL9FKEcp0/CRVmWRJ5gFi5msLCspc37+NygTzDgY0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jIbfP/aYotjH4xerXVw1PZHaeQmle6kiZJkPSVpNcBsSxW8Ht+xZZgKHlHt/MAssUVUvEAjBLf4kob8H6VdSHGVWRvpW2pre7UaRu3q2LQmN26TuHH7tTS6slVp/QaIqjK3VpZ9iKiQK+1VGE/igL5znhZmkJuwUnLVdO1JzXoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QcdvfmmW; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2cceb5f0918so10728961fa.2;
        Fri, 19 Jan 2024 08:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705680876; x=1706285676; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MZS8+douymIyp/G1h1ov9Y1Rdr9Hj7ajOnwayf3/aT4=;
        b=QcdvfmmWnWT5SWNEH4cP5iREbv7+7NCWtkapfyv8jthPS8j6pccMPtsCA6t5vQd2/E
         uO7FGzjqqih9qUTh/6W3ADQLlQUKAmRXBNqYjsCwtPLuNLsliivi/dxXCtaTdaeJ67vP
         bPG2/eR4+VWAnKEQcAI1R8974g+H8XCExAcGTVWBR/6ondAoodYgU8Y2FFne6f1gXTzb
         QOIikTiSLHNqguW84maKn9TVoe/OLfLVcYuwm4OiOntS5rU2dJnAIqZV9mlXX4i/J6mG
         rY7/0NcRQ9SJQyrwM76MegJro2IivCTxMXVVQFtQ6qTWsTu2G0zwBUk2ZZUYvHceIkKe
         Z1Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705680876; x=1706285676;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MZS8+douymIyp/G1h1ov9Y1Rdr9Hj7ajOnwayf3/aT4=;
        b=jPGzuB6on8DKfuK5DZodh/An3kHmi2jNc3GZVIlsWMeKpBeVBe4VwlpnzJND/HpJcf
         O3cg/D3wi8uDDNZxVNrG0mNKqsQS8gALgpmdhYkt+HpFKrUEav7Y5r5rYv9BtVlgqjNq
         iUacDy4AxxddKL6aKXr/BgB7PEoiWvHKNtUof0gGSaNSi6J+gU+9dcGH0gqnty+DskBN
         +IuNlh452J9MJIYYBqEOWtAzk4HBIgzOUK6VFi+Dk1wQc9I4Vl2t7puVJcgiemjihleZ
         f7KvdAbSTtUgfk5AAUsLmCkuZlPgqHwpAQxfupvCvia5j+cb4SnLaWTZvUI9w687c68c
         FWOA==
X-Gm-Message-State: AOJu0YwPR/CdJZb83fyXxWn2HjAoP7sO65Slob+sOLxll9+bgsBHRzll
	OHd5PD2c+13walH1SlbySRSZCgeFpWlh7geAotaT437aiIMQhPCAbKjWwlGiWiZXM6bKzesvso9
	6OxXlavGDLbQrrv9AD82x8Vj0j84=
X-Google-Smtp-Source: AGHT+IG4AWmyvk46hSLjREkIbqUt4PdjznNPm5PSf/hR21IX91v4MVnC382ND6Wc/ywvktNtzGzpa2ROJvpEuxdLURM=
X-Received: by 2002:ac2:446e:0:b0:50e:7be8:46fd with SMTP id
 y14-20020ac2446e000000b0050e7be846fdmr519933lfl.208.1705680875590; Fri, 19
 Jan 2024 08:14:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230804104602.395892-1-ckeepax@opensource.cirrus.com>
 <20230804104602.395892-7-ckeepax@opensource.cirrus.com> <Zali4qxdegY7H6eY@surfacebook.localdomain>
 <aec96f5a-b759-48c7-a5ec-bafe3bfa5357@sirena.org.uk> <CAHp75Vd6JtW4ddbSPXUp6WgEdBJizjwnS-XZzwLcXWWLxFWp-w@mail.gmail.com>
 <b1889bb0-2b9f-477c-80d3-a636b9017ea4@sirena.org.uk>
In-Reply-To: <b1889bb0-2b9f-477c-80d3-a636b9017ea4@sirena.org.uk>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 19 Jan 2024 18:13:59 +0200
Message-ID: <CAHp75Ve=SR_M5NGtu50Eu1Gw_g8mGfk1RAub22QZn3rwGNw+ug@mail.gmail.com>
Subject: Re: [PATCH v7 6/6] ASoC: cs42l43: Add support for the cs42l43
To: Mark Brown <broonie@kernel.org>
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>, lee@kernel.org, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	linus.walleij@linaro.org, vkoul@kernel.org, lgirdwood@gmail.com, 
	yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com, 
	pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org, 
	patches@opensource.cirrus.com, devicetree@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 12:07=E2=80=AFAM Mark Brown <broonie@kernel.org> wr=
ote:
> On Thu, Jan 18, 2024 at 10:46:28PM +0200, Andy Shevchenko wrote:
> > On Thu, Jan 18, 2024 at 8:11=E2=80=AFPM Mark Brown <broonie@kernel.org>=
 wrote:
> > > On Thu, Jan 18, 2024 at 07:41:54PM +0200, andy.shevchenko@gmail.com w=
rote:
> > > > Fri, Aug 04, 2023 at 11:46:02AM +0100, Charles Keepax kirjoitti:
>
> > > > > +   unsigned int hs2 =3D 0x2 << CS42L43_HSDET_MODE_SHIFT;
>
> > > > BIT(1) ?
>
> > > Given that this is writing a value into a register field called "MODE=
"
> > > it seems very likely that it's an enumeration value rather than a
> > > bitmask (and similarly for all the other places where you're making
> > > similar comments).  Please think a bit more about the code being
> > > commented on when making these minor stylistic comments.
>
> > I read a bit further and have given a comment about this as you put it
> > above that they are plain values.
> > Please, read my comments in full.
>
> I did eventually find that while going through the other comments but
> given that the earlier ones hadn't been revised and it was all a bunch
> of different fields it still seemed useful to highlight, if nothing else
> it was a little unclear that your later comment applied to all the
> fields you were asking for updates to.

Yeah, I was thinking about that during the review, that's why I first
commented and then concluded that those comments are kinda bogus.

> In general in a case like this where the code is already in tree it does
> seem like it'd be better to just write patche for the stylistic issues.

Sure. I believe Charles will address some of them, if not all.

--=20
With Best Regards,
Andy Shevchenko

