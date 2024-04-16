Return-Path: <linux-kernel+bounces-147318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A37DE8A7272
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 19:34:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57ADA282906
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 17:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9899133987;
	Tue, 16 Apr 2024 17:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NjTyf0JL"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997F412FF72;
	Tue, 16 Apr 2024 17:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713288870; cv=none; b=nFrnjg1PPD9CnzUdEPC1q+jIwY3hVrtnVVmUUfWfSbhf5m4FcZ5uPWo0ajjcdibsGpguCwLjdfvBhWSmTwoNuczRMimu+/pRQTgFJprVq5zgLLT9NgC7G6qeY4vhidlcgaQdpz+0xOK0WpltKNnel2Ql+IznuuUAt5ijB7irEW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713288870; c=relaxed/simple;
	bh=xu+k3B6e0S5uV2AeyPNUBYkGSJodPLz6zhec+aOyGCc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a06AHTDgLRBSKGmBMIEzhrzWyAVjFXhK7dqiCB/nmwHQrwCsjN7qx3X9scZOmoMqFvUePelrlOo0DWJwKk5AvwXs6Vl4fAtzOM0ykDAAOyFDK8hDAJxyT0He8stsccz4kIlxYXGAztv0+v8uyKibw+OVOPz1xMqWvFYnm8K4fkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NjTyf0JL; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a51a1c8d931so604171266b.0;
        Tue, 16 Apr 2024 10:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713288867; x=1713893667; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XBGtZhXrsDv9/IU80RlwXoRNjhCMbNIbfxUge/aRn1Q=;
        b=NjTyf0JLqTV953rWO+NTClV5fq1t5KbksMf9skJGxo7oSRc+MARP+bPUs/CufTXTOC
         dyZFS1aIeqUXQ3XyODeWNtsRjyTC7clYyQ/07nV/A4JACvzpsul4AiTCe7Kb6ACvXc7n
         VMG9jrqIT0jYXD9CaF1wJkcTWBc1rJjOTQUZaUesLWqbo1BX2vQq9lIZG/SAwmtgPklV
         knYFm5DFbysz1c5Vrvi8EgpfAqRR5WsFy45LLAgxk3z5PjRF4uliH7ATJrxT0Zjj6XWe
         hNT5CHliYC74ietoEeAHQeoyFp+Qw5aDdus2CjQGp0/e/Gp9QVSSGc0RItu8P9iQN2eQ
         l22A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713288867; x=1713893667;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XBGtZhXrsDv9/IU80RlwXoRNjhCMbNIbfxUge/aRn1Q=;
        b=SJX/OtRka5lmul2WAWd9+5cHjOD3f6rzSfyRfF1UNx1lbpeCLHrKkzO5ATZZm4hJH1
         x8/but4VJihol/6dAMYaDmpsLOX0GKD5ewWikc/2jQxRigndjQPp4IkzNtFdWFL0B8TK
         JyxUtkBFbyNT9aQUfTVgYd09Vp/5xXXmDtsX+dPyuO5RIQdeZk/yeB0PuRzbl+yBOtUQ
         vHi5NtD0h525zW8vPwhv0+CDuWATwdGNm5NO5Wj1D8iYaQ2aODUDam23nW2dp7M/a/Ny
         aTM8NFasLHLi7MIrqNPhHyUQENKdhx4xDGq7R0mR4eZzZudxkyoDhghC2vQRob7I8nVS
         xHYA==
X-Forwarded-Encrypted: i=1; AJvYcCXCdFdih/TsQVoKZ1T0ruiC5pjger2UZg3sJ92Lg8tfu5zynJzPTK2Qvs10wHJ+ACChFNay2tfjWlPj3btZyNjXlVSbJ5dRvSL627EZlrlwN3+xZwhSAv9ih5wfM81UvtnYXW8LIEwQG0OT3nctnqngBYYQCw3vtYUQzFwo40UQ/VkivhQhzTpau1Q+ZQ5IomP8fUB5IFBrGoWvGoZzmVBDuudavv+oqQ==
X-Gm-Message-State: AOJu0Yz/Sr1LTT50BhFlMDVy/rVgBrEHZP6v8AESTTFVryersdw7hpzc
	VLxDK2OK9z6d3vKpTy4oaFY1nDjskwxzJ+AkufdGFHbXXA4/IiCF6Mx8Zqv8thRf8LRIIKIvPc5
	31k3fZ4cgXL03fzT6PL79zAjhAh8=
X-Google-Smtp-Source: AGHT+IESOFgHtJldCSkg3hlXty7KCffRAd8b1WXWXaSWCE1frVgK14VVZblAjVAWRBOrri139ePgBSSDR7J4vov0Bco=
X-Received: by 2002:a17:907:31c9:b0:a52:4fc1:ea90 with SMTP id
 xf9-20020a17090731c900b00a524fc1ea90mr7379092ejb.62.1713288866697; Tue, 16
 Apr 2024 10:34:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416053909.256319-5-hpa@redhat.com> <202404170023.1zEGO9ja-lkp@intel.com>
In-Reply-To: <202404170023.1zEGO9ja-lkp@intel.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 16 Apr 2024 20:33:50 +0300
Message-ID: <CAHp75VeKCGSZTb5bGU4YNr9r-z+gXmk4GC5HOZCFcoRQRN37CA@mail.gmail.com>
Subject: Re: [PATCH v6 4/5] power: supply: power-supply-leds: Add
 charging_orange_full_green trigger for RGB LED
To: kernel test robot <lkp@intel.com>
Cc: Kate Hsuan <hpa@redhat.com>, Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>, 
	linux-leds@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
	Hans de Goede <hdegoede@redhat.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	=?UTF-8?Q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>, 
	linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, 
	oe-kbuild-all@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 8:03=E2=80=AFPM kernel test robot <lkp@intel.com> w=
rote:
>
> Hi Kate,
>
> kernel test robot noticed the following build errors:

> All errors (new ones prefixed by >>):
>
>    drivers/power/supply/power_supply_leds.c: In function 'power_supply_up=
date_bat_leds':
> >> drivers/power/supply/power_supply_leds.c:42:17: error: implicit declar=
ation of function 'led_mc_trigger_event'; did you mean 'led_trigger_event'?=
 [-Werror=3Dimplicit-function-declaration]
>       42 |                 led_mc_trigger_event(psy->charging_orange_full=
_green_trig,
>          |                 ^~~~~~~~~~~~~~~~~~~~
>          |                 led_trigger_event
>    cc1: some warnings being treated as errors

Probably you need a new dependency or so.

--=20
With Best Regards,
Andy Shevchenko

