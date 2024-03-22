Return-Path: <linux-kernel+bounces-111655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89BC0886F1F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:54:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C48FD281E65
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 14:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01284AED9;
	Fri, 22 Mar 2024 14:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W+mHBCAJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F264779E;
	Fri, 22 Mar 2024 14:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711119280; cv=none; b=gOda1HcuE4y9NlJdQDV6d9ousvVYkVGThZ5CKoFlq9TLDcb+swyTdbFaErydq9zf/+N5WbWmw0ElV6Tt9qP3Lf+GvzMMuLSREmpPnr5qwVFyfp5a1FSljEN/ft/YpY8rpBeVRkPt1VPG91gdC/S6UgMTcz6NIXzNFwGZ5Syhe3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711119280; c=relaxed/simple;
	bh=NAzmBK4W7ut3ePVFamFE0yUIy8iW7ofJ062itP751+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NDzyWZ0l6D6F0BM/4CekqRAOh+4LPBlRzo0TUv8qyS9Tv2O7g8UugBOOBYTqsyODxoiDCS7ECOGQFU/9xa5LnNWw1u/3iIYu/+5EMJ16X7/clw6YGU9eG87IbHF1YEoKZhr7SiJrGRU60L6bwLPReo5faD/F9hcCEw9pPnCMMqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W+mHBCAJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7583BC433C7;
	Fri, 22 Mar 2024 14:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711119279;
	bh=NAzmBK4W7ut3ePVFamFE0yUIy8iW7ofJ062itP751+4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W+mHBCAJAnE4kdCrnzH1xerDDfQPHKQIWBW74W8/BF6clSqt2cH/EXg1VEI2cTp+W
	 65+SFkR43Z+YBUnLhw0ejCrZ5m56LysOz1dCz7BFcDYnVsgCNcIKjvXl2v9te4qUxM
	 +8ze3eVPYLJMQf1SRmjD9BoxIF8Zoua4rumJGUlf1bNZxW8aK86sNAVKmge71R1odV
	 NGHIjSYpAIJmbJCJ1SAy1HJL5gtkEsWYlongCOUIk2E0/7GF8Zxg3WJfGjhU2SH9qk
	 HQywpx3wxwgtTR6bXoREAn/Ud139VXpG56MVgJBT4x1jFpsiGIgphX0vpw4N2A+hOX
	 lIQYXyxrBPl4Q==
Date: Fri, 22 Mar 2024 09:54:37 -0500
From: Rob Herring <robh@kernel.org>
To: INAGAKI Hiroshi <musashino.open@gmail.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	lee@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	linux-leds@vger.kernel.org, pavel@ucw.cz, conor+dt@kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: leds: add LED_FUNCTION_SPEED_* for link
 speed on LAN/WAN
Message-ID: <171111927468.885822.4599184890388891198.robh@kernel.org>
References: <20240320124431.221-1-musashino.open@gmail.com>
 <20240320124431.221-3-musashino.open@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240320124431.221-3-musashino.open@gmail.com>


On Wed, 20 Mar 2024 21:43:17 +0900, INAGAKI Hiroshi wrote:
> Add LED_FUNCTION_SPEED_LAN and LED_FUNCTION_SPEED_WAN for LEDs that
> indicate link speed of ethernet ports on LAN/WAN. This is useful to
> distinguish those LEDs from LEDs that indicate link status (up/down).
> 
> example:
> 
> Fortinet FortiGate 30E/50E have LEDs that indicate link speed on each
> of the ethernet ports in addition to LEDs that indicate link status
> (up/down).
> 
> - 1000 Mbps: green:speed-(lan|wan)-N
> -  100 Mbps: amber:speed-(lan|wan)-N
> -   10 Mbps: (none, turned off)
> 
> Signed-off-by: INAGAKI Hiroshi <musashino.open@gmail.com>
> ---
>  include/dt-bindings/leds/common.h | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>


