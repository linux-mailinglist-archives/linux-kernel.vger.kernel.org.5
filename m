Return-Path: <linux-kernel+bounces-132985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7879C899CE8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A75101C211DA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 12:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95E216C861;
	Fri,  5 Apr 2024 12:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cI1UkXGw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2349816C68C;
	Fri,  5 Apr 2024 12:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712320211; cv=none; b=h+soNJ0NX0CYk8Y4OJbetJpZRVGV6DP3myggj0w4bBlmFRegeLLExXRqWwKspdWRxsSkgbIYzASuyIDHp5Toa8O64R8TKn0Q1DQRWnkwGBBLkiXTZp9GTlbv991P7WCTPAcyFIySveJQ7Qsq/bnWEJ8dPAl+KxBXbwg4Cn1vhX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712320211; c=relaxed/simple;
	bh=8lQhM8JxUd/FKcBbaU5GpGkfXWulPr2jKxFBOayt09U=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=END5o1MW3QqTsiTnfZ8xRofRcj4d/WZzuiSAkxKo1p9Kq17KKGCDPf0zdEZU6syKUQQtDsAVAFpd3uZMvDQwd2KxQhPA2v6pkoCyiEcKJccX4Q5NSaTzjqqrVkrOL2GP/s19SfpSlq3EpKsIDGOU1wXEso04wE5+oxvMYjq42hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cI1UkXGw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B8ADC433F1;
	Fri,  5 Apr 2024 12:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712320209;
	bh=8lQhM8JxUd/FKcBbaU5GpGkfXWulPr2jKxFBOayt09U=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=cI1UkXGwKUFRepIYAsCkN9V3fri3x/30GDAeNheZRIYwH5PUtoN7fMFOa7Pe8FoAH
	 6yFlhKIYmHXiDh6UfMY1JkkuH95uCFoPPiYlO4DQwGvEDlIv1qc5LWx2kzGZlnIONa
	 XfLRUqNFqI9tYqRkhvDdq+AGJmNlRNpL0cPxt+IApOof20+6sJvQkw3EQPwNGSjRb1
	 8csCsxIeF7PIpgozJUSIVeSXpDvlz/HyBEtxTjEh7RSioqC0kTGK2nZGGI/8WONRT8
	 dKzgoWlDg4m+5ryJSBBn1XUgv6CtG90hrVNTX/WQDrWzy+gyC7MKRAHseljc9sGa3f
	 7Z5jStf7zlpwg==
Message-ID: <6d2cf4d9-0b6d-4fb2-a130-7695baa118c3@kernel.org>
Date: Fri, 5 Apr 2024 07:30:07 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] arm64: dts: stratix10: socdk: drop unneeded flash
 address/size-cells
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240401141025.98125-1-krzk@kernel.org>
Content-Language: en-US
From: Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20240401141025.98125-1-krzk@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/1/24 09:10, Krzysztof Kozlowski wrote:
> Flash node uses single "partition" node to describe partitions, so
> remove deprecated address/size-cells properties to also fix dtc W=1
> warnings:
> 
>    socfpga_stratix10_socdk.dts:182.10-211.4: Warning (avoid_unnecessary_addr_size): /soc@0/spi@ff8d2000/flash@0: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>   arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
> index 26173f0b0051..4eee777ef1a1 100644
> --- a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
> +++ b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
> @@ -180,8 +180,6 @@ rtc@68 {
>   &qspi {
>   	status = "okay";
>   	flash@0 {
> -		#address-cells = <1>;
> -		#size-cells = <1>;
>   		compatible = "micron,mt25qu02g", "jedec,spi-nor";
>   		reg = <0>;
>   		spi-max-frequency = <100000000>;

All patches applied!

Thanks,
Dinh

