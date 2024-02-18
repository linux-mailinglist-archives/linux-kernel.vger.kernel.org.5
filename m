Return-Path: <linux-kernel+bounces-70476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8073A85986E
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 19:06:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 304021F212B6
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 18:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A063E6F079;
	Sun, 18 Feb 2024 18:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="WEZdY36g";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EqHLC6iF"
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01BD6F060;
	Sun, 18 Feb 2024 18:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708279607; cv=none; b=h4I4E3Ky+N3XR/KKo5FELIFwYZPFxM59kdaW7vwVjSdq/IcOv4hWsGUIzEPgowHuXfxM1H1PvGRv0jvDYp1SeywGzOiErfnAvmrD78vdVchsVqHjaFZRYH4XyuUy0SQpz7WkdTc12chCaaXnh4RY9z1aMCxKCBqu8hhzhw1nHF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708279607; c=relaxed/simple;
	bh=HIFMoj2YuwmU6O4R7BeSsyCqxiXjLSXIQp4RGI1VdXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sQJr/9YRHpLhnsC7JyxhXJE97yNv5Tac/gCF6wA4/VTGsCoIhci+HIkwklGGm793LdUyYG1cHMnAURDsWoHKgicKQKBOAlBfILHzcds9cKt7QBlCYN5YrtJZcZhbhTpjCMGVayXu3vmmbQaARvJgXF+uS3/9+ADghf+VIGi8N74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=WEZdY36g; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EqHLC6iF; arc=none smtp.client-ip=66.111.4.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id D05B15C0054;
	Sun, 18 Feb 2024 13:06:44 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sun, 18 Feb 2024 13:06:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1708279604; x=1708366004; bh=tb7sGQn+pH
	ldqTfBtdXwgP8PRVkQyuHYYjbyt1nr/S0=; b=WEZdY36gdR8mpnHo8ke9S3OAZu
	+fRUDKo5rQO8V+JIFWUXrvGnf6wiZNdD38TPGuqfQbuacW8EQ8OmYHKdWbTxZtmZ
	rdAx4Mi9D7MdkD1qcyZ8L+jaG1ILzzgxriYN9nLUJUeb2nVkSO0gM78hyDBC1AYS
	++OoENfA48m0WiLekUpaIvrr43XtUbUsZHYOc/G3ABZbYJQDDiMigDhJnFT0d0rB
	E/CiRLYudR/Zhcy5w7yx5O8ThpPsowdsx24qSh3y1ka62XLALC9WzVK8KQMc9WB/
	ZA4wa5vGSw7rDY67iN5BliL4snRgwowHyF0cTW2lNrjcvYEXUqHZkB0lV8vA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708279604; x=1708366004; bh=tb7sGQn+pHldqTfBtdXwgP8PRVkQ
	yuHYYjbyt1nr/S0=; b=EqHLC6iFbsECJN7E5PnIE6hp0dhCYGxT7mf0k/FOzoo/
	e3yrRlQbXKk4lUgbCqCtfuKJAYaaAwz9893m7Z+OdpYG2PCyMy6FIBAbbyNp65Hd
	h0rTSNfs5k/aXyZRLtpuW0GwTgRTBEOOsH6+1lXuV9tSlvJOXZISmJQAurfeCwoV
	SzeTMiKyr8CrVt6Bhq+MquQMwCUTEd7S33Nbh3pgVEmAKB8uVVp7Y/W8Z6li7Acc
	q1Pxb8diqK5P0yf7+J6mahTHMo+A+ZfENjCzEHzmolyAbNchaltNdSHhHDVoWAiL
	JxjN+qFhIqmqm6Md983MYsLb07Ev+elaFvCIq3gr+A==
X-ME-Sender: <xms:NEfSZYMqry9rVaIvcqaRJfmFpstj15TTlpoTnkcWcP-MnHRu-svszA>
    <xme:NEfSZe_ngMCnROzPt8Qps9z005UkO3FdbDT6m2blIl3Wn7M616RWQ5HVIL-B_JBh2
    C0oMMWsSl7qwQ>
X-ME-Received: <xmr:NEfSZfTS99Ds7inpDZmFDTgm5btC9gbmJPISRx4x9WB_YRACFiqEWvL8N5uH8aHPhkjGe_Izg6I_111idmJO5aTtcAKJsE1_sQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeigdduudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:NEfSZQt23_YKMUCkskhvULtH4Vnn15ZGY1FwdO_SEUsSN73lBa8C_g>
    <xmx:NEfSZQfpmnkIBtI2pn1vnDW7Jyyv_xTT6FPCIZooMccQe8eX6srPlA>
    <xmx:NEfSZU0erFlJBY5v0kBT8l9hbD67oPS8qyVAr7leUqq6SjT7Lp3yhA>
    <xmx:NEfSZU1eavb15eB3BaqDcyyHXxvCvn-vo64u9eE-90tHl4z-bqua9A>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 18 Feb 2024 13:06:44 -0500 (EST)
Date: Sun, 18 Feb 2024 19:06:42 +0100
From: Greg KH <greg@kroah.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	ntfs3@lists.linux.dev
Subject: Re: [PATCH AUTOSEL 6.1 09/28] fs/ntfs3: Prevent generic message
 "attempt to access beyond end of device"
Message-ID: <2024021823-iciness-spoof-eb6a@gregkh>
References: <20240213002235.671934-1-sashal@kernel.org>
 <20240213002235.671934-9-sashal@kernel.org>
 <ZdJFqmZhIwTFTbHR@duo.ucw.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdJFqmZhIwTFTbHR@duo.ucw.cz>

On Sun, Feb 18, 2024 at 07:00:10PM +0100, Pavel Machek wrote:
> Hi!
> 
> > From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
> > 
> > [ Upstream commit 5ca87d01eba7bdfe9536a157ca33c1455bb8d16c ]
> > 
> > It used in test environment.
> 
> This seems to just replace one printk with another; not sure we want
> it in stable.

It provides a better clue as to what the error is, I think it is a valid
change.

thanks,

greg k-h

