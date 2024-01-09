Return-Path: <linux-kernel+bounces-20977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0DCE82880A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 15:27:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 427C21F24C37
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 14:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6FBC39AC8;
	Tue,  9 Jan 2024 14:27:22 +0000 (UTC)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB12B39AC0
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 14:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-5f68e2e1749so25109157b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 06:27:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704810439; x=1705415239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BSNpQrjMxu38IObUGMmHZtLYKM7CsitQLNIL1x6OifQ=;
        b=FpQ8prfUnNtY8/1rbhRAV4mtKqDBY/aUy8/vs+qQ6p7DNy/+rRblf7CKn7h71qT+Te
         kpQnOmCVSqckTqo0JnZRpxcSnCjJLy0ItOPIpGNVwPDCU8MlE/oY/640Eqro40TydkiD
         9Bu/k4LybGySA6dzRXvjykhZtOeyqRK+0Li30GpdomusI43Nps7Zs4ZzELgJxgsSwEp9
         X3Q46xfUN63u5iJ60Gbmcm02FsAvvGkT4p6VyRTPRPtfXwMlKsOMlavYwLsj2yZnaqPM
         Fqgil6rBMjwRGFdwhpNgK6G7yTyU854XSWyvtEs7M7QMEbNj5ZwMtuQFJeODl0YJE4eT
         y2FQ==
X-Gm-Message-State: AOJu0YzdjqljgbvJTk1SEvsax7KJZuiiqeLEPEJM0uOXSWCrx5yE+TH8
	Yvj1gQaypealTrlfor0o1c7hJZBvXqqnb8F4
X-Google-Smtp-Source: AGHT+IE8CTcfgQ4F9BRvaF/A1R3DhsyCPdzSpS+FJVlDO6ftDcABhSzqlur8sMgEQnsU1DKVilP01g==
X-Received: by 2002:a81:4802:0:b0:5ed:90e1:8bf4 with SMTP id v2-20020a814802000000b005ed90e18bf4mr3398454ywa.47.1704810439489;
        Tue, 09 Jan 2024 06:27:19 -0800 (PST)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id n69-20020a0dcb48000000b005e81c9ec392sm809019ywd.48.2024.01.09.06.27.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jan 2024 06:27:19 -0800 (PST)
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dbdbfaab70eso2003862276.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 06:27:19 -0800 (PST)
X-Received: by 2002:a25:414c:0:b0:dbe:d374:75a7 with SMTP id
 o73-20020a25414c000000b00dbed37475a7mr2374147yba.123.1704810438889; Tue, 09
 Jan 2024 06:27:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108093221.1477020-1-daniel@0x0f.com> <20240108093221.1477020-3-daniel@0x0f.com>
 <CAMuHMdX44A6+BNByuvbCC2gcM5vAipbaGAK7L8Vh8q3tMynBbQ@mail.gmail.com> <CAFr9PXn9wqbxToGDkSenW3XTCMPinUg1a9fHrUDQVhRKC6s5TA@mail.gmail.com>
In-Reply-To: <CAFr9PXn9wqbxToGDkSenW3XTCMPinUg1a9fHrUDQVhRKC6s5TA@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 9 Jan 2024 15:27:05 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVYqojGdKaCkY63mOhxupZ3Ag5+Y-haZZf43wyuCsdKkg@mail.gmail.com>
Message-ID: <CAMuHMdVYqojGdKaCkY63mOhxupZ3Ag5+Y-haZZf43wyuCsdKkg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] m68k: Fix interrupt stack frames for 68000
To: Daniel Palmer <daniel@0x0f.com>
Cc: gerg@linux-m68k.org, fthain@linux-m68k.org, 
	linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

On Tue, Jan 9, 2024 at 3:10=E2=80=AFPM Daniel Palmer <daniel@0x0f.com> wrot=
e:
> On Mon, 8 Jan 2024 at 18:56, Geert Uytterhoeven <geert@linux-m68k.org> wr=
ote:
> > I think it would be better to use the classic m68k stack frame.
> > That would pave the way for building a single nommu kernel for
> > MC680[012346]0 that runs on e.g. any Amiga.
> > MC68000 and Coldfire are incompatible anyway.
>
> While looking at how to do this I realised that the addql #2,%sp in
> RESTORE_ALL in entry.h will now break the stack frames for those fancy
> 68010+ users.
> So that needs to be #ifdef'd to make it only compile for 68000. I saw
> an error email from the next build stuff so I guess the change has
> been queued somewhere? If so I should send a fix..

AFAIK it hasn't been applied yet.  These days the bots also test
patches from mailing lists...

> I'm not sure how to actually make that generic without patching the
> code at runtime (remove the 68000 specific bit, reserve enough extra
> space to rewrite the code..) but it's a macro so not so simple.

Or use different entry points depending on CPU type?

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

