Return-Path: <linux-kernel+bounces-107949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C248803EB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 18:52:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 968EEB24154
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11FFFC11;
	Tue, 19 Mar 2024 17:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Yb0Yt7i4"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC892C183
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 17:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710870743; cv=none; b=lWXS3RZ1jXQvsoT8WVXEKH9BjLkA8dIl+V0Ajd0SigRoRRgGh3EUiUGR9Vuh11ER6gSoePbM7moehuUWQy6oXejO99RIpPcS3mPeqSsuX7ITneVf2VVg/W/KQOlPiJmOOHxTPyUjrzPHDfrHIT3n2bxjzEX4+4PchDf+ttaGXfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710870743; c=relaxed/simple;
	bh=/pA34yoKPuJnozUaZdll/pdd0Gh+2G414uWIjd3Nv+w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qW+Mh1cRHyp/83GkuSynw6ZN5QVb+c1Y0upaAMVcw/vhuPz0SzMdmKr6D3TlpF7/6ZFms+ofk4l1wxowWdMxRurxo5t/Wb8j3zCn+H76NRXzwHefQ1pRGdpTXSPOc4KlECB5MbT+Bg+r3x6LiSc/07W0N460KYOYM1QC30XopNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Yb0Yt7i4; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-56a0c0a7ebcso3194911a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 10:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1710870739; x=1711475539; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jsDdhGB1s86A5H2uDtk1GYBCObHAe8Bc+RYw8C3RVzY=;
        b=Yb0Yt7i4otq301JYzEqvON8bmS1ZG6HclZQEwwHY5jF2Rt/9ryolUhHhN38haWkL+h
         EKbb5jRCvH0QDJzbRxMDvPZlkPVCUfr46hC1l+dZYKEZTZ5if9S8QVPb1/V9iP63Wi2h
         Bx6nyfmHrRq32T0CvUKknMaDWB2rGQPcnGygc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710870739; x=1711475539;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jsDdhGB1s86A5H2uDtk1GYBCObHAe8Bc+RYw8C3RVzY=;
        b=lGrx3WrOsU0u58FXCzfY9aW75u0wrlCCfg7XnMdOTgMUaWfL6mEiZSBKiQas/oWYDs
         +PH9ZHyrgV8GP9JL0Wmpm7n7BAbVVfn65FYm11HoxI6uq5wM4oqdIbiuGcXRmbnkfU1A
         BDrbrI1hsDkcK+jakB//7B92D4OMcnxzRQTWsLATlW988A/CH8rIYq9hm0lCIKVlXfvA
         3Z90iG8GWXadj/JDiaa21bpQvs7b7Nw8B585wSPfjm/hTwroxZ2ubkxQxGOPHpDnD6ff
         KdAeskILO0xNbMP9n5jAQ6UqpJeHpboDnuFgoDFXXY687P1TKclnO4QwhmashxPUOJmn
         1g7w==
X-Forwarded-Encrypted: i=1; AJvYcCVcGYoOsGJ2k3EhXmudW6iKrOVtxcVlcuoG9QnVSj19FiUna2LtRKyyHvcb9k05oHshIikZKbyjgQBIZe1EXajIDdxnBK1PLqvfi4Ez
X-Gm-Message-State: AOJu0YwgrBYY2xnCJuG8oDgvG8ol2BWxNWshfWdWFe55WmKyJQ0gqkZ9
	dQBh1e5/nvah1YaFmFCtOIRHSXD37JTNJGeL6E7ial9+rrQ/5Zd9W0eJnpl49uFYlvzoEeX84gS
	rY0YuzA==
X-Google-Smtp-Source: AGHT+IGJgNZcFdZqqgwsnvYZ0VemDzNjYsSprurDPg7IVKNRKmOi1jEazd/aYlPgU3exjcUBDfaFbw==
X-Received: by 2002:a05:6402:458b:b0:56b:9567:3337 with SMTP id ig11-20020a056402458b00b0056b95673337mr1296011edb.1.1710870739076;
        Tue, 19 Mar 2024 10:52:19 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id eo14-20020a056402530e00b00568a1897dbesm5742790edb.77.2024.03.19.10.52.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Mar 2024 10:52:18 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a466fc8fcccso711838166b.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 10:52:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWVdQz1EAxUBW0dYo4xzbfIz+cy2meOQuuPOkwuOlVqPKM8UmHrJvuj/65bk8fiqf9Iv7i7wrbfS0MlmhJczOFLNzGZUeM01xSiY/Rd
X-Received: by 2002:a17:906:6d59:b0:a46:e595:f357 with SMTP id
 a25-20020a1709066d5900b00a46e595f357mr1437660ejt.9.1710870737954; Tue, 19 Mar
 2024 10:52:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319163656.2100766-1-glider@google.com> <20240319163656.2100766-2-glider@google.com>
In-Reply-To: <20240319163656.2100766-2-glider@google.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 19 Mar 2024 10:52:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh_L4gKHEo6JVZxTZ7Rppgz1b5pt2MJyJ2mZ-A8-Mp0Qg@mail.gmail.com>
Message-ID: <CAHk-=wh_L4gKHEo6JVZxTZ7Rppgz1b5pt2MJyJ2mZ-A8-Mp0Qg@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] instrumented.h: add instrument_memcpy_before, instrument_memcpy_after
To: Alexander Potapenko <glider@google.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kasan-dev@googlegroups.com, tglx@linutronix.de, 
	x86@kernel.org, Dmitry Vyukov <dvyukov@google.com>, Marco Elver <elver@google.com>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="UTF-8"

On Tue, 19 Mar 2024 at 09:37, Alexander Potapenko <glider@google.com> wrote:
>
> +/**
> + * instrument_memcpy_after - add instrumentation before non-instrumented memcpy

Spot the cut-and-paste.

             Linus

