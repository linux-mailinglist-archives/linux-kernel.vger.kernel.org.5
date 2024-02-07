Return-Path: <linux-kernel+bounces-56133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 341A184C678
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 09:43:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7B001F25492
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 08:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E487E208A9;
	Wed,  7 Feb 2024 08:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mIdW6Q6L"
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06BF224D1;
	Wed,  7 Feb 2024 08:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707295413; cv=none; b=nSEsHSqsLH8OprFXHKq5KDjoKHv/Bj0NE9A3zJFVg//zg/0l6l5O0GtkOd4v4GBPzmiHcaOsWxg8NUIU8hL5nCW3OVNAmSn28yeOCt4NIYxkxlHiG1Ygi+OBGnKOsK0ibMKkd0znECG29l0q6XWL9FHF1q+iCJk9KOZZG2ciqQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707295413; c=relaxed/simple;
	bh=AeXERdhsZSdHZJPsNsgbAAFELh/zeIqHLhVRBaa+zZA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PEqqLVl8okSLpALUTpuDAQ3dPF/aIUEqRG08n7zxnq+dLga9lHhLO4cjkrjUsO5Muf5ls4UCDY/LsiEpg7aPAY3+BUAzQLNJ1CY+vIX6S1gd2PAUYOnHW3jKjaHx0pgiWNE4zzwaFf0yIxmR3Skx58PaHT/TuBZjVYUkcQ4cNWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mIdW6Q6L; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5961a2726aaso208220eaf.0;
        Wed, 07 Feb 2024 00:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707295411; x=1707900211; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vp05Gs6ocR+pGiy78G1ozNGgoHRJUMGLkTNH5sSFn7s=;
        b=mIdW6Q6LvdJvyEyZPNpvWyQwL2NkXFHL1ggJKGB2RTJLFnJ2lvC6cBo+vndqpgD/T3
         Dic3GpGULKyW5tpXpsmAGlTZttNvIJCkrl/KXxnY2xoRrQ7g8GlBHCLU3zxlV4xXfkkW
         B5kiHnOfOge0WL2ZHZ+CCJJJgZ9TBE0iz1fEL2HLXXVvMeAP56o6Xi5tcv5X5S8eQs2p
         zWpFln72PLgOzSWNWrS4Xvxxk4pKgW4AgaHV5R2T06njRBfXr7frgh5zMy7b3VzKSCg9
         UBkDYEr0Vr8Aq6DA7SC+d6x7Z8unQ4z4zLSvugECEmz2/mpMYwCxoDY0kZry39kN/SOi
         48Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707295411; x=1707900211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vp05Gs6ocR+pGiy78G1ozNGgoHRJUMGLkTNH5sSFn7s=;
        b=PT9xYuGn7FKqAy6iCN8zi8Hu93a+AfHHdKDBV1XTdO8hwY5oj6Uwj8uLg6jMnpejPL
         dg3SmkiszwLl/uqSqfctBOs+Qv9uZ/nhbeGfOVmAc1tULo73KwJQKY/5lf8pFSNng73v
         YRpAbg9Y3FxOk5NGGT4lo+Be7kKJUmKoQE1GgxbhBK3xfExRStbvlwOZHWTbIcWLUeMf
         iw/TfzclaFXHSBS+4ImJBSyaUXAcQYX5e4sTuW557sHEmkZ8Vi7X3c80aZl/PrrsfF+0
         Wy3RvLPVpuX3GNZ250XZcYg3wEOPFI8JiPU8/1GutfCOjrBEKPHgqe9ktm7VIrW/kOOv
         iEoA==
X-Forwarded-Encrypted: i=1; AJvYcCVOPLBCXMuWs3OAlYKO4C39qwTpamjvtYYjmj/THa/9G8QGm5t+XnRTESnf94mvRf6qmLRLRIzNpnctXpSEe0RWNpLxvH9zaa/Rz9dvZ6Yy3S7Q9djxgdP0cHobOX32oY1SbjxkxF43RxehxAiKX91gaRTc0Usgk8uabktZw35e0+H8Yw==
X-Gm-Message-State: AOJu0YzMCFs5bRUL7wG7GhH4Eq6PWz8h33ZXVLMr7ZRG6pztNtSsAR1T
	XpKqdl9odLzXwQzIujqzi5T6qgLSP2v8hUUJR2Ntv78mA2zzGs37b19eAAk0TN5nn7HOhXUzEUj
	ktAeA8y6Ondp1G73MczYojnNTSHw=
X-Google-Smtp-Source: AGHT+IGELlPVInHjuUNFiDoSwgl7eSrE39No9ErdiklAgq08gvX4ku9OXQZAPLT6wq1PZeBHvsC3cViu9Ao1ZMWDCJI=
X-Received: by 2002:a4a:86c5:0:b0:59a:161e:ed64 with SMTP id
 y5-20020a4a86c5000000b0059a161eed64mr4392036ooh.8.1707295410167; Wed, 07 Feb
 2024 00:43:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207055856.672184-1-qiujingbao.dlmu@gmail.com>
 <20240207060913.672554-1-qiujingbao.dlmu@gmail.com> <14d1464b-7d60-4021-bc33-b0e809f3cde0@kernel.org>
In-Reply-To: <14d1464b-7d60-4021-bc33-b0e809f3cde0@kernel.org>
From: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
Date: Wed, 7 Feb 2024 16:43:19 +0800
Message-ID: <CAJRtX8Sj01ENTQ0VRNzwBy+e9qHyJdtUQxWBB1yDCE77-Xb9qw@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] pwm: sophgo: add pwm support for Sophgo CV1800 SoC
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: u.kleine-koenig@pengutronix.de, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	dlan@gentoo.org, inochiama@outlook.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 4:09=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.org=
> wrote:
>
> On 07/02/2024 07:09, Jingbao Qiu wrote:
> > Implement the PWM driver for CV1800.
> >
> > Signed-off-by: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
> > ---
>
>
> > +
> > +static struct platform_driver cv1800_pwm_driver =3D {
> > +     .driver =3D {
> > +             .name =3D "cv1800-pwm",
> > +             .of_match_table =3D cv1800_pwm_dt_ids,
> > +     },
> > +     .probe =3D cv1800_pwm_probe,
> > +};
> > +module_platform_driver(cv1800_pwm_driver);
> > +
> > +MODULE_ALIAS("platform:cv1800-pwm");
>
> You should not need MODULE_ALIAS() in normal cases. If you need it,
> usually it means your device ID table is wrong (e.g. misses either
> entries or MODULE_DEVICE_TABLE()). MODULE_ALIAS() is not a substitute
> for incomplete ID table.
>

you're right, I will drop it.

Best regards,
Jingbao Qiu

