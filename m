Return-Path: <linux-kernel+bounces-5953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5EC819217
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 22:13:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CC8EB233F5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 21:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619FE3B297;
	Tue, 19 Dec 2023 21:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EmG88mQE"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608B83AC01
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 21:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5534abbc637so3678258a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 13:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703020366; x=1703625166; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h7lbvJCDJ1XM7ZPTdVewOcxLLbPIBuDKo8DQQNb5RJs=;
        b=EmG88mQEaVlToJsv8oySfUlCstcuErd2hDiAR3rMOdHzsGTm2u8aFS1xzO0mIJp6uj
         uH+c8/Er86pw5qvvQ1bh8p6iE9/bgt0132tQhWWSVSHyLPHR7/mDHKiNFjHT/jA2dUzP
         3Q2U+AJIPctTpKko6kTxVztEnmC+1PnBPkdqlVN+406VEFmAddt0UhPBa3Af/IVc0lAw
         CCDjUa3vgtwkYajThyE2C+y2BdsgyQi5MZ7x9SDXRSQZXUwYAEoXcTzD0GKoldpRAbu5
         lD9uFjOl8arnTfNkv63FDlBeBQeDxwpDNVqF4WaN+PHCHRoANBe0Z9Ph6oD4uuGi+16L
         oy4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703020366; x=1703625166;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h7lbvJCDJ1XM7ZPTdVewOcxLLbPIBuDKo8DQQNb5RJs=;
        b=aE35BsQHFSyTZ3it2LfZ9svy7dBzoWwHXi4+BmENzbTRv+EmAfVG0cAMFj3inCi0Jr
         6g9tgjZW3wdDDMgiyyfEzTCkHDi91moKXBQhsRGpTi830P/eUchgXnQlyohnsbUPRRvV
         v3E4GFsLfv3Ad4xjGq7Y2plfjMqJBRnBRr+GZ1n2cij9RYcLi43CqZPM3LLNm3GxCoF3
         f9f9bXOaON/WaE3M1v/sCvluHNxn1WZUG7GqOIPAdF6LevDBeNes5Ft/4/QOmV4TF/fb
         w/rZD9nvS++y45/lmJrC344gJ6zfoEHN/1t2t2b5MItnqBiqIOTGfU2W/FJsdQRRm6IZ
         nwxw==
X-Gm-Message-State: AOJu0YwXx3zi5ys7HrDg2lDPJINcSInUi+FVHWIzOgs440C9S+QbeeDt
	5gio4V6lhgDrnyk45pXsZuIcCYgA5kBfrVNt750oAw==
X-Google-Smtp-Source: AGHT+IGx3h05PGeb3Es3OTmJpYxj0l2+kg87lc3hinLRFIMaFFOHpmYvxSRHlQSv9b2PFZtnDZ8q60mGJ1mZ6DK6CzA=
X-Received: by 2002:a50:c209:0:b0:552:85f4:ed39 with SMTP id
 n9-20020a50c209000000b0055285f4ed39mr4588788edf.38.1703020366584; Tue, 19 Dec
 2023 13:12:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231215-llvm-decode-stacktrace-v1-1-201cb86f4879@quicinc.com>
 <CAKwvOdmY=Jysqai3KOYO8+c5idP9JjNGKL2xZn2sDNdj5MjTVA@mail.gmail.com>
 <CAFhGd8qA8Hh63iZPP33Nsxu61OycP7oqT50mDgUO-HFNUWHZxQ@mail.gmail.com> <CAKwvOdmMCmcHVd7+ymKgVUe5uZrSvUYMaD9Fz5GSBtHBMPTnSQ@mail.gmail.com>
In-Reply-To: <CAKwvOdmMCmcHVd7+ymKgVUe5uZrSvUYMaD9Fz5GSBtHBMPTnSQ@mail.gmail.com>
From: Justin Stitt <justinstitt@google.com>
Date: Tue, 19 Dec 2023 13:12:34 -0800
Message-ID: <CAFhGd8q80F8kvigHQ1Njf3=KzPsahjy+oRTS_QRz6E6ujsSU5Q@mail.gmail.com>
Subject: Re: [PATCH] scripts/decode_stacktrace.sh: Use LLVM environment variable
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Elliot Berman <quic_eberman@quicinc.com>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Bill Wendling <morbo@google.com>, Manuel Traut <manut@linutronix.de>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 8:49=E2=80=AFAM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Mon, Dec 18, 2023 at 4:17=E2=80=AFPM Justin Stitt <justinstitt@google.=
com> wrote:
> >
> > Interestingly, I am getting good stack traces on mainline with a
> > LLVM-built kernel -- both with and without that patch.
>
> Probably because:
> 1. you have GNU binutils installed.
> 2. you're not testing .o files from an LTO build (which GNU binutils
> cannot decode).
>

Yes, and yes. Makes sense.

> --
> Thanks,
> ~Nick Desaulniers

Cheers

