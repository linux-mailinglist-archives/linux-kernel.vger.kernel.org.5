Return-Path: <linux-kernel+bounces-134650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D0A189B42C
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 23:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 011C2281523
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 21:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84B144C71;
	Sun,  7 Apr 2024 21:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lGYN71X3"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EED71DFDE;
	Sun,  7 Apr 2024 21:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712526687; cv=none; b=lW4VXAcFXA46PKPJ5Psr2/fTJOQv/w7kpRZbQFuEMwMD7jqtrZbeuwXNtBjPTw/dp1KSXTxHsYTQbSkSu0xnpYq3yiOLQC73y5Qn7VI/CRimaLqL87QzW8eQWe5CHNIeZ9bVqnDEu87So0VMh2aWFm5pQUVg9eHOV2wnQKdCVd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712526687; c=relaxed/simple;
	bh=f2BE/YI3xI3WQEaLDeBhgTVDQX30B7qq5OPHegjNfNs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tQoQGcyCfKzJJCsW15S0WIi1y8FHykikr6/knXAHlSO5I6yvNT688N0w4t4u42PaeMT84GRaegXTwSQ5AHjSnHAHd5N/trlM88t55d0LUUIV603uDbag33oh2adtkCuf7JhgWttKlcmUezFkwO9xnXCGh4o3C8jXSiQdfV5XFtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lGYN71X3; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-343bccc0b2cso2773228f8f.1;
        Sun, 07 Apr 2024 14:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712526684; x=1713131484; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=f2BE/YI3xI3WQEaLDeBhgTVDQX30B7qq5OPHegjNfNs=;
        b=lGYN71X34XvUBcOIYNCeoJnTTlMm1qizD0oygVHL305izSnmjzYHDYMZV8M223khto
         4EGzPmmVPdrsgvjWbSwSxN0cVKNycgOsfSoXFnEU3dX/jRukHxzPWXcvwzAntdcPLIVy
         kj/D3x6fnKhXdJbK3hmQD21NEuLoCpvWfoPPPWnMz7cn1DI6xS+zKcJWX/LRWHfcNRk2
         G5Z7/5YMx3XRljafhqTwNpGmB0ESWQKROzG51t5RW4UYFfjm/EQzIGUfenqX80giVfbm
         RKaogtjjurwZzqQnwXNukVPSTUGPszOvdZXN4Z1+IBeIZbHdveHHmJMRbYicxiZiB2++
         8E+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712526684; x=1713131484;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f2BE/YI3xI3WQEaLDeBhgTVDQX30B7qq5OPHegjNfNs=;
        b=v/6MMY/XQB9mSbmDdAI5IztnXwwbzzkswD+m1Kgy8Lsh/Pprc/xqfDAaFRZrzLcUNK
         JCiXJzrrV6kUSctcfHbVVXBfJiElv8m+kB59GniI2qtZ7MDAG1NhfAIpVLK+LTcoOqF+
         Dx9t+RNlWV5fGgMOVsuoeKL7ujdLo8sRDWaBXQmPjvvvXaOuEZHq5Xy/WiVd74kILhGb
         /MfuWj/uuyzV54KOZlPsDAlZeecKTCe4/brxO8q+X72+fuUhsmC5/B68dJD5S/JiwoF+
         FURN1ZpOGRpVslfE4kcci+6DdhPaEgcNzQTy9ddkJYjLKElQVXjzTkmbKhTrJIUqHEKw
         ycIw==
X-Forwarded-Encrypted: i=1; AJvYcCWLdkN/Me0M2zMkklD1fVX9oxp8X3JZpEu6HIG71hSG8IyCRyAslK55J3AVeKdhUwUnPNSxdxDxh4FAc+0Neh1572yEpKG1ITb6k57AdQif3l2WqqVEXtKBhQS+SvJ/Q4Wcfo49G5/o
X-Gm-Message-State: AOJu0YxdYdGGUSwDJBSW7frNzssckq2NgY3l+9y9hqqFNq4rr7iCaxwz
	/rvk/0U0OJ2IilM/rT/BQz3WbFX0nGbrmuo0FHk+pge80/HFNSuW
X-Google-Smtp-Source: AGHT+IFNa8Pgxn6ToZdy8WzhCnupBKfVBgYlsCz1D41N1qsNSX2cEfMSiK4ubfGwaCOw7jETL0ZHzA==
X-Received: by 2002:a5d:5985:0:b0:345:7fb2:4ced with SMTP id n5-20020a5d5985000000b003457fb24cedmr2250858wri.58.1712526683687;
        Sun, 07 Apr 2024 14:51:23 -0700 (PDT)
Received: from [192.168.90.25] (121.red-83-37-9.dynamicip.rima-tde.net. [83.37.9.121])
        by smtp.gmail.com with ESMTPSA id k2-20020a5d5242000000b00343c0c24a65sm7389249wrc.89.2024.04.07.14.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Apr 2024 14:51:23 -0700 (PDT)
Message-ID: <57fe9ec305efff58a2ef1e2ba6e334f042a2ad77.camel@gmail.com>
Subject: Re: [PATCH v4 0/6] Driver cleanup and series to add triggered buffer
From: Angel Iglesias <ang.iglesiasg@gmail.com>
To: Vasileios Amoiridis <vassilisamir@gmail.com>, jic23@kernel.org
Cc: lars@metafoo.de, andriy.shevchenko@linux.intel.com, 
 mazziesaccount@gmail.com, ak@it-klinger.de, petre.rodan@subdimension.ro, 
 phil@raspberrypi.com, 579lpy@gmail.com, u.kleine-koenig@pengutronix.de, 
 biju.das.jz@bp.renesas.com, linus.walleij@linaro.org,
 semen.protsenko@linaro.org,  linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Sun, 07 Apr 2024 23:51:22 +0200
In-Reply-To: <20240407172920.264282-1-vassilisamir@gmail.com>
References: <20240407172920.264282-1-vassilisamir@gmail.com>
Autocrypt: addr=ang.iglesiasg@gmail.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2024-04-07 at 19:29 +0200, Vasileios Amoiridis wrote:
> Based on next-20240405.

Hi there! Small tip, with git's format-patch, you can include this informat=
ion
for the people applying the patches with the argument --base=3D<commit or b=
ranch>.
This will point to git the base commit from which the series build the
changeset.

Kind regards,
Angel



