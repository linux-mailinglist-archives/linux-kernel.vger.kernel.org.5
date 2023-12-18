Return-Path: <linux-kernel+bounces-3656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D35CD816F27
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 14:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECA291C229DF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 13:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178EB80562;
	Mon, 18 Dec 2023 12:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="lBwINm1S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fwDsPFb7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F3D7CCF6
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 12:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 88C1D5C00CA;
	Mon, 18 Dec 2023 07:46:50 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 18 Dec 2023 07:46:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1702903610; x=
	1702990010; bh=Sp32Kv+FtgVwjl+FmjJanWnjE4SgTjgXVYd4enIlghQ=; b=l
	BwINm1SPVYf/2xehUq8cI0Pan7ZFfVrVl5KaBov3E6F/LkWo/G5T9O50Ul1rfunP
	6nhpVjRtgtG9VpcDQGtN3gLpWDpOo7eksvJOI1D1nPsKB2jjJLKwxvYtVw/y76FI
	XVvZOI24OHF1RaLM1DWklgsB112WcueZdeBgioXFc11j2MqPG/JIdTim5OZZV0eI
	wi9Mih4vKgWhHLB9R3T5nrFEPTpPB9Qcqu+BMEsFJ4BB5gCfh/gMvG1pZbEXXttw
	vQsxlOF6rqA4KpfSpmSP6OC3CWR+GxfUZPgLF3kRprijmT7oZ0wIOkBOWSGc6KYw
	XAdCN/n+q6W6L7Hy1a/RQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1702903610; x=1702990010; bh=Sp32Kv+FtgVwjl+FmjJanWnjE4Sg
	TjgXVYd4enIlghQ=; b=fwDsPFb78Bn/QPrqT3e7IO5SbbQjzk438KtHqj4uNRfL
	3NTsLKZZgd1kwYS7XEc9/dri3Ld74Rv6HDG3GpDuqB/4TRszTi9siDD6tNyfjty/
	sGhbKvpsU59g1KdKPeZKQJzSCMLxUxksFvd0HprRohdikV1rZmgAIjb2gVaTEeUc
	K4FRFZ/eXygez6Nxmy/LfS2chHllkJX5kB1HWl/H66kVzbYRyauDYsglacQtHi4e
	yKwKZvMTvdU6z09F9VXEggwTQvAVmOi+23PvEjCIk8YvSX0u9WnWA3JQTniFmKcN
	HHQrKYgiKyfqgUkQbRbP7A1lmH2bZusb+9oRHli8uQ==
X-ME-Sender: <xms:Oj-AZZIJkcnuBN91mubhrDN9OQ4wBx-8V2BCf14dZF4FxlsEK02X9A>
    <xme:Oj-AZVJb6Nc5xu14I0dS1bz5FIPZweUoxlnd3_UvyQ_VbYoJdCEa7tCvUabU5FK0H
    H2_QTmHAvIZQC0ygTY>
X-ME-Received: <xmr:Oj-AZRvm8vIHTds7C39m_1chTwLWoLI0snDhoxt5Ih4d6evmn7h_7_zmkAFCW22j97XMckOxiS_F3-RUwN44xTD6zhdEBXXGIAs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddtkedggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepvfgrkhgr
    shhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhird
    hjpheqnecuggftrfgrthhtvghrnhephefhhfettefgkedvieeuffevveeufedtlefhjeei
    ieetvdelfedtgfefuedukeeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:Oj-AZaan73ujZ4Ps0L7yC-7pKxLNsWQt8TaomS_gQhFcENaETor3OQ>
    <xmx:Oj-AZQZK9dIvTHjAk9mi6SdqxEowlkZ7-ks-elcH-HWitHdOFiaYnQ>
    <xmx:Oj-AZeCEYCWV8TeroqsKByESZB3EP5jKjLjXIocUSQeXNCMpfWIlTA>
    <xmx:Oj-AZbzBWUNtq3ocNaweT8Sq-4WpTcWdLHAPt3Bt_JY6_A5z-FOwiQ>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Dec 2023 07:46:49 -0500 (EST)
Date: Mon, 18 Dec 2023 21:46:45 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: Adam Goldman <adamg@pobox.com>
Cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 8/8] firewire: core: change modalias of unit device
 with backward incompatibility
Message-ID: <20231218124645.GA46034@workstation.local>
Mail-Followup-To: Adam Goldman <adamg@pobox.com>,
	linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20231217103012.41273-1-o-takashi@sakamocchi.jp>
 <20231217103012.41273-10-o-takashi@sakamocchi.jp>
 <ZYAa0vJYppKgr9x7@iguana.lan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZYAa0vJYppKgr9x7@iguana.lan>

Hi,

On Mon, Dec 18, 2023 at 02:11:42AM -0800, Adam Goldman wrote:
> Hi,
> 
> On Sun, Dec 17, 2023 at 07:30:12PM +0900, Takashi Sakamoto wrote:
> > +	vendor_directory = search_directory(root_directory, CSR_DIRECTORY | CSR_VENDOR);
> 
> Setting the CSR_DIRECTORY bit here is extraneous since search_directory() also sets it.

Indeed. It is redundant.


Thanks

Takashi Sakamoto

