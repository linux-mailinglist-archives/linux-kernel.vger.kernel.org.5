Return-Path: <linux-kernel+bounces-19620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4A9826FCD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 14:30:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 846041C216B6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 13:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB8245961;
	Mon,  8 Jan 2024 13:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.org header.i=@fastmail.org header.b="gEQdJ9pZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="2sji/5Ex"
X-Original-To: linux-kernel@vger.kernel.org
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DD445967
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 13:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.org
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id 3C9F5320122C;
	Mon,  8 Jan 2024 08:28:51 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 08 Jan 2024 08:28:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1704720530; x=1704806930; bh=rnhdSabR+a
	ACnx5x4HzpeUQsfXndD3oedpvNLHLzFco=; b=gEQdJ9pZI1QIQneu57Tvy9IYKe
	6A62M/taUwmlYqjdY4uWkI4ET3Wvi4EnXPw9Ib6Y2VTsCmTMRBb+cWi0ozr0/3Jc
	zHSPDpnNee9e1BhPtULapo4n3bmTNP4Ghb8j2CRStH0Kb7mlCz/9AmQpIaF8hqKb
	IksWiQeEpQREdkZHTq8Pyb3XpziYG6g5+Z35JAHTqf7URbsjvwxQukH5hEfhwivm
	72LuawVW6dt3NbctZAkTIlukI5nOZqOgthSTh4ukpQxxS1eyXDbXfUXtlbmdcs8o
	9cXG/zTePHakR54pOORsTXAYO09ihbcoTZE+43cOIbjl0O7NTpCKsFvtQWNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704720530; x=1704806930; bh=rnhdSabR+aACnx5x4HzpeUQsfXnd
	D3oedpvNLHLzFco=; b=2sji/5ExCgmvn+vbS41IZvDvdB6BrhnPx/3gdwvE3mly
	A+Bd5sx3aFPb1CqKRoKBrRmQ7zA24G5OySuIB3YgxlCk7XIWNtNHHnioP8JSVxgb
	f+eLkkoxG5xuXXeDJXSZsY8UZCOryRN8l+bOR9E1/ODWymOT9KgMFhiRwJ/zNxH1
	3DtCamaVU/eo6mUoCkiDGYy+Pd51+HMkBxSSdvMDGzq2+7EH0VBoo+P10sBo5D1T
	JRJhuTJ5DdH+CvnHi+s0xS9jKayacauLMeOQXJOgEuiZhcH1OatEeUN4GJKYLgDN
	s5m17l7cxQg9eq7d3EwostIJaw1ZuH8kj+f87H5V2A==
X-ME-Sender: <xms:kvibZcjNVDpzKBYNLzRmoqpNpfCD1UrzbAjHeBKySF1JwTX9HkEFlg>
    <xme:kvibZVBqU3OVph9b8idfypUjfAtahV6pl2ZX0Ldm9LkbeHfZm6YRhoI4_RPCIAIoE
    QNC9H3cpyLfcXTxD6c>
X-ME-Received: <xmr:kvibZUF8KGXyYYVQSSG7GhSDVvO_8AJsqULJmJzlhAP52bYlEFMwaO6gi8GDJSo6_b7Xfz6A0vAq2Tem5xEYmH0nK34>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdehjedgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfhgfhffvvefuffgjkfggtgesghdtreertdertdenucfhrhhomhepifgrrhih
    ucftohhokhgrrhguuceoghgrrhihrhhoohhkrghrugesfhgrshhtmhgrihhlrdhorhhgqe
    enucggtffrrghtthgvrhhnpeeileehheehtdeiveduffdugfdtgfevjeffudfgtefgteff
    udfhhffftedvieeggeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehgrghrhihrohhokhgrrhgusehfrghsthhmrghilhdrohhrgh
X-ME-Proxy: <xmx:kvibZdS5rqANLHPS3DaHJaIC2wY__Tkmk9Ghcx3E7IHE0BpvkBtFgA>
    <xmx:kvibZZxbDcnl-6i7UzRClzasIpc3sU-D3HZeznZPkwdYS7AJFWl3WQ>
    <xmx:kvibZb7FtNf2xinMLA5bQejkxtbaD9swWSboKCoUEOXP8epWbE1h_g>
    <xmx:kvibZR_lPJGoDAyA_q9dNy4vzQa4YIN1wC_Y2fQhTzVxq1vrCmOMxg>
Feedback-ID: ifd194980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Jan 2024 08:28:50 -0500 (EST)
References: <20240108032233.4280-1-garyrookard@fastmail.org>
 <20240108032233.4280-2-garyrookard@fastmail.org>
 <897a8bb4-a1d7-46ab-96cf-fd5ba447d2d8@moroto.mountain>
User-agent: mu4e 1.10.8; emacs 29.1
From: Gary Rookard <garyrookard@fastmail.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] staging: rtl8192e: rename variable is40MHz
Date: Mon, 08 Jan 2024 08:22:59 -0500
In-reply-to: <897a8bb4-a1d7-46ab-96cf-fd5ba447d2d8@moroto.mountain>
Message-ID: <87edesvtrx.fsf@fastmail.org>
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


Dan Carpenter <dan.carpenter@linaro.org> writes:

> On Sun, Jan 07, 2024 at 10:22:29PM -0500, Gary Rookard wrote:
>> Coding style issue, checkpatch avoid CamelCase,
>> rename it. is40MHz -> is_40mhz
>>=20
>> Signed-off-by: Gary Rookard <garyrookard@fastmail.org>
>> ---
>>  drivers/staging/rtl8192e/rtl819x_HTProc.c | 16 ++++++++--------
>>  1 file changed, 8 insertions(+), 8 deletions(-)
>>=20
>> diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging=
/rtl8192e/rtl819x_HTProc.c
>> index 6d0912f90198..1b1cb9514028 100644
>> --- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
>> +++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
>> @@ -87,36 +87,36 @@ static u16 ht_mcs_to_data_rate(struct rtllib_device =
*ieee, u8 mcs_rate)
>>  {
>>  	struct rt_hi_throughput *ht_info =3D ieee->ht_info;
>>=20=20
>> -	u8	is40MHz =3D (ht_info->cur_bw_40mhz) ? 1 : 0;
>> +	u8	is_40mhz =3D (ht_info->cur_bw_40mhz) ? 1 : 0;
>
> This should be is_40MHz.  It's metric.  M means Mega.  m means milli.
>
> regards,
> dan carpenter
=2D-
Okay, stupid me didin't give it to much thought that way,
...wow there's more that way then just mine
Good catch!
Regards,
Gary

=2D-=20
Sent with my mu4e on Void GNU/Linux.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJNBAEBCAA3FiEE1kC7bOvmQRqDVDSVKPZpkA66T0EFAmWb+IIZHGdhcnlyb29r
YXJkQGZhc3RtYWlsLm9yZwAKCRAo9mmQDrpPQfB2D/wMrp1lzEC55gNvoPeTt0SU
APGp93g3eBBubhjei5ZjQ9k6qEQ5NvGdp8GruqR09AOjEADDnicItzDUVcx6G7IQ
r4dMqJe8OzFCv4vGv6TTfD/XxT3w9qj0fbDILJ7O7SAHb5xtKVXDLt0aPkIhk+iV
uPwoCWZ/pxTwOIGQTq4vAnhBEDw7TUYX/PZ+NOOUp6P2QfPaIvz7/woZA0vYSEnY
TsgGQoHE5PQzplSS7jXdJINoSiq7hIugpOixBo06Qw1M8QBN2haNsr+26CRgHyMI
4SG7nuLjbJ32MrA8Q22Vr6r2LLMzss+kkIPcVwRidWLm3dZCsRxqgLEMWfLLpMT+
TVmtKsM8I6e51mFFPJKNXm3BgQZmeCqfnpoN313wxJ+PyLthnc6mQO0+ZerlsLCx
RJOWDH+CQeJxm0DP9CPDbGAu8gQfl6TDMYRfU9bPNq85rYghg8aSCbuWXKyt4zSD
0i7xkW9GfSR5Iwi2IWxCYWWcB84GKtu10QLJb+o2NR6GhbNJMwPYU+ivjTCdBh2E
iLukcfv8GkK7Da/GMa1knyLh7i1R8Hls9QxsyHgGdxqJHPhDB9gDQLtC8/Cy73eH
GcOYY/CQxQscMxqxYLAOG0U3+Vj9I1t2W2UpVXu2xNA6YIMi8og+/Fq8vGhl4lhY
V89LSUKBcXEw4naf7/s9tA==
=rPq8
-----END PGP SIGNATURE-----
--=-=-=--

