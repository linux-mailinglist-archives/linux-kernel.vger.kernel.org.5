Return-Path: <linux-kernel+bounces-29898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC3E98314DE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 531D3B24C7B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 08:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E492A1C5;
	Thu, 18 Jan 2024 08:31:46 +0000 (UTC)
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06741F18D;
	Thu, 18 Jan 2024 08:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705566706; cv=none; b=JbZdmAFFcThgwwYzhoehSlL/zyh8UPl9YwLyMphigNf0w1say/2CumWXOSZtYb0AdFHvOzt7B0Nuylzt/ErtBb4v7jAiQ+0Sf2vrYPZBEMcqtf9Q6+e02jaFh3Dn/0NKz8s2MskHO1MnrBR8+BlS4Vyb5BU1KAEkptfj48IHiBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705566706; c=relaxed/simple;
	bh=bLU+D3bJrWk/PnNMeH8xf4CmhMTRTOF+3NDKWxpYZeQ=;
	h=Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:X-Provags-ID:
	 X-Spam-Flag:UI-OutboundReport; b=tcNjE0uvqLPnQeaAd3borJArYlPBZd5TCFLLP2kYgSZUFPEvUsS8MrTCIyOBHiCLd6UI+bJ9oiM3t4vFI5C2T4qKElexafHZHtNbcCxT6CQ8vKxGlLgZyaSGBbBtM6SZEBtxECSI3uG08DHISZlmheCQfu4SbbBIigE/EwtPxAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de; spf=pass smtp.mailfrom=valentinobst.de; arc=none smtp.client-ip=217.72.192.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valentinobst.de
Received: from localhost.localdomain ([95.223.130.98]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1N5FQJ-1r17an28zF-011CwZ; Thu, 18 Jan 2024 09:31:04 +0100
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
Subject: Re: [PATCH 04/13] rust: kernel: add srctree-relative doclinks
Date: Thu, 18 Jan 2024 09:30:42 +0100
Message-ID: <20240118083042.21307-1-kernel@valentinobst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CALNs47u037Bjk60E4x+c0+fk+2v5sc8iDzD0ztyqyJRdMDBgeg@mail.gmail.com>
References: <CALNs47u037Bjk60E4x+c0+fk+2v5sc8iDzD0ztyqyJRdMDBgeg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:fhEYsMUIlQ2Opz612NeGjD7Nnk8MKhIWFopgIw6gfjQuOs2oeMa
 f5pmCOzsO1IDJqyeFeJL1s6cLHXqKGp6v/bctn/vMdYO8ypp4wJ3zDArIIjk8oVZn61IE5T
 sMSf5cra4rGDOzNe7L6XJxhscq1AaTXOrNe++8YRTtS9yP/9PnZ8Bi9cX37hq7Ymw4xvFPw
 TgwIuXiDX2Yta9CbegJLw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:w7m6WylPAGc=;JiS/tigJDArelHCR9m7U5TgLK3j
 vNh869nWwiD+IXWiEQuoGxZK83IC91imBRaK0+s537zeEgdbY9KD2kM4fdJCxzxhxHbHM3ipg
 UWNKm+jl8ECECK23VpI5wgpC8M0jP28qVUjxoXvR1Q8duzA9SXvaclL1i2DAA1JYUQ4O5BekT
 l0RKDlHxvY4IetuMs93q1fbKbXdAvBA6A6AgsI3BLqqzow2dNNh0QF0yJi9hZpjBc8SAQlZLo
 YphZrlH3YLrUsY1npUxaJ6y8z0e3/DZ/KjiWfBAS28eQ+J0lUU9xw9H7xLhGop/seEQMx10nm
 2aHmQQlVrWlK4aG/CCUsUXJcHNsb/f8NbsrIRBo9i8N1zbWTxN2ufuZ0iq6Coql21R4L13BcU
 Sfg0jQwxPKjdAuzaUqoUCDcYV/A9OEsIDVF/ao0vPDeslYhKJf2GZNmq/DwQX+Fls+G1xSrnS
 yYJnY4Q75lQNlO+yuDqnAlJqdvHb4WSOVovNsW1Lh0RgweHG+kAnevryMqzmC5ym5qWZOYUJk
 jDNNJAPmnjUwRfOea5xGiXSGffgCd3gEHT3zDu3WB/eJrf7sBKkYxmrVsZkj01QAoWuqEn5pC
 +vTj9NydRcuK//WP0rMVM5R6/pzr0MKEhelA40iEpEaD+gCyl83Gw/eCO8EI+yzkwlBT8qh6p
 ljMa9593lyQoTSb7Qwlnd90GjioW/2fP4i8DLFLzDk4IzsnjTf4wEzC5FchUQou6Z1k28XGLH
 qHDzOh87rYPQ4aLc7yoIOcZMM40piXQ7FP8x6CpDc5YqcW//i6EYnojAqjIQ5tXR4yaTvs04c
 jShraKFU0fjv3lgSDwtGDwOZUTTPkI+5WVb+/dkenBir8K/ssaT5HbkPbFdjkm5+vJytuxEdQ
 Pz7f0XQMlJICc3pzXpYJWKsrvjHf710Y64Ww=

> Hm, I wonder if we could figure out a way to make links point to
> specific definitions in the C headers with # anchors. I'm not sure
> what the intended platform to view these links is.

Currently the links simply open the plain .h file from your local tree in your
browser, i.e.,

```rust
/// [`struct wait_queue_head`]: srctree/include/linux/wait.h
```

becomes something like:

file:///mnt/build/rust-for-linux/rust4lx/include/linux/wait.h

and fragments won't work on that.

I agree that it would be nice to link to type definitions, variables,
functions, ect. in the file, maybe with something like:

```
#(type|var|func);<identifier>
```

However, I think this will require some parsing and embedding the C
source file into some html.

