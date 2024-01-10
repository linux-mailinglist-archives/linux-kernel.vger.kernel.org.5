Return-Path: <linux-kernel+bounces-21926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B658296AE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 10:56:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4DE41C239AF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 09:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1EEF3F8D4;
	Wed, 10 Jan 2024 09:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="YcpeB0b3"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1BD3A1B7;
	Wed, 10 Jan 2024 09:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1704880594; x=1705139794;
	bh=G5ZY+WDMakXQ+A9kkyY+1Zweqn5BA5eHIwkKZO9iYKQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=YcpeB0b3VX7/GpBoMKn1mndlZCFdb59O1BSfSkQZ4H3Fsnbb7NuRIEHPcLdlDGj4R
	 PMYfqA4uM58gDa1TE0wfLsBTv2W/YIboon/C3kKkNPvjDausG5B8XMEEvEwca/MZ2P
	 z7NJhGsbjia725+UFHHieel28RE5bMBvYSt6GkJ4Hd1NsRlh3PMezy1BUSf0FelewO
	 jB9WPKJojBT0EwLFJWQiNgtYPJULdYKY+vrwWYcNr8KVn/xehXHg1IDBuiEZgrKdrC
	 gDQxkbP4QoLOUEEq4DwqU8hc5zbD7eNNB5/oyh/mZ+bm12FEiQXhQ4nmEI49m0E0W+
	 a4ar3oMjmQ0AQ==
Date: Wed, 10 Jan 2024 09:56:22 +0000
To: Charalampos Mitrodimas <charmitro@posteo.net>, ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, aliceryhl@google.com, a.hindborg@samsung.com
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: sync: `CondVar` rename "wait_list" to "wait_queue_head"
Message-ID: <b11521cc-b873-4734-bb51-83f313300509@proton.me>
In-Reply-To: <20240105012930.1426214-1-charmitro@posteo.net>
References: <20240105012930.1426214-1-charmitro@posteo.net>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05.01.24 02:29, Charalampos Mitrodimas wrote:
> Fields named "wait_list" usually are of type "struct list_head". To
> avoid confusion and because it is of type
> "Opaque<bindings::wait_queue_head>" we are renaming "wait_list" to
> "wait_queue_head".
>=20
> Signed-off-by: Charalampos Mitrodimas <charmitro@posteo.net>
> ---
>   rust/kernel/sync/condvar.rs | 20 ++++++++++++--------
>   1 file changed, 12 insertions(+), 8 deletions(-)

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

Thanks for the patch!

--=20
Cheers,
Benno



