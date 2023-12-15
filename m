Return-Path: <linux-kernel+bounces-820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB59E8146A0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 12:18:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2E541C22C5B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 11:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18A13034C;
	Fri, 15 Dec 2023 11:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Av/9e3VM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6557724B4A;
	Fri, 15 Dec 2023 11:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40b5155e154so6127385e9.3;
        Fri, 15 Dec 2023 03:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702638963; x=1703243763; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1tF27Ct5v6tce6o6JnCer2vKNDZ4X+jcuur9cRoSxGk=;
        b=Av/9e3VM0yMiHGt/AjYQqLHRpZB7QkiyNcLx2/KyHbwojXjadRd64CVCJK2guyPkTg
         7vkoiNrGA7SrADE0wUa8/SlJD4SfevN3X2CX0o1LKTX2/KJPqVKkw2aLMKjZzToYZ7yg
         O9aquq+u+4ggcqHiVhbmTnoRMWNiZTlaEfuWWHHjz83WQ8D2flFzslHuHo3Jn8ZPTH1T
         09VoEoCAbI74a6Mw/JFXV8FCT+kkZz636RqGyTkSjKKlrZAT5rDBDJ/lI56/+PjH/8HC
         mxXMYX2ue4Uz5Nm4Z+v1A72z9BO5SjOUmFLGQJw9yFmgdB3XXRLfFLCfYXMQxy08082e
         dBsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702638963; x=1703243763;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1tF27Ct5v6tce6o6JnCer2vKNDZ4X+jcuur9cRoSxGk=;
        b=L1/VilHS+d5YIGaFniUSmZIr0fzX2rxIQ6iWF9fAD9e5S2J95dXmyBacAFuKFsuBTX
         J4ViWJq+Np6EHFC9BdZtLo07aUks3tnvSyWW4SGDUBn8qZ1j1ZPKU+VcOibPXOhlaXqs
         KBJA0dfYBQPm6eIA86fuh/NOShPFwz9alyDncPrpPxB9YClFOk//CY20AIkAcgKNIJ7D
         K5iJHInx/l+Ov8VfMJNywwexI8wKp7Jx9PGL3d2nUxv00bMd1ft4ek0NEIoimIT9KuZ/
         8wQy/eUR7IGlFsfDNQkO7/Vci16ityEpIsMYAKkegWBlR2gABqWfE6au+Zr4jbqg3AAD
         kHuw==
X-Gm-Message-State: AOJu0Yy5rH6+2P7z8cXG6dpCnREjt6ZQGW4QVQhdhg+sZmAeytbQa5oN
	wMy+5uGp9nLgRjA04UssOw==
X-Google-Smtp-Source: AGHT+IFCuPwJgXD4EEADZbIlN/xvhbXNUl/sRTkKJI012vdsN3bVbwt2nXfBaxVUmHzxpw1nDySk2A==
X-Received: by 2002:a7b:c4d0:0:b0:40c:3272:1fea with SMTP id g16-20020a7bc4d0000000b0040c32721feamr5519222wmk.87.1702638963391;
        Fri, 15 Dec 2023 03:16:03 -0800 (PST)
Received: from [192.168.1.148] (224.69.114.89.rev.vodafone.pt. [89.114.69.224])
        by smtp.googlemail.com with ESMTPSA id c17-20020a05600c0a5100b0040b4fca8620sm31500952wmq.37.2023.12.15.03.16.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Dec 2023 03:16:03 -0800 (PST)
Message-ID: <a92a0bff-057a-47aa-b82d-4d13b3a01e01@gmail.com>
Date: Fri, 15 Dec 2023 11:16:01 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kbuild: rust: add `rustupoverride` target
Content-Language: en-GB
To: Miguel Ojeda <ojeda@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>,
 Wedson Almeida Filho <wedsonaf@gmail.com>,
 Alex Gaynor <alex.gaynor@gmail.com>
Cc: Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Nicolas Schier <nicolas@fjasle.eu>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl
 <aliceryhl@google.com>, linux-kbuild@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 patches@lists.linux.dev
References: <20231214222253.116734-1-ojeda@kernel.org>
From: Tiago Lam <tiagolam@gmail.com>
In-Reply-To: <20231214222253.116734-1-ojeda@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14/12/2023 22:22, Miguel Ojeda wrote:
> When setting up the Rust support via `rustup`, one may use an override
> in order to select the right version of the Rust toolchain.
> 
> The current instructions at Documentation/rust/quick-start.rst assume
> one is using an in-tree kernel build (i.e. no `O=`) [1]. We would like
> to provide also the way to do so for `O=` builds, but ideally in a way
> that keeps the one-liner copy-pastable and without duplication [2].
> 
> Thus provide a new Make target, `rustupoverride`, that sets it up for
> the user given their build options/variables.
> 
> Link: https://lore.kernel.org/rust-for-linux/20231207084846.faset66xzuoyvdlg@vireshk-i7/ [1]
> Link: https://lore.kernel.org/rust-for-linux/CANiq72=mvca8PXoxwzSao+QFbAHDCecSKCDtV+ffd+YgZNFaww@mail.gmail.com/ [2]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Tiago Lam <tiagolam@gmail.com>

