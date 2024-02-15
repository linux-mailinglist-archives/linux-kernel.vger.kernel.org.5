Return-Path: <linux-kernel+bounces-66588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E0C855EB9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:04:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 118B3B2306C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6486C65E20;
	Thu, 15 Feb 2024 10:03:33 +0000 (UTC)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4339F67A1D;
	Thu, 15 Feb 2024 10:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707991413; cv=none; b=ttQgAnX4jJjDTeP8CDgvNeMgMR5Bwv5hL/y1aPn2HG1WaKTpczwNHrDRpvTCCLCi+5r5JYRlM2iWr9SAp3GoGmgA2PDhyw96bMnD8ivNUFtk9v/+e1pQccKHWbiY3oYt3dY1dv/PvyQLT3251Q3n6CKeJzKjIr3UwBRy1ED2vhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707991413; c=relaxed/simple;
	bh=YR8V0MA5kiA/Ck9lEvtlu9Lql6GumNZzdxBHtm5MY+0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jq+RImFeeZeLnNUnKU7XntPUwCXyjGo+zfFG50/tr+WpRyADjs2/1vPAdF2mWPEze/lUbPFIOthXm/+5JNBh9lRttEn7YobOc8ZKWPmyI11hhXp4h7mJl+Nue8c/dae6EAOAg1Z7YZOeoqYI6TRH6nyvqIzSOJ4birYoBGF+it8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-607dca92fcaso1793387b3.1;
        Thu, 15 Feb 2024 02:03:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707991409; x=1708596209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xJUkHPWrDHGs9cgj6Y6TdBYDhS9RdlMKz0F9hIT5hPI=;
        b=HGh4vxqoVOJkpG4FUJr2NBL4F6reHYvCfIcww7f6v7T/ydOTO2LfsBDzBhnNyh5q7K
         RTKSUvda+8MRF3AUvAc3+bdyd8KYkkynlATT4tO0rrQoiAKoT7/zmEdDLUCs6QtfahDW
         3nZXpBJJizQjHf/bJyK5hH/CjL/TtzxqVTwd0+wfMUXLLDeY9e+keWaYwN5H8JPZooMS
         rCeje/Y7CCdiM5tBKxrGvfF+SUgQgiDfJl28ze4ee9RMb9hkimVppHpfgAZLmraFxPAz
         5UCr4GXkztiafOlZribOw/lN7nJFbew4cBx2u60YFM/gMz7sWnAWa1ObpHPb/wHaQ3d/
         GkOw==
X-Forwarded-Encrypted: i=1; AJvYcCWzDRW98ybjF6t+oL6etnz3uMwvuuvAiuztJnbnoYtvHQyDyZSd8SgsBqlxBPPXN14dWonsGJ9Xg7rsbdtCcHTcb1Hp/oKRqc82diG3
X-Gm-Message-State: AOJu0YyEdcFbG9nXc9LHvAMp57GwCCbHvL1TdetT4tMb80u8610TxIMG
	M0C00HumRjmcyNoBd5Gy8odKi20mzgzfPGJfVOL7NOPKA1gMNX8C4d2n6iVoXLA=
X-Google-Smtp-Source: AGHT+IHFEARJ8SP3yoTjtHGIDxepe3NA8keqhvdABa6qUjMxBRWPAE8fJRCcgKnnHu0Kja4UWVjK1g==
X-Received: by 2002:a0d:d709:0:b0:5ff:b0ac:ffb1 with SMTP id z9-20020a0dd709000000b005ffb0acffb1mr1343729ywd.19.1707991409594;
        Thu, 15 Feb 2024 02:03:29 -0800 (PST)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com. [209.85.128.171])
        by smtp.gmail.com with ESMTPSA id t22-20020a0dea16000000b0060778320f39sm183881ywe.1.2024.02.15.02.03.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 02:03:29 -0800 (PST)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-607bfa4c913so6508027b3.3;
        Thu, 15 Feb 2024 02:03:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUXCEbs4JZG9ZXkvco0+UikiQGYxQd/ZH596Fl0sHiwwNa70noKEpDXJ4DTFsEM8J3jh/DTmTZsGHpGs+NE4mWN69YcZvX4NXI5eYIV
X-Received: by 2002:a81:9f0d:0:b0:607:8edd:b5f7 with SMTP id
 s13-20020a819f0d000000b006078eddb5f7mr895866ywn.49.1707991409152; Thu, 15 Feb
 2024 02:03:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212170423.2860895-1-andriy.shevchenko@linux.intel.com> <20240212170423.2860895-3-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240212170423.2860895-3-andriy.shevchenko@linux.intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 15 Feb 2024 11:03:17 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUDy3f0YQ9CpM+o9d7yL2NeBqyxYYEAR6FP8+gbLSndGQ@mail.gmail.com>
Message-ID: <CAMuHMdUDy3f0YQ9CpM+o9d7yL2NeBqyxYYEAR6FP8+gbLSndGQ@mail.gmail.com>
Subject: Re: [PATCH v2 02/15] auxdisplay: linedisp: Free allocated resources
 in ->release()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Robin van der Gracht <robin@protonic.nl>, Paul Burton <paulburton@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 6:04=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> While there is no issue currently with the resources allocation,
> the code may still be made more robust by deallocating message
> in the ->release() callback.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

