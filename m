Return-Path: <linux-kernel+bounces-162455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 533118B5B7F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B0D4281457
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166DF7E772;
	Mon, 29 Apr 2024 14:37:37 +0000 (UTC)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58DC7E105
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 14:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714401456; cv=none; b=Bj89VxL2QLWngZwBLWHvgf51yja70uYSSBjdwYJr4rKgnBYafNoEI0IsY5ljSy3c2Dl6j1c+VXuQ2jb48QCg+V/2HPa16Fl5sINsq3LjlyB6ARBQ9je4Hp8CdFZWGGiHNRmUyF54qD9heQW5lcbxoRZGzNH8Zg1U5gJCMwiDvDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714401456; c=relaxed/simple;
	bh=o76I6uYyuIHYHMcSkzurzNhgHFDpP4E7YAUzENMyBn0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wp4LlIWBA2qpA0YpdrAKGpGm6+czKmH6VzoMAY05vVZQK9ZZfhQnP8bxDLtPa8vyeTPthrxZpuuXYfFKm4OPPQCI/82q84XAS26zqqabbByNP3mKVNT9+6mhLJICMT/6vwRkLkCLBuAP3R3qSrMOjHV8c0UnkUqyhpwSlxplkJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-de54cb87998so4876777276.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 07:37:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714401452; x=1715006252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1B8TUxX3GMUuuf6X9eCvF4beZUOUbPqjMpWnhsqSxGE=;
        b=cj8hnyeJk0TDAftS+LxaVqUlBG+DXz8Iq84lWhQxITlV4om9Xb+jIzkPnnH46p0sIK
         z6JJrcJKEp+pT+DzWNNnIlFpPnr0FpQKN/EcyD3XUKdUnxSqmwLen/EEgO0YHr6dx2IJ
         NGRvIRe9BTAb9j945etX2lSxm2TuQNaLrZyr3sPAbnXLBruSEtISbaDzxuKOxtbOsNsF
         AIexIwFgfnEhOyNDDx7SLB61pvQcF1b2ACYi3s3ZJm+J6ANWnVzoDSeY5aFJaubSUcrY
         3kqiZoxQD6YmZcVr0JUV1a+Fcbb3tQYsajs+qh7Ga6wUmpZ/qXwnj7Nl8gGZSAQ0wp19
         P3gg==
X-Forwarded-Encrypted: i=1; AJvYcCWePtzZ+PgqqoGgMuH6XOaKVGmNQ+xEK8XS5wb9K6c/2uo0cFigDTJ/n2HMYVZIjkZXwu5fSBHVvsjpdk9qciD9Y/cPG3eF5wEOVGwv
X-Gm-Message-State: AOJu0YwxaeUklAKv30c2TI37wf6iQP/+N8cspIndkBwJQELon+2w1G+q
	ArtxN5+6lZEkPwKaXdzk9R+YW2yrXqNWDlPBYQbOceQKW1nlwMKEN0Lx8LRW
X-Google-Smtp-Source: AGHT+IEkTNx36IKCOzAK6M8IDj7To112Rew8+PT5tFpgZIapR9YHscf9FmAHMF2RZeKbzI0zd2tf/A==
X-Received: by 2002:a05:6902:220b:b0:de5:4a91:11c4 with SMTP id dm11-20020a056902220b00b00de54a9111c4mr13778234ybb.44.1714401452551;
        Mon, 29 Apr 2024 07:37:32 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id a6-20020a258706000000b00dcd2c2e7550sm5546689ybl.21.2024.04.29.07.37.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Apr 2024 07:37:32 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-de5acdb3838so3334495276.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 07:37:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVTckxnLENU4uQEDQ3eSYe4OS0pPwfnikjiFTMdHWKgpGcQQenAslkb+y0zAKr3eS2Qo23sWOtyj8mJnKYzaUenTzdKCY3gKJS/eEQA
X-Received: by 2002:a05:6902:2187:b0:dcf:a52d:6134 with SMTP id
 dl7-20020a056902218700b00dcfa52d6134mr13962181ybb.26.1714401451935; Mon, 29
 Apr 2024 07:37:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <419fcc09d0e563b425c419053d02236b044d86b0.1710298421.git.fthain@linux-m68k.org>
In-Reply-To: <419fcc09d0e563b425c419053d02236b044d86b0.1710298421.git.fthain@linux-m68k.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 29 Apr 2024 16:37:19 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUGAAqJsget--=ZZ9CejfPt5kLPkXFJkh5hfZrzhs8hzQ@mail.gmail.com>
Message-ID: <CAMuHMdUGAAqJsget--=ZZ9CejfPt5kLPkXFJkh5hfZrzhs8hzQ@mail.gmail.com>
Subject: Re: [PATCH] macintosh/via-macii: Fix "BUG: sleeping function called
 from invalid context"
To: Finn Thain <fthain@linux-m68k.org>
Cc: Joshua Thompson <funaho@jurai.org>, linux-m68k@lists.linux-m68k.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024 at 3:55=E2=80=AFAM Finn Thain <fthain@linux-m68k.org> =
wrote:
> The via-macii ADB driver calls request_irq() after disabling hard
> interrupts. But disabling interrupts isn't necessary here because the
> VIA shift register interrupt was masked during VIA1 initialization.
>
> Cc: Joshua Thompson <funaho@jurai.org>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Finn Thain <fthain@linux-m68k.org>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
i.e. will queue in the m68k tree for v6.10.

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

