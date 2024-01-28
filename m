Return-Path: <linux-kernel+bounces-41882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7563883F92A
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 19:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BD1F282DDC
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 18:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500872E84B;
	Sun, 28 Jan 2024 18:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hm6e5IUw"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414C72E62B;
	Sun, 28 Jan 2024 18:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706466418; cv=none; b=kCr3n9Pv6BbiuHu32Q1j8k5Mlosu7eyhxAwZQQsAAFz80+gcMBNX3vXvmb2loMewv9MdjGh7pZ1WYMabVg+zY0Nl11wN5t/IatQmo1FueEAGLcV8LFRPP/fD9TYlBRs60bwu+ksrTXfvnc05b+3I+qDE+6QMbRIdLCAqa9UPhp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706466418; c=relaxed/simple;
	bh=UXTngv2IRaXa+2eC4u2kVj1o4DgKsM6J1Yyn4x6/qHw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rP4CaSKzKBI65DvKzM8UZewPQGhW1EZB4EKAfjJImUTINmnJSoycRfxzNl9TurKgJT+6K4uUNGK/h2laky2NeSlkLHAgwojHfBANVMPFA12gHVZmgw3pWtDJcxJpQMG/nBEW/6F4pg9f2Z61jHCppIFqGIUO11/RzHaw8FNYPKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hm6e5IUw; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-602d0126e80so16950687b3.3;
        Sun, 28 Jan 2024 10:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706466416; x=1707071216; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UXTngv2IRaXa+2eC4u2kVj1o4DgKsM6J1Yyn4x6/qHw=;
        b=hm6e5IUwAEylMWdb0I2crHU8S80NVqt/M26Hd4P2OAwrNytL5rzVptCWlzgaUTeVtF
         bnhuLTmpLU57UwF47MAFdsE+gGIkVih0XnkS0lBALzODYlPv6ciIVeRBcQwB+2qHMvAs
         /Ap+TnNkuNwm3VTaAtlzgYjt8YpyvkKItnNvGcmWSJzl0htRK2kRIxcSbVnqTHB13frv
         /X+O61uE3GnlzzHdf2nvu3EV11r9eOrqxiWsXjJsTRdBPo1dLW0Yapv4Ipk7bDvKmtWs
         +gxNl2kXJwAUkk/KzO/YhsooF4AsI0873jqac8Twos0ZL98MObYD9Quq3jOICFVXc63m
         UcHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706466416; x=1707071216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UXTngv2IRaXa+2eC4u2kVj1o4DgKsM6J1Yyn4x6/qHw=;
        b=FUzb/XuDAFs8qqwkKVzobrKs+5yxj5lVrM252j5TenBDJJbv+wyc5tGrrbK2c1R4p1
         yqrT4JW77NSHJfBOsmmbgvJnXJPpM5Z07xiQ9oSFHRhclhSZgXy2/QBp+ssJpLJGSSWN
         yaDIzddUZeSXMuDN5Sl9EXNhNZJ37pR8vqg90tvRUzXGpKRb9P2/2eLxrgQZk4dwvv3S
         wN95zMgzx4SKcf77q3p+diDivN7CprpCUoEtt4OsWj3Foag0yKrylpxeaNwG71cdOXaV
         GpElWUwZXSvsE8iQnADLbGTXsE7eT1NCAPbPoQSRZyCH6h2quTi0RvUKQsGsCtFB8Dvq
         jtWQ==
X-Gm-Message-State: AOJu0YyfX0iV/doaodpzyXuK+DktoMISlJl3EtmJETL7Tv9v3wLzr2jz
	JmNHo61l6RQg4fOrSbhCYFD/KVywQxgYKjCHuoozCW4uOPkHIuhFcFH1ZrsJF/oNlwd0pvH/jLo
	RGepX4ywCF+K5T+KR+K/DAXOtr48=
X-Google-Smtp-Source: AGHT+IH4qPrdNAcAUFXsMfaYWG5heoS9259jnH7OV1Wc3BHu64nL+mQKDxGhwtH2ZbLGQ3WmWJjvggFPbjyNKRDRnPc=
X-Received: by 2002:a81:4006:0:b0:5ff:9810:e8d5 with SMTP id
 l6-20020a814006000000b005ff9810e8d5mr2500689ywn.87.1706466416118; Sun, 28 Jan
 2024 10:26:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231023174449.251550-1-ojeda@kernel.org>
In-Reply-To: <20231023174449.251550-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 28 Jan 2024 19:26:45 +0100
Message-ID: <CANiq72kGPTxC09GigzcLdD8qP6QPch0M7FB8iyqNHNnXN52L4w@mail.gmail.com>
Subject: Re: [PATCH 1/4] x86/rust: support RETPOLINE
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, x86@kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev, 
	Daniel Borkmann <daniel@iogearbox.net>, "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 23, 2023 at 7:45=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> Support the `RETPOLINE` speculation mitigation by enabling the target
> features that Clang does.

x86: do you plan/want to pick this series up?

Thanks!

Cheers,
Miguel

