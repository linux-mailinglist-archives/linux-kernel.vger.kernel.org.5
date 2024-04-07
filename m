Return-Path: <linux-kernel+bounces-134309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C332D89B023
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 11:46:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F07021C20C7E
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 09:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75BF817554;
	Sun,  7 Apr 2024 09:46:12 +0000 (UTC)
Received: from fgw22-4.mail.saunalahti.fi (fgw22-4.mail.saunalahti.fi [62.142.5.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6249F13AF9
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 09:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712483172; cv=none; b=JmPTiOrAl35dgnb6LbBwTPMVt3q5t6izHCxZFFqs08DOgbl7d3L0sZxox/akx1MkYe4MT+9Q6XZT3mZrDeJtcWvMJ80JPnjTKSxK+NFwu08kEFZOUAB8oHqYY7/xxilIPAgB4cUnRQorLFvzxEBmydpFKBM6hQhJwxAZIxpWUIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712483172; c=relaxed/simple;
	bh=MO/qmJcezZj5tAJgWw3Dh9g/o6Eajzx5fxXnsevPDng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dVWHaTgggKerTu8vDZgEec4ZKI73YdtmYoWMD9yhKzg1acLnmYqoJM4368I7SpOjP1SbFX69Dsz3Jw5jMzNxpA7WLD6KcvS8tvqrLIPzlP8V1JeILwmQwd/AvvMK/y+8JajfauwYNTUW9RRrdZ+tac3EovwU0Q3k8mp7wskxCvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=fail smtp.mailfrom=iki.fi; arc=none smtp.client-ip=62.142.5.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iki.fi
Received: from ydin.reaktio.net (unknown [85.76.255.15])
	by fgw22.mail.saunalahti.fi (Halon) with ESMTP
	id 7f66dd16-f4c3-11ee-a9de-005056bdf889;
	Sun, 07 Apr 2024 12:44:59 +0300 (EEST)
Received: by ydin.reaktio.net (Postfix, from userid 1001)
	id C050420089; Sun,  7 Apr 2024 12:44:58 +0300 (EEST)
Date: Sun, 7 Apr 2024 12:44:58 +0300
From: Pasi =?iso-8859-1?Q?K=E4rkk=E4inen?= <pasik@iki.fi>
To: Oleksandr Natalenko <oleksandr@natalenko.name>
Cc: linux-kernel@vger.kernel.org, Norbert Preining <norbert@preining.info>,
	stable@vger.kernel.org, regressions@leemhuis.info
Subject: Re: Regression in kernel 6.8.2 fails in various ways (USB, BT, ...)
Message-ID: <20240407094458.GB28090@reaktio.net>
References: <ZgvkIZFN23rkYhtS@burischnitzel>
 <6139700.lOV4Wx5bFT@natalenko.name>
 <20240406182943.GG1099@reaktio.net>
 <2724514.mvXUDI8C0e@natalenko.name>
 <20240407093931.GA28090@reaktio.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240407093931.GA28090@reaktio.net>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Sun, Apr 07, 2024 at 12:39:31PM +0300, Pasi Kärkkäinen wrote:
> > > 
> > > I noticed possible related USB problem/regression also with Linux 6.7.11, eg. my USB headset is not detected at all anymore when running Linux 6.7.11. USB headset works OK with Linux 6.7.9, so the regression is included/backported to also either in 6.7.10 or in 6.7.11.
> > 
> > It wound be nice to narrow this range down even further with bisection because there are too many changes between v6.7.9 and v6.7.11 that could cause this.
> > 
> 
> I just tested more Fedora kernel rpms, and it seems Linux 6.7.10 still works OK,
> but 6.7.11 has the regression (eg. USB devices not detected, laptop does not reboot 
> as it gets stuck before resetting the machine).
> 
> So the regression was backported to Linux 6.7.11.
> 

And with more testing interestingly it seems Linux 6.7.12 already fixes the problem.

I tried multiple times: 6.7.10 works, 6.7.11 doesn't, and 6.7.12 again works.


-- Pasi


