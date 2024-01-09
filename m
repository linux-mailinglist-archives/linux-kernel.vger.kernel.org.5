Return-Path: <linux-kernel+bounces-21359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B10FD828E27
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 20:49:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BCA41F25C82
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 19:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD0E3D3BE;
	Tue,  9 Jan 2024 19:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="IpCwrxPq"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC253D3AB
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 19:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 1623A3F5A2
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 19:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1704829748;
	bh=eAibZFIHs22Mx4aIchdApbfIV6foLFdsjJkLwLjGmLM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=IpCwrxPq4e7m96XYCUFdnTSgzspqM02kd7gtt/oYZu560M3UrgkIVPQAnr8m6nTo3
	 LuDSpQwRtstFcwzpHipUiM+uN3ggoFnpj4BYo44YjvfJJ0/FZtyV3j686ONJObrY1e
	 YJP+8L3o2D0XEcQmiwe5I23807MKpPXyRQdYEKyDRsMMH1r1lkM86a5ZZKiZkM5bOt
	 9jO4o6N0l6rekH7EX0PoicuQhV/MXEvpGK/BV4HzBfQdjNOKou2M96iV6J2hr5w4d+
	 NwbTFneonH8royGqMEk5TPA2k+khUrYiP9buk2LvCBnURfwjKoOXY3f41xDX0XlrdH
	 8TTCvc5LmSNxQ==
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-336953e0fe7so2245584f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 11:49:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704829747; x=1705434547;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eAibZFIHs22Mx4aIchdApbfIV6foLFdsjJkLwLjGmLM=;
        b=Eda4Z7gB8A8UEO+h86TfqmkSiCYComuqox0MXoDw4ykt6Eaxyf5CIJ+yWiC4LOpmPl
         mQiVp3vgbREnLyS9X/0DMxXhNtlVRzFgg6NSRs/6ZBnU2E7wE0I0y3Qa+CBSG5ZdEREK
         vz+OfL1IfMUc7nthJfjFmuq12phv1w6XKmdFyGVA4LYxCy/iBrZJk4pXfoSAk5/KZ9jZ
         oRIIy/dC09hr7VtGs+pfK6fXeyL9zNgufK1gTeBQO/SfW6qDAixZM4G5GkLlstri4oN9
         kcAuUMxOJx+wwYjNetg7FXVvNzoIUfv2DYNT6IXS2RK2KaIJGjlFTCklV8onvxb2FJEc
         NebQ==
X-Gm-Message-State: AOJu0YzM0fVelqsufhe/zYcGxMErwOitvbtT0VCaLwON8HEXrkoxCNNw
	jQTG1fgw0ozR28gAXOlnnriL3EtEW9ghp+8f0YLVTYXeXiPW0CvjBMhgKqaMCWlOMcsnfn5HUuB
	m5kI8SySvHCwD0lBH/pTwACSV0Y4xIcyYDYtCl5I3Qqa9Y15G7+WoihmJDmSv1knm
X-Received: by 2002:a05:6000:118b:b0:336:7077:c8c4 with SMTP id g11-20020a056000118b00b003367077c8c4mr1005828wrx.139.1704829747650;
        Tue, 09 Jan 2024 11:49:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF+4/5IW/lIlALhg3pYuR+C4FIzc6TXDwm+RT2eQjEfLXuSwfZA9i/vnLcf0OeKkWG4pup75JlFF6rC9V3sbP4=
X-Received: by 2002:a05:6000:118b:b0:336:7077:c8c4 with SMTP id
 g11-20020a056000118b00b003367077c8c4mr1005816wrx.139.1704829747280; Tue, 09
 Jan 2024 11:49:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213134303.2302285-1-dimitri.ledkov@canonical.com>
 <20231213134303.2302285-2-dimitri.ledkov@canonical.com> <ZZu9Nvkp3PdSeLHQ@gmail.com>
 <20240109192447.yhl37mwaw5jdkxjs@treble>
In-Reply-To: <20240109192447.yhl37mwaw5jdkxjs@treble>
From: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
Date: Tue, 9 Jan 2024 19:48:30 +0000
Message-ID: <CADWks+YO7zdFoYfLn+qwD8FyZoU1EfYCq1sghFkrn-nXANYMhw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] objtool: Make objtool check actually fatal upon
 fatal errors
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, peterz@infradead.org, x86@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

On Tue, 9 Jan 2024 at 19:24, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
>
> On Mon, Jan 08, 2024 at 10:15:34AM +0100, Ingo Molnar wrote:
> >
> > * Dimitri John Ledkov <dimitri.ledkov@canonical.com> wrote:
> >
> > > Currently function calls within check() are sensitive to fatal errors
> > > (negative return codes) and abort execution prematurely. However, in
> > > all such cases the check() function still returns 0, and thus
> > > resulting in a successful kernel build.
> > >
> > > The only correct code paths were the ones that escpae the control flow
> > > with `return ret`.
> > >
> > > Make the check() function return `ret` status code, and make all
> > > negative return codes goto that instruction. This makes fatal errors
> > > (not warnings) from various function calls actually fail the
> > > build. E.g. if create_retpoline_sites_sections() fails to create elf
> > > section pair retpoline_sites the tool now exits with an error code.
> > >
> > > Signed-off-by: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
> >
> > So, is this not expected to be the case anymore:
> >
> > >  out:
> > > -   /*
> > > -    *  For now, don't fail the kernel build on fatal warnings.  These
> > > -    *  errors are still fairly common due to the growing matrix of
> > > -    *  supported toolchains and their recent pace of change.
> > > -    */
> > > -   return 0;
> >
> > ?
> >
> > How about making it only fatal if CONFIG_WERROR=y, ie. an analogue to our
> > treatment of compiler warnings?
>
> Objtool has two classes of warnings:
>
> 1) "fatal"
>
>    - allocation failures
>    - CFG recreation failures
>    - annotation parsing errors
>    - other objtool bugs
>
> 2) non-"fatal":
>
>   - missing security features (retpolines, IBT, SLS INT3)
>   - unreachable instructions (note this warning may indicate more
>     serious issues like an incomplete or buggy objtool CFG)
>
> The first class of "warning" is actually an error.  It means objtool
> couldn't reasonably continue, so it exited early.  I'm thinking this
> should always fail the build so it can be reported and fixed ASAP.
>
> We tried doing that before, but ending up reverting it (for raisins).
> We should try again (as per the above patch).
>
> The second class of warning, though it doesn't abort objtool, can still
> be quite serious.  Ignoring it can fail the boot, or can expose the user
> to certain attacks.
>

As a distribution kernel maintainer, my primary motivation was
enforcement of the security features.
Specifically because these security features are config opt-in, and
when one opts into having them, they better be enfoced.
If something fails, well, you cannot claim that one has retpoline, sls
mitigrations enabled.

> My proposal would be to always fail for #1, and to make #2 dependent on
> CONFIG_WERROR.

I worry about bundling unrelated things. I still want to enforce
security relevant features separately from compiler changes.

How are you proposing to deal with toolchain upgrades? A given kernel
might be WERROR clean with gcc-11 and gcc-12 -march=generic, but not
with -march=x86-64-v3 (as recently found) or for example with
clang-snapshot.

Whilst at the same time, the security relevant things should be enforced.

From a distribution maintainer perspective, if a kernel is compiled
with CONFIG_SLS I want to be able to enforce that for both kernel and
dkms builds. I cannot reasonably keep up with toolchain updates and
dkms code quality w.r.t. WERROR beyond what is required for security
sensitive code paths like SLS and RETPOLINE.

>
> Note the latter may be problematic at the moment due to some outstanding
> warnings reported by Arnd and randconfig build bots.  I try to fix those
> when I can, but any help would be appreciated.

I guess we can override CONFIG_WERROR during dkms compilations, but
then i still want to ensofrce OBJTOOL errors.

How abou introducing CONFIG_WERROR_OBJTOOL and make CONFIG_WERROR
select CONFIG_WERROR_OBJTOOL? such that distributions can start to opt
into CONFIG_WERROR_OBJTOOL for production builds, even if they cannot
yet make the jump to CONFIG_WERROR?

-- 
Dimitri

Sent from Ubuntu Pro
https://ubuntu.com/pro

