Return-Path: <linux-kernel+bounces-163396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9890A8B6A3A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 08:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 394BB1F235BA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 06:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C49F17C6A;
	Tue, 30 Apr 2024 06:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OY0sdQqE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552636FB1;
	Tue, 30 Apr 2024 06:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714457601; cv=none; b=KYwh6KoEPTlqfyxOjZeY+VF9tQt/uhtG7VcvczKfybwz3S9TZlS45JPXqFz+nWaFNQ0sHLTz3IOdNdmzZoLHAgjTduv4lEn1UbB5cbBDpwQ7b6o5NrGYB+ablyWRCKLTLnFYouZZOv3BEg03fM6vZ+ZFH1/AlEPulqkR3fLw84Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714457601; c=relaxed/simple;
	bh=FrbMKvLmmocxoDwXlo9MJD+1DyQ+ycNVGCMxXLYrj1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Va1cOMIDmy98Gwuv1Y4NuD6PEH8sQVGX8R/rFrxQ4gmPXt7Yq/WB7vEJH3jwzX1z6P59AKuUq2XlUY3Nk/nYG8lDJtwGkkStL3lMUFsXvAncL4VQjXdjEzZJlnhl+DEsIuFkH4Iksovr8gjmHtfHJoUXAGbKhhcAHv+3s84+ybU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OY0sdQqE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0541C2BBFC;
	Tue, 30 Apr 2024 06:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714457601;
	bh=FrbMKvLmmocxoDwXlo9MJD+1DyQ+ycNVGCMxXLYrj1g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OY0sdQqEOmuuV+QWB3LrjvJ+fR+CM2ym5txNOIxFRVRx+XCV+obUOcT4yPlx6fVGg
	 30xsbD84qdAN6NHQGBJc9Gn3GEc2vXT1W78AT9BC5/6NOQAOJ2/5k5MEwMerfwPkol
	 vKjSUaAVMvhjgHhBBDFNvssHPjAwAKm55WJBB4LNXBV1sVLB84bFgf1SHE937agjwy
	 NHcOaGR9WjtoObPo74/I8yW8QMB4wuIvj8nxl7vxDzAlRxKuUMVOkv7mq/1pmAZxd8
	 b0g8uiK929hs0QEufFkGejIeJYuaWJcpf1Kbx54GFiv907HyxfbaUXANg+wMGGOnv9
	 av358IOdvKwQw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1s1gjx-000000007OM-0wla;
	Tue, 30 Apr 2024 08:13:21 +0200
Date: Tue, 30 Apr 2024 08:13:21 +0200
From: Johan Hovold <johan@kernel.org>
To: Krishna Kurapati <quic_kriskura@quicinc.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	quic_ppratap@quicinc.com, quic_jackp@quicinc.com
Subject: Re: [PATCH v16 1/2] arm64: dts: qcom: sc8280xp: Add USB DWC3
 Multiport controller
Message-ID: <ZjCMAY8HYb18IAzl@hovoldconsulting.com>
References: <20240429162048.2133512-1-quic_kriskura@quicinc.com>
 <20240429162048.2133512-2-quic_kriskura@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429162048.2133512-2-quic_kriskura@quicinc.com>

On Mon, Apr 29, 2024 at 09:50:47PM +0530, Krishna Kurapati wrote:
> Add USB and DWC3 node for tertiary port of SC8280 along with
> Multiport interrupts and PHYs.
> 
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>

All looks good now.

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
Tested-by: Johan Hovold <johan+linaro@kernel.org>

