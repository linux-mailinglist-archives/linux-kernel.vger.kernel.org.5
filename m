Return-Path: <linux-kernel+bounces-62259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDEA0851DA5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 20:12:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E04B1F2555F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 19:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17AC5482ED;
	Mon, 12 Feb 2024 19:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SxEBtPVz"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE4047772;
	Mon, 12 Feb 2024 19:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707765095; cv=none; b=DL/PbCpFcemY9P5yAiMJHz0R+gEYh3P/AJhNckQ1HijTDZlbKaPvK0fDmVKPh3sLo3oAY1+FzAB5FnWZ5H5w61KIba32LgyxJeExk/oD4t//2hMn+VTYQ9JYw5Jdqk3/XYe/PdLMmUZ94cQ0c3wcALOT1RmhGyuW/Dzr2x6L5jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707765095; c=relaxed/simple;
	bh=uShb6ZcgqhX2ALUmZCWrjlz3y5tvNFOTevE37zcmKJA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=teBwHUCy1A2FC8TUttP83baHtbXqgus1FlPknxq7uyak179qRhIvhLr/cFWIE2u8AqVC86myGYgpA/NXATspZ61fOXjKIr1fhV3K5BscjAGqbGsg/F4jmpKW14nXIEMQpZs7fvTMolOS2K4nSymXdrwc0c4Pxg2LRmGpYzTlCsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SxEBtPVz; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dc236729a2bso102878276.0;
        Mon, 12 Feb 2024 11:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707765093; x=1708369893; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uShb6ZcgqhX2ALUmZCWrjlz3y5tvNFOTevE37zcmKJA=;
        b=SxEBtPVzbSP1DXv65obqVo5hwkeW3UaNUwmtfAiGt7OLXeFRlkUaaaeH8D1lptRvbR
         D4eCbeP9gvtWBn5/Gu5GCCT58nByUKRqKzKaWtcOzYwOVlsCLeoVBzaZaMKvpcZb5ztE
         Dg8JPLuFg0/9f0ryQQjNPYikkrE9TSyuJ2GWiy71NJ/Cp15v0eoIOVl3eKkB0J0XHLso
         cN4KOInEEP/fSRRJGqvkmY7xwnCLmM656LPngGdqmUajj6z1e3iXZf9fE+tlk7e5ZYlx
         3rHg43FxsVLB3CgoeNWhN51Mq2pTs8XnmoIY4xF2vY3oiQgbLnK90VQGv+se0byOZd3z
         WA3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707765093; x=1708369893;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uShb6ZcgqhX2ALUmZCWrjlz3y5tvNFOTevE37zcmKJA=;
        b=iooptvjgsOldMRa9+PNcX2V0iczqt4JtbwUENBQyxsG6tgESN9qXcjiGlrW+wgZFSp
         sCsGk7WvPtuVGTYFzWSPzhwdOfbJ04MgvCAABKB3qwr7W6I1cdwBtVKljQRPEW9aqBHo
         ay0eLECJDLCmXo9anCk49hZVUPORKuaRmqmIKJo/9RtEh/NOG62sHNyKLAVqdeXFynpQ
         /k5vE0IGG6sDogTB0f+I7KP+arB1stv2q6CckP3oPoPRj0AOSiSD8sgCUGbtwxdI8MQH
         vnBRGUcTGauy1yXr1RDUVJbXTArS1qotDY+IsSvxaIJBUNTd53C/4NxMR6CCIP2VBOa4
         p+Iw==
X-Forwarded-Encrypted: i=1; AJvYcCWBAVKijnygfGrhEUr/62YztSy8iXptrIoy1MO8YrHQRVZ/oWGLGKB74k5PvV7KSIHdOWNOLyWwn8/km79Bc0qcT5rupMO5XAhsd+XuUO+3Fv4iZ4OurQoDaWizJUDDMHNLgSBK/NVuBULEHY48VdMZJS6ZtqaKHTH9sxQdhqkhlEAlq2p8QIg=
X-Gm-Message-State: AOJu0YwG23NqzJf7pXc8QwCFEylnDvcp0/7XogimcHFtytBF8datB6Xu
	1d/AHTw1fzA2fMMvvxDX+W/4Ktr5bzjHs9+TpNzpndc0PJVgSMO14Zu85c1070TWuUGJl0d95Si
	9MEcuFfVijxdrjFHiI3vfcL6B5Vy0g4a3imY=
X-Google-Smtp-Source: AGHT+IHqXLnUCxAsb7XvKnFAPSGDB3hUHETodqtr+uDm3QdrNT5WCj6II1sL9VaSLYPlv+uufOR+eCV6bruG7EgGquo=
X-Received: by 2002:a05:6902:4e6:b0:dc7:4758:7802 with SMTP id
 w6-20020a05690204e600b00dc747587802mr6000531ybs.48.1707765092762; Mon, 12 Feb
 2024 11:11:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117-swiftly-parasail-618d62972d6e@spud> <CANiq72mVKCOAuK4Qe+8AHmpkFwyJsVfx8AqB7ccGi3DYpSSWcw@mail.gmail.com>
 <20240118-implode-delirium-eefdd86e170e@spud> <CANiq72nx1s_nyvPW86jL7eiOxROr18LfOJqNtw8L42CP+gkhRg@mail.gmail.com>
 <20240125-bucked-payroll-47f82077b262@wendy> <CANiq72k7n0aZrifRRU08N8qLkNe+2EZwijZy5sM7M56n2xYHgQ@mail.gmail.com>
 <20240125-lazy-thrower-744aacc6632a@wendy> <CANiq72kb+_utZrYHtoKZQtQazikmkjpVUHpTBcaANizduMF5QQ@mail.gmail.com>
 <20240126-eccentric-jaywalker-3560e2151a92@spud> <CANiq72nu2NXUWYanHZd5EXgX4P_v673EWn6SCRW60Es9naraQQ@mail.gmail.com>
 <20240209-rage-keg-1b2982cd17d9@spud> <CALNs47sRqAbE=u3=_ciO2oge7Afz-6GBBhW+BwcLRET-TsuxTg@mail.gmail.com>
 <CAOcBZORDaHHH3jTL3GO7OsDubhhyQE0Uy2uAjJpiRzrKBgqaOw@mail.gmail.com>
In-Reply-To: <CAOcBZORDaHHH3jTL3GO7OsDubhhyQE0Uy2uAjJpiRzrKBgqaOw@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 12 Feb 2024 20:11:21 +0100
Message-ID: <CANiq72=VBFvB9O9c84YxpBBftpfNnnXx-+Xes0h8h6rN3EN5pA@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] RISC-V: enable rust
To: Ramon de C Valle <rcvalle@google.com>
Cc: Trevor Gross <tmgross@umich.edu>, Conor Dooley <conor@kernel.org>, 
	Conor Dooley <conor.dooley@microchip.com>, linux-riscv@lists.infradead.org, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>, 
	rust-for-linux@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	Matthew Maurer <mmaurer@google.com>, Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 8:02=E2=80=AFPM Ramon de C Valle <rcvalle@google.co=
m> wrote:
>
> Sorry for the late reply. Sami might be the best person to answer this, b=
ut KCFI (not CFI) tests are lowered by passes that are architecture specifi=
c (see https://reviews.llvm.org/D119296), so we'd need to add support for R=
ISC-V. There is no additional work required in the Rust compiler besides en=
abling it for the new target.

Thanks a lot Ramon!

Then for RISC-V let's go for the `depends on` for the moment, and we
can remove when the support lands for RISC-V (ideally when someone has
managed to boot it at least under some configuration).

Cheers,
Miguel

