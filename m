Return-Path: <linux-kernel+bounces-146866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F9D8A6C0F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 483BE1C21ADC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 13:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD52712C534;
	Tue, 16 Apr 2024 13:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PcQvRfl1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14A612BF29;
	Tue, 16 Apr 2024 13:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713273687; cv=none; b=cj2y/ToxzWuDME2+m0FzRBOTZjmFJfh0ElmDAmPAyI5H41l1uZGMSsR0DDUwEU+hmKxL0kuNnko+k0vs5cyI5Pz6So5XnzN8JnA7X5oQ6Za7lU7A/o9soibO6gcoJRCpM0XJR2STUy7ml99I6JYKmQ0oerEiCphL1DvFquJWN/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713273687; c=relaxed/simple;
	bh=Z3szNAXs6ookddwvTqDP6loCkEgNjGn9QA3Y5AYjnD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JuXX28ezK8ONdgZtjeS4TKaePu4uPlHp0x39BH2SHzjA9alscDPlbnwHWdScOTkUQ2rHYtuJy31SSMW4KWFXFdEdhLPK4B//hUcNlq4p63/fdNsWhLqUWWCteALvAldx8ZweXx/t7+ctf+OrAwOaL40BXJ0AJtKWCjNb+UPe2r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PcQvRfl1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15684C113CE;
	Tue, 16 Apr 2024 13:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713273686;
	bh=Z3szNAXs6ookddwvTqDP6loCkEgNjGn9QA3Y5AYjnD4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PcQvRfl1PF1/Kl0BySnWfDqHKFK5MwmrpmyHjJdHuGazVgbWmowxihz+X9Z1ydyV6
	 WQwFGwvxMPYCFMDwvHitP9bfrnn9N/7OWL8rLRe5hIU1QXetQ+FqBXTf6M2L4Es/Gq
	 Y9Uvtb+U4nABOQ7FuBRAouvHSMziyxKaXAxvPocg6z7de6skX9QVzplTjqVDgcejaV
	 I66+RuWPA40e0Y6inNySzxwOIYy1MEG1ji1fso7X3LWcACj4yWBuFTNHMYiWzkkYBU
	 ie+0XMkKGuWj6Fmr6h93aoRpaG72qvwsuGwhFTatP8S1nnqSBW8GAV6CnYSx7l+HEV
	 6Fxj87lCsurdg==
Date: Tue, 16 Apr 2024 08:21:24 -0500
From: Rob Herring <robh@kernel.org>
To: Robert Marko <robimarko@gmail.com>
Cc: kvalo@kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	jjohnson@kernel.org, linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	ath11k@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: net: wireless: ath11k: add
 ieee80211-freq-limit property
Message-ID: <20240416132124.GA2143558-robh@kernel.org>
References: <20240412162510.29483-1-robimarko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412162510.29483-1-robimarko@gmail.com>

On Fri, Apr 12, 2024 at 06:24:08PM +0200, Robert Marko wrote:
> This is an existing optional property that ieee80211.yaml/cfg80211
> provides. It's useful to further restrict supported frequencies
> for a specified device through device-tree.
> 
> Signed-off-by: Robert Marko <robimarko@gmail.com>
> ---
>  .../devicetree/bindings/net/wireless/qcom,ath11k.yaml          | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
> index 672282cdfc2f..907bbb646614 100644
> --- a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
> +++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
> @@ -55,6 +55,8 @@ properties:
>        phandle to a node describing reserved memory (System RAM memory)
>        used by ath11k firmware (see bindings/reserved-memory/reserved-memory.txt)
>  
> +  ieee80211-freq-limit: true
> +

Drop this and change additionalProperties to unevaluatedProperties.

>    iommus:
>      minItems: 1
>      maxItems: 2
> @@ -88,6 +90,7 @@ required:
>  additionalProperties: false
>  
>  allOf:
> +  - $ref: ieee80211.yaml#
>    - if:
>        properties:
>          compatible:
> -- 
> 2.44.0
> 

