Return-Path: <linux-kernel+bounces-110990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6D38866BC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 07:30:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43FA91C21D58
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 06:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39DFDA947;
	Fri, 22 Mar 2024 06:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="stf+/S8z"
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512E2FBFD
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 06:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711089009; cv=none; b=sTnKSKGSaEUwuFnPUaVHGHEyZsRp4N9jErkxHs+Db9jfAloTZMNLWs6yQM7IyYm32wyILnx6Y+K8eT+iuwNmK5TkGSuUVgNuVccA6mSildz3FPNkC28vJczz3Wol8Xu7v0Supanqm77+SrQffJ9ho1VLzwAf56LCsipwAKwBQfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711089009; c=relaxed/simple;
	bh=RaLGXV3wkG8D6RtEzkqlYsPr48/oVFW/MpPxaPCCmkk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iblmLk9f2n2YOlnpsCGC9cOSvrM54Nwncq1TOc6YRb5uo1UgGwDuB8O48Cow01n72e5R3pdmPVCK/QSnwwlIl/HhvvHwRWbjQC8EyIIS1okgqVPBlCKTCJEOBdK/XWXDG/YwBT+nxnMMV3/dPK7RCDhc4vat4+K1v2O+Z+L/q5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=stf+/S8z; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-7e083af7ceaso663084241.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 23:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711089006; x=1711693806; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=friF4mqOpL+RBrI/R2ofg6E/u5m4j7bkXfIK/7gVkkA=;
        b=stf+/S8zs96LGMGDQqSboY1KerMZnnbVepOJjCFdryUDNZKrPAWnIcDXDyMcG04vWR
         BW0TXkqyPNppDR+tTTQPOwbmLIW05GDQbZzz0CaPndrDGvh7tDaErrh0edIzK63qQOOb
         qMfEpLDkd8SR7ncBNG6bN8TkEtRERzd4j/vRLJq8XLKzXZQt8z9E5uecpMABp9/Z1CMJ
         jLXY37c2Si9KOOOdbnyRV/Z5Cyw+larnRWo/wHZ7R5MssApdakTHS1DakhuSRUmGkD6h
         cun+EylIqK9ajPe8SWc+8u30p8xszVPJmMhSUa+80yqJ+dX54WgPrHnWLbMhLOSHyHcs
         8GkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711089006; x=1711693806;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=friF4mqOpL+RBrI/R2ofg6E/u5m4j7bkXfIK/7gVkkA=;
        b=El59UsRUXmia5994eiC5m5BRBNse4KAy3lFBUXhTWxRMk5sA0l5X6xRbQ/VCY0hB9V
         Rj06dH3vdAud97VsGPWbJ3DHnm64xOBjONJa2cis/SEgUcZvueV0Dmg6ojn9KOZg/s9f
         1L6IIocsS/t4Llbx1DpNK+YsTV+jP3LOfKL9kG2epP/0cdA8l5qBtfK1W07REnPGcQUW
         altYZfRw0VL1dlZ8D9uVWdHj2JwXMoKSo7G8rNZhNfQdXknQZ/jqvTUG+0bQZ2A91vKc
         v1ZjxLPxdIVEyuMyH98ViuhOqChjElfDXsk/wzHIYqpo8bbzI3o7nC6RyYQMkP5r9EWF
         DOSg==
X-Forwarded-Encrypted: i=1; AJvYcCWS0YsbNROsE2forFq4j8OC3l2EVyCUc17uWZl6gbP9FsUT3E/SjfBkv+gi0+9sqKcbzScZyDJWNbFYANRjTWjz7w1eDdRmumrWgadD
X-Gm-Message-State: AOJu0Ywix70cYk73ZX9te/UmtSPvA1cgfSEC6djOxwxZYP3G5nEPuIvS
	fuuEoi7FAp4FcewOxf6yHpcOCaLQkYrhe/h20LKQI2KrMfBCSjggHcwylhSOtnuHLpCitdE2qNT
	4Oxgzwd9bUoOtD0i2P0mC8+IypIty1g8dlxLOWw==
X-Google-Smtp-Source: AGHT+IFQbB1B4AoNXkHKSgOqNqZlxMtMbvTbOTZhu1rm2Mw16zgjYGcqyrLEXEkNf5ApfjNO9O5cs8chrkwQfUwFz8E=
X-Received: by 2002:a67:f2c1:0:b0:476:b180:5cf0 with SMTP id
 a1-20020a67f2c1000000b00476b1805cf0mr1601671vsn.34.1711089006234; Thu, 21 Mar
 2024 23:30:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240315060707.471248-1-sumit.garg@linaro.org>
 <20240315060707.471248-4-sumit.garg@linaro.org> <ZfRlYnEQUKvwGQ65@gerhold.net>
 <CAFA6WYMucNzLNm+oHNd-Jb65oigpNphU=mFGM1cD8A-mK-BFDw@mail.gmail.com>
 <ZfmdWtoiP4ZF7JRk@gerhold.net> <CAFA6WYPzdSHEMmeb_J6LPje8MUkSSq93oN3+O1PMahtZN7hWnA@mail.gmail.com>
 <ZfwM3ZrjTWR_QANd@gerhold.net>
In-Reply-To: <ZfwM3ZrjTWR_QANd@gerhold.net>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Fri, 22 Mar 2024 11:59:54 +0530
Message-ID: <CAFA6WYN+Y8qyv9yEMoU1wqpqDN7rwNO5xfHkSUe+H2DdSiBqyA@mail.gmail.com>
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

On Thu, 21 Mar 2024 at 16:03, Stephan Gerhold <stephan@gerhold.net> wrote:
>
> On Wed, Mar 20, 2024 at 12:10:32PM +0530, Sumit Garg wrote:
> > On Tue, 19 Mar 2024 at 19:43, Stephan Gerhold <stephan@gerhold.net> wrote:
> > > On Mon, Mar 18, 2024 at 03:20:46PM +0530, Sumit Garg wrote:
> > > > On Fri, 15 Mar 2024 at 20:43, Stephan Gerhold <stephan@gerhold.net> wrote:
> > > > > On Fri, Mar 15, 2024 at 11:37:07AM +0530, Sumit Garg wrote:
> > > > > > Add Schneider Electric HMIBSC board DTS. The HMIBSC board is an IIoT Edge
> > > > > > Box Core board based on the Qualcomm APQ8016E SoC.
> > > > > >
> > > > > > Support for Schneider Electric HMIBSC. Features:
> > > > > > - Qualcomm Snapdragon 410C SoC - APQ8016 (4xCortex A53, Adreno 306)
> > > > > > - 1GiB RAM
> > > > > > - 8GiB eMMC, SD slot
> > > > > > - WiFi and Bluetooth
> > > > > > - 2x Host, 1x Device USB port
> > > > > > - HDMI
> > > > > > - Discrete TPM2 chip over SPI
> > > > > > - USB ethernet adaptors (soldered)
> > > > > >
> > > > > > Co-developed-by: Jagdish Gediya <jagdish.gediya@linaro.org>
> > > > > > Signed-off-by: Jagdish Gediya <jagdish.gediya@linaro.org>
> > > > > > Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
> > > > > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > > > > ---
> > > > > >  arch/arm64/boot/dts/qcom/Makefile             |   1 +
> > > > > >  .../dts/qcom/apq8016-schneider-hmibsc.dts     | 510 ++++++++++++++++++
> > > > > >  2 files changed, 511 insertions(+)
> > > > > >  create mode 100644 arch/arm64/boot/dts/qcom/apq8016-schneider-hmibsc.dts
> > > > > >
> > > > > > diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> > > > > > index 39889d5f8e12..ad55e52e950b 100644
> > > > > > --- a/arch/arm64/boot/dts/qcom/Makefile
> > > > > > +++ b/arch/arm64/boot/dts/qcom/Makefile
> > > > > > @@ -5,6 +5,7 @@ apq8016-sbc-usb-host-dtbs     := apq8016-sbc.dtb apq8016-sbc-usb-host.dtbo
> > > > > >
> > > > > >  dtb-$(CONFIG_ARCH_QCOM)      += apq8016-sbc-usb-host.dtb
> > > > > >  dtb-$(CONFIG_ARCH_QCOM)      += apq8016-sbc-d3-camera-mezzanine.dtb
> > > > > > +dtb-$(CONFIG_ARCH_QCOM)      += apq8016-schneider-hmibsc.dtb
> > > > > >  dtb-$(CONFIG_ARCH_QCOM)      += apq8039-t2.dtb
> > > > > >  dtb-$(CONFIG_ARCH_QCOM)      += apq8094-sony-xperia-kitakami-karin_windy.dtb
> > > > > >  dtb-$(CONFIG_ARCH_QCOM)      += apq8096-db820c.dtb
> > > > > > diff --git a/arch/arm64/boot/dts/qcom/apq8016-schneider-hmibsc.dts b/arch/arm64/boot/dts/qcom/apq8016-schneider-hmibsc.dts
> > > > > > new file mode 100644
> > > > > > index 000000000000..9c79a31a04db
> > > > > > --- /dev/null
> > > > > > +++ b/arch/arm64/boot/dts/qcom/apq8016-schneider-hmibsc.dts
> > > > > > @@ -0,0 +1,510 @@
> > > > > > [...]
> > > > > > +
> > > > > > +&pm8916_resin {
> > > > > > +     interrupts = <0x0 0x8 1 IRQ_TYPE_EDGE_FALLING>;
> > > > > > +     linux,code = <KEY_POWER>;
> > > > > > +     status = "okay";
> > > > > > +};
> > > > >
> > > > > What is the goal of overriding the interrupt here? It looks like you are
> > > > > changing the interrupt type from IRQ_TYPE_EDGE_BOTH to FALLING. This
> > > > > sounds a bit like you want the driver to receive just button release
> > > > > events (or just press events, not sure about the polarity). I'm not sure
> > > > > if the driver will handle this correctly.
> > > >
> > > > The use-case here is to just act upon button release events and the
> > > > driver handles this appropriately. Final use-case of the reset button:
> > > >
> > > > - Short press and release leads to normal Linux reboot.
> > > > - Long press for more than 10 sec or so leads to a hard reset.
> > > >
> > > > With IRQ_TYPE_EDGE_BOTH, that's not achievable because just a simple
> > > > press leads to Linux reboot.
> > > >
> > >
> > > Thanks for explaining your use case. Is the DT really the right place to
> > > describe this? In the hardware, this is just a button that provides both
> > > press and release events. Linux typically forwards these events to user
> > > space, without interpreting them in any way. This means you likely have
> > > some user space component that listens to the events (e.g. systemd
> > > logind). Ideally that component should be reconfigured to trigger the
> > > reboot on release instead of press.
> >
> > I am not sure if that's really the case. I only see power key value to
> > be reported as follows:
> >
> > input_report_key(pwrkey->input, pwrkey->code, 1);
> >                     or
> > input_report_key(pwrkey->input, pwrkey->code, 0);
> >
> > It's not like a press event being a rising edge (0->1) or a release
> > event being a falling edge (1->0) reported. AFAICS, a reboot is issued
> > whenever the value of power key is reported as "1".
> >
>
> If you look inside the input_report_key() function you can see that the
> input subsystem internally tracks the key state. input_get_disposition()
> returns INPUT_IGNORE_EVENT if the key bit already has the same value.
> Only when the key changes its state, an event is sent to user space.
> This means that all events reported to user space are effectively
> rising/falling edges (an event with value "1" is a rising edge 0->1, an
> event with value "0" is a falling edge 1->0).
>
> The only reason why setting IRQ_TYPE_EDGE_FALLING works here is because
> of the workaround added in commit be8fc023ef64 ("Input: pm8941-pwrkey -
> simulate missed key press events") [1]. No event is reported when you
> start pressing the key. When you release the key, you get a key press
> event (rising edge) immediately followed by a key release (falling
> edge). But the workaround was added to handle potentially missed
> interrupts, not to inhibit reporting key press events.

I rather see it differently being actually allowing the current
use-case to support only the IRQ_TYPE_EDGE_FALLING. As per your
description above, a falling edge can only be an event for user-space
if we have:

input_report_key(pwrkey->input, pwrkey->code, 1);
input_report_key(pwrkey->input, pwrkey->code, 0);

rather than only

input_report_key(pwrkey->input, pwrkey->code, 0);

which won't trigger any event for user-space, right?

>
> In my opinion, if you want to perform an action on key release rather
> than key press then you should adjust the user space program to do so.
> From the point of view of the hardware DT (and even the kernel), the key
> press happens when you actually start pressing the key, and not later
> when you release it.

The reason why we are discussing it back and forth looks like due to
lack of clarity as to how HMIBSC board supports this button. The
common implementation as per db410c DTS is to have two buttons:

- One button is representing pwrkey(KEY_POWER) which is solely
consumed by the operating system to cleanly power off/restart the
db410c.
- Another button is representing pm8916_resin(KEY_VOLUMEDOWN) which
apart from normal volume down is also consumed by PMIC hardware to
perform a hard reset on a long press (if more than 10 sec.).

However, on HMIBSC board we only have a single power/reset button
which has to support the dual role of above two buttons on db410c:

Only one button as pm8916_resin(KEY_POWER), behaviour required:
- The rising edge (or button press) has to be only consumed by PMIC to
perform a hard reset of the HMIBSC board if pressed for more than 10
secs.
- The falling edge has to be consumed by the operating system to
cleanly reboot the HMIBSC board.

So what you are asking here is that the operating system has to be
notified of the rising edge of the button even if it has to just
ignore that without any action. Do you really think that would be
acceptable as a generic solution for systemd logind?

Also, why DT isn't the right place for correctly describing the
intended hardware behaviour? Or am I missing any DT policy which says
hardware has to be described the exact way it is rather than the
expected way for hardware to behave? BTW, If you want the hardware
behaviour to be properly commented then I can do that too.

-Sumit

>
> Thanks,
> Stephan
>
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=be8fc023ef64dcb11042aaa4bb0f29f7e0335d85

