Return-Path: <linux-kernel+bounces-20261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC68A827C8B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 02:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4453E1F23654
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 01:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3C3186C;
	Tue,  9 Jan 2024 01:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.org header.i=@fastmail.org header.b="GQ97qUX2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="2r90DEEs"
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03AC15AA
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 01:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.org
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id 024825C0367;
	Mon,  8 Jan 2024 20:30:09 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 08 Jan 2024 20:30:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1704763808; x=1704850208; bh=BLkB46kVHq
	J8HkiTq+Qe0gAnj7qGYO+TVEMJATa8hc8=; b=GQ97qUX2ZTG3hZ6cRQcMUTxpss
	0VF2w3FaGXu7UZVB2Ugd35CgxtBZF2ScVkstaIdqCHnzirVJPfs2Cljvl/USR6qy
	veO0kEtXiYlWbFUGk6T3s6XQtnHbPbgKbJDecxlm8NdHuDFp7yBmmAYoiwIbn7SF
	vIhrMzsczd14XIeHqzeu/dACOnTnz6+mVGT5Ai47Bd1meTlYIpNuVPYbULZ4cMTo
	tJjvKIBSYrxULhNCalG73dFcHr3krCsB3db3gVIWAmUgdCBChmdTxWm2egSWtrZ8
	p/v4Eojx3/FRfx4kbgGRBsYJdbklA517we0ddD6Ke7bQAsYcsdzr+tegYJVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704763808; x=1704850208; bh=BLkB46kVHqJ8HkiTq+Qe0gAnj7qG
	YO+TVEMJATa8hc8=; b=2r90DEEs+w3XHj2lbqdXR8SYd5vSvBU98H0SrOOXLY93
	WmzY64vNoToUnpYXyDqYd7phqrU6et3TXaehDLEjz/nN42Qem0Kg5hH131tCxIrc
	W9Bq5XhnMazvzNdyNM8a5uTMfjRBeUXpXlI2SHU7++7yYq15mOlAm0bNHIIIoOpA
	tTrOCzfbw4W9TUxZFWSM4K1mXa0O94eR2u5cIT9oyKjjuBRM/kgxFx5KAiZvlF4D
	qRiHZNDLJq8/q0D86LSn2J+aAj2suuCYZdfDs0MhfOK5adVGOuQMSXnUbEf+YwWT
	kP7pPtcAgSv2LnYVFx2NlCguwjYnpj7U/8Bbh9IJNw==
X-ME-Sender: <xms:oKGcZY6pJ_WQcqLT7eQ9zVSvTQusO1gvUNftHJOsFa9n4IaRIR9riw>
    <xme:oKGcZZ7hFr8LRzebisiIe0yH4bPXa4M-3_msh4d50d8UJgSG5yakhaUken9UWspco
    jAB_ndxDNWHF-QEzUc>
X-ME-Received: <xmr:oKGcZXdceuSKZP8MgJxZ_jDPd2KM_IqhQDPc6kCEwNn3Ibu-ubC23DYwO6B2-xK_fhP1awWdkKke0xmyiYfpxAKIL98>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdehkedgfeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    goteeftdduqddtudculdduhedmnecujfgurhepfhgfhffvvefuffgjkfggtgesghdtreer
    tdertdenucfhrhhomhepifgrrhihucftohhokhgrrhguuceoghgrrhihrhhoohhkrghrug
    esfhgrshhtmhgrihhlrdhorhhgqeenucggtffrrghtthgvrhhnpeeileehheehtdeivedu
    ffdugfdtgfevjeffudfgtefgteffudfhhffftedvieeggeenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrghrhihrohhokhgrrhgusehfrghs
    thhmrghilhdrohhrgh
X-ME-Proxy: <xmx:oKGcZdK0w-uZMhTgAzBRZ1q33tmsg8PWyFDjsDnCNRfjbUuAmgzEcA>
    <xmx:oKGcZcJtpEA6-iLnS4Ks9dSPzYA7EbZHzLkVKC7wZDb56MEMNnRStQ>
    <xmx:oKGcZeyjXSwEOUwHUyEPSCg0l9ttRSCAE5R1h_v1pC6AvqalJHKq4w>
    <xmx:oKGcZRHSlkADeKDMOnUCGfuENajRX9nNF5qooJFzHZKmnfJtiGBugw>
Feedback-ID: ifd194980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Jan 2024 20:30:08 -0500 (EST)
References: <20240108032233.4280-1-garyrookard@fastmail.org>
 <20240108032233.4280-2-garyrookard@fastmail.org>
 <897a8bb4-a1d7-46ab-96cf-fd5ba447d2d8@moroto.mountain>
 <87edesvtrx.fsf@fastmail.org>
 <62836460ae502097ca8307bcee85a5ae3634e1acc74af843ffc466c28d1a0b95@mu.id>
User-agent: mu4e 1.10.8; emacs 29.1
From: Gary Rookard <garyrookard@fastmail.org>
To: Gary Rookard <garyrookard@fastmail.org>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, gregkh@linuxfoundation.org,
 philipp.g.hortmann@gmail.com, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] staging: rtl8192e: rename variable is40MHz
Date: Mon, 08 Jan 2024 20:25:55 -0500
In-reply-to: <62836460ae502097ca8307bcee85a5ae3634e1acc74af843ffc466c28d1a0b95@mu.id>
Message-ID: <871qarcmzt.fsf@fastmail.org>
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


Gary Rookard <garyrookard@fastmail.org> writes:

> Gary Rookard <garyrookard@fastmail.org> writes:
>
>> [[PGP Signed Part:Undecided]]
>>
>> Dan Carpenter <dan.carpenter@linaro.org> writes:
>>
>>> On Sun, Jan 07, 2024 at 10:22:29PM -0500, Gary Rookard wrote:
>>>> Coding style issue, checkpatch avoid CamelCase,
>>>> rename it. is40MHz -> is_40mhz
>>>>=20
>>>> Signed-off-by: Gary Rookard <garyrookard@fastmail.org>
>>>> ---
>>>>  drivers/staging/rtl8192e/rtl819x_HTProc.c | 16 ++++++++--------
>>>>  1 file changed, 8 insertions(+), 8 deletions(-)
>>>>=20
>>>> diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/stagi=
ng/rtl8192e/rtl819x_HTProc.c
>>>> index 6d0912f90198..1b1cb9514028 100644
>>>> --- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
>>>> +++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
>>>> @@ -87,36 +87,36 @@ static u16 ht_mcs_to_data_rate(struct rtllib_devic=
e *ieee, u8 mcs_rate)
>>>>  {
>>>>  	struct rt_hi_throughput *ht_info =3D ieee->ht_info;
>>>>=20=20
>>>> -	u8	is40MHz =3D (ht_info->cur_bw_40mhz) ? 1 : 0;
>>>> +	u8	is_40mhz =3D (ht_info->cur_bw_40mhz) ? 1 : 0;
>>>
>>> This should be is_40MHz.  It's metric.  M means Mega.  m means milli.
>>>
>>> regards,
>>> dan carpenter
>> --
>> Okay, stupid me didin't give it to much thought that way,
>> ...wow there's more that way then just mine
>> Good catch!
>> Regards,
>> Gary
=2D-
There's only mine that I can find, I'll fix them up
and resubmit them.

Thanks for your insight.

Regards,
Gary
=2D-=20
Sent with my mu4e on Void GNU/Linux.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJNBAEBCAA3FiEE1kC7bOvmQRqDVDSVKPZpkA66T0EFAmWcoZYZHGdhcnlyb29r
YXJkQGZhc3RtYWlsLm9yZwAKCRAo9mmQDrpPQc37D/0Ubc8io4K+JZLcQR6KDY93
ldeMGQWrWCpffSZxHG2DJJkhO8LOI6ZcWcjeq1B9r8RRRiXwDXYbSXH7Hm9DQCTG
nC3qaJ2gRpk2MA897WdmVrfLGGYtFJB7Z+GkX+JOZGE1y4g/syL54buXq/UQc0GX
e7g7+TG/e2x094BWc54axLJC4xq0PvKYZZCw+yXkInP4f2Nvw5Xz5+3s4qwoOiBd
DB1sx1lHA0ZMNvNuSgF+T7mAeAwHSRBHVFQHUJUGFIvhUIvUH+0YDtNtV9K9vknr
Z6TKvqwSFRx217xjG1ddi7/099rIdXVtbppOaquVU36lvwbyTAsnl/+MlMnBHiLI
TggvSTDXvRKQMX1NP1S5K7MOe09YsCsyunlcRm1HtZGCc3NVvjgR1XT9ysNg0tv2
4rfzQC1XIcrhW+Fnd6p5rZKPXKFR6xdBMr4XuAg+uyJzP0rByh8r03+Vz4jbXpVx
I0D9U6VRpdY2WCjA1lHVGjeyxDFXF3qOCLh72gLHW+cU9MxYFBBoFTJ9EFUawxW2
L6fQMwixnMP+Cv7iyqKWCgGLmDzRs1f3r6cDiGqDJrVezCfDGX6YDbf88ia/3q0A
jJSQqiOoL43Uo1qgyaoRzq5Us3vGcHhGNjR9Jfx9gdL85vfGd4EKBGrPPVpIh1OH
MDbq7ZH1g2r1v9TfXuKRvg==
=4+ac
-----END PGP SIGNATURE-----
--=-=-=--

