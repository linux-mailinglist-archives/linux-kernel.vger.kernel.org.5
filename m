Return-Path: <linux-kernel+bounces-17871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 764FE825464
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 14:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1858B1F238CA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 13:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 961272CCBD;
	Fri,  5 Jan 2024 13:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="vjf734BG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45FF2D620
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 13:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 178BA3F5AC
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 13:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1704460728;
	bh=IFg9X0cw6KEOe6IAlb6C60OWnstZjElkbRUwRAxmfko=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=vjf734BGqgllIB/OMUwCrnZtQUEyzFwrV3Yp8WDykjWHbFsV+a7Uu7RUlclbrSl3/
	 WzsLoZUNn1osWEkfNul//o1POBMVfDFO3jga/orAFbVFsQ56UN2HbR1P3bBueE7e5s
	 tMAbHlGhVO3xeO3zObYnzZuP5/TGznFavdTKmBBJx1nDYLMt2Kx7bjd+cnVDqLL/Dx
	 W9m9cfUGYNquftE1n7BqpPC2fL/5+hFuxVnI7eeYls3g3L1klrf2kybVapiz5sMkUJ
	 sWGHpK6B38r3vNGG8Z1y39hP9qlRyqJK9hHq5NHIO2w/T1jwBLR8QxiK/KJRpHRgtS
	 67S18vw+bCXKA==
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-781029a475bso100918385a.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 05:18:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704460726; x=1705065526;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IFg9X0cw6KEOe6IAlb6C60OWnstZjElkbRUwRAxmfko=;
        b=BUKCBBT0BGIv/iCU5Jt9JDthMpQM0lHGJI9XvVm7Kb+BVp3VGqVn7YGiS7Djd+N+Aa
         mIAFrEViTslF8wGEsSi3SV/l3E64YCYhjuNcDZmlLeuGFYqYHW2iqOjnFqbHOf3HSGtB
         O85bWkN4YKOku95uBpwKat3ScqZyVeNTDZwiolsmygrKP3zFM4nsJtutOiPvXYaEMhz+
         W8V8P5P5bfaLsA4/2FZ9pSBCybJa+D+adaBV0v54CLGr3Ivbe2Y+hSnrbwmmiEhyuhV5
         hKUzwWuzg2AVTJ5qOcYvK8iqK+PgbgmIFVnXprOeD9mo3G6KS/wOlIYUN2faf7uiUO3j
         D8LQ==
X-Gm-Message-State: AOJu0YyG7s2MNfb5szPdi0u+7LFX5cW7ZtDbFNv4mHQbi3gJxMxcim37
	ge+CZrWFyyfEJ5S8hkhagHC5R3HisNK3IWjv6uJ+UMgJz9RqsTNJ/NwiNK5jjIUvc+ajr7VoEwY
	WPtZ946/MX8bAZSb8KKkt6kPi5qD7J08Fw6L5XnePakHqQviAcPGay9kgJkZ3/DKTpFkfJ6ta
X-Received: by 2002:a05:620a:178c:b0:783:de7:f55c with SMTP id ay12-20020a05620a178c00b007830de7f55cmr371559qkb.18.1704460726691;
        Fri, 05 Jan 2024 05:18:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFSkJtpgQs5O0P21kOkQPotDAvI+IaEL+Pr5+euH6U094hbx+AkrsKTiUrqQJPzpV5J68/IEZ11z3+15L/lAVc=
X-Received: by 2002:a05:620a:178c:b0:783:de7:f55c with SMTP id
 ay12-20020a05620a178c00b007830de7f55cmr371543qkb.18.1704460726480; Fri, 05
 Jan 2024 05:18:46 -0800 (PST)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 5 Jan 2024 05:18:45 -0800
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <xd2ryic6mr6d6cbljjbhmr56mfpchfzkmc3lnznhmoiwyzip2a@6bhbho267e7c>
References: <20231222094548.54103-1-william.qiu@starfivetech.com>
 <20231222094548.54103-4-william.qiu@starfivetech.com> <CAJM55Z9tyrR7emEBrY0+Fnc_LUFQHkqYHLQ4ptL=XQMy52qtVw@mail.gmail.com>
 <xd2ryic6mr6d6cbljjbhmr56mfpchfzkmc3lnznhmoiwyzip2a@6bhbho267e7c>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Fri, 5 Jan 2024 05:18:45 -0800
Message-ID: <CAJM55Z9DgFCwXjQGhe+urnOg-AkJMbQUR+biXKONQsRcup1GXw@mail.gmail.com>
Subject: Re: [PATCH v10 3/4] riscv: dts: starfive: jh7100: Add PWM node and
 pins configuration
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc: William Qiu <william.qiu@starfivetech.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-pwm@vger.kernel.org, Emil Renner Berthing <kernel@esmil.dk>, 
	Rob Herring <robh+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Hal Feng <hal.feng@starfivetech.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Uwe Kleine-K=C3=B6nig wrote:
> Hello Emil,
>
> On Sun, Dec 24, 2023 at 02:49:34AM -0800, Emil Renner Berthing wrote:
> > William Qiu wrote:
> > > Add OpenCores PWM controller node and add PWM pins configuration
> > > on VisionFive 1 board.
> > >
> > > Signed-off-by: William Qiu <william.qiu@starfivetech.com>
> >
> > Sorry, I thought I already sent my review. This looks good.
> >
> > Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
>
> Is this also an implicit Ack to take this patch via the pwm tree once
> the earlier patches are ready? Or do you want to take it via your tree?
> (Maybe already now together with the binding? If so, you can assume my
> Reviewed-by to be an implicit Ack for that.)

Yes, sorry. This is also meant to be an Ack from me.

I imagined the dt patches would go through Conor's riscv-dt-for-next branch=
,
but the pwm tree is certainly also fine by.

/Emil

