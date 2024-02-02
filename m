Return-Path: <linux-kernel+bounces-49230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F216846776
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 06:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A231E1F256E3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 05:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8336C17548;
	Fri,  2 Feb 2024 05:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="BOansGLb"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2275517542;
	Fri,  2 Feb 2024 05:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706851023; cv=none; b=lJHw1gjD3Ot+FSLXaFkuQcqDJ7Mw28rNvKsiqWgU4Xezfy1ljUm6P5OuJAudzdWidgLasNMTJSqC10unDLkvplv01rda+AdoQ0VKkxRWASUoD7T+Gggqa3sKnQ9EsHbKWdkY4E99mQgL7Gji7NQisFlqOEKWYb2/CdZxxAgSn4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706851023; c=relaxed/simple;
	bh=dHm09GNtAQ2D5sNCYJ7iD1RuUoD5DGkS1Dcuyf8S2fI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=P5eK5QsU3vGEXIfqu8jwtlSrLayzh/fQgiJ0vQPPTz51ORAOXKf8SLBn3rR/AC/m3HYNtL5LlaOSNxarJ814R5h7INwcx0JfYcgozU3+DrvcLpuaGHpbKvjvIx91WIXEbTrjV+bGZDmhlX0UayaknZCb6gNaYQqHyGLxQhgpvnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=BOansGLb; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4125Gn7i037161;
	Thu, 1 Feb 2024 23:16:49 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706851009;
	bh=IvxmV9lEPY/8G0b8lAVHaGNoeanSp86mJODbUj2A1FU=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=BOansGLbUbpYZmnKOoA9BKLBVSRYSluxUiFFdAHS6fcmsV/mfJwL8GuoBRRKN3F2y
	 yYOikfBUXVlpRG5aSVNbsKcHh9lsTRkgKPdbq4mqz1P64e6LLhIQlGrwi17J/yDZXz
	 deMoPM65P7xT2J/wtaj5115oR7CPkawGh+Lb/0UQ=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4125GnAl048864
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 1 Feb 2024 23:16:49 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 1
 Feb 2024 23:16:49 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 1 Feb 2024 23:16:49 -0600
Received: from [10.249.136.17] ([10.249.136.17])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4125GWfg041656;
	Thu, 1 Feb 2024 23:16:34 -0600
Message-ID: <92d7de31-2c14-469d-8da8-11bb70ea2707@ti.com>
Date: Fri, 2 Feb 2024 10:46:32 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v2] arm64: dts: ti: k3-am69-sk: remove
 assigned-clock-parents for unused VP
Content-Language: en-US
To: Jayesh Choudhary <j-choudhary@ti.com>, <tomi.valkeinen@ideasonboard.com>,
        <nm@ti.com>, <vigneshr@ti.com>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <rogerq@kernel.org>, <sabiya.d@ti.com>,
        <u-kumar1@ti.com>, <eballetbo@redhat.com>
References: <20240201142308.4954-1-j-choudhary@ti.com>
From: Aradhya Bhatia <a-bhatia1@ti.com>
In-Reply-To: <20240201142308.4954-1-j-choudhary@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 01-Feb-24 19:53, Jayesh Choudhary wrote:
> VP2 and VP3 are unused video ports and VP3 share the same parent
> clock as VP1 causing issue with pixel clock setting for HDMI (VP1).
> The current DM firmware does not support changing parent clock if it
> is shared by another component. It returns 0 for the determine_rate
> query before causing set_rate to set the clock at default maximum of
> 1.8GHz which is a lot more than the maximum frequency videoports can
> support (600MHz) causing SYNC LOST issues.
> So remove the parent clocks for unused VPs to avoid conflict.
> 
> Fixes: 6f8605fd7d11 ("arm64: dts: ti: k3-am69-sk: Add DP and HDMI support")
> Reported-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
> Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

Reviewed-by: Aradhya Bhatia <a-bhatia1@ti.com>

Regards
Aradhya

> ---
> 
> v1: <https://lore.kernel.org/all/20231221113042.48492-1-j-choudhary@ti.com/>
> 
> Changelog v1->v2:
> - Updated commit message
> - Picked up Tomi's R-by from v1
> - Removed "Closes:" link since its invalid now
> 
> (NOTE: Sending again as forgot to put mailing list in cc earlier)
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

