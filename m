Return-Path: <linux-kernel+bounces-10569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E8481D654
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 20:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B6311C20EDA
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 19:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A84815482;
	Sat, 23 Dec 2023 19:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.org header.i=@fastmail.org header.b="V2mng07B";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="6mCcRbxX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74CC14A9C
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 19:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.org
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id C271E3200A27;
	Sat, 23 Dec 2023 14:37:34 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Sat, 23 Dec 2023 14:37:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1703360254; x=1703446654; bh=uHlIw7kyLa
	DAsRv1pMPPRSxaAnHaWfVJFKJmyski9UU=; b=V2mng07BQH/wNcyWuYiux2ME+J
	JhSUJABVWTpSJ7ISYpaFLCra7LN9MpGn2PGWMplaCIM1qXtLJkMGJTrWKK9iNm/k
	dV00+SWnZOe+6u5qt8JvQfjiYXnI/qYIReFv5W+Qi/6SNMunCyxzGo93zbaBBE37
	cEuyiNK27ryL5xDi4HorrU6G6iGZUxHFGOdCvbkiG6pysjkJKY5gkrYzov1OPZB7
	6kyzuL5DRqD5jCZiMRQOz6RKhBPOo8nPMftG/RV2lbj+wtGEJOW6V+/NOC+rJiBM
	T88I9Ewlh+bx8r0ukia0R/KGNTEbpgQD/eg3UU/2h0D6yLNTw6hMXfZDgfyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1703360254; x=1703446654; bh=uHlIw7kyLaDAsRv1pMPPRSxaAnHa
	WfVJFKJmyski9UU=; b=6mCcRbxXjsJ8N8PZUaDtXvA5rebBz4GnTM4/OUd3pFMB
	bxGqIkKtsEgY+UBJDvukfs+v499HbpLb7LupKxy44FudK3KXFoG7tmz/K5P9E5IQ
	XTAdPw0XDc+s+TQpfB7imHD8jOOHheJW+RThXImwvGpLrvd1PbuWPC9m+/4IFPhu
	3kYOXTMJ06PksPbkhlcq1HDWuJsasw9uesAMWwaaE5yE8ybmz+e8XLZSTBj6+SFf
	08IOzEYQ+QdU3DqNJ+9FZCkqybdfThmQ3zm+55VMksnjKhHpSZdQfHIrGQfb5t/J
	eunPed33yZUs6eVRv+YpZQaMqbd7cnWs+zzbumXKSg==
X-ME-Sender: <xms:_TaHZaHTzW29JRhiB4IoXC3QvAxhQmo_5mXUcBYUlDFaMIw-ft6KGQ>
    <xme:_TaHZbXdJ6uFYN-r_ms_bMdvXov-zQvIQKzggXNIgnksw_GHuGvZsqmlpPm_e1UqS
    aXpMG39Jdyok2HEEXo>
X-ME-Received: <xmr:_TaHZUJcZgEq4yNEgWeHpAbyjTOUBdXlarwSID5OPxhb2CY-YMzV8PMOnP-ixENUcSyEEm3U7Hy4pTA3TvnMhZAwyZk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdduledguddvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpehffgfhvfevufffjgfkgggtsehgtderredtredtnecuhfhrohhmpefirghr
    hicutfhoohhkrghrugcuoehgrghrhihrohhokhgrrhgusehfrghsthhmrghilhdrohhrgh
    eqnecuggftrfgrthhtvghrnhepieelheehhedtieevudffudfgtdfgveejffdugfetgfet
    ffduhffhffetvdeigeegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepghgrrhihrhhoohhkrghrugesfhgrshhtmhgrihhlrdhorhhg
X-ME-Proxy: <xmx:_TaHZUEANB1WdIiET7IHMXl7yEDGEmQYXyyAUdJWs9czt06SygCoPQ>
    <xmx:_TaHZQVGjv2XK8pWqpw9h89GzLu8zCJkN-MQ64koe9UNIPDl1sV0Ug>
    <xmx:_TaHZXPq_iuICaBA0aRzroQ8ZPzFJH0ex5TZk9AgZSKOand46rLtLg>
    <xmx:_jaHZdguWANxWKjDg5GNLPWpmKuJizO9lnZoBtRN8TCWFH3EsH9TLw>
Feedback-ID: ifd194980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 23 Dec 2023 14:37:33 -0500 (EST)
References: <20231216125303.3404-1-garyrookard@fastmail.org>
 <2023122348-angular-shopper-0b92@gregkh>
 <2023122316-alike-trimmer-b5db@gregkh>
User-agent: mu4e 1.10.8; emacs 29.1
From: Gary Rookard <garyrookard@fastmail.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: philipp.g.hortmann@gmail.com, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] staging: rtl8192e: rename variable pHT
Date: Sat, 23 Dec 2023 14:36:57 -0500
In-reply-to: <2023122316-alike-trimmer-b5db@gregkh>
Message-ID: <87a5q07lre.fsf@fastmail.org>
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

> On Sat, Dec 23, 2023 at 02:07:10PM +0100, Greg KH wrote:
>> On Sat, Dec 16, 2023 at 07:52:59AM -0500, Gary Rookard wrote:
>> > Hi,
>> >=20
>> > This patch series renames (4) different variables with
>> > checkpatch coding style issue Avoid CamelCase.
>> >=20
>> > (resubmittals)
>>=20
>> Does not apply to my tree :(
>>=20
>> Please rebase against the correct branch?
>
> Oh wait, this is an old one...

=2D-
Okay

Regards,
Gary
=2D-=20
Sent with my mu4e on Void Linux.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJNBAEBCAA3FiEE92Mpdr0+Cqw+uCNR5J46Hep3K4QFAmWHNxUZHGdhcnlyb29r
YXJkQGZhc3RtYWlsLm9yZwAKCRDknjod6ncrhMbmD/9Bkz4+rnG/+l/tUVstk8KR
Mi3fouCFXe/yllVH+VNd4D29Jl1nJaQGqvZ3cf1Bvbk9MvU4hu+OEJgydjpTBwf/
0Itm7yN2+GMWpfxbVCOyPsiKxNJ4xuloK7iMJgzDzvd1uxfBCmkJBrL7gWmEH54N
RZn0g/OSRelUiJLNFxNI9IOLqLWcnngIQAaY+L9FxIg8bpAe40dh4sOjQ59bkdBe
/xNGyUSc2wOaF4P348Cetz8c3kzHrkqPkylma7nulAVELJiP2e72huoBFO8u5ivP
nlBBWRazsGgtmRGS9AKzsxYOpCU8mhsBYu5VQmET0dw+I56BA+qDnHb0FfWcvGeE
VTS9Be9cAQBxZTTG/8DlEQLqn2WdYTXn5jVxdtFiaNj6dttugseFD/0PYt7KGqG0
qHxGU0q3q3eztcyqxGcTIpyWLofaFiKVHmsZwb3Ua7c0iItKUXbpx1Ypc0coGfou
tEdQPFIctg1vd+nkqam75oiFGYlhZgwOPUvoyjJIka2NAQ8UnuyDPDlOoT+xKb1F
BTQgAnJb3ghj4Ffd/npIk47aaucD7+sUSGwsobo4a9hxQ9cxrjon+sxkGJZr9/pR
/ol0ZC8Hr9Td9nCmQlaONO7PbwyKWm5RnN1Ank03G2tkf0qi7f2Med/wHF+moGsM
VqwO7s/dA8aqLyVxSEwzvQ==
=pcMn
-----END PGP SIGNATURE-----
--=-=-=--

