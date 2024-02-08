Return-Path: <linux-kernel+bounces-58233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F185D84E33B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 15:31:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 303111C2181F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 14:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCEBE79948;
	Thu,  8 Feb 2024 14:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ImokAwqW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE959200D2;
	Thu,  8 Feb 2024 14:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707402707; cv=none; b=sO9K9V0Kvm0Uj6gMRul8+SO/Oq7ahm5oSEYyvzpxEFr+xc9H5Tiauz9WvJSS1LMFXckiI/GuQsWAi8tWDMnvBz/V32zx4yECg//CqLPDSX0b0ZQ8Wca0DuhQM3csy6Yiwd59Nh6U3C7Q7+AIlC4RFpWGdcGNSFlaA8yR24WK8os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707402707; c=relaxed/simple;
	bh=I3KyQ/QgQFzOr93h4IxaJwGTFCBd9ZOO9qHDg18SGoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iMJ2WFBikFo4xmmLgowhHu6vl3Y4XuHxoQpte6V2fnLWhkjHl6EE6iq5CUjjLBeziRJ1FgqrlXadUKajRMi7Xkyp0TjNdISOZifpoYLDo69aGrIaOXg9OCaWQlFn1YbPOuOCuDArvSeeJbtfGF6h0BuoBi6RcO0Ip5y0vRLGPzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ImokAwqW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8952CC433C7;
	Thu,  8 Feb 2024 14:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707402706;
	bh=I3KyQ/QgQFzOr93h4IxaJwGTFCBd9ZOO9qHDg18SGoM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ImokAwqW4mjomuflcDGQ5wTs+rZrsZbysZrBjqs+5J6rAc65rq21Cr3zh1nGuq2u8
	 sHztjKgok5lVULu1IW+yvPMBHUvAlbBOdVwyjdZnfUqIFN5Ug4SaNZVOV8cUldeA2w
	 yd33VvLQ9uXzdCpuaJFFB7Tz6osCDiNTGYHCwh9ndpnBrb6IGKX3HqEGINWKCqSPOI
	 CsS/CXnO1IVhttIm0yvrwS4uf0k2Z0RQizZ2Cb0x16lC5RsAZaKNtnHBPYP34JyCbv
	 T1iC4plsm9N/9Z00I0wdqW9xh2Uh0ZyaH1Em896Id/DkmkF0GMMnk8+DoAVT0kMQLh
	 CatFU53NuZlkA==
Date: Thu, 8 Feb 2024 14:31:40 +0000
From: Lee Jones <lee@kernel.org>
To: Jeffrey Hugo <quic_jhugo@quicinc.com>
Cc: daniel.thompson@linaro.org, jingoohan1@gmail.com, pavel@ucw.cz,
	robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, andersson@kernel.org, quic_kgunda@quicinc.com,
	dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: backlight: qcom-wled: Fix bouncing email
 addresses
Message-ID: <20240208143140.GU689448@google.com>
References: <20240202180151.4116329-1-quic_jhugo@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240202180151.4116329-1-quic_jhugo@quicinc.com>

On Fri, 02 Feb 2024, Jeffrey Hugo wrote:

> Bjorn is no longer at Linaro.  Update his email address to @kernel to
> match the .mailmap entry.
> 
> The servers for @codeaurora are long retired and messages sent there
> will bounce.  Update Kiran's email address to match the .mailmap entry.
> 
> This will help anyone that is looking to reach out about this binding
> and is not using .mailmap to pre-process their message.
> 
> Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
> ---
>  .../devicetree/bindings/leds/backlight/qcom-wled.yaml         | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/leds/backlight/qcom-wled.yaml b/Documentation/devicetree/bindings/leds/backlight/qcom-wled.yaml
> index 5f1849bdabba..a8490781011d 100644
> --- a/Documentation/devicetree/bindings/leds/backlight/qcom-wled.yaml
> +++ b/Documentation/devicetree/bindings/leds/backlight/qcom-wled.yaml
> @@ -7,8 +7,8 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  title: Qualcomm Technologies, Inc. WLED driver
>  
>  maintainers:
> -  - Bjorn Andersson <bjorn.andersson@linaro.org>
> -  - Kiran Gunda <kgunda@codeaurora.org>
> +  - Bjorn Andersson <andersson@kernel.org>
> +  - Kiran Gunda <quic_kgunda@quicinc.com>
>  
>  description: |
>    WLED (White Light Emitting Diode) driver is used for controlling display

Applied, thanks

-- 
Lee Jones [李琼斯]

