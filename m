Return-Path: <linux-kernel+bounces-125786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC02892C10
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 17:37:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79E65B21432
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 16:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B596B2B9C5;
	Sat, 30 Mar 2024 16:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b="L4g/mTqi"
Received: from mr85p00im-hyfv06011401.me.com (mr85p00im-hyfv06011401.me.com [17.58.23.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4C32BB0D
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 16:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711816609; cv=none; b=BhXXKQQp7bNyAfrixiFgD2zGI6QSdwBeIug+LJEJ2kMCW9gF1Rm32n9B6qrF6xyJpuszjUGioUoJ/EtOHuCh3iHyiWri4cDIU7TmdjepHMhA6tUcg95ebAFl514kxUqDQZYo8FhbcCSN3jWqeGirRhw2WjiEjEKz2dydneLQ8wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711816609; c=relaxed/simple;
	bh=bhC28vlfwYiRi9JF5mh8TZiUGQSiMhN19F0vKCYegAk=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=rVLML+lJ4A+W0Gqa/16MVjypWOooamJvLcwtrRlMQTiVWx7i233pGEb/UOOh/Rlrv5prxwZjyFgNcuFhU1rfdElAWUvVEGe99Lee6nzhmQfgyZzdDtlBILkNa38HXxPselTQ9MgeAogenJYEQeKKSNJoMcFD/FuRPzocjBXqoN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=me.com; spf=pass smtp.mailfrom=me.com; dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b=L4g/mTqi; arc=none smtp.client-ip=17.58.23.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=me.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=me.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
	t=1711816607; bh=bhC28vlfwYiRi9JF5mh8TZiUGQSiMhN19F0vKCYegAk=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:To;
	b=L4g/mTqih39wKUGrnzA++XhcNO8Lyijae1pJNsVrLG0eH4tek+0tY38nl/HlHhuue
	 kKkYYfcBpgqVdt+8E08+XGyqA6I+1CKTEwB+XJErKfk9rio0Ajhy6FjYgqpgoOB8Td
	 Dzy74p4eQE6M2hyvw9Nn2she5cCI8Szfbqlph273gWqpxKqC9nITEDjYsn+YHGvyzy
	 Hm+B33PtRylYPkhUkENhhWpxzrmAp8aIWD0fDr/wgor4CnZ7hhnJtGD5CtZd40PFBQ
	 E1CpIZXAkElnQPG9b+0hnzaQBUNnBLUZNUvAnPDTRDmcbmu3XnF2+mqfQS66R9IdTd
	 XvYn75J6/wOmA==
Received: from smtpclient.apple (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-hyfv06011401.me.com (Postfix) with ESMTPSA id D33E7357AFFE;
	Sat, 30 Mar 2024 16:36:46 +0000 (UTC)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Laine Taffin Altman <alexanderaltman@me.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] rust: init: remove impl Zeroable for Infallible
Date: Sat, 30 Mar 2024 09:36:35 -0700
Message-Id: <AA29E05A-DCA7-4857-8473-C183C50EBE81@me.com>
References: <2dd2c052-0d1f-4a77-9fff-1d6db80310e1@proton.me>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Andreas Hindborg <a.hindborg@samsung.com>,
 Alice Ryhl <aliceryhl@google.com>,
 Martin Rodriguez Reboredo <yakoyoku@gmail.com>, stable@vger.kernel.org,
 rust-for-linux@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <2dd2c052-0d1f-4a77-9fff-1d6db80310e1@proton.me>
To: Benno Lossin <benno.lossin@proton.me>
X-Mailer: iPhone Mail (21E236)
X-Proofpoint-ORIG-GUID: Ew_WfHtjkljunJTafMuK8fYpGQW-NuoE
X-Proofpoint-GUID: Ew_WfHtjkljunJTafMuK8fYpGQW-NuoE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-30_11,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 mlxlogscore=678
 mlxscore=0 phishscore=0 spamscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2308100000 definitions=main-2403300136

I=E2=80=99ll do it myself tomorrow night; sorry for the delay!

Thanks,
Laine

On Mar 30, 2024, at 5:03=E2=80=AFAM, Benno Lossin <benno.lossin@proton.me> w=
rote:
>=20
> =EF=BB=BF
> <mime-attachment>
> <encrypted.asc>

