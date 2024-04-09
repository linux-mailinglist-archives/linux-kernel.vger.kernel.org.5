Return-Path: <linux-kernel+bounces-136393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB3489D391
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 09:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54F3A1F22CD4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 07:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2427D3E8;
	Tue,  9 Apr 2024 07:52:21 +0000 (UTC)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB0E7D094
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 07:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712649140; cv=none; b=HdZPmD+DPG07Eh8D9IPn1xNgAlXw9D0ZP3tKgJ3d0wPSn1EobwQeFCU4zb9rPj1sCL9Oozn9cP+MCtWKZRmJwGVt38tVStoR1DlMyNb6iw2qukpzCT+lvbp4knstAJK53npvfeclTmxewGR+BS/Jfw1MWKU6vR5HAQ6xwSPblb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712649140; c=relaxed/simple;
	bh=tja6D2D9zLCp/wwk0kBxodTByQozVcN4WMbhLnavqTA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pIf0fyGTbfej5MB6y7maF3J0w0hds9MZjXzsLIEZwq1/DpsxL8U8hvD0IoRCRKK6zGEBscd6ADIvCIm2gaGT2k48OSyP+/S8v6gBdQx1LqPI7UKoxBsUnzO2RWA0WdAmcghLli+L6Pjw42toELvatjx6wPE1SyX1TIeic+CTvZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-61149e50602so35080537b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 00:52:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712649137; x=1713253937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zGsJLD3MDPYLGbFxf/soiqkNvo17SqwPa+nbihFypWk=;
        b=Oqx2LVEZzCLc/OnCDEG/otjdLJgyuUo2aFwClmcumQR8Hnv899Rki+WOneX2V/xZ6B
         T0EFk7ijlLfiLtnVipL2v71zcQfzwjTMVvblz6vmI/q8nAB09ygaLxpmfRFyeFwPQCgL
         LLR95uXAJxsNE7sjQ8pBnhn8jNP9bIN9vZnp9nupA9IMVUmQVUQRYwAgrE5ZAgynlhGu
         PGTWAoNVP691rsDZus8CStEXKrkxT6PNSK0ydVYBdWfUBp90nrK0121uJuWJPROtr1t0
         Z+6lh3TEY60/E4mLpjohsVatqBGilElHqITbSiWxg6Wt5TIS/axYm4ZkaKjcdZsZQzML
         dAaA==
X-Forwarded-Encrypted: i=1; AJvYcCVRWZchYZWBH+mxs5ohsGRAYUtekVTBM+Hzq/pzHa5OKPSwfKidJa5/F3H8yrJXCaTR/OU/fpGWM0Fk09q2tXzfR6jfbfxqBaYuFM4c
X-Gm-Message-State: AOJu0Yy5PRMPxuxjwhi0I3GjItWsYUcd059IJH+MSb7DFnBwigarYLcv
	7GS/BUUwHg5DDFNW8B2UO1T2T3mdJisLZiWEkpiyfVQrgHvh+XVsYrMUpIKPwx4=
X-Google-Smtp-Source: AGHT+IGdCJyofR+xtphwBbbHc3kcAOayaGIQ1d/brSr0WIxSjxAMGr4QnHJ7khrrymt4m1dLf+8ygg==
X-Received: by 2002:a0d:e886:0:b0:615:1be5:6d33 with SMTP id r128-20020a0de886000000b006151be56d33mr1290432ywe.22.1712649134590;
        Tue, 09 Apr 2024 00:52:14 -0700 (PDT)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id g10-20020a0ddd0a000000b00617bcab1236sm2108211ywe.35.2024.04.09.00.52.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 00:52:14 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-615053a5252so47871537b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 00:52:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWLZ4wPkCGKsSbn9G+b7MbqdQF1YEroTt8LZpIW7b5Sj8ByGllUMIc8WINA89FC6nLDlO74E6FzCWXzJUoI1Dzl1GlMYWoFYhybO+U2
X-Received: by 2002:a25:ad42:0:b0:dcf:ecce:b2da with SMTP id
 l2-20020a25ad42000000b00dcfecceb2damr1188554ybe.19.1712649134048; Tue, 09 Apr
 2024 00:52:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240405144304.1223160-1-arnd@kernel.org>
In-Reply-To: <20240405144304.1223160-1-arnd@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 9 Apr 2024 09:52:01 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUPX+Tx9y3AGFXgVM8G0YkSLgmmNUPCQCX8L9Q_kg5muA@mail.gmail.com>
Message-ID: <CAMuHMdUPX+Tx9y3AGFXgVM8G0YkSLgmmNUPCQCX8L9Q_kg5muA@mail.gmail.com>
Subject: Re: [PATCH] [v3] parport: mfc3: avoid empty-body warning
To: Arnd Bergmann <arnd@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Sudip Mukherjee <sudipm.mukherjee@gmail.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Arnd,

Thanks for your patch!

On Fri, Apr 5, 2024 at 4:43=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wrot=
e:
> From: Arnd Bergmann <arnd@arndb.de>
>
> on m68k builds, the mfc3 driver causes a warning about an empty if() bloc=
k:
>
> drivers/parport/parport_mfc3.c: In function 'control_pc_to_mfc3':
> drivers/parport/parport_mfc3.c:106:37: warning: suggest braces around emp=
ty body in an 'if' statement [-Wempty-body]
>
> Remove it in favor of a simpler comment.
>
> Acked-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
> Link: https://lore.kernel.org/lkml/20230727122448.2479942-1-arnd@kernel.o=
rg/

Why the Link-tag, pointing to v2?

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

For the actual patch:
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

