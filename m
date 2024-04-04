Return-Path: <linux-kernel+bounces-131041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D415889824F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 09:39:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59288B23F79
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 07:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD16A5A110;
	Thu,  4 Apr 2024 07:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JN2SnF1q"
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEFC1CFBD;
	Thu,  4 Apr 2024 07:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712216325; cv=none; b=SAvPo4h/s14Poc1JRmMd+HoMsIZ6uYUy5iuqhAKP4tAj8DVNzvk4UT7oNlwPIEtCJ03xEEU6fbuGFseZqrZuq+XijiC6rPrZuc4BeO/lot7nxUJi6SZhB5ogSLAdqWuo1KUUjLd/9RHMmlMJ42skY9Sv1UND3jDgYOCSnVAPdBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712216325; c=relaxed/simple;
	bh=VI6p+4L4BRKcApkAcCV82aS1Qi1Z1UvR8SX+4NHMGnw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SzGY52b2OrVOEZ99OW3kUaV53jrDqpYttX3e6IXtzqfGYDgg4ntk7jDvbAbjNnEEniX7E58+e2qiZS60ITCsu4pAqMkeur82kYMKSxTnaHKWCOGq6iwJ8DrHBAAXvvR9bl3fDVigWnfSrV/hL9C3OMyCFn7VQquP0YDvAMOHpH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JN2SnF1q; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5a7a4119d02so293336eaf.1;
        Thu, 04 Apr 2024 00:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712216323; x=1712821123; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=we2O1Ti81VxZtCCVRPAlQfc7bOWmir0153692cEekTA=;
        b=JN2SnF1q8aYkV27/mPu/k8WqwTxYErayIRM6m7Lg1iXx7MOmYOPPHYwrfaHNgcSR5g
         kcAt9ZUL4m3TWDEC1ffzhFoRD3oJNB8s+eFmif/Am4RmWKVB7r28SfWbAWMxdL+G/1ZR
         uIodC6OxTjd5vBFuKNJi3EuN7y2YzPAsSzDqZkmUQNgbKJDNM8c0Be+zhGz9MEVncVbV
         09wKqQnYW9TAb4NQDg8ZL3VOm20wJfc3Aq4/DdQYItMrPo+6i9EAdZjZoRFe2EWUpKWn
         9KBRpC7jSTqWEiiWz2ePMdVRzqJ3GlG5XcOwd7taYhGz3WPYDuqHoSG4PJyIzAKrgf2e
         bTJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712216323; x=1712821123;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=we2O1Ti81VxZtCCVRPAlQfc7bOWmir0153692cEekTA=;
        b=CAPnsx3rMl7tKEpIqQqpwbCqPPHEht7RAad8Ll67VAO9rrJoNXa7BEOxYqKCUdpTxD
         q/CJ5EZFvMT/Zf38eeyc82OKXPnL8LMpu5krc2SxmY5oC3oIaspkFliydB+Qby1iynD0
         aMoeMQ9X0lVJvNnplNq1mFn7AYK5fMkWbncj1j/JAK5Qdt0KlqNTXpq0X1DvcP6Y0NAz
         fSsTsYsT7tQNGKkS4ZJZBu2Zyylv2TewfEWJLHwen6u5rcX6a3DAIhhJ24y0mX5F0d9R
         ryKTSLTlfrv3rxvKaCPT12U6ZgjKeyO6sI+dTZNp0LOzyh4cRK5t4ztKdchp242amESc
         QMHA==
X-Forwarded-Encrypted: i=1; AJvYcCX4xG6RXRcL/XREIKWKUjZDeEEnZvaFHGbew3x8Np5F5fisb/0hDcOZOG1Ogcn3dufzwgPxKmWUuyi+UntOWq9VWq8aX9OIkx7aDUtZCv9Vhp86iIS+0zJkDSZTT+dj2Vyat3Sc1wvG3XwcZLCajTx+2jlS3X4Eu2u4QULMqLzY83E/hb7rG1OPMJk=
X-Gm-Message-State: AOJu0YwMcTNSVNO4TH+vTD/iIKSB9NhB4MEferqqXf29A+JwAccLvnLc
	UKUq2D4raW/XjoKSj+aT3fM75O0pW9kOZFNxhbqxFI9wuEndJjgDkgm0mKZoqzAmlwwY46mzxf9
	yrZ1BNG2CSI0Q253WIFUQKRTUw3M=
X-Google-Smtp-Source: AGHT+IETHfDKs90ZM2H1TVHcAUgZqVFrTvOqJYL9jrxo6+qMd1YqwAdGD0Ml1tnLH1xe1d0c1QgdqCpI1PaSO0LTKYY=
X-Received: by 2002:a05:6820:308f:b0:5a9:d519:b541 with SMTP id
 eu15-20020a056820308f00b005a9d519b541mr1858551oob.4.1712216322675; Thu, 04
 Apr 2024 00:38:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404071350.4242-1-linux.amoon@gmail.com> <20240404071350.4242-6-linux.amoon@gmail.com>
 <d6d5f6d4-1d34-4d42-9afc-822a014063dd@linaro.org>
In-Reply-To: <d6d5f6d4-1d34-4d42-9afc-822a014063dd@linaro.org>
From: Anand Moon <linux.amoon@gmail.com>
Date: Thu, 4 Apr 2024 13:08:26 +0530
Message-ID: <CANAwSgSe37Pn062enCLd39P+RXU1VCZugyz7oDRafpnU1FyN1w@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] usb: dwc3: exynos: Use devm_regulator_bulk_get_enable()
 helper function
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Johan Hovold <johan@kernel.org>, 
	linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof,

On Thu, 4 Apr 2024 at 12:53, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 04/04/2024 09:13, Anand Moon wrote:
> > Use devm_regulator_bulk_get_enable() instead of open coded
> > 'devm_regulator_get(), regulator_enable(), regulator_disable().
>
> I fail to see how did you replace open-coded suspend/resume paths.
>
> >
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> > V2: no changes, did not find any regression in pm suspend/resume.
>
> No, that's not equivalent code. No explanation in commit msg.
>
> You already got comments on this and nothing improved. You just entirely
> ignored received comments. That's not how it works.
>
> I don't think you understand the code and Linux driver model. This patch
> repeats several previous attempts with similar issues: no logic behind a
> change.
>
> NAK.

devm_regulator_get_enable and devm_regulator_bulk_get_enable
both remove the dependency from the driver to handle the regulator_enabled
and regulator_disabled. ie this removes the regulator from the driver structure.

Since these functions set devm_add_action to disable the regulator when the
resource is not used.

     ret = devm_add_action(dev, devm_regulator_bulk_disable, devres);
     if (!ret)
               return 0;
>
> Best regards,
> Krzysztof
>

if you feel it's incorrect, I will drop this patch..

Thanks
-Anand

