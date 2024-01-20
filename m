Return-Path: <linux-kernel+bounces-31852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00FB5833573
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 18:10:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E5C31F2189F
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 17:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6621095C;
	Sat, 20 Jan 2024 17:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TMfhis7Z"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED852101FB
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 17:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705770636; cv=none; b=e/Lj7q5d+uk5bW9URKuQ3YePWhoUi6FNJ8KTgsGJZsNvG0x0J/WBqVfqxNzHA8QU4X6Q5zM2+vVPJz1/TOUsKq+AvQsEyDqkyQsyub1yJrdB/WXhQln7Mo9yssZzcl5MezyaBTkMKxorHMgCBpWRIvTyHcGwn2F8tuLfIFYtg/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705770636; c=relaxed/simple;
	bh=dhTu1lPmk/d3wryyglQE3+tw/NAm8/cH2G/NWH1uYVI=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ei5yIEXd2kT8RDKOujyAAc773ivNnjLTXpFmEmXyPpGW6cBtsWkYolPX2q+2JNPcmemRq7Aq4HzJ4gCCVITXg8gwcGhdkht16toBVn1r1XnY+5jmFUgsEQpDd8gKiTLSUpg3efW0gLWypmBuo9Myd+RKAJ7SOu3KHpkCVpHnva4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TMfhis7Z; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40e80046264so22759655e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 09:10:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705770633; x=1706375433; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oHzZD6vA4UTt8bp14tdBQde2SjW0aXBObq53kcMkZP0=;
        b=TMfhis7ZD6nPfQN0Nr8ApqoaovOKl4BjSsRBaBwLY44uc2leahYCMwYpf8QEIeCHze
         Tf6GDdvkGoyzSdFp6QTjzuZYkahA6Wwqm01tPEUUbA49F1iqVmQS5BV1XTESbF1bH3+y
         PBDlPW2N3w/APesRMoK8taKegi7WNxObKXAoHRvgwrVAwc9xohPgK+Ee//EwlZpbZwqT
         t1pUvRDHFgfSTnpOBS/G+AIXIBWW6J3qGmJDkC/Xnt/0fd8N8H/NgP9uT5Ml65xdrJg3
         4LDojAE3BEujrTTN7Npuwnl6qpR6t0l7l+Hv0H/3J/NdiMl2+gIdBq4w4mwvvQgcSgaQ
         gCrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705770633; x=1706375433;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oHzZD6vA4UTt8bp14tdBQde2SjW0aXBObq53kcMkZP0=;
        b=Hv11rC5cokRhgrj3ov1J3eKSCxMcIxwOZGC1jhtAawetxh52td2wiPShcOcnRxMzde
         1mT5idUU3dmGtB6QGK3TBTDgwOgRC5tsorIuNLfL4/VmMQ3vXs2HTZLJ2Om/lZaAv8jP
         qR7QTDgcWG3+z97dYqp33uR9l+IM/OcnsYhqbfbmqlfr3y6Mq/m4E6GhB0GOwSoO10Z9
         6CqtsgqoaSCm+/vBP7r+NcinN9MIMllULsm8CuPxAapL6eG09XFcl/b/INU8+0jKl6Wk
         /NUjhCDr+G/CQ6k4BuzQVZeMUzuLO2FqoXoDZrHRpZYbor+0TotEXZwDZAu+ZKHYxbRQ
         xuMQ==
X-Gm-Message-State: AOJu0YxtWVPtjK2QskdrpQiIidmx4MaJYXAp5nW/JULK5kHEr97XY68U
	1raBVCuBsbBB/443oTBLNxVwXQymdrEAsi5NKzNat06KJSFyJ9GQ
X-Google-Smtp-Source: AGHT+IEOnu5b6Df0KxjXKJo/jwyq5H+UWDUdwl3jTZs7NHn5JrtG8xEz01Rc5LIFqQ5NpORQATgJig==
X-Received: by 2002:a05:600c:6d3:b0:40d:9369:697f with SMTP id b19-20020a05600c06d300b0040d9369697fmr934869wmn.144.1705770632951;
        Sat, 20 Jan 2024 09:10:32 -0800 (PST)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id g7-20020a7bc4c7000000b0040d5c58c41dsm32237873wmk.24.2024.01.20.09.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jan 2024 09:10:32 -0800 (PST)
Message-ID: <65abfe88.7b0a0220.6a394.c3b2@mx.google.com>
X-Google-Original-Message-ID: <Zav-hUDKspwBfQEk@Ansuel-xps.>
Date: Sat, 20 Jan 2024 18:10:29 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Randy Dunlap <rdunlap@infradead.org>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Eric DeVolder <eric.devolder@oracle.com>,
	Nathan Chancellor <nathan@kernel.org>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Kees Cook <keescook@chromium.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@somainline.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH 0/2] ARM: decompressor: support AUTO_ZRELADDR and
 appended DTB
References: <20240119201356.7903-1-ansuelsmth@gmail.com>
 <CAMuHMdUYLEXVn=R2RFyfxeaSPKcwYxFxM1zcUpbXRFpQHe-WQw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdUYLEXVn=R2RFyfxeaSPKcwYxFxM1zcUpbXRFpQHe-WQw@mail.gmail.com>

On Sat, Jan 20, 2024 at 12:19:33PM +0100, Geert Uytterhoeven wrote:
> Hi Christian,
> 
> On Fri, Jan 19, 2024 at 9:14 PM Christian Marangi <ansuelsmth@gmail.com> wrote:
> > With this applied and ARM_ATAG_DTB_COMPAT_IGNORE_MEM enabled (more
> > info in the related patch) ipq806x can boot right away with AUTO_ZRELADDR
> > enabled and a correct memory node defined in DTS.
> >
> > It's needed to ignore MEM ATAGs as most of the time the values from the
> > bootloader are hardcoded and OEM didn't care to actually provide them
> > resulting in funny situation where a Netgear R7800 with 512Mb of RAM
> > have Uboot passing 1.7GB of RAM with ATAGS.
> 
> I guess you still need other values from ATAGS, so building a kernel
> without CONFIG_ARM_ATAG_DTB_COMPAT is not an option?
>

As I said in the other patch, yes DTB_COMPAT is still needed for
bootargs passed from the bootloader via ATAGs. Sorry for not making this
detail more clear in the cover letter.

-- 
	Ansuel

