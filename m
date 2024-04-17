Return-Path: <linux-kernel+bounces-148956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 30FCD8A89A3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 19:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4200B254BF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ADCD17167F;
	Wed, 17 Apr 2024 17:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d+tp96DW"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07DF1487F7;
	Wed, 17 Apr 2024 17:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713373265; cv=none; b=B3370gWZ1nPwTmzgzoHrpe0vWb3ZloX82YkaH2Z1Y2mbxCCEF97jLpucIDEN3RIuRMoI0gkhvuRdzePz1peqw1v34upwcVUWCu9v0zNdV21oWYbdi5Sf9VH3pCUd9ywZ0ttBZIx9oK77tgq33E23MZ2dMVR8BJTz0rfTAIPfT+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713373265; c=relaxed/simple;
	bh=7qwad6F14l5TuReDCaxKpdYeGsRIaVMPS5X5tPUMD5E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TI4Uk5Gq51lutfS94klwsPv++TingUgpaAbjGMYLwMrSxzlsgUknhj/aVra1AoMoj37SVurlt4pRyHkM+H9QR6l5+jWPXLazjFBguOazHlAh/21VWX5q8wTBv3BbjhHZxVYlQ029eoIp8NSDvkAJlzQosbwNQjzKELXTWh2mo2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d+tp96DW; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a526d0b2349so468531666b.3;
        Wed, 17 Apr 2024 10:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713373262; x=1713978062; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7qwad6F14l5TuReDCaxKpdYeGsRIaVMPS5X5tPUMD5E=;
        b=d+tp96DWHoTCzf5xJL5h2EkRTpY2dng5/4HwZYoUdAbVXPi0I6RCSr22xp7X7DLcPZ
         teoRsbdMuIAwm1JKB1JtrhxhuYY+oUAcIgP6I3AiKWr5L+B+xH9d8HnP6OqM1GQixDHI
         kxGGl8l3rPA1gxlfJ0UnDiySWQdbofht8EBt317dFsYpu9URqL3Z9WrlB+Q/43Pb7jzj
         5juQ+DhQXXPafH7Zd9SK2DuSz59bUscin/ErN8T+8mgYk+MtulKRA/VQ8M71PwCILRZG
         59KV5NqlQCIyUCbkUIgi/nRO1NSooyzRttTDM/IDtO9L1hoVQqI5/y5nIueXgwuFxW9H
         vzCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713373262; x=1713978062;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7qwad6F14l5TuReDCaxKpdYeGsRIaVMPS5X5tPUMD5E=;
        b=rOeCEKcI2wMzmzm9fxjcOVmah2MzfO6EwmAi9K/uo1szipbCJwAoy9IRIYjepqP3Mp
         A5YPQ0gaUlJAeU0yMzAf+S80/t1wP7PfURBf36SoGeUhkEhaKYTjtF91Hcy9/6UqhwVX
         3EcqDOa911KeJpL2UqeRtVjUAAPlpLkn9CzjCnQP0AeLUsFmRKTOixOfUk+dL2QAGxPx
         ZAriYxjAkFA5ylqqRRt/dvusLZtACPy2sY54N4SMxMiuqOjx54MUKoubFWGYVrmSBpUB
         B7jFtDN81ImgfI05Jf1fp5Iu9Nr1fgQpwp1ia3+Li/rlUeEX91Q7mJ3RGWHw5LfNLrsv
         nntA==
X-Forwarded-Encrypted: i=1; AJvYcCW161dPIeUhRtsfd/uejJszX+7Gt02BQmSb/6AbJlJhr7pE1rtL3QNlg5cSr7PzqmVA6HcFpL8lCcsiNkhkLTyAAvC4WDptzmY6G6XC1byD7x2b4bzjuq2F1y9dmbzMsiOGuq8NniuL9uU=
X-Gm-Message-State: AOJu0YyfJfthKX5Ot23HWO+aMSEBLRr1KNFtUAQTUNyHBuZZSOCvEnWj
	Q5oShxPF/6Lqii3IitxVQw3serOioB7KEjzJLllytP4fY3sicIa0l7zzn9UGO9TjMo7n/+yxCfJ
	1KNuq3R9UESjM4DMLaE7nhcxsYKc=
X-Google-Smtp-Source: AGHT+IHjqTDWZmtRPVFdbj0aG9crrmkL+pewqf6E+1PmO4tYLeDDlDuje0SMjWuIQbvH+KcEtnFkaReiKAfIoAQVBLE=
X-Received: by 2002:a17:906:b793:b0:a52:6d2b:e8f7 with SMTP id
 dt19-20020a170906b79300b00a526d2be8f7mr65234ejb.12.1713373261795; Wed, 17 Apr
 2024 10:01:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416211941.9369-1-tony.luck@intel.com> <20240416212247.9949-1-tony.luck@intel.com>
 <CAHp75VcQvNqaTj6GTNmhoMbTj-qbn=WX7OSuRwiPaFO5pzPd9g@mail.gmail.com> <SJ1PR11MB608394505D03C51EC2583BFCFC0F2@SJ1PR11MB6083.namprd11.prod.outlook.com>
In-Reply-To: <SJ1PR11MB608394505D03C51EC2583BFCFC0F2@SJ1PR11MB6083.namprd11.prod.outlook.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 17 Apr 2024 20:00:25 +0300
Message-ID: <CAHp75VcbtB=UEjBVM+C3_7Rbt9y1VSVkBOxjpyTA6TBYvtLqzw@mail.gmail.com>
Subject: Re: [PATCH v3 68/74] x86/cpu/vfm: Update drivers/staging/media/atomisp/include/linux/atomisp_platform.h
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, 
	"linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"patches@lists.linux.dev" <patches@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 7:24=E2=80=AFPM Luck, Tony <tony.luck@intel.com> wr=
ote:
>
> >> New CPU #defines encode vendor and family as well as model.
> >
> > Thanks, but I would rather see this using the following
> > https://elixir.bootlin.com/linux/v6.9-rc4/source/include/linux/platform=
_data/x86/soc.h
>
> Are you asking for drivers/staging/media/atomisp/include/linux/atomisp_pl=
atform.h
> to be refactored to use the new functions/macros in <linux/platform_data/=
x86/soc.h>?
>
> Maybe folks working on this staging driver can do that? I don't think I h=
ave the domain
> specific knowledge to make this update.
>
> Note that patch 69 in this series does update <linux/platform_data/x86/so=
c.h> to use
> the new vendor-family-model scheme.

So. maybe if this patch is placed after that one, it can be easily
seen how to amend it? I would help with the conversion as I know
something about AtomISP driver code (not as much as Hans de Goede,
though).


--=20
With Best Regards,
Andy Shevchenko

