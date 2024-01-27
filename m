Return-Path: <linux-kernel+bounces-41229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4249483EDAE
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 15:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C59212844AC
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 14:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1CE428DBC;
	Sat, 27 Jan 2024 14:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UK2sryzt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B482030B;
	Sat, 27 Jan 2024 14:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706366976; cv=none; b=Xj6g9KGJ6G/2aclP8vCbwDIOsm/q62yNYY3ma7jaVzAqE4rDUEN42MBA19sXQ+9D8+3KTfL6fdk5ZB6KEV3G+FyC7fiF/q7X4HG/IRH36+bn1hmUTdc7C7S3wG4sPihF6qAFhGnjaqDZ/dpobq7kKlJlULfcpuM5ySRJX9nEnTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706366976; c=relaxed/simple;
	bh=AuqsP3vAOKyVmdLsexssS1XtsE4VPIfUnFnDDujaPgI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b+kClfYIVBGIZLLM1J0322RxDYfiemjjvxYgY5aN1n/c/AV5QEwE07pipCjLhNsiIpUxznuUwMAIP1aB0+VjCMoELJYFdbp9sXk7eCPUqeAxcRpU2f/yBhHsE3ZJsbiiCMAVJmBeIUkb82em534NW7egvzd+HBXOY3Z59rzY7vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UK2sryzt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A0DCC433F1;
	Sat, 27 Jan 2024 14:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706366975;
	bh=AuqsP3vAOKyVmdLsexssS1XtsE4VPIfUnFnDDujaPgI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UK2sryzt9slcXtfmGdfUs7U5HJ0qEARPzusZ+817F5QCVuf9nTHcKO2TqABOBqaOO
	 9bmxM/POaiJAtBRJwuZAAS1GhlhFrZfHI9w/UX+tsWdjQLGfD9cX32VASudHlxCzmI
	 I7JnUX1uVuZBrv1QDOoFaujglta6vqCdF7o/FgsLXhGy8VB51XzAf8EyncCtZW3ZsB
	 dXgtLQ/fWFT39O8oahi76KVUpPLKbPqbuCeTnt+i33BpZGPItwh9+dI98nuIdEHvL5
	 ySnZvWsLkJMF7IwlHJODQgZ9JgQI4NQ2ovdvAPTMBlvOcSRtees5OUftVT8PXxH5yN
	 RTFfQCeeS7gWw==
Date: Sat, 27 Jan 2024 14:49:20 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Peter Rosin <peda@axentia.se>, Naresh Solanki
 <naresh.solanki@9elements.com>, Lars-Peter Clausen <lars@metafoo.de>, Rob
 Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 mazziesaccount@gmail.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: afe: voltage-divider: Add
 io-channel-cells
Message-ID: <20240127144920.455b6f0c@jic23-huawei>
In-Reply-To: <20240127-hunting-wick-fc1eed1af6b1@spud>
References: <20240126115509.1459425-1-naresh.solanki@9elements.com>
	<20240126-cinnamon-flatware-e042b5773f17@spud>
	<CABqG17hzZf2mme0v7hALhpd6-N3ZHqxdH-AhFg5eF9sbLSC2gw@mail.gmail.com>
	<20240126-scale-serrated-33686467d91b@spud>
	<CABqG17jp6YRGyTmNitz-xDdyhWOPgfT_XpXxw-OJLnXQ777vAA@mail.gmail.com>
	<20240126-blaspheme-calculate-a4134dc1ed68@spud>
	<536971eb-51f0-40e5-d025-7c4c1d683d49@axentia.se>
	<20240127-hunting-wick-fc1eed1af6b1@spud>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.40; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 27 Jan 2024 11:03:14 +0000
Conor Dooley <conor@kernel.org> wrote:

> On Sat, Jan 27, 2024 at 10:40:31AM +0100, Peter Rosin wrote:
> > 
> > 
> > 2024-01-26 at 23:14, Conor Dooley wrote:  
> > > On Fri, Jan 26, 2024 at 11:10:36PM +0530, Naresh Solanki wrote:  
> >   
> > > I did look at what you have there and I think your dts is wrong.
> > > 
> > > The iio-hwmon binding says:
> > > | description: >
> > > |   Bindings for hardware monitoring devices connected to ADC controllers
> > > |   supporting the Industrial I/O bindings.
> > > | 
> > > |   io-channels:
> > > |     minItems: 1
> > > |     maxItems: 51 # Should be enough
> > > |     description: >
> > > |       List of phandles to ADC channels to read the monitoring values
> > > 
> > > And then you have:
> > > |	iio-hwmon {
> > > |		compatible = "iio-hwmon";
> > > |		// Voltage sensors top to down
> > > |		io-channels = <&p12v_vd 0>, <&p5v_aux_vd 0>, <&p5v_bmc_aux_vd 0>, <&p3v3_aux_vd 0>,
> > > |			<&p3v3_bmc_aux_vd 0>, <&p1v8_bmc_aux_vd 0>, <&adc1 4>, <&adc0 2>, <&adc1 0>,
> > > |			<&p2V5_aux_vd 0>, <&p3v3_rtc_vd 0>;
> > > |	};
> > > |
> > > |	p12v_vd: voltage_divider1 {
> > > |		compatible = "voltage-divider";
> > > |		io-channels = <&adc1 3>;
> > > |		#io-channel-cells = <1>;
> > > |
> > > |		/* Scale the system voltage by 1127/127 to fit the ADC range.
> > > |		 * Use small nominator to prevent integer overflow.
> > > |		 */
> > > |		output-ohms = <15>;
> > > |		full-ohms = <133>;
> > > |	};
> > > 
> > > A voltage divider is _not_ an ADC channel, so I don't know why you are
> > > treating it as one in the iio-hwmon entry. Can you explain this please?  
> > 
> > This is the exact intent of the voltage divider (and the other bindings
> > handled by the iio-rescaler). The raw ADC reports the voltage at its input,
> > which is fine, but if there is an analog frontend in front of the ADC
> > such as a voltage divider the voltage at the ADC is not the interesting
> > property. You are likely to want the "real" voltage before the voltage
> > divider to better understand the value.
> > 
> > In this case it's much more interesting to see values such as 12.050V
> > which is presumably close to the nominal voltage (12V? guessing from
> > the node name) rather than some unscaled raw ADC voltage (in this
> > example it would be ~1.359V, which tells you rather little w/o rescaling
> > it first).  
> 
> Thanks for explaining it. Naresh, can you respin please with an
> explanation of why the property belongs in the binding please?

Agreed - the explanation of 'why' is needed.
As discussed, in this case the end consumer is iio-hwmon
(reflecting that the thing we are ultimately 'measuring' as a voltage
 of a wire that needs monitoring for hwmon usecases) and
that is measured via a voltage divider (hence that's providing
the measurement service) which in turn needs to consume the reading
from and ADC and hence the middle device is here acting as a
provider to iio-hwmon and a consumer of the ADC channel.

p.s. No one really likes the iio-hwmon binding because it is reflecting
     a usecase rather than hardware, but meh, it's been around a long time
     and we never figured out a better option.

    Things are much cleaner for circuits like the voltage divider.

> 
> > It's all in the description of the binding...  
> 
> Obviously it was not sufficiently clear, it's not as if I didn't look at
> it...

Given this device fits in both categories, perhaps a tiny bit of
additional documentation would help?

  '#io-channels-cells':
    description:
      In addition to consuming the measurement services of an ADC,
      the voltage divider can act as an provider of measurement
      services to other devices.
    const: 1

> 
> Cheers,
> Conor.


