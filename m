Return-Path: <linux-kernel+bounces-39751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6078483D5B5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:13:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3140DB20C70
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ECF76D1AC;
	Fri, 26 Jan 2024 08:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y1qguTP2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE8B7FB;
	Fri, 26 Jan 2024 08:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706256749; cv=none; b=hhiKqeVEyNi4ZpALL3uVsmiGsixEa62iA876lrpeJH+B9i1hI1i+PFjn8e4PSaDKqmwz6iq0GwUw3nb2zrxzGIqzEONR5IGsi9Sq0nYcqRQcTrYbOf61klLy6CqmE+ic0sU0y4UyFfuKAh7zNSQifAc8HGBxYBpgHwnAn9maCwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706256749; c=relaxed/simple;
	bh=e5RqXiUfA6NRNGKjt3CxSJ3zCXhBqQGuJKKlnfeXBBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LbeK09oL4yrV+E9cspBV2CXRAUv9CYzstj6lrD+O7/vDlZ7gemu4+hBw2qcf1h3kRdmd2H7zUhMXplvn8TAVh+S+e3u0C46hYCEnHXvIARTR3+x2p8PvtDOAVYa67rcfQUEd0zqde23yR6rMwd8KVme1LNofylr6FppxQoPrRWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y1qguTP2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFD9EC433F1;
	Fri, 26 Jan 2024 08:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706256748;
	bh=e5RqXiUfA6NRNGKjt3CxSJ3zCXhBqQGuJKKlnfeXBBY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y1qguTP2G1gop3ziXTuVUqHXx5FTziY9+Vs4vikiNNqRNMEA5AiB+KNUM2xpqh9yC
	 OV/6UOKDrgKMrqLoXPSWKWvVYHAV1GfTye39ByQbjwly3N4p7WAyHWz319I2wYdbAJ
	 y77x2kVDc1iYyh8g7UCHmfRC2jBIbbys+TF+V2rGfYabIVcISdCBqgP6s0xsW5Ctq2
	 Oj85pr1VA+diTym8b+05ypQQ/k7MssTEpdVHejqQmpOQ/OGrQdn/sH7AqlLcqUbr58
	 sNhoZjP6ePQpkDbJs6eZ+2gck40XuyS6f1wikmuVdjOXqVeiBZSE/BvsSFIGhljC4K
	 CZfo9eiSwVing==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rTHKH-000000002nP-2nAg;
	Fri, 26 Jan 2024 09:12:37 +0100
Date: Fri, 26 Jan 2024 09:12:37 +0100
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
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sc8280xp-x13s: Fix/enable
 touchscreen
Message-ID: <ZbNpdaSyFS9tYrkd@hovoldconsulting.com>
References: <20240125-x13s-touchscreen-v1-0-ab8c882def9c@quicinc.com>
 <20240125-x13s-touchscreen-v1-2-ab8c882def9c@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125-x13s-touchscreen-v1-2-ab8c882def9c@quicinc.com>

On Thu, Jan 25, 2024 at 07:55:14PM -0800, Bjorn Andersson wrote:
> The failing read-test in __i2c_hid_core_probe() determines that there's
> nothing connected at the documented address of the touchscreen.
> 
> Introduce the 5ms after-power and 200ms after-reset delays found in the
> ACPI tables. Also wire up the reset-gpio, for good measure.

As the supplies for the touchscreen are always on (and left on by the
bootloader) it would seem that it is really the addition of the reset
gpio which makes things work here. Unless the delay is needed for some
other reason.

(The power-on delay also looks a bit short compared to what is used for
other devices.)

Reset support was only recently added with commit 2be404486c05 ("HID:
i2c-hid-of: Add reset GPIO support to i2c-hid-of") so we should not
backport this one before first determining that.

That commit also added a comment in the HID driver about the
'post-reset-deassert-delay-ms' to the driver which should now be
removed:

	/*
	 * Note this is a kernel internal device-property set by x86 platform code,
	 * this MUST not be used in devicetree files without first adding it to
	 * the DT bindings.
	 */

Johan

