Return-Path: <linux-kernel+bounces-33238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 582FB836704
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A5CC1C22BEB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1434D12D;
	Mon, 22 Jan 2024 14:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kNPnx1BZ"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36394CE15;
	Mon, 22 Jan 2024 14:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935461; cv=none; b=lQ0SV8a7jbb20lwI0OcgQ96n9y1iXLo/DqcWtEy8XXVkmaX1H0MFjqQYtBdU2V37hVAeZGOuF7TYJrdgvIvJwtS4+sjfoBSv/pOVqRulz92hbcGR8oQmvwcX5bpe5NR2sknoYhWD/TXb75/XOGBP+d6Z8dyEzK019ZxTxUE7HOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935461; c=relaxed/simple;
	bh=dbTjgoR71IIADj4OTs/qmqArIX3aIs/ADiasXrZWiOE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gipV7YIzaFzAy3DcQCZ1WSEzneiolrQLBBV2JF1FFQCcTXhV1huPfmJHWGUrcipMXJj6TmtmPTe2i2f98URlTesAQk6FFFrRNyudrQzgtqvPpl8a3HDwr1GjPph8MdktGb1fGFPTXYHzCAdlZriRBEhs5liY5dZoof8mGvzeVIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kNPnx1BZ; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dc238cb1b17so2830676276.0;
        Mon, 22 Jan 2024 06:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705935459; x=1706540259; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dbTjgoR71IIADj4OTs/qmqArIX3aIs/ADiasXrZWiOE=;
        b=kNPnx1BZQdtAo9t7/iX5vBbRB+vPfYC7X1ZT8uoXv5dXybHTErOKyAm16t7WOQJH5z
         iLOWwxcnF9noLSGq6vLA5LanhBJDSOmTflqGNOiaH2TPgYkIc3XK/UynpUKZvSL4P3zF
         wHnDlZFsVG0EiS7wA4zZK736w3qPWrxB59/uZWiXePqmr+h2KP8DEW+GKkEYbK9/WILZ
         scGn4lv0iEx7WF30JSrmBAWhfZHazqX1Sx6+mPCmqyGJmGUoPbMNGyaYUSNYZ4Z2oSwv
         B4G2Ch1xaIuQDLozwejsvhfNRYtuy954gUB0tn0C41oSIHpnA853MABP/1Cy83sTMhwq
         CP5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705935459; x=1706540259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dbTjgoR71IIADj4OTs/qmqArIX3aIs/ADiasXrZWiOE=;
        b=Qvbf9yyNXOHbpfJN+5OUKdbuEIGgZTojuexkUTSuan2YMEzso811QVr6J72mYsrQak
         kfHGEuq3EVcyDryAVL3Y9anFiBvQhdFUbbm1TyzMu4iXqXw3k9QbThn3k+5dlENwk7Ta
         /59UYHwITXQreP6dajBbhf/CZ8V8rKZoQkRunRpuSRNKHyt2CUf9rGcpxUlr/4QOoJe+
         zRJcbZv1Wf9wt6K00JhXaCDjkL+hTfYEV9o6G4muUnc/6UUNFud53yq2LFOSnE44xKrU
         ummfh60YRSMI+ybmL0B9V7xcBaJ85WiQ6vSdk/sWysVOZNtgPmbdG9bfAWBhEDzun5Wh
         49iQ==
X-Gm-Message-State: AOJu0YzTZLMMfqENY2T/rp7J62cmZXZOc1eH0NFL78MegpkvialUsw5z
	IPGm0naR4Q4yCX1dIWfmtDkQFdleJ5OLRMlXBFFMjV0G4YUpwJoDvBz/9sjNRI6OXuAtnwBoNn+
	H5rk7z4z2CssjySALh+4RNQ4U6A0=
X-Google-Smtp-Source: AGHT+IHnzUFy2p7+kzamAfzR3Cl3NIAZ1jewG5eGKn99WPEvuGAIsldzYT/dpEHMVi27978kTvLjmfmnsNil4jXRYOM=
X-Received: by 2002:a25:ac1c:0:b0:dc2:3562:d234 with SMTP id
 w28-20020a25ac1c000000b00dc23562d234mr2243208ybi.12.1705935458861; Mon, 22
 Jan 2024 06:57:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231224172128.271447-1-ojeda@kernel.org>
In-Reply-To: <20231224172128.271447-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 22 Jan 2024 15:57:27 +0100
Message-ID: <CANiq72nxur+5ms8QSUmFUcCU=RU0GYvkYggDvGxr4uowNEeSNg@mail.gmail.com>
Subject: Re: [PATCH] rust: upgrade to Rust 1.75.0
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Wedson Almeida Filho <wedsonaf@gmail.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 24, 2023 at 6:21=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> This is the next upgrade to the Rust toolchain, from 1.74.1 to 1.75.0
> (i.e. the latest) [1].

Applied to `rust-next` -- thanks everyone!

Cheers,
Miguel

