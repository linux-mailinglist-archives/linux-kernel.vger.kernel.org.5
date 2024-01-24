Return-Path: <linux-kernel+bounces-36296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46DD0839E8B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 03:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F28A11F249AF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 02:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189081854;
	Wed, 24 Jan 2024 02:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BdkngYRS"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED66517CD;
	Wed, 24 Jan 2024 02:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706062125; cv=none; b=Cb1k3BWCxZipCXlT9g/J2ibLIY6lKl8cA9cwIdgvXFCTI0nwjk221qZ2R+NFqOia9Xj0q8Mn9POUiRv42q98PGbe1lFv881T4wPh0r4NKkDPdbJO5bUx2RFRLelDcM5xxZd8sgcxOhB9kUZNnoq9M7dxorFtHyW9yMWYSsi9ImQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706062125; c=relaxed/simple;
	bh=zBiYjjf2q3OfHbD35uOTj08nf+2UUl1vXChsWn5VrNU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rZOKdJ4+HC5V2zPh0EP8PdSER7iwkvcssLYAU7U6zrxaFV23Z06VR4N3tbMfpi2i1LdOU0ydrPofnWantUmJtDhaZ6ree4TA1ai3zdDVtDTyeYEpSvK7aH9PuQwSAD6DtIVTslVZFL4xKTcy85hsHei2UUA4/NzEP98X2cxnSjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BdkngYRS; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-55a035669d5so5886282a12.2;
        Tue, 23 Jan 2024 18:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706062122; x=1706666922; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ym83Povf1qB4v5FV66FjmhcBPTFopuHN0I6c13NU0CE=;
        b=BdkngYRSEJ4io3uSm4guMzBCjDdFnC/5RNf8z6EgCAsugYUw2LB+O9jx+tFHHTp1ch
         JYT+jMYDpSVRFLihA2EilVWs5salqb2tWdtfk/6sOblvCKBqCk0Y20lfIU438+b84e7p
         A9a8IAi74Ng/ZlUg+qMevnYGwQ+FX94+JgaHcAwcmoAQatZgGRxfvzm70Me+YUiXcmkY
         d/z+LRiMYWIdci7Yzz1OIK4W7SiYIw0+5Gzs0leIwmufJUJTVZysedegi6mld9KetWCY
         RDKRkjP6RH+4g6p/0wy9OenDll55zNLREcOAJt4a4Rn1RKSCIBarj+ZZ2+3KXnnyeWYp
         z+Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706062122; x=1706666922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ym83Povf1qB4v5FV66FjmhcBPTFopuHN0I6c13NU0CE=;
        b=TIbJm+nNK5C0ZbIXVOMYSpJpz05KrTk/GCC7rbWt3ZGofHA1OeAQlUkUf+RTwOkhkv
         if7MpAFaYokhV+uI8CvShFISsFMUCED96G8Xr3MddWgbFmTrNKncUJrHvHC/bKi1v9bG
         LP9XXM0xjnL6fYF+fQUhGW2N6mmfC5u5wl3azc6RlK4ZesYVB7jb/73zJ4e7ABkudVCK
         GIjzO8QAJAOJ42r1/QhBAXZg80/us1XpMYZiR0E81C2IvTGAPcriA9dREaL9KRyct08+
         TD5uu8Dt5NLq2jO+4GR9ejetZajkNF9fgisQs9oRDkc8ICLYbC3fUfdpvPl4Nz70oddO
         DYRQ==
X-Gm-Message-State: AOJu0Yxl6ahMPxHKeHMULoi5v8ozcCn67NqGWCGei4AgMewwaF91z+rS
	9aMpXq4TOgBLDNpl8mHSvb85CqwtfQWXgjpE74kRSbgOg992H9goRGlWMw9VeyzO2mUFt66RP/g
	e0Sr2m0kVH/bcD1kPmAz4m6HxU1k=
X-Google-Smtp-Source: AGHT+IFZRgkgmatX2SA3VczEnCF4CxWB+fiZjJyeiUygAXeuyqQ05ihrooCCLc5yhGc/5kQoJXHGwajCZ/VH9hJfRmI=
X-Received: by 2002:aa7:cfda:0:b0:55c:7ab7:d349 with SMTP id
 r26-20020aa7cfda000000b0055c7ab7d349mr1015680edy.3.1706062121970; Tue, 23 Jan
 2024 18:08:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122070859.1394479-2-zegao@tencent.com> <170605662743.1691877.1586103440745721732.b4-ty@kernel.org>
In-Reply-To: <170605662743.1691877.1586103440745721732.b4-ty@kernel.org>
From: Ze Gao <zegao2021@gmail.com>
Date: Wed, 24 Jan 2024 10:08:30 +0800
Message-ID: <CAD8CoPBpkeSFcFv3Fs+0TkafmUY4x3NdtfqPfqei2f246xFYZA@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] perf sched: Fix task state report
To: Namhyung Kim <namhyung@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Ian Rogers <irogers@google.com>, 
	linux-kernel@vger.kernel.org, Ze Gao <zegao@tencent.com>, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 8:38=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Mon, 22 Jan 2024 02:08:55 -0500, Ze Gao wrote:
> > No functional changes introduced in v2, just got v1 rebased onto
> > the tip of perf-tools-next for a clean apply.
> >
>
> Applied to perf-tools-next except for the last refactoring one.
> I'll test it separately.

Awesome!

Thanks,
        -- Ze

> Best regards,
> --
> Namhyung Kim <namhyung@kernel.org>

