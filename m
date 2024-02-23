Return-Path: <linux-kernel+bounces-79046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC89861CBD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 20:43:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E34C9B23A65
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 19:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B03F145B3B;
	Fri, 23 Feb 2024 19:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bf/EeXLc"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFFD1448FF
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 19:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708717359; cv=none; b=vEWr7CiDfFlDRyiqwGEZNu6vn4lJVJOjfM5Kqbl6saF7GoN2jXrfyxANpnsZtVUGWrkqU8ZnPMdDj30y/0F1TxuuIIz+NO6YdfkSr5zDSlAPTUcF+8hhcQACO/q6FnBo82GAcB58uTIe2t3lAHgh7+5NwsShL9cNEiT9HVDnwGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708717359; c=relaxed/simple;
	bh=8OxXWHAzXlBUP+dlP13J7itnoNWBwezp5JnB6Gnlsb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EqcuHkevm+I7S3S92+7kiBIa8iweQJFqB+nH275EKo6jznWDU2CCnrkbhwyxK1T2maNtdZaCsiRPWdQ8TdxFDaqOFFU18dUGwtze1fXYDd/Jptnl8nVj9qZyRCyvgCQXjBKfc5k1mUk9GKxgXTijVshfCGzhtj1eXcU1lVBIV1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bf/EeXLc; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+JlNdL9EgGVnJWuirBUTz09vxL3UyzgcwJYPKs+nBcU=; b=bf/EeXLcrApq2LMdc6oFZJfUfW
	57WDcwwVo5kOX0apDOtKySTGVLwSlCw8QPZpKgMggfFK6cZ0KayLDWGsAGqWAcWpboEzrLtk6BG+d
	Wh24fBrw0OYgiNTTfLIjk4VV/581DcAEX7ltQ/Pms5LbNRknHmuV/BMOpHZvwaQI8oDc6JfEogyjT
	EU9gwU14KDBQq5xQ87bVyFX+T/aPlRE39R9WDOaacey4ZkQYMPwYpQp9iu4asjhUTDGdSMWnid9GG
	jnxRxCskQIjH/1b8S3iZFfS6FY0XgCMyrdLqNQ/jFVy+B8Cxb2+Y7shsQN/FS9Xa744fH+5K4U5LF
	5PBthYrg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdbRL-0000000B2mm-2UiI;
	Fri, 23 Feb 2024 19:42:35 +0000
Date: Fri, 23 Feb 2024 11:42:35 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Mukesh Ojha <quic_mojha@quicinc.com>, russ.weight@linux.dev,
	rafael@kernel.org, linux-kernel@vger.kernel.org,
	cocci@systeme.lip6.fr
Subject: Re: [PATCH vRFC 3/8] treewide: rename firmware_request_platform()
Message-ID: <Zdj1K28NBfGfSJ-0@bombadil.infradead.org>
References: <20240222180033.23775-1-quic_mojha@quicinc.com>
 <20240222180033.23775-4-quic_mojha@quicinc.com>
 <2024022347-ribcage-clench-37c4@gregkh>
 <Zdi2odoYPBWywOXn@bombadil.infradead.org>
 <2024022323-accustom-eradicate-8af4@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024022323-accustom-eradicate-8af4@gregkh>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Fri, Feb 23, 2024 at 04:33:40PM +0100, Greg KH wrote:
> On Fri, Feb 23, 2024 at 07:15:45AM -0800, Luis Chamberlain wrote:
> > On Fri, Feb 23, 2024 at 07:21:31AM +0100, Greg KH wrote:
> > > On Thu, Feb 22, 2024 at 11:30:28PM +0530, Mukesh Ojha wrote:
> > > > Rename firmware_request_platform() to request_firmware_platform()
> > > > to be more concrete and align with the name of other request
> > > > firmware family functions.
> > > 
> > > Sorry, but no, it should be "noun_verb" for public functions.
> > 
> > News to me, do we have this documented somewhere?
> 
> Not really, but searching makes it nicer.
> 
> And yes, I violated this in the past in places, and have regretted it...

Care to share a few examples of regret?

> > > Yes, we mess this up a lot, but keeping the namespace this way works out
> > > better for global symbols, so "firmware_*" is best please.
> > 
> > We should certainly stick to *one* pattern, for the better, and it
> > occurs to me we could further review this with a coccinelle python
> > script for public functions, checking the first two elements of a public
> > function for noun and verb.
> 
> Changing the existing function names for no real reason isn't probably a
> good idea, nor worth it.  The firmware_* function prefix is good, let's
> keep it please.
> 
> If you really wanted to be picky, we should make them part of a module
> namespace too :)

Sticking to *any* convention is good, so longa as we decide on one, it
used to be hard to have tidy rules to do this sort of stuff but with
coccinelle we should be able to grow these rules and ensure we stick
to it for the good for new stuff.

  Luis

