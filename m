Return-Path: <linux-kernel+bounces-56992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A573084D271
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 20:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33E051F25B5D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 19:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF29126F03;
	Wed,  7 Feb 2024 19:54:21 +0000 (UTC)
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E4985947;
	Wed,  7 Feb 2024 19:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707335660; cv=none; b=IVf72PS93zoNmjM41Lnl2yC2lAtb4lRXRDy3p/5ryLpVpveHii/4lOC68BQssqEPRQXzFpD9DDbuSlLg3F312i10V5g0k+OUbznlq0Ph+a7GP68MiQeBTaTDHkxjgG0eANSmyInItttOAeVmqL957XyaM3i4/xZmF5DN1ZFgPfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707335660; c=relaxed/simple;
	bh=wfbSmuHab0V68wnlOCcAF2SVn1m+YMVLhGtx53tD9as=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bTOl5TTiEwf7B3+qB2XYvMOskM/TA+zysdVBnHfRdvoI475aHmMa7X1Ts1jThBo+w9CF2UxvT1uKWoJ0dk0amcZwcEbHMVdhgnNoS3ZrldnCwb5PCMYVNzSdN0Wo6U6kjhfBrd50A7oJIybkJTCCNznBVd7WKq22svooOWLzaRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-59a24bf7cadso281662eaf.0;
        Wed, 07 Feb 2024 11:54:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707335658; x=1707940458;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cxuT7grQtF6+jxH5TdI/JH0psGW02KwfjrWP6++bBUo=;
        b=w06rFthLoRNTI9bz1WlPMh8tV51FKliOMglBEg9dHPldMMqbFelNRhldhjMpfydxs2
         293rF6U1lzYxIbiBfNkRk7kOjYQAPUSsvb0kGf3na1Aky9mmT0nnlZvA7Um9wOUsxUd7
         +yvfls8F2oFH39wns9/IAjrk9fY5aRNNrzOKFhklURNgWtQg3ZRgFcleP9vLR2eOB6P4
         PwdkVcZr+xRGMptsYz1UWsdrQ2l1PReuA6eE99yPtB9NKSh8K1OiSMNv718u7DMP44Gu
         uCC/pctXTcY9BV5i41h7kAwkejPOhhNTJOftQcEK6mp6z7cGDIxj1PIh1KJbuOdvNp5e
         7PnA==
X-Forwarded-Encrypted: i=1; AJvYcCVTAMzlqdm4cy8PwWn0/mrWaUvDC72Me7pTBLIpVCmTjR7c0A1yjHzKEvPUjQnRZcVq06Ssh7uLi4oNFaWkCtvGGd7Xl67+v/YofbymlClu2yZ8f3AAjR/B1B/KLxrT6vdjlLDpb3I=
X-Gm-Message-State: AOJu0YzehGV5eToLMfaLD2nNeR8zDAzG9roXr/x5UtYvpdhbPfWRec1B
	uay7dOJncQ+q+5LdR2ba18ZDaBndPRUKFBq1XANvnl32y4JYg1L27Rzrk+XOQ2VM7svp98063hV
	3tjJKaG4kVVOzzeSJAF49q8EtWh4=
X-Google-Smtp-Source: AGHT+IHv6uqRut6OHEIswNK76znrlzV3lT4SqNcMhKHeZ34sVvR2sbP99u08sL7UiuUaaUlEcG6zTPrs+2nL2EfzsG0=
X-Received: by 2002:a05:6871:8a4:b0:219:ed95:916e with SMTP id
 r36-20020a05687108a400b00219ed95916emr77573oaq.5.1707335658402; Wed, 07 Feb
 2024 11:54:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20240207103144eucas1p16b601a73ff347d2542f8380b25921491@eucas1p1.samsung.com>
 <10423008.nUPlyArG6x@kreacher> <708a65cc-79ec-44a6-8454-a93d0f3114c3@samsung.com>
 <CAJZ5v0hn=KgaWn9pwtLsH2a8n61BNxzb1xrNoxUfEi3o9OAZGw@mail.gmail.com>
 <4a043533-009f-4db9-b107-c8374be28d2b@samsung.com> <CAJZ5v0hDmwaFEtLc8yDc4cXn2wODXAqATe0+_Hpm9QPODUPMQw@mail.gmail.com>
 <ZcOyW_Q1FC35oxob@slm.duckdns.org> <2f125955-8c7c-465c-938c-8768f7ca360b@samsung.com>
 <ZcPSuUBoL_EDvcTF@slm.duckdns.org> <ZcPelerpp3Rr5YFW@slm.duckdns.org>
In-Reply-To: <ZcPelerpp3Rr5YFW@slm.duckdns.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 7 Feb 2024 20:54:07 +0100
Message-ID: <CAJZ5v0gB2h1G_0a_BAbBtib=VxnJgF9N3Sa3QYpCeURcCtKUTQ@mail.gmail.com>
Subject: Re: [PATCH v1] PM: sleep: Restore asynchronous device resume optimization
To: Tejun Heo <tj@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Nathan Chancellor <nathan@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Naohiro.Aota@wdc.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 8:48=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> I couldn't reproduce effective max_active being pushed down to min_active
> across suspend/resume cycles on x86. There gotta be something different.
>
> - Can you please apply the following patch along with the WQ_DFL_MIN_ACTI=
VE
>   bump, go through suspend/resume once and report the dmesg?
>
> - Regardless of the root cause, I think async should switch to a dedicate=
d
>   workqueue with explicitly raised min_active (will add an interface for
>   it).

Agreed.

