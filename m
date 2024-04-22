Return-Path: <linux-kernel+bounces-153343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E128ACCDB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 14:39:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C50F41C20D7B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 12:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270EB147C74;
	Mon, 22 Apr 2024 12:39:18 +0000 (UTC)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6D2146011;
	Mon, 22 Apr 2024 12:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713789557; cv=none; b=kiH9CDwaDNyVYXWqrLbrGRf/dItdonXVJ3bUP5AUUxZQO/DvZ4XG9ehdppuVBfByCpL3kEk48KUC5G2DOcmMCFQCAeJv+HM5ovRG0GCLYLjSV5vvl3fWUMlcjp8pcr5ghwBFJVhf7oG8s8W3d8UIg79LSPiw/Fmg9EDY3jXyPK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713789557; c=relaxed/simple;
	bh=1xYqXXOCg8cH+eLna2SIoRUtXjWDA5Opt7wSg5dXJww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H1sjGbwc/K1g083iRyy8Gb4OFX6oSCrMKGaEMTqRgrYRLkZD4NRB2BWKDBd+d1t71D5L4P9yWg4WnywDoT20NJr2P8o1VBPizaeLprHt21Ed+mn8VSDRyxNcoG2zwv1MTT4YJHs/+Z4RYXCxBdQvpE6XFobqsxSDVu4IR4hUhE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-de466c64161so4552369276.3;
        Mon, 22 Apr 2024 05:39:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713789555; x=1714394355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xMBL1qo4g2eaajNMXZyEJbZLC89YfXgje/CzAO+pyC4=;
        b=SREk4G04Vr51JcLtUHKsjiB5DseaT1u0y0wMla7SMOlvl2R4iWaArfJHJSb0Y0g/S3
         o0MwTX3EdZPJuZboEnTOqrI160q3Jw3DpYYNNy4wjrNE21qS3njk2P3Lw0fOnE+t+RtV
         uBosZ6QGrVdAxrWL9FLljseDdKAaoFz3QikjrfgBZU5SsAJMVe1VqmJRf2j1kWp2i752
         dzD6mwQV2rDo1iHYvEID5Ywi3VoypNlpQtnXlde55qzAXQ/lSNac4W0D3nNuIQ29/pl2
         kWQCR9s8z1ZUXBGsEe4UyGqoBvgNB8omSA/+YilXPkSd4nKO7s9z4KH/zXHwlbxgkuPh
         nGIw==
X-Gm-Message-State: AOJu0YyPhzeNP1ySJHj5+kLIrQAcS6MAV/u9Hda8plJeO+2qo5g6aQ1b
	j81VLAVIrhoKkrNUkX3I8GX68UD8Y2AitoNgKc6dFt9FFedIr0DdHTIDtLHv
X-Google-Smtp-Source: AGHT+IFoYQxllOPUi1dR8w+zve6uhTrIjk0cU8qEEDxWhi9OWbIVixZwRWJq5ch+SGSeIB57nVEiiA==
X-Received: by 2002:a25:5f45:0:b0:de0:ea71:9ec9 with SMTP id h5-20020a255f45000000b00de0ea719ec9mr9228855ybm.1.1713789554630;
        Mon, 22 Apr 2024 05:39:14 -0700 (PDT)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id y9-20020a2586c9000000b00dc9c5991ecdsm1920014ybm.50.2024.04.22.05.39.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 05:39:14 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-de469a634fbso4432496276.2;
        Mon, 22 Apr 2024 05:39:14 -0700 (PDT)
X-Received: by 2002:a25:213:0:b0:de4:5f9a:157a with SMTP id
 19-20020a250213000000b00de45f9a157amr10282671ybc.36.1713789554244; Mon, 22
 Apr 2024 05:39:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=whdUP62_7N6s837tTFjvmcGxyRnMGwnVnZwn2fDVf5E8A@mail.gmail.com>
 <20240422123617.1363267-1-geert@linux-m68k.org>
In-Reply-To: <20240422123617.1363267-1-geert@linux-m68k.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 22 Apr 2024 14:39:02 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV0yf++WWeih15YVHomAaji9mW+VYg0B4sTDNhD28FY3A@mail.gmail.com>
Message-ID: <CAMuHMdV0yf++WWeih15YVHomAaji9mW+VYg0B4sTDNhD28FY3A@mail.gmail.com>
Subject: Re: Build regressions/improvements in v6.9-rc4
To: linux-kernel@vger.kernel.org
Cc: Linux-sh list <linux-sh@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 2:36=E2=80=AFPM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
> Below is the list of build error/warning regressions/improvements in
> v6.9-rc4[1] compared to v6.8[2].
> JFYI, when comparing v6.9-rc4[1] to v6.9-rc3[3], the summaries are:
>   - build errors: +1/-0

  + /kisskb/src/arch/sh/kernel/return_address.c: error: no previous
prototype for 'return_address' [-Werror=3Dmissing-prototypes]:  =3D> 14:7

sh4-gcc13/sh-allmodconfig (seen before in other sh configs)

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/0bbac3facb5d6cc=
0171c45c9873a2dc96bea9680/ (all 138 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/fec50db7033ea47=
8773b159e0e2efb135270e3b7/ (all 138 configs)

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

