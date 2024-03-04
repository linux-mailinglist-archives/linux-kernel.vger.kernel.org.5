Return-Path: <linux-kernel+bounces-91165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06565870A7F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 20:16:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B0111F230C1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 19:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B560D79923;
	Mon,  4 Mar 2024 19:16:50 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C818648CC7;
	Mon,  4 Mar 2024 19:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709579810; cv=none; b=YWqHGL+GjTzIoZBOTHiqCMirKs9jlUeg63YpyYRK03jsyc52RCgLG/BTZz12WGrTCpLC2+VCbQ+Tw/7BzrEAUX2VJVQmbGuLvFVVMJy88avBoyfIpm5bXTedzj0Gsyb1wP9jahN11JBRANHQFXd7YlnHIc9W+4CvrSGGI2WYw4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709579810; c=relaxed/simple;
	bh=+BMvzZC/p8UJlJ/Yb/cPBGKXL8LNozl5FUzNxsYDVPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uy0zOQPtMiOcVYt2DuxBRvsGERnKLZ34wXogTDg2A+NvFYJ+a6C6vV3bNR81f1yX5m6a3HiRZRqCQHzJJk7LWkjA4gei2FYmQ9/+kMb+lOOCI/t6u7GCN4PC6WJj1PlUhZb3pkhnRI5UgME9Wp2pDLAlVceOxtpB9UzNUAXDQng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="15498917"
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="15498917"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 11:16:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="914113434"
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="914113434"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 11:16:44 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andy.shevchenko@gmail.com>)
	id 1rhDnl-00000009nWC-38oj;
	Mon, 04 Mar 2024 21:16:41 +0200
Date: Mon, 4 Mar 2024 21:16:41 +0200
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	andrew@lunn.ch, gregory.clement@bootlin.com,
	sebastian.hesselbarth@gmail.com, pavel@ucw.cz, lee@kernel.org,
	linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 4/4] ARM: dts: marvell: Indicate USB activity on x530
Message-ID: <ZeYeGRGTuil-TsMg@smile.fi.intel.com>
References: <20240301014203.2033844-1-chris.packham@alliedtelesis.co.nz>
 <20240301014203.2033844-5-chris.packham@alliedtelesis.co.nz>
 <ZeIdXIx5zYjKQiSO@smile.fi.intel.com>
 <CAMuHMdVJiWtB4MSGHXXz=OAEvu-+b9Xp-jQ_NXWck+hwKGK4TQ@mail.gmail.com>
 <CAHp75VesLCo72ftQ2BNEKSXwF9A2pe0Vbnuves2-L3ist_twNQ@mail.gmail.com>
 <CAMuHMdXjqVQeQF6TFr1nQmUCLrEbY1gq5OdCcz6T60W33QO2-Q@mail.gmail.com>
 <CAHp75Vfh_pv50Pk84JGz6qT=K9m3w=0_HDGX2WvqEN4Nm8fFDw@mail.gmail.com>
 <CAMuHMdVuiYdjV46aS2fqPsFdW-vGK7zm_sY-LbWGYg4U0Ar5yQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdVuiYdjV46aS2fqPsFdW-vGK7zm_sY-LbWGYg4U0Ar5yQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Mar 04, 2024 at 08:01:58PM +0100, Geert Uytterhoeven wrote:
> On Mon, Mar 4, 2024 at 7:17 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Mon, Mar 4, 2024 at 11:57 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > On Sun, Mar 3, 2024 at 9:43 PM Andy Shevchenko
> > > <andy.shevchenko@gmail.com> wrote:

..

> > > So IMHO it would be a bad idea to make the DP mandatory.
> >
> > But I'm not talking about making it mandatory, I'm talking about the
> 
> OK.
> 
> > DP to be used as DP when it _is_ present and wired. If current
> > platform wants to use DP for something else, I'm pretty much worried
> > that this is the right thing to do.
> 
> There is not much we can do about that. People can already model
> such displays as individual LEDs, too.
> And in some sense, the auxdisplay/linedisp driver for
> "generic-gpio-7seg" imposes a policy, too.

Does it? It's exactly targeting very specific HW configuration. The only
question here is DP.

> What if people want to e.g. use 4 7-seg displays to show a continuously
> running snake?

We have an ABI to update a "character" mapping, so it's possible to do, but
it is not a main purpose of line display library.

Free running 7-segment display does probably belong to LED framework in that
sense (as just represents a 7 LEDs that user configured in a specific way in
the physical world). In such case it's just the 7 LEDs on a single PCB.

If you consider these limits as "policy", okay, but it's _hardware driven_
one, and not software.

-- 
With Best Regards,
Andy Shevchenko



