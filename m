Return-Path: <linux-kernel+bounces-107628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF8D87FF5A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 15:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F1D51F228B0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 14:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC4981754;
	Tue, 19 Mar 2024 14:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="H3zU5Ib1";
	dkim=permerror (0-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="qERMqygQ"
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69F481721;
	Tue, 19 Mar 2024 14:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.164
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710857594; cv=pass; b=F3dMPSkPF9choC3kLQltI7i4tG3s4pXWSXlMx0pcKVSouvi9Ydjq4W2dtkGu3vydDZtg3TfSeF1tZ8vwIU+VuhbvMqcSGf+I9tL0aKrWRa7x49/B2NcJOFFRNi9mtxNwgiUKU6YbrcdWUIQXIZImzx21Rud3EirzT8cLedeHep4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710857594; c=relaxed/simple;
	bh=6aCWbrDbRYmEYuxM00BPHK+S1MuilKFJ1QlbUTNPGZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ua0sGPgCWUI9mnCSlWDXdKGuSKics8nf/CABOLsaiTG5IRoXuS4YKsvmLPli+Bf0rUBKI9+/7KJnL7yTr1iR2sQHvcfqBKpoLIAafp5lajDulhfATgA3rkn1eSgcR9bC6bBZ47ySUyOqWbYNmSF74TD9/T6G7w6yzoJ8LD89JmU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gerhold.net; spf=none smtp.mailfrom=gerhold.net; dkim=pass (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b=H3zU5Ib1; dkim=permerror (0-bit key) header.d=gerhold.net header.i=@gerhold.net header.b=qERMqygQ; arc=pass smtp.client-ip=81.169.146.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gerhold.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=gerhold.net
ARC-Seal: i=1; a=rsa-sha256; t=1710857570; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Il3Vil8NTv2dc7zUgfhmuNShS31UiREIMfiltitCFfHOk0qaSgr6rjTXV9cGtCkAT1
    sHxuBK1b2h4vZuGF6yAEUadl4aqsFGCIExNaheFGhSlhFzsSdWGt7BO0xjCyz9lRbcRO
    N/ezL/s5/jyR5ZSFFaHmLnpmcJIoGyCtxD25Bz6KQMngkXt9gIWiPuQCzlL6dLBuLBX1
    TD7py+jrsbCnd8NIfHX3LBLHDiFD+Sew6PvbDnjj2GSFAPvBFvUKkc/cLMFQaJ8IlOAz
    jIR2gYgwYWc2JmMGnYmXQxoVtFbxn2hp5675bjOsMxcGTxvRvzoTa//GmUjLO0VO+Wxa
    DTuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1710857570;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=DYa+8d2UWYgwRzURH7RQQ2juMt5EiPhLxQIXRjk018c=;
    b=jDBvRhSRo1iznY9fpd3EA5YH32a+u9TTw8EqU+qzSCxyxaan71KpS9CFxOhX2wBJHu
    XrsNiCVzmo+c8ycxfyf21GKkANav1Te4dH89/8OXVPGQzbLMjmCcWvkmhWXBhV1rrPxU
    lbUvlvcItDPTrg1xwoo1OkRz6+VFZaDKH89fPBsT66k8vQCCC9iDR/5+xyIJP7f/juVn
    xABIt88WogBPRAtc/4GM5PFdj84VeKcUPMhEE9V4fvfagVnhswAO7tzmdftHtCROnQQA
    eIV6gLGM4MnI8/vkGMCv9lbbu8PUrAX6/509X7TKWdTzt/rpoazHhp2pguWiAsUAIdzP
    CVzA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1710857570;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=DYa+8d2UWYgwRzURH7RQQ2juMt5EiPhLxQIXRjk018c=;
    b=H3zU5Ib1Xwft4x9CsITafUB/hXpM8QyleUZWpjLO+TL0LvBY1vyfEbQGH/zXa+J29S
    yRD1xGtoBDrt1Ie/YED0TQx3rCDBtio2nltT9fVOkq1sO4fJ4vH4o/rHf0ATlb4ObJ+m
    n7U8DLtZbJsuEnZFM4fBS69Imk5DRxZ0Hids6S74x/Is6/QpG5p6xv+qos6TB+iCWHJj
    9RGHXxjMbIyVLo/c7NT/i8u5n6s1HLWGRISCwYNfhy9aYKU3PHBT7D727idN0vQ8hMH/
    T8lCN1qKdLJk6ZSIDBa0C3WvMVwx2GVldaaSz7cjRsbCiU7bFvCZjv3guwu2MRBsI66J
    1rmQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1710857570;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=DYa+8d2UWYgwRzURH7RQQ2juMt5EiPhLxQIXRjk018c=;
    b=qERMqygQkvRJLWmJr6bw5nmZ7b76M8SGfHK1T6/gRyCeUVdiVXyv10/iWb6/mmPorH
    dchaqanpdBvkI2rlOOBg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4peA8paF1A=="
Received: from gerhold.net
    by smtp.strato.de (RZmta 50.3.1 DYNA|AUTH)
    with ESMTPSA id R475ba02JECn06O
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 19 Mar 2024 15:12:49 +0100 (CET)
Date: Tue, 19 Mar 2024 15:12:42 +0100
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
Message-ID: <ZfmdWtoiP4ZF7JRk@gerhold.net>
References: <20240315060707.471248-1-sumit.garg@linaro.org>
 <20240315060707.471248-4-sumit.garg@linaro.org>
 <ZfRlYnEQUKvwGQ65@gerhold.net>
 <CAFA6WYMucNzLNm+oHNd-Jb65oigpNphU=mFGM1cD8A-mK-BFDw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFA6WYMucNzLNm+oHNd-Jb65oigpNphU=mFGM1cD8A-mK-BFDw@mail.gmail.com>
Content-Transfer-Encoding: 7bit

On Mon, Mar 18, 2024 at 03:20:46PM +0530, Sumit Garg wrote:
> On Fri, 15 Mar 2024 at 20:43, Stephan Gerhold <stephan@gerhold.net> wrote:
> > On Fri, Mar 15, 2024 at 11:37:07AM +0530, Sumit Garg wrote:
> > > Add Schneider Electric HMIBSC board DTS. The HMIBSC board is an IIoT Edge
> > > Box Core board based on the Qualcomm APQ8016E SoC.
> > >
> > > Support for Schneider Electric HMIBSC. Features:
> > > - Qualcomm Snapdragon 410C SoC - APQ8016 (4xCortex A53, Adreno 306)
> > > - 1GiB RAM
> > > - 8GiB eMMC, SD slot
> > > - WiFi and Bluetooth
> > > - 2x Host, 1x Device USB port
> > > - HDMI
> > > - Discrete TPM2 chip over SPI
> > > - USB ethernet adaptors (soldered)
> > >
> > > Co-developed-by: Jagdish Gediya <jagdish.gediya@linaro.org>
> > > Signed-off-by: Jagdish Gediya <jagdish.gediya@linaro.org>
> > > Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
> > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > ---
> > >  arch/arm64/boot/dts/qcom/Makefile             |   1 +
> > >  .../dts/qcom/apq8016-schneider-hmibsc.dts     | 510 ++++++++++++++++++
> > >  2 files changed, 511 insertions(+)
> > >  create mode 100644 arch/arm64/boot/dts/qcom/apq8016-schneider-hmibsc.dts
> > >
> > > diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> > > index 39889d5f8e12..ad55e52e950b 100644
> > > --- a/arch/arm64/boot/dts/qcom/Makefile
> > > +++ b/arch/arm64/boot/dts/qcom/Makefile
> > > @@ -5,6 +5,7 @@ apq8016-sbc-usb-host-dtbs     := apq8016-sbc.dtb apq8016-sbc-usb-host.dtbo
> > >
> > >  dtb-$(CONFIG_ARCH_QCOM)      += apq8016-sbc-usb-host.dtb
> > >  dtb-$(CONFIG_ARCH_QCOM)      += apq8016-sbc-d3-camera-mezzanine.dtb
> > > +dtb-$(CONFIG_ARCH_QCOM)      += apq8016-schneider-hmibsc.dtb
> > >  dtb-$(CONFIG_ARCH_QCOM)      += apq8039-t2.dtb
> > >  dtb-$(CONFIG_ARCH_QCOM)      += apq8094-sony-xperia-kitakami-karin_windy.dtb
> > >  dtb-$(CONFIG_ARCH_QCOM)      += apq8096-db820c.dtb
> > > diff --git a/arch/arm64/boot/dts/qcom/apq8016-schneider-hmibsc.dts b/arch/arm64/boot/dts/qcom/apq8016-schneider-hmibsc.dts
> > > new file mode 100644
> > > index 000000000000..9c79a31a04db
> > > --- /dev/null
> > > +++ b/arch/arm64/boot/dts/qcom/apq8016-schneider-hmibsc.dts
> > > @@ -0,0 +1,510 @@
> > > [...]
> > > +
> > > +&pm8916_resin {
> > > +     interrupts = <0x0 0x8 1 IRQ_TYPE_EDGE_FALLING>;
> > > +     linux,code = <KEY_POWER>;
> > > +     status = "okay";
> > > +};
> >
> > What is the goal of overriding the interrupt here? It looks like you are
> > changing the interrupt type from IRQ_TYPE_EDGE_BOTH to FALLING. This
> > sounds a bit like you want the driver to receive just button release
> > events (or just press events, not sure about the polarity). I'm not sure
> > if the driver will handle this correctly.
> 
> The use-case here is to just act upon button release events and the
> driver handles this appropriately. Final use-case of the reset button:
> 
> - Short press and release leads to normal Linux reboot.
> - Long press for more than 10 sec or so leads to a hard reset.
> 
> With IRQ_TYPE_EDGE_BOTH, that's not achievable because just a simple
> press leads to Linux reboot.
> 

Thanks for explaining your use case. Is the DT really the right place to
describe this? In the hardware, this is just a button that provides both
press and release events. Linux typically forwards these events to user
space, without interpreting them in any way. This means you likely have
some user space component that listens to the events (e.g. systemd
logind). Ideally that component should be reconfigured to trigger the
reboot on release instead of press.

If you hardcode this behavior in the DT you are essentially describing
that the hardware is incapable of detecting the press event before the
release event. This is not the case, right? There may be use cases where
someone would still want to detect the key press (rather than just
release).

Thanks,
Stephan

