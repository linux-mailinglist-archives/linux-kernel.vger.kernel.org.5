Return-Path: <linux-kernel+bounces-87169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 986AD86D098
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:27:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50370289E2F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34B26CC1B;
	Thu, 29 Feb 2024 17:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gateworks-com.20230601.gappssmtp.com header.i=@gateworks-com.20230601.gappssmtp.com header.b="D7HArK7v"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6691F70AD5
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 17:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709227634; cv=none; b=kQSxUo/zzxaiFOzCnlk1WHFM0mG7N68VjJLyZzoDovydpxoijpwFv+O5dcHMUJ7OS/xzr9x4hGKC39lEV//CrlqpiBzFNc89KdzvrDFwhC2TbuStfXkpxxykzgam3gcdeJNt8uNHfUICsecYDPbtvO2+UvOJw6L/AD6pKE92irY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709227634; c=relaxed/simple;
	bh=853yl5T7RBe14Q7Ic1pdq6lruxKv/bJ3MDmBIIZWjSs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=kJ0R4IR4NQzLxaX2w20jUuOai2R1n0Bzu5sOcJbJakpO1cF/48cqSaga7Ic4ZG/FVMtlTUXisHXuuFW/du9TMMOfTAlDaR/DPNsJ8fyyXPOc7cL5WJE5ftP0i4FnSRw2Lu3Ywlu16WIHr1/CMBxOxUuIwecyg7D2Pu08+k2fLfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gateworks.com; spf=pass smtp.mailfrom=gateworks.com; dkim=pass (2048-bit key) header.d=gateworks-com.20230601.gappssmtp.com header.i=@gateworks-com.20230601.gappssmtp.com header.b=D7HArK7v; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gateworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gateworks.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a3e550ef31cso176202966b.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 09:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20230601.gappssmtp.com; s=20230601; t=1709227631; x=1709832431; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=853yl5T7RBe14Q7Ic1pdq6lruxKv/bJ3MDmBIIZWjSs=;
        b=D7HArK7vr9IhpSKV4M7w9oNNLRVkDv2nHrmMYoHqdMt3zlGxuvyFgItSMicyJml6zy
         zZ6lXJvw0qlj3ASNSRgTtfHhyzC9sh0kKmneDlV6lUWixHQ5zCQJo8KsdqwJ0chIljsk
         kPJe/XsoRDcHWJQF+WmkSb1V9DrVaZ5r8phH9+ADImYoVCvZHf2WYMK/COva+614TbfM
         Mb6hk5q7btSiXvxqyfEGtZKaPHJdauIsLlnyLmFJGmPgyA3mepWUSms1VyPvkX00uIPk
         Q7rBPDv100R6vRzeoNviXnB3wxIeYzHXRZlBjUcvpvjK7ISa4lH8kmAyZesldhxIE2k1
         jlSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709227631; x=1709832431;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=853yl5T7RBe14Q7Ic1pdq6lruxKv/bJ3MDmBIIZWjSs=;
        b=LuYWrIteLJR4Wq1+rPVpa/VOuvMCBe1adQyIrA+kVvs4Ww2Q2yUeWR10tvYJ6W99qO
         CItciW52RTzy+FY9iPaM4tUF333P5Mv8PWmIQvilZO9p3f57jm6xDyAXLANa20SwJLHl
         kVYTKemiDkleHt4OZYUtkhJlSKJ+Q7ZgAyi82REkQKNws2Sh46J6KXGv56etoiQyXJB/
         Eo+HgEU+APNT5OeinIVjEc07qwBWoxo8Anwpq/RnLSkdxo+5swMoMUXAdhWvwt2LFfWb
         iva/2jea96LY8x/KusRIPfSWfvtwMb8dma1UpttyxY3nC3QFg3lbDDP7Kk0xYAxSUpEa
         Moaw==
X-Forwarded-Encrypted: i=1; AJvYcCXMAd+vqw6Lk7Vs2P+w2qO+IZULKNf9liUeLVfsRMtDcWC3shmyn9U0nvKJAMv3VlSyc39cPf/vih4jIS6Qj0JFR1gmfjpHykJl+5we
X-Gm-Message-State: AOJu0Yy1eYcXuJyQJoYzmF4Zabq49PR2KLUGd9xi8fX86fdXiNNi4qJk
	wEKbSwfjGNErjZIlMl65l76M/qQZBIIDeilpGOf3s4g6D688wPeS0ZEhgfM6JQkoVo7Oi1U/14s
	fjoP9p2DwPA7rK7tg3KzOESba/O9KFNMkooa4zA==
X-Google-Smtp-Source: AGHT+IHY+BeReToKKxC+x9eEFVG469n2fNVsygBbwAcPapCF0QV3dnwOTqV/Fu19u/7jKdln3AQTI2lVnWJwQiLIPYs=
X-Received: by 2002:a17:906:5fcc:b0:a43:a4a1:1945 with SMTP id
 k12-20020a1709065fcc00b00a43a4a11945mr2004809ejv.75.1709227630755; Thu, 29
 Feb 2024 09:27:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Tim Harvey <tharvey@gateworks.com>
Date: Thu, 29 Feb 2024 09:26:59 -0800
Message-ID: <CAJ+vNU3y5pzqeBnr8LHDtJtU7zajfRvP=_WmAhP=cAp_3iGFQQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] reset: add GPIO-based reset controller
To: Sean Anderson <sean.anderson@seco.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, andersson@kernel.org, bgoswami@quicinc.com, 
	brgl@bgdev.pl, Mark Brown <broonie@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Device Tree Mailing List <devicetree@vger.kernel.org>, konrad.dybcio@linaro.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	linux-arm-msm@vger.kernel.org, open list <linux-kernel@vger.kernel.org>, 
	linux-sound@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>, perex@perex.cz, 
	Rob Herring <robh+dt@kernel.org>, srinivas.kandagatla@linaro.org, tiwai@suse.com
Content-Type: text/plain; charset="UTF-8"

> On 1/9/24 04:41, Krzysztof Kozlowski wrote:
>
> I think a separate pseudo-device is necessary a generic solution. So I
> guess I will revive my patchset.
>

Sean and Krzysztof,

I see a lot of value in a generic reset-gpio driver that you have both
tried to get accepted in the past. I support boards that have a number
of SPI and I2C devices that often have GPIO resets wired to them that
are pulled in hardware to the in-reset state and find no support in
the various drivers for reset handling. I've often wondered why a
generic gpio reset wasn't supported in the SPI/I2C cores like it is
for some other subsystems.

The approach of a gpios-reset solution makes sense to me.

Will you be submitting a follow-on series to your previous attempts?

Best Regards,

Tim

