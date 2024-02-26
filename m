Return-Path: <linux-kernel+bounces-81832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B30B8867B8C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:17:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF20DB345A0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31EA12BF0A;
	Mon, 26 Feb 2024 15:44:20 +0000 (UTC)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BBF12BEB6;
	Mon, 26 Feb 2024 15:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708962260; cv=none; b=Ukt8hzQAw0nWPdaIi+Kj8e2ekwVr99kA5qice12+NogI3HFFIa+AzByy/Cew/IGr/b4R4JpuA/n+3+Pg5N4p+UrCnNC0uUFPwYM15y73mlTaPrapqUXX/7roO6befHxbTQf1ljCrkrQaxkZ7ihX3DFOucQVxB7Xq9eEVg82AhpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708962260; c=relaxed/simple;
	bh=l6azYtmZx0Q9eDroWkMEXLj2U7XzEVVBEhmA/Mh94jQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nl5l+odmMkNMaQoPiN48gBbIzTm2Q04sNxwplN2emHJuEq7wFPogr3qB7C+EHjE4DnvTxQ3onAgZOgO5J3mNh15dKVae6k0yKV+Fe1MnTVnItqJMbvTt1wg5DX6XBQqeD8UALdenr/sooT61ucyf80JtiqNg6aby0j2g6o02FhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6092149eb55so47157b3.0;
        Mon, 26 Feb 2024 07:44:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708962257; x=1709567057;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+0oW41fZhGgX0TG6t6VonNXEiYIoCQkfm20+OXgBAB8=;
        b=AkvrpxiyjM1b6ZUvwNm3TsxSWMvFm3Zy8KlQTZyqa2CxfM8HJESGQu0AbK3yiy1Iyr
         yr0n2kv12BKqEZueR1vocKqEQyDW1n39vDhmm+Op/Mkx4g72gugv+9dTcsvOoFLd9xDi
         P22B2jagPX4/FrBknnfZwEvwAAJjuh4SAz7AvdS8u660+SB1i3I+Wq0X5NDVkg1hVUWI
         /iMBHhIHx81L2WSu95TkYoGiJZQyjaS8S7cG2Ut8vd+Nx/VQIqIrKC2F0eSgZSjM6W8O
         XfSHE2kxkwITzcVNeCy0Is8KAbI6chWQHn4Rzhdxv6dG0ak8p9jIpWO0trPEyJ0hsUa+
         Uv1g==
X-Forwarded-Encrypted: i=1; AJvYcCV/jstLjttO9EKyoRgS6DV8Dj87QOCYbJ00RTLhi5GgtyU2ZfK1vh0f+a0fg5HgQrllv0rYKWu7Eg7gcAPOvKKBlYDFf3iRKstcOJmTwjG5CrApzz6WUWYaN97F6RXrujJl0geyjFSZxw==
X-Gm-Message-State: AOJu0YySiR23kNGu/H+RfCayCsoT/VAXuSPjofuK99db32HkfFUZZiiZ
	tiCEGbk/rbqvoqIAjTkgxupFyqwupni2+0OMnKXlwOj/a5taT1rhanhFqiTjvvM=
X-Google-Smtp-Source: AGHT+IEpBqVljuXH+2A3SraKvrHPvp7pltPHINYXJSHYyEGt83c6Q2IFyMyqahUfYO+PEBFa4U9LVg==
X-Received: by 2002:a81:5753:0:b0:608:d2ce:59e9 with SMTP id l80-20020a815753000000b00608d2ce59e9mr3373739ywb.31.1708962257126;
        Mon, 26 Feb 2024 07:44:17 -0800 (PST)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com. [209.85.219.180])
        by smtp.gmail.com with ESMTPSA id i3-20020a0df803000000b006049c16b843sm1223006ywf.145.2024.02.26.07.44.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 07:44:16 -0800 (PST)
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-d9b9adaf291so2995233276.1;
        Mon, 26 Feb 2024 07:44:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXWGTbWJu1UkpA+aY/m9yVtoJDoMP5EqZ7yLMCMfjqzF6WDqGRoHBeJcOs5zkOlyXALqkGoGfKgEvtq4xkgMuop71nGwonwnyKRIE6WRjs5W67Oz5CXjJnffQOr+GbrFHOvf5yjPkJnrA==
X-Received: by 2002:a5b:8c2:0:b0:dc7:43fe:e124 with SMTP id
 w2-20020a5b08c2000000b00dc743fee124mr3839477ybq.11.1708962256151; Mon, 26 Feb
 2024 07:44:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240219170337.2161754-1-andriy.shevchenko@linux.intel.com> <20240219170337.2161754-8-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240219170337.2161754-8-andriy.shevchenko@linux.intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 26 Feb 2024 16:44:04 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWevSiXD9mXfw74NUt0OebB3QhCE4HZTVBJ0dLE4=Lbow@mail.gmail.com>
Message-ID: <CAMuHMdWevSiXD9mXfw74NUt0OebB3QhCE4HZTVBJ0dLE4=Lbow@mail.gmail.com>
Subject: Re: [PATCH v3 7/9] auxdisplay: ht16k33: Drop struct ht16k33_seg
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Andy Shevchenko <andy@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Robin van der Gracht <robin@protonic.nl>, Paul Burton <paulburton@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2024 at 6:03=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> The struct ht16k33_seg is repeating struct linedisp. Use the latter
> directly.
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

