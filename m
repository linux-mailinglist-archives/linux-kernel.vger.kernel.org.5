Return-Path: <linux-kernel+bounces-69518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74AD9858A71
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 01:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 323F0289C3A
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 00:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7DE14901F;
	Fri, 16 Feb 2024 23:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CXh6xy/C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A401420B8;
	Fri, 16 Feb 2024 23:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708127952; cv=none; b=PZAD08I5HMX8uPfWrU0FSJsUEzOGD/LAruQH3PylDDuRsx3uviAODJHQYl8EFIqrD+HKs4Yxy1pl+JMPrhTWOeUNxnqwP7ie9Mey8Vn1H7QCVmKSc7V3O0PbkLg6V7Euhkzlp1T97JHBkTeX8qYjt0D9CCXnTDGMVBi2roOFJho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708127952; c=relaxed/simple;
	bh=ZdvWrXvxzIKYj+c7Aj3igkkKNWdmBtfejz7vWerTTzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UTMPu9fFYw+avPh7eG22cotwzzzd5dXTk3wgW5BiKb9q+FyY9d+yLBtvds+PUraJt9doV/Hd8mZtG3880cF5uQqQWPw3W3MFTGdYBW2Ev/wr2TEebcXfsipu2FzVYII7I6MZ8ohjL57WLXd2J3NhaNYYcdsjWWMR9VJ/gLaq+ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CXh6xy/C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ACAEC43390;
	Fri, 16 Feb 2024 23:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708127952;
	bh=ZdvWrXvxzIKYj+c7Aj3igkkKNWdmBtfejz7vWerTTzc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CXh6xy/CJOKmwSi4FQxltGUKjn97uJQreZHh4a+sZTub/SpUYtf06g5nP+v0kpVHz
	 HsfQ6HXAAHB7plIunXCZ4QPbQ2LVyqXSPacUb98gfD4ITl1GNYhQFH9A2kubZ3l3N9
	 lrR+M7aZXsWFHph/VoVLIcSq/qzoj+3NnZIl0qdpQKlKJz2teYntpWvrzrmDXuSqEU
	 G9KWcU90aF07pKKX691I/tUXlvmbwbCXRVMe2evgkn62tibXilY3dsmFfWZ7IPYe3z
	 S2RIYbSHSVc/N2+xgUKgKolFnSurOZm/LcQlAxJDRLWgDNCA5ciR46+7V9K/sn2csH
	 +G8SuqG1WRPQg==
Date: Fri, 16 Feb 2024 17:59:09 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, Robert Marko <robimarko@gmail.com>
Subject: Re: [PATCH v4 1/2] arm64: dts: qcom: ipq6018: add LDOA2 regulator
Message-ID: <cliph5zxla23bgguzk52ulxh6trl4qcggjg7hqvrg2d4qdh3a7@mq6fewwjfk2m>
References: <20240130130132.9550-1-amadeus@jmu.edu.cn>
 <20240130130132.9550-2-amadeus@jmu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130130132.9550-2-amadeus@jmu.edu.cn>

On Tue, Jan 30, 2024 at 09:01:31PM +0800, Chukun Pan wrote:
> Add LDOA2 regulator of MP5496 to support SDCC voltage scaling.
> 
> Suggested-by: Robert Marko <robimarko@gmail.com>
> Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
> ---
>  arch/arm64/boot/dts/qcom/ipq6018.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
> index 5e1277fea725..322eced0b876 100644
> --- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
> @@ -174,6 +174,11 @@ ipq6018_s2: s2 {
>  						regulator-max-microvolt = <1062500>;
>  						regulator-always-on;
>  					};
> +
> +					ipq6018_l2: l2 {

I still don't see a patch that does "something-supply = <&ipq6018_l2>;",
which would imply that the main thing this patch achieves is that the
regulator framework might turn the regulator off after a while.

Shouldn't there be a user of ipq6018_l2?

Regards,
Bjorn

> +						regulator-min-microvolt = <1800000>;
> +						regulator-max-microvolt = <3300000>;
> +					};
>  				};
>  			};
>  		};
> -- 
> 2.25.1
> 

