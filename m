Return-Path: <linux-kernel+bounces-98647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E008877D2E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 10:46:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E80F21F2208B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 09:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B4F2BAEF;
	Mon, 11 Mar 2024 09:46:33 +0000 (UTC)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0032628D
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 09:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710150393; cv=none; b=eAO9Y3hCgOhLFhyjmmcv/zDlPAfPOrQrleabm4FM2fGT58zP6L0HUrSfm7siol9+Es7AmDLHKabWLMKeHPUY3TXnvvLduRRusKCszmM7hml2kGFPdxVQ4Ljj0l/9EUEV1jG59UsReAf4kWWmyFS/lp/nhWuFjnUBJDqEcAUwnKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710150393; c=relaxed/simple;
	bh=+IhIWWmMoiz0cr5rX5h4YcagjuL9WVDt1WvtSZxFYAM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SS4wCe6LaPIilQ65JH16Fs+7Z3npkSUwVBZnM4AxneCGkKERLz7ZJyFKibA8pmprG0TuQHBKdY4xZN70yZU7FUgUILKDlTWsh1+9cWgRKUKCAThaD/PdEbNJLPJ6SeM4vZok46vji6DID97vE04Xf9Li0+DJ0FbiKefHydvjt7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-60a434ea806so3948227b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 02:46:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710150389; x=1710755189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a49AZSv/DVJYSyd2QXOst4qk8J6MxKeD4mMXWnYyGD0=;
        b=oF3yW99AMd2nye+SU2S13ppHIoEA0qbj3NDezvlU0t3GxovSLY20LwXwpBgIKUig/i
         Tgfp4TDKZ1s6pvPeRk3FNjKsh/viGHn0t43ouT2cHXTxhlZJV08JaNimLBcmq3RusSDK
         v07vw5L8FDAVET36ZPpne0PSguMrU11w+Oux+9sO2NSnLamvnF5jtvppWvptXXtOoRwk
         MOpb0jyKAxode5uZ4m7x8Bjo2TdE6IPS9s0F0a+9F4t+D/gFlSBUN0JknivjBNMdsLZU
         c21++MhWoXPNLnTig9ifegWTfoYd+o0MjF4OpSNLSNx/dNDJh0w+ZEmrcNtZ6lndm83X
         sA6A==
X-Forwarded-Encrypted: i=1; AJvYcCW3tKf2sKX+Y8msh/K1+5VCbo1xvCHtQrxCkq2lWzwuwWz4OCsn+BfLY8/5fUeUGR+0e7od9tKdCV5EuO1TpH4nGkYud7yRlc9GI9cC
X-Gm-Message-State: AOJu0YzWnlgS1FCocn+sTTDQ9Q03x5P2Qfy5uFpkh1/H/hUlPRtfxOdg
	qSwJSJVjYPteioZN0VKTjiEol/IDkcOCeWJ53rfIRz0iW/wRXQMich2GE2Phs9M=
X-Google-Smtp-Source: AGHT+IFWYSUVqZpyR7ycqcmTqNr/Yi0A9gXNgXzalF9Hqx8cPult8oeRSNqZ0455H+ttkV0YS7+nfQ==
X-Received: by 2002:a81:b64d:0:b0:60a:2046:e1b0 with SMTP id h13-20020a81b64d000000b0060a2046e1b0mr4405099ywk.0.1710150389538;
        Mon, 11 Mar 2024 02:46:29 -0700 (PDT)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id c123-20020a814e81000000b0060a28132b21sm793002ywb.106.2024.03.11.02.46.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Mar 2024 02:46:29 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dcc7cdb3a98so4163579276.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 02:46:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV/s2qREqRk/8AyMHQOBEkFGwDsQY58FS8yB3XqqVXOY73btKShCSpqoqH/4XzEEYC3ASQ42jGAo6EtjW5rp+89G5O53Q+yL8vO8mUY
X-Received: by 2002:a25:acc5:0:b0:dbd:120e:f337 with SMTP id
 x5-20020a25acc5000000b00dbd120ef337mr3925369ybd.30.1710150389125; Mon, 11 Mar
 2024 02:46:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240310211304.1190913-1-chris.packham@alliedtelesis.co.nz>
In-Reply-To: <20240310211304.1190913-1-chris.packham@alliedtelesis.co.nz>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 11 Mar 2024 10:46:17 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUO_C73AufgWj3qxFbArgWFq8LSr-gdcBaKcCSnqaOeKA@mail.gmail.com>
Message-ID: <CAMuHMdUO_C73AufgWj3qxFbArgWFq8LSr-gdcBaKcCSnqaOeKA@mail.gmail.com>
Subject: Re: [PATCH] auxdisplay: seg-led-gpio: Import linedisp namespace
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: andy@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 10, 2024 at 10:13=E2=80=AFPM Chris Packham
<chris.packham@alliedtelesis.co.nz> wrote:
> The seg-led-gpio driver uses symbols from the linedisp namespace. Ensure
> these are imported.
>
> Fixes: 899383f9ecf5 ("auxdisplay: Add 7-segment LED display driver")

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/r/202403100401.IDre04gu-lkp@intel.com/

> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

