Return-Path: <linux-kernel+bounces-1849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5358C8154C7
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 01:03:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 091471F25CB1
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 00:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81065694;
	Sat, 16 Dec 2023 00:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kO1eLu58"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31A44A26;
	Sat, 16 Dec 2023 00:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-db538b07865so1112173276.2;
        Fri, 15 Dec 2023 16:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702684956; x=1703289756; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HUP3bpCvVKirlUHMbPP+Vvn/KkPpGHwcdqXev2j/lBA=;
        b=kO1eLu581j9gEmC3vmDTqmZ2HaoI5q1SYoFe2nDiIrQ6DimOv8/M/yzSCle9uf6bav
         Jzlbx22bf3Ci9nsYnxIKaitXy/7CPwvUnbQJSv+tyKGTg3aMG+UenPmEm0yZbi9O6PuZ
         nw+hv/NRyaGzeX+Anxr4KqDHHpOp+bmyf4LSlfbjDBYi3iKQTrOZnqJeVJyDnm1Tgvg9
         wUc13O7vqmhLjKq1m0jVr3GHcyZbX/LaxjclpaDExeXuWkGc0fCpaUn00OdmJOAyul2n
         bLui6WfZV9/UjDNub+BmW4b69Y9H5XH64pH7579foAFJ8uUGa5vM4cRzCBV3b8mVQ/yM
         7d4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702684956; x=1703289756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HUP3bpCvVKirlUHMbPP+Vvn/KkPpGHwcdqXev2j/lBA=;
        b=l2oYkhGIaY5fXNiZ649dHwsarKK/gRqvmK0o/Qi3fVpcH0qURHFST/NLKLybwrbhr/
         rtpsPMgOA54Z7g2BdYuvSLa9iF75SK3UmHMCx9cCj5gsQhvuV5STZF8mSNJEQFeg//Ba
         YlX3IBeiqJDWh8/xcZrCnwjkotzAdHFaZSpdap6gXpXYr8oX3PwXJxvHpKkkFAhqy15X
         Pnrnf71m7DukYuVw8pQ6JlRql/jwy/zWi7iWaKEKBCJ42U9yrw4OS/Mx1KQYfZSv54Iv
         YvwvJ8V4CCsABEWOR9ffaSfu17FTsiKJzsBALe0fWXjcRtkHZ+5sJTtcyqpQysTsiOYE
         wdpQ==
X-Gm-Message-State: AOJu0Yxd4EGXe3woJeohflsdiBA1JBZ374cvw/uHptU+qSZDxswBujl7
	ZbfuWnb0QuA2KUy2eoxopXuK6ytrkqimpub3msk=
X-Google-Smtp-Source: AGHT+IGvPfH0mpoBG1iug8UwmNxFRI3F59+AybxidcQnROd3JXcSiY/aigPxSIwnvGkPkOjXOxZBO+SEVyrpS16B2bw=
X-Received: by 2002:a25:dcd1:0:b0:dbc:e53f:8705 with SMTP id
 y200-20020a25dcd1000000b00dbce53f8705mr2535065ybe.81.1702684955826; Fri, 15
 Dec 2023 16:02:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231215235428.243211-1-ojeda@kernel.org>
In-Reply-To: <20231215235428.243211-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 16 Dec 2023 01:02:24 +0100
Message-ID: <CANiq72mvspvQ_0Mr6TAw55sa_GUM6FRSYb_1JU67hwT+PzLZkg@mail.gmail.com>
Subject: Re: [PATCH] rust: support `srctree`-relative links
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Wedson Almeida Filho <wedsonaf@gmail.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 16, 2023 at 12:54=E2=80=AFAM Miguel Ojeda <ojeda@kernel.org> wr=
ote:
>
> Instead, provide support for `srctree`-relative links, e.g.:

If we decide to go this way, then I plan to send this to stable later on.

Cheers,
Miguel

