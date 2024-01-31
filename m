Return-Path: <linux-kernel+bounces-46669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 812F784426D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 16:01:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C44A296E99
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8CA12CD88;
	Wed, 31 Jan 2024 14:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k4vpGyOr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BBC12C555;
	Wed, 31 Jan 2024 14:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706712904; cv=none; b=MOBk7P5o73UY1vhuP3y3ASLA1z8ZKVl9/nRkX3HM5Zz2taqcVrPCEZwXDIK42resj1KyOVMdpiaSvQh41/01Jv3je61WbokWUhqKXZVAo62FUOVFmhBFqGOI9hGtvgA5lk/U1fSTF3C3OJKkWanaG6vnFohgsknjTor9FaYK2u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706712904; c=relaxed/simple;
	bh=bib7u/kOOTdQtOzyN6AdTB575aRRs5nTwJnPxeh/thM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=soW9Dblp6X4VHc1W7A4GHnwj4RCQGMbN3DuAVOqmBmTZKC0pR5XthhsmHxQJ7SswY1x/FTRY2YGyP9WMns80f4/DQb06fIwWUAN1M5JCk0t3MVMC4rWtp6SoFCLscQjILvH6lCljerwja+lj+Vve+mZzjxNXPVlJea9xciDnQa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k4vpGyOr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D68BC43399;
	Wed, 31 Jan 2024 14:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706712903;
	bh=bib7u/kOOTdQtOzyN6AdTB575aRRs5nTwJnPxeh/thM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k4vpGyOrvwwkNiqBbAqWJAB4O9tE8+XHHPCOxLgv0rZ2/2pLKCTnWIMGiVIoQlE8T
	 VhI2JHatS/i9/HbeFZz3NW2ZNCcnQBavHwBXX/HprWBXfqfUIV/7nizEAPGtDqxHqT
	 Zx08FgWMoDFzYRbH95mgSN38yV9oV/8uG7xFTG3W3VQlFiqtQuDlsEM4BhdhiLoGQh
	 5b6jCQ5ZfIrojcycshdI1tsjdN14hDjRhG92OZoSZosEmn8uQ28n9hjzcsFcBfEFUr
	 YThd1omAUn66lkx9UhMxgxSdc1K5l+zYDz5DLTcQxrjiEbJ49ubky1sLBOadPzuynk
	 fqMQvsYgCucEA==
Date: Wed, 31 Jan 2024 08:55:01 -0600
From: Rob Herring <robh@kernel.org>
To: Mao Jinlong <quic_jinlmao@quicinc.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@arm.com>, Leo Yan <leo.yan@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	Tingwei Zhang <quic_tingweiz@quicinc.com>,
	Yuanfang Zhang <quic_yuanfang@quicinc.com>,
	Tao Zhang <quic_taozha@quicinc.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: arm: coresight: Remove pattern match
 of ETE node name
Message-ID: <20240131145501.GA1254056-robh@kernel.org>
References: <20240119092500.7154-1-quic_jinlmao@quicinc.com>
 <20240119092500.7154-2-quic_jinlmao@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240119092500.7154-2-quic_jinlmao@quicinc.com>

On Fri, Jan 19, 2024 at 01:24:57AM -0800, Mao Jinlong wrote:
> Remove pattern match of ETE node name. Use ete as the name for ete nodes.
> 
> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
> ---
>  .../bindings/arm/arm,embedded-trace-extension.yaml          | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/arm,embedded-trace-extension.yaml b/Documentation/devicetree/bindings/arm/arm,embedded-trace-extension.yaml
> index f725e6940993..a10a570bd9bc 100644
> --- a/Documentation/devicetree/bindings/arm/arm,embedded-trace-extension.yaml
> +++ b/Documentation/devicetree/bindings/arm/arm,embedded-trace-extension.yaml
> @@ -22,8 +22,6 @@ description: |
>    with any optional connection graph as per the coresight bindings.
>  
>  properties:
> -  $nodename:
> -    pattern: "^ete([0-9a-f]+)$"

I prefer we keep something here. '^ete-' or '^ete-[0-9]+$'.

>    compatible:
>      items:
>        - const: arm,embedded-trace-extension
> @@ -55,13 +53,13 @@ examples:
>  
>  # An ETE node without legacy CoreSight connections
>    - |
> -    ete0 {
> +    ete {
>        compatible = "arm,embedded-trace-extension";
>        cpu = <&cpu_0>;
>      };
>  # An ETE node with legacy CoreSight connections
>    - |
> -   ete1 {
> +   ete {
>        compatible = "arm,embedded-trace-extension";
>        cpu = <&cpu_1>;
>  
> -- 
> 2.41.0
> 

