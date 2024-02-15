Return-Path: <linux-kernel+bounces-66591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D7DB855EB6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:04:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB2BF1F2145A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C3C664D1;
	Thu, 15 Feb 2024 10:04:24 +0000 (UTC)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B266865BCA;
	Thu, 15 Feb 2024 10:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707991464; cv=none; b=cVjwCs/KqgtIXPTIuMi9XVF0mR2V3St2RLqYjd0LjM8ANTAnA5jBWxQRzm6y29f66q4/0MfRe7+dq5k7ZH3bF+JFEulJwxC0Byov25LOGZkEcIKDHkOc7vLOl9PZQO5Pgo9nnsWFksIRyJ0lWwxyRF8VXtnOfh4XYW2T3+nLhNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707991464; c=relaxed/simple;
	bh=qaOdbpvLWIG7x4OZMARezMZygtF5+QCRiMI+aT7zXVQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sADLKBdQNrkRsuzDNGFVpsadmnZJwiFqHXpQKIAClKJ3t6QIleBV2j+CATYSLvxXBLIbmtI9scFRVwzX0izw+5TNYrV6isF9y5rEMFJBGcgJNJw3Jh850NyA6HcyzWv9ohLIJads5LMwVQ29x3d/UL9xqD93w7hcGCkFFnDtkVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d0d95e8133so8197651fa.1;
        Thu, 15 Feb 2024 02:04:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707991458; x=1708596258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yfkzCOLAUXAKQEpWTCc6rSRUSsh+fGIBUHKjj5JlZFk=;
        b=KjSbQivN6tsR9TY7JXH8DcrkdKOR4yKwVfpiqkgiqyKbhf+J+wZ+P2vnLobVRCy6hx
         BvPoez2B1gm42Cn/4yMebvNfwV/GlDHhTDsue+MAHbFbOXvzhVyhbcsUubsIzbjm6Fz5
         0Z+Mze5QrpkpHrUbEmRONvlOHY4n+ePeL/Rj6Azi0wiOJmNQ+1J59rV816i8N0CgOKgy
         o2XpLqn+onr1NU7TOFnKfnf/6ijbz2Op0W2JBRLdK0CAh8m3/xUaw6p+JxOHnKIK/bWi
         3qr0OxGHcYm+QHOt8LYiVueLJc2LN7SM2j58hb5rEu1/9Vb8dqSYX+68TPleBwzl5ps4
         E7hw==
X-Forwarded-Encrypted: i=1; AJvYcCW4PSg6WPc9x+EOirWu1oW8fPZZW1m2FTEdHJ7k7NpOHOdJS891bD3gROBjbSRFIRbQPhsoEh7b3K8HGbDqvPzvv74TA3x0gQLbeAKA
X-Gm-Message-State: AOJu0YxCzA+s4XugMulyRhP01mNVIo1qZTIXSyB54/SprNCUHCfbNR0Q
	WhAGg1FldiedcPOI6ZjUhqljALBYS+8Gtj74OfJLm+vGprCdqrSHHgV8lyXkmr629A==
X-Google-Smtp-Source: AGHT+IHXWzi2s5d/C1nDNG9aVmlLLCy0ERVSZ485t+PX53ESQxXymeKejEhnSnTRwfq2sYAo39+vJA==
X-Received: by 2002:a2e:7a12:0:b0:2d0:b003:95b7 with SMTP id v18-20020a2e7a12000000b002d0b00395b7mr965778ljc.13.1707991458275;
        Thu, 15 Feb 2024 02:04:18 -0800 (PST)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id a11-20020a2e980b000000b002d11aaa0ce2sm210210ljj.114.2024.02.15.02.04.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 02:04:16 -0800 (PST)
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-51288b2b549so385929e87.2;
        Thu, 15 Feb 2024 02:04:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUvuZExTDVGay3zi34Fpu3V7AZtc9MpoW2dH3GRTCuqb5fRRTDEwSzYd5h9CwLAsI3puFdk0PPRihKA/FJ9h0NDA0hmV9teTO3sjRPw
X-Received: by 2002:ac2:4f87:0:b0:511:5352:649f with SMTP id
 z7-20020ac24f87000000b005115352649fmr846968lfs.19.1707991445402; Thu, 15 Feb
 2024 02:04:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212170423.2860895-1-andriy.shevchenko@linux.intel.com> <20240212170423.2860895-5-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240212170423.2860895-5-andriy.shevchenko@linux.intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 15 Feb 2024 11:03:40 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXw=gNLbAUV976otSM+c6OfNRyz1bMfjrwQzKv2CW4LxA@mail.gmail.com>
Message-ID: <CAMuHMdXw=gNLbAUV976otSM+c6OfNRyz1bMfjrwQzKv2CW4LxA@mail.gmail.com>
Subject: Re: [PATCH v2 04/15] auxdisplay: linedisp: Unshadow error codes in ->store()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Robin van der Gracht <robin@protonic.nl>, Paul Burton <paulburton@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 6:04=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> kstrtox() may return different error codes.
>
> Unshadow them in the ->store() callback to give better error report.
>
> While at it, add missing kstrtox.h inclusion.
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

