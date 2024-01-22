Return-Path: <linux-kernel+bounces-32575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B65835D71
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26912B284CF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 08:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 200FA39ACF;
	Mon, 22 Jan 2024 08:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="gsJo3Nwd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X7tayABS"
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D226839846
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 08:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705913772; cv=none; b=P8sYZ0Ceua0y2f40NPkfEedGQfO5hDtmCFD/CviXuk8/9oBf99xRooCwiKCZXJ7Qj6oh3mFC6FBdnEMJJ3o9sX2St8JZg2FxSijqwGRd/xGaxHxJYSK39v/jlU9uFGeHqqpdLM4VYNlsR4HI6nyfEje+pzoK9i5DiiikmfHTmO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705913772; c=relaxed/simple;
	bh=3T9d+RtQGIM1ZlAxzmHkJ6LgiUDsgnVKGAE3HtZKsCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V7yrj6SfN5TuCzN/mFu2NzeP10khIcp/TnwGtEwHVGPsVcWqefqirk+dmCyLadhYtKXmSphn6i/XsUAIdej57mMAlc5n3n3wQi8qJlKrA01RQPXgt9UraKxDBTqPtemGXOBLjMtTrsd6QRXfVit+UlJLXNMeftSXPNaJ6MyPLz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=gsJo3Nwd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X7tayABS; arc=none smtp.client-ip=66.111.4.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id B99D95C015E;
	Mon, 22 Jan 2024 03:56:08 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 22 Jan 2024 03:56:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1705913768; x=
	1706000168; bh=jCJhY/hrZos2QYaYx0pzY9ipp8ub1zvgZRZtgPKnZP0=; b=g
	sJo3NwdEGK6StViwC6qt4KIfFhNyRxLTmMK5jS3fE352NSuXvPhk5fQlHljFZQQx
	PgxmK7FM2gJmtDLlKnrJMAVF+b+ilvMCP52LfLKqpvaQPNjF9Pjt9t8y1DscNOG/
	vcPxHc9HpPXA1SBry3XXWjb+HIkeL4bULWwch8IVFNKBAyBDlUpi3MW4xOsD3KlD
	WQ1jRrvehM0Ao0V4Sn5lfoXIOYqkmujlDOEY1pTi3nRuSa1Gr5gpN7jF0kAbWW6b
	TPUnU3LaGo3hXXyvkXYdnZff2G7ofwUGh4r755Ic8SP4SSKdNNTpNiFd1t1sBQTj
	1nHo7sRAguF+bq+ICR/KQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1705913768; x=1706000168; bh=jCJhY/hrZos2QYaYx0pzY9ipp8ub
	1zvgZRZtgPKnZP0=; b=X7tayABSceUPXuyz+7cCq9HgUKF4BbiNGIuk4+GgLel3
	StsY2tDKcueIK+c/ptQHgmVYba3PhvXW/rPOPzNuRJZp/TlUJB7nKhjvPaPibDsF
	fesWAQ4DUNg3IgNBsd9Iv+VjLoXS3w+fB+v4tHcnsS6HIkVwQV2TCBzcFO+7X/YS
	nzhpKtD1donAGQnu9d6k6wMWfpqFPMiCmz5mdI/tkGST5IvdZ5mkId/kMXdRye2N
	V3R1kz/q4u90ymlHWFM0W95zX3pi9Bh7my36v+ZjB+X+BQY0geQa544J2/EU+anz
	TE8+OOwr1TtGnRSAYAtxghcXtrxfmkzu3mryxifj+Q==
X-ME-Sender: <xms:qC2uZZzRR2o5PrjecHk9-DiehNm75UcMPclZpl_fDerTL592_UbF5A>
    <xme:qC2uZZSDrJJNx94m2WiYKLU4y9sf3vDXZ5QWrnb7YGVmYFuCnOpdnUKV6DbhN3xFq
    STTZNFVQhFO7vfv0w8>
X-ME-Received: <xmr:qC2uZTVWew3a7KEaVOLeFLDtHMnX5b8_jmzPfwiJ1p6jK6sAPeyWe3xAoKzLIQJCa1Pr1ggjcs6SgOHKLSTDgUsaxN3eG3sYVwc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdekhedguddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvrghk
    rghshhhiucfurghkrghmohhtohcuoehoqdhtrghkrghshhhisehsrghkrghmohgttghhih
    drjhhpqeenucggtffrrghtthgvrhhnpeehhffhteetgfekvdeiueffveevueeftdelhfej
    ieeitedvleeftdfgfeeuudekueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:qC2uZbi-tkBd-ebjh0llEulg3r3GK7iGb-Agd06SfrA9cFO4TqH4WQ>
    <xmx:qC2uZbBIDFvnU_N1XaPrAPogk4_uVNTBceoDBqyyJ8Nnt41n1NI9sQ>
    <xmx:qC2uZUKvr_BBfXzZFsa9EWQ_qBR0NKBvUBQU0RCJARyuBuolRaW5OQ>
    <xmx:qC2uZQ7p8cuk6kkRDmiLpsFGjjnWluG6kuGTGTtIycd8AMBGaepJfw>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Jan 2024 03:56:07 -0500 (EST)
Date: Mon, 22 Jan 2024 17:56:04 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: Li Zhijian <lizhijian@fujitsu.com>
Cc: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
Subject: Re: [PATCH 1/2] firewire: Kill unnecessary buf check in
 device_attribute.show
Message-ID: <20240122085604.GA254251@workstation.local>
Mail-Followup-To: Li Zhijian <lizhijian@fujitsu.com>,
	linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
References: <20240122053942.80648-1-lizhijian@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122053942.80648-1-lizhijian@fujitsu.com>

Hi,

On Mon, Jan 22, 2024 at 01:39:41PM +0800, Li Zhijian wrote:
> Per Documentation/filesystems/sysfs.rst:
> > sysfs allocates a buffer of size (PAGE_SIZE) and passes it to the
> > method.
> 
> So we can kill the unnecessary buf check safely.
> 
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
>  drivers/firewire/core-device.c | 14 +++-----------
>  1 file changed, 3 insertions(+), 11 deletions(-)

Applied both patches to linux-next branch, since they are not so-urgent 
fixes.


Thanks

Takashi Sakamoto

