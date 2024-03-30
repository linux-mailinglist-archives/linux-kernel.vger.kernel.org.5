Return-Path: <linux-kernel+bounces-125796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8DC7892C2F
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 18:43:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 307CD1F22824
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 17:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9C03BBFA;
	Sat, 30 Mar 2024 17:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xmi0e3wt"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C83D1E865
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 17:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711820582; cv=none; b=A0np7UsgXfPTVxczNf77uwGpJH3//dW/d/27ntri/uL1zsKXi5qxbq1EJlpNdIvqd8Ia4rmmpBYrXgnwvx+8Jv+AKnpXtxFYDJmNuIR5iMN/xUShR/HmsK4my4Wx1OZ1a++qwUp5vdXGj/UCVIGEYIYklOfMttqkRvAt6plKIXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711820582; c=relaxed/simple;
	bh=5DmMfqlLxt0CdOZeSLNsDEV2c/AuRyL+E36VOGaJdMc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UaZSQklmhNqVhI9tFWi0d16S61rk6qgAGZOzEqtGDYXpQCdFu1XnoG3GRtMHQ0C4vs7u15nnKVZGSoNBZPZypFJankXg3k32Y6BTqb2YywHfaIwIyVsaaGtbdinCeQ1D7XYd+GLTkuK1zBnSk8WdIOKe3gJV9zYOOvbpLt5gH0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xmi0e3wt; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-432bfaf533eso10327381cf.2
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 10:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711820580; x=1712425380; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5DmMfqlLxt0CdOZeSLNsDEV2c/AuRyL+E36VOGaJdMc=;
        b=Xmi0e3wt+WDGBsyw/Bu9//F5W4ABaP0rzOJrrr5rgwY+E3JHGdEa/qxqbC6UDfP8Q4
         izFscEadem9wH1fZmHgdKkd8QMwF3lrixYWfPwk6J/7cZVKtuDU2+W0kbdHu24JGZ4Vz
         lufWmNd5fr9ERoLPD+dRf0AtJwwpsJOtwBYzwss95PW49T41q4oKSHjZqmGIygXephzv
         eWw5Xvf/Mv1dZRMoydopHiiTTtf+xJSRIHSWKPKQk6bhbenYgd/UFA4ptexSZKBIjmeT
         CgTsB+rxSPAC70IAZ1hbF1kHzzpquQz7AEOA7oUdjz5m1OQbr+kk+IMkHKFFQPZBujSz
         Gy3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711820580; x=1712425380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5DmMfqlLxt0CdOZeSLNsDEV2c/AuRyL+E36VOGaJdMc=;
        b=AKMdgsuWRpe+u9XNhkWXbr6qNVTESnJMEmvTQuUUq24weOHjB89NGTh+eJkHC148qJ
         W64CT9UMXFUbaS8vQmc4YBm5Hs9XvuaW7whws/CcJtKm1hmGa5/k94QzCSuJDz5XITiG
         hh7yXQoMWO3Ic6QLBEOWCpf1F0mJ6P2ZjIxDkc750hkmGeKox61IkQx8q9b86owBdh6j
         +pmRbdkg/06uJeZGR5ILkUQ0ehWsKrKoMTtpYqRFrsX478wTME4RfFbj+jiGqkTRyWFH
         YXBCCceYTF+kjC8Bfxt/CRp3re6RLr9APZm81X4N3e2BbusN9W3Q27s6oHxCqHAxMeZW
         wZqw==
X-Forwarded-Encrypted: i=1; AJvYcCVbZebSAIIGEfuDtceMWCEy9Y52SPJ670b+YPsL1BX3aE+5QG4tgJ8ANlmmlIZ9VB3NcVR7HTBtAGojAwP6AirxOaLfYGWnfolK6UUI
X-Gm-Message-State: AOJu0YyKQ4Iq5JsYVPLPsijWmZ07yoAS4tR6D+PvygqtfhWEDIuwJLir
	CK0HAjvw2NZw5fu+wZRJcf5TP9WooK2JDBAbzKZaQsq0sHxfFylZ6/IklyuvgVsrhSarj5IFVVy
	GPrq5xDYNNuGIWeyCWtHuhul3tBg=
X-Google-Smtp-Source: AGHT+IFrr1zCfB86Db76fe9WYQlOCEF78ty0PRfRhF8x6I6QxGnv26jAL5zHurtUgGZ6AmpIes7q7ODHi0ZFtO3LC1w=
X-Received: by 2002:a05:622a:345:b0:431:7517:cdae with SMTP id
 r5-20020a05622a034500b004317517cdaemr7578617qtw.19.1711820580097; Sat, 30 Mar
 2024 10:43:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFGhKbzev7W4aHwhFPWwMZQEHenVgZUj7=aunFieVqZg3mt14A@mail.gmail.com>
In-Reply-To: <CAFGhKbzev7W4aHwhFPWwMZQEHenVgZUj7=aunFieVqZg3mt14A@mail.gmail.com>
From: Charlemagne Lasse <charlemagnelasse@gmail.com>
Date: Sat, 30 Mar 2024 18:42:48 +0100
Message-ID: <CAFGhKbxMi1R3bmEOwxu0Xs0DD1NusSWe-Q-XQFhKFaFCHDztBw@mail.gmail.com>
Subject: Re: warning: cast removes address space '__percpu' of expression
To: x86@kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	Luc Van Oostenryck <lucvoo@kernel.org>
Cc: Uros Bizjak <ubizjak@gmail.com>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Nadav Amit <namit@vmware.com>, Brian Gerst <brgerst@gmail.com>, 
	Denys Vlasenko <dvlasenk@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Am Sa., 30. M=C3=A4rz 2024 um 00:56 Uhr schrieb Charlemagne Lasse
<charlemagnelasse@gmail.com>:
>
> After switching to linux 6.9-rc1, I get a lot of these errors (when
> compiling with cgcc/sparse):
>
> ./include/linux/netdevice.h:4033:17: warning: cast removes address
> space '__percpu' of expression
>
> This is around code which wasn't changed and which correctly uses the
> per cpu helper. Sparse flags were -Wsparse-all for sparse 0.6.4
> (latest release).
[snip]

This also happens with the newest sparse commit
0196afe16a50c76302921b139d412e82e5be2349

