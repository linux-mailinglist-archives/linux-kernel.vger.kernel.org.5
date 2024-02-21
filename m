Return-Path: <linux-kernel+bounces-74585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C87E385D664
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 12:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 836DA284A4D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D54463F8DB;
	Wed, 21 Feb 2024 11:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="Yf2NLxY2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KJkzAJj7"
Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BBC442A;
	Wed, 21 Feb 2024 11:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708513377; cv=none; b=HCGbxcGxLtYCpX5ehzYxi9FCpl5yAzTSP+90BpF4D2pomhq20R4qy0eJbit0xDPACqeo32UGObGWf89Gg700JoFLDk1JFucEShWb6nHMCj/31enUqDSmVo/YhoohEaOwYWrF+z8l7aSUKpNuR5aToDdhxA3T9g7zwOHC9RooSeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708513377; c=relaxed/simple;
	bh=3cN1wXi39HONLLKZYBRPqTC48Hlqm0y4561gFlEXCRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f0nTGdD9X7iZLTIKMlcBvl/1NDY1wFi2BmavDy0+j3prmZ1bHzIsRx1JREHq30WzMx0c1DMQig70KgMbDOccU0qTgDj70nfAI8kGucVnpVzh8tsK3ngAXxRptSPxru/Z+2Hh8jyNU4FRfcLM0anV+5debfjZBJlrGnde9ryUgPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=Yf2NLxY2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KJkzAJj7; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 4386D1140084;
	Wed, 21 Feb 2024 06:02:54 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 21 Feb 2024 06:02:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1708513374; x=1708599774; bh=TqPp38CEZy
	o9GYo4UCO4UrQnY17peGWNRC+vB/dGlJw=; b=Yf2NLxY2KRIy14FvkZyehMDKZH
	jfr2xkq2OAn49/7OTwdHgv113asarlCVv367UUZl7rq3r0HBiAD5UVQT9esebLS7
	Yj9sMO0FXqA/2rV2foPOme20UHXGZjs0ozkSkrhFkJi3fHehU2Ju68lDf40bjbQw
	m844XMA5TKHSQi1YvGSm7NHCmm1pZ7CRyFPuP5Um/624/mEfOknerlwUxn74u67K
	LvcUQicTLPxfWX/2G7920lQ7pVROZsktkQz42nyof1hETzzu4NvJVZWJr96ceiOx
	wpzf/OuDKrggX7hABdTpjDbDFAHf3kUTpVOZOVcZEIjSRUAnrh0QNaKQw/tQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708513374; x=1708599774; bh=TqPp38CEZyo9GYo4UCO4UrQnY17p
	eGWNRC+vB/dGlJw=; b=KJkzAJj73S5isbzbmAWwuD3Tkh5Pb6wX6tDk7PUfKnvK
	afPWyW6jwUT4z2ezS0XHpco3YsTstz9GoFmwYxQgPGWxMMt6bXurBQfOcA+rq2+B
	t8kUsikkbj2xkKj9rSZnY4fv/5mUsOYZAZMOpkTitdl85oXMvVNQ1+pb7nsdMPf3
	ZOu8eV/iHphcfRJBThp0Az4lkuXYpJu4+/xDRjEeMHG1a1FU2BmQ6cVoTqEjUhXt
	Vk9ekdKzz/1kMvogqrWnlXos9Ta+ftxBDgreczaRe3v3uSyGK84PXOQlnCkBmYo1
	fnpqgtcnwJMwzujdDHuWExHB21Xsd5QDuZJQOd6c1Q==
X-ME-Sender: <xms:XNjVZfZJTYDexUDsCHKA_YxdPy1cOmCsnT-vYwtf87zL5sFL5SfFQQ>
    <xme:XNjVZeadGdzPFyMt9BgtBx0UvAUTLrzuwyiMqKF098vfpynYJt1n_Yc8A7gGqKWwQ
    ywMPFx706GrDw>
X-ME-Received: <xmr:XNjVZR83LbZxb_FFfw3ONq7RstvxpT30ME7bVUlBFtBmEF_Mm6LMUM5vanRL2p9OowU89GI50hmkTUXCcEQShL3ab-hojrcFzg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedvgddvgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeegheeuhe
    fgtdeluddtleekfeegjeetgeeikeehfeduieffvddufeefleevtddtvdenucffohhmrghi
    nhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:XNjVZVq-PSjRmOWm6r1IV4fIOUx1_sSB4ZGEdrs-vfyBVUk27dEbfQ>
    <xmx:XNjVZaqsil6cFXgXwdgX7f9nif1xExwTx6PcJeIb2kujZKE2yM15FQ>
    <xmx:XNjVZbTcyvG0hOfiqcu9xQcDlhefipOxXRmfW-J0qtVEwz8vumuhPg>
    <xmx:XtjVZerMKIfqFu_jvTFNqYroevMIip3MvMVNO6buoMowXJFffg5vSw>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Feb 2024 06:02:52 -0500 (EST)
Date: Wed, 21 Feb 2024 12:02:50 +0100
From: Greg KH <greg@kroah.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: stable@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>,
	Jakub Kicinski <kuba@kernel.org>, Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	"open list:BROADCOM GENET ETHERNET DRIVER" <bcm-kernel-feedback-list@broadcom.com>,
	"open list:BROADCOM GENET ETHERNET DRIVER" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH stable 5.4 v3] net: bcmgenet: Fix EEE implementation
Message-ID: <2024022142-jailer-unburned-2080@gregkh>
References: <20240212014859.3860032-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212014859.3860032-1-florian.fainelli@broadcom.com>

On Sun, Feb 11, 2024 at 05:48:57PM -0800, Florian Fainelli wrote:
> commit a9f31047baca57d47440c879cf259b86f900260c upstream
> 
> We had a number of short comings:
> 
> - EEE must be re-evaluated whenever the state machine detects a link
>   change as wight be switching from a link partner with EEE
>   enabled/disabled
> 
> - tx_lpi_enabled controls whether EEE should be enabled/disabled for the
>   transmit path, which applies to the TBUF block
> 
> - We do not need to forcibly enable EEE upon system resume, as the PHY
>   state machine will trigger a link event that will do that, too
> 
> Fixes: 6ef398ea60d9 ("net: bcmgenet: add EEE support")
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> Link: https://lore.kernel.org/r/20230606214348.2408018-1-florian.fainelli@broadcom.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> Changes in v2:
> 
> - removed Changed-id

All now queued up, thanks.

greg k-h

