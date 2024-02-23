Return-Path: <linux-kernel+bounces-78534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D006186149D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C9FA1C21B10
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27956823D9;
	Fri, 23 Feb 2024 14:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZWgXK3H3"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DD3823A9;
	Fri, 23 Feb 2024 14:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708699736; cv=none; b=OPkjjiI+bGYL+sYNJEayx/Mp9JLZIoWYPmBLfKmy6DzbathRnIb+Qn92u8mtHAPGsqa8sB7Or40XnPxMGZ3FikfGbZm7ociXvOyRKSf99ADGWOHhrVo0K+MdOkPJbtfkDBxj5eCRIsGkIMbA0MnR+fNhGP0onJszwiDksiTLJcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708699736; c=relaxed/simple;
	bh=8JApompvM0J/gpnwcLTup3cUj8M9W3A4GPR/LpT+CDE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TfI0ufxryYtvxpDioDs4nmLmak3BQxYv71fz72T1IBDH6Lu8SDC0xg7K3wIYMvf75WzxUnnKOicPFH+jUjfTA1d1aXSJPO8vnWKZ8cwF95r2l3gxLE91qTMl2QMNJsOV5nXkRbfzSGFthIXupyG87ZUOFlz001PiY3BE4NrvV1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZWgXK3H3; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-299b92948a6so690731a91.3;
        Fri, 23 Feb 2024 06:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708699734; x=1709304534; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8JApompvM0J/gpnwcLTup3cUj8M9W3A4GPR/LpT+CDE=;
        b=ZWgXK3H37YHGevUEcPLFXnRx2IejpyYb/tMr4AU/ozLaCqVXFGEoRw7SWVQf97Pj8u
         OieD0TeQQA3Dtf7yjacIEHiq/1rmXC2Qjscij6As9isjdPlWKxIbVjfu7kDsS9lteETk
         QsX6vWLSBjkr6E7I6xhRukhQ0s/s11WmfdfaW2fXbfvvlrYrapwq25xYM18u3omv3e8V
         LT3Pin/8ymRkGsz3XDGvhMaF21BuHYnKrasIfre37XDdTzhdZPzq1wslpREQuxRCQDxt
         W1ktEGynTZM7UUYBi931Ys0WouAleX+8ymF0+x00z+T3sSUBzxZ/XXqRDBbPJjVEp8Hq
         muLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708699734; x=1709304534;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8JApompvM0J/gpnwcLTup3cUj8M9W3A4GPR/LpT+CDE=;
        b=ikjQUiVZl/nhVTBoDU1s/Q73LwZVgRNEMKAPwHhki6k0U0xtHd21CIMfE3pMrGGdxM
         VKapEEOZQ0/fkVcuzmR9q9vtf7V+7BvtLKv0jmkjhOXaNYy1k//GePybviE3hkctRERh
         YwUSCzBaRQZLD+dYjsaO8+ZYFr6SEhPpyJZvdy50Hw/GznWTHbotth4+ExJchIsRgMG2
         StTkqlAwcjbrsrK8LylgRf8ntzqw0TxOg0ylCMNjg7kvRnuxY1LVI8RZmEOdJnh04rkN
         MwpPE4XmLNc7LNZc8gwhcNbCNWvxACVsNGp4SuUEin81qd7uKXU98ENL8A0nrbw7MZxC
         ZOhw==
X-Forwarded-Encrypted: i=1; AJvYcCVDK7bCv+6oZBxzZpOEbB5FhLzAxKMCc0Pv4c3EycosJXuRvOpF8WLnfRuGhaemPGnIwz5dKlns6FJiJ8F2zK5qXAFHvMXqP3uMi2H7WSBPF6FJ59H6h+Ic0bux4AWqGboAKC5iFP3eq/uUEW47Qp1BMeSVcJ1ZM8DeKET0vRS7kpKdy0AVg8I=
X-Gm-Message-State: AOJu0YwycSpXEYimlvwwqRtIzHPPkQno8PFdf0mg0/UYsu+whMridG4i
	etwxuyvXCv8n0Kx1wbJnIVmbSfYbz21/fwB1ajt4tTLmhVTtsj65gDfUBqCu+LHjTfFe7dIBw9S
	xwQA3CqrJsJe95Qh2256MIMhO4NM=
X-Google-Smtp-Source: AGHT+IEx80L+NjAGNZBT0jrWK6YYZABf331Gny44+Vt2581VZkWmKe7cyuzJfytUyxpNvh1A/stzEYfy6+bcfMkUw/I=
X-Received: by 2002:a17:90a:68ce:b0:29a:2788:c9d1 with SMTP id
 q14-20020a17090a68ce00b0029a2788c9d1mr7269pjj.39.1708699734458; Fri, 23 Feb
 2024 06:48:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223-leverage-walmart-5424542cd8bd@spud> <20240223-palatable-quintuple-ed221a517407@spud>
In-Reply-To: <20240223-palatable-quintuple-ed221a517407@spud>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 23 Feb 2024 15:48:42 +0100
Message-ID: <CANiq72=z+aO2cvmyHNYOVQyAXLiZeM5KV+YrMXAsCkotJFcHag@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] RISC-V: enable building 64-bit kernels with rust support
To: Conor Dooley <conor@kernel.org>
Cc: linux-riscv@lists.infradead.org, Conor Dooley <conor.dooley@microchip.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>, 
	rust-for-linux@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 2:38=E2=80=AFPM Conor Dooley <conor@kernel.org> wro=
te:
>
> As 64-bit RISC-V is now supported, add it to the arch support table,
> taking the opportunity to sort the table in alphabetical order.

Nit: this can be removed now.

Cheers,
Miguel

