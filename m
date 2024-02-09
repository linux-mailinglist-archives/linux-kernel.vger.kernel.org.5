Return-Path: <linux-kernel+bounces-59599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDAC884F98B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 707671F2355D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C51C7B3D0;
	Fri,  9 Feb 2024 16:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="FQ5e5Bmg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CXXvjQY5"
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270957603C;
	Fri,  9 Feb 2024 16:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707495799; cv=none; b=C6Pos/iVNgDI0rnDw0opsCr2kk7Q6TxtbpDDyZwCun4KUumFEXRStrp09yErXL6IPBEQhyohz7n5Hk5O6rMzpoLYDQj5UPbqqZHc4t9D7TPE0g1EXVdAUwb5S0iCWsUuwhf7hwFmuwZx/FqQ2hrKrOyai+rX1aMKwigwpVOiKKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707495799; c=relaxed/simple;
	bh=JcQ+HhzP9r+8LKGlm3MF4H2MaJwjf5OWYGl7P9bXR0I=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=YxszYRuLEHBMN/afLbl/ioAgt6Tg9L4GpM/DxMPXXZ3be4wxQ40m54+i/bWXIHF4/VtZLrK/fRoBzqNHcinpWULSvNFG81RukvudDUxtYlWxJUb7YII0Xui/diuZ/XEuXqJwqV+rh6Jqyu9LnyexlWWaPKW7PNf9s0XslwekWtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=FQ5e5Bmg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CXXvjQY5; arc=none smtp.client-ip=64.147.123.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id 04CBF3200392;
	Fri,  9 Feb 2024 11:23:15 -0500 (EST)
Received: from imap52 ([10.202.2.102])
  by compute3.internal (MEProxy); Fri, 09 Feb 2024 11:23:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1707495795;
	 x=1707582195; bh=JcQ+HhzP9r+8LKGlm3MF4H2MaJwjf5OWYGl7P9bXR0I=; b=
	FQ5e5BmgFeFTrrXxvPbnun9BDKQVlt1gIU2jvNvrUcNHvfsLxpBvUNTyE4jUE0kN
	toRfNZYymzM7J+q6M1Wfwwe6rkgdWf1aOaoITanULehgbDZzvi/NO5Dm9QTnQ6Mg
	ozNuX0m9h3H9sg6R52jmveQgPyXSaHtrT7o1ahS3xkcmxygeoQku2TchggT/OktI
	pPgcEDCbm1j0FLKJjV1hn9/tkNbJ+VhyB/Ki8U0/oEgNpR4q6xAVQWc7ncnQOV25
	DC9YRU/Co6hRriLqI2cp7NUfxcx4xSpcxwpJ+VHMwgrGH2GGr17E4pqblVVfDIjx
	jwBn5fsJBWfW4YAYL7JqRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1707495795; x=
	1707582195; bh=JcQ+HhzP9r+8LKGlm3MF4H2MaJwjf5OWYGl7P9bXR0I=; b=C
	XXvjQY5hY/G0xCNlm55tmae7ai7e5fQDrno8NunupphipNqAuBZiysl6lHwFur4b
	wGntfr28cBxnvSDrjsYq2GS1mO6m9iOxqUz5l9VRPwYx8nMRtRAuF2Bm4lswhxl3
	qS77L3eIKUTEliKEiLjZUi6h6ElbpYOY1rbgipLhTNSDMqETv+IZxB6Mxsv5p5ic
	0J4fu9n8W1J/XZKvvTG5lC4rgKwt9smoe8nn56BTHzox7ZprA0P9xuChJzEnKyDn
	dP06TDGzl935iLthSuaYwIoyE135jwrMtvZVVTtCCemKdlWTm7BtyATNKPzLy78D
	20/iG2P6sk3peYtlC0NGg==
X-ME-Sender: <xms:c1HGZYZPoRQgZb_EUKOXLuFSkGhPtXZR1IGSyuuZHMr_o31EyDBTgg>
    <xme:c1HGZTZcn4EqUumfq4rRmEUvXSkimiq82-dNqUO05tQE5oMMGSJj56WhAxsS-FQTK
    lyMf2EBkO8aAlh2o4Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrtdeigdekiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedfofgr
    rhhkucfrvggrrhhsohhnfdcuoehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssg
    drtggrqeenucggtffrrghtthgvrhhnpefhfeegudeftefgteelgfekgfdvjeelleevgffh
    jeffhfdtiedtjeefkedvuefgkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggr
X-ME-Proxy: <xmx:c1HGZS8f2yrjd3l0sVfawoNpzhwMbJPXpnKBhOhuXyb1lD0x0L5ovA>
    <xmx:c1HGZSrth-NGi03SssdlQ66fZ93H5dXi3xC3m21k_9yeYlzvV45JDA>
    <xmx:c1HGZTp770qVLstzLYo8561s5-gD0fan48BlpddpobSpDlWUGp52WQ>
    <xmx:c1HGZcCzOzknIjbSPLd9BBu0qFDUG5nLrVbf2QNLH54kg96xRt84lQ>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 3C429C6009B; Fri,  9 Feb 2024 11:23:15 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c4e6d61d-d836-4a79-a89d-141f92f6b41e@app.fastmail.com>
In-Reply-To: <dfb993c6-0e10-bc70-e8e9-a88651863a27@linux.intel.com>
References: <mpearson-lenovo@squebb.ca>
 <20240209152359.528919-1-mpearson-lenovo@squebb.ca>
 <dfb993c6-0e10-bc70-e8e9-a88651863a27@linux.intel.com>
Date: Fri, 09 Feb 2024 11:23:18 -0500
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "Hans de Goede" <hdegoede@redhat.com>,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] platform/x86: think-lmi: Fix password opcode ordering for
 workstations
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

Thanks Ilpo

On Fri, Feb 9, 2024, at 10:34 AM, Ilpo J=C3=A4rvinen wrote:
> On Fri, 9 Feb 2024, Mark Pearson wrote:
>
>> The Lenovo workstations require the password opcode to be run before
>> the attribute value is changed (if Admin password is enabled).
>>=20
>> Tested on some Thinkpads to confirm they are OK with this order too.
>>=20
>> Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
>
> Would a Fixes tag be appropriate here?

Hmmm - good point, though it has been "wrong" since it was originally im=
plemented (where we tested on Thinkpads).

I guess I could use the commit ID from when I originally implemented opc=
odes?
Fixes: 640a5fa ("platform/x86: think-lmi: Opcode support")

Do you want me to push a new version with this?

Thanks
Mark

