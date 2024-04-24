Return-Path: <linux-kernel+bounces-157764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0929D8B15D2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 00:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA0FE1F23146
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 22:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1D515FD15;
	Wed, 24 Apr 2024 22:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aTrXFdtp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AFC745CB;
	Wed, 24 Apr 2024 22:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713996499; cv=none; b=gS8a0KzLHnBgsHVBTqeu1QKskWaIyXulCgXuKijqQmHRoNEw1js7GxqqDr7xnT2ks8YLN2AZoNvhzy+RXFVzJDlMCpsdsuupYe+oFSYfFKV9BkKtrnFBnLGJbViVpfC+caYGWvl/fXq0PL8dAkZCbYLjsEm5QsHnxCXmG/4hG2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713996499; c=relaxed/simple;
	bh=XCPu6L2ArYdQ0BX15tTorcNCtrjXqi1BMPW5jn42dKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rEREijpuZuekZZuxvugBmyOAcsVRCAyb8zYor5QnpyvdJSkEOGMqHLE69uS7fQax1b6UuirzJ1yCx3NX0x9DkLxtOuI3A1tUvJB56uR83Obmrc4yH7sq9J1H30U6OxOeU1BrEOmfbdGN0qjZ7jFbGMh1NuQAkG45wb+DZebYZoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aTrXFdtp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7DC8C113CD;
	Wed, 24 Apr 2024 22:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713996499;
	bh=XCPu6L2ArYdQ0BX15tTorcNCtrjXqi1BMPW5jn42dKU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aTrXFdtpYcLtwz+Zb4QVNlscGac2KAfJm2LTWLpeV2XTqNwiHr1/PKYPh4O2Q51Pk
	 z6mk3ml2UHM/RyWE31eHOHRJHn11f6T7rOGyjAtqiK9oiBYqRpxotdSV8SQ9qMhZ1d
	 NI7TX2m+EdAPDH3HusEovEDrXNQK7JHHNmCvDHmeH1fLtbMi4jHtdBZaPlEvGykoRC
	 JWrtMA3tC/YtoIbAEDey+5tUwg1JOCkX57eH5KGpHBuCxhSy0VmGJVHEZ6KjG1wr1q
	 anKaWQl5LhYLy65v7OCaH39s0Z21cQDWETYT4pGUyKWcs6fM3QPmqmddsC4qn6Go6n
	 cOhtfitMh45Ww==
Date: Wed, 24 Apr 2024 17:08:16 -0500
From: Rob Herring <robh@kernel.org>
To: Tengfei Fan <quic_tengfan@quicinc.com>
Cc: manivannan.sadhasivam@linaro.org, rafael@kernel.org,
	linux-kernel@vger.kernel.org, viresh.kumar@linaro.org,
	konrad.dybcio@linaro.org, linux-pm@vger.kernel.org,
	krzk+dt@kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org,
	andersson@kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: cpufreq: cpufreq-qcom-hw: Add SM4450
 compatibles
Message-ID: <171399647317.796485.8186698309001803718.robh@kernel.org>
References: <20240424101503.635364-1-quic_tengfan@quicinc.com>
 <20240424101503.635364-2-quic_tengfan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424101503.635364-2-quic_tengfan@quicinc.com>


On Wed, 24 Apr 2024 18:15:01 +0800, Tengfei Fan wrote:
> Add compatible for EPSS CPUFREQ-HW on SM4450.
> 
> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
> ---
>  Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


