Return-Path: <linux-kernel+bounces-139969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B329B8A09CF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D3912856B5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9134D13E051;
	Thu, 11 Apr 2024 07:30:48 +0000 (UTC)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860B013CA86
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 07:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712820648; cv=none; b=rbTVah+ufqWYSBsW71fsmqlcmH8Vuc3xdffYcNfwPLgl0L0eQemOSHgiviLUjFc0pOs/E+SfbSmkxhXaM4x62Kfc4aEj30RG+zna6kmGeJj5Fmtlg/PU2NbvMBnORcBxz2zMTEavAHQqufT+lF+CxF0JKdFIwZcqFjO4Ys3qbuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712820648; c=relaxed/simple;
	bh=pez9jQTDttZQRiqEOkAfLPa9CfiiZp95gi1hVzEfONY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A77b4uhniu6I0XbHHgHagbjJmG/wLikK9BO6UWtw9aQmx4r3nRtMwlrtc285V3685MftF46XW8SaQRaDBIlgJBKQseSMu/Iv4/AgXQWN4o3NPoP7tSxLnyiRvFl83HA8WE6kxmteTEN3PFtAWZM36nn1EZtkMMD2v17XbkJ3TZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-61816fc256dso39225597b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 00:30:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712820645; x=1713425445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=huaVbJOvsvC89aSq/ljpkq5lTpDfnQw7dMOaaZfbyEI=;
        b=wv9h+rrSz94Mw5x8TK2t+aXkupV1LU6POAXGs1NtnKoBiL2v9CQL11MO17Vp5FdzEN
         P2/THpB92gJn/GnUGSh8fbMjLYWxbrw7De9UzMn4rxB3qPTvRARnXtTA+iAa4cpBF5dA
         8F4xALlXEfsPkANWffhnCO9oWe3HX5ytmMe8ubtbqY1ffiqWejNGoUop7+g1mywQ4QZj
         4MuE3yZ9U3WRH+msHPTtBKtDarXNf3uVWtyXJi+ef5Fe6mdpOOgAZl9+qspPxXinjwuQ
         j5KxlFa7ltMlSTBiPV8NY0Oa92agc+EGNI6u9bcHHIXnZZZiOvQoLgoM2/9VJ03B2Ptv
         SrSw==
X-Gm-Message-State: AOJu0Yx4ibTFmLaMx5L2jfF/pdv5/wMrMaHmSKz96p2PFuwkUQYgS5Y0
	32EDQevUTjjBRabDwS/C9uBsYn7oLRnz1inlpnbIB7g6geTqtzHRpW6KZkgz
X-Google-Smtp-Source: AGHT+IF3QSurFqgGA+n4seqN0LNatWB1K73x7je2hPRvF+tkjFJ06imhnL4I5i/CPwEEe8KmL+Orhw==
X-Received: by 2002:a0d:d80f:0:b0:615:35e1:e512 with SMTP id a15-20020a0dd80f000000b0061535e1e512mr5222535ywe.0.1712820644764;
        Thu, 11 Apr 2024 00:30:44 -0700 (PDT)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id u1-20020a81e601000000b006167f45edf9sm192819ywl.89.2024.04.11.00.30.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 00:30:44 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-db4364ecd6aso7939539276.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 00:30:44 -0700 (PDT)
X-Received: by 2002:a25:bc4b:0:b0:dc7:43fe:e124 with SMTP id
 d11-20020a25bc4b000000b00dc743fee124mr5115225ybk.11.1712820644434; Thu, 11
 Apr 2024 00:30:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240409161523.935384-1-andriy.shevchenko@linux.intel.com> <20240409161523.935384-3-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240409161523.935384-3-andriy.shevchenko@linux.intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 11 Apr 2024 09:30:31 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX_n4kifH6F20tt-umtL3rY9zb6=XmgrnXvuOJSibhrEQ@mail.gmail.com>
Message-ID: <CAMuHMdX_n4kifH6F20tt-umtL3rY9zb6=XmgrnXvuOJSibhrEQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] auxdisplay: charlcd: Provide a forward declaration
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Andy Shevchenko <andy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andy,

On Tue, Apr 9, 2024 at 6:15=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> While there is no compilation error, strictly speaking compiler
> should know about used types beforehand. Provide a forward decoration

declaration

> for struct charlcd_ops before using it in struct charlcd.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> --- a/drivers/auxdisplay/charlcd.h
> +++ b/drivers/auxdisplay/charlcd.h
> @@ -36,6 +36,8 @@ enum charlcd_lines {
>         CHARLCD_LINES_2,
>  };
>
> +struct charlcd_ops;
> +
>  struct charlcd {
>         const struct charlcd_ops *ops;

No forward declaration is needed at this point, as ops is a _pointer_ to
the structure.

>         const unsigned char *char_conv; /* Optional */

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

