Return-Path: <linux-kernel+bounces-134603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD42C89B374
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 19:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C244B20C15
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 17:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD553C064;
	Sun,  7 Apr 2024 17:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b="1hcwIUJ0"
Received: from ms11p00im-qufo17282001.me.com (ms11p00im-qufo17282001.me.com [17.58.38.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813B13BBE2
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 17:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.38.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712512565; cv=none; b=nEaSx647fZW3n9m2zj2ZASUOR+wFbxydvE9se+frIgcJvL2kgv/cRnuoOkP2K+0sRaGseFCbskd6wMFoQ8ssei63YmxDOG6OQc3Bng0iOGRaHkahhhiasMqS0qB7tfvP7PRZit2bxzdC4dTZZrEItfl9TpRtCNxZ7ppLP5DHR5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712512565; c=relaxed/simple;
	bh=UQxU8jMJyYiRRgiZP1/TGp9KcB4J3dMChQI1iPB7laM=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=bno3jiUFAfJfKEF54nDLbux5o4rE0zkeXYiY8yXLR6uQXNb/KtERiA41x5DGWHe00YQ0P1HqbI7n7yfYaVBeoxDPjd8fvUb1mlJZG0hNgKikYGEL2dGpKB/2wN3Weeyt6BsVfpUY2VzgFj2lfXi7sp0AYKSMoF0hCKrd+iz0We4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=me.com; spf=pass smtp.mailfrom=me.com; dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b=1hcwIUJ0; arc=none smtp.client-ip=17.58.38.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=me.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=me.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
	t=1712512561; bh=1L55z9HgcsBeCtGk8EKGjwew88mtrI15AkRnFNg6k6k=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:To;
	b=1hcwIUJ0Ru5XygPZsAYM7oeJlg35Jghl99W8h6j/2q3fuhXklLry9m0n1G4b0D/TA
	 pMGCOjk/5x8yz41Brzvo48/+ShiUuNkyoq/276HvwmzVBZ+bFAXMKDK/m4YOUF0ROd
	 V3UUUY+mTv2HSzX6zwnOhHQ/2xO4zzQyXEBJFOJoWxIUepG4bW2xXPP4vP17FtbvUj
	 GAiUY3nOB36u3hmZFsmuGH+wIvH2m93ADS1R2ZdiQY5k9GErMG6hmysXAOjPn7sd//
	 uKsZa5nfjj0LU9b0fhzmKtQex95Xp1eEKlHDyVTL0n4Y7i3z0dBFT0EPhPz7jxBns9
	 LIy3YAAUeRyzQ==
Received: from smtpclient.apple (ms11p00im-dlb-asmtpmailmevip.me.com [17.57.154.19])
	by ms11p00im-qufo17282001.me.com (Postfix) with ESMTPSA id 203561E0230;
	Sun,  7 Apr 2024 17:56:01 +0000 (UTC)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Laine Taffin Altman <alexanderaltman@me.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v4] rust: init: remove impl Zeroable for Infallible
Date: Sun, 7 Apr 2024 10:55:49 -0700
Message-Id: <37A7EC35-7889-4378-A30C-126B1AD668C8@me.com>
References: <3ecba34f-95a2-4f18-9729-f9cb3a4366c0@proton.me>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 Alex Gaynor <alex.gaynor@gmail.com>, rust-for-linux@vger.kernel.org,
 Wedson Almeida Filho <wedsonaf@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Andreas Hindborg <a.hindborg@samsung.com>,
 Alice Ryhl <aliceryhl@google.com>,
 Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
 lkml <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
In-Reply-To: <3ecba34f-95a2-4f18-9729-f9cb3a4366c0@proton.me>
To: Benno Lossin <benno.lossin@proton.me>
X-Mailer: iPhone Mail (21F5048f)
X-Proofpoint-ORIG-GUID: Iezh0l9YPBfilfTXNVUoheAnYZ2BgIsK
X-Proofpoint-GUID: Iezh0l9YPBfilfTXNVUoheAnYZ2BgIsK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-07_11,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 clxscore=1015
 mlxlogscore=821 bulkscore=0 adultscore=0 mlxscore=0 spamscore=0
 phishscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2308100000 definitions=main-2404070145

On Apr 7, 2024, at 1:56=E2=80=AFAM, Benno Lossin <benno.lossin@proton.me> wr=
ote:
> =EF=BB=BFOn 04.04.24 19:28, Laine Taffin Altman wrote:
>>> On Apr 4, 2024, at 4:03=E2=80=AFAM, Miguel Ojeda <miguel.ojeda.sandonis@=
gmail.com> wrote:
>>>=20
>>> =EF=BB=BFOn Thu, Apr 4, 2024 at 11:01=E2=80=AFAM Benno Lossin <benno.los=
sin@proton.me> wrote:
>>>>=20
>>>> I don't see this commit in the kernel tree, what did you specify as
>>>> `--base` when running `git format`?
>>>=20
>>> Yeah, I don't have it either, but it seems to apply cleanly.
>>>=20
>>> Cheers,
>>> Miguel
>>=20
>> I ran `git format-patch origin/master --base=3Dorigin/master`.  I
>> can=E2=80=99t imagine how that could have resulted in a nonexistent commi=
t
>> hash?
>=20
> That heavily depends on what `origin/master` is. Is `origin` pointing to
> Torvald's git? In that case it would explain why we don't have that
> commit hash yet.
> Normally you should base your work on the tree listed in the `T:` entry
> of the subsystem in the MAINTAINERS file. In our case it is `rust-next`.
> But no worries, since it applies cleanly it should be fine for this
> patch. Just something to keep in mind if you submit any future patches.
>=20
> --
> Cheers,
> Benno

Ah, that makes sense!  Indeed it was pointing there.  I=E2=80=99ll remember f=
or next time!

Thanks,
Laine=

