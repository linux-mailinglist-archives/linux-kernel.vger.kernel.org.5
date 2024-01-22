Return-Path: <linux-kernel+bounces-33072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C2AD83640D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 14:10:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2DEC1F247B8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 13:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FCE73CF57;
	Mon, 22 Jan 2024 13:10:00 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9763CF40;
	Mon, 22 Jan 2024 13:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705929000; cv=none; b=mtfYItS4u04J8BgkA/2ph6TAk4UbgqJxHcJoNBSAJTBpEE3pJdFB14M4mP29Q3xstAKJlMuHf8fiypPbB+TULZEgUKDIoP92t2siOxHFnj2qk6J9GoHuqXAChyfmIHVzizo7OtvC4hgVoh845DdCGS3mDY9MRwSrNw+AXa+lGuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705929000; c=relaxed/simple;
	bh=xiwg7Y87YSwBeE2hph4rd1wAKocGZq7PkaQcX0urJGY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rRReokfqjEzYMDHMnOUMA7pcaWcjoc87NAksuEcjDoqhI/KVukJ3yYOaJg3NFejW7PMAdqS3Jom8Nxwo3dtVw9C9/BsOsuunHC/kUTEY93CbSYD7kxOEHixodl1VGYjfvH41apGhgjdR3Rl8/4S+WLzBDqGCV9buod9TRRMokzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875b8c.versanet.de ([83.135.91.140] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rRu3Z-00053L-9z; Mon, 22 Jan 2024 14:09:41 +0100
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Iskander Amara <iskander.amara@theobroma-systems.com>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Subject:
 Re: [PATCH v2] arm64: dts: rockchip: add missing definition of pmu io domains
 1 and 2 on ringneck
Date: Mon, 22 Jan 2024 14:09:40 +0100
Message-ID: <3388688.6M6d0yLqnL@diego>
In-Reply-To:
 <VI1PR04MB6013A6A65AF95BB80067E601D6752@VI1PR04MB6013.eurprd04.prod.outlook.com>
References:
 <20240103164734.1151290-1-iskander.amara@theobroma-systems.com>
 <VI1PR04MB6013A6A65AF95BB80067E601D6752@VI1PR04MB6013.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Iskander,

Am Montag, 22. Januar 2024, 13:17:50 CET schrieb Iskander Amara:
> Dear Ladies and Gentlemen,
> Is there any feedback about the patch below that you would like to share?

no feedback, change looks good.

I was mainly waiting for the merge-window to close, so that
I can get a nice 6.8-rc1 as base :-)

Heiko

> ________________________________
> From: Iskander Amara <iskander.amara@theobroma-systems.com>
> Sent: Wednesday, January 3, 2024 5:47 PM
> To: robh+dt@kernel.org <robh+dt@kernel.org>; krzysztof.kozlowski+dt@linaro.org <krzysztof.kozlowski+dt@linaro.org>; conor+dt@kernel.org <conor+dt@kernel.org>; heiko@sntech.de <heiko@sntech.de>; devicetree@vger.kernel.org <devicetree@vger.kernel.org>; linux-arm-kernel@lists.infradead.org <linux-arm-kernel@lists.infradead.org>; linux-rockchip@lists.infradead.org <linux-rockchip@lists.infradead.org>; linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>
> Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>; Iskander Amara <iskander.amara@theobroma-systems.com>
> Subject: [PATCH v2] arm64: dts: rockchip: add missing definition of pmu io domains 1 and 2 on ringneck
> 
> Two pmuio domains on ringneck are not defined:
>         1- PMUIO1: supplied by vcc_3v3 regulator(PMIC RK809)
>         2- PMUIO2: supplied by vcc_3v3 regulator(PMIC RK809)
> 
> The reason why no functional effect was observed is because of that
> the above mentionned PMUIO domains were supplied by a regulator
> which is always on.
> 
> So let's add their definition in the dtsi.
> 
> Signed-off-by: Iskander Amara <iskander.amara@theobroma-systems.com>
> ---
> v2:
>         - Fix indentation
>  arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi b/arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi
> index 12397755830b..bb1aea82e666 100644
> --- a/arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi
> @@ -347,6 +347,12 @@ pmic_int: pmic-int {
>          };
>  };
> 
> +&pmu_io_domains {
> +       pmuio1-supply = <&vcc_3v3>;
> +       pmuio2-supply = <&vcc_3v3>;
> +       status = "okay";
> +};
> +
>  &saradc {
>          vref-supply = <&vcc_1v8>;
>          status = "okay";
> --
> 2.34.1
> 
> 





