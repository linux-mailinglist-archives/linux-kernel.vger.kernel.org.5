Return-Path: <linux-kernel+bounces-64227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85331853C4C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:37:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36C3B1F24116
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 20:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A377A612DD;
	Tue, 13 Feb 2024 20:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="neR61XFx"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF875FDD7
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 20:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707856647; cv=none; b=nIjnbFq2QDuCKgnhcYk7izKPRd5GPjrn910mKXCPyO1Zp7Dpbu+ZGp2xiHX6QzfE++lUSfrnDG/VteLvaOioc5xSuUERugOSnDpEpnikup6ApOYijbhSLLezH50NhsqibdlG9ZI0sXxqWAUOWyX0wKV9BH6SRUjG301VTQExEWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707856647; c=relaxed/simple;
	bh=VRorOrRrHwUnyd7C3zuIEQ0wDQxSEzrfZUP7At+3iIQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K0HwCWSydjpDx00u3mjMJzwuNcwWOCZNY4s8qEO5t9DCF00jsi011yjVLTdccNWRPRo3lFSIhtSv92sdgpKuMkUz1v7wjLn0r63N7gRf9jyZMvlDdQXP7uWb8wfNh2wPxT+4zhSzx9cTw394N62gGml4X1M9y8K8u+miXNIU7LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=neR61XFx; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-db4364ecd6aso4173206276.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 12:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707856644; x=1708461444; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b6UcSSahlv+A2iZdYbarvJ/03s3/9UcPgDdNSrpGp9I=;
        b=neR61XFx9vVEfM0e+exLcvfwIw8wzq28fPpMwKQ0fLYITJr+TvTv/W0E1pTFwGTZWD
         uy/NBNw2bYIncTkK2+oW7ee69uPYlItVrL8xCCQMMw9JLZBtmTrI9DkGwaFQD7LJSmuE
         nDaFwIYLlInbC5LIwliZP/ukoSoEAkDRVTL+WMMigwgrt1DM0oWlc2yXiqCKXETubO3B
         bCK/bBPndQ2Vglr+HjGjMvxDnv0awcw5xV67Kj9hqiRGrxfZRJpqkptq6fl5afsvWo55
         QMANQTYT5drY1naQZgsdKlC1yXXr8db/a17BjfN/Bk2R4hGMK0bMlv72BquMgm2QC8Tg
         N2qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707856644; x=1708461444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b6UcSSahlv+A2iZdYbarvJ/03s3/9UcPgDdNSrpGp9I=;
        b=LFq3Gt4kHOPUUXLI4hlgZNW2SDtTVenic3cZ3XC05aOLXavjmlsyI783fQJR41zr7Z
         tATzqniZDznSqV74W8zBa81cQnmd5Zv9tO7n7pT/+GNzca1p6+MO/Usb3jgv7gme6KWK
         33uGSl4Q4X+Xm5nh2U9PG7U29khrahYTXOZot3R8qNePmLLs2gG3eY3/kKHo3UTynlVh
         GuMr+G6Xotm4r55o90a5pUx8mRZIIDGZ8K0hmAzKDDV3U9ONkLFlZ+hiyKKK8YcakrLC
         FbiO39Z2uC9YDzycQyvkmHllnUaC0A1vbNAWl8f2OYbFfVhrx326vZZ+F6mpJQREEasA
         r/EQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMc/rEN3Hz3WxbXHdmuPDOdP3j04P4OxJsoOP/bJvKLrLs4eRzdesFU9U1YomOdY0W1FIflRr76mBf7hsUzt57eC747CViSXAKoenr
X-Gm-Message-State: AOJu0Yx7l2QbG8ZFP/DZur3sfRmIrclwljKNNnYzQPfBXnnH4idbCOhh
	fwj8DATAOPDBTNDtquBU/YdhB+e3h+VWf9aRdjFqQ7F0M66lCA+xkzAhMJ97zo0St/W5wn9ezdV
	0+BZVF1jzDQ1fNhlrHiXpZ6rhmD8=
X-Google-Smtp-Source: AGHT+IGbBIyZXOV1AimT1jfBQbzVd9NOciEat0xOiKUNMsR3PS2UX0l210eYDJoQLVYDOpviUW5vE/4orzLv0lupGAg=
X-Received: by 2002:a05:6902:4c1:b0:dc6:af04:2e05 with SMTP id
 v1-20020a05690204c100b00dc6af042e05mr208159ybs.7.1707856644542; Tue, 13 Feb
 2024 12:37:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208002841.GA2601476@dev-arch.thelio-3990X>
 <CANiq72=G--5LW-9sg2PscTL863mFVNdnX7LUQX2Xj02qZs4crA@mail.gmail.com>
 <20240212234850.GB3221859@dev-arch.thelio-3990X> <20240213025303.GA4006766@dev-arch.thelio-3990X>
In-Reply-To: <20240213025303.GA4006766@dev-arch.thelio-3990X>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 13 Feb 2024 21:37:13 +0100
Message-ID: <CANiq72npYCD-zKqcXPNOAxnKiUCCXGbFQaGo-8=0-171ni+ncQ@mail.gmail.com>
Subject: Re: Prebuilt LLVM 18.1.0-rc2 uploaded
To: Nathan Chancellor <nathan@kernel.org>
Cc: llvm@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 3:53=E2=80=AFAM Nathan Chancellor <nathan@kernel.or=
g> wrote:
>
> Alright, I reuploaded 18.1.0-rc2 with libclang.so included, please let
> me know if this will work for you going forward.

Thanks Nathan, that was quick!

I tried it, and it worked like a charm. bindgen reports:

    $ bindgen --version --verbose
    bindgen 0.65.1
    Clang: ClangBuiltLinux clang version 18.1.0rc
(https://github.com/llvm/llvm-project.git
c6c86965d967886ca5a2ed8968c949cd42cdd49a)

 And I built next-20240213 for LoongArch kernel with Rust enabled:

    # Linux/loongarch 6.8.0-rc4 Kernel Configuration
    CONFIG_CC_VERSION_TEXT=3D"ClangBuiltLinux clang version 18.1.0rc
(https://github.com/llvm/llvm-project.git
c6c86965d967886ca5a2ed8968c949cd42cdd49a)"
    CONFIG_WERROR=3Dy
    CONFIG_RUST=3Dy
    CONFIG_RUSTC_VERSION_TEXT=3D"rustc 1.75.0 (82e1608df 2023-12-21)"
    CONFIG_BINDGEN_VERSION_TEXT=3D"bindgen 0.65.1"

I also built our rust-next branch for x86_64 and QEMU-boot tested it
with the couple Rust samples:

    [ 0.000000] Linux version 6.8.0-rc1-gf090f0d0eea9
(root@02f0b7650ba6) (ClangBuiltLinux clang version 18.1.0rc
(https://github.com/llvm/llvm-project.git
c6c86965d967886ca5a2ed8968c949cd42cdd49a), ClangBuiltLinux LLD 18.1.0)
#1 SMP PREEMPT_DYNAMIC Tue Feb 13 20:14:57 UTC 2024
    [ 1.788925] rust_minimal: My numbers are [72, 108, 200]

I have hooked it up into my small CI to keep using your toolchain in a
subset of the builds :)

Not sure if you pick tags for this sort of thing, but in case it is useful:

    Tested-by: Miguel Ojeda <ojeda@kernel.org>

Thanks again!

Cheers,
Miguel

