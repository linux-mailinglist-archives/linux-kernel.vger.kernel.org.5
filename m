Return-Path: <linux-kernel+bounces-13402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C7E82049E
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 12:34:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8502E1C20E5E
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 11:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486677493;
	Sat, 30 Dec 2023 11:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O8UwZWxi"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936D98BE7;
	Sat, 30 Dec 2023 11:34:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D9ADC433C7;
	Sat, 30 Dec 2023 11:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703936040;
	bh=e4zIj9WN1rHOoaFgv5qNtqov46wr61rNTXnZQylXXXg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=O8UwZWxiI8abpS9S3Lbzp3CPK0eqfMjQb8MxCb4ajF5b2Lw/b81zF9pvi64laJn7h
	 FQjvOzNMA9nRZgsoGmd+qKq7Hiz07IfoAtI7+igco24jicf+IDTtKIypIbPLufzxwB
	 EEk46PwTcc6kMTIios4IdViifsNwTLZS/tX9h0JuDgzw0NyPASanMUPtc9YwiPYOPw
	 bk6gBmqQgp3qakzg+tjBMbJaQYxpPShB8DJHCmNV3GwXl05cM6RIkeqTc/bKVSr3WE
	 /K6My5E7LrgKED24TcamFDb6b7YiJEPA1FcbX9DfRk+ICfZDsnw0G3FP/XR37xMzH5
	 AF8odw6CUHh6g==
Date: Sat, 30 Dec 2023 11:33:54 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Andreas Klinger
 <ak@it-klinger.de>, Lars-Peter Clausen <lars@metafoo.de>, Angel Iglesias
 <ang.iglesiasg@gmail.com>, Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v2 07/10] iio: pressure: mprls0025pa.c whitespace
 cleanup
Message-ID: <20231230113354.0abaa6c1@jic23-huawei>
In-Reply-To: <ZYxhUJlAb63wRJE-@sunspire>
References: <20231224143500.10940-1-petre.rodan@subdimension.ro>
	<20231224143500.10940-8-petre.rodan@subdimension.ro>
	<ZYxSERlEAfwWpqWP@smile.fi.intel.com>
	<ZYxhUJlAb63wRJE-@sunspire>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 Dec 2023 19:39:28 +0200
Petre Rodan <petre.rodan@subdimension.ro> wrote:

> On Wed, Dec 27, 2023 at 06:34:25PM +0200, Andy Shevchenko wrote:
> > On Sun, Dec 24, 2023 at 04:34:52PM +0200, Petre Rodan wrote:  
> > > Fix indentation and whitespace in code that will not get refactored.
> > > 
> > > Make URL inside comment copy-paste friendly.  
> >   
> > >  			return dev_err_probe(dev, ret,
> > > -				"honeywell,pmin-pascal could not be read\n");
> > > +				   "honeywell,pmin-pascal could not be read\n");  
> > 
> > As done elsewhere, here and in other similar places fix the indentation
> > by making first character on the latter line to be in the same column as
> > the first character after the opening parenthesis.  
> 
> I triple-checked that I am following the max 80 column rule, the parenthesis
> rule and the 'do not split printk messages' rules in all my code in these 10 patches.
> precisely so I don't get feedback like this one.
> if the parenthesis rule makes the line longer then 80 chars I right-align to
> column 80 as seen above.

I'm not aware of (and can't immediately see) anything about right aligning to 80
columns.  It's fine to align it less if line length is long but normally people
go with aligning to one tab more than the start of the block.

> that is what I understand from the latest coding style document and that is what
> I will follow.
> 
> in this particular case if I were to ignore the 80 column rule we would end up on
> column 90 if I were to follow your feedback (open parenthesis is at column 45
> and the error takes 45 chars more).

It's fine to do this in the interests of readability.

People differ in opinion on what constitutes 'significant readability' and I'd
be happy with either a shorter alignment (single tab more than line above)
or going over 80 chars in this case.

Jonathan

> 
> peter
> 


