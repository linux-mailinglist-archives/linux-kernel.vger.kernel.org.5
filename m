Return-Path: <linux-kernel+bounces-105816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 788B087E4FA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 09:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C3CA1F2233A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 08:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF25025779;
	Mon, 18 Mar 2024 08:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XiGab2Lq"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3138817BDC;
	Mon, 18 Mar 2024 08:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710750661; cv=none; b=RG7BcWr7h0JgnO72fnhlFfn5wh3QMo471NG5lWTH1iq4kTVTmaYu144siUlvyuNqEGeQ5YQHJPBaskruQUHYUCP/gKtcIsx+FdKVYWGT8MTxxCruwsHyxo2xoU9WG9qVYJdAzw+0iXOADl9fgSAPuZi98fkGypHxHa3fiKOC5PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710750661; c=relaxed/simple;
	bh=aTNcL9rcfGV2tcNiBwK5lOr/N1TktsH+wMZ3yS/auuE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ebqwfYoqd/1AU5mRmH1nErp7MpbAGsGkqV/WFden2erGLI9NNP8pX8k4Tgqbv8WGHcNQhYJfhPLmJM8oGfnx8YAtns+raucdmLkjwboUbtiWkuQPsKfLnilGuK43K6ZQ0it1zwFPUKiVda8BvxG7SQrvlrGV4u1cILJB40vem9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XiGab2Lq; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a28a6cef709so588968366b.1;
        Mon, 18 Mar 2024 01:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710750657; x=1711355457; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aTNcL9rcfGV2tcNiBwK5lOr/N1TktsH+wMZ3yS/auuE=;
        b=XiGab2LqgE0wQZIzUH1z32uPHQsLF//X/wc/FJSwcrU6rULvQKqIz99NXD/0K/0Q/e
         C7pDfE/SnnPU1Y6oNk8iOnYLUOl8sK2WifbwI7bNSfZoc4oBNUCg/rECPrPxbRx3gNJI
         ODceExjrADCjWHQZLat1zkAF1J/3mfO/EVk8spzYCXyTYj+lCcRedSnin4TQDtCmic12
         QiGOtpmGCgaXDiJF+qMxncs7pTy5qTWhJrsdZjvY2nG2GDkzsE+1/VPhxvSY4FAS1UN7
         HNrV77aJvSS+si1CnToOTGYxG131VYT++GSCBrCzcB0ydGC79JhpIngOIwJ3mLKADWCG
         6ZAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710750657; x=1711355457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aTNcL9rcfGV2tcNiBwK5lOr/N1TktsH+wMZ3yS/auuE=;
        b=E5c4otVjzJxij5gEjEjQhTEwEsrY8xcDvc/zNEvGpUqlJIzcdu6p37+W30pz8mIy2i
         O/mKPBl4M3mii5wBZJGCW8OV5xOSMGatpU+VbM/E5gw5XJV1scC2eLgY4Cg74xPCFVBl
         7L0p4Ot+O/0rQwkdcSM7UlMjM0mZ16bMMFoxvZfXzBAw8Z/xmwuDQBfqFV6q24DhxGLX
         3jW2vT1OLxSpq9hO4rtJH5Ks8iQIGK9e5RM2QusHUnMQCdInN+o+4yECl8c7A19fBE0a
         T/4UQhRvdHwTzolAiyBf+6KnucdscdGhg6ewfTwsYAq6y/4BYr4NOx3HcmurHMSyj7S9
         8Igw==
X-Forwarded-Encrypted: i=1; AJvYcCVDkTrtaQdA5HHVz9OUDabnWzVRtNAJDuczH1y+ZVatdjvgf8N2oPiEyCGdiZxboWfyuqGNeE6aihMgO3/Rd51zHuj9gnXp68eRaY7ZErJ++ROv3io0X7Qh8QqM7Gw1bb4JTmeInFeZH3kQ
X-Gm-Message-State: AOJu0YwjKEID2gIEFgae1zZG8PmWng/XKJcbT3lfZlwMVvDPREUabXsY
	aZLJlNksx9VdhzRcZqM2+Ls0lcO+Tq2lTYCPseVZU3yPYdGxHTkG4tOIPA6xTf8Wsf/jlx84Ron
	+nJcja0zR8DAWttcqnKkIczemjwE=
X-Google-Smtp-Source: AGHT+IFyaKnmaYXudEyFpeZ0cn0sigVZg2eBU1E8qctUy87AClRrA3bZQwHovDEJ9oU8GdXOEMG94TJ3ap3HpbXA43M=
X-Received: by 2002:a17:906:f8c6:b0:a46:13a0:7db1 with SMTP id
 lh6-20020a170906f8c600b00a4613a07db1mr7381944ejb.7.1710750657287; Mon, 18 Mar
 2024 01:30:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240318064036.1656-1-wangkaiyuan@inspur.com>
In-Reply-To: <20240318064036.1656-1-wangkaiyuan@inspur.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 18 Mar 2024 10:30:20 +0200
Message-ID: <CAHp75VdyJGy6niQBNEX_C22_kDjdf-4tbe+ybLF=+GwZRzpg_Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] tty: serial: max310x: convert to use maple tree
 register cache
To: wangkaiyuan <wangkaiyuan@inspur.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, hvilleneuve@dimonoff.com, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 8:40=E2=80=AFAM wangkaiyuan <wangkaiyuan@inspur.com=
> wrote:
>
> The maple tree register cache is based on a much more modern data structu=
re
> than the rbtree cache and makes optimisation choices which are probably
> more appropriate for modern systems than those made by the rbtree cache.

FWIW,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

--=20
With Best Regards,
Andy Shevchenko

