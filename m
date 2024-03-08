Return-Path: <linux-kernel+bounces-97519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA0B876B5B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 20:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49BC4B21AAA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 19:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 862DB5B043;
	Fri,  8 Mar 2024 19:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="2tfNfHl4"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B395A55E65
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 19:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709927446; cv=none; b=b5TK/HW9UHQUXVoh80kvV1/8glgvQO+i1XMJQ2VHH3FVqe28nlYNzc/nFVrovtBZ+sjuZUneybJQT2OaYwAH0ASimqb40uuJZ9hbIcov29f48ka97GpbZQyCsWtKWfwJHAEC8XYCKIvIm1mgs6VBaVwaeo0w6cNKhFpIgI/5pYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709927446; c=relaxed/simple;
	bh=F+KDUPH5+mbx7+rMvQIki2u8trXARavLTQ5O4E92Y9o=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=WHQB7ZRONx/pPviYQyQOZzvTzljLh+WCEX5+BK8/Tyu2icxdkGUkeMB9uul14ClxlcN4lYrIdzt9/jd4Xrio+zlhfhr9KC6nLi2oM8zt8E6vThwiShq0ISbuBFWom75qTyqBMWUJhlfLUuoIVnunLOKyMwMmJEBlGvjcEO+h8Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=2tfNfHl4; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-412fc5f5152so18057745e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 11:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1709927443; x=1710532243; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iFx6+m/7JsKqN0XHB4LAwTg+zzCpC/J1O98A2CTIY6I=;
        b=2tfNfHl4ia5rp15QZ3eWMWbZIkPJ7VZfm0C14Gx6vtOeUDlF0PcGc3JF2DaQ5Yfy0Q
         Ydlk8dg/ELH80i1DHU60o3GjdAGOSfD5hDDJD4ComkA422UV/1stmFedpBb3XpEtQ+Qr
         QtrkAssOIuiH/SmcQRLHbRoeUVK1dlal2fBdoeUmXA2WW8QBj09Xa2kFwUBti0rjPw4i
         R16YFV23wf9KVtfT8wkEoe9docWjXhGPXtxJqAdAXvTJ+hNoTBxqta0hpGAJQE746Lzf
         n//BRE/GCqTjgVJaGLagjKfKqA99At5YodgTOkuoq9STj7JXgSvUOplhYqANfekvRFT0
         mwHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709927443; x=1710532243;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iFx6+m/7JsKqN0XHB4LAwTg+zzCpC/J1O98A2CTIY6I=;
        b=XO1SCDfDhFSmrz4VGkXL+dAVzdm53Up1uDR+OI7mFX8nCfZk4ajzSE0WJLVcx5hnfL
         O9aymZz42ID2CtzeJlIKpnhS9m24TR8LyPBMcdLt4wjCWNI0dQXtMx06A3zV+qtovQVM
         HgMOY1Wq+fCSl+Sr/mr2RrZoF4lZyJk/WkOdHuza23UzY7357WhRrS3/H5GOuMEwATQd
         8jy+8IskdVVaaLnruTwNW5+cWYj0sV6MCIswtvp5HlbD3nJtW06CAAehC0FpdGYPHSWV
         bGAOdW468nzpsoh/snIEo4OB2S8x1Ek2j3yqCJeAqOJA1mnnqjBZdyAntcwJgEirTZlf
         rg2A==
X-Forwarded-Encrypted: i=1; AJvYcCWcDn8QvKgGrfOlNRIq844OAbfB1ikkZl/5a9754+3kJHw5Q8eZ4CSzTeoNGQnTZk8nrkMwq8/NNfBysPgMcyyBmWO/1PPHRYS3rGdt
X-Gm-Message-State: AOJu0YyjxR6f3b8PjkdqUUKNWj1FratC5PdD/xR4KTJL9S7iOrBVdLpD
	3LUbwImHrbPHW6yh+HGBJkn9IQLzlGvA3oLSECnNnDWgjya3Z3g9KwybAIKNSiM=
X-Google-Smtp-Source: AGHT+IFgERx2HCRxe0cuz8WcIaaG2WzVA5aMHqLkgE03tEKhn+oudNWefjc02tmdr5H0XIgT49QUrg==
X-Received: by 2002:a05:600c:1c13:b0:412:abfd:2c0e with SMTP id j19-20020a05600c1c1300b00412abfd2c0emr215874wms.41.1709927442706;
        Fri, 08 Mar 2024 11:50:42 -0800 (PST)
Received: from smtpclient.apple ([2001:a61:10c1:8f01:f133:c671:605a:5e9b])
        by smtp.gmail.com with ESMTPSA id f15-20020a05600c4e8f00b00412ea52b102sm6999304wmq.34.2024.03.08.11.50.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Mar 2024 11:50:42 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.400.31\))
Subject: Re: [RESEND PATCH v2] x86/apic: Use u32 instead of unsigned long
From: Thorsten Blum <thorsten.blum@toblux.com>
In-Reply-To: <656ade98-c8aa-42df-8926-d0513e105816@intel.com>
Date: Fri, 8 Mar 2024 20:50:30 +0100
Cc: "David.Laight@aculab.com" <David.Laight@ACULAB.COM>,
 Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 linux-kernel@vger.kernel.org,
 mingo@redhat.com,
 peterz@infradead.org,
 tglx@linutronix.de,
 wei.liu@kernel.org,
 x86@kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <6548057B-015C-4A67-8231-0E63224BF74F@toblux.com>
References: <20240301203901.150465-3-thorsten.blum@toblux.com>
 <20240308124336.41654-2-thorsten.blum@toblux.com>
 <656ade98-c8aa-42df-8926-d0513e105816@intel.com>
To: Dave Hansen <dave.hansen@intel.com>
X-Mailer: Apple Mail (2.3774.400.31)

On Mar 8, 2024, at 17:12, Dave Hansen <dave.hansen@intel.com> wrote:
>=20
> On 3/8/24 04:43, Thorsten Blum wrote:
>> Improve types by using u32 instead of unsigned long. Fixes two
>> Coccinelle/coccicheck warnings reported by do_div.cocci.
>=20
> This seems simple enough, but the changelog and subject are really
> lacking in substantive information.
>=20
> The _patch_ literally does a few s/unsigned long/u32/ operations, and
> that's just repeated pretty much verbatim in the changelog and =
subject.
> So it just tells me two more times what I already know.
>=20
> Without going and running do_div.cocci I can't tell whether the =
warnings
> are good checks or nonsense.  I also don't know _which_ do_div()s the
> warnings even refer to.
>=20
> Could we get a _little_ more meat in here, please?

Yes, of course.

Coccinelle issues the following two warnings:

arch/x86/kernel/apic/apic.c:734:1-7: WARNING: do_div() does a 64-by-32
division, please consider using div64_long instead.

arch/x86/kernel/apic/apic.c:742:2-8: WARNING: do_div() does a 64-by-32
division, please consider using div64_long instead.

These occur because the divisor (deltapm) is of type long and the =
do_div() macro
casts the divisor to uint32_t, which could potentially lead to an =
incorrect
quotient.

Version 1 of my patch replaced both do_div() macro calls with div64_ul()
function calls, thereby removing the Coccinelle warnings. I used =
div64_ul()
instead of div64_long() because I also changed deltapm from long to =
unsigned
long, given that deltapm cannot be negative.

However, David Laight noted that div64_ul() is a 64-by-64 division and=20=

significantly slower (especially on 32-bit machines).

David's feedback led me to trace the source of deltapm, which is
acpi_pm_read_early() in include/linux/acpi_pmtmr.h. Since =
acpi_pm_read_early()
returns a u32 (which is additionally masked to 24 bits), there is no =
reason for
deltapm or any of the other intermediate variables (pm, lapic_cal_pm1, =
and
lapic_cal_pm2) to be of type long or unsigned long. They can all be u32, =
which
more accurately reflects their possible values and which removes both
Coccinelle warnings.

Maybe I'm missing something, but hopefully this clarifies my changes in =
v2.

Thanks,
Thorsten=

