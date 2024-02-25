Return-Path: <linux-kernel+bounces-79980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE7D862923
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 06:04:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BD6CB20F2B
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 05:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B61944C;
	Sun, 25 Feb 2024 05:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JFNtONFw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477CB8F49;
	Sun, 25 Feb 2024 05:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708837463; cv=none; b=HzUbeU3h3+SYFzUVrrVwK/8zZD1ro9bL5lvk/T1m/ERa/SlQKUh40O8yDdR6VMDtU9J8l+TGNxW6exe1fRXmkVYZX7qe1MCHIgGPlWjVxtndQq7MrE/eD4BwIUT/NhkMjFZZ43d+iLrd9kSoS770GnCWP0Cu967jhRB3UaGkVKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708837463; c=relaxed/simple;
	bh=PdNwwCg558iqeuTBDu5R3JB3xjnvzCi/WTZ16LnG+gc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e/Bl5YHpgYshEXg2zn/BWfSB29WW2hUHp1h8YHCqNhwy9ekpOEfCh8bjU4JRYbhc/Q6tZLsPrL2FoFAlUxO81kAwUpj2PmXR1sMJgdiIDh8DrNGhxquT3JUcLmKmRmOM4FgRV6Np6QY1RYUyW9sQoyveJdR2/LHJjfYWuwNYwUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JFNtONFw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF383C433F1;
	Sun, 25 Feb 2024 05:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708837462;
	bh=PdNwwCg558iqeuTBDu5R3JB3xjnvzCi/WTZ16LnG+gc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JFNtONFwjEAKdwMsHzGHg9Iwgkh+n8EOxliWq7Z0IAO3MP8tEwNnCmRHRGR+2VmWz
	 DfZ2qwieEFPlzzVNk9oEg8brQWd7EBgGMeJlNwNamB3G6NeXKccm4YZWiUxdn9IfW+
	 6ooHfrLDTN7f6Wf21NXzb3ATc5La4ET0znmZpuudSnNJy1AWG+VLF4cUXbny7FcPvB
	 44BtBrnhtQdU07Nngp/W/dqRKMTLT48zpDsTt5uk3djs0N1jY7x5rt+DO3PHVUPwTm
	 DNtCNgJs43EPRihLDgbeNEYKcfwPrC/tgc1NlDAQAfkbky1moJGqU9nkoG4w9ZFzsv
	 LkUfU93EmDDRQ==
Date: Sat, 24 Feb 2024 23:04:20 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: David Collins <quic_collinsd@quicinc.com>
Cc: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Subbaraman Narayanamurthy <quic_subbaram@quicinc.com>
Subject: Re: [PATCH] dt-bindings: nvmem: qcom,spmi-sdam: update maintainer
Message-ID: <u2z42cj2jlq6wf4ke3d3qxyoycy7lcqqgjjhcym3xudy3vck3s@vk7gkfl6rbpk>
References: <20240223232955.1907552-1-quic_collinsd@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223232955.1907552-1-quic_collinsd@quicinc.com>

On Fri, Feb 23, 2024 at 03:29:55PM -0800, David Collins wrote:
> Emails to Shyam bounce (reason: 585 5.1.1 <sthella@codeaurora.org>:
> Recipient address rejected: undeliverable address: No such user here.)
> so change the maintainer to be me.  I work on qcom,spmi-sdam as well
> as other PMIC peripheral devices.
> 
> Signed-off-by: David Collins <quic_collinsd@quicinc.com>

Thanks David!

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

Regards,
Bjorn

> ---
>  Documentation/devicetree/bindings/nvmem/qcom,spmi-sdam.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/qcom,spmi-sdam.yaml b/Documentation/devicetree/bindings/nvmem/qcom,spmi-sdam.yaml
> index 068bedf5dbc9..5d7be0b34536 100644
> --- a/Documentation/devicetree/bindings/nvmem/qcom,spmi-sdam.yaml
> +++ b/Documentation/devicetree/bindings/nvmem/qcom,spmi-sdam.yaml
> @@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  title: Qualcomm Technologies, Inc. SPMI SDAM
>  
>  maintainers:
> -  - Shyam Kumar Thella <sthella@codeaurora.org>
> +  - David Collins <quic_collinsd@quicinc.com>
>  
>  description: |
>    The SDAM provides scratch register space for the PMIC clients. This
> -- 
> 2.25.1
> 

