Return-Path: <linux-kernel+bounces-30130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE44E8319F8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 14:06:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D35F11C220BA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 13:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86CD25105;
	Thu, 18 Jan 2024 13:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EklE8HKK"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA71250E1;
	Thu, 18 Jan 2024 13:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705583159; cv=none; b=QX5xFp/69J2bKxkjwtObn9IeThI68SZGoFJv9b00K5smZw6yuSzb1MTQTz6i8+GTJ55uvaqLWsAU42ZQC1+nqrCIUax4ratopDN/B3zfx6KaEmbRAjParDsxjn6j98Uul2585JZcsVcP7pWue1+SHWpmBz0VEMJXP4hnLOWneSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705583159; c=relaxed/simple;
	bh=lFrp97aw/AwWDmRW5KGr0dh1PHBj2EJkvqJoRsMVEcw=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:X-Google-Original-Message-ID:Date:From:To:Cc:Subject:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To; b=J7utK+2xprDfor7zD/B4RU5ZfXdOVsswzhnlogW+UHXdtr3rkaLV3E3Ich9sWurcGHlIxbAkv1xzeJ6C5IiSeHrr13N8p1iKSCf9iqbUTmVZBXXlbPIrIcw4Y6EelFp4xoxdy1k53JwGInZvLBzGPkbquXREIphvjEdu1TMBZQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EklE8HKK; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3366ddd1eddso10010550f8f.0;
        Thu, 18 Jan 2024 05:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705583156; x=1706187956; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eAyJWWmqD0cVA+kTNGEGgS4mxc0bZZdSVSyAfOZfI6E=;
        b=EklE8HKKaB49rBOM2FK5nX6h+CcL7KHpRUoPKocgKv+SfP/Vkmh7YNX9D0fYE2vmx1
         6LowV9kZUZvvJt1/MVFsAXS42PdGKF1aiHddgGBAk9luHq3KozbvbKuMQIIMCULfsWJ+
         J94EsjbQfQQox+oqqXQOlaA4ZmX9H6s7dZKXDIbxqQ+mToYz6cnAHz6YBieh6bl6HGRz
         QbSthW/BGsFHmO5RlmSxqcGI5UOCjFGCCYv6WL0FRnK7f96qiiVEKH9dftUd84M7YwtF
         a7C8gBzLq9I+mjNsujF9Bz863S58nFCtLylCL+tAKWNiWUdBwPxuCw9c/oFvbBk+SWfx
         6U4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705583156; x=1706187956;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eAyJWWmqD0cVA+kTNGEGgS4mxc0bZZdSVSyAfOZfI6E=;
        b=WzrT3q5kbu8HvtgLE3w7pWw8Jnccw03Tm66Xe/1gXobmbMG1MfvMR/MWGDk00nWYJf
         H9Y8rVMMQqmVu7qyhK4v4BPCnAQOpyJRSXPHfJbu0E0tLXn8d0HEkRPmT3WyEKG8ydqV
         aNC0GVfpGm+qBljkDt9tu3MvEKY/dx4AEj5+AgCw0DXnheXyCjpTrIbNZ8Eb5mFu1i52
         hAx12Cc6BmmjADkpZsucdI5YHU160nsAb9v/P35BMbGsQLxSVl0bieic3kb9tOe3LX5a
         1F3O8+B2eB1u59i5HALQy8E2MPA6SyZDFVPImz8U6EinSCHS6bXB2fLEgWMbEG6Q2CxA
         BJ3g==
X-Gm-Message-State: AOJu0Yx7ReiTI0ndMk67r6r4GNCbyh5Zfd4RCyMW3rYayEhmmj+jxYy1
	DHaCcxIDjH5Gy/ndj8O+gUE/IzZcYY0yZ0+dDR7CAS2HSsbQuUKl
X-Google-Smtp-Source: AGHT+IFqwaZ+0WnKKEAfX4JvdzkKhCgsYxXZ0tAQS+JUGvMuYde7DrBcJ2kTILPVAIYWFWp+mmGwQQ==
X-Received: by 2002:a5d:630d:0:b0:337:c116:d741 with SMTP id i13-20020a5d630d000000b00337c116d741mr220840wru.255.1705583155464;
        Thu, 18 Jan 2024 05:05:55 -0800 (PST)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id c7-20020a5d4f07000000b00337876596d1sm3983995wru.111.2024.01.18.05.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 05:05:54 -0800 (PST)
Message-ID: <65a92232.5d0a0220.44e3f.f721@mx.google.com>
X-Google-Original-Message-ID: <ZakiMWcKDJ4f1UiF@Ansuel-xps.>
Date: Thu, 18 Jan 2024 14:05:53 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Russell King <linux@armlinux.org.uk>,
	Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@somainline.org>,
	Arnd Bergmann <arnd@arndb.de>, Ard Biesheuvel <ardb@kernel.org>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Nick Hawkins <nick.hawkins@hpe.com>,
	John Crispin <john@phrozen.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] ARM: mach-qcom: fix support for ipq806x
References: <20221021181016.14740-1-ansuelsmth@gmail.com>
 <CACRpkdbfvr1pkVb3XhBZLnmn7vy3XyzavwVjW_VmFKTdh3LABQ@mail.gmail.com>
 <63531543.050a0220.b6bf5.284d@mx.google.com>
 <CACRpkdbOQq9hUT=d1QBDMmgLaJ1wZ=hd44ciMnjFVgpLCnK8Wg@mail.gmail.com>
 <6357240c.170a0220.999b2.23d6@mx.google.com>
 <CACRpkdb4iqazgVerHCPU0VqZKYoB5kJeDSaL+ek67L=2Txem-A@mail.gmail.com>
 <65a7d352.050a0220.ee5cf.f69f@mx.google.com>
 <65a85cf3.df0a0220.9615c.a798@mx.google.com>
 <CACRpkdYNhUxFMOGPx-yrgUji03w0K5fRmVFFWW0MfDH1ZeBnxQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdYNhUxFMOGPx-yrgUji03w0K5fRmVFFWW0MfDH1ZeBnxQ@mail.gmail.com>

On Thu, Jan 18, 2024 at 10:02:37AM +0100, Linus Walleij wrote:
> On Thu, Jan 18, 2024 at 12:04 AM Christian Marangi <ansuelsmth@gmail.com> wrote:
> 
> > Some followup on this... I manage to enable DEBUG_LL and can have debug
> > output from the decompressor...
> 
> Yeah that is helpful!
> 
> > From what I can see fdt_check_mem_start is not called at all...
> >
> > What I'm using with kernel config are:
> > CONFIG_ARM_APPENDED_DTB=y
> > CONFIG_ARM_ATAG_DTB_COMPAT=y
> > And a downstream patch that mangle all the atags and takes only the
> > cmdline one.
> >
> > The load and entry point is:
> > 0x42208000
> >
> > With the current setup I have this (I also added some debug log that
> > print what is actually passed to do decompress
> >
> > DTB:0x42AED270 (0x00008BA7)
> > Uncompressing Linux...
> > 40208000
> > 4220F10C done, booting the kernel.
> >
> > Where 40208000 is the value of output_start and 4220F10C is input_data.
> >
> > And I think this confirm that it's getting loaded in the wrong position
> > actually in reserved memory... But how this is possible??? Hope can
> > someone help me in this since I wasted the entire day with this and
> > didn't manage to make any progress... aside from having fun with the
> > head.S assembly code.
> 
> I have no idea how this happens, but when I boot images I do
> it using fastboot like this:
> 
> fastboot --base 40200000 --cmdline "console=ttyMSM0,115200,n8" boot zImage
> 
> So I definitely hammer it to boot from 0x40200000 (+0x8000).
>

Consider that this is uboot so nothing about fastboot.

Without AUTO_ZRELADDR enabled this is the output from the decompressor.

Starting kernel ...

DTB:0x42B214A0 (0x00008B79)
C:0x422080C0-0x42B2A040->0x4349C600-0x43DBE580
DTB:0x43DB59E0 (0x00008B85)
Uncompressing Linux...
42208000 
434A362C done, booting the kernel.

42208000 input 434A362C output

The DTB location match but I can see the ADDR to the right place and
getting moved to a new location (I assume as it would get overwritten by
itself...)

guess the main problem is

mov	r0, pc (line 279)

With pc veing 0x40200000 instead of 0x42200000

-- 
	Ansuel

