Return-Path: <linux-kernel+bounces-121404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC7888E9B6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:48:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AE82B26574
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74A8131BAD;
	Wed, 27 Mar 2024 14:10:28 +0000 (UTC)
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 94A77131BB5
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 14:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.131.102.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711548628; cv=none; b=UI2RAIV52dCsLZpKtVD0Bvf307/H5MXP5+tCMSDLbkCFE0BRQHGVYAz6N+3X8iOyd9shklXXyg0rnTYSsiLqIYu88RX9f6Hq6dRvILD5UAlS7pZvjoKSvKMhimlMuae8BPXU3CxIvB5Eg6sRxezglrdFj+tDYhsaWahqUvkspo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711548628; c=relaxed/simple;
	bh=1aPizB982gPdQOZuvTieUnxfnfhAfZhPTIgVFH6+2WM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ArahqbRw0KIpop1gJPLA3idS+ikRcmBdJGAEmXK5qd5cK/cTvJdJdKkvS6V5RRBYEDBTvcRnpQiRA38eljzfmTx0BuVx9PBie/AY2Oz2ldFPXFu4cEtqL9Ve/VgW066esCajvHXKDiSkpajyQzj8luTwCHpX7bP78YLXn2sYUJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=netrider.rowland.org; arc=none smtp.client-ip=192.131.102.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netrider.rowland.org
Received: (qmail 926866 invoked by uid 1000); 27 Mar 2024 10:10:25 -0400
Date: Wed, 27 Mar 2024 10:10:25 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Norihiko Hama <norihiko.hama@alpsalpine.com>
Cc: Greg KH <gregkh@linuxfoundation.org>,
  "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
  "usb-storage@lists.one-eyed-alien.net" <usb-storage@lists.one-eyed-alien.net>,
  "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb-storage: Optimize scan delay more precisely
Message-ID: <a446cdf4-3a9b-43d8-b22b-78c20cce2b4f@rowland.harvard.edu>
References: <20240327055130.43206-1-Norihiko.Hama@alpsalpine.com>
 <2024032757-surcharge-grime-d3dd@gregkh>
 <TYVPR01MB107814D7A583CB986884AD4B290342@TYVPR01MB10781.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYVPR01MB107814D7A583CB986884AD4B290342@TYVPR01MB10781.jpnprd01.prod.outlook.com>

On Wed, Mar 27, 2024 at 07:39:55AM +0000, Norihiko Hama wrote:
> > Sorry, but module parameters are from the 1990's, we will not go back to that if at all possible as it's not easy to maintain and will not work properly for multiple devices.
> >
> > I can understand wanting something between 1 and 0 seconds, but adding yet-another-option isn't probably the best way, sorry.
> 1 second does not meet with performance requirement.
> I have no good idea except module parameter so that we can maintain backward compatibility but be configurable out of module.
> Do you have any other better solution?

Can you accomplish what you want with a quirk flag?

Alan Stern

