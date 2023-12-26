Return-Path: <linux-kernel+bounces-11620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A19681E911
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 19:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF684B218EC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 18:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D49186A;
	Tue, 26 Dec 2023 18:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G5NyIHGj"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E5F1849;
	Tue, 26 Dec 2023 18:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3bbbd4d2b4aso362296b6e.0;
        Tue, 26 Dec 2023 10:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703615702; x=1704220502; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fe6llAStBJM+lU1hroIelESFyF/1TQequyrsL42KNrk=;
        b=G5NyIHGjETXwZyzvsx8xzfb914AemZ/U30SAgfoR/CbTrPO/Gm0/kNuMWCjKZAfePZ
         QgDb21UKBm3V3jsnQB1vKk15JyGCkhGlkLgcZ2CPNR1ViYJangMLBO6xmbowFoz4nIAx
         IgWZ8GF3X2FmPTPhPmJYs+4IJ7kkr15RWs6KyMlAJx3+FuPMABS1BJcG44Xc7SfUMKhA
         mrxzHbuFXRURi7Cr2RXxelt03uVU3sHMhCqy92bah/hxtjEcYVx9jv+Y7RjYXUCUZByE
         HVoP+QQRFEx25u6aLbAgrvjMEbHAdD5VEb7pMDW/7k3UDPjpeKGgvHpRt18VikzzBAgg
         q7Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703615702; x=1704220502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fe6llAStBJM+lU1hroIelESFyF/1TQequyrsL42KNrk=;
        b=Fs6z7VcZm2ki2YPFv8AMAxcQHI53iKyvPAyi06gS0VyY+J6D7b5Oy0LcSolrAKQNsl
         4/Nnr0qcITxnmbWWYJdw8014wWQIAfEPsPtdWdxzJa1kesHcV2T8mBZTWM6tqF3j/gHQ
         y7KVwhtfvCAcM3FfU8UZQbbZMHjQnmX5vSb4sSWajA8XygtpbMXXad5FT0L/E5ka0vUI
         gQNgjWyCoEwcAqDsbshaBDRK8mAzGkwG/EwQeulPIdHjUpvx4fk6UOSORoVOsJPECzY0
         s/E8pgj8dfE5nbm9K0w8fJ+3sT3Jffw81F/rc167Bad5BMQkHxD35w3zqaj8Vh08oZ3N
         4KjQ==
X-Gm-Message-State: AOJu0YzP0Q0LE1lPPpHFaL2tXp2W4vgUmUv/UgTKKB2Zzdgpzf8ll2cI
	1X2e1YL897n24DyY7Z3+bGP3kNUE9bVvgxuslGI=
X-Google-Smtp-Source: AGHT+IEjC5hlnqkV+nRSxayldzoAFGJrlA6lBfARIWvwxPwaD84cZV1GvejDnPIofYh+Rr5Ud+s4fNSr/8mt7Vdxbw4=
X-Received: by 2002:a05:6808:3309:b0:3bb:ac46:8c6 with SMTP id
 ca9-20020a056808330900b003bbac4608c6mr2952343oib.18.1703615701822; Tue, 26
 Dec 2023 10:35:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231226-libstringheader-v6-0-80aa08c7652c@google.com> <20231226-libstringheader-v6-2-80aa08c7652c@google.com>
In-Reply-To: <20231226-libstringheader-v6-2-80aa08c7652c@google.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 26 Dec 2023 20:34:25 +0200
Message-ID: <CAHp75VfXWev7Z-tHRPAuWzaLj7ogiECW2arFc4CdcxUE87Ld0A@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] lib/string: shrink lib/string.i via IWYU
To: Tanzir Hasan <tanzirh@google.com>
Cc: Kees Cook <keescook@chromium.org>, Nick Desaulniers <nnn@google.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Greg KH <gregkh@linuxfoundation.org>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 26, 2023 at 8:00=E2=80=AFPM Tanzir Hasan <tanzirh@google.com> w=
rote:
>
> This diff uses an open source tool include-what-you-use (IWYU) to modify
> the include list, changing indirect includes to direct includes. IWYU is
> implemented using the IWYUScripts github repository which is a tool that
> is currently undergoing development. These changes seek to improve build
> times.
>
> This change to lib/string.c resulted in a preprocessed size of
> lib/string.i from 26371 lines to 5321 lines (-80%) for the x86
> defconfig.

Why did you ignore my tag?


--
With Best Regards,
Andy Shevchenko

