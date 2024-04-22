Return-Path: <linux-kernel+bounces-152839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4805F8AC51D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 09:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6D302828F7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 07:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B669353804;
	Mon, 22 Apr 2024 07:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TZJ5mDS3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6FF4CDE0;
	Mon, 22 Apr 2024 07:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713769970; cv=none; b=o1WU9vT7C2g6lzYt8fJMvaxHbhP8ahKai8m5Hslt0uaCfGW53XQIoeLYqUJV5GhjQyHEILdCtRu4jCQAFewaTHb+dRtwc0ncNBgf9ad8xcJl8/8h1rbF/g4OwWtjBrCGDeio+Ns1FMoUlOHOJIRo7G34zFePTPfge7AN/Q/18Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713769970; c=relaxed/simple;
	bh=nANodsRQh0SlHeZ8TSIrbcrOjTmp+PFztQpd3BDIO14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cfZ2nMVeVQTcMyHtqCz3rxFHQGkRV4Ec3Lrck7CWIKd+T94YAGv1hL1kQRHAUYe9BlL3/YUJGobIfFyo1m4/y2v1amGUwGkMwNmo4Ibn64hsaA9VYQgR3DkKO9+1a1FM7ucPrAFT7CnsNr3GFjVZa+XPy0RpwO9fGKQ1CDWe/2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TZJ5mDS3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8733AC113CC;
	Mon, 22 Apr 2024 07:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713769969;
	bh=nANodsRQh0SlHeZ8TSIrbcrOjTmp+PFztQpd3BDIO14=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TZJ5mDS3iZ8u6A5zh5olpA/0K2TLwjGCpzxN0Mf5pT2v2r0Ie4SOHFmUsPR5IsOJd
	 9jiLXxE1NPVOjroAZ5qhhc9b3aR4fNrsSzXL4K26LSfSAhl4zSjqL5Vs0zhH4SOqk9
	 diNXtpXrlpoJQYiBNV7Us+P2XuewFO8AsEn3N4dpATEkJiJHKA2jzGEc+FTQ0qSJle
	 xoygOIoS9SDB68PAjdokKwlm9X/kCyHwbbknw89DqLKKy4IgP82UsQBa+9h+a1INir
	 +j2FZiQcJKvrU/Uqj2xSeiyeqargBYg9rPG9p4x0vmocGMAISkHDtWEauANWN84/OT
	 ofoPc9re+XSOA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rynr2-000000002b5-0sv2;
	Mon, 22 Apr 2024 09:12:44 +0200
Date: Mon, 22 Apr 2024 09:12:44 +0200
From: Johan Hovold <johan@kernel.org>
To: Krishna Kurapati <quic_kriskura@quicinc.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Wesley Cheng <quic_wcheng@quicinc.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Felipe Balbi <balbi@kernel.org>, devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, quic_ppratap@quicinc.com,
	quic_jackp@quicinc.com, Bjorn Andersson <quic_bjorande@quicinc.com>
Subject: Re: [PATCH v21 5/9] dt-bindings: usb: qcom,dwc3: Add bindings for
 SC8280 Multiport
Message-ID: <ZiYN7F9i50CNtotG@hovoldconsulting.com>
References: <20240420044901.884098-1-quic_kriskura@quicinc.com>
 <20240420044901.884098-6-quic_kriskura@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240420044901.884098-6-quic_kriskura@quicinc.com>

On Sat, Apr 20, 2024 at 10:18:57AM +0530, Krishna Kurapati wrote:
> Add the compatible string for SC8280 Multiport USB controller from
> Qualcomm.
> 
> There are 4 power event interrupts supported by this controller
> (one for each port of multiport controller). Add all the 4 as
> non-optional interrupts for SC8280XP-MP
> 
> Also each port of multiport has one DP and one DM IRQ. Add all DP/DM
> IRQs related to 4 ports of SC8280XP Teritiary controller.
> 
> Also added SuperSpeed PHY interrupt for both Superspeed ports.
> 
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> Reviewed-by: Bjorn Andersson <quic_bjorande@quicinc.com>

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>

