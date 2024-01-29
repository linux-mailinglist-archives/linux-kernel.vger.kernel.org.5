Return-Path: <linux-kernel+bounces-43158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F4B7840C93
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:57:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8268A1C22FCA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE67157030;
	Mon, 29 Jan 2024 16:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RQRULy0z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67183154BF0;
	Mon, 29 Jan 2024 16:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706547415; cv=none; b=FKv1B2EK5hot3mHYjU/PMBv4ed3LGL7iP5aCoTFvHt9tBnx3KHl2WfnYVHp8YdpU7tCTftjCbA3uNcSdxzCKGkLbwZqWLGNHfnLG3VetqXn8IYBIav0QAI5sTx9P4Bk3qq/N+udA0J70tBKHib/RIuy6+Bc136b8onFgL+wrUH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706547415; c=relaxed/simple;
	bh=o1wrlYDctkpNgv/bHKopV+wojYxYm7idQb4shaCr3YU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gh6Rd0YrjCWL0lOyLhC+n6o0BrETisFgpmTtF8VivpYvtgo70Izd8PZnqw0jRErmuYCMLEDbCqIRBX6U3nmYPJWSiJVbhUbaYZRNxlYJAJBvYDqnmwWDV25Tmjc685iBVxOxqztQZq0ElxKA88QjTRa3rI4I0DCToHdhXWCMPiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RQRULy0z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B93BAC43390;
	Mon, 29 Jan 2024 16:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706547414;
	bh=o1wrlYDctkpNgv/bHKopV+wojYxYm7idQb4shaCr3YU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RQRULy0z9cwooO6H9rYP8ZxioB4lCR3wObNu+XWTnhRT1ptOh0w5UfxYhnS/WZ5pW
	 CHbHcIQykjr6gKSsovvlLykf405+eY07ySvzG9AXYyR1wo+MC/6EpUY6JSlEL+kPkq
	 lBYB+VAqwBkF9ET+Vmrl85Dp3Jm9xaRvncl7ipEdfoZ9cSNQSH6i/VFcFKZU6+o+Yb
	 1vkSqwBS2AvqBzTLCZt2wHoy65OpmaTBi1Sombr89gbY0uDinYoNqcT8/WWnVwbN9x
	 zQm9rgJQvJSQfeisofxm+B8vM7yKgcV/jq0DnhfrMX6QRwb+QOEsUfyVS4Gw8kFGzr
	 /YlR92whq/5vw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rUUwB-000000001nU-3lNA;
	Mon, 29 Jan 2024 17:56:48 +0100
Date: Mon, 29 Jan 2024 17:56:47 +0100
From: Johan Hovold <johan@kernel.org>
To: Bjorn Andersson <quic_bjorande@quicinc.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	Jiri Kosina <jikos@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	linux-arm-msm@vger.kernel.org, linux-input@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@somainline.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: HID: i2c-hid: Document reset-related
 properties
Message-ID: <ZbfYzyHaNmjJyNpY@hovoldconsulting.com>
References: <20240129-x13s-touchscreen-v3-0-c4a933034145@quicinc.com>
 <20240129-x13s-touchscreen-v3-1-c4a933034145@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129-x13s-touchscreen-v3-1-c4a933034145@quicinc.com>

On Mon, Jan 29, 2024 at 08:47:47AM -0800, Bjorn Andersson wrote:
> Some I2C HID devices has a reset pin and requires that some specified
> time elapses after this reset pin is deasserted, before communication
> with the device is attempted.
> 
> The Linux implementation is looking for these in the "reset-gpios" and
> "post-reset-deassert-delay-ms" properties already, so use these property
> names.

> +  post-reset-deassert-delay-ms:
> +    description: Time required by the device after reset has been deasserted,
> +      before it is ready for communication.
> +
> +  reset-gpios: true

Hmm, for the third time, it seems you ignored my comment that you need
to remove the comment about these properties from the driver as part of
this series.

	/*
	 * Note this is a kernel internal device-property set by x86 platform code,
	 * this MUST not be used in devicetree files without first adding it to
	 * the DT bindings.
	 */
	if (!device_property_read_u32(dev, "post-reset-deassert-delay-ms", &val))
		ihid_of->post_reset_delay_ms = val;

> +
>    touchscreen-inverted-x: true
>  
>    touchscreen-inverted-y: true

Johan

