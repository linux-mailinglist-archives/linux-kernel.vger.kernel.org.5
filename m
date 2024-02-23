Return-Path: <linux-kernel+bounces-78614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 979C78615E3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:33:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF3151C24369
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1A0823D9;
	Fri, 23 Feb 2024 15:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WklkA4+A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2EE10A3E
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 15:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708702424; cv=none; b=NwbMlPYUn1XNASNJf47B6kPWXlg0mrRZaqU011BYGzB4XBTNmNJYbzirTPVr0YjA0gQlp/Y/xKeiK5CAwMQd2BJgsptd2FcD8gtYhdYvHpFNsSJzGTDIdD5YbXvAS1NnS7vVuDecPO0gJd3kIcaZfmGAZ/FDzETJHqPwInD6rNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708702424; c=relaxed/simple;
	bh=KOyYNN4sawLmarmFXwEDwpnsf8VJet7cZEbLu6KFV6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xe3eesYQ7sqXQkoj5Ij54/vDUhC3I04RS8hBRjulSmgG8oodCSxCsxBZQ69eSfRdhminaghBcUePW4lqN7V+u9aepWl3Iv6rJ2P0qYMlvIYryg0jxgUE6OZEFDc1fOfdets40hdGzu2bMVmhF6kkYV6lNnJ8l07wgrkf8TDgcLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WklkA4+A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0070C433C7;
	Fri, 23 Feb 2024 15:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708702423;
	bh=KOyYNN4sawLmarmFXwEDwpnsf8VJet7cZEbLu6KFV6E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WklkA4+AxcwO46gmT3z1yG2l227y/JSWaLobbiHU7VJEPhujD0rz88AOb7ApI4OKa
	 6UJgzPc/UGSppjm7cMj1+gjzOclv4TQ9TTVThFjsoQLroDG/pCvtloym/U7RluTaLM
	 GoWuxI9+2j79t3ttyL7uK1apZC9YL+1JO4bmNcBo=
Date: Fri, 23 Feb 2024 16:33:40 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Mukesh Ojha <quic_mojha@quicinc.com>, russ.weight@linux.dev,
	rafael@kernel.org, linux-kernel@vger.kernel.org,
	cocci@systeme.lip6.fr
Subject: Re: [PATCH vRFC 3/8] treewide: rename firmware_request_platform()
Message-ID: <2024022323-accustom-eradicate-8af4@gregkh>
References: <20240222180033.23775-1-quic_mojha@quicinc.com>
 <20240222180033.23775-4-quic_mojha@quicinc.com>
 <2024022347-ribcage-clench-37c4@gregkh>
 <Zdi2odoYPBWywOXn@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zdi2odoYPBWywOXn@bombadil.infradead.org>

On Fri, Feb 23, 2024 at 07:15:45AM -0800, Luis Chamberlain wrote:
> On Fri, Feb 23, 2024 at 07:21:31AM +0100, Greg KH wrote:
> > On Thu, Feb 22, 2024 at 11:30:28PM +0530, Mukesh Ojha wrote:
> > > Rename firmware_request_platform() to request_firmware_platform()
> > > to be more concrete and align with the name of other request
> > > firmware family functions.
> > 
> > Sorry, but no, it should be "noun_verb" for public functions.
> 
> News to me, do we have this documented somewhere?

Not really, but searching makes it nicer.

And yes, I violated this in the past in places, and have regretted it...

> > Yes, we mess this up a lot, but keeping the namespace this way works out
> > better for global symbols, so "firmware_*" is best please.
> 
> We should certainly stick to *one* pattern, for the better, and it
> occurs to me we could further review this with a coccinelle python
> script for public functions, checking the first two elements of a public
> function for noun and verb.

Changing the existing function names for no real reason isn't probably a
good idea, nor worth it.  The firmware_* function prefix is good, let's
keep it please.

If you really wanted to be picky, we should make them part of a module
namespace too :)

thanks,

greg k-h

