Return-Path: <linux-kernel+bounces-17335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C67FD824BDF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 00:37:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73B5B286F52
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 23:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7992D606;
	Thu,  4 Jan 2024 23:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZX2Ucq0+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8FB2D05A
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 23:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-555144cd330so1365743a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 15:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1704411410; x=1705016210; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2tCIapFlQ8RuTR5nGU7S5pDnR7Si2VyfexSEg/0jado=;
        b=ZX2Ucq0+uflDkIUZeXKY4oIqQS9vl0SCxo6IEVzYER6+V9rRKIfIFYmBt/KQLC7b5F
         C+cDaSsyUmgDpjJdaV97S3Uz5/kipwAQFmv87se+lXeRz5xtSzt2tQmvX8oCMv/yf6LR
         /Hmg9+TYX7WHW3hyPpD6NMP6+MkK11Al9iEO8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704411410; x=1705016210;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2tCIapFlQ8RuTR5nGU7S5pDnR7Si2VyfexSEg/0jado=;
        b=tkr04klagpE8q//w/4rMBMwpQAXc+1/ZRL6G9Rb3PvaOfp1r2YHqVDVLsReLrG90TV
         XI5HFUGZWhjwQYu8pIJJ3yglY+WrxKbHEKxfYPmqbkLCWtnkBClxkR18AGqoQQUqm7jm
         UTb7vtfmUjGrnoIcgi5rv/OElMJScN607fpRg602H8ZWvLf3pwOzQeaOM36o3Ls+nevK
         jZpHYYY2ENdDZmt7m5VIYYiOP20Jx0rrl3PdveM2SnWdq2Bg02K+PCzN1u4OEIuDYpQ2
         F3n0FDevWQ6QasoS/qRgu3H2uJLlac5N3RbfX6VhfPcfKBV2VbNNtrmhlo2JXJ4Hxmxy
         63gw==
X-Gm-Message-State: AOJu0YxDlIIhBYU30DYDV5zUvURlVR9Wau8hj9979WasKNg85Y2ZOQX6
	ySKbkGBZjLxDopdoU1bz8te7oRnRV8OC/cA4Ezg4dgQMm7A70Xw6
X-Google-Smtp-Source: AGHT+IGJxNNvwMWSWLs4ajQ0ZiTXFfNdPTTRp4y6Xc/fmI4tj82wQZqYl6QnwqSt2HFkz4pU4j8bRw==
X-Received: by 2002:a50:c2ca:0:b0:556:cd93:775c with SMTP id u10-20020a50c2ca000000b00556cd93775cmr675051edf.74.1704411410606;
        Thu, 04 Jan 2024 15:36:50 -0800 (PST)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id i15-20020aa7c70f000000b00555f49e7080sm254163edq.56.2024.01.04.15.36.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 15:36:49 -0800 (PST)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5555f9061b9so1376324a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 15:36:49 -0800 (PST)
X-Received: by 2002:a17:906:71d2:b0:a27:4219:75f with SMTP id
 i18-20020a17090671d200b00a274219075fmr718565ejk.58.1704411409275; Thu, 04 Jan
 2024 15:36:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230920192300.3772199-1-goldstein.w.n@gmail.com>
 <202309231130.ZI5MdlDc-lkp@intel.com> <CAFUsyfKDRiX9kKOhHcA4PLqqT6Q5faHF0eRGiKN+9NSbvrUfDw@mail.gmail.com>
 <d02bd4f823534a00ae4915ead3d92773@AcuMS.aculab.com> <CAFUsyfL0M5P4+4s_b1kvJ_fE-ax8YBK0ammbKfoy7yKs1obzrA@mail.gmail.com>
 <CAFUsyfJduB29c6=BNmTtgoWcHAWA1AZ-sdbhyp02JVhvA6Gp0w@mail.gmail.com> <CAFUsyfLuo0_Sm91mqbM8Sbo-ncwnM4RaRq=GxQXDmkAN-nQ3uw@mail.gmail.com>
In-Reply-To: <CAFUsyfLuo0_Sm91mqbM8Sbo-ncwnM4RaRq=GxQXDmkAN-nQ3uw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 4 Jan 2024 15:36:32 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgv6h4ru=z8UR5XyutoRKveOetNpwovHburvRgG9NSa3g@mail.gmail.com>
Message-ID: <CAHk-=wgv6h4ru=z8UR5XyutoRKveOetNpwovHburvRgG9NSa3g@mail.gmail.com>
Subject: Re: x86/csum: Remove unnecessary odd handling
To: Noah Goldstein <goldstein.w.n@gmail.com>
Cc: David Laight <David.Laight@aculab.com>, kernel test robot <lkp@intel.com>, 
	"x86@kernel.org" <x86@kernel.org>, 
	"oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "edumazet@google.com" <edumazet@google.com>, 
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "hpa@zytor.com" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 4 Jan 2024 at 15:28, Noah Goldstein <goldstein.w.n@gmail.com> wrote:
>
> ping

Bah. I think this keeps falling through the cracks because the
networking people consider this an architecture thing, and the x86
people probably consider this a networking thing.

Anyway, since I looked at the thing originally, and feel like I know
the x86 side and understand the strange IP csum too, I just applied it
directly.

              Linus

