Return-Path: <linux-kernel+bounces-140416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A088A1419
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55A0BB2455D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 12:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F4514BF8B;
	Thu, 11 Apr 2024 12:13:15 +0000 (UTC)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E3C14AD37;
	Thu, 11 Apr 2024 12:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712837595; cv=none; b=iqmdKV0OwremW2cAANGUH04JhcF6nM3dhHScHd2meiF9fasWReeg48QmxHFQVwQItN3HWyHIXGd9ShfdGkJTqGfXOp0U4h3Alv/LbEVHM3/kD8uUodLKnIKPaSF+DstdmOWg5AzorkSRokVLhWxoIYKfvxPhYDoK6I9mBj76Xwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712837595; c=relaxed/simple;
	bh=KhDt1PcZey4FMwzRBGupAmjFzId9epagFg54kR09Bb0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pJtpkc9qPnkrCsrVAvyUfD5UY4glMlvfMQHAfuRRXpxDDvfU7r/jmUEq6/GXxrVovY4lUAl4BoCRHjR1iRXhq2kJrSi9x/mBV+MZ63OTBODFFvcxTp5X4RYZppn4/faxX1MDZ4YFW4kjvewZir5wvwssejLynsvD57aW8F0VndY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dbed179f0faso512138276.1;
        Thu, 11 Apr 2024 05:13:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712837591; x=1713442391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x3llqEbgzP/YzpRVEVWGjiHwv3lrTf4x91BuajdKI+M=;
        b=pLnyqZea0I/DiLjNdhTbtiaTM2Fl8HsR6/aCvD6alsjFP0x1ixCaLJER4y7c5vjG03
         kA2buPAyeByk15g2YINY721gG68Z83g7yg6kEQkB77m7zNmerVjkocwZWpFpIc7uZ6UU
         ACNPqZjzASv/R/hT/nK6BK2olKD3uH9vSO7E5p6qVg16+582Kg9/AWI4Mjg6RqreLG/b
         oo/h95l/wHRe2jCE3oaHB7gDs/XGH/5SRjZghq3PdC40ViWZ97Tgv0yYuDuMSO4blbBr
         QBaZTWrSICyVd6ePsMOI9xIi+Jn8NbPjaTXkAvPwUO3jNWDEd0/ByEMOLdsX3X6plTAY
         wZrw==
X-Forwarded-Encrypted: i=1; AJvYcCX5yrtbLfrZdXeiEdZT3d/ddgUMD7/xkeqC1n8gewmRCPYc8kzkUdLZxz0Sq8f2JFExQ/efU9POyxfOlRXdBeBOF8eCwNfrf+nHD1XoDJM=
X-Gm-Message-State: AOJu0YwTdvSiOn1vb/yl0gT/YK+687bjMOssvswRpgartmU6PBQBEqVs
	1+xQJ/owY3+umTRBwCfIaIJh/D9ZmCTGskB/BHAPBAlf0KAiLSe/KBrUCyik
X-Google-Smtp-Source: AGHT+IGeFr1cSEcK/dO8XO8MHtG1rhsBsOcLxNbcAZRKLXhrH5qr3eqXY1G7Pmr7Gp5itQ0pdjBrZQ==
X-Received: by 2002:a25:8107:0:b0:dc2:a46:3d29 with SMTP id o7-20020a258107000000b00dc20a463d29mr1766058ybk.9.1712837591348;
        Thu, 11 Apr 2024 05:13:11 -0700 (PDT)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id w17-20020a25ef51000000b00dcf27be1d1bsm249905ybm.28.2024.04.11.05.13.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 05:13:11 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-618509f818eso6978017b3.1;
        Thu, 11 Apr 2024 05:13:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUh/XJ5gpP2yLap9cMVXPKheQsK4UBhzuT1wnXg/HjlcEp4DoXlBu5aB7V1F043HryIAt8+y7/+mIgL5jjrSyzzPgC/M7RmopiuZZw2zRU=
X-Received: by 2002:a05:6902:c0c:b0:dc7:494e:ff33 with SMTP id
 fs12-20020a0569020c0c00b00dc7494eff33mr2106906ybb.7.1712837590830; Thu, 11
 Apr 2024 05:13:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410205201.1885032-1-shorne@gmail.com>
In-Reply-To: <20240410205201.1885032-1-shorne@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 11 Apr 2024 14:12:59 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV6W613FESO6EGTTJWoG=dfCbicyH49dywm-5O09SEi0Q@mail.gmail.com>
Message-ID: <CAMuHMdV6W613FESO6EGTTJWoG=dfCbicyH49dywm-5O09SEi0Q@mail.gmail.com>
Subject: Re: [PATCH] openrisc: Add support for more module relocations
To: Stafford Horne <shorne@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Jonas Bonn <jonas@southpole.se>, 
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Eric Biederman <ebiederm@xmission.com>, 
	Kees Cook <keescook@chromium.org>, linux-openrisc@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Stafford,

On Wed, Apr 10, 2024 at 10:52=E2=80=AFPM Stafford Horne <shorne@gmail.com> =
wrote:
> This patch adds the relocations. Note, we use the old naming R_OR32_*
> instead or the new naming R_OR1K_* to avoid change as this header is
> exported as a user api.

> --- a/arch/openrisc/include/uapi/asm/elf.h
> +++ b/arch/openrisc/include/uapi/asm/elf.h
> @@ -43,6 +43,8 @@
>  #define R_OR32_JUMPTARG        6
>  #define R_OR32_VTINHERIT 7
>  #define R_OR32_VTENTRY 8
> +#define R_OR32_AHI16   35
> +#define R_OR32_SLO16   39

Would it make sense to switch to the new names, e.g.

  #define R_OR1K_NONE        0

and add definitions for backwards compatibility?

    #define R_OR32_NONE        R_OR1K_NONE

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

