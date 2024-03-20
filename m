Return-Path: <linux-kernel+bounces-108500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3602B880B5F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 07:40:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE7921F22CD0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 06:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810BB1802E;
	Wed, 20 Mar 2024 06:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aR53uP9t"
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B18A29
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 06:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710916847; cv=none; b=NskQUI/9hHz05Z0lf2+Yeso8s+l9XrU+t/U7MsV8A75BV9yXoteuH9fDuxOQlXR8X/SeFLIO0SHmK0pL3wmY4F/34UF882w/DBS48XiYFK5y6ddbgYhC4WWw9gjeBT486I9XrZiHKhT3UOnzqiOVocQnlZKMZqZql/jRR8vhTLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710916847; c=relaxed/simple;
	bh=AJGAFL1dvLEouhNUnRCXPQwOfqJbsFPG6bk43pGZGe4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fGUtDik4o1qoEFUmqBqAKsuownse67Nl6w1Pcw/BYb7Z74Ik97GcYSph4hxYsYqPFS0yBvR3q+EmVFDGaIW6b0UHrpDCXAF8HNpjVZOYPqrvl/gLul//NQLeecOoe+GYOIQMNINC0LXZkuYJdBNnh98dOCZqX0s1kB9ZiAAQzoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aR53uP9t; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-7e04e70c372so622150241.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 23:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710916844; x=1711521644; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kcOOr88hJiSNYgd+zKExyCz3TqPQIrclo94noA5vOy0=;
        b=aR53uP9t7tKGqfdj2ailUNKhw2r25vatffUjbLiDUqk1MU30gJMxgSzCOCW1jXU0rJ
         dIFPMxpCUPW+ZpFM7V6+iQFq+bgk4f51GDlbwLQn3RSzVoVCRyoEUI87F9FWwMuiW4sX
         uvUFYNRKEJWOfj6FlLi2+byOAoaINHbKBWtp/SMQ79F8QOwFbK3VOIblztgfklaVGCom
         eshlM/Ta95IkDUu0/PsY6Z4yj+7A23GJDrJBesSRKrgP/iTevOorEL6BC+WIkReFmv2V
         TKZdZD+ImRj3KjdYfZtkzoDP3q3infbJK5bZEpeZvDspkyJZcIvMHaNsjDO6WY0K06La
         xzLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710916844; x=1711521644;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kcOOr88hJiSNYgd+zKExyCz3TqPQIrclo94noA5vOy0=;
        b=dkmV2jYTPwA8pkP6+k+NjrTNMYX3U7uDPZ88JC4tBGsuVj8YILnGIeHp7VIfqsPOEX
         wkL2avmI878MNJMiXmFhAtT1GcCWvP7GHMmXe1QWXs2fMAjSeuamXACHeIzy5r7a6b+J
         InG8tkYl5Yzg2zywf5264ampf4Io50wyWSSWsl0U0ARA0g+I8/AR+K1bckalyrbMuFD6
         mOss5Kn/PA3N1OnY2ytjBjLKjH7fYmEszQ36VRuqJq3kCpyWtRnvEEWw3OfxvA5btePh
         oESaPzpDCEqrUND7K0xFJzrKb/UFtpfZxCG/G0k9cpagOthbvqjD6DYeV4Pov4cNPgsO
         muhA==
X-Forwarded-Encrypted: i=1; AJvYcCXucBQd11BuG3d0TXxp6YI1lbGwnwy4KeHxVEB9MhC+S+ZVFBVdonMdqpgodK5xGGlONckBf+rCqkRlcQ/Gd4jqm7NVQqvb6ZNEceN4
X-Gm-Message-State: AOJu0Yxu6kdveKhS5GA2vFRL5HJmb8mgXkb+jEn+LcB0kgh8CEKBH+ep
	8i82Hy5QVR4hatC+4hzuSnJf8WeuPJ6N5x23fld0IyB4RTQSk7zUKRWBkKmMbx1h77UTOeLs/ea
	7BleSd0eVXldW5rQm42Mxr+ruemBj8HzCf1nsyw==
X-Google-Smtp-Source: AGHT+IFqApbTY6DNgifrc1HfffBhZy3NbvPjVLiTV7SeZTya+2/ILdAElBWlEApNAhzCDtWGwWEVDPx9jkFx9IMZ9us=
X-Received: by 2002:a67:ffc4:0:b0:473:35b2:7530 with SMTP id
 w4-20020a67ffc4000000b0047335b27530mr1088871vsq.23.1710916843900; Tue, 19 Mar
 2024 23:40:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240315060707.471248-1-sumit.garg@linaro.org>
 <20240315060707.471248-4-sumit.garg@linaro.org> <ZfRlYnEQUKvwGQ65@gerhold.net>
 <CAFA6WYMucNzLNm+oHNd-Jb65oigpNphU=mFGM1cD8A-mK-BFDw@mail.gmail.com> <ZfmdWtoiP4ZF7JRk@gerhold.net>
In-Reply-To: <ZfmdWtoiP4ZF7JRk@gerhold.net>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 20 Mar 2024 12:10:32 +0530
Message-ID: <CAFA6WYPzdSHEMmeb_J6LPje8MUkSSq93oN3+O1PMahtZN7hWnA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] arm64: dts: qcom: apq8016: Add Schneider HMIBSC
 board DTS
To: Stephan Gerhold <stephan@gerhold.net>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	caleb.connolly@linaro.org, neil.armstrong@linaro.org, 
	dmitry.baryshkov@linaro.org, laetitia.mariottini@se.com, 
	pascal.eberhard@se.com, abdou.saker@se.com, jimmy.lalande@se.com, 
	benjamin.missey@non.se.com, daniel.thompson@linaro.org, 
	linux-kernel@vger.kernel.org, Jagdish Gediya <jagdish.gediya@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 19 Mar 2024 at 19:43, Stephan Gerhold <stephan@gerhold.net> wrote:
>
> On Mon, Mar 18, 2024 at 03:20:46PM +0530, Sumit Garg wrote:
> > On Fri, 15 Mar 2024 at 20:43, Stephan Gerhold <stephan@gerhold.net> wrote:
> > > On Fri, Mar 15, 2024 at 11:37:07AM +0530, Sumit Garg wrote:
> > > > Add Schneider Electric HMIBSC board DTS. The HMIBSC board is an IIoT Edge
> > > > Box Core board based on the Qualcomm APQ8016E SoC.
> > > >
> > > > Support for Schneider Electric HMIBSC. Features:
> > > > - Qualcomm Snapdragon 410C SoC - APQ8016 (4xCortex A53, Adreno 306)
> > > > - 1GiB RAM
> > > > - 8GiB eMMC, SD slot
> > > > - WiFi and Bluetooth
> > > > - 2x Host, 1x Device USB port
> > > > - HDMI
> > > > - Discrete TPM2 chip over SPI
> > > > - USB ethernet adaptors (soldered)
> > > >
> > > > Co-developed-by: Jagdish Gediya <jagdish.gediya@linaro.org>
> > > > Signed-off-by: Jagdish Gediya <jagdish.gediya@linaro.org>
> > > > Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
> > > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > > ---
> > > >  arch/arm64/boot/dts/qcom/Makefile             |   1 +
> > > >  .../dts/qcom/apq8016-schneider-hmibsc.dts     | 510 ++++++++++++++++++
> > > >  2 files changed, 511 insertions(+)
> > > >  create mode 100644 arch/arm64/boot/dts/qcom/apq8016-schneider-hmibsc.dts
> > > >
> > > > diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> > > > index 39889d5f8e12..ad55e52e950b 100644
> > > > --- a/arch/arm64/boot/dts/qcom/Makefile
> > > > +++ b/arch/arm64/boot/dts/qcom/Makefile
> > > > @@ -5,6 +5,7 @@ apq8016-sbc-usb-host-dtbs     := apq8016-sbc.dtb apq8016-sbc-usb-host.dtbo
> > > >
> > > >  dtb-$(CONFIG_ARCH_QCOM)      += apq8016-sbc-usb-host.dtb
> > > >  dtb-$(CONFIG_ARCH_QCOM)      += apq8016-sbc-d3-camera-mezzanine.dtb
> > > > +dtb-$(CONFIG_ARCH_QCOM)      += apq8016-schneider-hmibsc.dtb
> > > >  dtb-$(CONFIG_ARCH_QCOM)      += apq8039-t2.dtb
> > > >  dtb-$(CONFIG_ARCH_QCOM)      += apq8094-sony-xperia-kitakami-karin_windy.dtb
> > > >  dtb-$(CONFIG_ARCH_QCOM)      += apq8096-db820c.dtb
> > > > diff --git a/arch/arm64/boot/dts/qcom/apq8016-schneider-hmibsc.dts b/arch/arm64/boot/dts/qcom/apq8016-schneider-hmibsc.dts
> > > > new file mode 100644
> > > > index 000000000000..9c79a31a04db
> > > > --- /dev/null
> > > > +++ b/arch/arm64/boot/dts/qcom/apq8016-schneider-hmibsc.dts
> > > > @@ -0,0 +1,510 @@
> > > > [...]
> > > > +
> > > > +&pm8916_resin {
> > > > +     interrupts = <0x0 0x8 1 IRQ_TYPE_EDGE_FALLING>;
> > > > +     linux,code = <KEY_POWER>;
> > > > +     status = "okay";
> > > > +};
> > >
> > > What is the goal of overriding the interrupt here? It looks like you are
> > > changing the interrupt type from IRQ_TYPE_EDGE_BOTH to FALLING. This
> > > sounds a bit like you want the driver to receive just button release
> > > events (or just press events, not sure about the polarity). I'm not sure
> > > if the driver will handle this correctly.
> >
> > The use-case here is to just act upon button release events and the
> > driver handles this appropriately. Final use-case of the reset button:
> >
> > - Short press and release leads to normal Linux reboot.
> > - Long press for more than 10 sec or so leads to a hard reset.
> >
> > With IRQ_TYPE_EDGE_BOTH, that's not achievable because just a simple
> > press leads to Linux reboot.
> >
>
> Thanks for explaining your use case. Is the DT really the right place to
> describe this? In the hardware, this is just a button that provides both
> press and release events. Linux typically forwards these events to user
> space, without interpreting them in any way. This means you likely have
> some user space component that listens to the events (e.g. systemd
> logind). Ideally that component should be reconfigured to trigger the
> reboot on release instead of press.

I am not sure if that's really the case. I only see power key value to
be reported as follows:

input_report_key(pwrkey->input, pwrkey->code, 1);
                    or
input_report_key(pwrkey->input, pwrkey->code, 0);

It's not like a press event being a rising edge (0->1) or a release
event being a falling edge (1->0) reported. AFAICS, a reboot is issued
whenever the value of power key is reported as "1".

>
> If you hardcode this behavior in the DT you are essentially describing
> that the hardware is incapable of detecting the press event before the
> release event. This is not the case, right? There may be use cases where
> someone would still want to detect the key press (rather than just
> release).

As of now there isn't such a use-case for the HMIBSC board.

-Sumit

>
> Thanks,
> Stephan

