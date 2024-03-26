Return-Path: <linux-kernel+bounces-118545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D8A88BC75
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5086A2E25A5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 08:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25B4EAD5;
	Tue, 26 Mar 2024 08:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="l7PZyTEa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D0A4A22;
	Tue, 26 Mar 2024 08:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711441863; cv=none; b=EEuNev6rVMcd2W1lUg7NtJ2Ef5qFCfC10UtA+O9w3FMUlsV+i94d7WVM96RMJvV8Is0ExkHPtr9LhtasXJR+CyA5USR/8WK/c333nu697aGWz2co6FopDYSJ+PMMMLey7RtvHC55Ft80uhEne8337JOTKQH6qCTzgs5e2pg75pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711441863; c=relaxed/simple;
	bh=IbF+4N6tEo6brIIuoUu69sJaSGZduUjBfVe4VkI9ggU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lXguXkBhxROIfIH7SKMamsjGD75K1Uwi1AApjyfT+UQPMwB7cMkOxRwdezxUv6NIjq2U8VthxlDnIHwr0n+0wIc0jLF+IiF9l1bH/+h6X8QakRVPuhTYZ1gTncA+b9zGfQ4Fc6B71kOCHEb541vOZPW8DKxoFDH7yssh5xxdf9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=l7PZyTEa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2376BC43390;
	Tue, 26 Mar 2024 08:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711441862;
	bh=IbF+4N6tEo6brIIuoUu69sJaSGZduUjBfVe4VkI9ggU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l7PZyTEaAbZVjqEgN51Gs5Ln4nm5SOxprbKcaO1HqS7na2znZekEVm9KXF+DG25sK
	 0JsMSj+qPOLqOiDfiFMq7OBUcpmCK9RUf/9Gb+V//CV/PEOybJkNP3CtGRhxqZfla2
	 VSoyTLiUJMjtNhblUgzaVlwMZyR0pwiothCB8IcU=
Date: Tue, 26 Mar 2024 09:30:59 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Komal Bajaj <quic_kbajaj@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Wesley Cheng <quic_wcheng@quicinc.com>,
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH 0/4] Add USB Support on Qualcomm's QDU/QRU1000 Platform
Message-ID: <2024032637-sessions-outcast-888a@gregkh>
References: <20240319090729.14674-1-quic_kbajaj@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240319090729.14674-1-quic_kbajaj@quicinc.com>

On Tue, Mar 19, 2024 at 02:37:24PM +0530, Komal Bajaj wrote:
> This series adds support of USB3 PHY support for Qualcomm's QDU/QRU1000 Platform.
> 
> ---------
> Changes in v2:
> * Dropped extra lines
> * Sorted the tables alphabetically
> * Link to v1: https://lore.kernel.org/linux-arm-msm/20240311120215.16845-1-quic_kbajaj@quicinc.com/
> 
> Komal Bajaj (4):
>   dt-bindings: phy: qcom,usb-snps-femto-v2: Add bindings for QDU1000
>   dt-bindings: phy: qcom,qmp-usb: Add QDU1000 USB3 PHY
>   dt-bindings: usb: dwc3: Add QDU1000 compatible
>   phy: qcpm-qmp-usb: Add support for QDU1000/QRU1000
> 
>  .../phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml   |  2 +
>  .../bindings/phy/qcom,usb-snps-femto-v2.yaml  |  1 +
>  .../devicetree/bindings/usb/qcom,dwc3.yaml    |  3 ++
>  drivers/phy/qualcomm/phy-qcom-qmp-usb.c       | 49 +++++++++++++++++++
>  4 files changed, 55 insertions(+)
> 
> --
> 2.42.0
> 
> 

The subject line here does not say v2, so I'm confused as to which one
is which :(

Please fix up and send a v3.

thanks,

greg k-h

