Return-Path: <linux-kernel+bounces-62471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0559852152
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 23:21:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D455284071
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 22:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC51C4E1CC;
	Mon, 12 Feb 2024 22:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jHGa4s3w"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AF1481D0;
	Mon, 12 Feb 2024 22:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707776472; cv=none; b=p4cFkZoi9fwWKsloACUqEgmpTJLnzx70xx0QXVWbsWfoURTDlJl4g5DHe7owp5gcSj9cm5j3z+9PMkpyfjEEb2xE/9uULWZ2Mad/Uw4n2c5yvTwKHS3cyx3koauivUEej+g4423FBUtbCxFW/AbjaUGL6VhRCt/9y4lFujxBdwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707776472; c=relaxed/simple;
	bh=BwZIUGw5rwhWZMHBntEgD6evsLiGKtlOXbv6xGs3Uik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IAawfu3dv1GDmtvo/UkJ2uiuQ3YkEq+rGk4yLB+4xTMY7IuwE8Ius/tFw8g0ZHgNzQnj3ZRbg2E9r9jLJyz/X4Z9+Jqnblek9eRhITOpDnXFYWEan5gxtA3DNN4rbZh02pbM4Q1Cuz/sAGuhQxLq2xIdZhVmqc+MqmMy+F3f4Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jHGa4s3w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CBEDC433C7;
	Mon, 12 Feb 2024 22:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707776471;
	bh=BwZIUGw5rwhWZMHBntEgD6evsLiGKtlOXbv6xGs3Uik=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jHGa4s3wLIvyZ48+8ZoMXJbUOtFhN9/WKiYUycimjDaa2jWq4/Q2rYPoHosSdpXYe
	 N33HualANFR1t/5b+2s16ERLdJ/OrqHCM+cYGKIiW5m/3jB8OZ7knyxvOd2gf1ATD3
	 9cYMzBDpYXHp4t6Yvilvj9RtzBeAD3WsZunRKiOI+x66eUtnmrZCUG7JQKz4v6OZVT
	 +BJE0jUdYqRgd7Md7z9O1qhUkUfwe5V6F4w/wBsPR6UTn2yDM0YlZhv2fa1YiOTFxG
	 6tf7FsPXip19YfYwCnnDF3RfGwsxZaV8o/EMI6+1V2zWKutRMwCVBliPNOExtBhkYF
	 SgK/lAKFauqtw==
Date: Mon, 12 Feb 2024 16:21:09 -0600
From: Rob Herring <robh@kernel.org>
To: David Wronek <davidwronek@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Avri Altman <avri.altman@wdc.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Andy Gross <agross@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
	linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-phy@lists.infradead.org,
	~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v4 3/8] dt-bindings: phy: Add QMP UFS PHY compatible for
 SC7180
Message-ID: <20240212222109.GA2655166-robh@kernel.org>
References: <20240121-sm7125-upstream-v4-0-f7d1212c8ebb@gmail.com>
 <20240121-sm7125-upstream-v4-3-f7d1212c8ebb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240121-sm7125-upstream-v4-3-f7d1212c8ebb@gmail.com>

On Sun, Jan 21, 2024 at 05:57:43PM +0100, David Wronek wrote:
> Document the QMP UFS PHY compatible for SC7180
> 
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: David Wronek <davidwronek@gmail.com>
> ---
>  Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml
> index 8474eef8d0ff..5faa1cb3a12e 100644
> --- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml
> @@ -19,6 +19,7 @@ properties:
>        - qcom,msm8996-qmp-ufs-phy
>        - qcom,msm8998-qmp-ufs-phy
>        - qcom,sa8775p-qmp-ufs-phy
> +      - qcom,sc7180-qmp-ufs-phy

This doesn't match what you put in the dts which is adding to the 
warnings:

     51  phy@1d87000: compatible: ['qcom,sc7180-qmp-ufs-phy', 'qcom,sm7150-qmp-ufs-phy'] is too long
     51  phy@1d87000: clock-names: ['ref', 'ref_aux'] is too short
     48  phy@1d87000: clocks: [[39, 97], [39, 103]] is too short
     30  phy@1d87000: 'power-domains' is a required property


>        - qcom,sc7280-qmp-ufs-phy
>        - qcom,sc8180x-qmp-ufs-phy
>        - qcom,sc8280xp-qmp-ufs-phy
> @@ -102,6 +103,7 @@ allOf:
>            contains:
>              enum:
>                - qcom,msm8998-qmp-ufs-phy
> +              - qcom,sc7180-qmp-ufs-phy
>                - qcom,sc8180x-qmp-ufs-phy
>                - qcom,sc8280xp-qmp-ufs-phy
>                - qcom,sdm845-qmp-ufs-phy
> 
> -- 
> 2.43.0
> 

