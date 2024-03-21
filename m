Return-Path: <linux-kernel+bounces-109901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5959E885786
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 11:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CD1B1C212A0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 10:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249E856B9C;
	Thu, 21 Mar 2024 10:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="K3t5ZWtC";
	dkim=permerror (0-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="+e7g0v1C"
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3E91F95F;
	Thu, 21 Mar 2024 10:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711017388; cv=pass; b=hZuH1mSMCeLZJS3xIhxlAMVv7P36l7s+AF397uUKJ9ZiCUMs+Ed81UoQo3FKiogGSpNNAYEmYjwtv9g/w0fKUwrZKMhywd0FZUatNBq6DkfLXL9Xzqs2px1kJZgEv/PZJFP9lEAf5aXrgezHDVt307Fem8ha8I4E+c1LxoZ2SeY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711017388; c=relaxed/simple;
	bh=keOTLKSvGVTnxO535H7WRDCiQwKKw1Cq8HM/wptw0JU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=anp8Js4Ma21xJgV85GWP23jKAZsVVvZz+nrisuuiy7iShbDQvney57ZT+FacYMxDDukGX/cwG6dBafAI8nGiI1/MfFIJfL/eVBOZzkU10gFIJercZ7yooOUp4M4F7SqiIaH7qD6vSKGHPrDe201cZn2bFM6WrJCeZa93ZKh/2JA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gerhold.net; spf=none smtp.mailfrom=gerhold.net; dkim=pass (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b=K3t5ZWtC; dkim=permerror (0-bit key) header.d=gerhold.net header.i=@gerhold.net header.b=+e7g0v1C; arc=pass smtp.client-ip=85.215.255.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gerhold.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=gerhold.net
ARC-Seal: i=1; a=rsa-sha256; t=1711017188; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=DXKhN+xfEdG/cxqwZMULNXkEsOdylpq94I+bDRP8XzbQ26ipSijuoOtFnUJ2kWRl7W
    62Qg28GxK4e4rdJefyKOZpAGQBeI663Vq+0FUOVEytMPRCgaYkEkBMHpg3orIMZPq46T
    pVfWR9hLnHqD8Ln/pp6MYSgAr///naDd9+0sqmSU0IcrgMgB8dsNYsS9e/GgfORRVPv+
    uT5nvsa7RzSWkplrIbqvEK2QLaxxxqEfq486hYCOOfjmc5qDH21wA7YXHxMYI4RgmqA0
    XZGflaLf1y5REtxwRmNGsDIHICEDyF8us+SK62jkqbISHkx3r62DI3U/VngLQyl5VSIS
    cx6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1711017188;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=z809RpZKOW22WdAtDimpaaHa/lNRu8AEnLDvd+n+93A=;
    b=HBFB5djMMMhRMP3bV1rmeLlgfN0nOBUkBq44Icl/DBqB3n7bi69fiXhJtvPMKpyEqi
    vFsWyOljFjXCLjnfn/P17ECGuwdlcT9KuKj4YKpPhbAyAjz+d2B/3Tf8FDZwsWd9hsLr
    +wJadxvADPKjgazb2pqUuFHrpY40VwRYT6YMrYYxFCE/16mJG2PR1juYlPwgHj4pYirG
    rTjRB5MvlbVDnWmgyZI7vu3Te5I2F+JAwjqNKaMer86H70GD3PTxre6QwRx5BBSbU6qf
    skpbUHqjLI6MsmJOe3oqtD3c6yTd98UECDvha7GPQNjHAdcs2EjpovE8Av1pJ78kUz3f
    Lv4w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1711017188;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=z809RpZKOW22WdAtDimpaaHa/lNRu8AEnLDvd+n+93A=;
    b=K3t5ZWtCQjbRHSlsmF4EbJk+/p+Fd6b8HM9dbphoLTgyE0LzWBkdNZvCQmxt4FT6ve
    9K+0TTlZLZMlcmhFkqWEQBbYlTmHMtladjT8pcJEhvwpApuSD/m9lKckmrlYxlJSmb7V
    gBq1c/0HjxQ4n0SAo2uxd3Hs7qMru66s1g9+u/PgALxOq7PUVoz3So2fNQ2n87X4vL2C
    FISG9RBfJYJznkH9rSnzqOlbLbWacNrAN7k0aRXhaBeWXQWMYnJagZ3RDlKeNGpmMcqz
    hqd8G6ZtLF7aCruwTxgbb3HNmtQ5puS3JXrMb8cL39+TPv9oH+xBd6P8JQUUI9j7aeBD
    2xOQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1711017188;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=z809RpZKOW22WdAtDimpaaHa/lNRu8AEnLDvd+n+93A=;
    b=+e7g0v1CkvmAX7KdGnIUk3oKbcSztVpH1c8bHFylHgDQ8YyDM0CTbSgKwpeQuc1du/
    wWX9VWTIcg5ML3JjgaDg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4peA9Zfh"
Received: from gerhold.net
    by smtp.strato.de (RZmta 50.3.1 SBL|AUTH)
    with ESMTPSA id R475ba02LAX8793
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 21 Mar 2024 11:33:08 +0100 (CET)
Date: Thu, 21 Mar 2024 11:33:01 +0100
From: Stephan Gerhold <stephan@gerhold.net>
To: Sumit Garg <sumit.garg@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	caleb.connolly@linaro.org, neil.armstrong@linaro.org,
	dmitry.baryshkov@linaro.org, laetitia.mariottini@se.com,
	pascal.eberhard@se.com, abdou.saker@se.com, jimmy.lalande@se.com,
	benjamin.missey@non.se.com, daniel.thompson@linaro.org,
	linux-kernel@vger.kernel.org,
	Jagdish Gediya <jagdish.gediya@linaro.org>
Subject: Re: [PATCH v3 3/3] arm64: dts: qcom: apq8016: Add Schneider HMIBSC
 board DTS
Message-ID: <ZfwM3ZrjTWR_QANd@gerhold.net>
References: <20240315060707.471248-1-sumit.garg@linaro.org>
 <20240315060707.471248-4-sumit.garg@linaro.org>
 <ZfRlYnEQUKvwGQ65@gerhold.net>
 <CAFA6WYMucNzLNm+oHNd-Jb65oigpNphU=mFGM1cD8A-mK-BFDw@mail.gmail.com>
 <ZfmdWtoiP4ZF7JRk@gerhold.net>
 <CAFA6WYPzdSHEMmeb_J6LPje8MUkSSq93oN3+O1PMahtZN7hWnA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFA6WYPzdSHEMmeb_J6LPje8MUkSSq93oN3+O1PMahtZN7hWnA@mail.gmail.com>
Content-Transfer-Encoding: 7bit

On Wed, Mar 20, 2024 at 12:10:32PM +0530, Sumit Garg wrote:
> On Tue, 19 Mar 2024 at 19:43, Stephan Gerhold <stephan@gerhold.net> wrote:
> > On Mon, Mar 18, 2024 at 03:20:46PM +0530, Sumit Garg wrote:
> > > On Fri, 15 Mar 2024 at 20:43, Stephan Gerhold <stephan@gerhold.net> wrote:
> > > > On Fri, Mar 15, 2024 at 11:37:07AM +0530, Sumit Garg wrote:
> > > > > Add Schneider Electric HMIBSC board DTS. The HMIBSC board is an IIoT Edge
> > > > > Box Core board based on the Qualcomm APQ8016E SoC.
> > > > >
> > > > > Support for Schneider Electric HMIBSC. Features:
> > > > > - Qualcomm Snapdragon 410C SoC - APQ8016 (4xCortex A53, Adreno 306)
> > > > > - 1GiB RAM
> > > > > - 8GiB eMMC, SD slot
> > > > > - WiFi and Bluetooth
> > > > > - 2x Host, 1x Device USB port
> > > > > - HDMI
> > > > > - Discrete TPM2 chip over SPI
> > > > > - USB ethernet adaptors (soldered)
> > > > >
> > > > > Co-developed-by: Jagdish Gediya <jagdish.gediya@linaro.org>
> > > > > Signed-off-by: Jagdish Gediya <jagdish.gediya@linaro.org>
> > > > > Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
> > > > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > > > ---
> > > > >  arch/arm64/boot/dts/qcom/Makefile             |   1 +
> > > > >  .../dts/qcom/apq8016-schneider-hmibsc.dts     | 510 ++++++++++++++++++
> > > > >  2 files changed, 511 insertions(+)
> > > > >  create mode 100644 arch/arm64/boot/dts/qcom/apq8016-schneider-hmibsc.dts
> > > > >
> > > > > diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> > > > > index 39889d5f8e12..ad55e52e950b 100644
> > > > > --- a/arch/arm64/boot/dts/qcom/Makefile
> > > > > +++ b/arch/arm64/boot/dts/qcom/Makefile
> > > > > @@ -5,6 +5,7 @@ apq8016-sbc-usb-host-dtbs     := apq8016-sbc.dtb apq8016-sbc-usb-host.dtbo
> > > > >
> > > > >  dtb-$(CONFIG_ARCH_QCOM)      += apq8016-sbc-usb-host.dtb
> > > > >  dtb-$(CONFIG_ARCH_QCOM)      += apq8016-sbc-d3-camera-mezzanine.dtb
> > > > > +dtb-$(CONFIG_ARCH_QCOM)      += apq8016-schneider-hmibsc.dtb
> > > > >  dtb-$(CONFIG_ARCH_QCOM)      += apq8039-t2.dtb
> > > > >  dtb-$(CONFIG_ARCH_QCOM)      += apq8094-sony-xperia-kitakami-karin_windy.dtb
> > > > >  dtb-$(CONFIG_ARCH_QCOM)      += apq8096-db820c.dtb
> > > > > diff --git a/arch/arm64/boot/dts/qcom/apq8016-schneider-hmibsc.dts b/arch/arm64/boot/dts/qcom/apq8016-schneider-hmibsc.dts
> > > > > new file mode 100644
> > > > > index 000000000000..9c79a31a04db
> > > > > --- /dev/null
> > > > > +++ b/arch/arm64/boot/dts/qcom/apq8016-schneider-hmibsc.dts
> > > > > @@ -0,0 +1,510 @@
> > > > > [...]
> > > > > +
> > > > > +&pm8916_resin {
> > > > > +     interrupts = <0x0 0x8 1 IRQ_TYPE_EDGE_FALLING>;
> > > > > +     linux,code = <KEY_POWER>;
> > > > > +     status = "okay";
> > > > > +};
> > > >
> > > > What is the goal of overriding the interrupt here? It looks like you are
> > > > changing the interrupt type from IRQ_TYPE_EDGE_BOTH to FALLING. This
> > > > sounds a bit like you want the driver to receive just button release
> > > > events (or just press events, not sure about the polarity). I'm not sure
> > > > if the driver will handle this correctly.
> > >
> > > The use-case here is to just act upon button release events and the
> > > driver handles this appropriately. Final use-case of the reset button:
> > >
> > > - Short press and release leads to normal Linux reboot.
> > > - Long press for more than 10 sec or so leads to a hard reset.
> > >
> > > With IRQ_TYPE_EDGE_BOTH, that's not achievable because just a simple
> > > press leads to Linux reboot.
> > >
> >
> > Thanks for explaining your use case. Is the DT really the right place to
> > describe this? In the hardware, this is just a button that provides both
> > press and release events. Linux typically forwards these events to user
> > space, without interpreting them in any way. This means you likely have
> > some user space component that listens to the events (e.g. systemd
> > logind). Ideally that component should be reconfigured to trigger the
> > reboot on release instead of press.
> 
> I am not sure if that's really the case. I only see power key value to
> be reported as follows:
> 
> input_report_key(pwrkey->input, pwrkey->code, 1);
>                     or
> input_report_key(pwrkey->input, pwrkey->code, 0);
> 
> It's not like a press event being a rising edge (0->1) or a release
> event being a falling edge (1->0) reported. AFAICS, a reboot is issued
> whenever the value of power key is reported as "1".
> 

If you look inside the input_report_key() function you can see that the
input subsystem internally tracks the key state. input_get_disposition()
returns INPUT_IGNORE_EVENT if the key bit already has the same value.
Only when the key changes its state, an event is sent to user space.
This means that all events reported to user space are effectively
rising/falling edges (an event with value "1" is a rising edge 0->1, an
event with value "0" is a falling edge 1->0).

The only reason why setting IRQ_TYPE_EDGE_FALLING works here is because
of the workaround added in commit be8fc023ef64 ("Input: pm8941-pwrkey -
simulate missed key press events") [1]. No event is reported when you
start pressing the key. When you release the key, you get a key press
event (rising edge) immediately followed by a key release (falling
edge). But the workaround was added to handle potentially missed
interrupts, not to inhibit reporting key press events.

In my opinion, if you want to perform an action on key release rather
than key press then you should adjust the user space program to do so.
From the point of view of the hardware DT (and even the kernel), the key
press happens when you actually start pressing the key, and not later
when you release it.

Thanks,
Stephan

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=be8fc023ef64dcb11042aaa4bb0f29f7e0335d85

