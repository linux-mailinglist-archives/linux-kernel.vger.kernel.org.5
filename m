Return-Path: <linux-kernel+bounces-131887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53AEE898D2F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 19:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 847831C26EC1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D6CA12EBDB;
	Thu,  4 Apr 2024 17:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b="K6Sf7z4N"
Received: from mr85p00im-ztdg06021701.me.com (mr85p00im-ztdg06021701.me.com [17.58.23.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440E412AAC5
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 17:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712251709; cv=none; b=TyYlTSjxHIZbpJ0RJOxrzuu2QKEjiYUvkSMxDFp5rqwo/LhdXo57p8xOyLvtxJnrOjxQNnwF6BQL48Q3jp/iXlCuQezexXzbeBMvv3qkNbQemAsraJ1ZcN/Q1M0LpdQeX1kBc6Kce6+VsO9p32S0QdiZ8vt8yfnUcXjFADXsPVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712251709; c=relaxed/simple;
	bh=Hgw8YDYeXIbAur1VdjrAw21TWVkSGL7n1rv1sgu7sus=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=MWbiEj7OWtUmYHCp0YutX/nbABp97MruIP8mqzSomfCn5kLNogdBXWbkPxdWfHdjA3HXBsh+QU65YiOCgpE3P4np336WvGB6QSm39xjOSQFeFDnIWzkkdk0ind9Td99WvPaijUYL3y735WN+Sx9yaroafB/qSAdaCz7pDDXuPH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=me.com; spf=pass smtp.mailfrom=me.com; dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b=K6Sf7z4N; arc=none smtp.client-ip=17.58.23.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=me.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=me.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
	t=1712251707; bh=nlxGTSwQ7v0Ep4e8zvJarUYi6YExHbW8T1sRZDS375Y=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:To;
	b=K6Sf7z4Nr7QiFWmn+X1PDtxtBEWa0hwwkPt1fXSxwjleugocm4HwQj6J39jdtw4kt
	 +6J82DQC0rKm3+0MWgjkrOPG/IGamEFWwmXg3rRkbd9J8ibjnsv7qjvJ4cppeCokl9
	 VUUi+SVBPCxHKScwnJFkLrAOGD88tSUni5bcSFcYGsnJ1PH+nf7uuOJ8SEThYDvquV
	 Tq4uy1NnwS/Kr6ByUZDso4z2UCwjvDzPLIquUSDH2Egnl6VvlLOxq0PVBHtfAqk6HF
	 fI45hf1pbozauPBNJ4ZceFl24ng+QVxmxdfZmpWuh6138lEon0q19k45PhuWr+u7sx
	 HQ3xZniwS7q4g==
Received: from smtpclient.apple (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-ztdg06021701.me.com (Postfix) with ESMTPSA id C1C892633A4B;
	Thu,  4 Apr 2024 17:28:26 +0000 (UTC)
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
Date: Thu, 4 Apr 2024 10:28:13 -0700
Message-Id: <A68286F0-AB83-4D64-99E3-EE47F03D1AAE@me.com>
References: <CANiq72nyqxH2C1gr=UUCOftaKe0zSuuB++mMUD9zXo-pPBVMVg@mail.gmail.com>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, rust-for-linux@vger.kernel.org,
 Wedson Almeida Filho <wedsonaf@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Andreas Hindborg <a.hindborg@samsung.com>,
 Alice Ryhl <aliceryhl@google.com>,
 Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
 lkml <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
In-Reply-To: <CANiq72nyqxH2C1gr=UUCOftaKe0zSuuB++mMUD9zXo-pPBVMVg@mail.gmail.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 Benno Lossin <benno.lossin@proton.me>
X-Mailer: iPhone Mail (21F5048f)
X-Proofpoint-GUID: xqsL6JBfzVb3C1dazRHJ2W53D_pWPobU
X-Proofpoint-ORIG-GUID: xqsL6JBfzVb3C1dazRHJ2W53D_pWPobU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-04_13,2024-04-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 mlxlogscore=980 clxscore=1011 adultscore=0 mlxscore=0 spamscore=0
 suspectscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2308100000 definitions=main-2404040123

On Apr 4, 2024, at 4:03=E2=80=AFAM, Miguel Ojeda <miguel.ojeda.sandonis@gmai=
l.com> wrote:
>=20
> =EF=BB=BFOn Thu, Apr 4, 2024 at 11:01=E2=80=AFAM Benno Lossin <benno.lossi=
n@proton.me> wrote:
>>=20
>> I don't see this commit in the kernel tree, what did you specify as
>> `--base` when running `git format`?
>=20
> Yeah, I don't have it either, but it seems to apply cleanly.
>=20
> Cheers,
> Miguel

I ran `git format-patch origin/master --base=3Dorigin/master`.  I
can=E2=80=99t imagine how that could have resulted in a nonexistent commit
hash?

Thanks,
Laine=

