Return-Path: <linux-kernel+bounces-81446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C8C867616
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:10:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26F2F1F25780
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B6B80042;
	Mon, 26 Feb 2024 13:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pfyoy3mI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8225C1CFA9
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 13:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708953002; cv=none; b=FxVFT6D540NQz0svibnUWGHNPu9PTSTvMsfvKPPn1Y30qtr2vjg9VS1L+0K++hRGcntH77dr89NeLVYnYhJsK2jSOEyx7uuV+J/jDDily/1xwCi7h0668DCLBDI0gtZY+v2Cj2aNDmlNsgRU0xPHsh3+htTGOko7hPDV1PhvT3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708953002; c=relaxed/simple;
	bh=CETfm2ZAiU7NP2W+UKDMT2EafoPo2rsh7PincvKVpA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=knYYfWlv9jBVaGZGZWMOOKqo6WP3vpi7nsCNQO/Kr0dYQOzgBeYNa5AzRU47jHvT2ZvmVyYu4gU70/HZWzXhWYw1RYXc99fiNREO+kHF7BH84kIUgrMPiFHWCw099TbellgHtXByQLKTChatdB19l8lJ6CQK++xOrygbRrNBPZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pfyoy3mI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9075BC433F1;
	Mon, 26 Feb 2024 13:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708953001;
	bh=CETfm2ZAiU7NP2W+UKDMT2EafoPo2rsh7PincvKVpA4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pfyoy3mI3LcKIKqtiEDFsyAmK1ZrZEr71DdXi945tYs2iEfyTxY7TpTbyIhMqRSAu
	 QrRw9T/3ESsBoXLNyaNfz0dWHMbBmWtygyDBShOGWiJAtjzvnRZ7aitnGNNyhHXV9q
	 kC1xNXEJbCKldiN7uSWzq9by4PfNI20WDmvplfKQ=
Date: Mon, 26 Feb 2024 14:09:59 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Mukesh Ojha <quic_mojha@quicinc.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, russ.weight@linux.dev,
	rafael@kernel.org, linux-kernel@vger.kernel.org,
	cocci@systeme.lip6.fr
Subject: Re: [PATCH vRFC 3/8] treewide: rename firmware_request_platform()
Message-ID: <2024022644-trough-humility-12b8@gregkh>
References: <20240222180033.23775-1-quic_mojha@quicinc.com>
 <20240222180033.23775-4-quic_mojha@quicinc.com>
 <2024022347-ribcage-clench-37c4@gregkh>
 <Zdi2odoYPBWywOXn@bombadil.infradead.org>
 <2024022323-accustom-eradicate-8af4@gregkh>
 <Zdj1K28NBfGfSJ-0@bombadil.infradead.org>
 <2024022452-unwilling-pancake-3b2a@gregkh>
 <ed9f2b75-38d3-8562-0476-2200e201d4c9@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed9f2b75-38d3-8562-0476-2200e201d4c9@quicinc.com>

On Mon, Feb 26, 2024 at 04:22:09PM +0530, Mukesh Ojha wrote:
> 
> 
> On 2/24/2024 11:06 AM, Greg KH wrote:
> > On Fri, Feb 23, 2024 at 11:42:35AM -0800, Luis Chamberlain wrote:
> > > On Fri, Feb 23, 2024 at 04:33:40PM +0100, Greg KH wrote:
> > > > On Fri, Feb 23, 2024 at 07:15:45AM -0800, Luis Chamberlain wrote:
> > > > > On Fri, Feb 23, 2024 at 07:21:31AM +0100, Greg KH wrote:
> > > > > > On Thu, Feb 22, 2024 at 11:30:28PM +0530, Mukesh Ojha wrote:
> > > > > > > Rename firmware_request_platform() to request_firmware_platform()
> > > > > > > to be more concrete and align with the name of other request
> > > > > > > firmware family functions.
> > > > > > 
> > > > > > Sorry, but no, it should be "noun_verb" for public functions.
> > > > > 
> > > > > News to me, do we have this documented somewhere?
> > > > 
> > > > Not really, but searching makes it nicer.
> > > > 
> > > > And yes, I violated this in the past in places, and have regretted it...
> > > 
> > > Care to share a few examples of regret?
> > 
> > 	get_device()
> > 	put_device()
> > 	kill_device()
> > 
> > vs. a saner:
> > 	kobject_get()
> > 	kobject_put()
> > 	kobject_del()
> > 
> > Learn from the mistakes of my youth please :)
> 
> Thanks for the history.,
> In that case, should we fix this verb_noun cases ?
> 
> request_firmware()
> request_firmware_into_buf()
> request_firmware_nowarn()
> request_firmware_direct()
> request_firmware_cache()
> request_partial_firmware_into_buf()
> release_firmware()

That would provide consistency, right?

thanks,

greg k-h

