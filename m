Return-Path: <linux-kernel+bounces-18763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F8ED8262AC
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 03:28:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 608EFB21CF7
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 02:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6254910A23;
	Sun,  7 Jan 2024 02:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FPIMwMzz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A1010A09;
	Sun,  7 Jan 2024 02:28:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3041EC433D9;
	Sun,  7 Jan 2024 02:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704594515;
	bh=K7ih9bZtybZqziznyQQD1kMoWldlbUm+9ljRnW2YBy8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FPIMwMzzJfuChI3Us/lS3S9+TlrQziTgoSb7/8uQp7jeEhqNzUmW3Xw0XOWBgOGkE
	 hZd4dIsnwL36Glpodhzi1IiDjY1flnZMnNt6DPHWIrCNMh643/QOEXOuEjIaGLfYm7
	 02cBU8M8MQ+FHcLi+VYcVm24iAoCZ/G3V1mxQQvFnvF0mUYn4trlAwqpdQsqHe/dBP
	 qRgxWWFyxmwnhsZeVMrIPeYvfcGS/PtITA0DJ+Ei0LKVyVBFxKygklw2g7pTJi3y0W
	 BJAyPEWhl+PFFBBi4tnoFfVlcjd2fmP+ZIdzoKddGYv0Ns6L5KVSLvnIm9lOF38tQs
	 LQBaqNaG5flcQ==
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5572a9b3420so3029615a12.1;
        Sat, 06 Jan 2024 18:28:35 -0800 (PST)
X-Gm-Message-State: AOJu0YyFqVXdDJvWyJ8oXmZwVk6d5ZIKeqeHTqoQdEWUzvUHHXBEU/Uh
	b/O8gh/XaSGWgQHo4UKsS08BuzB7CXHjyda9a2w=
X-Google-Smtp-Source: AGHT+IF43c6rpnnblMV44I9rcuIsU8WPV8s0sRSdlNkOxDUDA7gEuDgzBXjnRWJAeX/Eqg+KQmVaBlE8Nmyseh8LqjA=
X-Received: by 2002:a17:906:74c3:b0:a27:abac:177f with SMTP id
 z3-20020a17090674c300b00a27abac177fmr1608415ejl.29.1704594513638; Sat, 06 Jan
 2024 18:28:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240106065941.180796-1-wangrui@loongson.cn> <202401070815.6tdJWFme-lkp@intel.com>
In-Reply-To: <202401070815.6tdJWFme-lkp@intel.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sun, 7 Jan 2024 10:28:26 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5WCHsYi8f6AWVC-3RB3dp+vno0hS+tgkB1pqw48W24_Q@mail.gmail.com>
Message-ID: <CAAhV-H5WCHsYi8f6AWVC-3RB3dp+vno0hS+tgkB1pqw48W24_Q@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Enable initial Rust support
To: kernel test robot <lkp@intel.com>
Cc: WANG Rui <wangrui@loongson.cn>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, oe-kbuild-all@lists.linux.dev, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, WANG Xuerui <kernel@xen0n.name>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-doc@vger.kernel.org, loongson-kernel@lists.loongnix.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 7, 2024 at 9:06=E2=80=AFAM kernel test robot <lkp@intel.com> wr=
ote:
>
> Hi WANG,
>
> kernel test robot noticed the following build warnings:
>
> [auto build test WARNING on rust/rust-next]
> [also build test WARNING on linus/master v6.7-rc8 next-20240105]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/WANG-Rui/LoongArch=
-Enable-initial-Rust-support/20240106-150902
> base:   https://github.com/Rust-for-Linux/linux rust-next
> patch link:    https://lore.kernel.org/r/20240106065941.180796-1-wangrui%=
40loongson.cn
> patch subject: [PATCH] LoongArch: Enable initial Rust support
> reproduce: (https://download.01.org/0day-ci/archive/20240107/202401070815=
.6tdJWFme-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202401070815.6tdJWFme-lkp=
@intel.com/
>
> All warnings (new ones prefixed by >>):
>
> >> Documentation/rust/arch-support.rst:18: WARNING: Malformed table.
>
> vim +18 Documentation/rust/arch-support.rst
>
>     14
>     15  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>     16  Architecture  Level of support  Constraints
>     17  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>   > 18  ``loongarch`` Maintained
I think we can put a "none." or just a "-" below "Constraints" to fix
the warning.

Huacai
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
>

