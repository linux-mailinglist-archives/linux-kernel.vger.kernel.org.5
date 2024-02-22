Return-Path: <linux-kernel+bounces-76646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3243F85FA71
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCA3B1F251E5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 13:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4BF1353EA;
	Thu, 22 Feb 2024 13:56:52 +0000 (UTC)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B5612EBC0;
	Thu, 22 Feb 2024 13:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708610211; cv=none; b=CzOP/DXG1HNbd1VGmI82SJ7UE1cViRLT1sH2aOzoD2lvUYZ08WtetYKbkW3SG/ioXNyhokMgTku1jBX5al2afQvnAdOpJVGfag0/U6II40E38oBPmRfkTtTQwV7ZKzB0/m5UHwhtchQ2KUldJxqUSI5zCUIftBMqT0HLZh5d+UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708610211; c=relaxed/simple;
	bh=dEm3suX3fzhg2bcPZcHvC1sndYyx/vFg3G0E53CeiIk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oL/GJ8dcRpx/C8MQH2fX5K7WYEN49CvJkbqwbLgIAyavoC5oZ5oOO0GrxTr1RwULpOUZQ9Qa/S0t4C6/0SPQiFiTSrBOMQRllUFqWPUx3OcKLUE2iYNwsqsEt0mF5oIgdX68cyEQaj9BUHXULipeJFGoULOIQ1F4e6gCdE3jCH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dc745927098so1802930276.3;
        Thu, 22 Feb 2024 05:56:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708610208; x=1709215008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sHews1cTMJ0VI2OKFXujWZMUtBy3bDbxnSwdRHcUaXA=;
        b=nNBh2Fz13eVDl/Fndgm3t2Awv8SduR1H1fBqGv1hVsDQQFQybTWHPVLZSgKGJJ2+Zd
         bJtCSWzGT3l678M/dQME0PiZSKqwWnfYm3ZDFf+H8Y/kystv2x0CUnLd/Yb8aeKwS3dT
         EEhbRe3j4+L6L9p5KNDvh3+21rIQxUBIpNY7BDwH1n4PdaY8O/z3he+OPuUSN2nyMhKl
         uugMa/TnnLkxTQhW/QL5TylVWfkQJl6q5hxYBc1oGQaEt/qGuW4wvoWqCNlLrxoUFco0
         MiN8z5FOj18hDhPTNVBtopjNNtP1HAkCLZgIU89RWeOxQ1AWwGEqEP8LnI6TAihzuY/W
         w2ow==
X-Forwarded-Encrypted: i=1; AJvYcCXkl/UyDhLs9thlOgEYEC/Kazj0aNlIQl+W663MwmMVlVkm+XQt2vS++N2lYQhRXrpM5NlTAwX/V4tSTs+wU6YZOXIuWzxNDH8/XapkP8Lc+zMnd0yPWxfq4GflALotmvYMTSaSPstrdA==
X-Gm-Message-State: AOJu0Ywpz1iYmQOl4BW9vLKiu16m88yIXJ7eYaXUkSB61LGXq+zkc5p1
	ZVcpZB28o/0vWqMZVVvU5NHofEE031k5dnUNmTVwdHRLcnU4OmEaHPBjKc3A38k=
X-Google-Smtp-Source: AGHT+IHDnxMaL4S9e1oOcyRMxcT4xuDgnMz8PWZHdKA8rstOZAF22YU+xR3nLE5F3BRzap3Z8Y8K0Q==
X-Received: by 2002:a25:8c88:0:b0:dc7:5a73:184e with SMTP id m8-20020a258c88000000b00dc75a73184emr2462330ybl.14.1708610208158;
        Thu, 22 Feb 2024 05:56:48 -0800 (PST)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id v1-20020a056902028100b00dc7622402b9sm2750688ybh.43.2024.02.22.05.56.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 05:56:47 -0800 (PST)
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dc6d8bd612dso1966118276.1;
        Thu, 22 Feb 2024 05:56:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX+SZUYn3ufchA3+aPsYWxc3sxe77isC8SB9BYPP6JM2ZEVxZ5+Rx37uZlfe3mwzQobGuLGnYRqrUbqjpw8DJ7o84+wS/eAfPOYOHq8TrjyHvfaQ+VEvE2S5yo/kmf3SA9KqVbbwc3OVw==
X-Received: by 2002:a81:b615:0:b0:608:9c24:45c3 with SMTP id
 u21-20020a81b615000000b006089c2445c3mr1430864ywh.24.1708610207726; Thu, 22
 Feb 2024 05:56:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240219170337.2161754-1-andriy.shevchenko@linux.intel.com> <ZddRZWftWhMHUl23@smile.fi.intel.com>
In-Reply-To: <ZddRZWftWhMHUl23@smile.fi.intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 22 Feb 2024 14:56:35 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWQ1hx143eJYyCcEj-uqQ3uXLWfB_x70bQDn=wp3kQG7A@mail.gmail.com>
Message-ID: <CAMuHMdWQ1hx143eJYyCcEj-uqQ3uXLWfB_x70bQDn=wp3kQG7A@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] auxdisplay: linedisp: Clean up and add new driver
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Robin van der Gracht <robin@protonic.nl>, Paul Burton <paulburton@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andy,

On Thu, Feb 22, 2024 at 2:51=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Mon, Feb 19, 2024 at 06:57:59PM +0200, Andy Shevchenko wrote:
> > Add a new initial driver for Maxim MAX6958/6959 chips.
> > While developing that driver I realised that there is a lot
> > of duplication between ht16k33 and a new one. Hence set of
> > cleanups and refactorings.
> >
> > Note, the new driver has minimum support of the hardware and
> > I have plans to cover more features in the future.
>
> Geert, would it be possible to give one more round of reviewing/testing
> this week? I want to close auxdisplay for next merge window next week.

For 1-7 (linedisp and ht16k33):
Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>

I hope to get to the actual review later...

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

