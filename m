Return-Path: <linux-kernel+bounces-150898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B908AA66E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 03:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06B3E1C20BDC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 01:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0180610F1;
	Fri, 19 Apr 2024 01:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CBH7fvba"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415227E1;
	Fri, 19 Apr 2024 01:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713488811; cv=none; b=ODc50PBEOcmAREGJxLcnZyzBtsOKAGL6MJG96FSVNi8eHHjtU137bj3LwuGDmBbCP8ASnpk6cfB/ksizqOTuA4ib4G6llSn2zqFomuNAKUBRYpx958HPjMYv68cxayeoNh+askOaTcUqHhpjheYM1ker6YXk2kirrI//m0T09/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713488811; c=relaxed/simple;
	bh=EQ3CcyBcQp8w9mx/NBT3AqFnKjNGXoXk69sDOl27PYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=by+L7PATm/7dS2ge0Ex108sP4br1NtCSTQ9AkZk/2zW9uENwcIF3ejN56aonjTYOBBFFvASnY65y2zEGcDiqO1gA124KiRfj+n5BA7n6Gcu3BqQchsfWCwq5DCaacHcxGetlZpgaGoFb8i0OJwfwJ8FH3HB9uCm1Q7t9rxVlZr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CBH7fvba; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E05BC113CC;
	Fri, 19 Apr 2024 01:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713488810;
	bh=EQ3CcyBcQp8w9mx/NBT3AqFnKjNGXoXk69sDOl27PYA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CBH7fvba85dqEam8PXxLBT48YbQXpn8RsNau6BkmH0dzILUxA1Vw7O7xnKMh3xI0F
	 KCDhY4ZWvqXGBjwpcP7lJzwA/FGdzmmuZoKzkcvbEw7DWMipY7+iU6JwRR+LdYcvHz
	 aZk0tvbYCr6uxEG7LmKuw8oPU301JvY3yAFSnmn6qxig7xDkBdKLDN0YX83HnkFxru
	 SbhUxj7eBy13XL+arAD8M66K7fY0xY0heuQ4KBJgogBYzfRTtaczvHndx5+V46MMrT
	 1pIaYEoMXi8d91szdProNfO5CDc0Sj7/QWDwI9qedSY6W7J2kFpfItEaHPYosKLMH1
	 qgyDTlRu24A1Q==
Date: Thu, 18 Apr 2024 22:06:46 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: [PATCH][RFT] Re: linux-next: build failure after merge of the
 perf tree
Message-ID: <ZiHDplDS5OuDvhMU@x1>
References: <20240402094116.79751030@canb.auug.org.au>
 <ZhlRn0TUkcDaAZT5@x1>
 <20240413124340.4d48c6d8@canb.auug.org.au>
 <ZiGRQZQGl0REHm9A@x1>
 <20240419091717.50ce0a81@canb.auug.org.au>
 <ZiHAqDX0AQfsQbb6@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZiHAqDX0AQfsQbb6@x1>

On Thu, Apr 18, 2024 at 09:54:03PM -0300, Arnaldo Carvalho de Melo wrote:
> On Fri, Apr 19, 2024 at 09:17:17AM +1000, Stephen Rothwell wrote:
> > On Thu, 18 Apr 2024 18:31:45 -0300 Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > > And reproduced the problem, find below a patch that reverts the patch
> > > that removes tools/include/uapi/linux/stat.h, with it applied in the
> > > sequence above right after the merge of perf-tools-next it seems to
> > > work, i.e. it builds without problems.

> > > Can you please test this so that I can get it into perf-tools-next?

> > That works for me.  Thanks for this.

> > Tested-by: Stephen Rothwell <sfr@canb.auug.org.au> # PowerPC le incermental build

> > I will apply that patch to linux-next today (if you don't have time to
> > update your tree before I merge it).

> I'm finishing some local tests here, will push perf-tools-next after
> that, some 30 minutes.

Ah, and again thanks for the report and follow up collaboration on
having these things sorted out, I'm sorry for not having this fixed
sooner, I'm taking notes to automate this type of test and have it done
before pushing branches publicly.

I just found it strange that when trying to reproduce this the problem
didn't manifested itself reliably, but then, ENOTIME to root cause this
so far, this (partial) revert is the best thing we can do now, so lets
go with it.

- Arnaldo

