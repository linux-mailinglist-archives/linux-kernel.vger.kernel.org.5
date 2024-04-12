Return-Path: <linux-kernel+bounces-143278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD968A36A9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 21:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 065E5287A89
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 19:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A721509B9;
	Fri, 12 Apr 2024 19:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="gpteDel6";
	dkim=permerror (0-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="5caQbqJE"
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6214E14EC4E;
	Fri, 12 Apr 2024 19:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712951979; cv=pass; b=tM02eqSb0VXaU5aseqDfndC4vmK/DfD1l3sZPRySJSKEghbYm0IsV7w+79SCv/uilQ3/lAQNvQx71jCIqhnCTnwFZgsUULP3NBfpYUF2rJr9fzISIO15n8dO3EVJGBf+PvIT0HG6aFw7M3KGa+b3mpLkxf/wZzqdeNAK4c6FdMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712951979; c=relaxed/simple;
	bh=9GILyS5wOQePaTKkVr8cMkodqWg8VGVjdnrVrcN1rW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c1nm87q+sp2g+CV3VmLD3GgnE+08gH9pWgSTcAElVZ63ha8tp6nMgPMYDYiECeoeFzYKGl6RtrpWTcXb5S76Qn2AKyg/ifHQzg0xEdOSluX+eXpeh8pmkgycbmOkm+lNR+pG/vJXsoHzAAsoXK81PXIn3sRNIH80GpWKXMIJP4g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gerhold.net; spf=none smtp.mailfrom=gerhold.net; dkim=pass (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b=gpteDel6; dkim=permerror (0-bit key) header.d=gerhold.net header.i=@gerhold.net header.b=5caQbqJE; arc=pass smtp.client-ip=85.215.255.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gerhold.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=gerhold.net
ARC-Seal: i=1; a=rsa-sha256; t=1712951603; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=mXyGqxePBmd8lepTK9pbK2hPDvbmzxqP0x17Md01t23w2aU7a5WkCyRHk1r/1usGiH
    FX1oxFNvY/JCYdHn/28AN8z3OwDjmngIxWPyghO5ntAPLnEo/xA8jYtkZkmOZsO7ic13
    C8z8DLohWxvChxLviNf24oeUSzd8w1bq3CLQSHY7X01aa1YrI0WZXbqnQHgjX8lKRiBK
    H3GFTa696yq0mBsep4FP+NSibjrmSwqkNGIP95uEUvyP5P9Nc8Awr09LqtRE2l6XW0LI
    OJF7tNzLn27AgpJc60ivEkp1ZmSDjjn+8kCjaW/O95fUNYRX+yy8Kb8RpyVEjlJP8VSs
    Vfww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1712951603;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=FhdLnrYDB2Gbpoa3iA3B4bHJbBtO20mT/yS1LRQLe4o=;
    b=TRhtcnenJDtY7Ywd7qaePVOa/MlvA+jL4MBT/8FcsbHJDGj99IDVgKDNVo9/oA38MS
    1m3ZjXHtxjpT12QbrNb976NX9JiV9nctmeJhwIxtXzW1N+yAo/8FZT5bDwueE4c1ET0s
    7KHgowHbNlhGUnEY3F8UTIofU7GQikxoNwIviT1jTLOk0SFlOvvtY/kqGG3ds9XIDCPY
    bOJLM4T5KAde+qGHNj5BqdMORRYV3JPUu5OsicFlQ4Ll8osh4BqfbWDXFjOCZINdTDOf
    1jPpQTdSFqzcLgFhrxjtKq2hW6xsWkP3IBNVJVpTKRTvkOvDsk+ZHD3Z/FYi+a3tVeiB
    8qkg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1712951603;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=FhdLnrYDB2Gbpoa3iA3B4bHJbBtO20mT/yS1LRQLe4o=;
    b=gpteDel69DQ0ThyZf+szYkf4LEln0Uw1Gu4zbWYDyHCJnQEWy5jUlX4CPTTz5q1eS4
    //3LzhIGq9zSuCyyC3ffb0DSD2qUhYe0i6rd7nNwpz4cwe2xrFmG6AxZClI4KrpJlNU8
    sFfhvxXp5YibwGMPOZMEaR3yZyIBBw+5y4LnUEU2xu/RcxW6Na6OVZ1I9t+sxvXKbe0R
    TfVZdfAOtgtiwx7HTL7+pqVh9BqkvFctfT16uMo1WYxT/fKjTr/UdaviSwD11VaDMR24
    B3NN2KUSOaLabW2uzlQd13cOWFeRAHUUoLP9pxfHgValNPsZil+ElxGhcfEjZ4/aEBlG
    rWnA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1712951603;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=FhdLnrYDB2Gbpoa3iA3B4bHJbBtO20mT/yS1LRQLe4o=;
    b=5caQbqJEeEmju7YbfP7/x+LNKYr7C1dExLHSFFtXhfpc4JddZWWvOctbNhJhcsdsEh
    r2UB+9Dx32Fzfgp3yLBw==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4paA+p3h"
Received: from gerhold.net
    by smtp.strato.de (RZmta 50.3.2 DYNA|AUTH)
    with ESMTPSA id Raf12503CJrModL
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 12 Apr 2024 21:53:22 +0200 (CEST)
Date: Fri, 12 Apr 2024 21:53:16 +0200
From: Stephan Gerhold <stephan@gerhold.net>
To: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
Cc: "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] arm64: dts: qcom: sa8155p-adp: lower min volt for
 L13C regulator
Message-ID: <ZhmRJPAZUSlc1CSH@gerhold.net>
References: <20240412190310.1647893-1-volodymyr_babchuk@epam.com>
 <20240412190310.1647893-2-volodymyr_babchuk@epam.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412190310.1647893-2-volodymyr_babchuk@epam.com>
Content-Transfer-Encoding: 7bit

On Fri, Apr 12, 2024 at 07:03:26PM +0000, Volodymyr Babchuk wrote:
> Voltage regulator L13C is used by SD card IO interface. In order to
> support UHS modes, IO interface voltage needs to be set to 1.8V. This
> patch extends minimum voltage range of L13C regulator to allow this.
> 

I think this one also deserves a Fixes and stable tag. One could argue
that enabling UHS modes is a new "feature" but I would say the original
commit just missed setting the correct voltages with the intended use
case. I doubt limiting to high speed was intended.

Maybe also add a Suggested-by tag from myself:

Fixes: 0deb2624e2d0 ("arm64: dts: qcom: sa8155p-adp: Add support for uSD card")
Cc: stable@vger.kernel.org
Suggested-by: Stephan Gerhold <stephan@gerhold.net>

I believe you do not need to resend just to add these tags, the b4 tool
should pick them up while applying. It looks like this might not work
for the Cc: stable tag though...

Thanks,
Stephan

> Signed-off-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
> ---
>  arch/arm64/boot/dts/qcom/sa8155p-adp.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8155p-adp.dts b/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
> index b2cf2c988336c..9e9c7f81096bb 100644
> --- a/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
> +++ b/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
> @@ -283,7 +283,7 @@ vreg_l12c_1p808: ldo12 {
>  
>  		vreg_l13c_2p96: ldo13 {
>  			regulator-name = "vreg_l13c_2p96";
> -			regulator-min-microvolt = <2504000>;
> +			regulator-min-microvolt = <1800000>;
>  			regulator-max-microvolt = <2960000>;
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  		};
> -- 
> 2.44.0

