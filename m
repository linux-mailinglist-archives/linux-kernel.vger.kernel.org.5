Return-Path: <linux-kernel+bounces-8427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA0981B700
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 14:08:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D0E21F233B9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 13:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F9673184;
	Thu, 21 Dec 2023 13:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.org header.i=@fastmail.org header.b="WxgBRCLP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OTeaUDby"
X-Original-To: linux-kernel@vger.kernel.org
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2A36979B
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 13:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.org
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 269933200AD1;
	Thu, 21 Dec 2023 08:08:39 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 21 Dec 2023 08:08:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1703164118; x=1703250518; bh=TSmi62AbKk
	Ag1rP/36saQuYN5nGRz1D7HRB5YJAMmKw=; b=WxgBRCLP2yF/PaujaW7gO9nASx
	MgiYNQpg+wbtYwfCR2KjKEbtt1TN46Sc5jP15PoK/2CtlI+D2w5GsHCCvsEE/G77
	rcdsX5fbleY9THXENezD8mS8GNdQSdGP20g7/HGRwKcHo+FPqHziY5R4fH91M2qx
	LN7KdGnD+1Tys0BdyrRUwlwVmV3aa0aN5OJDUSoObmuhBo+EuorsleZE/Q8lyMK/
	xIlkGIA35QSqfJjE4jye2NiaO/1wV6mQG5yBTQT0/Nv1mSHFrq4RcVylTfXU1Aw1
	+qGi7s8XWprWoL3niptY9WLY2ACWZZJkaiVegqW5azIEoenmjqKLI7KZHAfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1703164118; x=1703250518; bh=TSmi62AbKkAg1rP/36saQuYN5nGR
	z1D7HRB5YJAMmKw=; b=OTeaUDbySbg+p8N8/zE7JtImq+9CUznDsOVkcl2iFTAU
	X9+qHdnlLSsWnXlunYr7+lOIWlAEWAckWqg7CpUHLk6KEZahYVtTBCfOswJ/PkWk
	aOtJkhomD5kgaywYfaRZevTQCkTCjqGuYvF0BONuRvFXcHlC0FjCv5H0uBuTBcf4
	yCiKeBcNQS+mmHKkD76qsvHKBRNFwqIbjWh2NlQUkLDE1Dnh53CIrMhYFOTA+Ang
	rIDWJjWy8nS+CKMOfMZRyfPY+ZGLC3O7OU+28LENKaIWZAEKOJKzL5Zoz+/2+RY1
	tgbR1o5CI9cRZKv6xpLfgVbrbBpgqzUryOKYhlr6iQ==
X-ME-Sender: <xms:1jiEZdh-7mpORy7jfLfyHd3at1yWP2mm0RfD3oNw9evc0IqgwG3rzg>
    <xme:1jiEZSAumFQjFfTULk2VVVS8YO_4hKTiMXJm88YgeyhHmDzX_0K5Q7B4oKGmNB1Va
    WHAf53KIc9BHFA-628>
X-ME-Received: <xmr:1jiEZdG7HPuATFHaR_wZEvVSssgtYp3IX13HfQfL4Nu1wJ5plXvjuNlx3szf469orS6Ejvo6Pkz5eIA7GsD09SMXhf4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdduhedgvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfhgfhffvvefuffgjkfggtgesghdtreertdertdenucfhrhhomhepifgrrhih
    ucftohhokhgrrhguuceoghgrrhihrhhoohhkrghrugesfhgrshhtmhgrihhlrdhorhhgqe
    enucggtffrrghtthgvrhhnpeeileehheehtdeiveduffdugfdtgfevjeffudfgtefgteff
    udfhhffftedvieeggeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehgrghrhihrohhokhgrrhgusehfrghsthhmrghilhdrohhrgh
X-ME-Proxy: <xmx:1jiEZSQqiWOVHzESqO-D7VuBpzKfVepTTyvHAZV2KCDIh5qPCiOPeQ>
    <xmx:1jiEZawNt-pDPluggYu-8eE7OLhqrtxXCzonQV3dhrSyDlEjgc2bzg>
    <xmx:1jiEZY72r6m2YG-_-R81edJpH3KkZoNS9BaqXInrinwaup7POiS4jQ>
    <xmx:1jiEZV-kvX1-hn90rqqDYCmvJWTtPL8vvQWsfn_kXrrP2HLXygJtWg>
Feedback-ID: ifd194980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Dec 2023 08:08:38 -0500 (EST)
References: <20231221031004.14779-1-garyrookard@fastmail.org>
 <2023122137-account-vitality-9a72@gregkh>
User-agent: mu4e 1.10.8; emacs 29.1
From: Gary Rookard <garyrookard@fastmail.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: philipp.g.hortmann@gmail.com, linux-staging@list.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] staging: rtl8192e: rename variable
 HTInitializeBssDesc and (4) other
Date: Thu, 21 Dec 2023 08:06:13 -0500
In-reply-to: <2023122137-account-vitality-9a72@gregkh>
Message-ID: <875y0rog7j.fsf@fastmail.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Greg KH <gregkh@linuxfoundation.org> writes:

> On Wed, Dec 20, 2023 at 10:09:59PM -0500, Gary Rookard wrote:
>> Hi,
>>=20
>> This patch series renames (5) different variables with
>> the checkpatch coding style issue, Avoid CamelCase.
>>=20
>> Patch 1/5) rename variable HTInitializeBssDesc
>> Patch 2/5) rename variable HTResetSelfAndSavePeerSetting
>> Patch 3/5) rename variable HTCCheck
>> Patch 4/5) rename variable HTSetConnectBwModeCallback
>> Patch 5/5) rename variable ePeerHTSpecVer
>>=20
>> Signed-off-by: Gary Rookard <garyrookard@fastmail.org>
>>=20
>> Gary Rookard (5):
>>   staging: rtl8192e: rename variable HTInitializeBssDesc
>>   staging: rtl8192e: rename variable HTResetSelfAndSavePeerSetting
>>   staging: rtl8192e: rename variable HTCCheck
>>   staging: rtl8192e: rename variable HTSetConnectBwModeCallback
>>   staging: rtl8192e: rename variable ePeerHTSpecVer
>>=20
>>  drivers/staging/rtl8192e/rtl819x_HT.h     |  2 +-
>>  drivers/staging/rtl8192e/rtl819x_HTProc.c | 16 ++++++++--------
>>  drivers/staging/rtl8192e/rtllib.h         |  6 +++---
>>  drivers/staging/rtl8192e/rtllib_rx.c      |  6 +++---
>>  drivers/staging/rtl8192e/rtllib_softmac.c |  6 +++---
>>  5 files changed, 18 insertions(+), 18 deletions(-)
>
> I see 2 different patch series here sent to the list, both seeming to do
> the same thing?
>
> confused,
>
> greg k-h

Sorry that was caused by an address typo
so it got resent to linux-staging..
new setup on different distro
Regards,
Gary
=2D-=20
Sent with my mu4e on Void Linux.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJNBAEBCAA3FiEE92Mpdr0+Cqw+uCNR5J46Hep3K4QFAmWEOPAZHGdhcnlyb29r
YXJkQGZhc3RtYWlsLm9yZwAKCRDknjod6ncrhHYHEACsbVqzfvvL0x6zZAmeHJev
EQBIDgGSghLpm8l+nw3SNetfY0Lxswgz0qS/XPYaKkwko0HSx8aRAwg/BCzG4jtA
+XzQbiV8se1FGawgeNitAc5/axT3gZkAXZHbCf9oU+rIO+sU/n9OlWb04OAeDjtN
I7xYPKufkGO0SquDmostYwPMPpI3EbK1jhADBkQuhDo2BKxXSQ+KSut/+hIGUgKW
koxXbUFTQSB1tMFlP3IzTUKv/HhiRB4F6M7uIXn0yab/IPxuikBcnRqi5/wWAzwz
dhFfwZp6JNTUqahyD4qxF6Galxxo6dASBhsLV2XIyTMT+DsqgsGtrfkFDhnqa3Bi
SSSJjp21uYhmUkKHfFecu65uS3KWLFtQi73li4OXFtABjoWlwjriWzTIOB9adPmk
b3xxtcva+vj7/SZleFXqHjm6XrsFJmnRJhOoVDG/qCtYpXqdOZ0cHv7/JfLHTcX5
BVgG20r4lWsMETO1b2Hz3Ur6LMK5zuE6k7NhjG13Sd8u5APgmsrNHdCyJkAe+YMf
fz9baKuanOIh9TChfoBzbysk7HYOXVSH1qDEFPpszf2qsQZtw3HkbJldeCGDglLJ
9zczLWR+68TvlKgPoMMcLXABvhSsTysE1mU7Y0Ry2ZgKm+YRFYtlrKnYmYyrTCCM
dr9HoNjD2KaTDEknGBVrrQ==
=eI5L
-----END PGP SIGNATURE-----
--=-=-=--

