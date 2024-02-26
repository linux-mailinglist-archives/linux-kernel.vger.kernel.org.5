Return-Path: <linux-kernel+bounces-81811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D347867A52
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:31:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D5B51C24E67
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719E512AAE1;
	Mon, 26 Feb 2024 15:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b="VEqQzjZW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dtsejjMD"
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09DC12BF2F
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 15:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708961455; cv=none; b=ZBzKndQRDwNFoOrNXT2BbAFFMX8dfES2pxgR0kexnrqcVQsEfPWUl403T1usiuFf7RFIXSRxTV27ZVvu0YnzT+iqcz1reayhKrrwLlXofFM74bRrPDpHnaBhHhmfpqn/6zxZLWVbDj4zDjgWhkAxtfPMhPuB8zBPLLeY8v8Grh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708961455; c=relaxed/simple;
	bh=vJWrYPv1rD63nJNI6S5N7HYEDIbe2xSJDrg8r+EnuvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rdBMYoWfJmZrpm4POg1hT5SHZMF7n6PHCof392euVHrhLbK8ml4uCtJ2MjVxQAkHZEfLwCEwkELfx1zqXkkQG+CGIBmzxBYQbcFAQqDBYVhelAUdm8CybY4cnm3Otd48wvT4gzcxF5+NS+aPznHIr6z79NU4xvc/qTiDZXO25E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza; spf=pass smtp.mailfrom=tycho.pizza; dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b=VEqQzjZW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dtsejjMD; arc=none smtp.client-ip=64.147.123.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tycho.pizza
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id 6D37B3200A4E;
	Mon, 26 Feb 2024 10:30:39 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 26 Feb 2024 10:30:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1708961438; x=1709047838; bh=E9BrEdzGh+
	86NkizWXe8ImITUXtVhnMNSPCm6NdyUQk=; b=VEqQzjZW2Ns08mQBuBol1uqUeC
	9csK9FbhJKvdnlejMpi1BbB+qB4mATv1qPfk5Oo6kj8Gm+Jd8nMYu5IFB0GaiSNs
	dexXkG6jxiM9nQsDbhm5qnuLiRG1hF8UQMUO5AaFmd+fKM2wm+aM/wQvxw+LZaE/
	bns8TQovcGMm172Q/z29xmbLD4Sad7MjxG/QRgrMk0ego8/EBrX8GLlu0kTmBU1x
	tdLtgPwQcGOwukF9aaAXLAoiTkJDwIpCHNo6y0nWqHSynSuG16rcXsgrJBoH/h7b
	g83yREHCRpH9YB0E8W7ImQn+fn5VIGbKq29owedcOoy3J5hBn3lcqNUCCJEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708961438; x=1709047838; bh=E9BrEdzGh+86NkizWXe8ImITUXtV
	hnMNSPCm6NdyUQk=; b=dtsejjMD8v5Opp1ymDM9HTgrDYRZNNXCIZL/B79bb4aD
	Gs5oCf9XG5apeSUCf2vGSCmF1kCLsn99eoMlNuQ1iI+pDTmlCbqZOH3PhcDw3aRd
	nPY5P/lxRIDyrVag6tqXi3IYxrBRS2F9/cqDTb0DadPBgArARIXB2yvWQD+P8psc
	U1KfAaL7N98Zht5Le9cxCDtLzKKM1qGge6y7P6ezT9VcJZOyIGZA3b54aGz5++/x
	+qxwONyYI3AgMCtECbEYQGWi5NeoL31go4PRSBtj/UQhrFkjnTGuF8FzW7JNzlPU
	0OJv/PHZunlDXPBUgUbub+F3+fIHO/TFQ109OoG7EA==
X-ME-Sender: <xms:nq7cZZcWMI0Dwltq_fJ94mQNP32j3kbbROeWxI8uHKNFp1ThlT5H1A>
    <xme:nq7cZXNk714vZZLxI27C-i1lehuy3xNss0Owk3ohg9HVEcl21puSzfYQUdCw54GPs
    KBHDPT3H3n1zqhp1Gs>
X-ME-Received: <xmr:nq7cZShvkctjpIbxyOclC31zGPkL8sseMhuG01V_ofyWeSRQiG3tUvWQGrE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrgedvgdejhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvhigthhho
    ucetnhguvghrshgvnhcuoehthigthhhosehthigthhhordhpihiiiigrqeenucggtffrrg
    htthgvrhhnpeeutedttefgjeefffehffffkeejueevieefudelgeejuddtfeffteeklefh
    leelteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hthigthhhosehthigthhhordhpihiiiigr
X-ME-Proxy: <xmx:nq7cZS-wjcRJL2ZDo475rIU7DljiNHrl_R9OU4H-h9oVzYypO4Dv4g>
    <xmx:nq7cZVsCNmYc5sdAuI2vPxd_gZ4acSh0Ad74_XSsr-9e809lZm0vcA>
    <xmx:nq7cZRFf56E7MVNX8mDR7f4-XShEqCufC-ruKb5sgf-mmWb1FnwHfQ>
    <xmx:nq7cZfI16Qm9sv4HEy0J3w8fj8C3A-8Qs7qE5fjZODQEeGSskIuphA>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Feb 2024 10:30:37 -0500 (EST)
Date: Mon, 26 Feb 2024 08:30:35 -0700
From: Tycho Andersen <tycho@tycho.pizza>
To: Christian Brauner <brauner@kernel.org>
Cc: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	stgraber@stgraber.org, cyphar@cyphar.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] tests/pid_namespace: add pid_max tests
Message-ID: <Zdyumw6OfWBqQMTj@tycho.pizza>
References: <20240222160915.315255-1-aleksandr.mikhalitsyn@canonical.com>
 <20240222160915.315255-3-aleksandr.mikhalitsyn@canonical.com>
 <Zdd8MAJJD3M11yeR@tycho.pizza>
 <20240223-kantholz-knallen-558beba46c62@brauner>
 <ZdoEavHorDs3IlF5@tycho.pizza>
 <20240226-gestrafft-pastinaken-94ff0e993a51@brauner>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226-gestrafft-pastinaken-94ff0e993a51@brauner>

On Mon, Feb 26, 2024 at 09:57:47AM +0100, Christian Brauner wrote:
> > > > A small quibble, but I wonder about the semantics here. "You can write
> > > > whatever you want to this file, but we'll ignore it sometimes" seems
> > > > weird to me. What if someone (CRIU) wants to spawn a pid numbered 450
> > > > in this case? I suppose they read pid_max first, they'll be able to
> > > > tell it's impossible and can exit(1), but returning E2BIG from write()
> > > > might be more useful.
> > > 
> > > That's a good idea. But it's a bit tricky. The straightforward thing is
> > > to walk upwards through all ancestor pid namespaces and use the lowest
> > > pid_max value as the upper bound for the current pid namespace. This
> > > will guarantee that you get an error when you try to write a value that
> > > you would't be able to create. The same logic should probably apply to
> > > ns_last_pid as well.
> > > 
> > > However, that still leaves cases where the current pid namespace writes
> > > a pid_max limit that is allowed (IOW, all ancestor pid namespaces are
> > > above that limit.). But then immediately afterwards an ancestor pid
> > > namespace lowers the pid_max limit. So you can always end up in a
> > > scenario like this.
> > 
> > I wonder if we can push edits down too? Or an render .effective file, like
> 
> I don't think that works in the current design? The pid_max value is per
> struct pid_namespace. And while there is a 1:1 relationship between a
> child pid namespace to all of its ancestor pid namespaces there's a 1 to
> many relationship between a pid namespace and it's child pid namespaces.
> IOW, if you change pid_max in pidns_level_1 then you'd have to go
> through each of the child pid namespaces on pidns_level_2 which could be
> thousands. So you could only do this lazily. IOW, compare and possibly
> update the pid_max value of the child pid namespace everytime it's read
> or written. Maybe that .effective is the way to go; not sure right now.

I wonder then, does it make sense to implement this as a cgroup thing
instead, which is used to doing this kind of traversal?

Or I suppose not, since the idea is to get legacy software that's
writing to pid_max to work?

Tycho

