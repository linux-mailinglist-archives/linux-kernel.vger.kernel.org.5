Return-Path: <linux-kernel+bounces-15730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D771F8230F5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 17:03:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6955CB23C7A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 16:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE0D1C294;
	Wed,  3 Jan 2024 16:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="AwqK80hX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i/bzzaEj"
X-Original-To: linux-kernel@vger.kernel.org
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC4A1C287;
	Wed,  3 Jan 2024 16:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id D20453200A33;
	Wed,  3 Jan 2024 11:01:56 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 03 Jan 2024 11:01:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1704297716; x=1704384116; bh=zerdII11Pc
	HIs2IOb7NkEzCQJgSakeLaHwCLP1gYgms=; b=AwqK80hX8Ajw0lFy/L1TkJ5Von
	5+iiTs9j/hclVmOY50q5k0ZOTxmsMEzUwlMLLRlg8AXXmjb7In+KX/JGsQzlfi5i
	dRhBgRVI7Thexhx/47yjvRt8WKruTxYYGFOX239D2uJ4HlgVlc2r91WYRvatG9f/
	IIlfoPNbUcOKkurMhvhTwmWUt5cL2pajC01yqNpGxgziDB+VR24ZcBh6GOlh+9yK
	diGvxwHaGb3yxR/qvC33r3mWvLZyt0QVkLQ6Bzw5Tf41o5n1qx76Ay1P3ivPrxlJ
	F3k4IvP7xva/tKUj5zvwaXeHowxHPyfHuGCIznovEZOnEbDZpojNXdjkNXpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704297716; x=1704384116; bh=zerdII11PcHIs2IOb7NkEzCQJgSa
	keLaHwCLP1gYgms=; b=i/bzzaEjGwwHLBGbfSddu3ZMkdzfPRoZFYbln9O2p0OL
	916OvtNspweUDjeighbfB69ezfIjkQHLkZVbMJUmMlJNuoMGkvB8gp+fRMB84HRO
	37Tllb6Ly7S4cm54yDrPNMR1P5rE+l/m6TcQhmkECPtSfcwt7PuDsr9Az00qgcie
	GEZrlFCMTfnQE2TxZXc+I2FwCKtoglNg/nfnbT8a4Du5kd/G322KR3vnb1eWRXX7
	bmq90tByD76oUTvSrCzkWDEuK2frSOpprKj9O3/m6uwAUuzmRYcZUriVRLDw+/i8
	KHr+LJiGa4dENe4MZKvwK3DjFKoZHh2dxnclWlrihA==
X-ME-Sender: <xms:84SVZfeUdRqRZ_35z2mgs5lXouS79CqvtnpoTQ4H45ctQJ-v_QremA>
    <xme:84SVZVNzkLUiSW-23clNxAbna-jeU0J9066nR_lDJ77u0NranorCn2lMmjXOrGG3S
    hAXaPwOTfZT9K3piNo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeghedgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepgeetiefhjedvhfeffffhvddvvdffgfetvdetiefghefhheduffeljeeuuddv
    lefgnecuffhomhgrihhnpehprghsthgvsghinhdrtghomhenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:9ISVZYgEAlgfahnNmo9vgHhciXE3CMzQdjqfuaCZwq2kVgOzC754MA>
    <xmx:9ISVZQ-KMavfryjSJNRLBR6gWLuloVY8Z8xnVEziMf5irgwh_hbWWQ>
    <xmx:9ISVZbsGOer7F-zbjB1CEgNTRY9r8ip5NXtk0GJpQ9NkUixKdydZCg>
    <xmx:9ISVZfFs_0HH0PEun0erNYmsgFTymzPa0ebsDjmvoMppDjHP3o4C2g>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id E469DB6008F; Wed,  3 Jan 2024 11:01:55 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1364-ga51d5fd3b7-fm-20231219.001-ga51d5fd3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <557cfaec-6721-4409-83c9-6a60742a5021@app.fastmail.com>
In-Reply-To: <ZZWBS5EugvO2dBp0@C02YVCJELVCG.dhcp.broadcom.net>
References: <20240103102332.3642417-1-arnd@kernel.org>
 <ZZWBS5EugvO2dBp0@C02YVCJELVCG.dhcp.broadcom.net>
Date: Wed, 03 Jan 2024 17:01:35 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Andy Gospodarek" <andrew.gospodarek@broadcom.com>,
 "Arnd Bergmann" <arnd@kernel.org>
Cc: "Michael Chan" <michael.chan@broadcom.com>,
 "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>,
 "Pavan Chebbi" <pavan.chebbi@broadcom.com>,
 "Somnath Kotur" <somnath.kotur@broadcom.com>,
 "Kalesh AP" <kalesh-anakkur.purayil@broadcom.com>,
 "Randy Schacher" <stuart.schacher@broadcom.com>,
 "Vasundhara Volam" <vasundhara-v.volam@broadcom.com>,
 Netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bnxt: fix building without CONFIG_RFS_ACCEL
Content-Type: text/plain

On Wed, Jan 3, 2024, at 16:46, Andy Gospodarek wrote:
> On Wed, Jan 03, 2024 at 11:23:11AM +0100, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>> 
>> A recent patch series generalized the filter logic in bnxt to no
>> longer just be used for RFS, but it now fails to build when RFS_ACCEL
>> is disabled:
>> 
>> drivers/net/ethernet/broadcom/bnxt/bnxt.c: In function 'bnxt_cfg_ntp_filters':
>> drivers/net/ethernet/broadcom/bnxt/bnxt.c:14077:37: error: implicit declaration of function 'rps_may_expire_flow' [-Werror=implicit-function-declaration]
>> 14077 |                                 if (rps_may_expire_flow(bp->dev, fltr->base.rxq,
>>       |                                     ^~~~~~~~~~~~~~~~~~~
>> 
>> Add back one #ifdef check around a call to the missing rps_may_expire_flow()
>> function.
>> 
>> Fixes: 59cde76f33fa ("bnxt_en: Refactor filter insertion logic in bnxt_rx_flow_steer().")
>> Cc: Michael Chan <michael.chan@broadcom.com>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>> I don't know if this is a correct fix, only checked that it is plausible
>> and that it does address the build failure. If a different fix is needed,
>> please just treat this as a bug report.
>
> Are you using a kernel config with CONFIG_SMP=n ?  That was how I was
> able to reproduce this.

I saw this in two randconfig test builds on 32-bit arm, both with
SMP disabled, though I did not expect that to make a difference.

In case it helps, this is one of the two config files:
https://pastebin.com/raw/uxHEXzG2

> There is a good oppportunity to clean this up a little better.  When
> CONFIG_RFS_ACCEL is not set there is no reason to even have
> bnxt_cfg_ntp_filters included in the driver build.
>
> I'll talk to Michael and we will post a fix for this.

Ok, thanks!

     Arnd

