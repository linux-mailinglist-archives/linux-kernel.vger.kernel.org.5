Return-Path: <linux-kernel+bounces-153482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB248ACE99
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38BF62818BE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AECAA150982;
	Mon, 22 Apr 2024 13:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jExadde+"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB8D5028B;
	Mon, 22 Apr 2024 13:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713793516; cv=none; b=h+9bRLjK5tTm/D36VZZY56MhP18yfOY8YV7gx81bNFNlsDDXHTJnmaeFw97Boyfre8u2EIfICwUB7gvuFGXXpc19IEYlSSL1u5jFjym5V4YcFi0nr13Zzfyh8nj5O+bY6yBqkrFoB/0nWJlvRT6dAndbNFW24doqeS6iWwXY5DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713793516; c=relaxed/simple;
	bh=Xv+I/AWrnfGbuhd3Su1CfOwuNvsQXMXHzG4M4Oi9wL4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UhlHObPC87iQFSrcisNTdW6PHBKY207628Mb7LHtLyPFEjmtfVrE7mgV7tffoM2KQQbc2PtPFvPfV/956BfoaUeTlszGH/nf2DPjcl9gSf/ez13uzv7IU5D17xMR+DQtbqCVhlFWAkQ2MNxh8CfJWYHfsWYnr2CvhsTajEtllM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jExadde+; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2dd6a7ae2dcso19769761fa.1;
        Mon, 22 Apr 2024 06:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713793513; x=1714398313; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hBOxLfLCI8MpZaNvMa3DGb5sURgs6UxpjUu52caJphg=;
        b=jExadde+izGkesQ08yTaZz1t846lmLHCva0NTXwSBj/qVOJ8GBwxXvLrHgOs52PDlA
         iaM3beF0xrfaeEdlG3SGnXVjLByeTVKilGK2IsRjUzjGFIurdcaxCGedYRGpFvCtrf59
         o8Z03mAM85OYiopB+/QXWkBgjNFJcAPXUrujlN3NITgpGJUsKReZIxBb2mw0JqQXhMDk
         y31Rgx5zs2rna7z2dk1flvnnV03sYP1T8QgJWPSnjyCzEoSWAQ9AzZ54ZjC7H6YOZqIq
         AQo27zTzodiBCyUYwVtOyehtKo55/v97LAfKh9FZtsNck7/x76Ea2sTLnMhaV8jYtiUR
         Ss7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713793513; x=1714398313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hBOxLfLCI8MpZaNvMa3DGb5sURgs6UxpjUu52caJphg=;
        b=lVfUjfpMhZ8+8ypGl6/7RJTN9UqRYEXI9cXLoyjNUCzQcNJ5UOG+gw868UYBvy32Dk
         YezhlPsDTYUaESeAFB8j1knudkX5zZQveVq27gx1O8WNCMLFL04wsXj/1kiFamiwgUV6
         b6Ap7g4tyPlDdsmXjY1TIKEwW4s58DmxZ0x04Sa8C10buzGJWRbrpLF1x/zADW4mAlMR
         yHAsBhU2qdSBkfCmy2d0CerP6XeVCP5ojMlbacZrKapcq4SCfyHeXLyIy3F6W1H6nmel
         bK2f7v27K6lvqf7u65lXm6PLZyI670+6ES2FDPlzF97+oN7vBQHkMwOW2OUCDPAZqR6j
         l9AQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmUWTvFAqlafr9SL22g4MkYVaFEINrwXASTg6LgiowiwOKtlQ9y9aunI0qnU9o0R9vIJ+FbyMOWFq2VErg1GmovpwSNPNkxqxJwZmz5QyimFOFIJpqerJ+Y+cvEIeRa0a5EuD10tOrKRd9ShQB
X-Gm-Message-State: AOJu0Yxx/GAgWQ2Kftx9QZjVZ6tUi+H7CoSwBjgOZhn5gsm1Umh0DZdy
	HNNvoQEHdW26QDD33SGQoEGWbrY+oyK/0BUiaA/kv30Jq8LLqrl9UFRE6hLfA48vL2vcoiTax7i
	RlH1AEDX5NQJPBQ9+IiZ494oN/EDJTXmT
X-Google-Smtp-Source: AGHT+IEFfGhxb6ipU7LWemFA+rw18CyH7IvwYZVUA6pAOBjmsuhMiDjp127ta1Tiw5nij2AbpaPPDx2TWU7AeL0xdak=
X-Received: by 2002:a2e:740e:0:b0:2d8:2d0a:7b9b with SMTP id
 p14-20020a2e740e000000b002d82d0a7b9bmr8148616ljc.14.1713793512309; Mon, 22
 Apr 2024 06:45:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319154611.2492-1-johan+linaro@kernel.org>
 <ZiZdag8fw8H1haCb@hovoldconsulting.com> <438844e9-47e8-486e-9611-ae524d6974b3@quicinc.com>
 <ZiZkK4BAoqxNg7yG@hovoldconsulting.com>
In-Reply-To: <ZiZkK4BAoqxNg7yG@hovoldconsulting.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 22 Apr 2024 09:44:59 -0400
Message-ID: <CABBYNZJ1H7eEi8qsZUAxOa5HoE=xQ0wb2YFx0g7-SxxkNAS3Bg@mail.gmail.com>
Subject: Re: [PATCH 0/2] Bluetooth: qca: fix NULL-deref on non-serdev setup
To: Johan Hovold <johan@kernel.org>
Cc: quic_zijuhu <quic_zijuhu@quicinc.com>, Marcel Holtmann <marcel@holtmann.org>, 
	Zhengping Jiang <jiangzp@google.com>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Johan,

On Mon, Apr 22, 2024 at 9:20=E2=80=AFAM Johan Hovold <johan@kernel.org> wro=
te:
>
> On Mon, Apr 22, 2024 at 09:04:58PM +0800, quic_zijuhu wrote:
> > On 4/22/2024 8:51 PM, Johan Hovold wrote:
> > > On Tue, Mar 19, 2024 at 04:46:09PM +0100, Johan Hovold wrote:
>
> > >> Johan Hovold (2):
> > >>   Bluetooth: qca: fix NULL-deref on non-serdev suspend
> > >>   Bluetooth: qca: fix NULL-deref on non-serdev setup
> > >
> > > Could you pick these up for 6.9 or 6.10?
> > >
> > > The patches are marked for stable backport and only privileged users =
can
> > > set the N_HCI line discipline these days (even if I'm not sure about
> > > pre-5.14 kernels...) so it may be fine to wait for 6.10 if you prefer=
.
>
> > could you share the patch links for me to review. i can
> > 't find them now
>
> Sure, but you should bookmark lore.kernel.org in your browser as you can
> search the archives there yourself:
>
>         https://lore.kernel.org/lkml/20240319154611.2492-1-johan+linaro@k=
ernel.org/

Did you send these to linux-bluetooth? I don't see them in:

https://patchwork.kernel.org/project/bluetooth/list/


--=20
Luiz Augusto von Dentz

