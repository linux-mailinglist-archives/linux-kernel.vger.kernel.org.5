Return-Path: <linux-kernel+bounces-56557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A080284CBBC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:38:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D41951C21E5B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 13:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF8A27763B;
	Wed,  7 Feb 2024 13:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b="2ovkCmc7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z+fRcucR"
Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B583C062;
	Wed,  7 Feb 2024 13:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707313111; cv=none; b=OzSaAbysqI/DY33mZoEp+Wst2Ia5+zi7YMquaorHlbnlr+/YQaq8kwpSiYXqajRLjL+YCjnMsdIRIGXQfwzWeLp/tRBemf1l21NzXWIOp6tp196B95Qf67JaIwdgxFQ5qUIIjGSaN+DER2uFxPKfIRj6dD8jhSc2psgEMOZiY+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707313111; c=relaxed/simple;
	bh=Uwv/WJmwhyfFa3neNLcSwsw2I11UAjibajrmPfs5/Gg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tF0v/Vz2VL9mI3xUGQ3jS7Mr6iWM+rV/U6LGD02wB/ALS//cMfxnQA54duh9fikeEddiLqaJQuo8ekrzF218iEuZRX9hKSjURiath0+ZqAe7lpj/Ui+h1Q5MFHi5hHR5by5xMBXTLVvUAsL+oTHMMn6AWy7H/P5pMCwVeqCiCrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza; spf=pass smtp.mailfrom=tycho.pizza; dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b=2ovkCmc7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z+fRcucR; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tycho.pizza
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 2E70713800A2;
	Wed,  7 Feb 2024 08:38:28 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 07 Feb 2024 08:38:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1707313108; x=1707399508; bh=Uwv/WJmwhy
	fFa3neNLcSwsw2I11UAjibajrmPfs5/Gg=; b=2ovkCmc7b3vweBJqbF0JUDKVOV
	UCWiNDfPA3olqR8WShz32FyTUwtdjnD2mIRt2M4BjytuRTMOeikE4QT12/BfEQcn
	mHjRr4qdKQMSqV78ZkM2/mM6t/jyQPl4eV1tXf9wov3SiRphaU/nkbAJC6oyMWtv
	HOrAlTFkMn4Em2UDOhr/AVNxMakdwdJZ4luUpMkPs0CoInG+VZYPWqQhYiABQd14
	IXOTvj6J/T/Va5bIb6MeNprd3ErfuC5UERvvCY109Q3JZaRCra6FfTL5ALWwy6ft
	Wo6swmJel4HXfkFSyEooRLkAO+v2OObjIM5jncuWXPKqZRIv9jlD3SeL5YMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707313108; x=1707399508; bh=Uwv/WJmwhyfFa3neNLcSwsw2I11U
	AjibajrmPfs5/Gg=; b=Z+fRcucRzmYBfCUoA0Sm14AV+itHbpEugXzpXfUC+rQ8
	mOpJrtW/kTv4VNAas4Z13zQtpjk2DcDrdJ0a01jUfR0L3Vbr6vB2O/F3R6K5h/tv
	SjYrOSc7KgJaFaGJWQ6tYr93WJtFE7kKLS2FZEI66a5SjYayjBgQugJlV3b/QCf1
	Xc48mRCi+fZ2WS0PUDPgENm4oufo/CkduwHaDHzVO+/nkLQLLPU45+L3dnEzxKXe
	+QTubQjZ0tExnCz4OKjf9yNryA2bEpfyeyxIpc0T0DCPIIBGnVCq7UFBuBYUKx9l
	DYnZiQr+2UJ5xFf3Mom6Y8im/11T+D1iubst+iR91Q==
X-ME-Sender: <xms:0ofDZSNN0CA154QkgwyAnUcuejqrzpx_7RL8LrIpdSIs38NvJdDUCg>
    <xme:0ofDZQ9mONyIEFyWCKBmt1AcJJXJHrWMrP9wcFa092Xin2XzDrbtjPN_85N_0zWld
    GSn3BGkciYlgAGfqQg>
X-ME-Received: <xmr:0ofDZZRG6X5JkN-SkYPppihv3piPcY0yOox9JKxDXYFClOx-MvRqOmnoiuJWl_eCMeMWGgl4Jqo0P-Uc60NBBj3w2iej>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrtddvgdehvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvhigthhho
    ucetnhguvghrshgvnhcuoehthigthhhosehthigthhhordhpihiiiigrqeenucggtffrrg
    htthgvrhhnpeeutedttefgjeefffehffffkeejueevieefudelgeejuddtfeffteeklefh
    leelteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hthigthhhosehthigthhhordhpihiiiigr
X-ME-Proxy: <xmx:0ofDZStxD0ycQ1PpqlvoR42P9n2gZpiLXs1Fi-19Y_9c7-lY4G959w>
    <xmx:0ofDZaeVJxyHpM7qrA0OiKnQwmdhKhtt3zpKIKR-R2j4EMq7gal6oQ>
    <xmx:0ofDZW1eKdbZJr_p72hh_EtZRh5Rrt8y5CsinCEZerwfla03aBn4GA>
    <xmx:1IfDZSRBx7R-hpTkDeP2gmqJrobEpjBwjnKNhUi4fcn_SPH11JGs_Q>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Feb 2024 08:38:26 -0500 (EST)
Date: Wed, 7 Feb 2024 06:38:24 -0700
From: Tycho Andersen <tycho@tycho.pizza>
To: Christian Brauner <brauner@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
	Tycho Andersen <tandersen@netflix.com>
Subject: Re: [PATCH v2] pidfd: getfd should always report ESRCH if a task is
 exiting
Message-ID: <ZcOH0GcW4RSAItnN@tycho.pizza>
References: <20240206192357.81942-1-tycho@tycho.pizza>
 <20240207-vibrieren-waldarbeiten-30eeade05203@brauner>
 <20240207-daran-fliesen-6039a2e36f39@brauner>
 <20240207-blumen-neulich-f1507e0c5cc0@brauner>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207-blumen-neulich-f1507e0c5cc0@brauner>

On Wed, Feb 07, 2024 at 10:50:26AM +0100, Christian Brauner wrote:
> So this is what I have applied currently where I moved the check into
> __pidfd_fget() where it makes more sense imho. But please double check
> that I didn't mess anything up:

Oof, good catch. Looks good to me.

Thanks,

Tycho

