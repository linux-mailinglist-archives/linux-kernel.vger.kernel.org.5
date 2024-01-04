Return-Path: <linux-kernel+bounces-16537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 053AF823FDD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 11:50:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A64C2829CB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 10:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A415210E8;
	Thu,  4 Jan 2024 10:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gpCPCU84"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3D620B3F;
	Thu,  4 Jan 2024 10:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-59446cd46e9so149345eaf.3;
        Thu, 04 Jan 2024 02:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704365394; x=1704970194; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2SfapSwpfulfo8BBw7BIPGiMa27IAqeFCkx3f3KM5G8=;
        b=gpCPCU84kga5dNw1lxypXaL0DCwTnMaQYuk1y0A9qRni547NxLaTfUWE0nVTumk+uk
         EIdu/vrDALdLkravHgy/QWM29mfd6upQcdRLyZ3lvPIzyhrzSIGelnyAcEu3tr8UE3XS
         lWZGlV+XMNNxUTuFZfwgjisBXza/kjLOI9Jz/xoVzC31msJDSLt7uFmQNu3bULT2lAkV
         uNCRfBgGpfj63CHCYvJNHQgxWT4O8V1XLbfRSuAhsDQIZKviGoZwqf4t19ZJHKhik9GX
         xwPaa3+ISm2mZdr6RyHuqnCN8rSA+dl6ZSrU+mTinrD6mFafJl/9MLboJrveb21nMpvG
         AncA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704365394; x=1704970194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2SfapSwpfulfo8BBw7BIPGiMa27IAqeFCkx3f3KM5G8=;
        b=wiUp6FAhM/IN4QdmmNfUHc478iUmaqa4EaiJn9GRS+Wi9dSXHPZLsOTwm4KTo4Nwur
         xOM2dgvsOLDzOxTMKapDBrqWizySBs5LKGfH9+rmYUQLVVHTmXTKrF4Z1IC02axDHZF8
         XPtTluv0GL1xi5srOktd/YMCrJ42RoNAlbo0/v4jy07MmZpxEuAfZLKhYk5VCxzxMlDs
         lrGcs0em6MVQLcMWVSp0+PHbJsqJ8IUb4x39N5dlS0Ngh3AmgSccqk515YhFKuzQIAql
         ptlmvdgIlyTp2LFg9UH6Pdv0jSwYaZNzoaxGXyhaNqvOTBVCbbIxta6B4dezlRGOGoZ5
         VMhg==
X-Gm-Message-State: AOJu0YzyqSHkXk0g4yjmJpKhYnuU2HCohkd+sky//7MoDnyLk7DFjcqw
	fIvfmdSMOpKm+QOJ/CL+RR1fDAjw18xVDYw8xqs=
X-Google-Smtp-Source: AGHT+IHiYdjePJt9jT63OfLvUDdP3kasg/tSkQ4ahCEZEOaDWrB1J6A5S3/vYS0Xw/vgRz97zO8+ijBMJiEUWhSGpXw=
X-Received: by 2002:a4a:d18f:0:b0:596:1ede:a9a9 with SMTP id
 j15-20020a4ad18f000000b005961edea9a9mr332035oor.13.1704365393755; Thu, 04 Jan
 2024 02:49:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231229090643.116575-1-qiujingbao.dlmu@gmail.com>
 <20231229090643.116575-2-qiujingbao.dlmu@gmail.com> <c5f7571e-8c99-4143-bfcd-cfd5b08329a9@linaro.org>
 <CAJRtX8SjutyeA29zvkHR2LmoPF0BSWSVVg44MOGqzn5znOmQVw@mail.gmail.com> <7a2957c4-d020-4948-8964-4375f6319f32@linaro.org>
In-Reply-To: <7a2957c4-d020-4948-8964-4375f6319f32@linaro.org>
From: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
Date: Thu, 4 Jan 2024 18:49:42 +0800
Message-ID: <CAJRtX8T=mMUS8WszCEdF-SYXV22RikWV4tg4t0rPss2599jYfQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] dt-bindings: rtc: sophgo: add RTC for Sophgo
 CV1800 series SoC.
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: a.zummo@towertech.it, alexandre.belloni@bootlin.com, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dlan@gentoo.org, inochiama@outlook.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 4, 2024 at 6:44=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 04/01/2024 11:34, Jingbao Qiu wrote:
> > On Thu, Jan 4, 2024 at 4:32=E2=80=AFPM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 29/12/2023 10:06, Jingbao Qiu wrote:
> >>> Add devicetree binding to describe the RTC for Sophgo CV1800 SoC.
> >>>
> >>> Signed-off-by: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
> >>> ---
> >>> This patch depends on the clk driver
> >>> Clk driver link:
> >>> https://lore.kernel.org/all/IA1PR20MB49539CDAD9A268CBF6CA184BBB9FA@IA=
1PR20MB4953.namprd20.prod.outlook.com/
> >>
> >> I don't understand how binding can depend on a driver. This is very
> >> confusing and suggests you write binding for the driver, which is not
> >> what we want.
> >>
> >> What's more, I really do not see the dependency here, so your message =
is
> >> incorrect?
> >>
> >
> > What I mean is that clk is used in the following example. In the clk
> > patch, there
> > is a macro definition that can be used to replace this number.
>
> And how is this a dependency?

Thanks. I will drop it.

Best regards,
Jingbao Qiu

>
>
> Best regards,
> Krzysztof
>

