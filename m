Return-Path: <linux-kernel+bounces-65501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB73854DE4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:17:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 774EE288865
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B5465FF00;
	Wed, 14 Feb 2024 16:17:03 +0000 (UTC)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA5D5FDD4;
	Wed, 14 Feb 2024 16:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707927423; cv=none; b=e9HoqIOux6FDXi1G+qAFvdls5VVFQDxGkQOoL25nO32k6W4myrPUZ7mdnkX05WCeFF8kCVtftH/CSHw1jmEkWBOY3C3WUmLfeB8u0gm/b2jR695gwpSd1q5UCdmtUJl10Q7erfB3IORhUPdjTeS3yPrPJHSvvOX6saxonCDMeXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707927423; c=relaxed/simple;
	bh=+KwuCyZcD1ytf8ee3jyMUEjAWvDs1bXqvMEmBHJWRI8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EnGRfQv3ifwctkJk/jLuC5rVvH6YDsIHxmaqfbHFPtyP/pwYKGRrYxq1oH5mvJHN+szJcchnxJBbsPV3G3BuHFNat8NQFC0iO6gJl7XvhiAJ1EK5HdLqszUbE/PHOTa73OivRSuF0f44trpQKGb53miaog1uFLevWZgfCcnrElA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-db3a09e96daso4754168276.3;
        Wed, 14 Feb 2024 08:17:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707927419; x=1708532219;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eL9tA3rhy6+CNRIITZCNAmgKdS1I6ZY4AAyMY1xF/sk=;
        b=pPWUc9ooy6a4E0X2+nnn/CFWp2fTk4v1GdqFn6QKemRX8y8BwHpegbvEfr4LWQLiq7
         PLUZqJEYEqh0n/ZNbTkhs8K7xskpLix86rzYpj3ICEmOXWuoRT5nHySPNOMEhM5KnGIv
         phhMeizRv2mQM8WRmF0gi0yM2zo/XKR97o6oCg71trEA33G81JFe3mH/63Y1Tu+POpPX
         AI23P9UaowooqnRRtw2wShZ5W8u37NhzM+AEAllYZx7Cyk5TeQ14sb92ms6fOunR/Ls4
         /aisGih/SGDY0ZDe4VKK42Va7pFOYDL+4kfDuy4hH/uzAIHSJv7CMxCzkVw+Na4fGxJH
         Cysw==
X-Forwarded-Encrypted: i=1; AJvYcCVRmvnB3E/MpvpkrpFlQE2tjDRwvnb4M6Dcx0CAqjVtmrb/BGt4WObYPjtawbrxIrgRt1j0NKaw6oJDqCZVZ2nfVsio2QhJ/xb466B6DcNhsP63ctwgQS/Ohy6YLiOKvxvk1bCQEbMZx1SjFcgsnww0O+Sl9/evtYuhqgElc/s9Y/M=
X-Gm-Message-State: AOJu0Yw5m3xRXcyooikco2cZyoV3cjo0X4xtOVQwG4MZVD9uAQuZpOrZ
	GfObeihFYqPzYvvOJnHitDaeFtLJ7wg1/fUPPYEpk/iz1Yu2KEUV0vZ/X2HWfWI=
X-Google-Smtp-Source: AGHT+IG35l5QoZ9kxEYz2EfT3Mq6Kk0qe0sG+A/GAqVyEiYCsnWERBk0HHn/sbRwYKS60GzaWO2RTg==
X-Received: by 2002:a0d:e343:0:b0:604:eb7f:30f4 with SMTP id m64-20020a0de343000000b00604eb7f30f4mr2811767ywe.31.1707927419179;
        Wed, 14 Feb 2024 08:16:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWxFZYsqj7BcYSmrO565+ZwZ+f1/iRf3vk8hIJE7G7xsrniSnZZPDEof0g9oewzSHZwvBG1GyRrcyMGAHm9xr2hpINKmuXfrDwp+J5WNV6O1vjOaoZKiCnT3dn51pdhoGUPpcJpQDwRJbjQ2G8EVObF7mmfnHF3BPpj4ac2KUvHOww=
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id t145-20020a818397000000b005ffcb4765c9sm522613ywf.28.2024.02.14.08.16.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 08:16:57 -0800 (PST)
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dc74e33fe1bso5562794276.0;
        Wed, 14 Feb 2024 08:16:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVM4E1Ri204hUXbTALa+Wi7a+lWmIKqP33ih2ZpW9dTHPQouDtzSbsy/XIYf5c9uxqjcTVkdDQBcw9xhkhhxRhoGYuL6BELrOL3FcpjU6HBV3U5BmDpZXbhpnPj6GbRyieW6/+MpJxHkRZL3jqxLKX9mwr6vUg2l7sx2DoPXWpNvnI=
X-Received: by 2002:a25:8682:0:b0:dc7:776b:5e4a with SMTP id
 z2-20020a258682000000b00dc7776b5e4amr2417997ybk.56.1707927417345; Wed, 14 Feb
 2024 08:16:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213220221.2380-8-wsa+renesas@sang-engineering.com> <20240213220221.2380-14-wsa+renesas@sang-engineering.com>
In-Reply-To: <20240213220221.2380-14-wsa+renesas@sang-engineering.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 14 Feb 2024 17:16:45 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV6oh4x4LQKu7-UTMU+g1WGnUehyN+vJcGug2EZFuyf7w@mail.gmail.com>
Message-ID: <CAMuHMdV6oh4x4LQKu7-UTMU+g1WGnUehyN+vJcGug2EZFuyf7w@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] mfd: tmio: Move header to platform_data
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, Lee Jones <lee@kernel.org>, 
	Ulf Hansson <ulf.hansson@linaro.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 11:04=E2=80=AFPM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> All the MFD components are gone from the header meanwhile. Only the MMC
> relevant data is left which makes it a platform_data for the MMC
> controller. Move the header to the now fitting directory.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Acked-by: Lee Jones <lee@kernel.org>
> Acked-by: Ulf Hansson <ulf.hansson@linaro.org> # For MMC
> Acked-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

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

