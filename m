Return-Path: <linux-kernel+bounces-138996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E803F89FD3B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 18:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2573F1C2269D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF40F17B507;
	Wed, 10 Apr 2024 16:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b66/qBbx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A81A26AE8;
	Wed, 10 Apr 2024 16:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712767235; cv=none; b=UGrrCli/cPbqpZWs0gc13agRQBGvrZe+k9m8uubhMRbp1HUSnmy78LkOJPfEAAO4fC5cxodQPrzxu7LNuhTzt9uCGJDN8GvojNd0mxclQI8aGzPDtSMGQ8RhLY1YF0szNWW5+Gszt5VYl5h/X3jsVP11ntUR8tdV84gmkZxY6/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712767235; c=relaxed/simple;
	bh=u1Ays1TopEnoD9JREpSfKXueGaUE5K8KcfqquzYAtJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aTgJElJKNOJJqQh9aoQ4y4BWjhxKfdY6QiDTAHnH9p1I06zy+gIr9/0RBkQXd2g6wTnm6EGOxvzAdxs35A3bL0bqJJG19dndHswROMxEleLoDAvvMfychP7KPuqkvgI7Bt95LZt6g7XSJQbEdaLEZCq3uA36tq3Lrf5rMu/xh+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b66/qBbx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93E0BC433C7;
	Wed, 10 Apr 2024 16:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712767234;
	bh=u1Ays1TopEnoD9JREpSfKXueGaUE5K8KcfqquzYAtJg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b66/qBbxu/dr947rCndHmvWVYRa08F8cj79FfO72nwFUdFfAnKaaMj8GqcbqyJv73
	 rubAPjTQIN8vsU161XsstzGHwbZy2oE6rgcSagCd33cGBv7t7ft67tcYTlkeLPrQ+1
	 GkClpJXEVQYRdhkllx7TNTDk5b7ITusnBshANlkreJRLX9cFAw+7m0CN0Cj2Xrx9t0
	 AC2591PmVXuHzepZoBxM+SlXK4UR6tbCsZoSypQxlShMKr8zQsmqvu8NZe49oNXEmy
	 KZUCARzhbNxBHvzOQQ3YPuSrL6RP0RlsSOoaOPA2twzdOa4V5syJGBnd/DEyTxTc2U
	 pHwb967VSawTg==
Date: Wed, 10 Apr 2024 11:40:32 -0500
From: Rob Herring <robh@kernel.org>
To: Peter Griffin <peter.griffin@linaro.org>
Cc: avri.altman@wdc.com, linux-phy@lists.infradead.org, vkoul@kernel.org,
	martin.petersen@oracle.com, alim.akhtar@samsung.com,
	devicetree@vger.kernel.org, willmcvicker@google.com,
	linux-scsi@vger.kernel.org, mturquette@baylibre.com,
	conor+dt@kernel.org, ebiggers@kernel.org, kishon@kernel.org,
	sboyd@kernel.org, krzk+dt@kernel.org, jejb@linux.ibm.com,
	linux-arm-kernel@lists.infradead.org, saravanak@google.com,
	andre.draszik@linaro.org, linux-clk@vger.kernel.org,
	bvanassche@acm.org, linux-samsung-soc@vger.kernel.org,
	chanho61.park@samsung.com, s.nawrocki@samsung.com,
	linux-kernel@vger.kernel.org, cw00.choi@samsung.com,
	tudor.ambarus@linaro.org
Subject: Re: [PATCH 02/17] dt-bindings: soc: google: exynos-sysreg: add
 dedicated hsi2 sysreg compatible
Message-ID: <171276723023.413753.7709849085293151317.robh@kernel.org>
References: <20240404122559.898930-1-peter.griffin@linaro.org>
 <20240404122559.898930-3-peter.griffin@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240404122559.898930-3-peter.griffin@linaro.org>


On Thu, 04 Apr 2024 13:25:44 +0100, Peter Griffin wrote:
> Update dt schema to include the gs101 hsi2 sysreg compatible.
> 
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> ---
>  .../devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml  | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>


