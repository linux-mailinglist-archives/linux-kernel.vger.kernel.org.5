Return-Path: <linux-kernel+bounces-88397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1EE86E10A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 13:28:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F3FF1C22C71
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 12:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A263E6E60B;
	Fri,  1 Mar 2024 12:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="eo44/2CT"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0A12AEFF
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 12:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709296095; cv=none; b=KaZA8yuEyu/MFUlPcNAqADyPM0K9zCyVa38arbgl/SbonxBfiYkHj9HrLbY5O0ucW62Hg2PJjE3KuzTgKUKA++NMTHROESuyxlb3Tvrby2gN5xBvqxVSxWqWWzFOFwbC2uycAHyINg29xd4mDNfscyn/PF1jvFAxvbNtA3t/P10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709296095; c=relaxed/simple;
	bh=04vMMo6bccK56zwp5r5ELDKqpn4WVBvY558bJjYKRPE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=tQi+tIHMyI5GRodxMj8RvQ2vN/nyvKfGHcy6Q6dXXgxRSusJSkudkwEjisMDTKPbDLjX0hl1tEkAQkmHkCtoGFIQnVFXrbKt9K/7Q1G9mc1ayzwrW2zL/6Cmg8Qb9/nFJ/R2HjiwOrjiQHDhNiUvboC2eAf2+sFm/cv+uxkmjXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=eo44/2CT; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a3f893ad5f4so320905666b.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 04:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1709296092; x=1709900892; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=04vMMo6bccK56zwp5r5ELDKqpn4WVBvY558bJjYKRPE=;
        b=eo44/2CTBgk7D20/GmsUsEDSaGEYi2NC+JlRPM8gmdSu6lbkrXHlxxSUOtDWoOi1/M
         E/Ajur4lPfs9cok+vNtq33N/SUm79b22BKlTBCcb+xhlElRA+EeJbMQFfbUEnzHiuixS
         n3lhynJw1BOTtqGY0XKGMB5QE+FeUTHS8ptoKiloev+fs+pPDBjYCCbfvu9a4KExXdue
         YBHVQIWpxvZj565UnQ13LssmKBHDdusCCNpihk0r0Ua246Oqud1XwcRQZU72hW+Oksd8
         lbau3CT4/rro0CINR9hDbkJpyqvlo6f9qxz1kUEx4z08eprtMjGoJ/8DNVdC2I5j69v7
         wO2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709296092; x=1709900892;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=04vMMo6bccK56zwp5r5ELDKqpn4WVBvY558bJjYKRPE=;
        b=OQFCGffSx0rl3wdlTEKaGDp+4XxH735h2n+/EdlDKJeVeOgd0Vvs68A1TYNb60jyOC
         T1GuC6IVQOAHPTuKohy2Etz4Nfru298s9rM1WDfZ7cA5jqVBHStYv/463e+EjdN6TtzC
         kFOhLTXrn4W7XXELCEVMv7fUMtteubdO2uwlJt9OsryAycB161Sm0j7dipNOF4JRBKA7
         CUM0QJv3OZPirdCTN1YeGB0HRlXBMdrxxKqA2n0V0gaLUKFHE9gr1M8RSgsrP+IUYLjW
         TGxKMgabJ/wk2+agIvYu5GwLPMCbeEhyDy+6ok+lOx6ts17MhhQWB9YggvHJNwTp+dwv
         Fjzg==
X-Forwarded-Encrypted: i=1; AJvYcCWcWfUorrpwWxW8ikQuEy9ADbSee5bEtUCknV7GVGVqzlHiQ4GGWxjNqmEKT205+9h4TU579Gu3BEG3dBr6tEcCzzEZOpu9MmiVGxAj
X-Gm-Message-State: AOJu0Yx9UG7W8Uyp+eVJKbSDBcIcHJVje1TE7Kw7ElCHKLXQax6H0f+f
	S2ZWJJhQXlpKuja251Ef5qKtTy7c56wEIVHtgatiVwyPkv1lzq2ZsKZAykf+3dY=
X-Google-Smtp-Source: AGHT+IHzpOG5EeatqynQN5wVE5IJFA6LTUSu+kmhFT2QlI2R+7IfwwHn0YnseiZJ9thFC6gF11TS3w==
X-Received: by 2002:a17:906:d92f:b0:a43:af0b:ec31 with SMTP id rn15-20020a170906d92f00b00a43af0bec31mr1242565ejb.53.1709296092465;
        Fri, 01 Mar 2024 04:28:12 -0800 (PST)
Received: from smtpclient.apple ([2001:a61:1069:f701:6c1a:d05d:ad7c:b80d])
        by smtp.gmail.com with ESMTPSA id mf24-20020a170906cb9800b00a3e1b4575dfsm1658200ejb.2.2024.03.01.04.28.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Mar 2024 04:28:12 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.400.31\))
Subject: Re: [PATCH] x86/apic: Use div64_ul() instead of do_div()
From: Thorsten Blum <thorsten.blum@toblux.com>
In-Reply-To: <7e46123775e64898bd7c467328125ee0@AcuMS.aculab.com>
Date: Fri, 1 Mar 2024 13:28:00 +0100
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "x86@kernel.org" <x86@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Wei Liu <wei.liu@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <8ECEC999-A742-488F-99B2-A076EF9CA2B2@toblux.com>
References: <20240227114333.1718-2-thorsten.blum@toblux.com>
 <7e46123775e64898bd7c467328125ee0@AcuMS.aculab.com>
To: David Laight <David.Laight@ACULAB.COM>
X-Mailer: Apple Mail (2.3774.400.31)


> On Feb 29, 2024, at 23:13, David Laight <David.Laight@ACULAB.COM> =
wrote:
>=20
> do_div() does a 64 by 32 divide that gives a 32bit quotient.
> div64_ul() does a much more expensive 64 by 64 divide that
> can generate a 64bit quotient.

Since the dividend and the divisor could (according to the types at =
least) both
be 64-bit values and do_div() does a 64-by-32 division, the quotient =
could
potentially be wrong.

However, if the values don't require a 64-by-64 division (not even on a =
64-bit
system) and the divisor (deltapm) is guaranteed to fit into 32 bits, =
wouldn't it
make sense to change its type from long to int?

Given that acpi_pm_read_early() returns a u32 and is then assigned to =
unsigned
long pm, this might be the source of the issue. Changing pm and deltapm =
from
long to u32 and keeping do_div() as is, would improve the types and =
remove the
Coccinelle warnings...but maybe I'm missing something?

Thanks,
Thorsten=

