Return-Path: <linux-kernel+bounces-383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F38EB81404D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 03:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF21B282BF4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 02:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A93115CA;
	Fri, 15 Dec 2023 02:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rfz8XoYI"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565FBECD;
	Fri, 15 Dec 2023 02:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3ba14203a34so223159b6e.1;
        Thu, 14 Dec 2023 18:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702609096; x=1703213896; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dEuYNRBlgzXCt6dLMDXZjmgpWHVvzha3MPNxQgSpSX0=;
        b=Rfz8XoYI16chjKa1IghAnlLe5l1x3YJ9KkvIsMbqv/VpQWfS6B2U9OQHiv3panTvIq
         6W3SWW0cIBYaRn5NtcQVNPypx1I7AkULeCfkyhAJZeNgNEQDlgdObTRUEmYKKmnycScq
         EUHcT6hrUrweIq3u67IZzhJo5JSkXdeMVjAdtIk9PnN9AxQX6m9tbOkf9juEgvsuyjLy
         JfmXr/Y6LoH/nEZHVEn134qXvMjUdLex+7a7VVIwZP5N9JTH3A1HL1nVYPYGsA5hiEjB
         r8XtllsuBOoe2gSwxd6h8zkId6ppfAm3fmbvj17QjDqLrkwvymqjNUK+I7s6DFESC+cA
         VOOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702609096; x=1703213896;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dEuYNRBlgzXCt6dLMDXZjmgpWHVvzha3MPNxQgSpSX0=;
        b=HJMvmlf98XHhFFxkOg2vYKGOqQfhT6Co8Vdv9naFTAPmBP2RIdloQ7Si1N5brF0OLU
         8JMcy535eqO7w3YaibvmvE+xDW9g3PfBIPtSbqdQdobgqudoUEvUnwBYuSvt/nq/E6fH
         BcMXjZqhUB7qp7jWjiCbYNtVRxV+gUv/sIhTG4tsjMpTdW9T1UvTawWt6UrG430gK1f+
         PNGM1/9L0YpZ77U/0hLScetp8BezdId6vbU95+7oOJcmP+YLXrypthkYQ9iJ8FgBf2ML
         m0t6EmDUZbaC4dV2iBqhhIjAkbRNLFUBX6EpPypCS2tliYIFTWNzB0DeOyjn/VxnvsYG
         ISGA==
X-Gm-Message-State: AOJu0YzlFWbVlXGJHWjXmi5deZFlMgYRAOzRZets5EGTEpjnqcbhvzG9
	I6WvtTdK+vHta8G8eQQuj0c=
X-Google-Smtp-Source: AGHT+IGda2uOu7tUCWI6/kdPBjVtdx5P6FD+g5ouxNnOF4IFpNT0gSRZmMn/eMLi7lrKD9L6eqauNA==
X-Received: by 2002:a05:6808:eca:b0:3b8:b6f6:4f8e with SMTP id q10-20020a0568080eca00b003b8b6f64f8emr11950143oiv.65.1702609096352;
        Thu, 14 Dec 2023 18:58:16 -0800 (PST)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id i11-20020a170902c94b00b001d359db2370sm3143684pla.152.2023.12.14.18.58.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Dec 2023 18:58:15 -0800 (PST)
Message-ID: <f09fa249-1425-429f-8f16-e95fb2d2cac3@gmail.com>
Date: Thu, 14 Dec 2023 23:58:10 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kbuild: rust: add `rustupoverride` target
Content-Language: en-US
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
From: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20231214222253.116734-1-ojeda@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/14/23 19:22, Miguel Ojeda wrote:
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
> ---
> [...]
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>

