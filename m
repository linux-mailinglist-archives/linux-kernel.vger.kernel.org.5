Return-Path: <linux-kernel+bounces-105617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D47AF87E1A4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 02:28:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FF941C2144D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 01:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E041CFAD;
	Mon, 18 Mar 2024 01:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mAZqwJus"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753CD1CD07;
	Mon, 18 Mar 2024 01:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710725276; cv=none; b=QIaFhdtuecS7skmpojejXTusE7xV6+H7voZvfc7IcBxvO6OdKefiRYExbEWeiUiASeROXwIFsbPGbuCJo58wQ27641ZfcPuqx4zR9M3f61cnFvbrvjFvN6aWizU/csHGgywIeYcsJua9CwzwPU9aTEaoW3Bjgp9tf9SsKnB7dSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710725276; c=relaxed/simple;
	bh=RhB/nWWwoCQMMHLsN2PtqvPB+ZkEomggWeNkRLQBVUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bLsmpKNpUAH6nxdY1qlO3iGcoFHYK5flGqF4I9iAn3jdagxuraBYcExPO1dbB0P3X9baCBzfiXYXLYCwE4KPR5IfG2MEH5gQNxFtLLlat0tio3X6inTqitzNmxWLwAzo+S4m+afjo7mYF6ylwF6i5By0HyGEcmDY5zqxlrNPjx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mAZqwJus; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE0F4C433C7;
	Mon, 18 Mar 2024 01:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710725276;
	bh=RhB/nWWwoCQMMHLsN2PtqvPB+ZkEomggWeNkRLQBVUc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mAZqwJusQJZXb2OJMfT+mDfrdyC8ILUSY2QKpsvTPvP5oVcLiZ9GyhibASy3ausGx
	 5JHmg3fBSOTc4NkezKfvT82kSECEFp049Z5SpFxh6nbg/natLPSx+uRbgvLJn9T3Rm
	 AJIctURuGRrhcyszXa/oo5r/qhwp+e49EzTkjq0aPo+IlbR7ATcaKCiENjaAplVGaB
	 BKZi9HQVhh9mamrTZoWwMWSjwngbgodqh5rXnjSb4scBrNsZr17vogzbxn2/2W5Aow
	 08qpNcTQeweb+KERctFkLLKDCgS9DTFwqBBIE6OSqZDrsQrgz3QSrS+y/tYxRb0HuA
	 obxAj+9QY/NNg==
Date: Sun, 17 Mar 2024 20:27:52 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thara Gopinath <thara.gopinath@gmail.com>, Amit Kucheria <amitk@kernel.org>, 
	Marijn Suijten <marijn.suijten@somainline.org>, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, stable@vger.kernel.org
Subject: Re: [PATCH v2 2/3] thermal: qcom: lmh: Check for SCM availability at
 probe
Message-ID: <yes2jztatfs7abss6rt3dlnnifse7xh2klyd44zg2lkngp7mjf@dsmh23oqgbf6>
References: <20240308-topic-rb1_lmh-v2-0-bac3914b0fe3@linaro.org>
 <20240308-topic-rb1_lmh-v2-2-bac3914b0fe3@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240308-topic-rb1_lmh-v2-2-bac3914b0fe3@linaro.org>

On Sat, Mar 09, 2024 at 02:15:03PM +0100, Konrad Dybcio wrote:
> Up until now, the necessary scm availability check has not been
> performed, leading to possible null pointer dereferences (which did
> happen for me on RB1).
> 
> Fix that.
> 
> Fixes: 53bca371cdf7 ("thermal/drivers/qcom: Add support for LMh driver")
> Cc: <stable@vger.kernel.org>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

Regards,
Bjorn

