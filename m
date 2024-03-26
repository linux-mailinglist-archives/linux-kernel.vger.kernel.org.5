Return-Path: <linux-kernel+bounces-119114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0835988C458
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:03:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 460142956D6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615B48624D;
	Tue, 26 Mar 2024 14:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="XixxKFIn"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACB8763E2
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 14:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711461718; cv=none; b=Pl3Pb/kgZ9fWJC4QxdvpPAuSvIQEQ08ZRpOgnSc1jmbQ58Ix4CStkZ3JE2iuPPQvxQlD+Lx+dkKlF/cK+y5+2djy1zCvSbg6q8SaWl2z3zhFHnMcX5dPlMojL2DhCkEtKIjaox7zz334Vlg50TyMszkHHKGNFwURN2uyi5al2as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711461718; c=relaxed/simple;
	bh=V3LtLcoh7RZfxBzKmMQISZYQAPflpMNXZ4QLRQ6Jozk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FG8LNKaW7tveDT0Oa/7mzkH3iqbII3M5eRCfevVHLelnJqF+p+fILxb5CXTC6C4itdmSlU5YQLNxloEkNbU052lA2hvUq5uciIrvo6wImapAf/ck8mr8nvcQA+inA/E7XmDWh7+7rbR7/EXEc+a7Uc+KhG0SQ41lwwn86OmuAVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=XixxKFIn; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1711461708; x=1711720908;
	bh=I5Jc+r590Poy8psRxAt4x4kjnJbKbgVKmyw8FzFeADg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=XixxKFInoIckjSdzAKvOCMmqM0VHzgCFvJRXt1UxcJ8KyYEaZM+ihqXSynJ3mK6Fc
	 hVc7duyrw7Rrnkd+3UfuS8zWOi20v7tnr8zdWm2KKbVCa3RHpZX/fhRDsLKzu91cUX
	 vIZvB2pYaMwP5gKXDmcMrlSTJmhIiO8N7zoTpgo4HXacBQluTA4+1yRgPqm0pL9o+Y
	 eV5mfs69tBqtKSmQvsdKXq9ekRrYmsOrtNJYuwBaJGMomrfEidX5+IV5x4Li+8O9KC
	 fFdqaYpUsjoDr13LWcAjzvZIfYECtRS1Uo2nCYqHkrZ4x7khPo+DTjpr48ACObIP4T
	 xH4lPg37rLpjg==
Date: Tue, 26 Mar 2024 14:01:41 +0000
To: Wedson Almeida Filho <wedsonaf@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, linux-kernel@vger.kernel.org, Wedson Almeida Filho <walmeida@microsoft.com>
Subject: Re: [PATCH 08/10] rust: sync: update `Arc` and `UniqueArc` to take allocation flags
Message-ID: <cxfjI5t5UJ8OSbEeS2LoskypEutyGhL9OwBZZyfQOAYg9_mDdLiJFpYG7J3bKAx004q6-9czY540i1NxgxTiOVo95caFkf0WAcurFww2F00=@proton.me>
In-Reply-To: <20240325195418.166013-9-wedsonaf@gmail.com>
References: <20240325195418.166013-1-wedsonaf@gmail.com> <20240325195418.166013-9-wedsonaf@gmail.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 25.03.24 20:54, Wedson Almeida Filho wrote:
> From: Wedson Almeida Filho <walmeida@microsoft.com>
>=20
> We also remove the `try_` prefix to align with how `Box` and `Vec` are
> providing methods now.
>=20
> `init` is temporarily updated with uses of GFP_KERNEL. These will be
> updated in a subsequent patch to take flags as well.
>=20
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> ---
>   rust/kernel/init.rs        |  4 ++--
>   rust/kernel/sync/arc.rs    | 28 ++++++++++++++--------------
>   samples/rust/rust_print.rs |  4 ++--
>   3 files changed, 18 insertions(+), 18 deletions(-)

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

--=20
Cheers,
Benno

