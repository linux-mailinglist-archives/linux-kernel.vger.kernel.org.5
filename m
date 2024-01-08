Return-Path: <linux-kernel+bounces-19080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF4D0826796
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 05:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F05B1F21A70
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 04:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ACEA4C6E;
	Mon,  8 Jan 2024 04:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ubxMhBMP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671B179CC;
	Mon,  8 Jan 2024 04:23:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B88CC4339A;
	Mon,  8 Jan 2024 04:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704687803;
	bh=ezhgovzwtbl5aiCEBWaqQXNw0GJ0WXozlkT004oAt+A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ubxMhBMPnOZqRKZVnnA/vesq2ON1PZFcLf8aNLxIk45upWt7WYs2+VehvWlrvhBFT
	 rQrBA5nowg9TWohCMQQabmMIg7tG3mK6dZFanG9f8Sl5Jh4QXMdPlFAglLLs+TXe/6
	 6gW76XH0UnswkaYbTFsDHWPoFB1zqUgggVxDcoJA865hWLBsrRrt65yIXYsXxYuWUU
	 tNMeFq03bnxIhYuWqgoCdkJn3FbqfBt3Pmn0475weiIx4liAeXSjDTYZ/E1UeC0a35
	 6pzooZZqXYrZy5f7RcSVrgT8oEhwr/aG/VRFRV3Rp3XAO246BpuGLtJyXudIHE3pqU
	 zEhtCY2/PvtqA==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-556c60c3f9aso1617627a12.3;
        Sun, 07 Jan 2024 20:23:23 -0800 (PST)
X-Gm-Message-State: AOJu0Yz8g8DHEbZjGU94ODn7Z5tz9HLlAhW3JJY0GyVt46tZuqQsFq1E
	FFzD+LoBYOcuBgImkvwbW4bZZRpSyUrikmEr/8Q=
X-Google-Smtp-Source: AGHT+IFJjig79ZB0iC0XLaT/lU6a6r5MpjmqOrkFnO9JTppo6ZB6EaGeD33z/lxS/vPgmS1H4G2RA1/OzbKksuC/dxA=
X-Received: by 2002:a17:907:868e:b0:a29:27ad:8eac with SMTP id
 qa14-20020a170907868e00b00a2927ad8eacmr1673809ejc.6.1704687801631; Sun, 07
 Jan 2024 20:23:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108032117.215171-1-wangrui@loongson.cn>
In-Reply-To: <20240108032117.215171-1-wangrui@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 8 Jan 2024 12:23:10 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7qGSiXZFybw20p4inLVphtucUgcvw4H=JkSAfCRoe-sA@mail.gmail.com>
Message-ID: <CAAhV-H7qGSiXZFybw20p4inLVphtucUgcvw4H=JkSAfCRoe-sA@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] Rust enablement for LoongArch
To: WANG Rui <wangrui@loongson.cn>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, WANG Xuerui <kernel@xen0n.name>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-doc@vger.kernel.org, loongson-kernel@lists.loongnix.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

No need to split patches.

Huacai

On Mon, Jan 8, 2024 at 11:21=E2=80=AFAM WANG Rui <wangrui@loongson.cn> wrot=
e:
>
> Enable Rust support for the LoongArch architecture.
>
> Previous versions:
> v0: https://lore.kernel.org/loongarch/20240106065941.180796-1-wangrui@loo=
ngson.cn/
>
> Changes in v1:
>  - Address htmldocs warning.
>
> WANG Rui (2):
>   Documentation: rust: Add a character to the first column
>   LoongArch: Enable initial Rust support
>
>  Documentation/rust/arch-support.rst | 13 +++++++------
>  arch/loongarch/Kconfig              |  1 +
>  arch/loongarch/Makefile             |  3 +++
>  scripts/generate_rust_target.rs     | 10 ++++++++++
>  4 files changed, 21 insertions(+), 6 deletions(-)
>
> --
> 2.43.0
>

