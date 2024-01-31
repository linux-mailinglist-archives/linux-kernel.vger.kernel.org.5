Return-Path: <linux-kernel+bounces-45756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D67C8435DF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 06:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1128C1F26816
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 05:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD833D998;
	Wed, 31 Jan 2024 05:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="SKWMr+Xd"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F215F3D550;
	Wed, 31 Jan 2024 05:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706677715; cv=none; b=EyV/0dV+4ieRsFZQ11FDBL/j/s7bOUUZV5B4NTfwQazXKBpS1x35vr2rFrssdxqf80nA9cNwtbqtTe66/GHMRv1urxSyvdqdhM+l7jb58UpWck3jzVUcStI4yJ5mCn7JuRaU8dr5gFyZ/MVWeDOLbbnnqAXdijojAYZj4S2w2/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706677715; c=relaxed/simple;
	bh=5/9E+Z069VkLNNPVB+X8W2U3aiFKX0DUW4JQ+SZcIMU=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=fqd4fC2Eow9dvKrhE/eU3b3cClGrAcwB1tvtkdgF9ZUW44nGX/6om63frqCgRIgzHXIH+SqIFZIB/erJESNDBFSdxxZrQ7GJB3BJg2YB57xuPBvPsC7Lz2hXzOb5sXsDLT1w7yKn9kO6DykLdXSQIUJCYNZ3krfZNfJY4VVQ1uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=SKWMr+Xd; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1706677712;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dFaxIwxEmyt5THRnWn7HLhXsgUMlYlkFF7eFCp1ek/g=;
	b=SKWMr+XdnjWACiQxgwrji/XGE94Cz/zzma1cpB55I+LTJxedRtmOA+jwXHJ+TwC6+SpCUd
	AG7OqABrcNjdgO+YJVv2uYELGMiusfhmtBUGDjKYSg1CrvI7ZRaIKuYs2yO1v9cpz4ZQBj
	T4Yqzyd9rWhi0OjfO3EZ4qMDrihrwR0tMnoE5xCrbxwAd036rhL1/z8CNvM7b7BLv7u8AE
	3t1HaYp3VqF0k3YN8E6LUJQ2D7KbfMzCXmHBeERn8zlUfH3jxY8F4pls06dYiCLKTAguZt
	GvVGfd+n5n6nJzmh38meWvSvzXAqHxRlhdXJ9zxxHfoP2y5kMoO/BgS2LqQ8Ng==
Date: Wed, 31 Jan 2024 06:08:31 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Alexey Charkov <alchark@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>, Daniel Lezcano
 <daniel.lezcano@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] arm64: dts: rockchip: Add further granularity in
 RK3588 CPU OPPs
In-Reply-To: <20240130-rk-dts-additions-v2-4-c6222c4c78df@gmail.com>
References: <20240130-rk-dts-additions-v2-0-c6222c4c78df@gmail.com>
 <20240130-rk-dts-additions-v2-4-c6222c4c78df@gmail.com>
Message-ID: <400e19a3f7b2de674a1db457b675233f@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Alexey,

On 2024-01-30 19:21, Alexey Charkov wrote:
> This introduces additional OPPs that share the same voltage as
> another OPP already present in the .dtsi but with lower frequency.
> 
> The idea is to try and limit system throughput more gradually upon
> reaching the throttling condition for workloads that are close to
> sustainable power already, thus avoiding needless performance loss.
> 
> My limited synthetic benchmarking [1] showed around 3.8% performance
> benefit when these are in place, other things equal (not meant to
> be comprehensive though).

I'm fine with this two-patch approach, so this important new feature
can be merged quicker, hopefully in the current merge window.  We can
add more OPPs later, after the additional testing is performed, of
course if all checks out as expected.

> [1] 
> https://lore.kernel.org/linux-rockchip/CABjd4YxqarUCbZ-a2XLe3TWJ-qjphGkyq=wDnctnEhdoSdPPpw@mail.gmail.com/T/#me92aa0ee25e6eeb1d1501ce85f5af4e58b3b13c5
> 
> Signed-off-by: Alexey Charkov <alchark@gmail.com>
> ---
>  arch/arm64/boot/dts/rockchip/rk3588s.dtsi | 87 
> +++++++++++++++++++++++++++++++
>  1 file changed, 87 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> index af8b932a04c1..506676985a7e 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> @@ -360,6 +360,21 @@ cluster0_opp_table: opp-table-cluster0 {
>  		compatible = "operating-points-v2";
>  		opp-shared;
> 
> +		opp-408000000 {
> +			opp-hz = /bits/ 64 <408000000>;
> +			opp-microvolt = <675000 675000 950000>;
> +			clock-latency-ns = <40000>;
> +		};
> +		opp-600000000 {
> +			opp-hz = /bits/ 64 <600000000>;
> +			opp-microvolt = <675000 675000 950000>;
> +			clock-latency-ns = <40000>;
> +		};
> +		opp-816000000 {
> +			opp-hz = /bits/ 64 <816000000>;
> +			opp-microvolt = <675000 675000 950000>;
> +			clock-latency-ns = <40000>;
> +		};
>  		opp-1008000000 {
>  			opp-hz = /bits/ 64 <1008000000>;
>  			opp-microvolt = <675000 675000 950000>;
> @@ -392,6 +407,27 @@ cluster1_opp_table: opp-table-cluster1 {
>  		compatible = "operating-points-v2";
>  		opp-shared;
> 
> +		opp-408000000 {
> +			opp-hz = /bits/ 64 <408000000>;
> +			opp-microvolt = <675000 675000 1000000>;
> +			clock-latency-ns = <40000>;
> +			opp-suspend;
> +		};
> +		opp-600000000 {
> +			opp-hz = /bits/ 64 <600000000>;
> +			opp-microvolt = <675000 675000 1000000>;
> +			clock-latency-ns = <40000>;
> +		};
> +		opp-816000000 {
> +			opp-hz = /bits/ 64 <816000000>;
> +			opp-microvolt = <675000 675000 1000000>;
> +			clock-latency-ns = <40000>;
> +		};
> +		opp-1008000000 {
> +			opp-hz = /bits/ 64 <1008000000>;
> +			opp-microvolt = <675000 675000 1000000>;
> +			clock-latency-ns = <40000>;
> +		};
>  		opp-1200000000 {
>  			opp-hz = /bits/ 64 <1200000000>;
>  			opp-microvolt = <675000 675000 1000000>;
> @@ -422,6 +458,21 @@ opp-2208000000 {
>  			opp-microvolt = <987500 987500 1000000>;
>  			clock-latency-ns = <40000>;
>  		};
> +		opp-2256000000 {
> +			opp-hz = /bits/ 64 <2256000000>;
> +			opp-microvolt = <1000000 1000000 1000000>;
> +			clock-latency-ns = <40000>;
> +		};
> +		opp-2304000000 {
> +			opp-hz = /bits/ 64 <2304000000>;
> +			opp-microvolt = <1000000 1000000 1000000>;
> +			clock-latency-ns = <40000>;
> +		};
> +		opp-2352000000 {
> +			opp-hz = /bits/ 64 <2352000000>;
> +			opp-microvolt = <1000000 1000000 1000000>;
> +			clock-latency-ns = <40000>;
> +		};
>  		opp-2400000000 {
>  			opp-hz = /bits/ 64 <2400000000>;
>  			opp-microvolt = <1000000 1000000 1000000>;
> @@ -433,6 +484,27 @@ cluster2_opp_table: opp-table-cluster2 {
>  		compatible = "operating-points-v2";
>  		opp-shared;
> 
> +		opp-408000000 {
> +			opp-hz = /bits/ 64 <408000000>;
> +			opp-microvolt = <675000 675000 1000000>;
> +			clock-latency-ns = <40000>;
> +			opp-suspend;
> +		};
> +		opp-600000000 {
> +			opp-hz = /bits/ 64 <600000000>;
> +			opp-microvolt = <675000 675000 1000000>;
> +			clock-latency-ns = <40000>;
> +		};
> +		opp-816000000 {
> +			opp-hz = /bits/ 64 <816000000>;
> +			opp-microvolt = <675000 675000 1000000>;
> +			clock-latency-ns = <40000>;
> +		};
> +		opp-1008000000 {
> +			opp-hz = /bits/ 64 <1008000000>;
> +			opp-microvolt = <675000 675000 1000000>;
> +			clock-latency-ns = <40000>;
> +		};
>  		opp-1200000000 {
>  			opp-hz = /bits/ 64 <1200000000>;
>  			opp-microvolt = <675000 675000 1000000>;
> @@ -463,6 +535,21 @@ opp-2208000000 {
>  			opp-microvolt = <987500 987500 1000000>;
>  			clock-latency-ns = <40000>;
>  		};
> +		opp-2256000000 {
> +			opp-hz = /bits/ 64 <2256000000>;
> +			opp-microvolt = <1000000 1000000 1000000>;
> +			clock-latency-ns = <40000>;
> +		};
> +		opp-2304000000 {
> +			opp-hz = /bits/ 64 <2304000000>;
> +			opp-microvolt = <1000000 1000000 1000000>;
> +			clock-latency-ns = <40000>;
> +		};
> +		opp-2352000000 {
> +			opp-hz = /bits/ 64 <2352000000>;
> +			opp-microvolt = <1000000 1000000 1000000>;
> +			clock-latency-ns = <40000>;
> +		};
>  		opp-2400000000 {
>  			opp-hz = /bits/ 64 <2400000000>;
>  			opp-microvolt = <1000000 1000000 1000000>;

