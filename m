Return-Path: <linux-kernel+bounces-12546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A900681F683
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 10:48:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD8511C2288F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 09:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790936FA3;
	Thu, 28 Dec 2023 09:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=svenpeter.dev header.i=@svenpeter.dev header.b="JEODCXGf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q+kQXi9i"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8428C8DB;
	Thu, 28 Dec 2023 09:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svenpeter.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=svenpeter.dev
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 172185C0085;
	Thu, 28 Dec 2023 04:47:10 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 28 Dec 2023 04:47:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:message-id:mime-version
	:reply-to:subject:subject:to:to; s=fm2; t=1703756830; x=
	1703843230; bh=InsY1OZSAZnSuRG5SxIiyCXnOFO2J93RUtltbwwZBKQ=; b=J
	EODCXGfaWH/RBkHZg+MRUqF14mEFLiGkf14+E4Owwcr9gcZY/MDgMh0K4ZwLuVZO
	Vf6vvjrZDlISOgRZ9g1bd/X7f5YPiXR6UV/urfeRAzEliopi0TDWjUA+LCmxxNyj
	s3FCRG7wh7i93JKXGmYeJNUpK8erAuFOrforPnOxfZG9XzlTtMnRKkzR/CSeWvDr
	cdgmZ+vgApPg2fd2oXITlzVYbsS17tiOZWHcbfNVpU/atoRuHFdpXrCYvwCermAB
	ruA4bt40t6hPIBK5FLSpEUA+ysgnWG5/zxXkLIWO6ufF711mi1TMHv4AhmFjilBD
	Dn5WNeP0RU5qrbWijm+IA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1703756830; x=1703843230; bh=InsY1OZSAZnSu
	RG5SxIiyCXnOFO2J93RUtltbwwZBKQ=; b=Q+kQXi9iTox/LHxCTiogbP52BxlSn
	AuAqbM6oHAU6oRIxONdnB24SftCQulLg30NCmtTkXPFnJ5soDBYFWlFTlRcEuGaN
	AbKa+oCNavbBUPlRSWuQAr/LRj+heuP+CqMjk7KZtBxdfJdlOAjxKydk8/+fn6Ul
	DO9HzATDcAT6LS41wtASf7UX9TE4yQxDdnUOaOxhN2DLji7433rmUM9hi9FRCZNr
	MyuzfeWJrts/IstFwR6gkCfeWawTRKbXQ/71fXn+OqFxQW93o89DRNOQRzyMrSfw
	a/sxh1sPy5UySogDK4w0MJoYP8Bvi/3Mxz+6/1c0kHNjTW4d3j+aXPFjA==
X-ME-Sender: <xms:HUSNZc39K3WYZc-YiW5QMAka5XWh7gfHT7T8UFb3ThG_yavNn91nmg>
    <xme:HUSNZXFas3AUsapFZmLAKT_AlBB6FjfLCtUMHafwuDsO4SEYZAW9gz7RYs1OorlMX
    ZpPO43X2m9L3ZOOTDQ>
X-ME-Received: <xmr:HUSNZU5gK3V14ecc6FSbK2IHQ8PLeMZNoO5wL1XmVQeufORXYLQbDOTvKLnyN9aj_Bxqyfl0VLpkkc_lWM91OipeDylLg16oAKyvL1-bz_BLF4ta5szwj0zikwK6Zg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdefuddgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurheptgfghfgguffkffevvffosehtqhhmtdhhtdejnecuhfhrohhmpefuvhgvnhcu
    rfgvthgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthhtvg
    hrnhepleehkeehudelvefhteeltdelhfekiefgkefguddvheekjeehuedvtdeikefhgeel
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:HUSNZV2ByYyS1HTDH2irmFn-Zao3jF9vqBR0BgGZ08cjUU7zZ_5_zQ>
    <xmx:HUSNZfFmBSCmTAfv-Wj9_SZy6mFWdQi8KmATinoeufcSHcPsxufPcA>
    <xmx:HUSNZe_22-F5_YmMRyo28uLypzQog2athcPLRgJhU3qTY3BrIxfnhQ>
    <xmx:HkSNZQIbd22bB8eWUI6N3DRwJGU1uQYSHMvHcIJGBWjtLtN5piajWw>
Feedback-ID: i51094778:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Dec 2023 04:47:09 -0500 (EST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Sven Peter <sven@svenpeter.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v3] Bluetooth: Fix Bluetooth for BCM4377 on T2 Intel MacBooks
Message-Id: <AB87C916-9CF9-4B8C-AFF5-74CA4151C4FC@svenpeter.dev>
Date: Thu, 28 Dec 2023 10:46:57 +0100
Cc: Paul Menzel <pmenzel@molgen.mpg.de>, Felix Zhang <mrman@mrman314.tech>,
 linux-bluetooth@vger.kernel.org, stable@vger.kernel.org,
 Johan Hovold <johan+linaro@kernel.org>, Hector Martin <marcan@marcan.st>,
 Bagas Sanjaya <bagasdotme@gmail.com>,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>,
 Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Orlando Chamberlain <orlandoch.dev@gmail.com>, kekrby@gmail.com,
 admin@kodeit.net, Janne Grunau <j@jannau.net>,
 Aditya Garg <gargaditya08@live.com>, asahi@lists.linux.dev,
 linux-kernel@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
X-Mailer: iPhone Mail (21B101)

=EF=BB=BFSending this again because Apple mail decided to default to HTML
mails since the last update apparently *sigh*



=EF=BB=BFHi,


> On Dec 27, 2023, at 11:30, Johan Hovold <johan@kernel.org> wrote:
>=20
> On Mon, Dec 25, 2023 at 09:26:05PM +0100, Paul Menzel wrote:
>=20
>> Thank you very much for the patch. I am adding Johan to Cc field.
>=20
> Thanks for the report. Guess I could use a break from the proverbial
> eggnog.
>=20
>> Am 25.12.23 um 21:01 schrieb Felix Zhang:
>>> Starting v6.5, Bluetooth does not work at all on my T2 MacBookAir9,1
>>> with the BCM4377 chip.  When I boot up the computer, go into
>> Somehow a blank line snug in above.
>>> bluetoothctl, and then try to run commands like scan on, show, list,
>>> it returns "No default controller available."  I have tried reloading
>>> the
>> It=E2=80=99d be great if you reflowed for 75 characters per line (also be=
low).
>>> kernel module, in which the log outputs "{Added,Removed} hci0
>>> (unconfigured)."  With this patch, I am able to use Bluetooth as
>>> normal
>>> without any errors regarding hci0 being unconfigured.  However, an
>>> issue is still present where sometimes hci_bcm4377 will have to be
>>> reloaded in order to get bluetooth to work.  I believe this was still
>>> present before the previously mentioned commit.
>>> Due to the bit HCI_QUIRK_USE_BDADDR_PROPERTY being always set in
>>> drivers/bluetooth/hci_bcm4377.c (line 2371), the chip would be left
>>> unconfigured on kernels compiled after commit 6945795bc81a
>>> ("Bluetooth:
>>> fix use-bdaddr-property quirk") due to a change in its logic.  On the
>>> M1 Macs, the device would be configured in the devicetree.  However,
>>> that is not the case on T2 Macs.  Because the bluetooth adapter is
>>> left
>>> unconfigured, it is not usable in the operating system.  In order to
>>> circumvent this issue, a flag is added to prevent the bit from being
>>> set on the BCM4377, while setting it on the other devices.
>=20
> The commit you tracked this down to restored the original semantics for
> HCI_QUIRK_USE_BDADDR_PROPERTY, which means that it should only be set
> for devices with an invalid address.
>=20
> The Broadcom BCM4377 driver has so far been setting this flag
> unconditionally which now potentially results in also valid addresses
> being marked as invalid.
>=20
> I've just sent a patch that makes sure to only mark invalid addresses as
> invalid:
>=20
> https://lore.kernel.org/lkml/20231227101003.10534-1-johan+linaro@kernel.or=
g/
>=20
> Note however that the flag still needs to be set in case your device
> lacks storage for a unique device address so you cannot simply drop it
> for some device classes as you do below (unless you are certain that
> these devices will always have a valid address).


We do know that though.

BCM4377 is present on Apple=E2=80=99s x86 Macs and always has internal stora=
ge
for the address. If the board comes up without an address there=E2=80=99s no=
thing
much we can do because the address isn=E2=80=99t provided by ACPI or anythin=
g
else and setting the invalid address quirk for that situation seems appropri=
ate.

BCM4378/4387 is present on Apple=E2=80=99s ARM Macs and never has internal s=
torage.
The address is always provided by our bootloader in the device tree.
These should always unconditionally set HCI_QUIRK_USE_BDADDR_PROPERTY
just like this patch does.


Best,


Sven=


