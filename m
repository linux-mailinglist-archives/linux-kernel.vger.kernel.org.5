Return-Path: <linux-kernel+bounces-15437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8089822C00
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 12:20:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A4D41C233C6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 11:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC72818E24;
	Wed,  3 Jan 2024 11:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="siv4dEvU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="4skXX/n4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988F018E0C;
	Wed,  3 Jan 2024 11:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id A52445C01B3;
	Wed,  3 Jan 2024 06:20:11 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 03 Jan 2024 06:20:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1704280811; x=1704367211; bh=pURSsn42YA
	SyjShYaXFji90kv1W3zA6MqwSIHytkY6k=; b=siv4dEvUTdBa5tvrhjfr+0AqUz
	MC+yLr0d/hie2ElJdhXE9U9i8FdAlYhNaIEZmQeU+lNJct2lmqOdDgG+nRXE5BsM
	C5FklLlR8QJTIAZDb3dj/PPrWr5DVY4x/HhO6TtjYHj+QUOk2vZm0sh2Vj6WXydu
	n4q3vm4M3wha7rsHEyNFxcGjCH3xc1Isk7KRS6HIXHsFAcOxb2k8hTFwneI5+15Z
	gobIeGOZT+UymSBgtLf9wiN1FcAu8RUU59qpQwF8O66etIKmvILPllLQaTBdd40r
	YNcgJOYfxWSWgPIIs6sOnKJ435C+gG/P6CaoTcRVXnHxJOCLVonBVe8QOKlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704280811; x=1704367211; bh=pURSsn42YASyjShYaXFji90kv1W3
	zA6MqwSIHytkY6k=; b=4skXX/n4oIK9krhbABBIURU/f98yOhCL/oPYgI5oU5Z+
	VkaXh/klpi0UAZRtaSn046r9uHggozA+xgWjGwjw8GyFFcnCJ4wFlvwTOfTy2Y9S
	V/0QmRnrOXtt7YY682YRc/SkAfdtIpbnwMNv7zpU+966o8rzMfhHRB7qsNaod7VR
	qMBTBB77FWBtf18fC1KSHS0ZDY9ylin/rdXIacfPPF57FrIZacSWv1LOkoSOCFwZ
	fmIxT7vVeyni6WpHWrke4MvSnErl695+OZEsboiu7aJ7MV/RcWaarE7toqN0kOE1
	hVJ9w+2aj2yhVB4HDNgCgc2+uIhDDb7p1RnCdIcJPw==
X-ME-Sender: <xms:60KVZbdhEAWYmjrIFrdGSQ2sj_mVdqoTzTYah8F4j7_DlhX0ARREbQ>
    <xme:60KVZRMhbu4YCMbfPMGTcIzliLDg4h_uMFSifraI9pZiSIkbkd03xGxJ6ymBmxt_I
    rELdQD8QBMsF0dLQUk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeghedgvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepvefhffeltdegheeffffhtdegvdehjedtgfekueevgfduffettedtkeekueef
    hedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:60KVZUh_f2VP4sA3WEv3PIk-btw0PRX6d4s0yc_sZc3KVTUIn6ZbwQ>
    <xmx:60KVZc9N587-YLpnmIzzjrAna-6-dL4UlvVVw3W2gNkTzvgPHq7U-A>
    <xmx:60KVZXvfe2FcwdAq1MI7aZDwQ_SesO7RkKTy29yA3_mc3f8X_aoXUA>
    <xmx:60KVZXEplb9W-61xCi7E_hgXj8mIat1e_CooVTvFlmTxo-tCObMx8Q>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 0C00CB6008F; Wed,  3 Jan 2024 06:20:10 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1364-ga51d5fd3b7-fm-20231219.001-ga51d5fd3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c66dd905-3342-44ff-9aa7-ff2c7b9024c7@app.fastmail.com>
In-Reply-To: <ZZU87SZcE/6i8lyo@boxer>
References: <20240103102458.3687963-1-arnd@kernel.org>
 <ZZU87SZcE/6i8lyo@boxer>
Date: Wed, 03 Jan 2024 12:19:50 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Maciej Fijalkowski" <maciej.fijalkowski@intel.com>,
 "Arnd Bergmann" <arnd@kernel.org>
Cc: "Jesse Brandeburg" <jesse.brandeburg@intel.com>,
 "Anthony L Nguyen" <anthony.l.nguyen@intel.com>,
 "Jakub Kicinski" <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Paolo Abeni" <pabeni@redhat.com>,
 "Simon Horman" <horms@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>,
 "Larysa Zaremba" <larysa.zaremba@intel.com>,
 "Piotr Raczynski" <piotr.raczynski@intel.com>,
 "Amritha Nambiar" <amritha.nambiar@intel.com>,
 "Alexei Starovoitov" <ast@kernel.org>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 Netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ice: fix building withouto XDP
Content-Type: text/plain

On Wed, Jan 3, 2024, at 11:54, Maciej Fijalkowski wrote:
> On Wed, Jan 03, 2024 at 11:24:45AM +0100, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>> 
>> The newly added function fails to build when struct xsk_cb_desc is
>> not defined:
>> 
>> drivers/net/ethernet/intel/ice/ice_base.c: In function 'ice_xsk_pool_fill_cb':
>> drivers/net/ethernet/intel/ice/ice_base.c:525:16: error: variable 'desc' has initializer but incomplete type
>> 
>> Hide this part in the same #ifdef that controls the structure definition.
>
> Hey Arnd,
>
> this has been fixed by Vladimir:
> https://lore.kernel.org/netdev/20231219110205.1289506-1-vladimir.oltean@nxp.com/
>
> in a way that we don't have to wrap driver code with ifdefs.

Ok, sounds good.

    Arnd

