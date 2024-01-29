Return-Path: <linux-kernel+bounces-43166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E48A840CA9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 18:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EF251F27F74
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC83157E86;
	Mon, 29 Jan 2024 16:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q1YXFNdo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED0F157020;
	Mon, 29 Jan 2024 16:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706547593; cv=none; b=UjhP2uyRz2OQDQ1hBRykiwZhcFVI/FOHU9q8WCuXatRCJ5gOu76dmAtGJf7bZpX5dHdRWhQuhZ7A/BmJPXFwXwZzmJP/W94LzPN7BhH4rG4iRg4BBowTFwaU+tpuqrdsuitboTZD88hdcxX08fMOxPKcQ6VFse0p7iZDLzJKPm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706547593; c=relaxed/simple;
	bh=/UzI7ZXEeoI0XJZVFqiFBLMZ5LqRbK9eEwG+B6vZnBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cxaCdV5gSTZ0wv0W8eriKbRQgsYNw+rfEcnk1iaK0LjRYcSVxVnvrlch3lJJ0oCJt4gHd1aAWKn+L3iF4g8DgLQwqn9KiViUWEx2gJYVeXJMvhB79XefDK7PGHWp6Ao0lqZSpKbf53PzbXinjLTYtHSgcW6Qmyxj2iejxXCt4z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q1YXFNdo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6395C43390;
	Mon, 29 Jan 2024 16:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706547592;
	bh=/UzI7ZXEeoI0XJZVFqiFBLMZ5LqRbK9eEwG+B6vZnBk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q1YXFNdowXzkFlFk+S2jJSFXdtePJ8WtKVPS0bpw7dA7113IN4q/pFcidJLRSQkwQ
	 e5IO5h57TV6jnPCTYyNxneodq+SZp9LV+MOAL5PTSFPaT55u6QUu008zQJTruYgllh
	 YPpKBI7B6exftv6f3J+VW2seBu+Qj8ReYRkb1TDtT3so+ET+jjbqLwvxAW1t1hQpkT
	 ywimP/C9gpY7UsqZL4sdK/iIJ8A1DBaZM5LlWlmF2JAkGerBBkBv2QrURd6f4ztZEI
	 wlBE9FJ+Kb++RWc1Wi+2lYkkWq1pSRKwBSRc8Y3zkjXcDlFHZa1ygVtGbU9rfr9yWC
	 EuQqguqcq4UpA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rUUz4-000000001o4-2is6;
	Mon, 29 Jan 2024 17:59:46 +0100
Date: Mon, 29 Jan 2024 17:59:46 +0100
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
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: [PATCH v3 2/2] arm64: dts: qcom: sc8280xp-x13s: Fix/enable
 touchscreen
Message-ID: <ZbfZguXnHIGP0DUe@hovoldconsulting.com>
References: <20240129-x13s-touchscreen-v3-0-c4a933034145@quicinc.com>
 <20240129-x13s-touchscreen-v3-2-c4a933034145@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129-x13s-touchscreen-v3-2-c4a933034145@quicinc.com>

On Mon, Jan 29, 2024 at 08:47:48AM -0800, Bjorn Andersson wrote:
> The touchscreen present on some SKUs of Lenovo Thinkpad X13s is never
> detected by Linux. Power is applied and the device is brought out of
> reset using the pinconfig in DeviceTree, but the read-test in
> __i2c_hid_core_probe() fails to access the device, which result in probe
> being aborted.
> 
> Some users have reported success after rebinding the device.
> 
> Looking to the ACPI tables, there's a 5ms after-power and a 200ms
> after-reset delay. The power-supply is shared with other components, so
> this is active all the way through boot. The reset GPIO, on the other
> hand, is low (reset asserted) at boot, so this is first deasserted by
> the implicit application of the pinconf state.
> 
> This means the time between reset deassert and __i2c_hid_core_probe() is
> significantly below the value documented in the ACPI tables.
> 
> As the I2C HID binding and driver support specifying a reset gpio,
> replace the pinconf-based scheme to pull the device out of reset. Then
> specify the after-reset time.
> 
> The shared power rail is currently always on, but in case this ever
> change, the after-power delay is added as well, to not violate the
> power-on to reset-deassert timing requirement.
> 
> Fixes: 32c231385ed4 ("arm64: dts: qcom: sc8280xp: add Lenovo Thinkpad X13s devicetree")
> Tested-by: Daniel Thompson <daniel.thompson@linaro.org>
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>

Thanks for the update. 

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>

