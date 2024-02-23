Return-Path: <linux-kernel+bounces-77560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A1B860781
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 01:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB9BB1F248A6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 00:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E6A1C13;
	Fri, 23 Feb 2024 00:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RWcliE0r"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA85197;
	Fri, 23 Feb 2024 00:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708647300; cv=none; b=G+v9iZoORvJ9LsLJfWYnjFKXYsZ1PorDf6siXvjrO0dTyj2bZj6znhfeLzqo04miS2zpyc8KyzJZ5Qz0gBcVvjqmKGEooPhdhuUWLjil/P2V+foB9YEeY2hXHAduHHdRwFyAVROVSBVZO2Ce/ArTgB5bc0R7qofjgqB3SEDX6qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708647300; c=relaxed/simple;
	bh=ALaTQHJzjzLX0q4pli/+d7/sB1mmAsYN8kZyIavFMIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Du/mqHe4I/jUR8CvTLfClCu6YH60LHH1sJ8hRaNTmT4e8QNDI9DoHLvpUJdWMzuaDYdQkscglkwxcfhClw4hPTP2LcybWQdTq7UutCYFBTSiFLqc8NvzGYmO3palwARbMtA9Y3CKG4nlKIkk9+XO7Bu2xU1vrFv+azTudj01XhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RWcliE0r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69C7FC433C7;
	Fri, 23 Feb 2024 00:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708647299;
	bh=ALaTQHJzjzLX0q4pli/+d7/sB1mmAsYN8kZyIavFMIc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RWcliE0rIhur5hiRYX4R0M8ZEPK7UCaliJX8CB+PxtbDKvi8Aahh/DYUfwYJbtQha
	 QCBA903CEt/JMtUFPdFVMv+QEYYh/YWgUyd9E5d4rxuAKvqP+PdqwFXpv+JlNBdYHl
	 pK67suVHaf94CGkt4q//DOt1qx2ywu6Fx27KrTH45LEGHMEIc6hPU71S8dwGp1MkzB
	 9UftHahESHnfk8xvKpZw5NSbKBjXjiJ0JsZVPGoXVoY1EFgxSv+lXWzp9+Mcu54LfY
	 9Irz0WiShZ4kTfru3E9cWQFyzfFT+J+S/fyPBho9o5DkzFVy9QrE9sNz7f+hFDnLp3
	 T5uc4rQVWbQXg==
Date: Thu, 22 Feb 2024 17:14:50 -0700
From: Rob Herring <robh@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-arm-msm@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	David Airlie <airlied@gmail.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	linux-clk@vger.kernel.org,
	Michael Turquette <mturquette@baylibre.com>,
	linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>, iommu@lists.linux.dev,
	Rob Clark <robdclark@gmail.com>, Joerg Roedel <joro@8bytes.org>,
	devicetree@vger.kernel.org,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	linux-arm-kernel@lists.infradead.org, Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	Conor Dooley <conor+dt@kernel.org>, freedreno@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 1/8] dt-bindings: arm-smmu: Add QCM2290 GPU SMMU
Message-ID: <170864728970.3860293.1851655437327503155.robh@kernel.org>
References: <20240219-topic-rb1_gpu-v1-0-d260fa854707@linaro.org>
 <20240219-topic-rb1_gpu-v1-1-d260fa854707@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240219-topic-rb1_gpu-v1-1-d260fa854707@linaro.org>


On Mon, 19 Feb 2024 14:35:46 +0100, Konrad Dybcio wrote:
> The GPU SMMU on QCM2290 nicely fits into the description we already have
> for SM61[12]5. Add it.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>


