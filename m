Return-Path: <linux-kernel+bounces-77133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E2E860189
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:36:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74512B28322
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C612548E4;
	Thu, 22 Feb 2024 18:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ENDhL9Lh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9AA5491E;
	Thu, 22 Feb 2024 18:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708626276; cv=none; b=T+2iN2ZTW784Bnk9qWa7sY6/5nRIo1G/afk5I/hM6Zk9K5PnO6arFPskDOevD0l/7D9WR+yJJY7M7Yr1niVfVvNEDl7/JJHuCTPeUECSumXcM87/aLBx2Tz4CtyEwhRVJBvxN92/T3HcJwdLPvhyFgryYMhBj7eOQOlq5HJdO90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708626276; c=relaxed/simple;
	bh=x42gYfFIle5hMZRh275TRKsrYsjhPinQRyYzAvbClLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zb/ZkJZ6S7ampiTDUk5HWB7p27St4g3A3EXzET4vauMhtYKBaaZzUmU94NvH5cVWZ2bnOWSoXuGAl7tigxi6VVkh7FTEiP1RCZOMBn75nR7su7VF8JzTpdFwJlyeOgLiSOw9zTEZ7dX8f/8bncBz7lGPBZgXlpEA7RuHfGUI9B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ENDhL9Lh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43084C433C7;
	Thu, 22 Feb 2024 18:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708626274;
	bh=x42gYfFIle5hMZRh275TRKsrYsjhPinQRyYzAvbClLc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ENDhL9Lh247wVsy1yzU4AHQUn/r2Ra+9U5W5T1nwoWvQUHORHYW2dQJDMX6us/SsZ
	 Kf+MH+cHbgHt8DLocbrYtO7O8/GszCzgx1/Cjwro0PU7rhoF3iB1Bd1ee3pIKvyBSh
	 II4WRU5jieQ1yMD4OH3gJOxfef8bvwAPuqen1n9tw9uvrV7iNgwXXc2BTesd6/sFTe
	 PMxgrqel9tEJmKPhUC2FFSJkK9JWCWyBrjdg1sUfWylGyiJ+/wNJ3Ne9yvihrjmKf2
	 UDSHZ9YOyDhgdI/K/nh2yjVOWLlhTSdJ7KW2WRvaCMf9kwxhyWDGjUfBflwCi3aSWs
	 8pY9PbfPtjvEw==
Date: Thu, 22 Feb 2024 12:24:30 -0600
From: Rob Herring <robh@kernel.org>
To: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Cc: op-tee@lists.trustedfirmware.org,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	linux-stm32@st-md-mailman.stormreply.com,
	Rob Herring <robh+dt@kernel.org>, linux-remoteproc@vger.kernel.org,
	devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/7] dt-bindings: remoteproc: Add compatibility for
 TEE support
Message-ID: <170862626977.3652711.10744856298270939089.robh@kernel.org>
References: <20240214172127.1022199-1-arnaud.pouliquen@foss.st.com>
 <20240214172127.1022199-6-arnaud.pouliquen@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214172127.1022199-6-arnaud.pouliquen@foss.st.com>


On Wed, 14 Feb 2024 18:21:25 +0100, Arnaud Pouliquen wrote:
> The "st,stm32mp1-m4-tee" compatible is utilized in a system configuration
> where the Cortex-M4 firmware is loaded by the Trusted execution Environment
> (TEE).
> For instance, this compatible is used in both the Linux and OP-TEE
> device-tree:
> - In OP-TEE, a node is defined in the device tree with the
>   st,stm32mp1-m4-tee to support signed remoteproc firmware.
>   Based on DT properties, OP-TEE authenticates, loads, starts, and stops
>   the firmware.
> - On Linux, when the compatibility is set, the Cortex-M resets should not
>   be declared in the device tree.
> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> ---
> V1 to V2 updates
> - update "st,stm32mp1-m4" compatible description to generalize
> - remove the 'reset-names' requirement in one conditional branch, as the
>   property is already part of the condition test.
> ---
>  .../bindings/remoteproc/st,stm32-rproc.yaml   | 51 ++++++++++++++++---
>  1 file changed, 43 insertions(+), 8 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>


