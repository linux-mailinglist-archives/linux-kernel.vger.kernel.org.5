Return-Path: <linux-kernel+bounces-74434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED5085D40B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:44:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F3791F26F59
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E33A3D3A8;
	Wed, 21 Feb 2024 09:43:27 +0000 (UTC)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909343D546;
	Wed, 21 Feb 2024 09:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708508607; cv=none; b=U3upUYCVTSvy2Y+RFxH+kWD9d1q8xz3uivqTuJUaqFpLIm21EkXMCLY4rUkFFhaMGKeSye/RqXp3ureIVupkL1v1sKtKZwPqJ5BOk9Y/7hmA91957+vQgVvd5Y9yT+pvrCOFLeo+HE+2iCAmyuHLsXpAi5hg2Nv3Es81GM+YLcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708508607; c=relaxed/simple;
	bh=Jc+mU+fS9kSA/mfu1aWjRFbkp1oUlojmjOw+I1ndkTs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ILd8RxPKOI0KzQ/6hQPtOjoAnsS4G5ULXRMKWhGCpPXH663OgOjRnINq7qZHtNRDJujcvCkWkZ8IhieZlIYEJ1LtVsKBieq0Ea0fylemM7k1B4SjWIKQOJM1V7DaC+2LaKOGD3mQwrp/01PmlCtfhn1opACJ0GUB3uudtWQudcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6080a3eecd4so44715617b3.2;
        Wed, 21 Feb 2024 01:43:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708508604; x=1709113404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e1rnWifO1FlLZJnQ/CQ0KYuFIGdPw6XFGeepCZz6o/g=;
        b=wYvZzRqA9kptrfAG6KDr6SkS5kSFw0PvbaM8ywP8hcdzBgqJZvQbYfK5nCXsuCqecT
         go6HjRAXSLE17OZjqGcMeaVlQb/LfXfBXjZHpaukY/hK7so7QTj11h+V3EAltwZG0jJJ
         7EawFV8KjbpCZ1a012QkD0e77FV0QUE321FPImYxk/i8uG0TnEHiwadswjK63iJw4w+f
         bKALAq1vQrFvdK0/yqvWN5kaUNWTcfMKoTUYn5KMFeGGuhiTYCeunmzvgUbD7YY+0Xzq
         ihFCegZ2rtr2cIZp2L+CwNJCZrVEg8PcuOdNcK0bJ08X/t/93w7M6gy3F4xyDLm93KSe
         Q0Dg==
X-Forwarded-Encrypted: i=1; AJvYcCV1p2ZUd1AJcj/XBQVxGEq1GZTAztG7KqMqD+8J/2J51AipQ2o3TTXjKOaDU6SgSBL9T4RtOz0MCKqWPhDiwkTYNCm9btpl2Y/8DogaTsEmsRTGJLkyiiIU73hVY6NZxyeIz9vE4xu72y7UwQwZq+Ek7bNKehFrSACCPijt3By+AZ0TFrFUoFPjOE8=
X-Gm-Message-State: AOJu0YwU3kNN5VMaLvIofHOavaUI77r8IxG0ointLqa44h3nfgZO6P2L
	jvxTvsHA51sOJ36LNcpe9uiA4hE2CiVVS1FTg4cFOuzWRXEuI9UbbPmevNGjuR0=
X-Google-Smtp-Source: AGHT+IGj9TtbgopCymErpNaDh0X35/h/j2kKShvb/9rwU6y4+K+n0HV7U0iH6uTmgB7yCEZS5VJerA==
X-Received: by 2002:a81:99cf:0:b0:607:f708:6c5e with SMTP id q198-20020a8199cf000000b00607f7086c5emr13458250ywg.10.1708508604150;
        Wed, 21 Feb 2024 01:43:24 -0800 (PST)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id e203-20020a8169d4000000b0060487d30610sm2527429ywc.45.2024.02.21.01.43.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Feb 2024 01:43:24 -0800 (PST)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-60821136c5aso23642517b3.1;
        Wed, 21 Feb 2024 01:43:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWYYU3bsDJ2FljiX4eKMVLM3pFRAxucVfbEi2J1Yestfi01X06RW46eJuOkcvHCrkGuyg/2ZQmHH/+q03lv5dJAydgy1XAjkMY+AA2cDV4WGCeivGS7A5F9th1CycA4Yo9LXfBMfA6QQMe9O5rQv7zb0iatHbRf0ubZXT2lNVLqgErjFkmV+Td8jJw=
X-Received: by 2002:a0d:ebc6:0:b0:607:ec66:37e6 with SMTP id
 u189-20020a0debc6000000b00607ec6637e6mr15264804ywe.42.1708508603832; Wed, 21
 Feb 2024 01:43:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240220-fix-sh-mmcif-v1-1-b9d08a787c1f@linaro.org>
In-Reply-To: <20240220-fix-sh-mmcif-v1-1-b9d08a787c1f@linaro.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 21 Feb 2024 10:43:12 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXdatXk4H2M0tr3fiZMGzx9FbuNUvCbhRbT0W2wfMVKdA@mail.gmail.com>
Message-ID: <CAMuHMdXdatXk4H2M0tr3fiZMGzx9FbuNUvCbhRbT0W2wfMVKdA@mail.gmail.com>
Subject: Re: [PATCH] mmc: sh_mmcif: sg_miter does not need to be atomic
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Thanks for your patch!

s/does not need to/must/?

On Tue, Feb 20, 2024 at 11:58=E2=80=AFPM Linus Walleij <linus.walleij@linar=
o.org> wrote:
> All the sglist iterations happen in the *threaded* interrupt handler
> and that context is not atomic, so don't request an atomic
> sglist miter. Using an atomic miter results in "BUG: scheduling while
> atomic" splats.
>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Fixes: 27b57277d9ba ("mmc: sh_mmcif: Use sg_miter for PIO")
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Hi Geert, it'd be great if you could test this!

Thanks, that fixes the BUG, so
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Unfortunately it is not sufficient to make the eMMC work fully.
I will follow up in the original thread...

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

