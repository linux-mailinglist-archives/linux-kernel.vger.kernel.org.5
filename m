Return-Path: <linux-kernel+bounces-69734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F085C858DD2
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 09:00:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 902FB1F21B86
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 08:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E7F1CD1F;
	Sat, 17 Feb 2024 08:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1d//L7cw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6551CABA
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 08:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708156804; cv=none; b=qPDSJiBpxXj7V3Y2Iq38qkO1CTXaEovTkWCMaH+jBLbYsZEwHX+ZlkG3ZdJoI9+ZVkE+jh7HmZCWX80GsG/ZdXyp+BFvzbT/NXtxIHbzSHwxnojawuXDF/pQdIIOGdoJvTaRpzjy12LPR4q1Qc3u/OwmjjQvW45qMmBEiyGsDIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708156804; c=relaxed/simple;
	bh=YzQkWpBhQRLkt7J1Vsy/RO58VHS1N5FXB32uCE4qUxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CXIdCsoXq+mUzH05W+e3g+7qWdo5iymNGyNh59tPOmpdUVrZN/jwE8WjOlIUl5UigIi6duMCd3KU7gmKn8P+//RaCmjUUgfS/IN0XqlnEqy/+GTt69mqwoopzeRF/UuIlwah+E+4SGNdfKgz2H+uKaRfOnZjTwHHWOWiOMm6YhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1d//L7cw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAD0FC433F1;
	Sat, 17 Feb 2024 08:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708156803;
	bh=YzQkWpBhQRLkt7J1Vsy/RO58VHS1N5FXB32uCE4qUxk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1d//L7cwxVEimMT9gD+J+TH8xZY2169pE1gUgpV/N8ZfWqI0QBPicttlb2cEjqOnI
	 OciP4Ct/pswdeAT8IQArHalJ6HPrYJ+1RPSq56XLWsrf4+uIAvHEf/rdLBRumNVhVZ
	 igs+CPBYVXa/E/RCyNS/q8BkGmUSepKqnbLMrGP4=
Date: Sat, 17 Feb 2024 09:00:00 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 0/2] parport: Convert to platform remove callback
 returning void
Message-ID: <2024021747-maggot-onto-30a8@gregkh>
References: <cover.1702933181.git.u.kleine-koenig@pengutronix.de>
 <cf6vlgvbbtsofdladgeqenrf5bqpn2p3vhzu2llwuu4ee5tk6i@w4h6jjexeulj>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cf6vlgvbbtsofdladgeqenrf5bqpn2p3vhzu2llwuu4ee5tk6i@w4h6jjexeulj>

On Thu, Feb 15, 2024 at 10:22:09PM +0100, Uwe Kleine-König wrote:
> Hello,
> 
> [Cc += gregkh]
> 
> On Mon, Dec 18, 2023 at 10:05:17PM +0100, Uwe Kleine-König wrote:
> > this series converts all drivers below drivers/parport to use
> > .remove_new(). See commit 5c5a7680e67b ("platform: Provide a remove
> > callback that returns no value") for an extended explanation and the
> > eventual goal. The TL;DR; is to make it harder for driver authors to
> > leak resources without noticing.
> > 
> > This is merge window material. The two patches are independent of each
> > other, so they could be applied individually.
> > 
> > Best regards
> > Uwe
> > 
> > Uwe Kleine-König (2):
> >   parport: amiga: Convert to platform remove callback returning void
> >   parport: sunbpp: Convert to platform remove callback returning void
> 
> I got no feedback for these patches since they were sent two months ago
> :-\ 
> 
> Looking at the last patches to drivers/parport, they were merged by
> Greg. Given the patches weren't sent to him, should I resend?

I can just take them directly from here, thanks!

greg k-h

