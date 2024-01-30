Return-Path: <linux-kernel+bounces-45333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D13B4842EA7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 22:29:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 102DD1C216B8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 21:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6253E78B5E;
	Tue, 30 Jan 2024 21:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q8ziWRqT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E08E762C7;
	Tue, 30 Jan 2024 21:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706650156; cv=none; b=bCc1fv1LYVnd36Tk/2jghMBW0zmdOiO8INeJxdQo4lkDbU8Jo/8X/iSpKHieVlFqFfGT8Q3LzU7TCqzqc5goNmCkoyXv/kc2Tr2HhJWNF9LbZKDAjuPKNQDutn1uSXJw4igK6b159KRAc6v3dxhaExzZvurby0ByOFr4c0c+o70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706650156; c=relaxed/simple;
	bh=htS2vi71gOQBI40lDiMqxxDjzh4dd9HyjhwVvwvSlpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SJwTLKQNqtqQwssXmjvjDxTkgNuSWh9BsLyOGqSXTFeU/8moOHnA4BlEVwmuCva024Hq/R4mSTRLnpwywJLfUaur0F33/d1GdrDuzuZK5TaL+daODTGL3tZQ4sUbZpzqGdJ94Xu8L08QonYrpLcVQnkjxw3VSTmuM3UTUXQSXJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q8ziWRqT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A927C433F1;
	Tue, 30 Jan 2024 21:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706650156;
	bh=htS2vi71gOQBI40lDiMqxxDjzh4dd9HyjhwVvwvSlpM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q8ziWRqTU1/k4ahFMKzw3ycKFIPnH4YRRmEJrRNGlwuYuDxo8WSFjfWw2K+G/yl2P
	 F8d/FjV0nTx28FtFg6jlh6CmgGXj8ae3k028J/DhpcX480GeSfXmgHhxN0t1ijLWqH
	 I0WlBdLWyOMVLgmSbCCncvCPYmTIbEvipENY2Bgi1SwrGRrf3SVJhfj3IUSzHjg411
	 PP5wo7Qn5f+MNopTKCoKE+bQSnDZq1aDogbY5hHTDJBrygBQElLMvQx2g1TySzI6MZ
	 dZaTX8R3LLkJe0u79X2uze3TQlgsdFKLi5YLYO0FsCdl/4E2Y6wxVal2R4auHViZNj
	 ktDDYqJJkqmSg==
Date: Tue, 30 Jan 2024 15:29:13 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Lucas Karpinski <lkarpins@redhat.com>
Cc: Andy Gross <agross@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: qcom: sa8540p-ride: disable pcie2a node
Message-ID: <mfdvit7jgr53qlhuedkrq6mtgjjmgfoejsuh6pgy6gusqq7vxq@rkufgqtht2ve>
References: <qcoqksikfvdqxk6stezbzc7l2br37ccgqswztzqejmhrkhbrwt@ta4npsm35mqk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <qcoqksikfvdqxk6stezbzc7l2br37ccgqswztzqejmhrkhbrwt@ta4npsm35mqk>

On Tue, Jan 09, 2024 at 10:20:50AM -0500, Lucas Karpinski wrote:
> pcie2a and pcie3a both cause interrupt storms to occur. However, when
> both are enabled simultaneously, the two combined interrupt storms will
> lead to rcu stalls. Red Hat is the only company still using this board
> and since we still need pcie3a, just disable pcie2a.
> 

Why are there interrupt storms? What interrupt(s) is(are) involved?

Do you consider this a temporary fix?

Are you okay with pcie3a misbehaving?

Regards,
Bjorn

> Signed-off-by: Lucas Karpinski <lkarpins@redhat.com>
> ---
> v2:
> - don't remove the entire pcie2a node, just set status to disabled.
> - update commit message.
> 
>  arch/arm64/boot/dts/qcom/sa8540p-ride.dts | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8540p-ride.dts b/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
> index b04f72ec097c..177b9dad6ff7 100644
> --- a/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
> +++ b/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
> @@ -376,14 +376,14 @@ &pcie2a {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pcie2a_default>;
>  
> -	status = "okay";
> +	status = "disabled";
>  };
>  
>  &pcie2a_phy {
>  	vdda-phy-supply = <&vreg_l11a>;
>  	vdda-pll-supply = <&vreg_l3a>;
>  
> -	status = "okay";
> +	status = "disabled";
>  };
>  
>  &pcie3a {
> -- 
> 2.43.0
> 

