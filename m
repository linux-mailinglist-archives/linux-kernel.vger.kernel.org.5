Return-Path: <linux-kernel+bounces-147547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 843C38A7613
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 23:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 189161F22BBD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 21:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598C85A106;
	Tue, 16 Apr 2024 21:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DV2gZ5qW"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F36E44C6B;
	Tue, 16 Apr 2024 21:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713301477; cv=none; b=pjgwYdtEneBRzxMwQQ1NszQo9TRTShBrwx8/0jEmIWayL98a2ClLLHEwGGvF0kH9kNXj7/c0bLEByhAxlA/5SwQHuTI7u7LJU6KoUff4ZmHWApDpntJdWe0niXYAXSQmBHnEfRlO0r0cBGuBYHvPJsxqY8rCphVWwfntH5emrro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713301477; c=relaxed/simple;
	bh=N9qE6JgV6fYnyVb+pQl76YXT2IELRhILEDrXUvW1SO4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WLPvWg45SoRkUVmDIgFMJQ/gd2lATKl8sJPdOwnmn9aGSCCvdKPA9gcJ8Igq9iZ8fhJvgbq5CESLs9rLaWziI/XIWIjBF4KRy/HYwPHJc8684jPQQmb4tZCgzeXqxKjCseSLNpf8CM/s3jv/1N/n2GyFJyiT+4w0Kd1UWha4XBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DV2gZ5qW; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6edb76d83d0so4469158b3a.0;
        Tue, 16 Apr 2024 14:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713301476; x=1713906276; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W3DFIF9J4IlfEcwvIp7AKlf9Ly/QtvztUm7AJm8wPds=;
        b=DV2gZ5qWjyXsPPEa4mCi2vkHoRuMyvFtnN+iAm9t3XhGDVKp4Sj6lPacRDTbjgcg6l
         DXitqGvrffai0kWGhhFPFhUlu1cb36bp5Stectqfaa75RlQQK/ks/qvwgFgjUtYcAp7Y
         qYMeMrWfR2761BK5Oes5VNFIzeAxl3Nwxf+rH+SPpivaTqh8+zn6UdViXtkXrDC9bXGW
         mlagjEBw5MfnyhBHwBK5WLh+QwC5vtTfG3XSYW+6lOSu0etXWoBdXwUxXaopAwn7tiv8
         cdMjJHTu3aUw7HmqY7PSQMwPDEaMQTpnbLTv4qYDco3aIyyyX/iEcncPUii43ySocy+9
         Zg1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713301476; x=1713906276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W3DFIF9J4IlfEcwvIp7AKlf9Ly/QtvztUm7AJm8wPds=;
        b=VEM0y0DyYdNYNVi+eDgNZ1zEvZMS1bM56VeZe3s4Q2xB//wR51iwCdpl/uUiQpVzTp
         xRMyax7ilB3ApfURNNhtElJlH0N5An8/OUvyEqfMVMbDz1OPYq7NCNm6ypph1SXWTJvK
         ixkOvXXdEgsBkSbREg8vICMGP/HOGBDrJT685adpv3p3vNoDzlfTYLvhlQP+xaX9Iqdy
         Ty6fV62l65k5pPUfa7w69EG4wTI+1gkiclgW+lWKQzpAa1xre1s0GhGUtGdoAB7e+Bpc
         YvXBL1pjW8V2GQaJ5rpvVy7DKB0IlEefoIqmmLoqmwFaDxLOE+EDgLMDUFsHaTYqmnH9
         htsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTkkUEbPgcK8zLwIag9yBH6YVzivfhJvh4Eob1fOTJ/SW/r/Qu4mmwsFwnG6Havk/v9q56eNfAhmYLHj2GW5o8Y92yO9n1/VFa1z5T
X-Gm-Message-State: AOJu0Yw5AV7+W/s1ZGU5fGkEtyOKLtivlxtY7dA+GcmtpvSgACmGU6W9
	UgP30ypSTf/wfLJxNZ3tv1HaYPIf5XMfUGr8RSlzJAo4yA8kckLS7B5sHd+NfnTWyMKk6NeyTyp
	O9gBD8U5meLRGhRU301494H8n+9zPbOZ3MYk=
X-Google-Smtp-Source: AGHT+IFnpvZjwCkWjtauwG9vAXFhLTFxYjS5vEHbXTVtTyqiuAqErbGDYlngGUrdD0INSqPnD3v+cgRLHFvY5JHsuMA=
X-Received: by 2002:a05:6a21:3e0a:b0:1a7:a478:d5e0 with SMTP id
 bk10-20020a056a213e0a00b001a7a478d5e0mr15746684pzc.12.1713301475678; Tue, 16
 Apr 2024 14:04:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240328013603.206764-1-wedsonaf@gmail.com>
In-Reply-To: <20240328013603.206764-1-wedsonaf@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 16 Apr 2024 23:03:37 +0200
Message-ID: <CANiq72k=x_P1adyVV+9t_g9fzRznaoO8+kqsYDsunuvZjrUX8g@mail.gmail.com>
Subject: Re: [PATCH v3 00/10] Allocation APIs
To: Wedson Almeida Filho <wedsonaf@gmail.com>
Cc: rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, linux-kernel@vger.kernel.org, 
	Wedson Almeida Filho <walmeida@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 2:36=E2=80=AFAM Wedson Almeida Filho <wedsonaf@gmai=
l.com> wrote:
>
> From: Wedson Almeida Filho <walmeida@microsoft.com>
>
> Revamp how we use the `alloc` crate.
>
> We currently have a fork of the crate with changes to `Vec`; other
> changes have been upstreamed (to the Rust project). This series removes
> the fork and exposes all the functionality as extension traits.
>
> Additionally, it also introduces allocation flag parameters to all
> functions that may result in allocations (e.g., `Box::new`, `Arc::new`,
> `Vec::push`, etc.) without the `try_` prefix -- the names are available
> because we build `alloc` with `no_global_oom_handling`.
>
> Lastly, the series also removes our reliance on the `allocator_api`
> unstable feature.
>
> Long term, we still want to make such functionality available in
> upstream Rust, but this allows us to make progress now and reduces our
> maintainance burden.
>
> In summary:
> 1. Removes `alloc` fork
> 2. Removes use of `allocator_api` unstable feature
> 3. Introduces flags (e.g., GFP_KERNEL, GFP_ATOMIC) when allocating

Applied to `rust-next` -- thanks everyone!

    [ Used `Box::write()` to avoid one `unsafe` block as suggested by Boqun=
 ]

Cheers,
Miguel

