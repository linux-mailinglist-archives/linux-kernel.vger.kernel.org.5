Return-Path: <linux-kernel+bounces-90698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 632BE870387
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 15:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9B121F26D8F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 14:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1A03F9C3;
	Mon,  4 Mar 2024 14:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="QGmT4hxL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fu/R4XyE"
Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4609D18E2E;
	Mon,  4 Mar 2024 14:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709560967; cv=none; b=Mun8DLWbNOp/0LEhOdmjuTnDrvqFgeTlbkl4Q8rHMZZtZnZDwQYeTyJ6WpIWKVJsrYdQbjmPiBqCb7zxVv1KdtsbYvmUtCaEe4pdbOP7lJFPZ7n2K1fNnw9A0XK9ilO6f2JgIc6xZpcuCD5Ankk/GTXifZIQzWkYfPghPaIGZOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709560967; c=relaxed/simple;
	bh=oW3W6ISMlJ8Eg/hIHK1jMTGlAIWDK7R9bRS0g0+jPHo=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=eoIV8yad0kMCSC0T5Vc7MSTemxdIA5jG+auaxARaKZ5hQVeUnhFslW6EzSYQuGlSKUcaWqC0ouazw0yexZPsml0jF40JOLDKLUArIuuDUhDAMQO0xfWclDnd8unJSVrkewesR1FNzvvtfgtaGIelr9/wsDlupYDtv2hzv5s5Ui8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=QGmT4hxL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fu/R4XyE; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 501D311400D5;
	Mon,  4 Mar 2024 09:02:45 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 04 Mar 2024 09:02:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1709560965;
	 x=1709647365; bh=Tyc3a0qlsGocDX90h5xGZM+hiCwDa28icbfjEtQ1zvk=; b=
	QGmT4hxLNmXGRO4v8IvjfEmWtXchgSMU24haZAHL4NW4DDDMnfs8r+EyLQzXryfo
	vX435XzUZWRrzWY+Gs1nqemCgJZDw0+xWhpxgAZDJZwaSDjmJyxoNgtO3fo0p10X
	bPexUBHqFSEl8QL+wBysexQN6gN6vpoIlenx2XSyq7Ilv8ZhcO7yEQ43bVvHzilv
	0atKdtofMbe8qwL+83Wyx/Z6KvcBdcKv7ojY7YNk8fBnFZngoGM8KNRRj0+fVzyd
	Fd2WQfIQs1S9OWOUPVGQLPfmoIpSLWm6UzubajS7F5iRgNHqrRw50Q9kxMoLCYZm
	4fXaZ6/JotwSFacA/5jGAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1709560965; x=
	1709647365; bh=Tyc3a0qlsGocDX90h5xGZM+hiCwDa28icbfjEtQ1zvk=; b=f
	u/R4XyE+vPN6RibXUKog+0xaHcTYuBNIdnDDkFXGO0/FunwE8VWyEpoMTF9L/5Nq
	rlPmCRO5XLYgPbKv+5l7gbxnsZ0yxNLnNi5+oRcPp9mkuU6X+NXtHT+09Ox1NJ0r
	5SlJohgOr80SI/6xbRLNy7MgluqY7v3BFcd8X8xPEoMDTzTdBqjEXbPnEzr2Ypy9
	4t8gCtlcVsPMFMBAqBWxCeigDDCOxHrs/9HZ584RvkJmHFiRRntQ23eBL7BJefqC
	wAzsp1nQ2pseaRQrIE2t9+JfW7iFJnXGj2lgUsdkSodgWVaZ1+c2BRPWclZZhsO7
	undGJVuOVjeDDvX2jcmiA==
X-ME-Sender: <xms:gtTlZd_NN9IfbcavqA02lUeQUK9glF1D8g-xgTj0OaukXht_pkakHQ>
    <xme:gtTlZRseQxhD7o0mA4nFhRRRcpPWq8KhBzAwpQ_2WzOrgCU5NkOQyCsZa33N6O2bf
    9X_uNVCUBiUVHA5Jm8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheejgdehkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepgeefjeehvdelvdffieejieejiedvvdfhleeivdelveehjeelteegudektdfg
    jeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:g9TlZbBr5MPmIecoKgXRB13aymYfIbR3OS0v5gVDhe8tNomBgTTF6g>
    <xmx:g9TlZRdmJcw66TEtr_syhGOZXx-B2IyBL4T2SmtwKwNSYbZVnoD4VA>
    <xmx:g9TlZSPmHNHDWF6RgyJni1Z6Duznav77L3s-o12LBBBhHOrnnwZmTA>
    <xmx:hdTlZXfZOkInKEEcYLMv1ZLDUfYNuEU81F-xLYkbSortVbCH-f64bQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id BB003B6008D; Mon,  4 Mar 2024 09:02:42 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-205-g4dbcac4545-fm-20240301.001-g4dbcac45
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a9063efe-1faf-4945-83ce-449a23d44fc5@app.fastmail.com>
In-Reply-To: <36df8535-083f-4ce3-84c7-b8f652a9085b@notapiano>
References: <20240212-coreboot-mod-defconfig-v4-0-d14172676f6d@collabora.com>
 <36df8535-083f-4ce3-84c7-b8f652a9085b@notapiano>
Date: Mon, 04 Mar 2024 15:02:21 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Cc: "Brian Norris" <briannorris@chromium.org>,
 "Julius Werner" <jwerner@chromium.org>,
 "Masahiro Yamada" <masahiroy@kernel.org>,
 "Nathan Chancellor" <nathan@kernel.org>,
 "Nicolas Schier" <nicolas@fjasle.eu>,
 "Catalin Marinas" <catalin.marinas@arm.com>, "Will Deacon" <will@kernel.org>,
 "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>,
 "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, kernel@collabora.com,
 chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-kbuild@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 "Tzung-Bi Shih" <tzungbi@kernel.org>
Subject: Re: [PATCH v4 0/4] Allow coreboot modules to autoload and enable cbmem in the
 arm64 defconfig
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 4, 2024, at 14:56, N=C3=ADcolas F. R. A. Prado wrote:
> On Mon, Feb 12, 2024 at 09:50:04AM -0500, N=C3=ADcolas F. R. A. Prado =
wrote:
>> N=C3=ADcolas F. R. A. Prado (4):
>>       firmware: coreboot: Generate modalias uevent for devices
>>       firmware: coreboot: Generate aliases for coreboot modules
>>       firmware: coreboot: Replace tag with id table in driver struct
>>       arm64: defconfig: Enable support for cbmem entries in the coreb=
oot table
>
> is it ok for Tzung-Bi to merge this last patch for the defconfig throu=
gh the
> chrome-platform-firmware tree?

I would much prefer to see this patch get sent to soc@kernel.org
so I can pick it up through the soc tree. I'm usually not worried
about bisection issues with defconfig changes since most users
have their own .config anyway, and in this case I don't see
any strict dependency and would just merge the patch directly.

     Arnd

