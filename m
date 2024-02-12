Return-Path: <linux-kernel+bounces-61334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACBC4851131
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:39:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 643F4283657
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 10:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C89822F0C;
	Mon, 12 Feb 2024 10:39:09 +0000 (UTC)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CE220DE0;
	Mon, 12 Feb 2024 10:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707734348; cv=none; b=oEGOUuuirIMPpp2SRnCuZgOgsO9Q8Mx882s4+6to+EuTOmwrE6zs/mvfZZwwiF3xZPjouOlVQJqumC/p9qAPVAdDk4barGnoeNcYmr078kGV5kynHnW9+LIXA8tFoTS3qihHBm+occsqaaqkVYSHCI1dQh5MridRcJHGSQPzUmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707734348; c=relaxed/simple;
	bh=vIRnSA2/UCHVJY0PheUXzIsMIR7oHMdU5Plkmeo92RU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lym2PmIos9bPSAiprV7c7V9kOTy9S8s7Sh1WwU71OB9QJsog+02AaUQ1S+IYMm6WFyegKJcxfmZY/gRZWkzZfaVxktwfZWM13LEUaG68/XpzTT+OhyKJ5hTrmPdEbcCY/mMaz15s+jH/yfbl/5jvaEMDbTLeo9yYGwKLfcMBG0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-60755a1ecf2so7967647b3.2;
        Mon, 12 Feb 2024 02:39:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707734344; x=1708339144;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ayXpZPY1fxadVeIhcDF8L8oSKL8BElfr/ZnMo8cAPwY=;
        b=jGa7iFcuBxoX3INMy4aUtb3b+TEKXOJst998zmD/GajmdsaQRdyrf9Edlg5aBbbzMO
         8vhfjoEASZSnpwhui5gu9Pzn3ua6dM9ndGbdz9RJAN9nEnhM7po+HV4+pyXGw6lPXoHe
         7X6nv2mb7Fp/FKiv+ED02g7jrJwmYTyFj6SPLHdxImD/MJAQnCMxq/dKWfFlSD+aEdWV
         fIQcM0OCRh8ZdXyHbVMJxJ59yV/clp7GGaNsF8OjsFzL8k84IfGqN/rOIzcAyCqcspX7
         aX8iCH4zWUExwQaX4nvI6kyEZMc1Y0gB+v2bPBVHhMYbCknpCAt0pmQ/tjMM/OH7reCg
         lRRA==
X-Forwarded-Encrypted: i=1; AJvYcCUqfI08xWbz0aPx4PjLgsSC8Eru1YQqSZH6DIENweU1xvWYPzDwt9xOqSZX/UGamboiSFeK0egYGiebA4lZyOSn7XF4DEDhggCusIbFa/WKyqUZKt16Q0f3uC3sfauYNaYXtAUhRualiEKUh7jJRYm7htD4oT6WkikdT4wGdWX5PL4Gmcl9Oh3Ks+xzhFLKcpUExFSHevkOfL+cMiFZAkbgXQKTtpGc
X-Gm-Message-State: AOJu0YxXbBrkgStGmnK2x6H5dSQs1WmXMGHH2CQ+QWpcu5+5PsGcJPI7
	Mq/G9Q2HuVySiFb45yocXSQOeXM4CGScdOqMzJ5+zcPmyo9eJKFjIf5J1NY4jr4=
X-Google-Smtp-Source: AGHT+IGpcZCRDManNxfuM+NTuDBIOtTIqHhhJ2cPKmEyp2zOmP7j2xbXtmYobZD0MtESEHApe0kSCA==
X-Received: by 2002:a25:d884:0:b0:dbc:ecba:70fe with SMTP id p126-20020a25d884000000b00dbcecba70femr4777932ybg.65.1707734344068;
        Mon, 12 Feb 2024 02:39:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXbYEpdKLfmAwAgKZA5x/wKR7PWnzLYovSOmeUBmeOPC+mttf2bSP5w4+NkocsXzHbZjjQRDH9nQcRZMb25RSlaIB3vyd57MThQ7OppOFheLKNDzL8FVsP3PpCd+OqDc7kiXVkBnXYValbdV4ttSa/QTGxbkC0KqGCkBcEu2fSY+lOudg4SJAli+0i5LGKdmheewIxF673XpMR4rmW4W1FIOoeXErO0
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id f63-20020a255142000000b00dcbb7dd8b86sm16055ybb.52.2024.02.12.02.39.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 02:39:03 -0800 (PST)
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dc74897bf61so3017735276.1;
        Mon, 12 Feb 2024 02:39:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWkYDX705pITY72aesnaqV1dit6nMSGFy7yZRw/vy4yTPhz6vOgTEN06O6TEYiora3kcQFTDI8zEl9Qx7UQzXdn+g0NDuA8UBanP1rv8Y2n9Bs0+/KFlTFhzZnH7PccUjMxWEOPfwJ7lkn6PXEWMtlRdzFFg0/cvjJDaAUMma2ZQqyN4NBny2vM1KV3qXhbugbYhEi0IRXXhEoF1yHLT7Jy86f39NK3
X-Received: by 2002:a25:bc8d:0:b0:db9:9537:2c39 with SMTP id
 e13-20020a25bc8d000000b00db995372c39mr2124911ybk.2.1707734342729; Mon, 12 Feb
 2024 02:39:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208135045.3728927-1-tudor.ambarus@linaro.org>
 <20240208135045.3728927-2-tudor.ambarus@linaro.org> <20240208-grating-legwarmer-0a04cfb04d61@spud>
 <c2b08463-cb13-4e9b-8797-8ebcf1047f66@linaro.org> <20240209-chest-sleet-a119fc3d4243@spud>
 <0ac8d573-6486-458d-afb9-090b5f8d4a21@linaro.org>
In-Reply-To: <0ac8d573-6486-458d-afb9-090b5f8d4a21@linaro.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 12 Feb 2024 11:38:51 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXEKecx-wQCSzqmRr6af2AUOnoFhfD2JLx28n8OYnvzGw@mail.gmail.com>
Message-ID: <CAMuHMdXEKecx-wQCSzqmRr6af2AUOnoFhfD2JLx28n8OYnvzGw@mail.gmail.com>
Subject: Re: [PATCH 01/12] spi: dt-bindings: introduce the ``fifo-depth`` property
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Conor Dooley <conor@kernel.org>, broonie@kernel.org, robh@kernel.org, 
	andi.shyti@kernel.org, semen.protsenko@linaro.org, 
	krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com, 
	linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	andre.draszik@linaro.org, peter.griffin@linaro.org, kernel-team@android.com, 
	willmcvicker@google.com, conor+dt@kernel.org, devicetree@vger.kernel.org, 
	arnd@arndb.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Tudor,

On Fri, Feb 9, 2024 at 5:55=E2=80=AFPM Tudor Ambarus <tudor.ambarus@linaro.=
org> wrote:
> On 2/9/24 16:21, Conor Dooley wrote:
> > On Fri, Feb 09, 2024 at 01:56:56PM +0000, Tudor Ambarus wrote:
> >> On 2/8/24 18:24, Conor Dooley wrote:
> >>> On Thu, Feb 08, 2024 at 01:50:34PM +0000, Tudor Ambarus wrote:
> >>>> There are instances of the same IP that are configured by the integr=
ator
> >>>> with different FIFO depths. Introduce the fifo-depth property to all=
ow
> >>>> such nodes to specify their FIFO depth.
> >>>>
> >>>> We haven't seen SPI IPs with different FIFO depths for RX and TX, th=
us
> >>>> introduce a single property.
> >>>
> >>> Some citation attached to this would be nice. "We haven't seen" offer=
s
> >>> no detail as to what IPs that allow this sort of configuration of FIF=
O
> >>> size that you have actually checked.
> >>>
> >>> I went and checked our IP that we use in FPGA fabric, which has a
> >>> configurable fifo depth. It only has a single knob for both RX and TX
> >>> FIFOs. The Xilinx xps spi core also has configurable FIFOs, but again=
 RX
> >>> and TX sizes are tied there. At least that's a sample size of three.
> >>>
> >>> One of our guys is working on support for the IP I just mentioned and
> >>> would be defining a vendor property for this, so
> >>> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> >>>
> >>
> >> Thanks, Conor. I had in mind that SPI has a shift register and it's
> >> improbable to have different FIFO depths for RX and TX.
> >
> > IDK, but I've learned to expect the unexpectable, especially when it
> > comes to the IPs intended for use in FPGAs.
> >
> >> At least I don't
> >> see how it would work, I guess it will use the minimum depth between t=
he
> >> two?
> >
> > I'm not really sure how it would work other than that in the general
> > case, but some use case specific configuration could work, but I do
> > agree that it is
> >
> >> I grepped by "fifo" in the spi bindings and I now see that renesas is
> >> using dedicated properties for RX and TX, but I think that there too t=
he
> >> FIFOs have the same depths. Looking into drivers/spi/spi-sh-msiof.c I
> >> see that the of_device_id.data contains 64 bytes FIFOs for RX and TX,
> >> regardless of the compatible.
> >>
> >> Geert, any idea if the FIFO depths can differ for RX and TX in
> >> spi-sh-msiof.c?

See my other email
https://lore.kernel.org/all/CAMuHMdU_Hx9PLmHf2Xm1KKTy_OF-TeCv7SzmA5CZWz+PLk=
bAGA@mail.gmail.com

Note that at one point we did have 64/256 in the driver, but that was
changed in commit fe78d0b7691c0274 ("spi: sh-msiof: Fix FIFO size to
64 word from 256 word").  Diving into the discussion around that patch,
there seem to be two factors at play:
  1. Actual FIFO size,
  2. Maximum transfer size per block
     (up to 2 blocks on R-Car, up to 4 blocks on SH(-Mobile)).
As the driver supports only a single block, it should be limited to
64 on R-Car Gen2/3.  R-Car Gen4 claims to have widened the register
bit field for the maximum transfer size per block, so 256 might be
possible there...

> >> Anyway, even if there are such imbalanced architectures, I guess we ca=
n
> >> consider them when/if they appear? (add rx/tx-fifo-depth dt properties=
)
> >
> > I think so.
> >
> >> Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml:
> >> Override the default TX fifo size.  Unit is words.  Ignored if 0.
> >> Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml:
> >> renesas,rx-fifo-size:
> >> Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml:
> >> Override the default RX fifo size.  Unit is words.  Ignored if 0.
> >
> > These renesas ones seemed interesting at first glance due to these
> > comments, but what's missed by grep the is "deprecated" marking on
> > these. They seem to have been replaced by soc-specific compatibles.
>
> In the driver the renesas,{rx,tx}-fifo-size properties still have the
> highest priority:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git/tree/driv=
ers/spi/spi-sh-msiof.c#n1350
>
> Maybe something for Geert, as I see he was the one marking these
> properties as deprecated. I guess he forgot to update the driver.
>
> Anyway, I think we shall be fine, even if we don't hear from Geert.

The renesas,{rx,tx}-fifo-size properties date back to the early days
of DT an ARM, when it was assumed that slightly different versions of
IP cores could be handled well using a single common compatible value,
and properties describing the (few) differences.  The pitfall here
is the "few differences": too many times people discovered later that
there were more differences, needing more properties, and complicating
backwards-compatibility.

Hence the handling of different FIFO sizes was moved to the driver based
on compatible values, and the renesas,{rx,tx}-fifo-size properties were
deprecated.  See commit beb74bb0875579c4 ("spi: sh-msiof: Add support
for R-Car H2 and M2"), which shows that there were more changes
needed than the anticipated FIFO sizes.  And more were added later,
see later additions to sh_msiof_chipdata.

So unless it is meant for a configurable synthesizable IP core, where
this is a documented parameter of the IP core, I advise against
specifying the FIFO size(s) in DT.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

