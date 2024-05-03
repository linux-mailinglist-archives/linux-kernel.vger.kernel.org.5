Return-Path: <linux-kernel+bounces-167828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C57658BAFED
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 17:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5245C1F2323D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 15:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4BD715216C;
	Fri,  3 May 2024 15:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nYRa2Eql"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8956715357A;
	Fri,  3 May 2024 15:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714750427; cv=none; b=bYiAUqUoJ/+mFTUySJbJy81VrcQAcosUT1uvGVa2uCjgUrHLWwnd3jEQnl53IaZHokG4tJYDNSNA1TOZuTf5KYx3jpUKb8UpZIoGbwX7hdWsbgNRZAV8mxOfxVj4X1KiDm06Ec3I5ZP4tKC8aFuUy977pDyjSR/VsdBJrMOZnlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714750427; c=relaxed/simple;
	bh=JXQcDcKWqzjhdoLVmcGoX/pJLAV7051JyL1j7rqs0Jo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R3n2yBsq6YoFb2Q2IF77tuaY+VuwFRKx+t3kv4s9gHQ1ip8PWmfs9mH3BppX7yK7rX6ej5InZr2ZyMq7x+IQ+yKJ7J0vg3SX747Yfu8sDVwNPEMciVOKRz6pVIov6u17sT26Cj+RMCrciUb/cukydOx/zeFTMi1sxwRaywvwE/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nYRa2Eql; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714750426; x=1746286426;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JXQcDcKWqzjhdoLVmcGoX/pJLAV7051JyL1j7rqs0Jo=;
  b=nYRa2EqljJr8J6rVpiBF3eZWhS5Y30rkmnjwqiHmCCIyhawMVNLWwe1U
   62fzBkwKTBDeJddyahyWkyUW15NjO1cYGbZwhBNOe/3ePeM5Q/Ek9Xa5x
   g6rZZZJ5DfHQ5wt8CP779NO7A0b3MHg+SdUryigX31KwP6f84XlmcuXvL
   tB0Q1DxUKHYm16wjaEeSISXVXJq6RiYjI7kaxtIHxh64iABGtsiAf3Jpe
   OWrI9qwGzV6EXvOcwIAwxZubnJKmzym6yNlyBnWjRLsqbEgWF+EXj8aV6
   jS0NPRsFGdVZAZh9HhZbGaO3pkDTKY478fYT/sxYbJQ5ttp32YUXPPuhp
   g==;
X-CSE-ConnectionGUID: FLhLzZYYRKaUk3O8ueYiRA==
X-CSE-MsgGUID: xHl3SvzuQtOlIz3FO5Zbow==
X-IronPort-AV: E=McAfee;i="6600,9927,11063"; a="21246756"
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="21246756"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 08:33:38 -0700
X-CSE-ConnectionGUID: NnLN++MEQZeMqitbiHkXBQ==
X-CSE-MsgGUID: E5c4JURLQzmMoyl+EcK2qA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="27565553"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 08:33:36 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s2uui-00000003goA-3q75;
	Fri, 03 May 2024 18:33:32 +0300
Date: Fri, 3 May 2024 18:33:32 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Parker Newman <parker@finest.io>
Cc: Parker Newman <pnewman@connecttech.com>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v1 00/13] serial: 8250_exar: Clean up the driver
Message-ID: <ZjUDzB2aRjBa9dII@smile.fi.intel.com>
References: <20240502144626.2716994-1-andriy.shevchenko@linux.intel.com>
 <20240502114645.4445b3da@SWDEV2.connecttech.local>
 <ZjO4vYEBzxU3fpzC@smile.fi.intel.com>
 <20240502120840.02c65f30@SWDEV2.connecttech.local>
 <ZjPL5z7ah-Qkct6l@smile.fi.intel.com>
 <20240502134949.5e780635@SWDEV2.connecttech.local>
 <ZjPVEr7D0lEf86kQ@smile.fi.intel.com>
 <20240503083638.0f8d9afb@SWDEV2.connecttech.local>
 <20240503104730.3e0f55d0@SWDEV2.connecttech.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240503104730.3e0f55d0@SWDEV2.connecttech.local>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, May 03, 2024 at 10:47:30AM -0400, Parker Newman wrote:
> On Fri, 3 May 2024 08:36:38 -0400
> Parker Newman <parker@finest.io> wrote:
> 
> > On Thu, 2 May 2024 21:01:54 +0300
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> >
> > > On Thu, May 02, 2024 at 01:49:49PM -0400, Parker Newman wrote:
> > > > On Thu, 2 May 2024 20:22:47 +0300
> > > > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > > > > On Thu, May 02, 2024 at 12:08:40PM -0400, Parker Newman wrote:
> > > > > > On Thu, 2 May 2024 19:01:01 +0300
> > > > > > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > > > > > > On Thu, May 02, 2024 at 11:46:45AM -0400, Parker Newman wrote:
> > > > > > > > On Thu,  2 May 2024 17:43:54 +0300
> > > > > > > > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > > > > > > >
> > > > > > > > > After a rework for CONNTECH was done, the driver may need a bit of
> > > > > > > > > love in order to become less verbose (in terms of indentation and
> > > > > > > > > code duplication) and hence easier to read.
> > > > > > > > >
> > > > > > > > > This clean up series fixes a couple of (not so critical) issues and
> > > > > > > > > cleans up the recently added code. No functional change indented by
> > > > > > > > > the cleaning up part.
> > > > > > > >
> > > > > > > > Just an FYI I submitted a patch series that fixed several of these issues but I
> > > > > > > > think it fell through the cracks (I know everyone is very busy!).
> > > > > > > >
> > > > > > > > Link: https://lore.kernel.org/linux-serial/cover.1713533298.git.pnewman@connecttech.com/
> > > > > > > >
> > > > > > > > I believe my previous patch series is no longer required. This one fixes
> > > > > > > > everything.
> > > > > > >
> > > > > > > I haven't noticed that, if it contains duplicated patches, I may replace mine
> > > > > > > with yours if you insist.
> > > > > > >
> > > > > > > In any case it's better to reply there that you prefer this series to be
> > > > > > > applied, so Greg will not pick it up.
> > > > > > >
> > > > > >
> > > > > > I do not have a preference. I am fine with using yours if it is easier on
> > > > > > the maintainers.
> > > > >
> > > > > Up to you, there is no issue to take your patches in case they are the same
> > > > > (or quite similar) as mine. I can pick them up, just tell me if you want this
> > > > > to happen with a list of the patches (as mail Message-Id).
> > > >
> > > > Just use yours.
> > >
> > > Okay, thanks!
> > >
> > > If you are going to test, better to pay attention to the BIT() conversion patch
> > > as Ilpo noted an issue. I believe it's easy to drop (via local git-rebase run)
> > > or move and test separately.
> > >
> >
> > I am working on testing now but patches 7 and 12 did not apply with git am.
> > Both failed around lines 1095/1096.
> > I can apply them manually but I may be using the wrong branch (tty-next).
> > Which branch/commit did you create your patches from? I don't see it in the
> > patch submission.
> 
> I figured it out. git am was applying the typo fix patch out of order.
> Sorry, I didn't notice that. Patches should be fine.
> 
> I can do a final test once you decide what to do with the BIT() conversion patch.

Can you revert it and test the rest? So we will know that they are okay.
Or does the above implies that you already performed such a test?

-- 
With Best Regards,
Andy Shevchenko



