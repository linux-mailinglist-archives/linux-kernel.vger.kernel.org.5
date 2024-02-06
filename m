Return-Path: <linux-kernel+bounces-55145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 327F984B8C9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 16:06:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AEF0B2DE62
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A19C13329A;
	Tue,  6 Feb 2024 14:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b="2hNU11hz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PxhQtply"
Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20408131E53;
	Tue,  6 Feb 2024 14:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707231164; cv=none; b=FBMk2PVSUVsP/qmPphUFC6NmGaVrMKkXH0v740YSHrZwcpnyvsBA1keOhoy+Z6SkmhnlNrIiwzxkXQ8nb5rA3AURtN1WKsp+2MFGh70jlLhudyVbHc2WLd7YYqETe9hG9Ty23I9JGQ/4Ef80ECD5ry5dJcsmhxpndC5+hCEiSF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707231164; c=relaxed/simple;
	bh=R/742LRkouuAuethox2x2vtIJsIKE4T+HK1LMPu93+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VBCbwrF/FcxWrBFMQkgCLye6iAhYC3skKHEgsICaOJn0OZZvksV1oXDCCgVgv0hWSLmCkUzmDhkhd7VBK437oK4Cr3/Jtyk7XtL384QWrRfNp/UXnm4Pdvwaj4YoImx3RzOq0AQRx27mSGudNycEW/Nh2FNIqSRlThbqykktkno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza; spf=pass smtp.mailfrom=tycho.pizza; dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b=2hNU11hz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PxhQtply; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tycho.pizza
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 0DDF5114008D;
	Tue,  6 Feb 2024 09:52:41 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Tue, 06 Feb 2024 09:52:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1707231161; x=1707317561; bh=Fd2EgqbFxv
	tE/GJ2R79t8CbsMl7dcUlSu6Hik69SEuI=; b=2hNU11hze/lK2HnZ81Yq+0e3X0
	WzYn3FVaMIa8MOVt9PNrgJxS7KJ/VR+q+bTlfHfw0ZoAcaHapXgEDeMNnjq7nfyK
	Doa09EyBz+2cuF4H/uHe6I6C2Oum8CPQ/Kug75/foHx4h7aRgidAjpBmbw60lmdr
	4QO5inVfGlDaX0aWe9qDiKAqb8RcsRIK5NFcZIRWTDAXD5ifRacv1IYYBWFwyLvz
	JD4x/UuKP4ECVVq9HIXl7WzpNFXa16afqWJyDZi8A1X5HBqxdb6/3Elarm7zQqhf
	yyjC27G9NVVb86aHVhOx0ML6l2AF2CxVI0xz5qig+kSFsqN1g0KWW9Ks7W5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707231161; x=1707317561; bh=Fd2EgqbFxvtE/GJ2R79t8CbsMl7d
	cUlSu6Hik69SEuI=; b=PxhQtplyTcojFzSGgmYlbpBx7uOUQyhGtdJG/0ttwfeO
	qUB2ekHR9YirbggSssgFSi3i1xTDho8n0hT4OMZDfVII9ps+yhIb8w5j8lG69FF1
	J+/+GuRqOZnqiLwXEQqIPdqBnqT2e7h4EouoX9A+E7915tBLPVG8xvRuwWAxXSF3
	O7sc8ukp/zA1EKA4N3tl0Vrsn8ObCpgi8lThdidM/NgC/fPGU9WwVZr+U/mbY2Fn
	6Amak1Bl7cF6qxaiX+2F0cD4G1ZQDgUEo3808F//jI+y83oC8ycg19PWNW4ELmTT
	cuFtEg4MZtCC6twI91NOleCKhncYwVANcyv/vifaLw==
X-ME-Sender: <xms:uEfCZQstBdf7ESZL-l7RypKCL9D5fPr2K0oQDzh2EHR1fPHKxnxxlg>
    <xme:uEfCZdcrxouWN6N-CkTVKCHruUWXxU426wYRxigOT-vQ4zRi0v7SdWgf2bqymBTaV
    tPTG4IPkgy4_VPJAo8>
X-ME-Received: <xmr:uEfCZbwsWGJXLxsADBFggu0Ox0-O5UAMjF63gPibNRShusdsgIpDs2T2PFHazFweFWi7too7Fa2Z9f7BWB-a-OYXSwAv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrtddtgdegtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdortddttddvnecuhfhrohhmpefvhigthhho
    ucetnhguvghrshgvnhcuoehthigthhhosehthigthhhordhpihiiiigrqeenucggtffrrg
    htthgvrhhnpeelffekveduvefftdejkefhtefhgeduhffghfejtdehieevjedtkeejveej
    keeuieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hthigthhhosehthigthhhordhpihiiiigr
X-ME-Proxy: <xmx:uEfCZTNg76HajRWw_mXDbHKTr18PHxW1MD238fZjPQg_nwl8wazqvw>
    <xmx:uEfCZQ-MoSgqVKPN1xpnnJHI3aOrf9v4vfF8bXTD0MtxstzO65PRyA>
    <xmx:uEfCZbW4WBElWaAQXCT8NnMUM0DJp313g2Tdd4kfG60Owjne_VdY9g>
    <xmx:uUfCZQzrE9cKwfPLQw8jf3ruscWAyMtdEMvQt9K9FvtbUfA_cBpQYQ>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Feb 2024 09:52:39 -0500 (EST)
Date: Tue, 6 Feb 2024 07:52:38 -0700
From: Tycho Andersen <tycho@tycho.pizza>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Andy Lutomirski <luto@amacapital.net>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pidfd: clone: allow CLONE_THREAD | CLONE_PIDFD together
Message-ID: <ZcJHtqqvxUoBJLRo@tycho.pizza>
References: <20240205145532.GA28823@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205145532.GA28823@redhat.com>

On Mon, Feb 05, 2024 at 03:55:32PM +0100, Oleg Nesterov wrote:
> copy_process() just needs to pass PIDFD_THREAD to __pidfd_prepare()
> if clone_flags & CLONE_THREAD.
> 
> We can also add another CLONE_ flag (or perhaps reuse CLONE_DETACHED)
> to enforce PIDFD_THREAD without CLONE_THREAD.
> 
> Originally-from: Tycho Andersen <tycho@tycho.pizza>

Goes without saying I suppose, but,

Reviewed-by: Tycho Andersen <tandersen@netflix.com>

as well.

Tycho

