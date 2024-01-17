Return-Path: <linux-kernel+bounces-28694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB0E8301EE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:11:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EEE01F274EE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 09:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9042113AC9;
	Wed, 17 Jan 2024 09:11:04 +0000 (UTC)
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B784C13FE4;
	Wed, 17 Jan 2024 09:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705482664; cv=none; b=poy+qHyHwbUqpTT7ERM/LlfN/9iJETZbJtOT5VCzb9odhqT2kd67dL2yyOFtiNx5gvnvAd7GrzpOFPR08qOWLg9DasUeV1YPQmuebFq0IgmtPsbmjKdOMd0nldXuI8YM5+2MYb+23m37SKEr84IUD2D5bZouL/7tb0KLzzNbqk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705482664; c=relaxed/simple;
	bh=Wufmwc5OiZ2ZBOE+SYQMYh5caOE9cr+BFk/qMaOMUpw=;
	h=Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:X-Provags-ID:
	 X-Spam-Flag:UI-OutboundReport; b=VQ/RMg2saA7dwIEDF9D0oJeC8ffXQfwn3FShTv+exISu3ZbNFLcg3E6Gyfwwxay7OAGJVN2IyoGSfqw7gzf2IYK99yDHbJUYDnusDOvsmOVZ7Q4t24xmedYSppx3ZsySiGlfX8eBHLXvZFokuYfhAl1mo0BwJf6ihyE4OrubWDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de; spf=pass smtp.mailfrom=valentinobst.de; arc=none smtp.client-ip=212.227.17.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valentinobst.de
Received: from localhost.localdomain ([217.245.156.100]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1Mlvr3-1qh6cX2za7-00izH3; Wed, 17 Jan 2024 10:10:46 +0100
From: Valentin Obst <kernel@valentinobst.de>
To: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Valentin Obst <kernel@valentinobst.de>
Subject: Re: [PATCH 11/13] rust: kernel: add doclinks with html tags
Date: Wed, 17 Jan 2024 10:10:29 +0100
Message-ID: <20240117091029.182098-1-kernel@valentinobst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <a3856ffc-ddb9-4066-8e1d-999c8f7790e8@gmail.com>
References: <a3856ffc-ddb9-4066-8e1d-999c8f7790e8@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:+8e1IUodYn8hytsPyKooqZPdIIj6vadUy9opB2OzBzSrvRBArSm
 mg10RiNwKGnJfNXP5VY+21f6Jnca4b2ZZfzuoyyQgfL9fDPC/KvTQt5OzrB40XftEbHNy5T
 CwibTonzyAjLCsMDfvytLPwudFWJ5OgNWJVcH6Du5FzRMJ3RsRWWLwYlGHp2TDNZyV7zpGZ
 W3QURz0710XAjUVztU2NA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:OnI26W7kGy8=;FhSUg2A5gIqu1sgMx0AuCkrtJRZ
 SS5RpGgq7biN4894fWEJq4MiJ/R5VJfvb6pHbzNDyM5sxLx3hAZECVL/9yXqeeXvBsz8fgwEz
 3ibYIxaL1AD66COhg5BrAH3CGwgSk7Hui94k3tN6GL29B4Aiy/AKW5VH0QKoIbgWg8lsjdOOU
 nZyHa1/dHagEm856xR6wlh17PXIntxlUrzwZuQKvcFD6dvq/rAvQKZSjjre8Vu8fMQK168fJn
 vBOTsh5QrncKu6uqMAOLMiiMWONIbicaaw4yzlJkOLOOa9TNUB0mE9KncvAxoqjIQcrGRM0Du
 dMiNqZ9+TGlJ4HJRjPVgWAROTsSUnSWDxc7ntOH3fmB+Y+6r99yCfsKOhkrogd0heseevTMCa
 fS6dzPBLNJGr4m12JufEgOOooQ+M5NV36UL3Olg0gtOOM8Ry4fRrc/2AkYoFerHPdZNK75Ez9
 xfMO0iiF4RbMwnGsrGwWzkVVRVXhB4xKyLbxxg6ZkFltvg8WepUCNZvU2mHThoTzEul2Tx4iB
 UN9Dq9GuZV9lWnhW77MPvEM0FjGBrL5UfMhlqXbeKFznduLwpA5TDquvxaWZqjL8PBVv5ETAt
 /ftMnSnp+2otdbEkNs0DOZLXNm452vy0FxE/NUqDttOqxDQLPN5ZO4rU/ih3xDlgV/Gea5on6
 Ft0V0pa5rHJHLTAJRxAPdz+1axiUi4vDGaweHH5tZXKDuE5QYIXzjuqgOsAdRuKDmIrR+WPJu
 X0fqhAZHBMEwzxmpo8jLOpETGKq1TMmfmoMVK7SSmg25QBIrI/MB7mzPbHPjCV7T7RSgEEwMe
 linvlblyO/XfCjPNh6y+QvZlzB5iC6aVjdphIZ5bdop2gZA+aFPbwVu1EC0ef1rI3kSSnieAS
 xNMZjBI4W/Sf6jnOSnV7NyaInP2ZGHx1Y+lQ=

> > [...]
> > @@ -14,7 +14,8 @@
> >     /// Byte string without UTF-8 validity guarantee.
> >   ///
> > -/// `BStr` is simply an alias to `[u8]`, but has a more evident semantical meaning.
> > +/// `BStr` is simply an alias to <code>[[u8]]</code>, but has a more evident
> > +/// semantical meaning.

> Isn't there a way to escape square brackets with backslashes with
> mbBook? Like `\[qux\]` or something? I ask this because this affects the
> readability of the doc comment so if that could be omitted it'll be
> really good.

Here are the things that I tried that did not produce a link:
[`[u8]`], `[[u8]]`, `[\[u8\]]`, `\[u8\]`, [`\[u8\]`], `[[u8](u8)]`,
`[[u8][u8]]`,

This results in a link, but it includes the square brackets:
[`[u8]`][u8], [`[u8]`](u8)

This results in a link that only includes the `u8`, but it is not
formatted as code:
[[u8]]

The only other examples of linked slices that I found are in the
standard library [1].

My assuption is that crate documentation is much more often consumed in
its rendered form, which is why I think the reduced readability is ok.
However, if that is not the case this change might be a bad idea.

[1]: https://doc.rust-lang.org/src/alloc/ffi/c_str.rs.html#58

