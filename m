Return-Path: <linux-kernel+bounces-49186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1DA8466EE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 05:19:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9889B1F28AEE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 04:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D840F504;
	Fri,  2 Feb 2024 04:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K2fbX+ZD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF5FE54E;
	Fri,  2 Feb 2024 04:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706847572; cv=none; b=HLgbQhEzs0MBQb5NClCBjDrZNC8eNVXrxVsXvDVgzv9JJ2jjyJ5f7ztvawGu+sqPjdJEoFJ8DbzyJNcDadN74iovNV9Krmcas2+9M0Gf1yM5U/ASOCpOD8H/yJcQrS8f5R/wJBpybJgefWId62HNe486DqU6k+03JvrXc6IolIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706847572; c=relaxed/simple;
	bh=Hsaci8eNHL5sCPud5AdQaD6AoTiXQ5sgZOkV48/5tlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t4THSap1IeSPYQAno3XkpqntGPkDIHkTQINxZ4TGr8CMmDgt+yxS75y+AcS4vh0Mmtq5CuZ2jD42l7UgiBmjaIOC/NFffeepAz0wwh+cDOx1ohXsFpMXMUz7NBrDGc95R4g+nExTnKzXgxz6rFA6xz1iMokNoeOfl2lGfYyjqnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K2fbX+ZD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3794FC433F1;
	Fri,  2 Feb 2024 04:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706847572;
	bh=Hsaci8eNHL5sCPud5AdQaD6AoTiXQ5sgZOkV48/5tlQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K2fbX+ZDawG+pTe/dHzRjicmwbwT55cluW0LcgLXO9aJQs0byHi//hj5ULjPGmS+V
	 4qhKJ/dAqRX4MvWJRJ2q2O2mz2iU/TA+tRnRdfWYVPKGRbfkvGWtgfP9CZ49Oh6ik0
	 H3MPaMEpK6hWmgu9GJfVcADThCTwLQiKLbLWWocD7jagQIK3+OxAVHh5qJRpmcbrN6
	 qUWU7AY6Mr7ySMxHc7OBK5zEK6t2TKl1HMumgS0SwT/WG3h0X7SIa1rbPm2fUJd4ie
	 5cTZtl5J+U9wyO2x4IWwqKoi3+y8IHj8ONP/HXSsyGbV41BrQo46FntiNKo1QJSMRL
	 9VRgN4ajcIk9A==
Date: Thu, 1 Feb 2024 22:19:29 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: thermal-zones: Don't require
 polling-delay(-passive)
Message-ID: <jdif7y5wrapwkqrgmmzzifypn72m6752ac2rdw2m3jemsl6f47@effnmveiqhbh>
References: <20240125-topic-thermal-v1-0-3c9d4dced138@linaro.org>
 <20240125-topic-thermal-v1-1-3c9d4dced138@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125-topic-thermal-v1-1-3c9d4dced138@linaro.org>

On Thu, Jan 25, 2024 at 01:11:15PM +0100, Konrad Dybcio wrote:
> Currently, thermal zones associated with providers that have interrupts
> for signaling hot/critical trips are required to set a polling-delay
> of 0 to indicate no polling. This feels a bit backwards.
> 
> Assume 0 (no polling) when these properties are not defined.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

> ---
>  Documentation/devicetree/bindings/thermal/thermal-zones.yaml | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
> index dbd52620d293..68398e7e8655 100644
> --- a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
> +++ b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
> @@ -228,8 +228,6 @@ patternProperties:
>              additionalProperties: false
>  
>      required:
> -      - polling-delay
> -      - polling-delay-passive
>        - thermal-sensors
>        - trips
>  
> 
> -- 
> 2.40.1
> 

