Return-Path: <linux-kernel+bounces-167737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7D68BAE48
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 15:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D71FF1C20BEE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 13:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8FA2154441;
	Fri,  3 May 2024 13:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b="n2VzZcnA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GXE4/VPN"
Received: from wfout1-smtp.messagingengine.com (wfout1-smtp.messagingengine.com [64.147.123.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC25C1DA21;
	Fri,  3 May 2024 13:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714744706; cv=none; b=sJdekg2OoGOHHJ+8lJyRLI62F4VolabWzAuQIaVV/q5HtYIOi9AqeQAHaUfLZTgWNy/2jpKLcbQzMVMo7lM/FUTx9nBJBuGxL73/fh7N/3Hwa95DFJWFZC0fEANXu7p86iGebTHmTZXS1lIzXFpTgdC2UKtLb+sf0tH3R9HV7Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714744706; c=relaxed/simple;
	bh=BOJZM66K3VGN4oJNOKqKgSsV8u5CZQXA9q6/C9fnzpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ieDdXe8fWecMY7g+Qh9c603cbHoERkCoM5zR+4tfIBicnQBpMFoEBUb3w0rG0Am9+WhvCqcuV8l0DcxW6joPb1r0amEBmcH+wF5jnJQWzGiVElETMD28CmLaHbpDeiYw7M97i8/S+gklDfdcBzbKS/FQ05zR9OkGA0NEHhfswhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza; spf=pass smtp.mailfrom=tycho.pizza; dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b=n2VzZcnA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GXE4/VPN; arc=none smtp.client-ip=64.147.123.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tycho.pizza
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.west.internal (Postfix) with ESMTP id 999981C000D9;
	Fri,  3 May 2024 09:58:22 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 03 May 2024 09:58:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1714744702;
	 x=1714831102; bh=209j5NHS7dsYfwuQMBB8LNTkfds+nbdFRIYToPwGUzc=; b=
	n2VzZcnAj8bFrXyR+kPN0xG7cePpzcLoeVi0de8nypF4TLmnSHBQNpE2TLkeQeUT
	Fa2u8hM7UmS0Z3fIyI69vDyVROv64/d8Yn5LWCn3djYJ2+89XJj5iZ2lrxrxKLnd
	nC3hgl3uUMHWlT+MWtAf+RCkWahhjU9tefekyAE5WRTtZIXsJHuuVUDbABeMdUGy
	R4Wiby1qHFNTT1wHO/YGzMF1+vhH3iQmqil85IogO5xn2SgpmaRBj9Acb4ySE9tf
	s+608kxjaKDPD0dwumBinvPnX+jW8/YOnKeLNG16YaidO41NYnm8I2NNU025NI3J
	MGp8Z3QEUTNNyiXQ78Zfpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1714744702; x=
	1714831102; bh=209j5NHS7dsYfwuQMBB8LNTkfds+nbdFRIYToPwGUzc=; b=G
	XE4/VPNIdHovH6MOVM5M/B2v9SVujBRBOsmI+sZ9aLrmRktsOdt+T7BiETMaNrRT
	+DEytVQlpzwp8nCG07QrxdxIcF9KUBIL2ebgLhGY8fCcYAV9/xKpMMOhYZZVOgmL
	O+TYWWbr1CFjx+nJ22nHhsYUuH1DO6aqWDzewPCrkiKpw6HOOPFPEtRPuAVm5OJ9
	Lv2SQB854vdWqTVfjeVpWVbVS4CY66wJOL0aRD2rIMfA7qwBdH18E9njJA0n0oPl
	wLcKI670ANS416nuG/wZj3yoXB55sETDdaHnoKIE/LmSdKyW1yDAo5U1EL0DFy8f
	lyXRjj9If7eBFfSPAJStQ==
X-ME-Sender: <xms:fe00ZqJ9GUTdVn6X7IyPLlObPFoHy4DQF6ya_Z2tpTnJCUmTt9LIeA>
    <xme:fe00ZiImCHuwJb1oZt7_lP_jKpyIadEbCFZNcefEh2YgQOwBOzGhUOQIaTYb6WT6E
    0HX96ClPu5RYpBqPUM>
X-ME-Received: <xmr:fe00Zqsgc0_ml7U7fFcAOBGKchlUxhduTIgVRTPYr1ZZqS0LeMBRLbskkHAjQiYzBgWP-rHMCpXnMOK1591we-KrcGA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddvtddgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeortddttddunecuhfhrohhmpefvhigt
    hhhoucetnhguvghrshgvnhcuoehthigthhhosehthigthhhordhpihiiiigrqeenucggtf
    frrghtthgvrhhnpeevffehhfetteeffeelgefhffetueefhedtieekleefgeegtedutddt
    lefhhfetieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehthigthhhosehthigthhhordhpihiiiigr
X-ME-Proxy: <xmx:fe00Zvb25e_wh1TcTGI62Zu9rK1p5R2wRglU3L8G7kf3hLlGKDohag>
    <xmx:fe00Zhbv1vujY-l_vaYjo0_-Kyhl0SJO1gEmDbexRDiyg-iAInAqiw>
    <xmx:fe00ZrAsgFIZfCgeyBM7lO3TnHt-VQNQIl7kqJ6pq0TfFsO7-0wyWA>
    <xmx:fe00Zna4lo0Wz55GON99bmjg4kEn60ZlBjytvv4kYTgEhONMfwyOfA>
    <xmx:fu00ZvOJpzcvRrQV0vydJ8sN_JFdhKv128UeNRUi2u5yhQvu8lHBAbvW>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 May 2024 09:58:19 -0400 (EDT)
Date: Fri, 3 May 2024 07:58:16 -0600
From: Tycho Andersen <tycho@tycho.pizza>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Kees Cook <keescook@chromium.org>,
	Alexander Popov <alex.popov@linux.com>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
	Joel Granados <j.granados@samsung.com>
Subject: Re: [PATCH] stackleak: don't modify ctl_table argument
Message-ID: <ZjTteMPELxCZTUSw@tycho.pizza>
References: <20240503-sysctl-const-stackleak-v1-1-603fecb19170@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240503-sysctl-const-stackleak-v1-1-603fecb19170@weissschuh.net>

On Fri, May 03, 2024 at 03:44:09PM +0200, Thomas Weißschuh wrote:
> Sysctl handlers are not supposed to modify the ctl_table passed to them.
> Adapt the logic to work with a temporary
> variable, similar to how it is done in other parts of the kernel.
> 
> This is also a prerequisite to enforce the immutability of the argument
> through the callbacks prototy.
> 
> Fixes: 964c9dff0091 ("stackleak: Allow runtime disabling of kernel stack erasing")

Reviewed-by: Tycho Andersen <tycho@tycho.pizza>

Tycho

