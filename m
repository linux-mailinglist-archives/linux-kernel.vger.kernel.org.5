Return-Path: <linux-kernel+bounces-164851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3FF38B83F9
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 03:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FD89284004
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 01:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26829525E;
	Wed,  1 May 2024 01:35:02 +0000 (UTC)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC20B4A33;
	Wed,  1 May 2024 01:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714527301; cv=none; b=eQC1pvu9853HYdf8K4ZaSHoXCZ79RFHPh67lra6adcduVYzpyXH87Ye+NnJAYCtXmdYD+oMuRId9EIpR54c5AkzA3TsZVjwGnwEHs1wQon/8leRLDM1drRkdkkML2+7kooavyUT9ZN66kQPHBegmlnoV/qIlSSZ3Z7D/GfBWNuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714527301; c=relaxed/simple;
	bh=ojCK361NApnkeNZEAQMiCCmFYP9p9GCT3zWweDRk2IY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hVm8TU5v2xJXgqkmQATwOqv2yXA1aYxXj/tXxifmq7ryZVHnZb+jBGObK0yOVzYWo1s+qlDHPCWGEXGCG+Ml5OJ8KXgO+skZ6V6eyzI28+DxvhVwts30gG5sRHjY+3P6sq5UyANbnK8Ao2v9iJsHN46Dk6D60W4U0p7M1rkDe+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-51ac9c6599bso7020885e87.1;
        Tue, 30 Apr 2024 18:34:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714527298; x=1715132098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ojCK361NApnkeNZEAQMiCCmFYP9p9GCT3zWweDRk2IY=;
        b=a/ZSZN5h6efT08XN8eXQfEOXqKrx4VyOG35bM/BbJ3vflgC8T7IQV7vsRPnwWa64bd
         MCeBoEm092UgwFT/SzrMFVh6cb2sn9FX3kQvtwY5hM3fXN1u/HfMobql+NZY0fjYW/zn
         U1A9HhwxgeZO7Coy7VM49vQtmSmY2cNvo45Q5OlkudO7sh03e/c0nT8QxntKHOsOTR8N
         ibNeYNo3zMEney2D391AC4nZaNpNpVEsU6rNBH61orrY4wAZh9cUgQuQGfb+UmnbcP3+
         1bTANttiKM6VC/35aCGUR0GAQhiuEN5RtFu7Xq65fK7FyRv56vWES4KSP/clUIGWAD/N
         cC9w==
X-Forwarded-Encrypted: i=1; AJvYcCUuW2EvIx09z0kIkwHJl66tsarqDJTpFjGpyJeHKMsOPmVM5iPujDhjowFTs387hZv2BzRT4otwuETWCy6svkBR+IYHSxshQzBcUS+VrmXuAqcWhVQNT7/FDGpE/QQilMbIAn/5yUwmQw==
X-Gm-Message-State: AOJu0YxS8KOpBJ7F1mJ7E8L5DVcRLBz3f/NV8Cta/72FUD6gQIMHUtyz
	yaMnPCed1OhzCMFGoiRbdVqJ7GpURdN0nwcg4kxQHhnwAPWFJgnjX+N9v4+5O6o=
X-Google-Smtp-Source: AGHT+IEUL15r7ROMr1waQtt658aOX88J27yKxvH8Z9OQCJjKm7LvuATnI5Dm9aLTcehEDi8pa6I7/A==
X-Received: by 2002:a05:6512:1383:b0:51d:2017:e65 with SMTP id fc3-20020a056512138300b0051d20170e65mr866141lfb.66.1714527297663;
        Tue, 30 Apr 2024 18:34:57 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id 17-20020ac24851000000b00518a01fdf2asm4700183lfy.144.2024.04.30.18.34.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Apr 2024 18:34:57 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-516d4d80d00so8090760e87.0;
        Tue, 30 Apr 2024 18:34:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV/6gtfHXMzeI3y08BLHzFh7aU8lme8OBrf2rGFTx+pZgEvOf/MGLU+/0j3ArMy+5AvXuyLcvByYcYGyJz6J9suQPt7pMEDkZSotNYBkatzzp1PUPghvdykeLYAvDVbhTYhhNzpuW4cWw==
X-Received: by 2002:a05:6512:e8a:b0:51e:9812:b2ae with SMTP id
 bi10-20020a0565120e8a00b0051e9812b2aemr662647lfb.33.1714527297286; Tue, 30
 Apr 2024 18:34:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240501111917.23e2b0f2@canb.auug.org.au>
In-Reply-To: <20240501111917.23e2b0f2@canb.auug.org.au>
From: Sungwoo Kim <iam@sung-woo.kim>
Date: Tue, 30 Apr 2024 21:34:43 -0400
X-Gmail-Original-Message-ID: <CAJNyHp+G_zt_SbbGwFZzPyi=HjDs8sv_N0DqjHWih0OKb1EykA@mail.gmail.com>
Message-ID: <CAJNyHp+G_zt_SbbGwFZzPyi=HjDs8sv_N0DqjHWih0OKb1EykA@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the bluetooth tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Stephen, thank you for reporting this.

On Tue, Apr 30, 2024 at 9:19=E2=80=AFPM Stephen Rothwell <sfr@canb.auug.org=
au> wrote:
>
> Hi all,
>
> After merging the bluetooth tree, today's linux-next build (arm
> multi_v7_defconfig) failed like this:
>
> net/bluetooth/hci_core.c: In function 'hci_release_dev':
> net/bluetooth/hci_core.c:2831:9: error: implicit declaration of function =
'msft_release'; did you mean 'dst_release'? [-Werror=3Dimplicit-function-de=
claration]

The patch was insufficient. If CONFIG_BT_MSFTEXT=3Dn, msft.h does not
declare msft_release().
I will send a patch for this.

Thanks & Regards,
Sungwoo.

