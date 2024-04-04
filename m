Return-Path: <linux-kernel+bounces-131137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CFDC898384
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 10:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 268CB1F214E2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 08:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C74873186;
	Thu,  4 Apr 2024 08:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="ZQY+fOGL"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0304597A
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 08:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712220813; cv=none; b=t0meR3bEzSykL/VzOWAw7lErMhVSpnA70cC/wLCmo9ur5HlJgzBS2qTwMNFbm8bK9v89+cE5Ue5Sv62LM0grfRDHHgnn67V2pUAIzj4PFKTl7Rke8wkJvJU6vUPeBHodkQfseFj61Cq96wnVWkDR8qReYmY3prZ4FogkkVJvdUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712220813; c=relaxed/simple;
	bh=QnqiA7cqOqWHyrF7A1C3zhzdsaPCJ71GOtHW696ZnKQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V2WgWyebf8Dsa2d+/0f8TmTn5ldsHNUCNj3c1WkBvzvXnxZA//G9x6zNluzu36bjzaqqtAdWDpNJDJjq+v/NppLc8qQ64EUmg2vO4Enc712SS+UIi/7ll9iqWwGAHzQKdziIfuKFhFSikEL13bezLMo0CRwV57RV/xDntUU1iVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=ZQY+fOGL; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=k36xzs2vbbcnhm7bjcihyouree.protonmail; t=1712220810; x=1712480010;
	bh=QnqiA7cqOqWHyrF7A1C3zhzdsaPCJ71GOtHW696ZnKQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=ZQY+fOGLftwavMBKHACHzh9s0Y91H5obfbsw6fw5H+crmXOk5pZI8LXOHr+z+l5vv
	 0d7/NQct7rZ52LKr4dYu+CiubbUS8cR7sXAMBRlRU6bd0qaXS9hJKl7R1Kdjrb7Ayt
	 8RYKbusYlRPN2oLFCiiMu4dtOji2Asucv44zKhF5f5okGJ1D8OCcVxG+T9uOLt6NqO
	 U64H3FYS0C/ARjLKzjKcSnPp2QY5FBIHZvKscDBji3qv4Fw2E282Msz+qN2/kkUjFX
	 yCu9esAhSWxPEPApanpPLDijR7qnOrImdmMG+TNrlBY2sZG+gXwE95xFtzza/NpQpD
	 Zyn1D44d5C2vg==
Date: Thu, 04 Apr 2024 08:53:22 +0000
To: Boqun Feng <boqun.feng@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, Martin Rodriguez Reboredo <yakoyoku@gmail.com>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: init: change the generated name of guard variables
Message-ID: <331cfa9d-9687-4922-a7f8-5579173d66c0@proton.me>
In-Reply-To: <Zg3aVLUHkRFxqAh3@boqun-archlinux>
References: <20240403194321.88716-1-benno.lossin@proton.me> <Zg3IHZfYVEOh7nc4@boqun-archlinux> <ef1400ae-ba9e-4656-98db-a882ac720c1e@proton.me> <Zg3aVLUHkRFxqAh3@boqun-archlinux>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04.04.24 00:38, Boqun Feng wrote:
> On Wed, Apr 03, 2024 at 10:09:49PM +0000, Benno Lossin wrote:
>> On 03.04.24 23:20, Boqun Feng wrote:
>>> On Wed, Apr 03, 2024 at 07:43:37PM +0000, Benno Lossin wrote:
>>>> The initializers created by the `[try_][pin_]init!` macros utilize the
>>>> guard pattern to drop already initialized fields, when initialization
>>>> fails mid-way. These guards are generated to have the same name as the
>>>> field that they handle. To prevent namespacing issues when the field
>>>
>>> Do you have an example of this kind of issues?
>>
>> https://lore.kernel.org/rust-for-linux/1e8a2a1f-abbf-44ba-8344-705a9cbb1=
627@proton.me/
>>
>=20
> Ok, so a new binding cannot shadow the name of a constant, that's a bit
> surprising, but seems makes sense.
>=20
> The solution is not ideal (for example, a constant can have the name
> "__something_guard"), but nothing better we could I guess.

Yeah that would also be problematic. I think the problem from the thread
is best solved by making the constant there upper case, so it would also
avoid this issue.
But debugging the error in the macro is a bit annoying, so if someone
encounters this again, they don't have to deal with that.

--=20
Cheers,
Benno


