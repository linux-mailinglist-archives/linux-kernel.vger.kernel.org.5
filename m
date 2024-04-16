Return-Path: <linux-kernel+bounces-146841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8735B8A6BB0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B94CE1C21B85
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF4212BF31;
	Tue, 16 Apr 2024 12:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bf56ET9v"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B281212BE8C
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 12:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713272382; cv=none; b=jPqEBqvTr4fezoCjdC1eSNjBiEvnEJtXNv/5HBNc4hbAeT/tV/7nAkaTKNbx8ZphSyfYXxpnOtiJrMmLxVB3KlmBBuCcN4KAECi27BR0XWjoYH2nocl/e3+r3tKe+ygCt4zdUI2g/eXuR5ETyvgA81JpkdTB4eQgHSdCCEQ8JNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713272382; c=relaxed/simple;
	bh=9vivecuqLxpWcVVbWBg8R8WXEJKMUnErDIemeKW5USE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K8U6Dl4ogbSCA32Gz4J7R0FOWs8KguIzVKp7YU86KshDewEM52LH+kkQjHOyaMcSlve8SN2mOp4OefFiqm4z1C4XkapcetTPbZTE1jhSzb4/bb/g5hA2Jo9MW2H5L8gIClY+0trv5OCOnYTbRKxRlz2G4rUqRQZo468/zEhpyfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Bf56ET9v; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dd02fb9a31cso3715008276.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 05:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713272379; x=1713877179; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9vivecuqLxpWcVVbWBg8R8WXEJKMUnErDIemeKW5USE=;
        b=Bf56ET9vzemNftn06WexwwlQik2rNcSpAG78C+8luGrHqPR2CFDo40mpQlDn3EswOl
         9ZosYnW4niLBTuO8hpunvgS6hDKmsDd8ZsKI78aOJmN9rI8RtxangNi0G/ML9dxZg3Hz
         3X0ro0/V2rbTOJN4PpWrAuwn8SFclUKq3EB/V3ZDPdrLNbCAl78rSST2OBWzNzRThusS
         /5sdFqa/7zje6ZVFWtfiFpQdwm2cV0AKBIOcOx32r109HK3woj+MiHFXeJuMnkImv9sn
         PE5Sf0fyZWBN46sd0W0yI2+krs/5fpS1zwS4xliavQCzZOh7c/xJQhL60goB1IpXz5x5
         C92A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713272379; x=1713877179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9vivecuqLxpWcVVbWBg8R8WXEJKMUnErDIemeKW5USE=;
        b=dKv0DleH6QiqntBIs9i9BsHBqi+WkxxbSSkEjU/VGgf6kjmxUyOAoFB0/BvItYgSbp
         1zZHG9Xw6exUH7L7UmPoyvVUD1vslfnCEMErCvoDYQsK8wS30IZJS+l4/qQu0JKZZhn+
         eh3gwNs+RhmsfCCiF31sS/mzSsCrcDpTjuQrlV49GPF+OPGAvLqD2OhuJVApAB3zxfoD
         xn5sNQqe+wEs2ayKQtb9HrbSNOthA0eMjMRwOkrH2HQfAfd2ZC505Ycrky7IldNXc+Mp
         tk1AOZKnwXI12N9t5xBQNi49hQG4chBGmauTt9Src1a4HdiLvvzgPAEJ9LwwSWqBY77t
         u8tw==
X-Forwarded-Encrypted: i=1; AJvYcCXy0PsI6JXZyvtd7mA7Ai0QOlBMTs/WQi8qtq0ARrPPZ1Hx3CQamOz0mrWWrDiViHZeYqUErroYyyXdOOQz0iLDmX2ri85aF+IbA6TJ
X-Gm-Message-State: AOJu0YyHnpt8mdZrvHIrGmb0EdecMuHRvgC2sl4K26Tc59i4vJevYyd2
	4jHSVDsZjm1tdLoecW9fRBrA74MdPRQCJYtKbICJtV4+6VU9dmqID8N+vNChpSQbw+CicI4Z98l
	yWAxaRt/fxlFvIAHACUXn15xA0R6smx2YUqfVPg==
X-Google-Smtp-Source: AGHT+IER4ET7tjdY7MFE9y9iXSWpKZRx6QzxZXviRVDxpgAQBBJ7zwMk5n1oREBP04xnwa9enbl+aCjWdoQ+zs8fiNU=
X-Received: by 2002:a25:2747:0:b0:dd1:ebc:ca2d with SMTP id
 n68-20020a252747000000b00dd10ebcca2dmr11141827ybn.52.1713272379300; Tue, 16
 Apr 2024 05:59:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1713036964.git.andrea.porta@suse.com> <2d1272cad92ad618297a6683e9264e31b8f2df73.1713036964.git.andrea.porta@suse.com>
 <f6601f73-cb22-4ba3-88c5-241be8421fc3@broadcom.com>
In-Reply-To: <f6601f73-cb22-4ba3-88c5-241be8421fc3@broadcom.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 16 Apr 2024 14:59:27 +0200
Message-ID: <CACRpkdbGFpFM3WKXeAy8nfXUf46GKPNBM8sfi3X-WWQJ=A9nhA@mail.gmail.com>
Subject: Re: [PATCH 1/6] dt-bindings: pinctrl: Add support for BCM2712 pin controller
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Andrea della Porta <andrea.porta@suse.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kamal Dasu <kamal.dasu@broadcom.com>, 
	Al Cooper <alcooperx@gmail.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, Jonathan Bell <jonathan@raspberrypi.com>, 
	Phil Elwell <phil@raspberrypi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 14, 2024 at 5:45=E2=80=AFPM Florian Fainelli
<florian.fainelli@broadcom.com> wrote:
> On 4/13/2024 3:14 PM, Andrea della Porta wrote:
> > Signed-off-by: Andrea della Porta <andrea.porta@suse.com>

> > +++ b/Documentation/devicetree/bindings/pinctrl/brcm,bcm2712-pinctrl.ya=
ml
(...)
> > +$id: http://devicetree.org/schemas/pinctrl/brcm,bcm2712-pinctrl.yaml#
(...)
> > +title: Broadcom BCM2712 pin controller
>
> This is not strictly speaking BCM2712 specific, the pin controller you
> describe is a Broadcom STB product line pin controller.
>
> Please describe it as such as and make BCM2712 a specific instance of
> the chip using that pin controller, see more comments on patch #4.

So also the name of the bindings namespace should not be this one
controller IMO but the name of the family, bcm-stb-pinctrl.yaml or
so.

Yours,
Linus Walleij

