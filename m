Return-Path: <linux-kernel+bounces-31775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EECE88333CF
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 12:15:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 252C71C21140
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 11:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2120DDA8;
	Sat, 20 Jan 2024 11:15:34 +0000 (UTC)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABE633D4
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 11:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705749334; cv=none; b=jQHi2dxWjrYuwbwuAYrdbPAMeST3sYVlbP1IutCCeYqJXobidl2L+xWJXlr2WYysBZipfxf1uzn4Z9AsMtJdcT7JUNkDzeQ/H7HQQZLxrbUaFiCeKO1jL+mxVRQTHvt61tK+LB1qFXO7CBWQcOebUnJiTZe1oBppT+eKy1i64Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705749334; c=relaxed/simple;
	bh=XQjlJh3YPjfhTke1+yh1TooAYK0zco69C3EhVz1doPY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YwQt/jOcaqAsk8q5dDfTCN2ZL/dndOSig65JDEcXcNFOW7ztbTMMm9YgfBgc7a8NYlZTwL7hK2xXjcPZApBugIN091jLwyF401zuTj04Rk9Dk7nBeCO4qMuamV0lb2CPP5S5UvHo/Cv4ZRojuSgPT2rDhAIn+AhRV2oezUdbAJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-5ff88cbbcceso13612127b3.2
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 03:15:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705749331; x=1706354131;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KJoQIGkAS5zmySYyUkRJUoSLspv6ybxrQAgjWy1nfMk=;
        b=lH2RHptWpZK6lfouuK+FqOfEsG+oPLUDVNL1EMZKRhcporVSZZrvCVTBtB616Cguuy
         9iU39GKdPdBZLn3kJmUrwNldED6TQINmp3WKvWWCxrq7Zn7NCPVliDCuEws1Q/SRjbqi
         iYMDbQP+ONX4Z+fFKPc7fQK42wtpPxMyk7EbCtktr1QknXJpGncOhUDNxf4R89/fFTUT
         KweRET8M6E2DrS4IXtNr1jdLe6fZbM7ZrEGg3RSJ986MZXC8gIhVpCmRzRmrtqjkn3jY
         cPXvWk+dZHcUdwiSdaK+OJoQoWLxgCgLTYgP7Vcsq3rtb/GsLoZwTLjPA5t/qW8Wvt0s
         WkqA==
X-Gm-Message-State: AOJu0YxUset5AI0lp1tN6vb69Wh8QZ+YpSj7qqsOizeL+ejJvHGnSnUv
	HaqsehpNcVx58BIa715b/B1FMT9/DpEVASk7frWge/rm1PxKl0rqhZntEGtfXP8=
X-Google-Smtp-Source: AGHT+IHa9ZNf6p7nLa/0nMxQmI0NN5tK/HRR91bpevct68wzBSOHLkH8gfGcP+NmjGPyjn6DbTug0g==
X-Received: by 2002:a0d:ce44:0:b0:5ff:53a2:b355 with SMTP id q65-20020a0dce44000000b005ff53a2b355mr901401ywd.95.1705749331134;
        Sat, 20 Jan 2024 03:15:31 -0800 (PST)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id x199-20020a81a0d0000000b005ff8950ed82sm1861939ywg.38.2024.01.20.03.15.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Jan 2024 03:15:29 -0800 (PST)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-5f8cf76ef5bso17501827b3.0
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 03:15:29 -0800 (PST)
X-Received: by 2002:a81:6941:0:b0:5ff:4c00:2731 with SMTP id
 e62-20020a816941000000b005ff4c002731mr950040ywc.52.1705749328888; Sat, 20 Jan
 2024 03:15:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240119201356.7903-1-ansuelsmth@gmail.com> <20240119201356.7903-2-ansuelsmth@gmail.com>
In-Reply-To: <20240119201356.7903-2-ansuelsmth@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sat, 20 Jan 2024 12:15:20 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXSetHV9OdbBdf4NYhq7dq4b2Bez=33ZtgULbw5sthBUA@mail.gmail.com>
Message-ID: <CAMuHMdXSetHV9OdbBdf4NYhq7dq4b2Bez=33ZtgULbw5sthBUA@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM: decompressor: support memory start validation
 for appended DTB
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

On Fri, Jan 19, 2024 at 9:14=E2=80=AFPM Christian Marangi <ansuelsmth@gmail=
com> wrote:
> There is currently a problem with a very specific sets of kernel config
> and AUTO_ZRELADDR.
>
> For the most common case AUTO_ZRELADDR check the PC register and
> calculate the start of the physical memory. Then fdt_check_mem_start is
> called to make sure the detected value makes sense by comparing it with
> what is present in DTB in the memory nodes and if additional fixup are
> required with the use of linux,usable-memory-range in the chosen node to
> hardcode usable memory range in case some reserved space needs to be
> addressed. With the help of this function the right address is
> calculated and the kernel correctly decompress and loads.
>
> Things starts to become problematic when in the mix,
> CONFIG_ARM_APPENDED_DTB is used. This is a particular kernel config is
> used when legacy systems doesn't support passing a DTB directly and a
> DTB is appended at the end of the image.
>
> In such case, fdt_check_mem_start is skipped in AUTO_ZRELADDR iteration
> as the appended DTB can be augumented later with ATAGS passed from the
> bootloader (if CONFIG_ARM_ATAG_DTB_COMPAT is enabled).
>
> The main problem and what this patch address is the fact that
> fdt_check_mem_start is never called later when the appended DTB is
> augumented, hence any fixup and validation is not done making AUTO_ZRELAD=
DR
> detection inconsistent and most of the time wrong.
>
> Add support in head.S for this by checking if AUTO_ZRELADDR is enabled
> and calling fdt_check_mem_start with the appended DTB and the augumented
> values permitting legacy device to provide info in DTB instead of
> disabling AUTO_ZRELADDR and hardcoding the physical address offsets.
>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

LGTM, so
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

I plan to give this a try (for regression testing) next week.

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

