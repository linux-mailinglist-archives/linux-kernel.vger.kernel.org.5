Return-Path: <linux-kernel+bounces-132498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B0A8995E4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 08:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9332C287D96
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 06:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240CE2557A;
	Fri,  5 Apr 2024 06:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sE6cB/Tp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EKJAZvcr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4E32C691;
	Fri,  5 Apr 2024 06:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712299932; cv=none; b=Sp2OAE4vUh3KLhAmibCItt0dDeS/GTgnSHHmYy6vWKugDcSl1GCQ5JXHxvnaKrq6gJ+oY9txpTsnq5YzdZ3sgy3wQgCS5WhhTaBvHdkeZu3X1DehwksNfIyp5iUujslpPeng2a+suKjBajAHUJHToXq5rmHnwZljPE7x5/ywwO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712299932; c=relaxed/simple;
	bh=0upqfH+hmSvdsDYytEA9yQ9PQdfhWTsqbdptUKyCMFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pLP272dilT3XooP2ygqDoW/SOPS0vMr7r3owm25kgZMQiLx0I9a+WONOKbzXk7MHzxDDdUTzJuG9GYWeIxVE5nISbDBgUpItaqOP5kEoKtqDl3OmSD2gWZLwDwOTsl8WDETGIHtnjonv8/RYvScFC2A2NrBUKsh9nJd240D1cQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sE6cB/Tp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EKJAZvcr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 5 Apr 2024 08:52:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712299928;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MWsjPvs3s+wQ+qMdp2q2teQ93TV5fEuMHC3tI1ptgwM=;
	b=sE6cB/Tpeu0t+6Tg1cZ39s25Ly1iXImBE65RY6Ozq/m2cgbp0P70pNPBiQE9FfOSoRw1Qx
	dJjph8xvLX3gmDjscQCONIx5FQLHDE6e2WG13rmCv/TsQVbGeH+CXs61EJhZ+IoOQO4Pmm
	HbPBTgXqbhizPQYkPsD3Pf5gKPN0KFTT1joIK8486BjmCi8wP35eLAl3rkpw06EUe4EWsi
	cLA4uTSDGvKuY9hyk+oLzYkp8MwUCqXshJQAsLk8/xEuQbFKsA6NB4Oaf2dym4s8rjaNuZ
	A0h8z4Oqq07PRb8YNyR4bOUoy73XBXvZFDfoeHhop9aRlpif3zbbLojxm0ykHw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712299928;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MWsjPvs3s+wQ+qMdp2q2teQ93TV5fEuMHC3tI1ptgwM=;
	b=EKJAZvcrRDA9kVHPORNLck/fOUJykfQZYzp/HPERq7LUcXoEJ7y6UUFcfE7vxyIUwf/DiK
	Oum3hg6yhgnLXfBw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "John B. Wyatt IV" <jwyatt@redhat.com>
Cc: John Ogness <john.ogness@linutronix.de>, Petr Mladek <pmladek@suse.com>,
	Clark Williams <williams@redhat.com>,
	Juri Lelli <jlelli@redhat.com>, Derek Barbosa <debarbos@redhat.com>,
	Bruno Goncalves <bgoncalv@redhat.com>,
	"John B. Wyatt IV" <sageofredondo@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: NMIs reported by console_blast.sh with 6.6.20-rt25
Message-ID: <20240405065206.uMCEN-CK@linutronix.de>
References: <ZfSfrzak9WS0ZFv7@thinkpad2021>
 <20240322122921.U3WRsO4X@linutronix.de>
 <ZgSvVCDja6yFCC0Y@thinkpad2021>
 <20240402103414.KkkX5RuV@linutronix.de>
 <Zg9BhxtWepFZyH8t@hatbackup>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zg9BhxtWepFZyH8t@hatbackup>

On 2024-04-04 20:10:47 [-0400], John B. Wyatt IV wrote:
> I reran the 6.6 test and no NMI was reported with fully preemptive and
> the realtime tuned profile. It was my error; my apologies for that.

no worries. 

> I did include more of logs if you want to see here for my 6.8 testing.
> 
> https://lore.kernel.org/linux-rt-users/ZgWL2UyknaE2T70C@thinkpad2021/T/#u

I looked over it and it seems we are good.
Thanks for testing.

> Sincerely,
> John Wyatt
> Software Engineer, Core Kernel
> Red Hat

Sebastian

