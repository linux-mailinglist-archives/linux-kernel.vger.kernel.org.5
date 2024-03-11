Return-Path: <linux-kernel+bounces-98662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1188877D8A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 11:02:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E102C1C20BBA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 10:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B4A22F07;
	Mon, 11 Mar 2024 10:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aDMAzFcG"
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E9222338;
	Mon, 11 Mar 2024 10:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710151322; cv=none; b=AlKaJ3xouUWTBWY8dePLkCAc2dSag01uGyR/4hF1jewbVzr3QkkV146xHxsZgpHMoTCvvTIdvHoR4etLNwZbnPMY7NuGNxiBvL2v+/W7ufDoljlqMjGZiE0jzOcOB4y74XoNvuqMHA9CODogjDWLtav1z026Y7h5zi4vsufPhDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710151322; c=relaxed/simple;
	bh=C0lZ6B2LOqG14mkDCWHzxUAa9DXdg3M75sHJf0k3SEM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gEclJZvtiPArRhKSkkmn8ONFXFAaYbDCz51VK/c2gnGOJk0fJBFeyG+qff+m7SRdfx+IgLyuQK7grEjqcUBVJi9pHlD9Az8dyWh6nNnJE+p7ogio34IGGMfgRj/1Ice3qJxT24O3BdDgxdilpwZtZoukhZ8HAa8EHeYER49Bgqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aDMAzFcG; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-221a4f9557dso2102308fac.2;
        Mon, 11 Mar 2024 03:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710151320; x=1710756120; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2+Wn2Uqb3xw0M3yXxu8yoQDE/POXlxhsfE/KZsuL0tU=;
        b=aDMAzFcGemQ/uowqJb7t76OuYzYbEZ8CMZ57XUHI7/bQZW8fK+n5p2Jjm1FSFzk9cB
         1zJClDgUdVPS9CU2Ic2Wjkkos41XTv2vo/aezYXxVF57mzBkjTMKtVP8bT9eD77xo7eX
         M0l755pyNPCNisP6VN/PNYuh75RlTCaDt6OVc/B0piTRCA+gvlezXs4789IqBTpH08Yp
         4EqTQ4QdaVz1NlGKYnYeyGvjCuK8vS8x8Y3lQEu9PyQIH/+d7U+latW5Btuc7OShfxxa
         88tVryxmnd0XzOQhclEI+sJQGCx9IAf+gTbWCVtbyUFZBYXY3EFZIdf5dNEYRjVDloOU
         6I1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710151320; x=1710756120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2+Wn2Uqb3xw0M3yXxu8yoQDE/POXlxhsfE/KZsuL0tU=;
        b=gY5+yuf9Xve7/NRAacFoCI2t5jq4HA0ogV7g7mOhy29e0UKYR+y4/mAwN9UfCIlOmH
         0FS+xbtObPblo3OIog6IsVSO1iZdSzzbUrIhnbt1Mx9F1F81RXRojrfJo9FU9QdcestT
         hHqYeHhYvYRNb+nI65lPdFY5vRias6Vw6OQKyQJ9JRjonAbdYwlh6klxbevzzIO0AIl+
         g5kkGGadgGBaWTIBJ1jyi7Q/52ln9cOPmTUcr0pfs7+DnbpEma8gSnIDyLsdgNXSYQqk
         U0MzfG/HEWRv7NFWqgoyjljmbp4keoNEVNd8TayGDXzNrI0HBwfqPTSfJ+/dk8z0fj/B
         Cn+A==
X-Forwarded-Encrypted: i=1; AJvYcCUEOCIYx4DhPtS+B15pN9orRgs8HmrGUKJY8PywXrCPTWB98GBtyvd86Wtry0AJM5QlbkJorETbnsFBBqSS5IP5OXiVZU6FFSgP0zaA
X-Gm-Message-State: AOJu0YzLIPeI93F56Ugz55XiRlVSQsG/R/tFfzQ/HAZJugqy+7mmq1pU
	0ywFFqPex+jIq0ZqQlWnyNdKHhQy/lEMJl6ae1RkzSt1KBcVfb8XQJSaJE0nZP2/kI9NCMCD7wK
	VSb2kNVsJd7ZlzgEIHIrRy5Jp95A=
X-Google-Smtp-Source: AGHT+IE+HdXxVacCokVXm6AG1Enh2GRrurBbBK52TD/DZnfbOMy3nxz2d4aziM1/T87eix+xubS28lgFRxatZxaUF04=
X-Received: by 2002:a05:6870:1097:b0:21f:9c60:dba8 with SMTP id
 23-20020a056870109700b0021f9c60dba8mr5592419oaq.4.1710151320411; Mon, 11 Mar
 2024 03:02:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311094559.547083-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240311094559.547083-1-andriy.shevchenko@linux.intel.com>
From: Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date: Mon, 11 Mar 2024 11:01:47 +0100
Message-ID: <CAMhs-H8kVSrY-2upSEnLp-F2MXzSu3sCN1st=JghBMrT27buXw@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] MIPS: ralink: Don't use "proxy" headers
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
	John Crispin <john@phrozen.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2024 at 10:46=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Update header inclusions to follow IWYU (Include What You Use)
> principle.
>
> Fixes: 5804be061848 ("MIPS: ralink: Remove unused of_gpio.h")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202403090727.nLhljNp6-lkp@i=
ntel.com/
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  arch/mips/ralink/timer.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)

Acked-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>

Thanks,
     Sergio Paracuellos

