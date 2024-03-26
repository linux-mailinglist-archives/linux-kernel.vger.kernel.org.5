Return-Path: <linux-kernel+bounces-119790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36DA088CD17
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:23:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1A65B216C6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E167713D26D;
	Tue, 26 Mar 2024 19:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eCe7TINc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C68713C9AA;
	Tue, 26 Mar 2024 19:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711480836; cv=none; b=GODNIc3nUICnOzdK/2Pc2k60xOVnEzy1hvZn6rulvJJMzTUZ+D5VglSD7GorO0rs4sljDZZjInzk77JISf7VvzMI+Qxs6CurlQWFDyuE08CvxemSpIR7+JEiyRELo7NggOgffNTKVNvsMDFCdBFHZxTdBOvHNt/4OjTWOmOMrVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711480836; c=relaxed/simple;
	bh=4pVK3zwjf7q3/wKz/a7Bedi8s68WPvTFAqBMDraigKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QkFAkhKg8/RyslwDBqhWxGenhgjSDYCVvk1yNLnHQnUnWScHOlJIOz+j3+iR8eCrHdJBXRGwzx12cfaQQttChqYfpXMFEfKriQ9nokGByyskAjhopQfkzssVloNLmsn9WZ1JInTeQdBMvNGq6YiMj077jRAfgFZujIZ2Z2uQsGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eCe7TINc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86D96C433F1;
	Tue, 26 Mar 2024 19:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711480835;
	bh=4pVK3zwjf7q3/wKz/a7Bedi8s68WPvTFAqBMDraigKc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eCe7TINcTy+1o3JIqbJXojYzmEPUcxoZurMQyELBJWt8YFZgezRoZSdmSfAx7Ld1O
	 3ycKqWa8N9qaPE0ErPQXt1k27L7joNAi+NeF4foSMdiEWCa+cSsmDWjHocv6i96k5K
	 2mE3w2jmK9iTcfibNmDuC63Z16znTCwoBIKjNRDY0vD8YVPZab27rnIBrmjfKGgstT
	 aMdylAK4/cnlGsHHZtPHb9z7p1pmzhZY6gD4ysH9OaEnoTDICtBALUwcqNSrpXBU6T
	 wdjFDMSWTHhS1Rv6l/63LTR6lTW7Ce7RolYpaTBw+3L7IGgg8ORXExxJgDGTJ6xRaF
	 g+Fsa2Leg36Fg==
Date: Tue, 26 Mar 2024 14:20:33 -0500
From: Rob Herring <robh@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Baruch Siach <baruch@tkos.co.il>, linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v3 0/4] dt-bindings: rtc: convert multiple devices to
 dtschema
Message-ID: <20240326192033.GA3240297-robh@kernel.org>
References: <20240326-rtc-yaml-v3-0-caa430ecace7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326-rtc-yaml-v3-0-caa430ecace7@gmail.com>

On Tue, Mar 26, 2024 at 02:03:22PM +0100, Javier Carrasco wrote:
> This series converts the following existing bindings to dtschema:
> 
> - armada-380-rtc
> - alphascale,asm9260-rtc
> - digicolor-rtc (moved to trivial-rtc)
> - nxp,lpc1788-rtc
> 
> All bindings include at least one compatible that is referenced in the
> existing dts (arch/arm). Those dts could be tested against the new
> bindings.
> 
> It might be worth mentioning that the reference to nxp,lpc1788-rtc in
> arch/arm/boot/dts/nxp/lpc/lpc18xx.dtsi also includes another compatible
> called nxp,lpc1850-rtc, which is not documented or supported by existing
> drivers. That generates a warning when testing against nxp,lpc1788-rtc.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
> Changes in v3:
> - alphascale-asm9260-rtc: drop unnecessary reg description.
> - nxp,lpc1788-rtc: drop unnecessary reg description.
> - Link to v2: https://lore.kernel.org/r/20240325-rtc-yaml-v2-0-ff9f68f43dbc@gmail.com
> 
> Changes in v2:
> - General: reference to rtc.yaml
> - digicolor-rtc: move to trivial-rtc
> - Link to v1: https://lore.kernel.org/r/20240323-rtc-yaml-v1-0-0c5d12b1b89d@gmail.com
> 
> ---
> Javier Carrasco (4):
>       dt-bindings: rtc: armada-380-rtc: convert to dtschema
>       dt-bindings: rtc: alphascale,asm9260-rtc: convert to dtschema
>       dt-bindings: rtc: digicolor-rtc: move to trivial-rtc
>       dt-bindings: rtc: nxp,lpc1788-rtc: convert to dtschema

Reviewed-by: Rob Herring <robh@kernel.org>

