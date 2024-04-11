Return-Path: <linux-kernel+bounces-139970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92DC68A09D0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C38AB1C221BB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE33313E04A;
	Thu, 11 Apr 2024 07:31:47 +0000 (UTC)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B9913DBB6
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 07:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712820707; cv=none; b=utknGWKG09BS2wk+h42I3C2SCBM/E2dKszR2tt19JNX/MnKqlA9+3aL8zIH8uUJsn7QKOHd1bqIMuQaHapgboXs1jIumqP0rVMmsmGb4FhmXEDZ6FY1FhyAwLu80bgFHmP26NHLuWYcWBHrS/2CwnIrBth/2TGfAsJurt4lrHXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712820707; c=relaxed/simple;
	bh=UlI7FEv6uoW2qM6wkpRItq0E0Qmo2HK9RGw0C3um1zE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SjaeI3B9dsWiLt4wGQglQuVZXvIG0FazvvnTnt7aN2lUclHzIz+v909B5L4Nb7UDry9Bl9TnZsVpeou1CVI0JoTMIYB+I4DUn3QtLriudMlKYO0dw3aFEXSsUonV8qi4DbDBISd6sHzlTueMxBoSqvIDrrzQ0KmOGqA10AM0PPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-617d25b2b97so43193847b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 00:31:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712820704; x=1713425504;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3YhWCdTDOgsA8E04ZbuKLF0P4zAMCEpWAJPEAQpUn4M=;
        b=OGLvecnciuUL3kMOvVXtx+MucGP3Rb3P8ph3gpWHgxX3cu0ofqOoSmeHcEUOtgk+cv
         5Pf2ZF273ckPZECcu85ONFesnR2EcIOHvJCvhQOi7qT+mvel5p4l8xLoo6sVIwcEY0m/
         YllF8vVAMYNWcVtnzF0gfyy9ZXxJi/iAKPap1zzL25S1S0MSWQBWAKoodvxdI2QfHrB1
         S5zZJh+BOazaQOP1UlogBTEetATf3TOTqXM1SLIdW6/JywTzSP2uVQM3cydtfiGUkJ8B
         5u0api5T2qKiZSyge8cTonbxV5FbwI2xCOXnGtaO+hc9AuPXSUKG+WJjly8JOPO8nsXT
         VqQQ==
X-Gm-Message-State: AOJu0YxEu8ya0WnTQx+EejOi/i79TBe0mO4GwB197H31WeP2bhnSRg0a
	W2OzWXInB6RfXA1AYlRbOWIy8hinS8XrbicaHJF/R+yeq0IQ+hKfLGLKDu9X
X-Google-Smtp-Source: AGHT+IGXjm7JCoAlZtoScle/RJXmMmEOFOeUoOcvZhWE9oWlI3bYyHv+XOKWZTBaFo8uK0PruKb0rg==
X-Received: by 2002:a81:d505:0:b0:615:2ed7:59c with SMTP id i5-20020a81d505000000b006152ed7059cmr5064597ywj.47.1712820704165;
        Thu, 11 Apr 2024 00:31:44 -0700 (PDT)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id j15-20020a81ec0f000000b0061511220f16sm195661ywm.92.2024.04.11.00.31.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 00:31:43 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dcd9e34430cso8567525276.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 00:31:43 -0700 (PDT)
X-Received: by 2002:a25:c101:0:b0:dbd:c442:9e60 with SMTP id
 r1-20020a25c101000000b00dbdc4429e60mr5364342ybf.36.1712820703740; Thu, 11 Apr
 2024 00:31:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240409161523.935384-1-andriy.shevchenko@linux.intel.com> <20240409161523.935384-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240409161523.935384-2-andriy.shevchenko@linux.intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 11 Apr 2024 09:31:32 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUeh0T0Y=zizZLx9oB44qwCgGmNdvGa3Bx4xZGOz6BLDw@mail.gmail.com>
Message-ID: <CAMuHMdUeh0T0Y=zizZLx9oB44qwCgGmNdvGa3Bx4xZGOz6BLDw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] auxdisplay: charlcd: Add missing MODULE_DESCRIPTION()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Andy Shevchenko <andy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 9, 2024 at 6:15=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> The modpost script is not happy
>
>   WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/auxdisplay/ch=
arlcd.o
>
> because there is a missing module description.
>
> Add it to the module.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

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

