Return-Path: <linux-kernel+bounces-136376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8FE789D35D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 09:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A178B24022
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 07:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88617D096;
	Tue,  9 Apr 2024 07:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mKTruYtj"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289277CF1B;
	Tue,  9 Apr 2024 07:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712648260; cv=none; b=ea+iw+dlwQ48l7B4icVaAcJQ6dXK3A5OdAHgLnIVNK7CCcE4CKLv9V/1bgH+naG0Yq6tMulfjpKqEmcPrG/152rbQPimEDaHu1F7NPhcQaEnFEupvPGDdWHfzrUjsrkH4KIrEkiKBWBLRGESFJhtBa/fBC3ac/L+PBvIhogj+Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712648260; c=relaxed/simple;
	bh=f2v6EemJgH8gUwOG9G1BJvqod8DiK6XZ/DoVV1vkxVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W0PGLSwinLcTM860IC8qI7BucpwDU39zcCRU50OipNT447k85lDjx9fDiWXokMFCbtoxSHBt0eFgFVdvdYdfF3wSD81pUilo6jG1dssXhlyFvWB90hl5dH1sjUGWf0l+djg1GUTD+1jAAxeixSsSOHI5hYpycDKDmxIxxzgyOkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mKTruYtj; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a44f2d894b7so596657766b.1;
        Tue, 09 Apr 2024 00:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712648256; x=1713253056; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oeZX37alwhVBm66iueJmj96zOvfZbQdgLcxSPkunHuE=;
        b=mKTruYtjKsdA1cLDFPYMi8Ps8DLrcs+lpxQ2SFdxpdFIWSiOUhzK87H0oieJ87ncDp
         Ep/2Q48zvt16GeG93fhkMU47NV5//FgCCvkIUtIls3p5tTOaNUMvmiruw8NMuQV+d6Uw
         td+KVPWKPn1j4AGzwdWvWfZZSwt7Qresecp1OIg7BiKPjGIex6Yvdvc35ypAMQ9lBnOD
         P3dLmPar0CP8vsPEuuiu+bl/OV9RvT7XV0rfnW8C8QtNyvXa08XT5kQV7p1FBxGQ7+LE
         urPOcTBVEsxA14/DV6kuJLw8YBTdOqOInhxmx7GvjFLMuB/Wbg7Uuwly6K3Gtt1Jk7YJ
         c2/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712648256; x=1713253056;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oeZX37alwhVBm66iueJmj96zOvfZbQdgLcxSPkunHuE=;
        b=orfM69QqTCXr6w3z787TryyKo2eTpniLMhqIKtrMSBj1kbC6+6dk6tUl9sd2RzcVSU
         wVBn7ptYWQpgK52i62Stj9ZGwhb/CdVY4LJsgSCgsU/tSMIXdeOGBgCfcMp27Hi2ZM0A
         1oouY3KhqBbqT1ounYv4s/omOKtQwKzXq2OaO3+HLQi1uI4Eop4KexKkDbOTw223xuLn
         CLO9aKoYboTvjoYo0Iam8SRgJk4HoSfMH0rPLIPleLOYAXcjJ/gIG+8vqhOcescdy7pk
         Oii4yOkjUwatGC8YCglGZ7FiApzUdZFC8gzeGQAGsu/yC3e7W7cG5jgb3VswcFAo4qWf
         dpUA==
X-Forwarded-Encrypted: i=1; AJvYcCWOGOGomPov9U41uwnS+udIlviQyrDipChmGW20zgDO+kLo8yAoo4T5GSy/iNbrT4IK7+UZoCx/0w3b6a0IM5WjkZFAs9lxB/z61ACYYyLp7+nZBJoLThHu5GKjPEVCl1NV2gHRPDEKAD1mzCFAXQ==
X-Gm-Message-State: AOJu0Yx3UGW2qcLN5Mic0GAfMFsEMkGUaETo4X3y9Q5Mpp5xQ5jiqVT7
	dtnE3WbTYU7CZ26owl8EStDVIEOa2DJ4s6887DFzrJzlOqBMTgSi
X-Google-Smtp-Source: AGHT+IGC9u6AdJJdmgz3Ddo1LVoNSbNdizV6+YvEnSzrTXf8auCvZmdmyCV946q1E5gu6YDtorI07Q==
X-Received: by 2002:a17:906:ae4a:b0:a51:b3cb:cdca with SMTP id lf10-20020a170906ae4a00b00a51b3cbcdcamr6859147ejb.26.1712648255795;
        Tue, 09 Apr 2024 00:37:35 -0700 (PDT)
Received: from gmail.com (1F2EF1A5.nat.pool.telekom.hu. [31.46.241.165])
        by smtp.gmail.com with ESMTPSA id jw20-20020a170906e95400b00a51c5940247sm3368760ejb.213.2024.04.09.00.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 00:37:35 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Tue, 9 Apr 2024 09:37:32 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 1/9] tools/include: Sync uapi/drm/i915_drm.h with the
 kernel sources
Message-ID: <ZhTwPLliHXKPAJUQ@gmail.com>
References: <20240408185520.1550865-1-namhyung@kernel.org>
 <20240408185520.1550865-2-namhyung@kernel.org>
 <874jcb9etk.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874jcb9etk.fsf@intel.com>


* Jani Nikula <jani.nikula@linux.intel.com> wrote:

> On Mon, 08 Apr 2024, Namhyung Kim <namhyung@kernel.org> wrote:
> > To pick up changes from:
> >
> >    b112364867499 ("drm/i915: Add GuC submission interface version query")
> >    5cf0fbf763741 ("drm/i915: Add some boring kerneldoc")
> >
> > This should be used to beautify DRM syscall arguments and it addresses
> > these tools/perf build warnings:
> >
> >   Warning: Kernel ABI header differences:
> >     diff -u tools/include/uapi/drm/i915_drm.h include/uapi/drm/i915_drm.h
> 
> All these years and I never realized there are header copies
> there. But... why copies?

It's better than all the alternatives we tried so far:

 - Symbolic links and direct #includes: this was the original approach but 
   was pushed back on from the kernel side, when tooling modified the 
   headers and broke them accidentally for kernel builds.

 - Duplicate self-defined ABI headers like glibc: double the maintenance 
   burden, double the chance for mistakes, plus there's no tech-driven 
   notification mechanism to look at new kernel side changes.

What we are doing now is a third option:

 - A software-enforced copy-on-write mechanism of kernel headers to 
   tooling, driven by non-fatal warnings on the tooling side build when 
   kernel headers get modified:

    Warning: Kernel ABI header differences:
      diff -u tools/include/uapi/drm/i915_drm.h include/uapi/drm/i915_drm.h
      diff -u tools/include/uapi/linux/fs.h include/uapi/linux/fs.h
      diff -u tools/include/uapi/linux/kvm.h include/uapi/linux/kvm.h
      ...

   The tooling policy is to always pick up the kernel side headers as-is, 
   and integate them into the tooling build. The warnings above serve as a 
   notification to tooling maintainers that there's changes on the kernel 
   side.

We've been using this for many years now, and it might seem hacky, but 
works surprisingly well.

Does this make sense to you?

Thanks,

	Ingo

