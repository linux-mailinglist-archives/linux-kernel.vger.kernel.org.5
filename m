Return-Path: <linux-kernel+bounces-104585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F050787D075
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 16:41:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7CF31F23EA0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 15:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF2F3FB09;
	Fri, 15 Mar 2024 15:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HiCwNKtH"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725FC3F9E1
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 15:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710517277; cv=none; b=m6RDIOAtu7YU4awvEqSR8MhmXMvm5Yd23eYlDCYdeiHBRkkMtbucNDcRJxJH7UyQ+wqFB+A0dSyEnHPglEAaZSaA9nisChwnI0YPpaSPOowYkNpriKUphQRb15Zvz2nMJQI4sQGR7sEnBQ0VVUoTNvXtTztX5Rgqgo1AsG0Ye0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710517277; c=relaxed/simple;
	bh=AmGYu/KmJ+qcj+15+G/YbSuN8IdPg12yQImX0B4+x2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HSfDZyoCUn9vrzvNl9l0HWDZeQwXL36E2cNdCAnVIs+kL2lt9PiFX6OL/pFJrXubiuryJIywSyp4yS/nluUaLFZpZFfHdS6R1pSSr39AMmpGmQy4Ko8YcLl2m2IDI1e6YdlWGlrO8BNadqMS8qhK3Bkbz/HkKHs1MEIM5DfT2hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HiCwNKtH; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-33ec7e1d542so1072914f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 08:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710517274; x=1711122074; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AmGYu/KmJ+qcj+15+G/YbSuN8IdPg12yQImX0B4+x2M=;
        b=HiCwNKtHYTNMB29YO2jdoToJlLiTAypVzOoY8Jv1HmK8RUCXiUfqsJ9NRTV0cZ3ylv
         laSDwfSD/NnnY+lfw3gCsodFrq15B3gBaG63iW6X92OhegpyRILKF0lt5Gh3t6+nyBGv
         SOlx5EMYqapKHP8tQtHeKVj8NI4veLR3Ni0PdFpKdKzEo41z/4JJz/cVjyx99JhsxGR1
         tycLM04ptPGGb1FKAeA6ytwuNHmnCe1mYgeW7/qQ2oBGHLspmqO2RKyXAvuio8YbvYf0
         U2ZiursQzm2Z5NN7BZky/qW/sB5v5ID0Lmt72UnkEJGlgGfmYIqvxUvRXz9O7sntqoej
         QTsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710517274; x=1711122074;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AmGYu/KmJ+qcj+15+G/YbSuN8IdPg12yQImX0B4+x2M=;
        b=oFRJZbIM9lJ+iHTTOG4QlSL+3ETW+8/h0f0fwxOvkFKAnUqfGvRzCIGMyoSBRr05vk
         zuun7qt0dSJZdPyB8hh/LBfAIQF/5ehq7ogRvN39TniLtks9sxhV9Zq3OD6uFG1U8+kt
         K1NuO4T2IgNS0pp8+9oA2WEH5ZjLxlcUOsYB3G2XQ6uCFac1NuZud74ubhRG5+toB662
         O3+WhUGeaXDqtbCAj8RUF+/QoueeV7966rUacc146S6ZFIBF6B4d8Uj+9F2ubSMgARYR
         SpvrYGjhjrbD0aYZferXUJiL+OXnAQwkB4FZIjlt1Ppi1GhhzIaRLz4why73Nj0JYfe1
         tIYA==
X-Gm-Message-State: AOJu0Yy53er+7bXRws6CprLq99Duw71xZCm9YfpffkRedCwslFptXmhG
	9Fe865EArnie4+BZVpnVBvz1gzEWiF4Is+SBLSif8KwOwizXeyW/i66jDE+xw5F1pP+NyNTGPdP
	N8vtkmyInjGbpQRkvWIWUU40eE2iyEqBHDDA=
X-Google-Smtp-Source: AGHT+IH8Q8SSu8IGWZEth02qMiFAjGhXFIIShwADWYh2tfaYycmK/2cKGSYCk49OmkpqY3HMobzNa7Fu6XouPmXN6vI=
X-Received: by 2002:a05:6000:250:b0:33e:1e0e:69a with SMTP id
 m16-20020a056000025000b0033e1e0e069amr3347057wrz.13.1710517273566; Fri, 15
 Mar 2024 08:41:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240315091434.10622-1-dmitrii.bundin.a@gmail.com>
In-Reply-To: <20240315091434.10622-1-dmitrii.bundin.a@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 15 Mar 2024 08:41:02 -0700
Message-ID: <CAADnVQ+o9WQNdY2iApYMN=KnKSxnKGb6NcYzYkDD9V36Di6bCw@mail.gmail.com>
Subject: Re: [PATCH] tools/resolve_btfids: Include linux/types.h
To: Dmitrii Bundin <dmitrii.bundin.a@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Daniel Xu <dxu@dxuuu.xyz>, 
	Viktor Malik <vmalik@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2024 at 2:15=E2=80=AFAM Dmitrii Bundin
<dmitrii.bundin.a@gmail.com> wrote:
>
> When compiling the kernel there's no type definition for u32 within the
> translation unit causing compilation errors of the following format:
>
> btf_ids.h:7:2: error: unknown type name =E2=80=98u32=E2=80=99

What compiler? What setup?
Steps to repro?

No one reported this, though lots of people
are building resolve_btfids that uses this header
as part of the kernel build.

pw-bot: cr

