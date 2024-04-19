Return-Path: <linux-kernel+bounces-151558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B342F8AB078
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E9BEB2487C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 14:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6930212D76F;
	Fri, 19 Apr 2024 14:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WErG7uO4"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E42B8063B;
	Fri, 19 Apr 2024 14:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713535986; cv=none; b=N9URmrAYdJ6z+w0awMI6aoPjXidhVPy4bCi/aF6KLSMn0a6lgZKJhtQvkmoUsYNMA7KFnND4Ljl4u5zHNIUmAM47mSDD2ngyFuvzMFENUKIZPjg44Rp8EKQ/GoB0Tzg3GCDlN0KsXVJ1PyaVWfYEOFqiYSYD7opkogzle03PvIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713535986; c=relaxed/simple;
	bh=T+y7+J2wbn+FxsaSDNsiBBdtQp+H6naiE2HcMJYbVmU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mzQlYf33BpgZkXJlN6nVQwXvEfyKKMYRIZtxF81Y0Pka6uijSkTYC+okfTA5927CfqPMHwMAQl3QMxkZE+ufobPEFlRNZ4NL2mP3tedepJ71S7Y2IOFBR566XDRqmzjwPscBvmcMiCwiLClDj4QXDN+QqLLNyjAzt62RnhGCJ6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WErG7uO4; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a51ddc783e3so250409666b.0;
        Fri, 19 Apr 2024 07:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713535983; x=1714140783; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T+y7+J2wbn+FxsaSDNsiBBdtQp+H6naiE2HcMJYbVmU=;
        b=WErG7uO4+1L7iGNI6nvRzREQCNG+T5NLkYMxJseCiYOw2ZmdIU+QEvN9NyIiKVZx7s
         0h3guF2iVvTjruNShJCW1xcBwYXpC6BZToGHlrHSEtbdzx5J/EvwDqu/Z26Vua0TJw7g
         llt6u23X5HxBHy8T5PwtWEvD0iPzh88XM+dwAHn8+0fGEuUjB2p6HR1dCTtcK87ZKbh/
         XlxBHdhr2iwijCJao9nGuW1avRPkTn1xD4WY/JIsg8mZvbEzTEP6fAkdMK+zeda/lDj7
         GRCIJMZU0ADB7LCBTqqh2J2Cr2VsN/z9phLYeLvZrrF/w5vkaRB3H/ca1oXvIAzvXttR
         tUpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713535983; x=1714140783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T+y7+J2wbn+FxsaSDNsiBBdtQp+H6naiE2HcMJYbVmU=;
        b=YObGgs+piIufwC9dlw1issluv14TorfXpfPhXdNx0ywgsHH0B/ZrvmeAWIJXHs9NSX
         l/P2lSJubjD6Nanr2QBc1lwsfaYBH3CbJ/JJzbr/qS0KhNab4xtMjKAEcq3dha8F6DNL
         UmMX8XHhiGyuSJuU8dth+dOVaRjo1/GqqKHixxo7oQPvvp3DzuKo8U5/n0RLNZ4Hc9oH
         h2IsHDRa2+AqDsqvf1XIrjBnsiji3WoGwy+mCekOon+DJVNMKw6z+B0GryD7bW7+wXjF
         ldOfqLRD7FljLjOMnQ5tsEgcUr9VAEhq64cYannVXAe79FF17KtQdHx3/M39HerFMBFo
         xh4A==
X-Forwarded-Encrypted: i=1; AJvYcCVnxTC0JRHBu4JxHz5upAcOEj8BTg2CN/wrwEDZEBBkSJYhbdR/Yvpi0LrpqEVjQshy9n7xSFkq3ljRSq+LuQaOMWTTm+tL+J+NMaI5Hpo2nM5KPQOnJKpiy87HDexD5I1bZQ5ceEacRXBwcoDe
X-Gm-Message-State: AOJu0YzU/AUgJ5UqE1sIsWlgKbe06IKPr9LfecpsHaHW4owOAE/lGfFR
	IBUeNAbouhCNGdgGj0OB+0UDR964mHYe1XvaG1caXYx37JvbfOayyAcNLLYBDl8FFuunMOoZCGp
	zlg0GFaJrc/yZV/PLGMAI1ogeXmQ=
X-Google-Smtp-Source: AGHT+IHnCCWwROMVBVtqAYRi6UAanm1Vi5Fygz5pSV8taOuke9kzytQKAPbDEuSSVxopVcEy9z50yjVWjmM8/NyRyJo=
X-Received: by 2002:a17:906:3bd4:b0:a55:8efa:2129 with SMTP id
 v20-20020a1709063bd400b00a558efa2129mr555147ejf.52.1713535983460; Fri, 19 Apr
 2024 07:13:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240419140017.work.012-kees@kernel.org>
In-Reply-To: <20240419140017.work.012-kees@kernel.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 19 Apr 2024 17:12:26 +0300
Message-ID: <CAHp75VdBLpDLMkLGmtwsCEpDZ+WzC9jxGYo+E9D5cAJP+SkR1Q@mail.gmail.com>
Subject: Re: [PATCH 0/5] string: Merge separate tests into string_kunit.c
To: Kees Cook <keescook@chromium.org>
Cc: Andy Shevchenko <andy@kernel.org>, Ivan Orlov <ivan.orlov0322@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2024 at 5:02=E2=80=AFPM Kees Cook <keescook@chromium.org> w=
rote:
>
> Hi,
>
> We have a few lone function tests (strscpy and strcat) that are better
> collected into the common string_kunit.c test suite. Perform various
> renamings, merge everything, and clean up after them.

All makes sense to me, thanks for doing this!

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

--=20
With Best Regards,
Andy Shevchenko

