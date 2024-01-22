Return-Path: <linux-kernel+bounces-33456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1878369E7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:14:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F7CB1C2444E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F03865025B;
	Mon, 22 Jan 2024 15:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g1aLLm/+"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE9F3F8EE;
	Mon, 22 Jan 2024 15:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936377; cv=none; b=UPQ2BkEgrPqT6LTPiRz/vifqTYjLZh/9lOvGap4Q+Y0llgN0DX1GwO52oi4aBLfVnH6cjspsfVzgiwVD/cv0xz2EIj/eT7ARNdALN7tAdbbpTbyJR+P+NjUmgltyAq5hxpd53JBistbeVNyeojH6soIROLEToCM4OyVV5vp08GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936377; c=relaxed/simple;
	bh=F8f7LxqnB4DWxevS+3UIAe7bfKrLO5NJPchO5Xp1HuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DWU8IggbX8i8QhtqiULy4pwDJF9GP90iO/H+yPEgrzDDptB9O8D+5yPJAny3g2KSRm/Q4ys7ThcQ/ICb8xWqlol9SsO1ko+9YZiC70wTRcTSMkoyongeSH68pfXq9TRzlED/rYrTDvcMAwqZyYLaGLXSd735hSTGKon//kT6bI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g1aLLm/+; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-559cef15db5so7657471a12.0;
        Mon, 22 Jan 2024 07:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705936374; x=1706541174; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0LEUEYz+ew2ECb67VWN/zpFNcZ3uWeplc0iWoOX36Ng=;
        b=g1aLLm/+zUzSv2vIjdR09pRvY8bsH7BIT95mLfp82PETicSSiXI4iz154y8lj0Gl8H
         cY6rAJSvAummE35yLXx6OZBV+46bBGrEgkySuBYakkV6d2aX73S6X3LgiJS1n3ZorFvC
         KlG8pO81haBe/Wh2LWeVSOD+QWtvgImzwJ168XasrPRg+NLM8gp4X6WhTU0UUjEwD7/C
         afqmDd3V7FAm3UrNb+/i5JJaYc15qVTcZpTXMltmchjfRzF9EPAFYO0zNaac9cY9zQLS
         XA/eyCPmXbr9YS/aKd1qrX4flmCdvpLWLst8KZRHCPqFT0M0nwMDAgjFy2EHrx5i9bsL
         u1Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705936374; x=1706541174;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0LEUEYz+ew2ECb67VWN/zpFNcZ3uWeplc0iWoOX36Ng=;
        b=Uv12JvKkoOXpDZKaehv8G9+Rw4d1Gf07meO+UGMESXdBTVqZK7RSaFc74sb/j+jk4V
         LBuo6pEElSSNlLr+rq41xF4262SmSFkurFzBqtpoyifUHavTzoGBrX4aKkqmvV/miXc2
         3B51qKOS3xJXKPl+2HaVwf46EfwOI2u7q2UP5BgN0/7wNKCjBHiRdNbo+1FShtqeRdZX
         qCskuGVFpQYzsoAJu7d0UCoKeKtozPCG1fisXe/KD0htQHSNIb0AbaJtHmvog0RMckA2
         BIC26CAtOFrILPKkf0ccTroYE7fXtqQtlbIJ0PhU1nqeBDsw80EHswvCG+2vns0cbfAB
         QScQ==
X-Gm-Message-State: AOJu0YwuP4Or++PGf83j9kBLilbw4x9GxasXJtIp1yIlZ6FfrDFZE2+M
	vJZ7ZfCKe4Ilo06cHLXsGKlaZJnizSoEhf47dMnw21vNqeutjZIf
X-Google-Smtp-Source: AGHT+IGTJDoUzcbPE+cHVrC5chv52od6TNhT61AcXuBecr0U5QGiDYHdEyhTiteGFvtYgAyKPJEV0A==
X-Received: by 2002:a17:906:ce44:b0:a2e:82db:8c32 with SMTP id se4-20020a170906ce4400b00a2e82db8c32mr4199842ejb.28.1705936373571;
        Mon, 22 Jan 2024 07:12:53 -0800 (PST)
Received: from skbuf ([188.25.255.36])
        by smtp.gmail.com with ESMTPSA id cu12-20020a170906ba8c00b00a2f181266f6sm5343874ejd.148.2024.01.22.07.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 07:12:53 -0800 (PST)
Date: Mon, 22 Jan 2024 17:12:51 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Tim Menninger <tmenninger@purestorage.com>, f.fainelli@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: dsa: mv88e6xxx: Make *_c45 callbacks agree with
 phy_*_c45 callbacks
Message-ID: <20240122151251.sl6fzxmfi2f6tokf@skbuf>
References: <20240116193542.711482-1-tmenninger@purestorage.com>
 <04d22048-737a-4281-a43f-b125ebe0c896@lunn.ch>
 <CAO-L_44YVi0HDk4gC9QijMZrYNGoKtfH7qsXOwtDwM4VrFRDHw@mail.gmail.com>
 <da87ce82-7337-4be4-a2af-bd2136626c56@lunn.ch>
 <CAO-L_46kqBrDdYP7p3He0cBF1OP7TJKnhYK1NR_gMZf2n_928A@mail.gmail.com>
 <20240122123349.cxx2i2kzrhuqnasp@skbuf>
 <1aab2398-2fe9-40b6-aa5b-34dde946668a@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1aab2398-2fe9-40b6-aa5b-34dde946668a@lunn.ch>

On Mon, Jan 22, 2024 at 03:30:20PM +0100, Andrew Lunn wrote:
> On Mon, Jan 22, 2024 at 02:33:49PM +0200, Vladimir Oltean wrote:
> > On Tue, Jan 16, 2024 at 05:51:13PM -0800, Tim Menninger wrote:
> > > My impression is still that the read_c45 function should agree with the
> > > phy_read_c45 function, but that isn't a hill I care to die on if you still
> > > think otherwise. Thoughts?
> > 
> > FWIW, Tim's approach is consistent with what drivers/net/mdio/mdio-mux.c does.
> > 
> > 		if (parent_bus->read)
> > 			cb->mii_bus->read = mdio_mux_read;
> > 		if (parent_bus->write)
> > 			cb->mii_bus->write = mdio_mux_write;
> > 		if (parent_bus->read_c45)
> > 			cb->mii_bus->read_c45 = mdio_mux_read_c45;
> > 		if (parent_bus->write_c45)
> > 			cb->mii_bus->write_c45 = mdio_mux_write_c45;
> > 
> > My only objection to his patch (apart from the commit message which
> > should indeed be more detailed) is that I would have preferred the same
> > "if" syntax rather than the use of a ternary operator with NULL.
> 
> I agree it could be fixed this way. But what i don't like about the
> current code is how C22 and C45 do different things with error
> codes. Since the current code is trying to use an error code, i would
> prefer to fix that error code handling, rather than swap to a
> different way to indicate its not supported.
> 
> 	  Andrew

You did write in commit da099a7fb13d ("net: phy: Remove probe_capabilities")
that the MDIO bus API is now this: "Deciding if to probe of PHYs using
C45 is now determine by if the bus provides the C45 read method."

Do you not agree that Tim's approach is the more straightforward
solution overall to skip C45 PHY probing, given this API, both code wise
and runtime wise? Are there downsides to it?

I have no objection to the C22 vs C45 error code handling inconsistency.
It can be improved, sure. But it also does not matter here, if we agree
that this problem can be sorted out in a more straightforward way with
no negative consequences.

I sort of don't understand the desire to have the smallest patch in
terms of lines of code, when the end result will end up being suboptimal
compared to something with just a little more lines (1 vs 4).

