Return-Path: <linux-kernel+bounces-31776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E8028333D3
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 12:19:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E63361F222AD
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 11:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7943DDC1;
	Sat, 20 Jan 2024 11:19:44 +0000 (UTC)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4645E33D3
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 11:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705749584; cv=none; b=Q5hK2r3PNMUg6hLUaZ9qWLd6P9DnTUHZcwh32Qb3yyxPrxnQIbUntD6TO7wO4Xh/QyOq2jdjQ/nxVM4O1idHrb1HslZ+NeXqU0VXy5MpQqKnqdB30duLRpt9dcMxMreMbHXdaPVKkcsMU5zQnS9H3/iqt7DXCEFdLTGuSHSP/q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705749584; c=relaxed/simple;
	bh=Di7n5m4Iea5hjuol2KWrIxHltfJM8dFn7sIk3Kagb3g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N+kfZZ/7JZ3l0ELTSzOafEgOE4XvmI3nXlA9nci9vXlSrbcxTLAQvkfIOJxocDUa31YvUNkYbNs1/kKzO8TnwhkFqerDsixR/aoCdSkKlDPUKWj/9cHVfv6xNbf+fwGhcHd1m3/QA6F2+tUgibouq0rJVAtaB4WVYr5qIWd0dw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dbedb1ee3e4so1425348276.3
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 03:19:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705749582; x=1706354382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vhWi8EKUbj8ACQZ6QR7ZNJXvSvgz6eg2m6MMtOKxnXE=;
        b=Rvv1dK+FckRQnYzn+XTIwJlAGdOuoe+HgHg14Z4MyIgDyzVYEVM/5tDuUd65jlMqwP
         r2IDPgkAqsqiDbE7lBj2+nSA+w/6k/uMuFEVjhwpUFe30F1eIJt1KD/ZG5kEnGmnuZne
         zX3M1KBFURabLyXkNAdVRrHdS3v8DiU4yMftgafLFtHyPgQDgIJl/30pEmpu8Y6q+E3V
         rqyy2bdXnkLi/dx5Pn7ab1VUp7XpbfomwN86R6MGQrkjfJ85kexmbXuMI13dQ2GdDFIQ
         XmcG2zYjBUxBr714WgPnR451BRKPvIql/hHVTEaFlAzLg4cRHQouU18/Snvgu3kQT7wb
         1+IQ==
X-Gm-Message-State: AOJu0Yz6rfWskKRvCK+xQLdS/uDo2a/XR0Tf8a+dQQmk2NcP3zu2WONe
	fKe98uzqJp39EWftpIIevWzViLrrId1cN8zXO86OJNTO+MGuojBeypBQs0J8Gu8=
X-Google-Smtp-Source: AGHT+IEtaILLgiVRvr3CfaCgTxelg6xh32IS58RnCOBSHsqVXb6BYtQ/+mPLwBITQLQBcA4ZI7AnPg==
X-Received: by 2002:a25:ade5:0:b0:dc2:51f8:77a0 with SMTP id d37-20020a25ade5000000b00dc251f877a0mr796451ybe.112.1705749582069;
        Sat, 20 Jan 2024 03:19:42 -0800 (PST)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id h1-20020a25d001000000b00dc22e979d73sm383380ybg.27.2024.01.20.03.19.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Jan 2024 03:19:41 -0800 (PST)
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dbedb1ee3e4so1425323276.3
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 03:19:40 -0800 (PST)
X-Received: by 2002:a81:6509:0:b0:5ff:94ae:78e4 with SMTP id
 z9-20020a816509000000b005ff94ae78e4mr735712ywb.28.1705749580630; Sat, 20 Jan
 2024 03:19:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240119201356.7903-1-ansuelsmth@gmail.com>
In-Reply-To: <20240119201356.7903-1-ansuelsmth@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sat, 20 Jan 2024 12:19:33 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUYLEXVn=R2RFyfxeaSPKcwYxFxM1zcUpbXRFpQHe-WQw@mail.gmail.com>
Message-ID: <CAMuHMdUYLEXVn=R2RFyfxeaSPKcwYxFxM1zcUpbXRFpQHe-WQw@mail.gmail.com>
Subject: Re: [PATCH 0/2] ARM: decompressor: support AUTO_ZRELADDR and appended DTB
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, 
	Andrew Morton <akpm@linux-foundation.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Jonathan Corbet <corbet@lwn.net>, 
	Thomas Gleixner <tglx@linutronix.de>, Randy Dunlap <rdunlap@infradead.org>, 
	"Mike Rapoport (IBM)" <rppt@kernel.org>, Eric DeVolder <eric.devolder@oracle.com>, 
	Nathan Chancellor <nathan@kernel.org>, "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, 
	Kees Cook <keescook@chromium.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@somainline.org>, Linus Walleij <linus.walleij@linaro.org>, 
	John Crispin <john@phrozen.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christian,

On Fri, Jan 19, 2024 at 9:14=E2=80=AFPM Christian Marangi <ansuelsmth@gmail=
com> wrote:
> With this applied and ARM_ATAG_DTB_COMPAT_IGNORE_MEM enabled (more
> info in the related patch) ipq806x can boot right away with AUTO_ZRELADDR
> enabled and a correct memory node defined in DTS.
>
> It's needed to ignore MEM ATAGs as most of the time the values from the
> bootloader are hardcoded and OEM didn't care to actually provide them
> resulting in funny situation where a Netgear R7800 with 512Mb of RAM
> have Uboot passing 1.7GB of RAM with ATAGS.

I guess you still need other values from ATAGS, so building a kernel
without CONFIG_ARM_ATAG_DTB_COMPAT is not an option?

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

