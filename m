Return-Path: <linux-kernel+bounces-3083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C72816727
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 08:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72C73283CDC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 07:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E80101CE;
	Mon, 18 Dec 2023 07:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M6P04eck"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CE6D2ED;
	Mon, 18 Dec 2023 07:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-20364459774so1734991fac.2;
        Sun, 17 Dec 2023 23:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702883518; x=1703488318; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UhmvapdjbK4Juob7xVNZEvY20g3FFXidM5reGh1RCcM=;
        b=M6P04eckv+9wSQoC9OCl9IFGQKjIrt9voGo3DRZ0Gx0MSVZC+gErCPUKOyrmdWNMFY
         2saHjtzZ9FKV8rFRGRSi6/uw6pPpLigKEG7klmFlgRl5McLVtt1rzlrfPoogs0tP6Pb+
         8F7P9j46rGHnKSPAf0v/URhSjnRA8F0uxSly5UY90N8lSWdMWQSKyQaEFvYzv7k0poSf
         wDb9u4mlq7Z4b9fyi3Iopls4qfCybxhVtEq2fbgX6xxd9N7C2zNJbR8nzjVmofm9xQVm
         ev254tjc5nVvkZZIHJsg3tW/cIzsv1ovXRV7+1n+vHFT76ykZA4uKpugmRn93yiGt9j+
         ClbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702883518; x=1703488318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UhmvapdjbK4Juob7xVNZEvY20g3FFXidM5reGh1RCcM=;
        b=goxJa7kFSdd9nF0IguusjC6KGlmp7w1Expwjr/aCDUagWjl/VDXyiRa8pzIhus7c7l
         1RVnAiTmAfdW1/FBfOSEMHeatg5tGPFcXE6I8SKu0Yi1nKZBTpa//TW4HOh3gXuorfIF
         jsVU6ckwkMI213xabwIaP9RzCDoDYqnl0vb1S3krgNemklEoKbjI3de6Za+PSsuNilVn
         6UlgnP95DD0nluzT98ubW/R0JJY9q/rkDFMOzsXNPU2tv7PjEArbwVSlkKA5b8bFLLtG
         Vs6hmTu9HMfM+tCgPotmsS3OZWoQY2y2BXn7hBUh8SqdEbkOkUQFVJooLZob+9dKT1/j
         Ijhw==
X-Gm-Message-State: AOJu0YyR4n/74CriJ5toYzWwqYH3IsYusbgfz1UDHomvw9iFValY77E8
	YDSiLjONzDla6hQO42wUxeR46weY7K8f3sRT8kM=
X-Google-Smtp-Source: AGHT+IHPVzt32uHRpOM3hUEPlx1J8EdwKEMu7SdIg1Pona01Ee1GULJv60QTmrXAk4aveIqd54Nvt2t93iq6zl6qHMU=
X-Received: by 2002:a05:6870:414a:b0:203:b69b:674 with SMTP id
 r10-20020a056870414a00b00203b69b0674mr2011546oad.35.1702883518015; Sun, 17
 Dec 2023 23:11:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231217110952.78784-1-qiujingbao.dlmu@gmail.com> <ZX/bUfSS1+32skCM@xhacker>
In-Reply-To: <ZX/bUfSS1+32skCM@xhacker>
From: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
Date: Mon, 18 Dec 2023 15:11:46 +0800
Message-ID: <CAJRtX8T=bD4S1yMbexuwiMOK7rtwOg5TmVQJsRW6b8Lv9LnPKw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] riscv: rtc: sophgo: add rtc support for CV1800
To: Jisheng Zhang <jszhang@kernel.org>
Cc: a.zummo@towertech.it, alexandre.belloni@bootlin.com, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor@kernel.org, conor+dt@kernel.org, 
	chao.wei@sophgo.com, unicorn_wang@outlook.com, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, linux-rtc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, dlan@gentoo.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023 at 1:53=E2=80=AFPM Jisheng Zhang <jszhang@kernel.org> =
wrote:
>
> On Sun, Dec 17, 2023 at 07:09:49PM +0800, Jingbao Qiu wrote:
> > This series adds rtc support for Sophgo CV1800.
> >
> > Changes since v1
> > - fix duplicate names in subject
> > - using RTC replace RTC controller
> > - improve the properties of dt-bindings
> > - using `unevaluatedProperties` replace `additionalProperties`
> > - dt-bindings passed the test
> > - using `devm_platform_ioremap_resource()` replace
> >   `platform_get_resource()` and `devm_ioremap_resource()`
> > - fix random order of the code
> > - fix wrong wrapping of the `devm_request_irq()` and map the flag with =
dts
> > - using devm_clk_get_enabled replace `devm_clk_get()` and
> >   `clk_prepare_enable()`
> > - fix return style
> > - add rtc clock calibration function
> > - use spinlock when write register on read/set time
> >
> > Jingbao Qiu (3):
> >   dt-bindings: rtc: sophgo: add RTC support for Sophgo CV1800 series So=
C
> >   rtc: sophgo: add rtc support for Sophgo CV1800 SoC
> >   riscv: dts: sophgo: add rtc dt node for CV1800
>
> AFAICT, the rtc subsystem supports not only RTC function but also
> power/reboot controller, so modeling the rtc subsystem as RTC only doesn'=
t
> match the HW. I expect a mfd here.
>

Thanks,I will improve it in the next version.

Best regards,
Jingbao Qiu


> >
> >  .../bindings/rtc/sophgo,cv1800-rtc.yaml       |  47 ++
> >  arch/riscv/boot/dts/sophgo/cv1800b.dtsi       |   7 +
> >  drivers/rtc/Kconfig                           |   6 +
> >  drivers/rtc/Makefile                          |   1 +
> >  drivers/rtc/rtc-cv1800.c                      | 400 ++++++++++++++++++
> >  5 files changed, 461 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/rtc/sophgo,cv1800=
-rtc.yaml
> >  create mode 100644 drivers/rtc/rtc-cv1800.c
> >
> > --
> > 2.25.1
> >

