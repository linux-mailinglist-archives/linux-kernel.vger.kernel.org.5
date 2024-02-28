Return-Path: <linux-kernel+bounces-85228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D61686B283
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 15:58:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE2C6B244D4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A0615B10D;
	Wed, 28 Feb 2024 14:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zjh0SRi4"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8622273531;
	Wed, 28 Feb 2024 14:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709132303; cv=none; b=F14WRnX3A6VtOxPr759TJC+HWQW1WKsN5kq/A+jXLCCun83snA2QwJSWCg1HDWk3re6PLTvfE40K+vuAakfn4qbjOher2srv3rrcL+mIiU7dugWavjM2r+wc5vEbpU+G5R8bCn4+PIdDqW7oMnytxv6zTk3qZaCVNDU9hFWnitQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709132303; c=relaxed/simple;
	bh=D0mxBNIYaM/LvyCACLqGR6ej8KvkbeUqHMXZmcDYbD8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JfML8tCMaKi0Vu+3zbm3FVykBjbhbtgQ9x7+LZjs1u2uRXauR1M5kCiIHiErUb4hckEpjVV9zv68Il76FLMnC2cTXGZ6ATAJcRSn3V95u3TkI+w0w4rdBwmEDz1XTPxGo9UOIqs1OE6DS7Qr5wsvtToYYy50VHBKyquAXVJ2O9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zjh0SRi4; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-55a8fd60af0so7758447a12.1;
        Wed, 28 Feb 2024 06:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709132300; x=1709737100; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TQb0JnJ+sgplpcUuC4pN4ac3IxkeDfhPVjjzotONsYA=;
        b=Zjh0SRi4Oeds13svzg5jn4zqXfUVbjEYxIRX0QtV4cQb0jyFToNg6xwXtM97S9WjsQ
         Uf/I1E5aG5gG/aFHAdkq0w4lWmKcrRqbDBmUam3Y8xGJIehSU+SR5T3wUlmZAH6kpr6u
         IbGmaiDgJOK2yVby3OqPO/LZxfkPD+Lb7IRKTWRZsijoCeUdQsKBed5sS7TMDcYLWsP6
         NFaxMze4ypW9mma6kNjYL8P9YQfKmLRKPqrDSrmN0n9+pl/asArC3iIS7fSIjukAIpjo
         mr3PmIxJefBYHyof8KidWrcqAGcw1WSBAG5MjSVi1jyYsVqJlZSQfacPR0FeREE3Ly2D
         WdpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709132300; x=1709737100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TQb0JnJ+sgplpcUuC4pN4ac3IxkeDfhPVjjzotONsYA=;
        b=AGdsxARQlmPucgU6/Dizu8DxydAJDh0MLhmRaCpBiZGqjXKc7QCnYVYFspf2tTwD5r
         3SzL8+IadywutQs3bPy7tmphDgchzWRQJvKkit+9W6GxElmufFb87rp/S2FERqO7leDw
         RgfaGJ/IGkrQmu77HlGPHYwEwRhTjdn2C7J+lPRZgCT3XS6StLZB/mUjxhOyrW5MF7wl
         M70oAox3j7QKLbjQPkvVIH6VsqGTt1WjdAa1NmECOtvSjoqMP5NNDuXT5Mx9618fN8oy
         Zjz1YPm5rFF1Fn+oqgpEYFKptMDWLeM3HUh36ICUytZ+1x/4lZ0cEUdsnwUQGOWhS8C3
         R1cQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCTwY7k8j1GPxmuAufU15SqWBE7JPy7Dn7hjLF/YXfScmP+5C1IwoslH1pjhfzkAaUmWLEjhMgkEy6yeNqw9FArtn7axTKQfV0b0HptdjQTTcO7vTgNV37HKSG13p5YSp9/KyJ7dPZYuvAmdhTNQWFtjsuVGZXuvXqV5W/CnkrMMDS1Es=
X-Gm-Message-State: AOJu0Yyypdcv2KVLflMjjqbgvBqP+/hDhGDNJrNLEVhgijqP4G2QKwyd
	oU2X2AiUNckDZvfknzIxE7HF8gsnNswQWlaLR4omtWYcKY/4Njh/Gy9Rfv5TrpDkIL535SdTnsI
	WpNAXEL11lHbP+vNSgoL2CCCS4WU=
X-Google-Smtp-Source: AGHT+IHbUi80zT/GDNSOM62vj6itxNrIGGGPlRo9mbQuyAjdAlxxHCTGE9XVvRXPzk9pIjfFUK/K2RvzZlnWYUOiUpo=
X-Received: by 2002:a17:906:6dcf:b0:a3e:b3e6:5b71 with SMTP id
 j15-20020a1709066dcf00b00a3eb3e65b71mr9147554ejt.62.1709132299649; Wed, 28
 Feb 2024 06:58:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227212244.262710-1-chris.packham@alliedtelesis.co.nz>
 <20240227212244.262710-3-chris.packham@alliedtelesis.co.nz> <20240228140423.GA3307293-robh@kernel.org>
In-Reply-To: <20240228140423.GA3307293-robh@kernel.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 28 Feb 2024 16:57:42 +0200
Message-ID: <CAHp75VfW0Q7At+JnyWGXP3d=2dfWADRiQ-Z97B2JcZio3A_tyw@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] dt-bindings: auxdisplay: Add bindings for generic
 7 segment LED
To: Rob Herring <robh@kernel.org>
Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>, andy@kernel.org, 
	geert@linux-m68k.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	andrew@lunn.ch, gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com, 
	ojeda@kernel.org, tzimmermann@suse.de, javierm@redhat.com, robin@protonic.nl, 
	lee@kernel.org, pavel@ucw.cz, devicetree@vger.kernel.org, 
	linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 4:04=E2=80=AFPM Rob Herring <robh@kernel.org> wrote=
:
> On Wed, Feb 28, 2024 at 10:22:42AM +1300, Chris Packham wrote:

..

> > +  segment-gpios:
> > +    description:
> > +      An array of GPIOs one per segment.
> > +    minItems: 7
>
> How does one know which GPIO is which segment?

I believe we need just to agree on this. Since anybody can shuffle
GPIOs in the DT, there is no need to support arbitrary orders. And
naturally 'a' is bit 0, 'g' is bit 6, 'dp' bit 7 if present.

--=20
With Best Regards,
Andy Shevchenko

