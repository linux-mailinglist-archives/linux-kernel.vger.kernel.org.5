Return-Path: <linux-kernel+bounces-14853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC66822336
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 22:22:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28AE7B20BAD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 21:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE1E168B4;
	Tue,  2 Jan 2024 21:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="FQzzBiLq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QbIJ6/Qo"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F73168A2;
	Tue,  2 Jan 2024 21:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 37DF85C0545;
	Tue,  2 Jan 2024 16:21:54 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 02 Jan 2024 16:21:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1704230514; x=1704316914; bh=f48AgWcFEp
	gF/0dIz78P2eBfvCrK498VxBEFdpVW/rM=; b=FQzzBiLq5QUbTq1IZJ0HkCziBk
	JsoKK0Jr4k1HUdqKWl9KoDqL4KG09C6julFyTt+kVrdMqdqKiW9HuB3aKQcB1Dni
	RM7N9eQofxupW5FLjmtoWpCNmcN/mcdcs8ZP4Tnpj4nia3szOI1JLoSg6Jgrqt0p
	2pLJhFeH74QgrDqvRtYIMCKjOW8I1Bi3NovwmJEtyjWdPg3XXOpg36twEtQogO0U
	tsatLo1KDyZObUqq0Tpa03mc8O8fR35RID1xz6spujZ+Ps5zaPbIL+aCY+/YmOSm
	QCFMUry4U1Do4yoz5gVw+NWNDOeCY4POEyKTXnCfOr0QIu8iteE8oRTxffVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704230514; x=1704316914; bh=f48AgWcFEpgF/0dIz78P2eBfvCrK
	498VxBEFdpVW/rM=; b=QbIJ6/QoXywQtwSe+5dh10lXAJ83JBHqoG4WF59ypa1T
	/22VVdNsWpPPKRSL+TnF7CSidnW3ONE7odkNkMtWdXc97jdRlNfAX+66Mm0THCxH
	KG9fNZKBX50WiGT8Yo/MEAN/riJIx97j8j63bWhy71BkPlzGw3GQvjNCrU8gXYBC
	CxGoJllZmf62dkf5ad4WqZPHrZP/Xqu3RsJN4rZZEEBNCyEz0asR+xWyzHHWDhRl
	KBFtzoirvB/zxSDj/o9TfNNGM8JM7Bm1fBrNsBPFxeVQa5xAJ33r5202HZ3CfzbQ
	VuTt0zIvMEUYwy68SS8YldC9p1go2yur3uExhtGMtA==
X-ME-Sender: <xms:cn6UZZudzgM_xiTPPs5s7-WKrTF8113mXEQ1abPKk9VTMS3z3aWhsA>
    <xme:cn6UZSd5bD2ds1yu4kq5KTnV5A0S1CdobdV0m3yQipfmA1K9T_xDzusWta3E_F6qH
    7hl_tVB69Hu8DqaS-A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdegfedgjeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepvefhffeltdegheeffffhtdegvdehjedtgfekueevgfduffettedtkeekueef
    hedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:cn6UZcz3XBVK1YSXLXIzypeVFTsiJHbub1dnyoCOIZbHxVy2W4tHVA>
    <xmx:cn6UZQM2KjwdiioUTigneXkBZtxjL8ekB0uqfXNSO_PnLI2Pr7mhvA>
    <xmx:cn6UZZ91hyuFntkw5wnrFiLrKYTubwn79lQDZoCICLexKsBEn3tW-Q>
    <xmx:cn6UZSObkumm59_nmBy5_qbBhHepVu_bC-zmWiWfrcvnEZKoHt_GrA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id EEC21B6008D; Tue,  2 Jan 2024 16:21:53 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1364-ga51d5fd3b7-fm-20231219.001-ga51d5fd3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <fb69e804-6a9d-4052-a96e-40f8a20c189a@app.fastmail.com>
In-Reply-To: <d1ce6aba-1b10-471c-ba60-10effa1dac10@corelatus.se>
References: <d1ce6aba-1b10-471c-ba60-10effa1dac10@corelatus.se>
Date: Tue, 02 Jan 2024 22:21:33 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Thomas Lange" <thomas@corelatus.se>, Netdev <netdev@vger.kernel.org>,
 linux-kernel@vger.kernel.org
Cc: "Willem de Bruijn" <willemdebruijn.kernel@gmail.com>,
 =?UTF-8?Q?J=C3=B6rn-Thorben_Hinz?= <jthinz@mailbox.tu-berlin.de>,
 "Deepa Dinamani" <deepa.kernel@gmail.com>,
 "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>
Subject: Re: [PATCH net] net: Implement missing SO_TIMESTAMPING_NEW cmsg support
Content-Type: text/plain

On Tue, Jan 2, 2024, at 22:13, Thomas Lange wrote:
> Commit 9718475e6908 ("socket: Add SO_TIMESTAMPING_NEW") added the new
> socket option SO_TIMESTAMPING_NEW. However, it was never implemented in
> __sock_cmsg_send thus breaking SO_TIMESTAMPING cmsg for platforms using
> SO_TIMESTAMPING_NEW.
>
> Fixes: 9718475e6908 ("socket: Add SO_TIMESTAMPING_NEW")
> Link: 
> https://lore.kernel.org/netdev/6a7281bf-bc4a-4f75-bb88-7011908ae471@app.fastmail.com/
> Signed-off-by: Thomas Lange <thomas@corelatus.se>

Cc: stable@vger.kernel.org
Acked-by: Arnd Bergmann <arnd@arndb.de>

