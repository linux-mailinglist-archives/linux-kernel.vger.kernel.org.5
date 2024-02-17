Return-Path: <linux-kernel+bounces-69936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9505485907F
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 16:26:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43D17282A45
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 15:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B037C6EB;
	Sat, 17 Feb 2024 15:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oDOBkAbt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDCC69DE6;
	Sat, 17 Feb 2024 15:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708183557; cv=none; b=ZIPu000IJEo170QBR4IFkklQZll7Fa2zvRhmIpB4rPHFD2lWdN37JGT2pDsa12+OhJq+De32UEldBC3peefpT823jguku6S/avtOhzyoRINd/iOyjf0JKbmr30dVf4gtUQ0mY3bpUhveYCdDLwy39IOx/7CfVmnvIATy3g1xJ9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708183557; c=relaxed/simple;
	bh=bWSYvvO2IqnPnE4jdJtpaD30hy778JveY74K8PjLF/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P55PKAlOsigFu9qqbuYZZfBOQ4fPu05RQk71hYllZLcP3q5DrNiV5NzQt9QntkXE1dhjPqQXriPeCdbiU43LwfgY5bWtHuujxAG63tD5K3RGhjPq7pENSlT7GuWW/lSoO0w0HZ62CelGnZKsfA8wVlEES8GrJ04ZoJU/EFZl38Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oDOBkAbt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 118DFC433F1;
	Sat, 17 Feb 2024 15:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708183556;
	bh=bWSYvvO2IqnPnE4jdJtpaD30hy778JveY74K8PjLF/o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oDOBkAbtvGbq7DXCQ0hwEpPoTMxxZHeT3FyxwmkS2Jy5blwcPrVMfUkIQ3bwx/Gus
	 H3vcCYEB5ZQPuao69WEdC0Ckza5VituxgF8EpfwKFZbuErRxqgskepgd4pMGaQYOLl
	 2CHJbdAPsQFz7KvSc0mxq6pLIq0cyoj+q4pXMnPc=
Date: Sat, 17 Feb 2024 16:25:54 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Wesley Cheng <quic_wcheng@quicinc.com>
Cc: srinivas.kandagatla@linaro.org, mathias.nyman@intel.com, perex@perex.cz,
	conor+dt@kernel.org, corbet@lwn.net, lgirdwood@gmail.com,
	andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	Thinh.Nguyen@synopsys.com, broonie@kernel.org, bgoswami@quicinc.com,
	tiwai@suse.com, robh+dt@kernel.org, konrad.dybcio@linaro.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-sound@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-doc@vger.kernel.org,
	alsa-devel@alsa-project.org
Subject: Re: [PATCH v17 00/51] Introduce QC USB SND audio offloading support
Message-ID: <2024021754-unengaged-saggy-6ab1@gregkh>
References: <20240217001017.29969-1-quic_wcheng@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240217001017.29969-1-quic_wcheng@quicinc.com>

On Fri, Feb 16, 2024 at 04:09:26PM -0800, Wesley Cheng wrote:
> Several Qualcomm based chipsets can support USB audio offloading to a
> dedicated audio DSP, which can take over issuing transfers to the USB
> host controller.  The intention is to reduce the load on the main
> processors in the SoC, and allow them to be placed into lower power modes.
> There are several parts to this design:
>   1. Adding ASoC binding layer
>   2. Create a USB backend for Q6DSP
>   3. Introduce XHCI interrupter support
>   4. Create vendor ops for the USB SND driver
> 
>       USB                          |            ASoC
> --------------------------------------------------------------------
>                                    |  _________________________
>                                    | |sm8250 platform card     |
>                                    | |_________________________|
>                                    |         |           |
>                                    |      ___V____   ____V____
>                                    |     |Q6USB   | |Q6AFE    |  
>                                    |     |"codec" | |"cpu"    |
>                                    |     |________| |_________|
>                                    |         ^  ^        ^
>                                    |         |  |________|
>                                    |      ___V____    |
>                                    |     |SOC-USB |   |
>    ________       ________               |        |   |
>   |USB SND |<--->|QC offld|<------------>|________|   |
>   |(card.c)|     |        |<----------                |
>   |________|     |________|___     | |                |
>       ^               ^       |    | |    ____________V_________
>       |               |       |    | |   |APR/GLINK             |
>    __ V_______________V_____  |    | |   |______________________|
>   |USB SND (endpoint.c)     | |    | |              ^
>   |_________________________| |    | |              |
>               ^               |    | |   ___________V___________
>               |               |    | |->|audio DSP              |
>    ___________V_____________  |    |    |_______________________|
>   |XHCI HCD                 |<-    |
>   |_________________________|      |
> 
> 
> Adding ASoC binding layer:
> soc-usb: Intention is to treat a USB port similar to a headphone jack.
> The port is always present on the device, but cable/pin status can be
> enabled/disabled.  Expose mechanisms for USB backend ASoC drivers to
> communicate with USB SND.
> 
> Create a USB backend for Q6DSP:
> q6usb: Basic backend driver that will be responsible for maintaining the
> resources needed to initiate a playback stream using the Q6DSP.  Will
> be the entity that checks to make sure the connected USB audio device
> supports the requested PCM format.  If it does not, the PCM open call will
> fail, and userpsace ALSA can take action accordingly.
> 
> Introduce XHCI interrupter support:
> XHCI HCD supports multiple interrupters, which allows for events to be routed
> to different event rings.  This is determined by "Interrupter Target" field
> specified in Section "6.4.1.1 Normal TRB" of the XHCI specification.
> 
> Events in the offloading case will be routed to an event ring that is assigned
> to the audio DSP.
> 
> Create vendor ops for the USB SND driver:
> qc_audio_offload: This particular driver has several components associated
> with it:
> - QMI stream request handler
> - XHCI interrupter and resource management
> - audio DSP memory management
> 
> When the audio DSP wants to enable a playback stream, the request is first
> received by the ASoC platform sound card.  Depending on the selected route,
> ASoC will bring up the individual DAIs in the path.  The Q6USB backend DAI
> will send an AFE port start command (with enabling the USB playback path), and
> the audio DSP will handle the request accordingly.
> 
> Part of the AFE USB port start handling will have an exchange of control
> messages using the QMI protocol.  The qc_audio_offload driver will populate the
> buffer information:
> - Event ring base address
> - EP transfer ring base address
> 
> and pass it along to the audio DSP.  All endpoint management will now be handed
> over to the DSP, and the main processor is not involved in transfers.
> 
> Overall, implementing this feature will still expose separate sound card and PCM
> devices for both the platorm card and USB audio device:
>  0 [SM8250MTPWCD938]: sm8250 - SM8250-MTP-WCD9380-WSA8810-VA-D
>                       SM8250-MTP-WCD9380-WSA8810-VA-DMIC
>  1 [Audio          ]: USB-Audio - USB Audio
>                       Generic USB Audio at usb-xhci-hcd.1.auto-1.4, high speed
> 
> This is to ensure that userspace ALSA entities can decide which route to take
> when executing the audio playback.  In the above, if card#1 is selected, then
> USB audio data will take the legacy path over the USB PCM drivers, etc...
> 
> This feature was validated using:
> - tinymix: set/enable the multimedia path to route to USB backend
> - tinyplay: issue playback on platform card

I've applied patches 1-10 and the 2 dts changes here, as those all had
acks from the relevant maintainers already.

thanks,

greg k-h

