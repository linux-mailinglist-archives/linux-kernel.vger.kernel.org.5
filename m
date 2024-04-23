Return-Path: <linux-kernel+bounces-155328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3E88AE8F1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 16:02:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 198DB1C22939
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608D513D2A0;
	Tue, 23 Apr 2024 13:59:31 +0000 (UTC)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE40613CFBF;
	Tue, 23 Apr 2024 13:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713880770; cv=none; b=uv++KsR3JPIyzTNngMaqLy4ldRbY9SyodjCDKzvetaJaIZJLy9RU2MdpBSk7ziZwJmPRzStDVIdpKa4jwaVLUxfBs0iy0HHGClNDQWvlLtx66YG0JaXH55iyWDrAqwwOs0Lo5+ujMyW79l+7a2KaywJKwb4PdydkBqxJiV28kKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713880770; c=relaxed/simple;
	bh=0izXReL0Rq3fK4pJRtpsZSNyCSZDawUyOeWoMHjQ09k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RwyIIm2Uo8MYybBcR8exWloYb5gcL+I5jfXrGeV8qsdeUIag7L5j7xJaoMYvxVXE+KBrezRt6uTi5ItMSNNoPW2uXJC2+LTTM2IanDEU2hMtHHiKlFP/aiRbmnvGXa1PaI6LgKNWcESSCYABgjSLbx1Kte2yDzRPV065cBvbgog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-617f8a59a24so47330927b3.1;
        Tue, 23 Apr 2024 06:59:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713880767; x=1714485567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LARPRLMq1SiLQ8Aw43h8gLmlW0F7jfV/URLOW5h9Mts=;
        b=qctLPIaedOL68TPzBJ00YGA2WFLrImEOMQ8d8ZA9MYYxJeSR165oatC06zs96i2Cqj
         l3S1NT/78oFMqGgcBJj6+Om8ac6gsdat6pELzg6CRiyvJxKtSrnZKXbYX9y+eocdmJg/
         VRsPVGcR273zF5hXSwufdDB0KX7z064mcNh8ZxKPag7sKVld8j140Y22Da8tZ12egf3i
         J9ZAbwkKiMDWHy8cQOcTqQikJPpg1lrgJjOmFb0w8D7ojjV8oT3aj0flWmoj3huttw7u
         rvyRHv+QFYER8+XFgwIqxkY0nr25hsXAYO+jrpN7xW36XJm5RFpbN+z28OHAibauxm/z
         29PQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2iB21kC1dI9aNsrNaR3rL5iX9VXO/8uzuq+Vj1PE2LnsfZ02UozNJRBABEkF9HbbrNDDa++19+cQ3QEDFsGkJLuh+vDMY2YwP5pGRfrvznfoZ5bNp33vXhXHS30l19NScPTX6Grdf
X-Gm-Message-State: AOJu0Yxd/iH65UufWfy4S2k+myOh5FGPZ7tWGYpcatv+8DgSgR0L4icX
	sZxyZ9kEWbSk4r9WD6UMnhGOkXSZ3awA/6QSmNquX9N7g2qHQkzcwHKe4O4G
X-Google-Smtp-Source: AGHT+IFpL5GVUEW3fxJ4nRF0cOOI2eDoKI+dSpOw/xK8uE/8AyJrJTx8/wdLS86Yzf2VF9wHQ+j7tA==
X-Received: by 2002:a05:690c:6188:b0:61a:e48c:38b7 with SMTP id hj8-20020a05690c618800b0061ae48c38b7mr15257440ywb.41.1713880767364;
        Tue, 23 Apr 2024 06:59:27 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id m3-20020a0de303000000b006152af6131dsm2487303ywe.119.2024.04.23.06.59.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 06:59:27 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-de46da8ced2so5562137276.0;
        Tue, 23 Apr 2024 06:59:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXwwymjyWySYWwC6fuOisTYW8fSL2CtJwpZEcHw4Q2KlJQVcO0tx/7tBAPmvdwSB5cf2EL3ogHGWUI2BzxeBVTxnu6UAivCddhmeRj+HwyrWiAEIlz2vDNQ9DKpbvNmxDPKsYEh55HX
X-Received: by 2002:a25:8209:0:b0:ddd:7456:d203 with SMTP id
 q9-20020a258209000000b00ddd7456d203mr13410005ybk.41.1713880766869; Tue, 23
 Apr 2024 06:59:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240423132024.2368662-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240423132024.2368662-1-andriy.shevchenko@linux.intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 23 Apr 2024 15:59:14 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUcafU3nLyam9CL=FBS=ZitHykbXh=fqz3ahO3oVEYALw@mail.gmail.com>
Message-ID: <CAMuHMdUcafU3nLyam9CL=FBS=ZitHykbXh=fqz3ahO3oVEYALw@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] Documentation: process: Clarify use of Cc:
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 3:21=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> Add a couple of recommendations on how to utilise Cc header in
> environment friendly way.

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

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

