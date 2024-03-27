Return-Path: <linux-kernel+bounces-121576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5942D88E9F0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:56:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B35412910F8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3F412F585;
	Wed, 27 Mar 2024 15:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="AF17BpdZ"
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D4812DDAD
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 15:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711555006; cv=none; b=Sf3Wlj4UG5canKEI00B6OWMSUIi4I1BCTXyzCcs6cjM7bGhxKJAkiTrDWNa9yAqIza+0L8+/cfOhRgs3yOUgLpOaOWNPei5EO/4N+YYTLiKg5RiKxG4xNe9pYYwLOOG1PSnQl1un9aRcZvSLB/wRH4zDVS1pRZx9K94dfGRsCB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711555006; c=relaxed/simple;
	bh=oBy/JhjmK2EQqsC1nixTeg1nQjy3xFSLinUv1gCwOII=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VUPjsIRPPtHqv9kBADUN0gRPesozxjU6voi/+bVuDIMpeZ+7rDXdQd9q3u39QFrPXH156+kM4ObXcE2NR4A9w7LFszXvQCsYO2VPHtwMoxKhia9eFBgofJLaLWR8p5SiaTeyfj1vOw5uhQog3/RaAUeHc/H3tXPdHxS+B8l+m24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=AF17BpdZ; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1711555001; x=1711814201;
	bh=fX+Yqy0xwfZnwVjVOSoy1fd6e/DKxaeiapYp3ctKXdA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=AF17BpdZD3qcOocqZDkG7vB2JN+8DhPFot5cAMfhMqmMa8RnOKCTO5qQ/JY5qVLGx
	 +DKhECZdaR2ZJsplWFS4BsYFnCGE+vlpaab2dyQOy/2aUieBqEEjm/2pFqph+wrj/K
	 AbXYcVN3omi6tBQnqvwievcTiCZ9sPVI97m6MFC+kv3L1T3YQqbgZjhIR6tE3RU3fa
	 XAUPtxwF55ABQ5fn8+x/xtnMTqgc2vEP1ueId2WxWB53IMuFSI+pbSUAVdJjyeMPXm
	 KFpBFGVyCwFerFLHvs0kbtJUJjkTwMYYWJekqqJx8ShmFWUmi3WUIwexIh2/rSiRtm
	 y9rSpi7Gu+DwQ==
Date: Wed, 27 Mar 2024 15:56:28 +0000
To: Wedson Almeida Filho <wedsonaf@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Valentin Obst <kernel@valentinobst.de>, a.hindborg@samsung.com, alex.gaynor@gmail.com, aliceryhl@google.com, bjorn3_gh@protonmail.com, boqun.feng@gmail.com, gary@garyguo.net, linux-kernel@vger.kernel.org, ojeda@kernel.org, rust-for-linux@vger.kernel.org, walmeida@microsoft.com, Trevor Gross <tmgross@umich.edu>, FUJITA Tomonori <fujita.tomonori@gmail.com>
Subject: Re: [PATCH 1/2] rust: introduce `InPlaceModule`
Message-ID: <nNO5IHIkY0ti-c5334QC1qNmxmomUn7FpPoq7gw8rrty90n8s5j0r0a8opXAQL2SBBU5ZI3Bni3W7p0i4jnoPZjxQqPTcmv3qYt1emMZ4kQ=@proton.me>
In-Reply-To: <CANeycqo9noMJGSCsjCoH29xuPTJ7NEmYnFBE__9D+tvaqsiLdQ@mail.gmail.com>
References: <20240327032337.188938-2-wedsonaf@gmail.com> <20240327081317.45574-1-kernel@valentinobst.de> <CANeycqo9noMJGSCsjCoH29xuPTJ7NEmYnFBE__9D+tvaqsiLdQ@mail.gmail.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 27.03.24 15:23, Wedson Almeida Filho wrote:
> On Wed, 27 Mar 2024 at 05:13, Valentin Obst <kernel@valentinobst.de> wrot=
e:
>>
>>> This allows modules to be initialised in-place in pinned memory, which
>>> enables the usage of pinned types (e.g., mutexes, spinlocks, driver
>>> registrations, etc.) in modules without any extra allocations.
>>>
>>> Drivers that don't need this may continue to implement `Module` without
>>> any changes.
>>>
>>> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
>>> ---
>>>   rust/kernel/lib.rs    | 25 ++++++++++++++++++++++++-
>>>   rust/macros/module.rs | 18 ++++++------------
>>>   2 files changed, 30 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
>>> index 5c641233e26d..64aee4fbc53b 100644
>>> --- a/rust/kernel/lib.rs
>>> +++ b/rust/kernel/lib.rs
>>> @@ -62,7 +62,7 @@
>>>   /// The top level entrypoint to implementing a kernel module.
>>>   ///
>>>   /// For any teardown or cleanup operations, your type may implement [=
`Drop`].
>>> -pub trait Module: Sized + Sync {
>>> +pub trait Module: Sized + Sync + Send {
>>
>> This does not compile with `CONFIG_AX88796B_RUST_PHY=3Dy || m` (or the
>> phylib abstractions' doctests) since the module `Registration` is not
>> `Send`.
>=20
> Thanks for the heads up. I thought I had enabled all rust code but
> indeed I was missing this. I will fix it in v2.
>=20
>> I remember Trevor raising the question whether we want to require module=
s
>> to be `Send`. I am not aware of any examples of `!Send` modules but I gu=
ess
>> it would be possible to write code that is only correct under the
>> assumption that it is loaded/unloaded in the same context.
>=20
> It might be possible in the future, but I don't believe it is now
> because all rust modules support unloading. And there is no guarantee
> that the thread unloading (and therefore calling module_exit) is the
> same that loaded (and called module_init), so a module must be Send to
> properly handle drop being called from a different thread.
>=20
> Not requiring Send on the original Module trait was an oversight that
> I don't want to repeat in InPlaceModule.

I think that this change should go to the stable tree, can you split it
into its own patch?

--=20
Cheers,
Benno

>=20
>>
>> @Trevor: Are you aware of any modules with that requirement?
>>
>> I have been using this patch for quite a while with my TCP CCAs now
>> (without the `Send` bound) and did not experience any other issues; thus
>> offering:
>>          Tested-by: Valentin Obst <kernel@valentinobst.de>
>=20
> Thanks!
>=20
>>
>>          - Best Valentin
>>


