Return-Path: <linux-kernel+bounces-8331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4782981B5C9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 13:28:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0194328604B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 12:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA23A6EB64;
	Thu, 21 Dec 2023 12:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="MWZwkPPr"
X-Original-To: linux-kernel@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538C46EB63;
	Thu, 21 Dec 2023 12:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BLCS68v015162;
	Thu, 21 Dec 2023 06:28:06 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1703161686;
	bh=5AimOjX8mVtl/H74cpa+H08a66kuDuPQZ9w/xBNEu9w=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=MWZwkPPr7eTZA4xXasV4hbZ43I5+TV/CtuF/ezXGIVUxv0/hwrXHdhfMv4pbWLhH+
	 zlDbHv7+MAcn45N4Z2JxuPbaXf0iem/7TMUHthDKUJJBTDQE/Tc2dXoJdZQihF/NCq
	 DuSn6Wr6AjdTKsJUuiwE7TOpa/+uAmy+1A394O50=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BLCS5Ch117361
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 21 Dec 2023 06:28:05 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 21
 Dec 2023 06:28:05 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 21 Dec 2023 06:28:05 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BLCS5gA090270;
	Thu, 21 Dec 2023 06:28:05 -0600
Date: Thu, 21 Dec 2023 06:28:05 -0600
From: Nishanth Menon <nm@ti.com>
To: Jayesh Choudhary <j-choudhary@ti.com>
CC: <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <a-bhatia1@ti.com>, <rogerq@kernel.org>, <sabiya.d@ti.com>,
        <u-kumar1@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] arm64: dts: ti: k3-am69-sk: remove
 assigned-clock-parents for unused VP
Message-ID: <20231221122805.3kl5mujtk2npvrmf@skiing>
References: <20231221113042.48492-1-j-choudhary@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231221113042.48492-1-j-choudhary@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 17:00-20231221, Jayesh Choudhary wrote:
> VP2 and VP3 are unused video ports and VP3 share the same parent
> clock as VP1 causing issue with pixel clock setting for HDMI (VP1).
> So remove the parent clocks for unused VPs.
> 
> Fixes: 6f8605fd7d11 ("arm64: dts: ti: k3-am69-sk: Add DP and HDMI support")
> Reported-by: Nishanth Menon <nm@ti.com>
> Closes: https://storage.kernelci.org/mainline/master/v6.7-rc6/arm64/defconfig/gcc-10/lab-ti/baseline-nfs-am69_sk-fs.txt
> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
> ---
> 
> Local testing log for HDMI on AM69-SK:
> <https://gist.github.com/Jayesh2000/517395cd85eb28d65b8ee4568cefb809>

Has this been always failing or just something introduced in rc6? I know
I noticed this in rc6.. so wondering..

> 
>  arch/arm64/boot/dts/ti/k3-am69-sk.dts | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am69-sk.dts b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
> index 8da591579868..370980eb59b0 100644
> --- a/arch/arm64/boot/dts/ti/k3-am69-sk.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
> @@ -918,13 +918,9 @@ &dss {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&dss_vout0_pins_default>;
>  	assigned-clocks = <&k3_clks 218 2>,
> -			  <&k3_clks 218 5>,
> -			  <&k3_clks 218 14>,
> -			  <&k3_clks 218 18>;
> +			  <&k3_clks 218 5>;
>  	assigned-clock-parents = <&k3_clks 218 3>,
> -				 <&k3_clks 218 7>,
> -				 <&k3_clks 218 16>,
> -				 <&k3_clks 218 22>;
> +				 <&k3_clks 218 7>;
>  };
>  
>  &serdes_wiz4 {
> -- 
> 2.25.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

