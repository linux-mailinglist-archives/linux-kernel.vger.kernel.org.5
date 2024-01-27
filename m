Return-Path: <linux-kernel+bounces-40953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C6683E8C0
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 01:49:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AE481C23163
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 00:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3791033E9;
	Sat, 27 Jan 2024 00:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="p+MW4oL2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CgAMysPH"
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com [66.111.4.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FEA12573;
	Sat, 27 Jan 2024 00:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706316565; cv=none; b=NhISQYgzDUo0vcAbYO3Nu5qTHZvGPfYn+BwZ9Sa6dZ0rgwMZDgdGrjGMz3NBdMw4Wln6VaXw8xljemis7/BQutdxrXJ62jwKar5CpJCV8aWFEN+EfSLphiqyMhDJYS2ipt1sa98TfDkIqe8MMeVPe4UzdnySPsDXVdd1k73kz8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706316565; c=relaxed/simple;
	bh=/xI16sc9U7F43oPCBqcnzr7KshjKk+7xCXn9cY/h7h0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gXXa1/R94voE3zBCOWKJ3720nm68yJhfUV5fogc4Wqmphp35YBb7LruQUqHV3AoNEsc0VNKdD3Dt2tz4QrmIbo3sLoH09Aa01huzcsGqaJ2mXhu569cOT6Sp/UWdrmxk8gnfxiAhGu5qhlbB+xCXLQKMWIytABXunn71kiLbaGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=p+MW4oL2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CgAMysPH; arc=none smtp.client-ip=66.111.4.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailnew.nyi.internal (Postfix) with ESMTP id 1800458130F;
	Fri, 26 Jan 2024 19:49:22 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 26 Jan 2024 19:49:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1706316562; x=1706323762; bh=I8fLiLrH5V
	G4dzDjXgnXjKnS7HDcUKeqHKjydZvPuqk=; b=p+MW4oL2Eum3VGatHqbl5mM10m
	WWVYBB4bpdUTcMaT8G0ImWXY8uJ5k9fQUMGaA/KxGUl1Lzoq2NDqnZjG/x4DBF7r
	7VKBSIHS6gMJpKXpNjm/sIxdIsQLlpObefAHYz+jNaseK4y4EgV21nK9Vi6vtQad
	8gj4YTrunUUInDkEyLXDotpL577h9//m6qtEPJEJRUdu8zfAnP/ZUQpsr/I1bwqf
	q2M/KXqneYIOj6mJWHxM+fh/SGtWkSejd0kxApex9iR/DUmcPI+RcMsPvaOjgPvs
	j/H7a8AiYSa87R2IB9Bn26kE2CnsKEY+0239k/5getAgPq96XJTYTzRK+CsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706316562; x=1706323762; bh=I8fLiLrH5VG4dzDjXgnXjKnS7HDc
	UKeqHKjydZvPuqk=; b=CgAMysPHaW9fjpq4ue1QBo8a9k4ZTY25n3pPjUHpLcUW
	8JJ0TbvnySOG/0kGu9bWvnoeonsI7mB4khABMrSJndvuXMek+1AII2KbWePKwKRA
	mMQWyWaR25tnSNi1OpOX49YQlxNkqdnPyNV4CjE40ZDkMqHvE6yADoDi5vKDISEB
	bGkYCzJvXiTONO4u+a5EjynO3KP2lpM3N6z2NcCLZZC5HqHUtTp07LBATLAuhpy7
	5lcpTj327aI/E5kMsu1k+RZ6uiC0PSIlfzFK8h17QsUJwwzn9xlezjAKA/Hy6s+H
	ftPEHrIur9rK4jL/0KxcKxHcYQGVx6C4ZYOQyQWA9g==
X-ME-Sender: <xms:EVO0ZdCRW6nIPpfsHPJwzl8ILSwrD8pTtMrtNezVlgiuDhaHj69XIQ>
    <xme:EVO0ZbgRtHQ5LL65BngHDmqd30HKhTs_iP2SYIcX0Qe63Q2Mzm9YAkyI3R8WPyq3n
    uUvvhFA3_jJ2Q>
X-ME-Received: <xmr:EVO0ZYkzl1VQDNIZsgmdaXlxj_t_9tqo457GPpOof6_mi95JdsIavZTrNz7n>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdelkedgvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttd
    ertddttddvnecuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhm
    qeenucggtffrrghtthgvrhhnpeegheeuhefgtdeluddtleekfeegjeetgeeikeehfeduie
    ffvddufeefleevtddtvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:EVO0ZXxz3d7anyV_1d1FdORLE5OaxtmqjEo3EcitvsgPuJriPUeqYA>
    <xmx:EVO0ZSRYnxTA9b4eIPDSCRkzr08T4SDdK1KHgwWLkDsnP_12BcM6UA>
    <xmx:EVO0ZaZ7H-sCpZp1tK9Sr_NpHi7kAO7wkKJL0omHEpf_Rm3e1lORKg>
    <xmx:ElO0ZbTj_DJiwuTTVS-v_X6Ir1t3ETtxAecmJea42JvhnwGedGKjBg>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 26 Jan 2024 19:49:21 -0500 (EST)
Date: Fri, 26 Jan 2024 16:49:18 -0800
From: Greg KH <greg@kroah.com>
To: kovalev@altlinux.org
Cc: stable@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org, keescook@chromium.org,
	sfrench@samba.org, corbet@lwn.net, natechancellor@gmail.com,
	ndesaulniers@google.com
Subject: Re: [PATCH 0/2] smb: client: fix "df: Resource temporarily
 unavailable" on 5.10 stable kernel
Message-ID: <2024012613-woozy-exhume-7b9d@gregkh>
References: <20240126193143.245122-1-kovalev@altlinux.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126193143.245122-1-kovalev@altlinux.org>

On Fri, Jan 26, 2024 at 10:31:41PM +0300, kovalev@altlinux.org wrote:
> After mounting a remote cifs resource, it becomes unavailable:
> df: /mnt/sambashare: Resource temporarily unavailable
> 
> It was tested on the following Linux kernels:
> Linux altlinux 5.10.208-std-def-alt1
> Linux fedora 5.10.208-200.el8.x86_64
> 
> The error appeared starting from kernel 5.10.206 after adding
> the commit [1] "smb: client: fix OOB in SMB2_query_info_init()",
> in which the buffer length increases by 1 as a result of changes:
> ...
> -      iov[0].iov_len = total_len - 1 + input_len;
> +      iov[0].iov_len = len;
> ...
> 
> [1] https://patchwork.kernel.org/project/cifs-client/patch/20231213152557.6634-2-pc@manguebit.com/
> 
> Error fixed by backported commits in next two patches  adapted for the 5.10 kernel:
> 
> [PATCH 1/2] stddef: Introduce DECLARE_FLEX_ARRAY() helper
> [PATCH 2/2] smb3: Replace smb2pdu 1-element arrays with flex-arrays
> 
> 

Now queued up, thanks.

greg k-h

