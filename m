Return-Path: <linux-kernel+bounces-81820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 27602867AC3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B3A3B27F03
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7A412BE87;
	Mon, 26 Feb 2024 15:38:35 +0000 (UTC)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38121E51D;
	Mon, 26 Feb 2024 15:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708961915; cv=none; b=R2XNYIyJ7er0JHMmhXxr7MGaE0av3fSDHTGId/w9AlMQnHhgqpLjfoQx/5ZrhCl65XV3+qo0byh8c6m010UnUQxZRlPZecPdiclsIlG5q36RrHNSBXe2bkyhdo4zHjQDFtPF0Xe1dgnkoPB+CtwCcLbWhy/muIz7V0Z0ZdJ7z0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708961915; c=relaxed/simple;
	bh=L7qz4q8oWIeDBkqYVr/UL7/lk3Oozt04Alwv/TxizvE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=giesBmClsADmZVwkl12SI+UgS0EjslQ7LyUhUCOlys+Bs+sgntShK8OGASaIBod0SHgwKDo8ikjfvs9NHxZYTLf5p45tMp6jCYvE8zDA4q2dzcRSLg/+KOtsnpUOOT6CM6xeoMONxIlb1IBTeM6D9T2/qk+VePAdWnMA5oZBMZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-608e3530941so16120107b3.1;
        Mon, 26 Feb 2024 07:38:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708961912; x=1709566712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ocbT52q9GFO3nyDUIiXOIkIiOkdC6TMGN9Xh09tUq64=;
        b=TXVsKxyWveamTglZn6NV9ghRwlNH12YahSyyjrWu9ag3h8hLP8gEmyPPq214wyggJr
         qBfvrh7yXFehB/z5QX2nmOF6NDm5+9DELxs3I5Yq/OkPct0IFx1xAOw2NbU/NCsVY8ni
         fsJZ2TXH6G0l/xADLwCtnuzt1/pAm7HdNnNku5H+dBuChfX8V74lyYspKnbpVIlyOLrz
         JiHn4mGwer84PND7p4vFCbiEnnaZX/PWIaTNBndZR7A8Y5phhlsPCJycU/UBdGqzA/pW
         pPEdwL+rXqc9yfLZo+fDCf3GS0VZt7OlO47uq+rgCqPGi6g1xL0cym6aVPro0zhAH2IO
         1lGw==
X-Forwarded-Encrypted: i=1; AJvYcCVqyyJ1X2Yzp8nWa960X/8wr/+5rIay19zojCyNAvB1Y0Ds0e0gNkeIzZmL+n6u05T6Fe6fr2fSpsbzq0xaDLO7aaFHzmUrqw9wb3nnXsTp2rF42hoc6SUvgBk1WKoNd2nzbwS/hp1ifg==
X-Gm-Message-State: AOJu0YxYa3WMEuXZoMITjD+WylkShRHD2G2zxlWdJ1DXDpFLgo4uiD3i
	IjlgwZDr8Nt0IVZTbdx8Ln+U9gr9LT9oOC10gUHn1ZvOYsxDDdA1cL0S/2FHGNQ=
X-Google-Smtp-Source: AGHT+IFXpz6VFtTBRq8jXZDVghK/JocQ/QKR6JfBEAwXoINcf0NPiwTmUPBtPiR6XY4h9lXXgFuD7w==
X-Received: by 2002:a0d:d507:0:b0:607:9dd9:ce65 with SMTP id x7-20020a0dd507000000b006079dd9ce65mr6302778ywd.44.1708961911815;
        Mon, 26 Feb 2024 07:38:31 -0800 (PST)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id c11-20020a81b54b000000b00608d9358ccbsm1085986ywk.132.2024.02.26.07.38.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 07:38:31 -0800 (PST)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-609210a679bso483947b3.3;
        Mon, 26 Feb 2024 07:38:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXKyMQPpHCM2pyByXEOF7bGoZMwJCZ4OlEjGfkkJgm6F4QmlfF+zMOnYzlNB2VhLA6B8VYBCaJDPhnqFgCIly/ynhXIf0yiLRlvC9q8DsRz4XIrqlExtk0VcwJWrkyOlPs0WPPwvmzbkg==
X-Received: by 2002:a25:2fc3:0:b0:dcd:3a37:bdb1 with SMTP id
 v186-20020a252fc3000000b00dcd3a37bdb1mr4995732ybv.44.1708961911092; Mon, 26
 Feb 2024 07:38:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240219170337.2161754-1-andriy.shevchenko@linux.intel.com> <20240219170337.2161754-4-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240219170337.2161754-4-andriy.shevchenko@linux.intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 26 Feb 2024 16:38:19 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXs6eSYyvKO06=ADExrO4agSmOUvm++n077WB=FV70fUg@mail.gmail.com>
Message-ID: <CAMuHMdXs6eSYyvKO06=ADExrO4agSmOUvm++n077WB=FV70fUg@mail.gmail.com>
Subject: Re: [PATCH v3 3/9] auxdisplay: ht16k33: Add default to switch-cases
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
> Currently the compiler (GCC) is able to figure out that there is no
> other choices possible than those that are already listed in the
> switch-cases. However, if we want to move some code to the callback,
> compiler will start complaining that no default is defined. Make
> sure we have all switch-cases equiped with default.
>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
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

