Return-Path: <linux-kernel+bounces-78709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D14D8617A8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:22:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B987A1F211B7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F384C79;
	Fri, 23 Feb 2024 16:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oyrEMY/q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C34823CD;
	Fri, 23 Feb 2024 16:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708705249; cv=none; b=YJXn8IUNYKupj/Cv5sKuJ1iage8NMq/T5Y+LnY9pNBv9FHsjJPi3vtcgNBU+3gfrg/93+NRcVAYz06EmRtQkrZrltlmqSeMj5UrONxtpal/G2QGeS3Sce1qliJ3T/gpGYfi1kz69qhVAJqsY0fYg1ID5FeZhVl7wUmrpMPi/AmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708705249; c=relaxed/simple;
	bh=DvHi85np8LJsYVNCrsC1Bq/l80CI1t1Izc/jC68GZYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hrIfzWVWEzNhfxEseyUFgZcuxZ+6Ll5UJIjzjtryfCObKXdIRTjdAkFokBxEnUSF/EJTrFT4PllEeFZ6RQ2B8n8/Isnvjh1Vx8q092HoV+tEUx7ETZzvj/xhzmpi431TYgJtLzmIjKKyVTpmxjHq5ae7V8CiqRQkaj2bwFHXZJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oyrEMY/q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A2FEC433C7;
	Fri, 23 Feb 2024 16:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708705248;
	bh=DvHi85np8LJsYVNCrsC1Bq/l80CI1t1Izc/jC68GZYU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oyrEMY/q2KXxiHjwpBsZslqiSCdGA4M8rLjHS9oFmAHdlnUjkZy8rvdp+2+xlbGC/
	 C2fHeAmo3GIgtmldsoO7eP/iomz1AMugjd4lOkyns4BijjrahB3FMF8ZUxHGlVrHy+
	 ZsXB1r2ZpqlwaXqwvymMvtya/2iJ64YM3WhjxxvTJL9TDIB6i1L2qvxYJtIbJrg3Nc
	 wBchIquEAp5aGg8Gy1oOvs0+ePkLkyHgqzkAOYuvxVp1PsW+um/FIqmAP5/hizC+r7
	 l2GOmb4BNcbq3FDWCg4wMaW1r12G6mlRHQcnboWUWemq7VfnvA9Fm9hEZLERJJOk+6
	 81ws+TUWKesLg==
Date: Fri, 23 Feb 2024 16:20:42 +0000
From: Lee Jones <lee@kernel.org>
To: Abdel Alkuor <alkuor@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Jean-Jacques Hiblot <jjhiblot@traphandler.com>,
	ChiYuan Huang <cy_huang@richtek.com>,
	=?iso-8859-1?Q?Andr=E9?= Apitzsch <git@apitzsch.eu>,
	Alice Chen <alice_chen@richtek.com>,
	Jacek Anaszewski <jacek.anaszewski@gmail.com>,
	ChiaEn Wu <chiaen_wu@richtek.com>, linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] leds: Add NCP5623 multi-led driver
Message-ID: <20240223162042.GJ1666215@google.com>
References: <20240203175910.301099-1-alkuor@gmail.com>
 <20240203175910.301099-2-alkuor@gmail.com>
 <20240208130115.GM689448@google.com>
 <Zci9xE5uHRJGMg5q@primary>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zci9xE5uHRJGMg5q@primary>

On Sun, 11 Feb 2024, Abdel Alkuor wrote:

> On Thu, Feb 08, 2024 at 01:01:15PM +0000, Lee Jones wrote:
> > On Sat, 03 Feb 2024, Abdel Alkuor wrote:
> >
> Hi Lee,
> 
> Please check the inline comment. All other comments will be addressed
> in v2.
> 
> > > +What:		/sys/class/leds/<led>/dim_step
> > 
> > The step principle seems a bit arbitrary.
> > 
> > Why not provide the time directly?
> > 
> > dim_step_delay?
> > 
> > I already see documentation for risetime and falltime.
> > 
> > Perhaps that will omit the need for both direction and step?
> >
> I'm going to drop off both and use risetime and falltime. That being
> said, the documented risetime and falltime for lm3533 use steps instead of
> entering the time directly. This is my first time doing this, should I document
> risetime/falltime in sysfs-class-led-multicolor-driver-ncp5623? or should
> I update risetime/falltime in sysfs-class-led-driver-lm3533 to reflect
> risetime/falltime for ncp5623?

Keep them separate please.

> > > +Date:		Feb 2024
> > > +KernelVersion:	6.8
> > > +Contact:	Abdel Alkuor <alkuor@gmail.com>
> > > +Description:
> > > +		Set gradual dimming time.
> > > +
> > > +		==== ======== ==== ======== ==== ========
> > > +		Step Time(ms) Step Time(ms) Step Time(ms)
> > > +		0     0       11   88       22   176
> > > +		1     8       12   96       23   184
> > > +		2     16      13   104      24   192
> > > +		3     24      14   112      25   200
> > > +		4     32      15   120      26   208
> > > +		5     40      16   128      27   216
> > > +		6     48      17   136      28   224
> > > +		7     56      18   144      29   232
> > > +		8     64      19   152      30   240
> > > +		9     72      20   160      31   248
> > > +		10    80      21   168
> > > +		==== ======== ==== ======== ==== ========
> 
> Thanks,
> Abdel

-- 
Lee Jones [李琼斯]

