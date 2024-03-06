Return-Path: <linux-kernel+bounces-93185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF517872BFC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 02:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D358E1C23218
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 01:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1AE6FD9;
	Wed,  6 Mar 2024 01:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="qrgdFPf6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VNrdu7IY"
Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7396FAF;
	Wed,  6 Mar 2024 01:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709687440; cv=none; b=vD6JOhWzDqyAMe94fbWbrYcuMN9dp9MYfslHJJ3VDSzFegcnfWos56Tqq+NlXjtSqDQznFJMmenVam1CYjeyDMwKqArAfeNaTkvQ6vx/66CI+Jln18pefIMSwASLDSIwn+2dNyK1rR608yNirXwPHfFiU2tXKb5vOSwLbnQ6Wc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709687440; c=relaxed/simple;
	bh=YOr/GbT9jgOAplPWvdq3W+lM+vmFTaiSh/I1Fj3fFKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kye0uSGBXHkXgWHiMX3ninzggzdEnoYbUp7y14NTySPtTon+3YQ1B350Kg1vPuIKF+b7knx27XCdPL37IOMlcA/4Jtg0h/dKirokpvG4RLv5+2XtMi/UqVa/A9ECZGAi01C9CxSJbkbGay30Kmj+xMwhT7s5UCehRmXY1hni/3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=qrgdFPf6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VNrdu7IY; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 1E23A1140138;
	Tue,  5 Mar 2024 20:10:37 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 05 Mar 2024 20:10:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1709687437; x=
	1709773837; bh=nIgXLago0+goMoIVpizmwo89vrCawNjtqrrcg3tzX1o=; b=q
	rgdFPf6B/Q7LoPmKvahlzpP6JYC84k8/nOrdLSn1SmDiWPM6SnSbBo+nylNVsnrf
	P9jKSmiSzMH1dkX6RW8arBUg+9/IRYB02iM4oiPU3S1asK7UVbCmJ19iDZhQDpyz
	eryN07pFHehUojspgvP7m9jHrtjmXU9FxtS4/Dj9XliMwMjD8ikZYPKrC3iqRfHs
	VpVfMjN7bSpLHtw1yOn+YWrI9MuenfsqbrNggmtXa8jfsEHyv83A3+XAfj3ydzTX
	/UyKA6wdmHjeVILM7CBEx9f6dDHBXldL0Ff4gYFMUs0xqpyJVkHUhCRvt7pLBzuW
	8hDjitwM1dU8TluXxG+Xw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709687437; x=1709773837; bh=nIgXLago0+goMoIVpizmwo89vrCa
	wNjtqrrcg3tzX1o=; b=VNrdu7IYFx1muMn62Ghnbw39NUezZAj2Rshfg0atzAc9
	tEhLV48vgNaUkv9zxmpQQuhggLpZBW7P1B/zKYNlcQZMzoi/wwxzldhz0iIWB1qX
	kC+MR8Jy0kthJEsDBQer46phQBZ8eaesk1KGRSgehzh13NsAo83ifr3vYYyWUoa/
	ED1xBwNjM6qsi4bqH3D/bONMck6kuCRKW4O9Mj7kZE2BZl/bMF1OFy31DLlzqYH3
	5TsGjXSqHKp7Xg+WrHWr524t3W8c18dlrv0X0w8kfiJWfRbtJXlYl2cRaf0BgPjP
	uw0n4FreaAxifJxUoegKRfz9Z7xgwjf+Wr2fRDtvPQ==
X-ME-Sender: <xms:jMLnZVScJBPyx5Bp4vhSd06NTpKHtTUgf_hL6ak7oTigjrf7in7EKw>
    <xme:jMLnZewjcEgvDveZgSL04ft44fsIQzvKIN4whkam4AjuHeL_wHA4E3QOOy6Or1xhT
    sPIqDTTlIKqZ2GrZPE>
X-ME-Received: <xmr:jMLnZa2r9VQQea-dw39tuzS--aK80RYPo3FNPGVhbGRmB331yCuiPpBuzduJR_FchKm4lv7ZtL-IUt03-kVZKflJHoXH8FNN6Xo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledriedtgdefudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvrghkrghs
    hhhiucfurghkrghmohhtohcuoehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjh
    hpqeenucggtffrrghtthgvrhhnpeehhffhteetgfekvdeiueffveevueeftdelhfejieei
    tedvleeftdfgfeeuudekueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:jMLnZdDyNnM-Dy_VlVrz7kKEYL0pMVg3gM-FkA7rNI-od0FKJDVCBQ>
    <xmx:jMLnZegGkOAkEqF7Er105GduAHiasmTdaIZID_K5Uoz_8s3WUW_DfA>
    <xmx:jMLnZRr9TRLZRp-9xMn9ApVoQBvv7o41PgA3x1t-ztEsCCk5Og81cw>
    <xmx:jcLnZTYjJtbn9ek55E_4CSPMt0fi-zmny7eN95KbUhAyG3SFoj_f8Q>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Mar 2024 20:10:33 -0500 (EST)
Date: Wed, 6 Mar 2024 10:10:30 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Clemens Ladisch <clemens@ladisch.de>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, Kees Cook <keescook@chromium.org>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
	linux1394-devel@lists.sourceforge.net
Subject: Re: [PATCH 0/2][next] firewire: Avoid -Wflex-array-member-not-at-end
 warnings
Message-ID: <20240306011030.GA71684@workstation.local>
Mail-Followup-To: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Clemens Ladisch <clemens@ladisch.de>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org, linux1394-devel@lists.sourceforge.net
References: <cover.1709658886.git.gustavoars@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1709658886.git.gustavoars@kernel.org>

Hi,

On Tue, Mar 05, 2024 at 11:24:15AM -0600, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end is coming in GCC-14, and we are getting
> ready to enable it globally. So, we are deprecating flexible-array
> members in the middle of another struct.
> 
> There are currently a couple of local structures (`u` and `template`)
> that are using a flexible `struct fw_iso_packet` as header for a couple
> of on-stack arrays.
> 
> We make use of the `struct_group_tagged()` helper to separate the
> flexible array from the rest of the members in the flexible structure,
> and, with this, we can now declare objects of the type of the tagged
> struct, without embedding the flexible array in the middle of another
> struct.
> 
> We also use `container_of()` whenever we need to retrieve a pointer to
> the flexible structure, through which the flexible-array member can be
> accessed.
> 
> With these changes, we fix a couple of -Wflex-array-member-not-at-end
> warnings.
> 
> Gustavo A. R. Silva (2):
>   firewire: Avoid -Wflex-array-member-not-at-end warning
>   ALSA: firewire-lib: Avoid -Wflex-array-member-not-at-end warning
> 
>  drivers/firewire/core-cdev.c  |  9 +++++----
>  include/linux/firewire.h      | 16 +++++++++-------
>  sound/firewire/amdtp-stream.c |  8 +++++---
>  3 files changed, 19 insertions(+), 14 deletions(-)

Thanks for the improvements, however we are mostly at the end of
development period for v6.8 kernel. Let me postpone applying the patches
until closing the next merge window (for v6.9), since we need the term to
evaluate the change. I mean that it goes to v6.10 kernel.

If you would like me to applying the patch v6.9 kernel, please inform it
to us.


Thanks

Takashi Sakamoto

