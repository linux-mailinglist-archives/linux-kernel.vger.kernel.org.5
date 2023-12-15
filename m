Return-Path: <linux-kernel+bounces-493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7880E8141EE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 07:48:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 206D01F23AE0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 06:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7080AD282;
	Fri, 15 Dec 2023 06:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jx5Cc55t"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595F9CA6F
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 06:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-20335dcec64so279740fac.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 22:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702622906; x=1703227706; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PmEAkrgNM0PL5WdA7i6ZA6lF8xdUr9x9GVAMkOS4s1w=;
        b=jx5Cc55tgey7C0NN36E0sZ/RDXcIMkmRyug9GiPrYLi7Z4UYiMT/DHvy1CVx7ZReDM
         8HZY1Xw5nsHBPTcEmkpoMXEqPCjfjJkx/EhMsyUmx1yQKTsg6863//t4lf1W+T+77Rg2
         JWI+yO3RXfVD01NN2wIDI5l028tYvt03DTRPxNaasyToxmCJmFVNrp6VaeBi3o7iAfSa
         oEEl1BN9acYITlb/myjP8UinxkhJINn4oJfVb+4uV5MfbPL49aISWZ7chGrIXg3sh8tE
         6LCSela14EHc3/YguvWB/dP0CvvGDcMQ+H8wTlUvtmvFUDiVZ5qTFkGozoG5r8SwN/9G
         O5Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702622906; x=1703227706;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PmEAkrgNM0PL5WdA7i6ZA6lF8xdUr9x9GVAMkOS4s1w=;
        b=BDFVk0e3LpAZuS9GrSvP41lnG/QcsjzX4C5Jq7286aUvmx1box2K/3xRJpfbF2NLjJ
         c/Wqv74+j5tyRVo2LimxM7/3EXO0a4cc8u5CR0RjfaqeoRmL6VyKrLALaqprJawakXJb
         /TDVlUoJzhofAKPYfle5bdzhAYV6UOCMwM6r4Kj+dLHTM/j9x//6aCpu40xlD38no18A
         +xSYO3l53isO+AgzRihf/OLp33E4DYZAMdNnoC6+X4a/dCX41HTn7gFdapjWb9hDUJZn
         45Xr4S9NruaqqxJ37N2HvFtVjLi61eCouPXGBW3AWbxSUPXarb3bM7f6f6OVmBGVQkP3
         AGWQ==
X-Gm-Message-State: AOJu0Yxmcl7KU/5booOwvz5ercfGQmHM9JoDLq/Q+8usKt07xvJrA78e
	dC6ram88VRHJvj57O/ibyeTLIg==
X-Google-Smtp-Source: AGHT+IFF4pgJFftiq7yKmL80+d1+bU6Ppn8xJ+TEx/o2lA/bgMlgVvDWbdcT34R47MQjZdXWfyNI/A==
X-Received: by 2002:a05:6870:514c:b0:203:62ca:abb4 with SMTP id z12-20020a056870514c00b0020362caabb4mr1162582oak.51.1702622906411;
        Thu, 14 Dec 2023 22:48:26 -0800 (PST)
Received: from localhost ([122.172.82.6])
        by smtp.gmail.com with ESMTPSA id y65-20020a636444000000b005b18c53d73csm12449556pgb.16.2023.12.14.22.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 22:48:25 -0800 (PST)
Date: Fri, 15 Dec 2023 12:18:23 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Tiago Lam <tiagolam@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>, Jonathan Corbet <corbet@lwn.net>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	rust-for-linux@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] docs: rust: Clarify that 'rustup override' applies to
 build directory
Message-ID: <20231215064823.ltm55fk4zclsuuwq@vireshk-i7>
References: <e2b943eca92abebbf035447b3569f09a7176c770.1702366951.git.viresh.kumar@linaro.org>
 <1c03eb18-a6ac-45c8-8fea-46097bb4e132@gmail.com>
 <CANiq72=mvca8PXoxwzSao+QFbAHDCecSKCDtV+ffd+YgZNFaww@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72=mvca8PXoxwzSao+QFbAHDCecSKCDtV+ffd+YgZNFaww@mail.gmail.com>

On 14-12-23, 18:22, Miguel Ojeda wrote:
> Something like v1 but a bit simpler, e.g. keeping things as they are,
> but with just a sentence after the command like "If you are building
> the kernel with `O=`, i.e. specifying an output directory, then you
> should append `--path <builddir>`." could work.
> 
> Or we could just provide a `rustupoverride` Make target to do this for
> us [1], since we have all the information needed and would be
> copy-pasteable by everybody. I can send it as a non-mangled patch and
> then Viresh can redo this one on top using it.

How about this ?

diff --git a/Documentation/rust/quick-start.rst b/Documentation/rust/quick-start.rst
index f382914f4191..367b06f3edc2 100644
--- a/Documentation/rust/quick-start.rst
+++ b/Documentation/rust/quick-start.rst
@@ -39,8 +39,17 @@ If ``rustup`` is being used, enter the checked out source code directory
        rustup override set $(scripts/min-tool-version.sh rustc)

 This will configure your working directory to use the correct version of
-``rustc`` without affecting your default toolchain. If you are not using
-``rustup``, fetch a standalone installer from:
+``rustc`` without affecting your default toolchain.
+
+If you are building the kernel with `O=`, i.e. specifying an output
+directory, then you should append `--path <builddir>` to the above
+command.
+
+Alternatively, you can use the ``rustupoverride`` Make target::
+
+       make LLVM=1 O=<builddir> rustupoverride
+
+If you are not using ``rustup``, fetch a standalone installer from:

        https://forge.rust-lang.org/infra/other-installation-methods.html#standalone

-- 
viresh

