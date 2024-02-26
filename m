Return-Path: <linux-kernel+bounces-81865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F14867B21
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:06:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F65E1C291F1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D7B12CD8E;
	Mon, 26 Feb 2024 16:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="z8FjqaeI"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE23912C819
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 16:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708963576; cv=none; b=WJJYnYAmQowfIhddfJHKpAY8nRz5TN2JfCdmO2JgOuaMvh/EUJFv/MqjSk/E1FFOYTVBJpt7c94VYkuj6MN5h9XLG7eM8a2rV5iysFlZ2KiT/jpNBBZ1zRohezLe2BDF5hbJRxiQ5QkURpGygpg8/p5VubaWsMEyRiy/b6VdwIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708963576; c=relaxed/simple;
	bh=0vWCW341aYdqTh1i18g1rVlJHLBtC/3TVzzqVYsIBwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R33XT6iEnX1Kui14iOcDLv3KhDwwevxn9Ikw8gSqH2L4X6u4NtoMKklDQJFcB/uUkuWdKb5OBaz8R2Vzgtrs4783SkipUihR9kInH9dssqr56Fom1ufi9NGi+NeQrykt8qt2cRUoGjNF0nwdIEJyefCADXrbpdCdOYudci4uekY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=z8FjqaeI; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4w0pyzX13oH7yLsHCQxEK+jhZJgnfrrDCDdIA5IXYd4=; b=z8FjqaeIAOZZfC5MFb+Xs4/vCB
	HwnEct+tTsPNSnbxcmxb/SYlMfMwT4KjUdaCdRIlCBFm/5bJ055WLFshTnVSmvoybocid2vLb3uB4
	NHH4IxuqSHTgK5sAQ/ISJXyXOwSTX5lbOoh5GNH6odn0gVRZsBpNGYLxnXsblJcMksO2y772ESNcy
	7EN0z0EqIc206fNGT+R9oxDSFZ0zlK8VW+tJx5fWXM7BZrZMb2Bkhm3a47RG262+X5hzFAWBpQ6Y+
	kOlMGEpRS4SuFKsIECQoclDN/cm7V2OoLxMb+gmYfBMNmP1IiM0eQeKhfdOC1KQxAE5LV8RusT24J
	+LXuHhlA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1redUb-00000001ZMw-01gl;
	Mon, 26 Feb 2024 16:06:13 +0000
Date: Mon, 26 Feb 2024 08:06:12 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Mukesh Ojha <quic_mojha@quicinc.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, russ.weight@linux.dev,
	rafael@kernel.org, linux-kernel@vger.kernel.org,
	cocci@systeme.lip6.fr
Subject: Re: [PATCH vRFC 3/8] treewide: rename firmware_request_platform()
Message-ID: <Zdy29AwHwjne8aq_@bombadil.infradead.org>
References: <20240222180033.23775-1-quic_mojha@quicinc.com>
 <20240222180033.23775-4-quic_mojha@quicinc.com>
 <2024022347-ribcage-clench-37c4@gregkh>
 <Zdi2odoYPBWywOXn@bombadil.infradead.org>
 <2024022323-accustom-eradicate-8af4@gregkh>
 <Zdj1K28NBfGfSJ-0@bombadil.infradead.org>
 <2024022452-unwilling-pancake-3b2a@gregkh>
 <ed9f2b75-38d3-8562-0476-2200e201d4c9@quicinc.com>
 <2024022644-trough-humility-12b8@gregkh>
 <f142baba-619c-940c-9ceb-7c0d9c8ca7dc@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f142baba-619c-940c-9ceb-7c0d9c8ca7dc@quicinc.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Mon, Feb 26, 2024 at 06:52:49PM +0530, Mukesh Ojha wrote:
> 
> 
> On 2/26/2024 6:39 PM, Greg KH wrote:
> > On Mon, Feb 26, 2024 at 04:22:09PM +0530, Mukesh Ojha wrote:
> > > 
> > > 
> > > On 2/24/2024 11:06 AM, Greg KH wrote:
> > > > On Fri, Feb 23, 2024 at 11:42:35AM -0800, Luis Chamberlain wrote:
> > > > > On Fri, Feb 23, 2024 at 04:33:40PM +0100, Greg KH wrote:
> > > > > > On Fri, Feb 23, 2024 at 07:15:45AM -0800, Luis Chamberlain wrote:
> > > > > > > On Fri, Feb 23, 2024 at 07:21:31AM +0100, Greg KH wrote:
> > > > > > > > On Thu, Feb 22, 2024 at 11:30:28PM +0530, Mukesh Ojha wrote:
> > > > > > > > > Rename firmware_request_platform() to request_firmware_platform()
> > > > > > > > > to be more concrete and align with the name of other request
> > > > > > > > > firmware family functions.
> > > > > > > > 
> > > > > > > > Sorry, but no, it should be "noun_verb" for public functions.
> > > > > > > 
> > > > > > > News to me, do we have this documented somewhere?
> > > > > > 
> > > > > > Not really, but searching makes it nicer.
> > > > > > 
> > > > > > And yes, I violated this in the past in places, and have regretted it...
> > > > > 
> > > > > Care to share a few examples of regret?
> > > > 
> > > > 	get_device()
> > > > 	put_device()
> > > > 	kill_device()
> > > > 
> > > > vs. a saner:
> > > > 	kobject_get()
> > > > 	kobject_put()
> > > > 	kobject_del()
> > > > 
> > > > Learn from the mistakes of my youth please :)
> > > 
> > > Thanks for the history.,
> > > In that case, should we fix this verb_noun cases ?
> > > 
> > > request_firmware()
> > > request_firmware_into_buf()
> > > request_firmware_nowarn()
> > > request_firmware_direct()
> > > request_firmware_cache()
> > > request_partial_firmware_into_buf()
> > > release_firmware()
> > 
> > That would provide consistency, right?
> 
> Yes, Below names look better..
> 
> firmware_request()
> firmware_request_into_buf()
> firmware_request_nowarn()
> firmware_request_direct()
> firmware_request_cache()
> firmware_request_partial_into_buf()
> firmware_release()
> 
> @Luis/Others, Can we do this change ?

Go for it. I just also think we might as well document from the learnt
lessons, and our preference, instead of making this just one developer's
personal preference because the moon made them feel a different way than
two years ago. From my part it is best we *strive* to stick to one
convention, whatever it is. As for the *why* to document this, I suspect
it allows easier namespace grep'ing for symbols related to one thing or
another, as to why it shoudl go first, I'll let Greg chime in.

Long term I see value in having anything we decide to stick to, to make it
easier for debugging heuristics.

  Luis

