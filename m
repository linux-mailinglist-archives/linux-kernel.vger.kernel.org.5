Return-Path: <linux-kernel+bounces-86403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA7E86C4EE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C781728C5EC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 656765A7A3;
	Thu, 29 Feb 2024 09:23:33 +0000 (UTC)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D525A0FA;
	Thu, 29 Feb 2024 09:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709198613; cv=none; b=ZFxhmwoK5zRBTSOKurfDXCb6fXYYRXBF/i5vmhtdYXoQWAiZuu5tDwrSgaQUdyPCLb3DEeBqktsBPpU+T3VfQR3Uhdml87D31hg6k+Z3xpwVSs1mjiWtE/PmC0E7Xl2DFdjpnZFsOXkEKJA3VwnULqyRHTovouLHyTasEF/kA9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709198613; c=relaxed/simple;
	bh=1XU1cs7VALNZKx8vt8v+2D2SZJDuWIN8jcuP7QRWL+0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=np4buvEanZHEdRFINyiPA7xKqA5YfLxQYSChM2s52DLCVR59kHiTwuoHHefdMoBgJ7LKbnLPgkuUITGx0ZScHbAeMBjGaCv8RcwYpwIoVA/Q6Ai3nm86woOS8ySxCLglfRCe+ml7YfU4uEkx7auwcnqiQkIda75xuREmxPbqgiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-607f8894550so4780917b3.1;
        Thu, 29 Feb 2024 01:23:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709198608; x=1709803408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OiC0kBtF19WK+LeOA4CJH8Hju+1dSIg0bD9jOGn2HI4=;
        b=duHaSaSeyQBC6A/vEY2iPLI2tr85QyqIIH1AH6nWGMR50sXCDMtp5CD4UGVg5r+v6e
         gtHYU+stNe6mo86+GNcQLfubLWqO6RAtvz4kAf6D6WBG/6MGMKUgDzIEafk9lIDlOBjv
         ta6GHL1aeHC5byJXT+1SmQQYnaxUIAU7dy6HiuS5QwGCg62A/RcE2hQ1R0ErROf2XyOM
         wVJrOw5oXKRT/1t6PpGvAb0iuZJJdF6X/av47UZQwK4fyyURWiqVi3J32xoehzoDFIlD
         hWyHFUCLk8LkhStmjeHvuw0Kci0VWGAZ2MplG7Qsfu1+KpVAxue/rsZr5cEGuSx2YmKK
         Qp3g==
X-Forwarded-Encrypted: i=1; AJvYcCU5+H4nziWIF50Ce893L7qK/i80aNROXHYscSKqPThpZp+bskgkJga8ovjc0Gq6ZbTrmZNstTWHAKU0OR3aPF0Dzu0647vHF07w90TKXgwO0QA1rw+XpNwK8yAgi32qKsfI1AmguTY4QStg8PFiZdaeMES9d5FZQl9fHdsUVAkkzXT5Jas=
X-Gm-Message-State: AOJu0YzbY8AlHDTZ1XC0YHjqrZcSEKbETAaWFgid1k8BmWdHgkR7LNm6
	Efqhx4Ce946C62FPVxSEc7n27Z67XyUfjXi/9Nn1YNDCuKiotSjBfQIHgTxqhTc=
X-Google-Smtp-Source: AGHT+IGvXpeYNw7meFiNlQliBLjcWukM3ve37TtSWhkfayEvg/75caWbmHFytSgCpxjWvbbIGoQbjA==
X-Received: by 2002:a05:690c:dcd:b0:607:ca2e:f23e with SMTP id db13-20020a05690c0dcd00b00607ca2ef23emr1985495ywb.30.1709198608135;
        Thu, 29 Feb 2024 01:23:28 -0800 (PST)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id fr2-20020a05690c358200b006079f55766bsm258909ywb.68.2024.02.29.01.23.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Feb 2024 01:23:27 -0800 (PST)
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dc6d8bd612dso755284276.1;
        Thu, 29 Feb 2024 01:23:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVd4N9ZxHM2NGYE/jajMl9VA4HhvWHlSnnilVGCiqOW/14KuADINTJT8yuL1QM2SzmfZHHBHFN6nCH+DVyoFFZ1oWYgaVeacFRCOC7Y/LvJPXz3IoC+BaauO5w/tJwgwwQzbq2pqGbLNLbHkh8YWmiIBZkIjGAf7MWMQTHwvcTp5usyQ4c=
X-Received: by 2002:a25:2903:0:b0:dc7:1ab6:6aca with SMTP id
 p3-20020a252903000000b00dc71ab66acamr1586095ybp.63.1709198606631; Thu, 29 Feb
 2024 01:23:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227212244.262710-1-chris.packham@alliedtelesis.co.nz>
 <20240227212244.262710-3-chris.packham@alliedtelesis.co.nz>
 <20240228140423.GA3307293-robh@kernel.org> <CAHp75VfW0Q7At+JnyWGXP3d=2dfWADRiQ-Z97B2JcZio3A_tyw@mail.gmail.com>
In-Reply-To: <CAHp75VfW0Q7At+JnyWGXP3d=2dfWADRiQ-Z97B2JcZio3A_tyw@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 29 Feb 2024 10:23:15 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWgytkANQ19=pSfG7Jpddo7Htgp2P=p7EAVmpWYuGPmCg@mail.gmail.com>
Message-ID: <CAMuHMdWgytkANQ19=pSfG7Jpddo7Htgp2P=p7EAVmpWYuGPmCg@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] dt-bindings: auxdisplay: Add bindings for generic
 7 segment LED
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Chris Packham <chris.packham@alliedtelesis.co.nz>, andy@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, andrew@lunn.ch, 
	gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com, 
	ojeda@kernel.org, tzimmermann@suse.de, javierm@redhat.com, robin@protonic.nl, 
	lee@kernel.org, pavel@ucw.cz, devicetree@vger.kernel.org, 
	linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andy,

On Wed, Feb 28, 2024 at 3:58=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Wed, Feb 28, 2024 at 4:04=E2=80=AFPM Rob Herring <robh@kernel.org> wro=
te:
> > On Wed, Feb 28, 2024 at 10:22:42AM +1300, Chris Packham wrote:
>
> ...
>
> > > +  segment-gpios:
> > > +    description:
> > > +      An array of GPIOs one per segment.
> > > +    minItems: 7
> >
> > How does one know which GPIO is which segment?
>
> I believe we need just to agree on this. Since anybody can shuffle
> GPIOs in the DT, there is no need to support arbitrary orders. And
> naturally 'a' is bit 0, 'g' is bit 6, 'dp' bit 7 if present.

Note that there are no bits involved at this level, only GPIO specifiers.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

