Return-Path: <linux-kernel+bounces-29945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F3BC83159F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 10:20:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 912861C2295B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6987C1D55A;
	Thu, 18 Jan 2024 09:20:42 +0000 (UTC)
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E55BE7F;
	Thu, 18 Jan 2024 09:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705569642; cv=none; b=KBbdTkKARUH2JdcXrFR53L8C95arH4DRZJybGWdia1iCOhGotizLTSCHIZJDPVDqhjyUfIG/URtNID0IlppHMuAiq40d1/2hWRXC+oTFPveTepXt5O2C7jXGC6awl1GJNdS8t8fi2jafHAK4pNYxHdkIsUvYKlg50g2uiZ7q3Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705569642; c=relaxed/simple;
	bh=icgK142jnhKCNQrfFxL3msTXe+wMu7KCrBK09QWJP30=;
	h=Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:X-Provags-ID:
	 X-Spam-Flag:UI-OutboundReport; b=dNVXnvy6LvCjSgvSpWkTH2E/cEARwvPHrYQ41ddF1PSt6WAHwFA8fxZSn8niWeu19Pb+1yyShPpQWmWvzs3ZUnt3iXlvtiKTd9SS9Wm4ZDMKOkfvOMFnZUNqGEaQYCDHd5vZAHndxJPTO2ibeA2OxsM278U8PReSN9Pt5ePKoek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de; spf=pass smtp.mailfrom=valentinobst.de; arc=none smtp.client-ip=212.227.126.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valentinobst.de
Received: from localhost.localdomain ([95.223.130.98]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MFJfN-1rK2q03Bbl-00FlBA; Thu, 18 Jan 2024 10:14:49 +0100
From: Valentin Obst <kernel@valentinobst.de>
To: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Trevor Gross <tmgross@umich.edu>
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
Date: Thu, 18 Jan 2024 10:14:37 +0100
Message-ID: <20240118091437.25001-1-kernel@valentinobst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CALNs47v1y6aXBFka6Af1BNykycjNce6Rnjvf0sw4r1vMegFhBw@mail.gmail.com>
References: <CALNs47v1y6aXBFka6Af1BNykycjNce6Rnjvf0sw4r1vMegFhBw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:HvRMwuW92UrERzMMxxxPExZjYNfh58cwuz0pbbQTI6gocQRi/8L
 e2FqSqk+w9T2rAu/GwwyOE97vt7WoJyKpUpI4inBQ3E5HIfNGeJ06bj5TNFCwmlcwh9CxM7
 SafIUROvPyDhbklQPpjTaqo9D9nZ9ZiyHlUtv4W0ckPi577PjCIr40dXpZkQdjk+AC4d2oV
 DlFnEL7VgDVIB9ClBZuxg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Z3VQi8fndeQ=;rNfQTWLsJhh6/edYb5PLoOPvPoj
 PpTg2MU7cjWUzfh8LIeVa4jWTCRE6XgkiXkrXfVt/+EYaIahhKJLfUkYeX6tPLdbRYB/UL19B
 e8RspkweSeZB1Z5cQ2/vHKzl/bl/zLcn0ClxeWp7ZsZ1z2wduMDCYIRCA90DeWAWI388n6bWB
 L9+LQL4wTpwLRz3xO/WKUdxwHQcAYpDKHCFlarqaER1iCSjOqegXpyQX75G08hx705UOMw37r
 Rb0zBRmHhLSD8tw6v0qxh0ll+Bq9gfDgDMMgGhvw1uSe9Wh5YjAUd+LZAEoVI4ILDMgk9TST5
 KghkvrE7N1hjYdq/rwlq24FFmwwXKhILsrF567ZnVv5p4ZsMHZo2kuTVOSbNbZWjM/aBekVj8
 fx2YpFeGKAFxjOVkNLdPwO/onx7BcKFMoaKUMm1AJorAWbRtXYHcBIqGkYRFQSu2QZPW1yZ9y
 jbrOwJZYgl+lfTGBSyr1w+eM1sVNfxjebeWgj3Th0MRGwqL/AvJdmQjxYrRuoSHJBSToxCuPY
 LcNqL12yhg4hzFOysKyc7bWny1DIWwW1UzP4QmGbuCPWMI7BehGwF5JOIjtUwpz80FRV/An9f
 MdEayP7wRf8twfGWuQGYXiRgobvrSAgmMmLyozL/KqoKkIZF/3GLG0LXR2fEDFJ6Ndwt2eFff
 Wg3xJ1rd8YqKJznBy1wzoYd+PNZWo/+31it0oGEb39G9rBWfXfZIu7FWTqe7bu6/zJpnI4/nb
 YFpBuOAUFBbnL+c4ToRTbjTIPTwwcqWVQA47rtcKJ26DQeN64rlBZ49RqGtWZSRv1/QPMshhd
 Dhm27KS67oCHcch0z9Ao3z6jEsYHhRe9Y6Z+xoTNqACC49y9G9aikMRoPW+/CIgPJukfOV1LY
 wgbSYHMsMcfEThA==

> Std sometimes does something like this, which links to the slice primitive.
>
>     [`&[u8]`](prim@slice)

This would indeed link `&[u8]` to the slice type. But I agree, both,
linking to slice and to `u8` is not necessary as it is common knowledge.
However, if it is a slice over a more complicated/custom type it might
be worth linking to it, and in that case the 'code' tag syntax would be
the only option we have at the moment.

> What exactly is going on with Arc, is it not getting linked correctly
> when it has generics? I don't quite follow what <code> does.

In this case it is about the `&`:

<code>&[`Arc<T>`]</code>

Here, `&Arc<T>` is formatted as code, but only the `Arc<T>` is a
clickable link. While

[`&Arc<T>`]

results in:

```
/// over [&`Arc<T>`] because the latter results in a double-indirection: a pointer
    |           ^^^^^^^^ no item named `&Arc` in scope
```

using:

&[`Arc<T>`]

would result in a link, but `&` is not formatted as code. Finally,

[`&Arc<T>`](Arc)

would work but `&` is part of the clickable link now. Thus,
using the html tag here is the only way I found to get the
'cleanest' form in the rendered document.

> If rustdoc just isn't making good choices in certain places or isn't
> flexible enough, could you write issues in the Rust repo? Better to
> get inconveniences fixed upstream if possible.

I like the idea of finding a proper solution to that in rustdoc
instead of cluttering the source code with html tags. If nobody
strongly objects I'd drop the whole patch in v2 and open an issue
in the rust repo.

	- Valentin

