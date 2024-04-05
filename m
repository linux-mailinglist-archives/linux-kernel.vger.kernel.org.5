Return-Path: <linux-kernel+bounces-132829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA4B0899AE2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 12:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 064541C21FA9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 10:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB4B15FCE7;
	Fri,  5 Apr 2024 10:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iwfZuYcT"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83948537E9;
	Fri,  5 Apr 2024 10:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712313045; cv=none; b=CqysPI5fmZ6IP9MvhkLfESAdmZtsZdN4pMv6HgWxikGSRjEEKngOA7egYkOpNfzzTiowVmyteI6PMdPb9Aek4M41OEVdQ8UF2GfxvaLPp19OGX4N2T3QLy5IKhCmgo5s8xN6fXYgHGajphiosuYtOzUokKkFlKTSyeGsvIbjjRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712313045; c=relaxed/simple;
	bh=MjyZT3uHQHE76lUIF8K+O+k+aMaljvlerxoCcM2gaOQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gPEaDH/fmjycF+1dJ3tUSf6VVkI0uov1iqMusAADx16ubkwvU3pJFSsiBFjPytOWM9DO0wUAfa/TYy2dw2duzA9DvEl1gfcHYdFHXyXF++yaLaXtuQcK659MshrxjfLn5jDIe9fElDUzzggc4cOKcGKmCYZ4a55tQku+27vnYic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iwfZuYcT; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2a485169476so58347a91.1;
        Fri, 05 Apr 2024 03:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712313044; x=1712917844; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MjyZT3uHQHE76lUIF8K+O+k+aMaljvlerxoCcM2gaOQ=;
        b=iwfZuYcTvL7+r6WMnGMkOcA+oJ/5waMYqEjdoifJUP6SGpEJV/yqfYGan6Ei/P+Te6
         X7bM3O02IP9O4X+V684NPS1IgaaOjL9oVRNMRFbFoPwyWq1VDIhZIU0S7XL7e7Fdyg5M
         Q+SFGjfLu5DqiZR/wvgyrEYs33hDfsNcAi+0NVLPF/qpGinnvl47BmyMwxGjF1Qws16Q
         axWxhxImoGY0Kcg51IvjI8zyVmewXI7W9YaBw/d0rlmQVG4NTwQvtDl2kIYQcpGBeuYk
         fgbO9W0/FczU57bpYAKx6+lLQeUs+B3ZZJ2Y+DVhnK6Rt1j0pcFXJcPhrU/gfptJB9//
         vlhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712313044; x=1712917844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MjyZT3uHQHE76lUIF8K+O+k+aMaljvlerxoCcM2gaOQ=;
        b=QKBvX/eUN5/sxEJutzxauuwBR7RMfdRWNsd+XnOZvhJSYPM14FmBf8Cf3vE6h9G8K6
         JPVKazvqMjikF/ZhVqtsk/ZJhusb61JSL1plUlSKz4OMk6Cr2EoUYDTeNK3JWPQH7fCV
         B+zhr7lJ4nylOB6UVHC1cxQaeqzFSlh/yLtGW7a3RGXYg5dGY/TwiaxpGBQQEAXxH+ag
         /i5muD9pUWy1rRVVt28TskcUToLSHYlb4HZ/tlI/6VLVm9Lt219/p+T4fUjfWFhef5L3
         XmCpRm4RUsfZBfwEyAbEOeQZFcf5c/svVmlkbGau/XBdWEuwHB+hnypCbjKR+D1rsj+5
         0jtA==
X-Forwarded-Encrypted: i=1; AJvYcCXKl45RGg6Xon9054EtRIVOEx8DZyl3ARgkeiYFn+rXYeDV805274Wcz60G1VUdk3tKNpkvZT0gzGa9HehlGTtVVr4YVUg+1xxAmvQxd19xf1x+pgEm7DjwzqOjaCS1fKhp7wRno/BTdwpY9afqyrpdjjnYoIRaUWWCXmLCIHtWTOuUyGg=
X-Gm-Message-State: AOJu0YxSxBqGLhQo4UgGpJAE6pq5jMyAP3+ivwpoRy9IlZJeAJ9kECwW
	Im8oLcBQkr7KsFXoFhdEGjTbidhumi1x36wMsiHXytUkVmV7G5POPI4LPSsNY4IDkPpeOxtVscj
	Y+cphRHN0cpk3b16kz9vIhk2J/Mc=
X-Google-Smtp-Source: AGHT+IFYJriAFttp3bClZnkaGaA416ql9G0BWF43cyDOJfJ+9QjQwmRH9HhSoypwCYo/lJU4PVsdV36O4Srk2/lVIwc=
X-Received: by 2002:a17:90a:9ab:b0:2a2:38ee:66f with SMTP id
 40-20020a17090a09ab00b002a238ee066fmr762112pjo.46.1712313043351; Fri, 05 Apr
 2024 03:30:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404-providing-emporium-e652e359c711@spud>
 <20240404153258.GA852748@dev-arch.thelio-3990X> <CANiq72kSfC2j07mAaV591i4kDwejWRYcFTvASgQmNnHVe5ZwCw@mail.gmail.com>
 <CAOcBZOTuqzwQncS8rMUMoOj3zE+FnLxPY6O=4EEaOP2xuFG9Vg@mail.gmail.com>
In-Reply-To: <CAOcBZOTuqzwQncS8rMUMoOj3zE+FnLxPY6O=4EEaOP2xuFG9Vg@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 5 Apr 2024 12:30:01 +0200
Message-ID: <CANiq72ko18KobmSp4x=twYRBT5NZmg80rBUC2_rXkDg=67aMOw@mail.gmail.com>
Subject: Re: [PATCH v3] rust: make mutually exclusive with CFI_CLANG
To: Ramon de C Valle <rcvalle@google.com>
Cc: Nathan Chancellor <nathan@kernel.org>, Conor Dooley <conor@kernel.org>, linux-riscv@lists.infradead.org, 
	Conor Dooley <conor.dooley@microchip.com>, stable@vger.kernel.org, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Sami Tolvanen <samitolvanen@google.com>, 
	Kees Cook <keescook@chromium.org>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 5, 2024 at 12:34=E2=80=AFAM Ramon de C Valle <rcvalle@google.co=
m> wrote:
>
> Sorry about that, I should've done this already. In addition to the link =
you added above, here's a tracking issue for KCFI support for Rust:
> https://github.com/rust-lang/rust/issues/123479

No worries! Thanks for taking the time creating the new tracking issue
-- linked now from our issue #2.

I also linked your update here and noted the benchmarking needs /
regressions report request too.

Cheers,
Miguel

