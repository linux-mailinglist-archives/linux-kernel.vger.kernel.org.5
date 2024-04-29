Return-Path: <linux-kernel+bounces-161817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA85B8B519D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 08:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DDA2B21A7F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 06:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A545B11713;
	Mon, 29 Apr 2024 06:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c9SMrj7j"
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9097914003;
	Mon, 29 Apr 2024 06:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714372893; cv=none; b=POzvISKFs7pJ+yi2U5l14rZ2NIu3EnwCucd/CnR6TqL7rqaC6MfiSH3gGMImEubsdnW3x7emh1DebN4/KDRf9yj4i4eGT0/SLH4ksPXUUj24U/T5V/bo62RPEpEVGB7yMzfO8SSdZHMJZU0QPu/SAH//vBLItYk4E6Cg+qOAP18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714372893; c=relaxed/simple;
	bh=h5Lbua+VlAcWdhu3QeUSNO0WmUWPNQk53Q3LU1vs5Vc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W7fQ2DZt5oVWxf+z6tPcoH2D6CnoqSMNcUmwruhwwFj+3eGTFCkZoPP9RiO+Ua0io4PAGQatpVz9MDULqPkIXxBkNDXjnU7q2bWmDESUHNAM7kBzziw5vtIUhH3v+3+G4X4F3tNTQK5e3k35iXBCCQTn2YugimUjqPIQ9c+HsSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c9SMrj7j; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5aa1bf6cb40so3045002eaf.1;
        Sun, 28 Apr 2024 23:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714372890; x=1714977690; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WgBY4OmPcqw82XexSWZuwlH1PM0/PzczUye2q4AdVKI=;
        b=c9SMrj7jwUwdpWr6gcmiJzxI2qbfVOj6HT6zRZdr0kxDr9mPzD2ytNsrE/uAX7rGDd
         7TsDr1DmE8zk73jvUTH1cSvQsxWC9WGb+RiW2tDr1DUz6KlyQ27bXQ1eay9ipDafPWtV
         Iz6M9E9Hevo7Tp0eG4u6wQ1NkM3N8oo9w58IcYDM5dNE9aFCu4Mln3My/Q1951pHqVXB
         XienHoy2G6IMvwHVYvjT7igctmfj9attnYbTHCMHx6/gzXDVl+JvyTMA5b37u9ETPpcd
         iekX31jXrBJkPaB+Ckcu1v1CUf8QDinvUh936bnNj9W7+2Y3TAJKt0sS3Ro2c+GbpU06
         cxkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714372890; x=1714977690;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WgBY4OmPcqw82XexSWZuwlH1PM0/PzczUye2q4AdVKI=;
        b=DggeSiyeUh55yH4Dq/HezSkyvhZutH55J+pr9JDkO+swEve3G3TQ4bjwvULUWtviRO
         kpWgkhy4jpP24LSqdGL0rFQIUv33ajxLGzAfiNAexMZoCB8j46ktUwyN12t3A+sBpWA6
         V+I4/RQDZ19+m4y+u68dytV9pF/I62gQS0du/gV+Ld8l0i7NpWKtcvFAfEyAfpoKJszr
         3EwDlTam/JKXHn08xib3H4LoawslowOK9Yk20VGd3a8oCKH8MG+UCPjStkYBMiRryZ1Y
         GGErGJbXajslxBlhtiBMv/j9aCvdsv3517b+6yOe/p60PDikMstBbo+29P51ZUyL9W7r
         4ZxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnoFH/S7LEqpqSAWv6WZ5PHQaS0jW8ul6F3V9HLb4qt2YLld2392cmrfvFQ1NCQn0DPfr2AtZO5/K/3Lbl6g5D9pE6aBB3bKZpo4D7A1ib1pJS1MGp2JMDAM/BnmOgSmbvu0IHSnqvphfe5vTSXIl3tEE+6Fvyiva73t+Lg0KjNrqLhw==
X-Gm-Message-State: AOJu0YxD8DsJbcFaVzQM/jdqKRvHgN0vzpdTGLSWaiNqBmH90xbWgBl4
	xgQ0YoCttx2cV1hJYfBn6b4Zg1RzDo24Wan5oXIIYIQ/wFjiAjEd/xqkurT+BBiU7m2N5wFd/7m
	9tiBQdn24hMaY2CBeyD0KCnP8znw=
X-Google-Smtp-Source: AGHT+IGJ4iLg2RHmdalKHLkfEPhg76eu7dX0uQvjEQn76xhlDTojLONLF3y7p8r9FUHtq//1J+Dn5+ECE3mnTZgr0BY=
X-Received: by 2002:a4a:ad4b:0:b0:5ac:6891:cee7 with SMTP id
 s11-20020a4aad4b000000b005ac6891cee7mr10929162oon.3.1714372889534; Sun, 28
 Apr 2024 23:41:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240427075426.662671-1-qiujingbao.dlmu@gmail.com>
 <20240427075426.662671-2-qiujingbao.dlmu@gmail.com> <40eee0ca-fb15-40c7-80be-a1198f37663d@linaro.org>
In-Reply-To: <40eee0ca-fb15-40c7-80be-a1198f37663d@linaro.org>
From: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
Date: Mon, 29 Apr 2024 14:41:18 +0800
Message-ID: <CAJRtX8RztQfeoBhGjdAZZBW5h9PQT_pYhyKCRsbXwx83SbCExA@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] dt-bindings: mtd: add sophgo spi-nor-controller
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: broonie@kernel.org, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	conor+dt@kernel.org, unicorn_wang@outlook.com, inochiama@outlook.com, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	dlan@gentoo.org, linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 2:18=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 27/04/2024 09:54, Jingbao Qiu wrote:
> > Add YAML bindings for cv1800 spi nor controller.
> >
> > Signed-off-by: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
> > ---
> >  .../bindings/spi/sophgo,spi-cv1800-nor.yaml   | 33 +++++++++++++++++++
> >  1 file changed, 33 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/spi/sophgo,spi-cv=
1800-nor.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/spi/sophgo,spi-cv1800-no=
r.yaml b/Documentation/devicetree/bindings/spi/sophgo,spi-cv1800-nor.yaml
> > new file mode 100644
> > index 000000000000..121a80fbf2d5
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/spi/sophgo,spi-cv1800-nor.yaml
>
> Filename like compatible.
>

I will fix it.

>
> > @@ -0,0 +1,33 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/spi/sophgo,spi-cv1800-nor.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: SPI controller for Sophgo RISC-V SoCs
> > +
> > +maintainers:
> > +  - Jingbao Qiu <qiujingbao.dlmu@gmail.com>
> > +
> > +allOf:
> > +  - $ref: /schemas/spi/spi-controller.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    const: sophgo,cv1800b-nor
>
> A bit unusual that compatible has nothing in common with tile of the
> binding, thus the name of the hardware block.

I will modify the title.

>
> > +
> > +  reg:
> > +    maxItems: 1
>
> No clocks? No interrupts? This looks incomplete.

If necessary, I will add clocks and interrupts.

Thank you for your suggestion.

Best regards,
Jingbao Qiu

