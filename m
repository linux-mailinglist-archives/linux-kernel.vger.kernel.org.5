Return-Path: <linux-kernel+bounces-91906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEFC5871837
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 09:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0DC01C2146A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 08:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A4B7F7E5;
	Tue,  5 Mar 2024 08:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DaVewEA3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37347EEF8;
	Tue,  5 Mar 2024 08:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709627177; cv=none; b=OdYFTJYsmOosLbXopAqTHP55lahb1QBidCDCW72dN3P7hz22JvgYRy8y7q4gFzhENqW35XuJiGaRp/MWG/nXIfPyVfzLdZcOUkTyHo6WdLnvUOmRnvpOnos2zbAMiZWA4rE73tWsMs/kNVnQiiSWA7+lAVup/yGBq9VWm608EcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709627177; c=relaxed/simple;
	bh=oZI5u9UqBMKh6iu9qOucIbAz7ZiCUSpHp982hC84V5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XXGnVb6MGV9bQe4ysvSnTATuYw9PHMEq+BAaNlf5u1aMo/6hF/k1SAO+ncgD3id/yM1orkAG+XZx/DT2woWPPtSloVIH7WqNP6suL4HYQAHj4gw128RsPwTS9XRnH0RO1dGtIcR7TjEzFZFT3MXoP3cY2lNl2x7f+lAfvx6EHgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DaVewEA3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E2A6C43390;
	Tue,  5 Mar 2024 08:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709627176;
	bh=oZI5u9UqBMKh6iu9qOucIbAz7ZiCUSpHp982hC84V5M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DaVewEA30wxuNtivbAcVismACBuM1RHcTHQ6CtJhc6Sj85ay4JjFWt3/Hu5j5w46S
	 YC0SCB2NvyA0ye/ybn5CJZcczhcEe4QWCUTlAYevem5DVbnWUwxeySiwotyXl2bL7Q
	 fhq9l81DsAt9i+T8jIZXWSaZ4vDAWhp1JATeCjAwH5q9+oaXMNK9IBO4tBf1a1ukpM
	 1gljMJ7x+Ryf9YagLhc5X7/lmv57a0kFjQi1tbz5dntDHd5F71aLpQrZ6KwACiOvX4
	 GznAvBbXR0P+U/Ev+OtugYfKwdWdnq62pIiJ0p4MntnMGS+MG0FC3C6n3Z0DSD526t
	 07U+fsiFH+O3Q==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rhQ7y-000000003DX-1FuZ;
	Tue, 05 Mar 2024 09:26:23 +0100
Date: Tue, 5 Mar 2024 09:26:22 +0100
From: Johan Hovold <johan@kernel.org>
To: Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Wesley Cheng <quic_wcheng@quicinc.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, quic_ppratap@quicinc.com,
	quic_jackp@quicinc.com
Subject: Re: [PATCH] usb: dwc3: qcom: Remove ACPI support from glue driver
Message-ID: <ZebXLkA9kXzx6qNi@hovoldconsulting.com>
References: <20240305042143.3455101-1-quic_kriskura@quicinc.com>
 <ZebFKlae0a-deBKl@hovoldconsulting.com>
 <0c2c039e-b49e-4172-9c7f-24061e3ac5c6@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c2c039e-b49e-4172-9c7f-24061e3ac5c6@quicinc.com>

On Tue, Mar 05, 2024 at 01:47:05PM +0530, Krishna Kurapati PSSNV wrote:
> On 3/5/2024 12:39 PM, Johan Hovold wrote:
> > On Tue, Mar 05, 2024 at 09:51:43AM +0530, Krishna Kurapati wrote:

> > You should update the Kconfig entry for USB_DWC3_QCOM as well and drop
> > the ACPI dependency.
> 
> Missed it. Thanks for the catch. The following is the one right ?
> 
> diff --git a/drivers/usb/dwc3/Kconfig b/drivers/usb/dwc3/Kconfig
> index 5fc27b20df63..31078f3d41b8 100644
> --- a/drivers/usb/dwc3/Kconfig
> +++ b/drivers/usb/dwc3/Kconfig
> @@ -131,7 +131,7 @@ config USB_DWC3_QCOM
>          tristate "Qualcomm Platform"
>          depends on ARCH_QCOM || COMPILE_TEST
>          depends on EXTCON || !EXTCON
> -       depends on (OF || ACPI)
> +       depends on OF

Right.

> > Looks good to me otherwise.
> 
> Thanks for the review. Wanted to reply to your comments on multiport 
> series depending on how this patch goes in upstream.
> 
> Can I push out v2 or wait for a couple of days (as a standard practice 
> before putting a new version) ?

I think you can send a v2 straight away in this case.

Johan

