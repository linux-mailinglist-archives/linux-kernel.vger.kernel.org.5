Return-Path: <linux-kernel+bounces-44533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE57D84235A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:40:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CD0D1C2117A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B42679E6;
	Tue, 30 Jan 2024 11:40:04 +0000 (UTC)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DECE67730;
	Tue, 30 Jan 2024 11:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706614803; cv=none; b=PUh4PKn1kJYRJuZX/ZFoqVCfSUtndSGqhs41KuBMuR7edjg3ig52cS1Ut45yJLlzRRUm3/KM08oTUJSV4B6GXJ/B2oQ3Tk1dY260ARNjH8JiAag7abSoA+9N8dEXa4XdYXgrolfp6ZNFdlv0blYM2iBuoAjcqrAbFyXBp2eb6oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706614803; c=relaxed/simple;
	bh=QZi6hH3hCiwolBzzRH1I95c2gokGmaqMuHyc4kuOpDA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bvrfnm1T7rw+vYfGYNKSoKiFCBSKOToUJVU5Y5G90vJjUw7FgOcmxTO5ARet/3jMcs0juwf/IvKNq/pohDyU+J6277BDjJ4MJe0Cu2ZjZx8dVvjjZNnKsSsegbDZYDGN47c0WyDzmSdljl523JYTDP+9THrIdDtqxKaSy/owxqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-602cf7dfeb1so36658017b3.0;
        Tue, 30 Jan 2024 03:40:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706614801; x=1707219601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zZlJC9u1HnC8q9K+3pMnjJXJAMpe7B2980by2Js6G+M=;
        b=EJ8D2kGZIdQS4cxSVJK1JXMzs0wRRUh/jnw7MQ02SClj96o6XzAD/tX646VLEntzw7
         j/ZOWrKq+rkthtieY0NP1knmUjBcVEeT1D0kXgzc/fA3Oor1HvP63fLxgeyazp8Kaqx1
         e+yu74pjPsMgnTZdIfJSR8Jza8ZZAm6lSh4XhK015FL6vY8YJdzGdQUiKCr8WEJaA9yA
         p3dWmrzQsEQxRwbpN/E2nVL6jVu6ujoeDG1Qsh65QJNnQvn0gyBc4MKQGUtxghra015a
         eVfzcOyTw4XBHUXUCuvVe4LcnvTL75itvnQ9mqiwb6qGxKrFyniQyxORTR3vey9kuW5z
         g/Pg==
X-Gm-Message-State: AOJu0YwoimrD5T00FDlYJ5ON9Q1p67WdKkPL9LK4uUhHduPWEcDTr4HL
	0ZvlADu44xKhcx/H4hFQEpUAQ4Jhfin5DzD46PLOpTUSJxPPE2gmg6XcOkZY7wg=
X-Google-Smtp-Source: AGHT+IEoWmE+U3Rh9KZsPcID17g8PAwntMd/z1cKsI5vB7fXdUxMonfFVaDauymTTY3ZC4yaSNEMBA==
X-Received: by 2002:a0d:d691:0:b0:600:3cf0:955f with SMTP id y139-20020a0dd691000000b006003cf0955fmr5456111ywd.43.1706614800844;
        Tue, 30 Jan 2024 03:40:00 -0800 (PST)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id gq7-20020a05690c444700b006029b98821csm3095188ywb.3.2024.01.30.03.40.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 03:40:00 -0800 (PST)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-5ff7a8b5e61so36013147b3.2;
        Tue, 30 Jan 2024 03:40:00 -0800 (PST)
X-Received: by 2002:a81:490f:0:b0:5ff:81bb:8135 with SMTP id
 w15-20020a81490f000000b005ff81bb8135mr5960801ywa.32.1706614800402; Tue, 30
 Jan 2024 03:40:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130094053.10672-1-wsa+renesas@sang-engineering.com>
 <CAMuHMdUMeHCCiAkNyJMHTGUSTqewt=AWPUy+beA_kR26vcS8_Q@mail.gmail.com> <Zbjc_p_Pin7TAHw4@ninjato>
In-Reply-To: <Zbjc_p_Pin7TAHw4@ninjato>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 30 Jan 2024 12:39:49 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVBXXpv9QfttBETQAeeRQjWRvfVJnrpPNiQj-N1SB9GQw@mail.gmail.com>
Message-ID: <CAMuHMdVBXXpv9QfttBETQAeeRQjWRvfVJnrpPNiQj-N1SB9GQw@mail.gmail.com>
Subject: Re: [PATCH] spi: sh-msiof: avoid integer overflow in constants
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Wolfram,

On Tue, Jan 30, 2024 at 12:26=E2=80=AFPM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> > What about unifying the individual SIFCTR_?FWM_[0-9]* definitions
> > into SIFCTR_xFWM_[0-9]* instead, and using the bitfield helpers in its
> > sole user?
>
> But they don't match, so we can't unify them?
>
> #define SIFCTR_TFWM_1           (7UL << 29)     /*  Transfer Request when=
 1 empty stage */
>
> vs
>
> #define SIFCTR_RFWM_1           (0 << 13)       /*  Transfer Request when=
 1 valid stages */
>
> Also, the steps don't match (1, 4, 8, 12..) vs (1, 4, 8, 16...).

I stand corrected...

/me looks envious for a brown paper bag...

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

