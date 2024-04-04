Return-Path: <linux-kernel+bounces-131279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F9189859F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 13:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC1081F28F72
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 11:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6D4811F8;
	Thu,  4 Apr 2024 11:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UamSE0Qg"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DB259157;
	Thu,  4 Apr 2024 11:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712228598; cv=none; b=WuuCBkZEak3O6G2V9Jt2sEb6qrC7c6bt85XSpipt+CDzhQht1/Pw9RXWx/kA58P7+YCDQJFCKvj4LVDXQGkbOxGZTYvvo2lxQ0MLAaAGqFP/HTwO+T50lr/Jwlmn8P5rfUwg41E0HtMFO3IeYoQEh7C1Ezcs81dDlnkBwY3jM2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712228598; c=relaxed/simple;
	bh=fdu26r6ihIaZX1cgogSD3D0GMtEvmDKWge8KTEoRyp8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MpQdnBiM40SGBXUuLFhXzgoKzf4VnaGit1dglTLBdZZVGgHXjtorjCxcX6mJeBlXNc8j3mZj5lv7oqxqMUkBRXSBqOa+tgQiFfG2vdseq2XHgUrkh2eAlFeZ94Vgtrlo1OGdZ3mMuA1O1YLK0agkhN1pAqcXkTt6A+PVcUSJ4XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UamSE0Qg; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5dbf7b74402so591275a12.0;
        Thu, 04 Apr 2024 04:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712228596; x=1712833396; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fdu26r6ihIaZX1cgogSD3D0GMtEvmDKWge8KTEoRyp8=;
        b=UamSE0QgDUXMQ3n7OR4g+C++oeQ7Yl0eQHXJD1unzuvoXxrF/zj/zgcHLyMN3wbDkG
         P2Mk8yU+RgLQnclvzTxo57flirdr9w3uULurQmT7PgsHQlKbZLOtLbcawxJfdVvTJAIb
         KIx9u2FCAVmHkFaQoli9kYNeZUa6KwkAC62FukJiA66vj30cJHDCZs1TzrNfkAYEhlvI
         Ia+3SG94Vry9EpnZVt2x96R31XzuQlio377dMZI09Vcpfgwomnc7oi4qcZDRO1EowmdL
         VjceIocXABSIvfco9StjkFlrO/RWBv3Q6ROxn4li6Ps+MFHBZXbikmGrInJOXV/7/XCL
         t6lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712228596; x=1712833396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fdu26r6ihIaZX1cgogSD3D0GMtEvmDKWge8KTEoRyp8=;
        b=t+Hqr3EBz2Bou2xuBqgPUQYyNhScRYlLlKbLI23frsnB9cX1Ti9m9nM5f8rA/xsMHQ
         biuwjq4BXalG3YDJZ9PXQgc3qlivv0hTSdE/ffTTj4vxhD8Vd6hQygv1s3haHVEgf5nU
         LToogp4p1YaH9qLwKdXvvDNktXMFaJd6xV5CsiSLlvL0+HIu1Ko0tVU3vACuFWo8aWsb
         ud9PLZafZEG3N2lKCOcXzxmyIHS+CQ9IklyfK8XJo7wy/fUtMhZkRGO305dj2JaA2msi
         BQNQpUjkpbMRzm8HN7ehs9M6KEkY4iWwUv4XojkhQj4Ki9CXoxOSWWcQ7Liz2zlBgfSh
         Qx0A==
X-Forwarded-Encrypted: i=1; AJvYcCW9ly8icUZrpCXFiLADyJrjQ4dF29ZlI43xLwDXSfOShgcxPYT1FQVK7yeUzyDwNq+Cg23FlWeZWp2UWNEUAbH8BkIZIyJzd1A6xi9+I0gYQFpWiHKrs/LEpKJn8Jkzfbbd2R9RtpH1AxX4TS33/9QRxrBamfgalhX0AaoNogGR8xwJRVQ=
X-Gm-Message-State: AOJu0YytjWCc6BBvmKZGBos6e42cWv1tTVlR7K7toL3EYB+IBlDxrjs4
	l4J9LcUck/BL3YHzNy7EuexkPkdbAxRdUZ2+fivL8QwYv47hvP8170JUVTA1REL1VLlHgozDwG6
	lIjFmu9Ah5+oFlLIQPFIAeJi+gp+Pg2nEZkw=
X-Google-Smtp-Source: AGHT+IGa+EvFZksW3o4vdfyb9WBWkSxxOHrpZnu+E4Hbla3uW8VhIWpksDBi5VCY27MzkuQ5BUX+rCFVxMGUxP3J+wk=
X-Received: by 2002:a05:6a20:4729:b0:1a3:6c63:8f9e with SMTP id
 ek41-20020a056a20472900b001a36c638f9emr1844042pzb.27.1712228596312; Thu, 04
 Apr 2024 04:03:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA160A4E-561E-4918-837E-3DCEBA74F808@me.com> <d3423fb5-c117-4bd1-9f86-db35590a0562@proton.me>
In-Reply-To: <d3423fb5-c117-4bd1-9f86-db35590a0562@proton.me>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 4 Apr 2024 13:02:40 +0200
Message-ID: <CANiq72nyqxH2C1gr=UUCOftaKe0zSuuB++mMUD9zXo-pPBVMVg@mail.gmail.com>
Subject: Re: [PATCH v4] rust: init: remove impl Zeroable for Infallible
To: Benno Lossin <benno.lossin@proton.me>
Cc: Laine Taffin Altman <alexanderaltman@me.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, rust-for-linux@vger.kernel.org, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, 
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>, lkml <linux-kernel@vger.kernel.org>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 11:01=E2=80=AFAM Benno Lossin <benno.lossin@proton.m=
e> wrote:
>
> I don't see this commit in the kernel tree, what did you specify as
> `--base` when running `git format`?

Yeah, I don't have it either, but it seems to apply cleanly.

Cheers,
Miguel

