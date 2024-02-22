Return-Path: <linux-kernel+bounces-76181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F6B85F3EE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:06:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B887B2691D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A0913770E;
	Thu, 22 Feb 2024 09:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="itN9fHp6";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="itN9fHp6"
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796B436B02;
	Thu, 22 Feb 2024 09:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708592778; cv=none; b=bzc+RWPk8dQsK0v7rJ6haPENlYZI5ijUg9D/qKDVSI+l010bfu0fAR2DraBblKmCIoJP6JPB6s8pWofmo2986997FtEHddVUEZcOYy7PcIZVl/7nRH/zNjCuNOr0HnMvqftOxxn8qXmJebGwu4iOM2oNo4IC8HAqqZ4LA7eryvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708592778; c=relaxed/simple;
	bh=A6qL6LYkEgzw3jQG0rBz2GpF63+UvR4JQcTowuWGOf0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UsHTC3JQ1ZMqZxAjQt98pmDH8sN41glfSbDdORdPRvIhl5Ky9uqxxh7oUwMxnaaSbcEoFBOUHtGEwzLjs+JNroauMCo8BCtFKluk6uIf6/XMsDn6dWTA2QpFs08OMNEKcil6hArKYPyNrBXbkNj4t5C1uPAVYXujLBwYeX25kjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=itN9fHp6; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=itN9fHp6; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1708592772;
	bh=A6qL6LYkEgzw3jQG0rBz2GpF63+UvR4JQcTowuWGOf0=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=itN9fHp6Ii5Ewe0zC5vLvsC64OtBvfUAs8QWc2f8E7xIWfbWjoEZkSjpHcFPGso75
	 llwFR7iHXgEdS127Bd3osGqbyPelaAlc7COS5wxMHRGDqnwwtDyRkgnYMYkOeUJoSL
	 XXgsG19oOEUOcfKk2VXaVMP+nH6v3OxvbTDDEfsI=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id AED4B1286587;
	Thu, 22 Feb 2024 04:06:12 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id irqCIaH1qFpv; Thu, 22 Feb 2024 04:06:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1708592772;
	bh=A6qL6LYkEgzw3jQG0rBz2GpF63+UvR4JQcTowuWGOf0=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=itN9fHp6Ii5Ewe0zC5vLvsC64OtBvfUAs8QWc2f8E7xIWfbWjoEZkSjpHcFPGso75
	 llwFR7iHXgEdS127Bd3osGqbyPelaAlc7COS5wxMHRGDqnwwtDyRkgnYMYkOeUJoSL
	 XXgsG19oOEUOcfKk2VXaVMP+nH6v3OxvbTDDEfsI=
Received: from [10.236.41.91] (unknown [88.128.88.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 73B0B1286557;
	Thu, 22 Feb 2024 04:06:09 -0500 (EST)
Message-ID: <354bf802d27ea995858e41dd90d9a83ffc6739aa.camel@HansenPartnership.com>
Subject: Re: [PATCH 1/3] tpm: protect against locality counter underflow
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Jarkko Sakkinen <jarkko@kernel.org>, Lino Sanfilippo
 <l.sanfilippo@kunbus.com>, Alexander Steffen
 <Alexander.Steffen@infineon.com>,  "Daniel P. Smith"
 <dpsmith@apertussolutions.com>, Jason Gunthorpe <jgg@ziepe.ca>, Sasha Levin
 <sashal@kernel.org>,  linux-integrity@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Ross Philipson <ross.philipson@oracle.com>, Kanth Ghatraju
	 <kanth.ghatraju@oracle.com>, Peter Huewe <peterhuewe@gmx.de>
Date: Thu, 22 Feb 2024 10:06:05 +0100
In-Reply-To: <CZB0I9OAGNHT.1HTSJU3925RBY@seitikki>
References: <20240131170824.6183-1-dpsmith@apertussolutions.com>
	 <20240131170824.6183-2-dpsmith@apertussolutions.com>
	 <CYU3CFW08DAA.29DJY7SJYPJJZ@suppilovahvero>
	 <2ba9a96e-f93b-48e2-9ca0-48318af7f9b1@kunbus.com>
	 <ae3fecc4-7b76-4607-8749-045e17941923@infineon.com>
	 <91f600ef-867b-4523-89be-1c0ba34f8a4c@kunbus.com>
	 <CZA9CM3PDILC.82JMLUWMB6B7@seitikki> <CZA9GMC718HA.1JFHTTWV563IE@seitikki>
	 <7a7f8f0c1b9d124bfc01b66082abf2d8445564ce.camel@HansenPartnership.com>
	 <CZB0I9OAGNHT.1HTSJU3925RBY@seitikki>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 2024-02-21 at 19:43 +0000, Jarkko Sakkinen wrote:
> On Wed Feb 21, 2024 at 12:37 PM UTC, James Bottomley wrote:
> > On Tue, 2024-02-20 at 22:31 +0000, Jarkko Sakkinen wrote:
[...]
> > >  I cannot recall out of top of my head can
> > >    you have two localities open at same time.
> > 
> > I think there's a misunderstanding about what localities are:
> > they're effectively an additional platform supplied tag to a
> > command.  Each command can therefore have one and only one
> > locality.  The TPM doesn't
> 
> Actually this was not unclear at all. I even read the chapters from
> Ariel Segall's yesterday as a refresher.
> 
> I was merely asking that if TPM_ACCESS_X is not properly cleared and
> you se TPM_ACCESS_Y where Y < X how does the hardware react as the
> bug report is pretty open ended and not very clear of the steps
> leading to unwanted results.

So TPM_ACCESS_X is *not* a generic TPM thing, it's a TIS interface
specific thing.  Now the TIS interface seems to be dominating, so
perhaps it is the correct programming model for us to follow, but not
all current TPMs adhere to it.

> With a quick check from [1] could not spot the conflict reaction but
> it is probably there.

The way platforms should handle localities is now detailed in the TCG
library code snippets (part 4 Supporting Routines - Code):

https://trustedcomputinggroup.org/resource/tpm-library-specification/

It's the _plat__LocalityGet/Set in Appendix C

The implementation documented there is what the TPM reference
implementation follows.

James


