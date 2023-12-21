Return-Path: <linux-kernel+bounces-8433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8677C81B712
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 14:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7D3D1C23DE6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 13:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B163745CD;
	Thu, 21 Dec 2023 13:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="GUnH9Qt/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="p7M16dhp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111087319B
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 13:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 0BAFA5C026A;
	Thu, 21 Dec 2023 08:12:53 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 21 Dec 2023 08:12:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1703164373; x=
	1703250773; bh=uXnfqe1/rU5Aj6adZ7mG3BFBjzWeNfv+XHLSvTxStnE=; b=G
	UnH9Qt/FUEQiuy1jgaUF7A+hqkfFqCPgGsoaMkD5JMh3gjjmjoYsGPvDX18PZ4QB
	p6gyDyhd33voMPf9ri06Fkyet3aG/wtt06N+Q7lewMrv+6tKLlpS6tREuUmlHsi+
	x65oQeKjHi2EeLGHUC5SE5KY9xITbCCkmjQki47voqxu02BHQHNTGTGkYzjtauvW
	Yz708NY4lA2j2v1NxmBJD0sTVXY2rijhYrbBbwFrqjazRL661A2IMuXK/Fq+Cay5
	Ev9DeSFS08Phni23dKduuZNNoMF9OfkUW90XypuouVwNPcK11KPPcdxa+G7LNKJQ
	18ig3Zt39cuq7NBrdGfKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1703164373; x=1703250773; bh=uXnfqe1/rU5Aj6adZ7mG3BFBjzWe
	Nfv+XHLSvTxStnE=; b=p7M16dhp0a4dq8aSnsYzOggQ2rkPmBWvRLD8p4iIYRzV
	ORQgsO6UyMk0smn+csU7OG+i5SCyMfdS8DdMWBjXUkUcgWWRpt5jjESfHScWkulg
	zNYiuijuHBldwMMvxz3ZTKja3ki5sfYf7LJ1OTkvJakfDvvZadYuQmLAAv48WZJL
	nAHXX4+yKxToDU1lupJXQbkPvWH0q1OSHo0PvtRoqAnwaY23rU8q88FMnUJFkRIN
	H7Zmo5kZvSAdSPPCH8hnyQXrsgQ3ygGtTPKqWfE2X95C9lqDSN8tvKAEz+ZDuLQk
	sbiWKPTuDbNR0/SXCKroQd/8IFkNmG8EklTU425yqw==
X-ME-Sender: <xms:1DmEZdpvz8pLu10F3xL1Ta8BD2DIr8g7xf4N_pFZeAUMlV656a94hQ>
    <xme:1DmEZfqXvin6FR-QuviCB-y-8Acus729BX4e0o5Vq_lF5zu98X5KiMAW4nWzEZMRa
    rW3o--GJXITK_9Ozk4>
X-ME-Received: <xmr:1DmEZaOpieD_-li-87_Fa3EUyIsNdz_d8nNJwaDr3Xa7LIEjW1CZR-bkm48NaEkLAuW6Hw-cnVwHCwsgqEEaMRqHaFL_r-cIukE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdduhedgvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepvfgrkhgr
    shhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhird
    hjpheqnecuggftrfgrthhtvghrnhephefhhfettefgkedvieeuffevveeufedtlefhjeei
    ieetvdelfedtgfefuedukeeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:1DmEZY4YLUqCsIJnDl9DfSRh_X6-_QAXZFiCP_plrzmSJ8XDJXmc2Q>
    <xmx:1DmEZc7MbhyWuszAWqeUsuUQszmz1w1qDEwCBjZe31iGsjMHPWqBrA>
    <xmx:1DmEZQjk_Jm0MpfKKa9JcsHsaPj_bB9PZ26zk-hxHsGz4iScwQBx1g>
    <xmx:1TmEZaRn7WscGuc4BkTr65rz6FUNBawEeIByAxm6on9B3AGVxAc9zQ>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Dec 2023 08:12:51 -0500 (EST)
Date: Thu, 21 Dec 2023 22:12:48 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: Adam Goldman <adamg@pobox.com>
Cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/8] firewire: core: detect model name for legacy layout
 of configuration ROM
Message-ID: <20231221131248.GA603497@workstation.local>
Mail-Followup-To: Adam Goldman <adamg@pobox.com>,
	linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20231220041806.39816-1-o-takashi@sakamocchi.jp>
 <20231220041806.39816-8-o-takashi@sakamocchi.jp>
 <ZYQ0gNwDsocA9QS7@iguana.lan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZYQ0gNwDsocA9QS7@iguana.lan>

Hi,

On Thu, Dec 21, 2023 at 04:50:08AM -0800, Adam Goldman wrote:
> Hi,
> 
> > -	ret = fw_csr_string(dir, attr->key, buf, bufsize);
> > +	for (i = 0; i < ARRAY_SIZE(directories) && !!directories[i]; ++i) {
> > +		int result = fw_csr_string(directories[i], attr->key, buf, bufsize);
> > +		// Detected.
> > +		if (result >= 0)
> > +			ret = result;
> > +	}
> >  
> >  	if (ret >= 0) {
> 
> ret is an automatic variable with no initializer. Unless you initialize 
> it (to -ENOENT), this is UB.

Indeed. The uninitialized value is going to be evaluated. I'll send take
2 patchset later.


Thanks

Takashi Sakamoto

