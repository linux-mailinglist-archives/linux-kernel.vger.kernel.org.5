Return-Path: <linux-kernel+bounces-55348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F0F84BB8D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 18:04:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69BC51C23FA2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 17:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211106AA0;
	Tue,  6 Feb 2024 17:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b="PdkpBL6u";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nFK0Oj36"
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF94DF67
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 17:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707239053; cv=none; b=dCeVfjfz5WCpiUKTQWaq4XHCozYdsf/ZDf4I13xL1QuGHwLZKEV2isJrm6WiTe54SchrAZSlVlgyM+K3W4TUKdNyrMdC0qV6OCOyfGxcZ1+M2zbYfF0fDbF5EMCTBDB2xjepcxqQXgEeimMKuvjEUaI2mrcrh4AVg0s5tuj8SUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707239053; c=relaxed/simple;
	bh=q/OfiRJpq+x5oplySSR5jJ5wnGPv1JYrJIt8jWN2g44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DjXkyR+NIMTk6bi1VFCJoULWRUUUdG86ZSBJ/wvitsol7mZfCbTsX3YZV9kqA4HlbqXS/ehl/86jp9iDwVeh+HionGyzt7eJICkMWhkY4M/L4CJ7RJJ33Uyk3HxBupFnZfkuNIFqNVFLTjgmbTyJF44Xg7fUIfLtYOocUV5BTeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza; spf=pass smtp.mailfrom=tycho.pizza; dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b=PdkpBL6u; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nFK0Oj36; arc=none smtp.client-ip=66.111.4.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tycho.pizza
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 3670D5C01CC;
	Tue,  6 Feb 2024 12:04:10 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 06 Feb 2024 12:04:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1707239050; x=1707325450; bh=VN8Cd/6/QU
	IMRCH56wbkEB8qncG2Wz7ukEomi/HXzmw=; b=PdkpBL6uXWQh544B3B7Muxtw5B
	TgSqYOcRkvNUeSjItgvFabWYGEVty1rt+2At/Z9msuJC4yTt1i2UKi/OuJo6peJg
	5pY9nY8hgXQINpWEYhzqM250HMysGLGWgE6T18Ct9FzmzUjZ+EfpL+oYbCOxQBGB
	HBE3hUZm+ivOWFJTKT+upcUxf3y3kL6tOvMepjxPpGsqhTWTtjTFNalmWwEdJwfr
	PtmxG5aV83permqbJgCjghi25jgAhFrZfimD8vOD1XLx2kEgN2iAKKfF/J62OX2S
	iAw4C/u8ETNyYcWebuvHC0RDsDSdMmMHLZSrPoGmQnObLBKAFlaYrDvOncFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707239050; x=1707325450; bh=VN8Cd/6/QUIMRCH56wbkEB8qncG2
	Wz7ukEomi/HXzmw=; b=nFK0Oj36OyM4CdWrQx9JbFjjeu3YHOUWnmncUuN6Y8qk
	Pwg4sqlRT6X3Lr6xHrg4GctS2IYHVO393i7mIF8nwnKiNQrZ+XeXn8L/OzIwqyDA
	cvNFOh8skoNzTsJbU7VcGvMVcnhjqVyxjjMq1fvvKpHzBOsVGmEpd4TC9a2Oetu4
	JC4fZzUIlOl0hIAYRtLRJRIGD7O0ZH26Xu8Mpkn/w4flBckGbGnNw3CULLHD/d4N
	ZTnVkLTyFjvI57XKjfb1dnrIc0WaBkD9ZPDQ6bT68NyBSb+HuTVi5R+XQ39ZmqmP
	Rw3FAevWBvDmeujJD8FXAN/ciMEbJHke5xhfAqzIBw==
X-ME-Sender: <xms:iWbCZe08cKnJtQgTMhVWLvGXw7GvtPNsEQlx9rd9t3J6KKiLD5Gm4A>
    <xme:iWbCZRH7-PPNABfYQB838B5Ce54-1fKGy6C3jqMsCGIfBlwXuZyZsdLexIBUuNbrL
    MGp5bdBH3vAexNNKF4>
X-ME-Received: <xmr:iWbCZW6EoLtE8fZy_ujJ2y2NTiY49SkpJ1kxt1fAbNo4IIrvJHCQj1eVSjUuVCUbxtDxoZ8RuLRe4Q5BJdMXNxRbxDMM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrtddtgdeiiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvhigthhho
    ucetnhguvghrshgvnhcuoehthigthhhosehthigthhhordhpihiiiigrqeenucggtffrrg
    htthgvrhhnpeeutedttefgjeefffehffffkeejueevieefudelgeejuddtfeffteeklefh
    leelteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hthigthhhosehthigthhhordhpihiiiigr
X-ME-Proxy: <xmx:iWbCZf2intgLViOra3akTVnD1DG1PJGsy--NsACD_wk7_DMLnvm1ZQ>
    <xmx:iWbCZRF4eqUWBSJgOD0t3om2OuDMCC5OQfHjxBdn2J8a-lTr_lIwAw>
    <xmx:iWbCZY8Bl2v1pA9EOLRNb-HOgBylq54g6EF9JKh3u45tmKW6o4rjVg>
    <xmx:imbCZVgoZTXtVs2lHh4fD6cDFOKL456noGOQV9PWSufOSIaHEVhNnA>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Feb 2024 12:04:09 -0500 (EST)
Date: Tue, 6 Feb 2024 10:04:08 -0700
From: Tycho Andersen <tycho@tycho.pizza>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Andy Lutomirski <luto@amacapital.net>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pidfd: exit: kill the no longer used
 thread_group_exited()
Message-ID: <ZcJmiBxpaElivX2J@tycho.pizza>
References: <20240205174347.GA31461@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205174347.GA31461@redhat.com>

On Mon, Feb 05, 2024 at 06:43:47PM +0100, Oleg Nesterov wrote:
> It was used by pidfd_poll() but now it has no callers.
> 
> If it finally finds a modular user we can revert this change, but note
> that the comment above this helper and the changelog in 38fd525a4c61
> ("exit: Factor thread_group_exited out of pidfd_poll") are not accurate,
> thread_group_exited() won't return true if all other threads have passed
> exit_notify() and are zombies, it returns true only when all other threads
> are completely gone. Not to mention that it can only work if the task
> identified by @pid is a thread-group leader.
> 
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>

Reviewed-by: Tycho Andersen <tandersen@netflix.com>

