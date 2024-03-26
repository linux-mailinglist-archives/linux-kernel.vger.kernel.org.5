Return-Path: <linux-kernel+bounces-119710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE67988CC4F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:48:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 847B41F8198F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E061313C9AF;
	Tue, 26 Mar 2024 18:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dlFdgaNg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A00F13C9BA;
	Tue, 26 Mar 2024 18:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711478844; cv=none; b=H/0PB4jy16MIouLnVXWwWcg9bmLb8cMVL1NmraoOcS9q270VN0m2+QXMr8+tvkBMafzU0+2Mb1RiCqTR29mNtfq6eZcf1WUEoXgZSIO6I0lIaGKUOvXapvwcQTL+LNe4ulByKWD9JMPk9OI8yW5EgLr7XbGgv0VcfSOEDPT12Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711478844; c=relaxed/simple;
	bh=yLFy0pMPO69Aun53ynYkbVRY3qnekKy9hgrSlXDTycE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E2wdqXt5AtkA89KC32KmyAuk6TSAs6ILxY3wrJoC+DpNfw2CTMCixS7oqJmGq5Joxgg+PgNjyuyJIU8AuR2yGweLBDG7eUz5tcsL+0C4v5h35o6w1D6sgwM/1yPvtoamtV+cDFUx3A4VSV3npy6NPgMPV2biDB0Tcn/cMAjozDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dlFdgaNg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A6F2C433F1;
	Tue, 26 Mar 2024 18:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711478843;
	bh=yLFy0pMPO69Aun53ynYkbVRY3qnekKy9hgrSlXDTycE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dlFdgaNggHAXTZqWdWbnKDL1UXA99fQtbN0FOQ8fWhKdax3O+EMWQitF4TCJRcUO5
	 M1gB47L515GUJZ5Tu0GV+yHpHX2gCjlruRv7bvIs9yKGJZewGohmTugQCmaqcskUIT
	 qQhr1c3nLFrzDiNbCUgXPQiiVGCZwSHYrsycQzEROwmXX76diqjmhxgTiaonMILIXz
	 UFQI/7k+KMxbwhVRQlW3kwqfJa6021B5NhOvp+lW/YER9RoI2XOYb/XTSYTQHHgRTH
	 aX9MR/XIEVqIinSMxWZ6h1NerlF4szMTgCfuLN04plJULFSaVGUmDNQvwYj7E1GgVk
	 N9OhzT+o7Oe5g==
Date: Tue, 26 Mar 2024 13:47:21 -0500
From: Rob Herring <robh@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Baruch Siach <baruch@tkos.co.il>, linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-rtc@vger.kernel.org
Subject: Re: [PATCH v2 3/4] dt-bindings: rtc: digicolor-rtc: move to
 trivial-rtc
Message-ID: <171147884025.3182443.161090976508685252.robh@kernel.org>
References: <20240325-rtc-yaml-v2-0-ff9f68f43dbc@gmail.com>
 <20240325-rtc-yaml-v2-3-ff9f68f43dbc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325-rtc-yaml-v2-3-ff9f68f43dbc@gmail.com>


On Mon, 25 Mar 2024 22:10:10 +0100, Javier Carrasco wrote:
> Convert existing binding to dtschema to support validation.
> 
> This device meets the requirements to be moved to trivial-rtc
> (compatible, reg and a single interrupt).
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
>  Documentation/devicetree/bindings/rtc/digicolor-rtc.txt | 17 -----------------
>  Documentation/devicetree/bindings/rtc/trivial-rtc.yaml  |  2 ++
>  2 files changed, 2 insertions(+), 17 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>


