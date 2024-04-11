Return-Path: <linux-kernel+bounces-140012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3868B8A0A54
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:44:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CEFEB24E57
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B05713E04F;
	Thu, 11 Apr 2024 07:44:03 +0000 (UTC)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9CE13CA86
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 07:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712821443; cv=none; b=RfEFK5XA9BrI1kCtLVyMt0sqRkW7TbtWS6FgsV9gJT/BMzxldPtJsiB4jC46Eq/cNsStX3eZE74QWnsfg9LiiE3SNOoogXUAlDW3wnHTdHARiTxyRrTwEAjMMKEBuARJz6B1CngeKZ3YPWLK7Dz7EB2yBADHeg6bCxFMxFHTqr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712821443; c=relaxed/simple;
	bh=MK8DEEZls97W2mChpjGeirjgUAIZlFHd2+UMg/hcnko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jvSJ3LJFH2DX96mMc/FT6YI6+XUQ+IxCRalhR6ppPNqxgK8nVIhTfe6Y5uPuVcAweCxpaIidGVuxROUuCpfYVbj3x2HxBUS4Y6VJeNAsWpciCha2ePeItZ8hUTMhwExEQRA0twl6LVc54kzq9/VOOK3xG+2TVNF5ic+uKquwLcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6098a20ab22so70239987b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 00:44:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712821440; x=1713426240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AqBhs9akk02aNP7WXbC+MayH8mTuRtWaDEMgPpW0wT4=;
        b=ZHIHl4t1ucAqhBjAcn+twf8sJFyfV+GthGk3aIbHzMRgqpsrqS4mutlpP2XWT5SbP5
         jmMZqTO4adRMlEBsYNIkzXEv49DnpOaxKyJcDK63l5xbMpfaVT3TPtOo875oWcCP4Goo
         EFsmxBXhyX3T+SHG4jGzBHWN2XfUR5b6cjRS6KS5I4g5Dr1xmyKwyugRjXGC0CRt+P3r
         4GdbALf6AMNDsh64LdQ9Dau5V9WMk2ilGLhuJ0TzxpxRymCTRk7ikPA41q7vZGYRXelp
         fcfuljg7aPmydR0O/kq4RgQb//OOqQK21L7YWScCJ/ep+g2cfjPlZKNE2TtprZn2ZnG5
         3vZw==
X-Gm-Message-State: AOJu0YwAOTgsFTd9GZOF4UL4fDPzaMtfOgAmRJO4zI5vokpeGmkXYkV7
	qorOoHj7AWjYYYHvM1S9yBVjlwbMpTV4pmk+wuuPhjVr52WV3kIz7gZSLCQk
X-Google-Smtp-Source: AGHT+IH3BzuAGkvLC/1Dz/Y54iaC5OKUixL7JIHE0Ihon+hLYlv8T/5/uKcrgddRNb2BgUBQ16suhQ==
X-Received: by 2002:a0d:c302:0:b0:60c:cc12:4b85 with SMTP id f2-20020a0dc302000000b0060ccc124b85mr4879869ywd.38.1712821440431;
        Thu, 11 Apr 2024 00:44:00 -0700 (PDT)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id j72-20020a81924b000000b00615800d67c3sm204810ywg.3.2024.04.11.00.44.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 00:44:00 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-617d25b2b97so43259647b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 00:44:00 -0700 (PDT)
X-Received: by 2002:a25:b11f:0:b0:dd1:7128:617b with SMTP id
 g31-20020a25b11f000000b00dd17128617bmr5241054ybj.38.1712821440057; Thu, 11
 Apr 2024 00:44:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240409173921.1080616-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240409173921.1080616-1-andriy.shevchenko@linux.intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 11 Apr 2024 09:43:48 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUm77VFSraw0KTKYoUknZ4Eyfgt9GeP9T-0_ET7L_zVsA@mail.gmail.com>
Message-ID: <CAMuHMdUm77VFSraw0KTKYoUknZ4Eyfgt9GeP9T-0_ET7L_zVsA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] auxdisplay: charlcd: Don't rebuild when CONFIG_PANEL_BOOT_MESSAGE=y
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Andy Shevchenko <andy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andy,

On Tue, Apr 9, 2024 at 7:39=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> When CONFIG_PANEL_BOOT_MESSAGE=3Dy the module still includes
> the generated header and gets rebuilt even if it doesn't use
> anything from that header.  Include generated header conditionally
> to avoid unnecessary rebuilds.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks for your patch!

> --- a/drivers/auxdisplay/charlcd.c
> +++ b/drivers/auxdisplay/charlcd.c
> @@ -17,7 +17,9 @@
>  #include <linux/uaccess.h>
>  #include <linux/workqueue.h>
>
> +#ifndef CONFIG_PANEL_BOOT_MESSAGE
>  #include <generated/utsrelease.h>
> +#endif

Perhaps move the existing "#ifdef CONFIG_PANEL_BOOT_MESSAGE"-block
up, and move the #include inside the #else branch?

>
>  #include "charlcd.h"

Regardless
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

