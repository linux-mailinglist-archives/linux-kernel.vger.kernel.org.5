Return-Path: <linux-kernel+bounces-36571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 627BF83A334
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 08:41:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D0CA28300A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 07:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F337171A3;
	Wed, 24 Jan 2024 07:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="QOzbeEOU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dkOCgmY7"
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2D817550;
	Wed, 24 Jan 2024 07:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706081957; cv=none; b=FA1KXYh2ac4DZL5oH0UReHdvELlbf8uzldoEYhEIpydjq6wACb6XsaU2fxtd68O7vFey6hfdnrQcJKqyLiMVdnA+C+VsvBynbK48UIAONjYs8tHA3gh3sM897xvScXHSBlzZZedQ43GiygVfHCJFwZi3/F0pCWonWTqZjHzAAPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706081957; c=relaxed/simple;
	bh=D9xiLc3ZLn+kzRd73I0utR9rOr5+qDorAUvhecrJ/GQ=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=rk4d+uuo93C88/uLgtr1UPobC9sYW3ZgiZFcmRcIVSERq1tcPBbV5cLI1gHUge9Lm4TQwMtUrreJzMeqGbN+oYJopnOmCfcqULrQB6KPw4DtOqwS68qOwv/eE0UHcDWsznJF2tcq2BGEaXYAZOsd+kAz8H+t7GgPNC7GwBFMomQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=QOzbeEOU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dkOCgmY7; arc=none smtp.client-ip=64.147.123.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id A8DFF3200B11;
	Wed, 24 Jan 2024 02:39:13 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 24 Jan 2024 02:39:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1706081953; x=1706168353; bh=wS35TwK0K3
	MUqOLWKIEUN4XToREr5MJPwePHWgqnUXE=; b=QOzbeEOUxsmmwCRvwyDa6uJOd0
	V6VxJ1hz0dq/Z8IIYvaP+2gGafTMn8ojm5vuQiyMRLInJDVxnF5Ypf5p7I4Tltcr
	J6JmwuZPrh+M/OdhQd/MF27syr1H0DRkpZRhE5nHzDRto0cS7zGVKql0XBXr20S9
	UGATx6ivIusF0G4MY7ZagIwQ8CyyYJa0927bOUYOENJeSoqXSVohrjqN6zh1Yw85
	uInG0bbNs7BkU6tCCFmvhsBiqrv7wp6AmbDFrRIfaNU2w8Gyt+5wDGskO0ddjtmk
	HEddPhvQhlnC0UnWvbt23FV1lZvy7mHhvYWah8vWXC/8e2N2xLK+x+wfzCAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706081953; x=1706168353; bh=wS35TwK0K3MUqOLWKIEUN4XToREr
	5MJPwePHWgqnUXE=; b=dkOCgmY7rJ8pgQjO+69dAeru9JMOqksLU/t8+Ej8tncT
	P52reVCASyRKqwkrrawkhL3UlGknrUhzGH+W2v3DAHX5uO2Qp9lVAmw6G6njUrIG
	kPQwQV2pWGtzOWEpTF6MxVAiWT8MTAAUnBJW0iAfIaPx46j2SDDYyIiuj4p00lIn
	Z7vFQCoSxRthkybGOWFc92SgrW51nSpC8o07Qf5E4apnLuI/xq0tNGihTRfVgCao
	krfcn8nYH2YDWSzeHYx4U7091KpDDIqDuyJC0m+kW+3DhdZ6iltX/MGxIRZgn7dR
	PAL44zp+zc9HpBGy+uLANFYsuM9+ks9BEUPQy1zqbQ==
X-ME-Sender: <xms:oL6wZVs90lvtw8jOEuZEd7hfbi6nC3pIj2JZd4JJoK1uXBwWlz4_Qg>
    <xme:oL6wZef9fb0WVH6goh1IkMWO91itL7O0PVoMR-RDMbr4N3Rf3AeCenzj0bUVTSN-A
    0IXbtC-HCxJIaLqQE0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeltddgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:oL6wZYz9FjsvzEyjoS8bBg4jqi4PO5j3_sMN-j5aR8dInOBrS78YIg>
    <xmx:oL6wZcMoiTpfelET3n5Lmn211_fohn0s0nVP40M3lXuiftsOWA_lzw>
    <xmx:oL6wZV9RDRHGxeYLCEAEKIaFmCO9djhUsx7jGJl0n3nHzoZhB3T_cg>
    <xmx:ob6wZVyvhY3tU3wPVckvSAFaJbtnUas_uS0Kz2rixbRBUf-VRO86xw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id BDB43B6008F; Wed, 24 Jan 2024 02:39:12 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-119-ga8b98d1bd8-fm-20240108.001-ga8b98d1b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <bd3f6fcb-2239-4fd3-bb9a-c772bbce5a44@app.fastmail.com>
In-Reply-To: <20240124004028.16826-2-zfigura@codeweavers.com>
References: <20240124004028.16826-1-zfigura@codeweavers.com>
 <20240124004028.16826-2-zfigura@codeweavers.com>
Date: Wed, 24 Jan 2024 08:38:52 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Elizabeth Figura" <zfigura@codeweavers.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Cc: wine-devel@winehq.org,
 =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 "Wolfram Sang" <wsa@kernel.org>, "Arkadiusz Hiler" <ahiler@codeweavers.com>,
 "Peter Zijlstra" <peterz@infradead.org>
Subject: Re: [RFC PATCH 1/9] ntsync: Introduce the ntsync driver and character device.
Content-Type: text/plain

On Wed, Jan 24, 2024, at 01:40, Elizabeth Figura wrote:
> ntsync uses a misc device as the simplest and least intrusive uAPI interface.
>
> Each file description on the device represents an isolated NT instance, intended
> to correspond to a single NT virtual machine.
>
> Signed-off-by: Elizabeth Figura <zfigura@codeweavers.com>

I'm looking at the ioctl interface to ensure it's well-formed.

Your patches look ok from that perspective, but there are a
few minor things I would check for consistency here:

> +
> +static const struct file_operations ntsync_fops = {
> +	.owner		= THIS_MODULE,
> +	.open		= ntsync_char_open,
> +	.release	= ntsync_char_release,
> +	.unlocked_ioctl	= ntsync_char_ioctl,
> +	.compat_ioctl	= ntsync_char_ioctl,
> +	.llseek		= no_llseek,
> +};

The .compat_ioctl pointer should point to compat_ptr_ioctl()
since the actual ioctl commands all take pointers instead
of interpreting the argument as a number.

On x86 and arm64 this won't make a difference as compat_ptr()
is a nop.

     Arnd

