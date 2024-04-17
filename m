Return-Path: <linux-kernel+bounces-149233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC9428A8D6B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 23:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 630851F2120F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 21:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F02481D3;
	Wed, 17 Apr 2024 21:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ep/096dj"
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5531811CA0;
	Wed, 17 Apr 2024 21:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713387619; cv=none; b=jc7jlBorfLNYaAQWfbwZyKAcsFHB276U03XuShAP7QLNuKXomFYZ2FWQb9KQ6ikElKmcGEDN8qBDLftievQumLkDM547oiebd3rrFjEx87ueQtl1VvW6dm4MpLcAXxrUTN3U0MiwGa8qT9oArX6XF+NNg94dqLtyfhBX9F7eKvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713387619; c=relaxed/simple;
	bh=h0LsziHZrPLdHFoKqTRlSzeeWSNawnGjXerjz6G5plI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mH6YWp5BIlSCNLMk7AcylrtXWw0LKcmU07VDKEFGOYtX5ZPQAAm3QnfCWMvJjUxWrS/6bSkpt9Fq+1PcbtMjpfhHzaNOfqvxv5p/19qtj95hC9iTfab6ppHUVrw3q1bike3CJlfJp/e7ng98FVR794zz1TGS3YbFEXy3R7TTlVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ep/096dj; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-4dcd4cb27beso23265e0c.3;
        Wed, 17 Apr 2024 14:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713387617; x=1713992417; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iSuniwuDrjvFmNVPR3oekSBsyWWc7GZEaP5elvPlAzk=;
        b=ep/096djh8j/cHf/quCa3m6Emk1fbdXQf6lTf4LUspU3xoW3tvmh7yu2pEYEc4IuCo
         2WvwhH6fMbxU8Ji2sCAJEczvvUZ8NNDJ0uxc1BlKhgLtU6kEBTBbSUJFK5aSnxQ0M5FC
         +gptfpCSW8773VmTU/6xhAyFA/N6AV35bIUp9v/4e7qcmeyUigp+LyLq4Oxcb1MY29E5
         QIdjPG4WKZylX7IHm6Z9PnE8C/q4W1FNL5yjrbb4QxrvOh0dIfFxdIulkiZACtf1VqZc
         6G1n526AGEnV84KmZTGtnqvzeebtpy/KMNIrUsRK3zbe8n2AqywJRAPJLPE4zEvYfYJL
         Z+kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713387617; x=1713992417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iSuniwuDrjvFmNVPR3oekSBsyWWc7GZEaP5elvPlAzk=;
        b=XNguRjPkaaw7iEPBeJBEXMwlO2OuQOXnPhdenRWzZmGC/coNdLlrfbue5ULQxfd6Lu
         LdEdwWlQ8Weifd/uk9zTDfCWf2Ia6qSnRQGqA/k9nDzoYc++EYZxh4fCBZA0m4/fGANI
         bhGqo3Q7nXJTgPaCZntRvI+TYovNELRngJYbE5JQI8ie+fgPLHgLP3m0bw6mYDzFvmoV
         fihCA0640K92AJDXIlbct8J05LsXKQrj2b3zUUBNx4GM3z+pSNncxH76KeXfc20dw1Ls
         YcpHZ4oEoUK+bM31gS31iyXHgzujmTVNicCEiwetGt4fT4+bPYljErcgSm6dTkP1RKFC
         wWdA==
X-Forwarded-Encrypted: i=1; AJvYcCU0GXNmn5ZHEAO0uicj4LK6fn2C+AGiLTalpfRtTOqAymS6N6m08NJJf2EB7RV5EuE9KFUiheBf5OUEni0IiG+3fmK9QlQss9t6T2+mLT7WRQ3MikV173t4W0B4epdwMWEGPmwTDhW2eHtqfIjDtEs=
X-Gm-Message-State: AOJu0Yx40f4rVEjHERql33RWRxAio6wMfEpsbf+EY262D76ojpSi7t6k
	unzDgn7N077YDAcW19znbNso1mAL+hkJSMJxkUZRWzin8eqX8elDNjvgLQl9EQEyw46kmBe6Fp/
	2b+Z0Wz4bovdnuUciWu/j912sSLlusEID
X-Google-Smtp-Source: AGHT+IHD84aVtDXQEffOuqP04Y2q6mD1LCgnxpwZv5lEZ6tzn0BThGEsLNCfjT23hZWkEzubn9hjLrEVv4kfzTkiq90=
X-Received: by 2002:a05:6122:1193:b0:4dc:fbc5:d47 with SMTP id
 x19-20020a056122119300b004dcfbc50d47mr749238vkn.16.1713387616935; Wed, 17 Apr
 2024 14:00:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240321114201.359381-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdVvARk6i_aU6B7yPFfAGwaK5Yh=idYP9iuEAHoP9PvjOg@mail.gmail.com>
In-Reply-To: <CAMuHMdVvARk6i_aU6B7yPFfAGwaK5Yh=idYP9iuEAHoP9PvjOg@mail.gmail.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Wed, 17 Apr 2024 21:59:50 +0100
Message-ID: <CA+V-a8sXDBZvOWJzD7SANPJLyeQaSA-0t24KJo=1Wwoz27JLLA@mail.gmail.com>
Subject: Re: [PATCH] reset: reset-rzg2l-usbphy-ctrl: Ensure reset line is
 asserted in error path
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, Biju Das <biju.das.jz@bp.renesas.com>, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Geert,

Thank you for the review.

On Wed, Apr 17, 2024 at 3:38=E2=80=AFPM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> Hi Prabhakar,
>
> On Thu, Mar 21, 2024 at 12:43=E2=80=AFPM Prabhakar <prabhakar.csengg@gmai=
l.com> wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > In the event of failure during devm_reset_controller_register(), ensure
> > that the reset line is asserted back.
> >
> > Fixes: bee08559701fb ("reset: renesas: Add RZ/G2L usbphy control driver=
")
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Thanks for your patch!
>
> > --- a/drivers/reset/reset-rzg2l-usbphy-ctrl.c
> > +++ b/drivers/reset/reset-rzg2l-usbphy-ctrl.c
> > @@ -132,8 +132,10 @@ static int rzg2l_usbphy_ctrl_probe(struct platform=
_device *pdev)
> >         priv->rcdev.dev =3D dev;
> >
> >         error =3D devm_reset_controller_register(dev, &priv->rcdev);
> > -       if (error)
> > +       if (error) {
> > +               reset_control_assert(priv->rstc);
> >                 return error;
> > +       }
> >
> >         spin_lock_init(&priv->lock);
> >         dev_set_drvdata(dev, priv);
>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> Alternatively, you could register a cleanup handler with
> devm_add_action_or_reset(), like many drivers already do.
> Or better, turn devm_aspeed_peci_reset_control_deassert() into a
> generic helper, and convert all drivers[1] to use that.
>
Good point, I'll send an RFC patch for this.

> That would just leave us with undoing pm_runtime_enable(), which can
> be automated using devm_pm_runtime_enable() instead.
>
Agreed.

> [1] git grep -w devm.*reset_control_assert
>
Cheers,
Prabhakar

