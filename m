Return-Path: <linux-kernel+bounces-42-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54625813B1C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 20:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F248B1F2234F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 19:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7719B6A03D;
	Thu, 14 Dec 2023 19:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="ySvXgOp3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MnsXmnTF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A186A32A;
	Thu, 14 Dec 2023 19:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 8B9505C0225;
	Thu, 14 Dec 2023 14:54:38 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Thu, 14 Dec 2023 14:54:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1702583678;
	 x=1702670078; bh=mN5qbRfsXf8A4df0Um6vbI+Vk/gTSPo9T1qldcDY91w=; b=
	ySvXgOp3x1Aa1QhcpGaVQKVQd16RvIO14MfFE0QsHNNj7SFXSVoiaQI0rEED2fa3
	l7QmFTd/e9zOuE/YcW8UoTpkmiipghNqfOruYQ9U3IQVg0ELDxi8L4s53ig/+ypk
	uV2l0rh5hzDXXSYWbHI28ceQrBYdsQCqH23rdt2W+6wf3BdgbBuHru+tYpozHMyZ
	GFvmp5DOLLmb6SP1koutbH1OtKte1z+3y8xacXbV1qL7OdbUkAKV+78uXD9TEy2K
	gs4DwmxD78Qfz2BUai4eZOVWowoH2y9z4VOEM/ZCdV106ZvBOFZcMvOLzvLO+gZ2
	tX/SLh4evNIElY/kUYB7dw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1702583678; x=
	1702670078; bh=mN5qbRfsXf8A4df0Um6vbI+Vk/gTSPo9T1qldcDY91w=; b=M
	nsXmnTFeuFSmtHXcJuoIf+miHePv4/nEeq+VGUVXOSScD4airPv/gtCkudk3Sz4T
	v0jAI3K5pnbKJIm/fdFNHkeTkyviHnlMz8/iOqvS0NJ/lhHalVXx/Fq8f7pZZDO0
	aQ/GqtxfUcbdTyD/RK+ZvJvomXKHQ6ufGTfDbscnDBQR0cncGLq9zgsERCr+vH4N
	1HoEpD5NPBB/TIB8cH4ulPrRXmHy0vbzQ7jfDBEmihcbRHw+a4UiPyZjxLNPPiVT
	91r1hiGBN1YESzebexL0uEDE2J0o1Iy7gVoJKshTQ2WCOOB4T2pciwPzwDXyofkj
	u1M+bkChNMncc3uQoiCTA==
X-ME-Sender: <xms:fV17ZeGwNMtPe72n5TpoFipkaJKY2cDig1I9td9fF4AM3IonpDyZaA>
    <xme:fV17ZfWRu1ENroOPkl6zIMEXRrFCNRoub5KmQZiFUYRrxN_c9EZei1ZK-G3HKNod9
    IWYI_a5JljNIXD013g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudelledguddvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
    tehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrf
    grthhtvghrnhepgeefjeehvdelvdffieejieejiedvvdfhleeivdelveehjeelteegudek
    tdfgjeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:fV17ZYKbO00xaR0gcox4H-y3vZYWtQebjOjp6IxIchZHK-rXWN0Aeg>
    <xmx:fV17ZYFu08xG3R_pXScrXksrOrnt514XUi4SmmKbVUtHH7hPod3z_w>
    <xmx:fV17ZUW3fSTBDdV-ii8ONTVGCjKYC7zbjADSoe0O2UB2vP1Lp8cFGw>
    <xmx:fl17ZednEFxH-L8oKmKaeRO1e3JX0MfrelOBoXRVpqA69eS-3KSgKA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id C0A4AB6008F; Thu, 14 Dec 2023 14:54:37 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1283-g327e3ec917-fm-20231207.002-g327e3ec9
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <374978b4-9bed-4d5c-90e2-344e46dedaf8@app.fastmail.com>
In-Reply-To: <40b5e438-22f4-43e5-9663-db44dd402a35@app.fastmail.com>
References: <202312041909.lwhcU35R-lkp@intel.com>
 <5f1caaf8-1edf-444a-b017-c4d08e52213b@infradead.org>
 <f712a65b-4984-46e8-bd43-1309b5cd41f0@app.fastmail.com>
 <c10194f2-097f-4455-9932-19961edbf990@infradead.org>
 <40b5e438-22f4-43e5-9663-db44dd402a35@app.fastmail.com>
Date: Thu, 14 Dec 2023 19:54:18 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Jiaxun Yang" <jiaxun.yang@flygoat.com>,
 "Randy Dunlap" <rdunlap@infradead.org>, "kernel test robot" <lkp@intel.com>,
 "Masahiro Yamada" <masahiroy@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
 "Nicolas Schier" <nicolas@fjasle.eu>,
 "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: pm.c:undefined reference to `i8042_command'
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 7, 2023, at 01:21, Jiaxun Yang wrote:
> =E5=9C=A82023=E5=B9=B412=E6=9C=886=E6=97=A5=E5=8D=81=E4=BA=8C=E6=9C=88=
 =E4=B8=8B=E5=8D=885:26=EF=BC=8CRandy Dunlap=E5=86=99=E9=81=93=EF=BC=9A
>> On 12/5/23 22:52, Arnd Bergmann wrote:
>>> On Wed, Dec 6, 2023, at 06:24, Randy Dunlap wrote:

>>> I think it's bad style to force-select an optional subsystem.
>>> How about making the entire file optional? It seems that there
>>> are already __weak functions in its place.
>>
>> Yes, I agree in general.
>>
>> Hopefully the maintainer will opine your suggestion.
>> Jiaxun?
>
> LGTM, PM is not an essential function here.
> Arnd, do you mind making it a patch?
>

I just tried it out and my version doesn't actually work since
we still end up building the file with SERIO_I82042=3Dm.

We could still make it work by checking for serio being
built-in here, but in the end I think that's worse than
Randy's patch, so let's just go with his original version.

      Arnd

