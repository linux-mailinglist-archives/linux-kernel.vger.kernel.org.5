Return-Path: <linux-kernel+bounces-52998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB365849F52
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:16:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8593B1F235FF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD313A1A0;
	Mon,  5 Feb 2024 16:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ksIpgWxA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD4E182C3;
	Mon,  5 Feb 2024 16:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707149754; cv=none; b=Uhw6hZG/FCbGYi1H8/jm56OcyNnG43rkXM9NCs3IVeJpSBOcmZY67hMUpmGmS/kkLHj0jjDiSmAkWhBaQFfwog351w5smMAYFtnj9f2+l6RHupuw4dtIRJ6n7ciRD4Ycz0Xkq04gawynzw8I1iEjnYtFi//CA3ND2cLwVOnoKDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707149754; c=relaxed/simple;
	bh=pCLcOeuz7GM0qdBkeSN1ELKzmfqDZkh9BKSKdwWr5vM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tThCt/tOz1Fech7FViVbouEdQUqHtk1VD16jNIvcjbxuGD1ubkOe4yC7tjK54BLewQjawSjArBgdDlj5gwvVzZzIA3ZUbvjlz+INEizPcdFcIN7fVeDfU8tVxFbwGVRCmhuahFoEn2qx8tAfImLGm+lB73wQcOwPdvYwcieCHIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ksIpgWxA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6A6BC433F1;
	Mon,  5 Feb 2024 16:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707149753;
	bh=pCLcOeuz7GM0qdBkeSN1ELKzmfqDZkh9BKSKdwWr5vM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ksIpgWxAK/YRnmHJoWXterAu9SCQffFikp2LjIp8Iz8XAM4OWQ6gLfgrjKJhMwdFv
	 JgM/E453UyYYdndqpuIje3ScCEDbvasL1oBmJYF5HoOsKSD0LDXUXqDIxOH8pIWk9g
	 iVOwiOLzL13pqdzV/19KnJV+rh201HZ30bozYSYn/WEei+A1/ifhkaBODmBAIjOOyg
	 dBifWOYANu3c6k+kNAkf1WWrtQrHU1azak6q7dnmSpUz4KIqF7APWTkK1CA4wYNXj+
	 PfHysKfwDOLp0/2pixk5HMdB6UkXUYCXqvdMPnPJNaWH5Mr4vejNyLLokCXeT2Zl1O
	 k/RGzNjfQtrRg==
Date: Mon, 5 Feb 2024 16:15:49 +0000
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
	Peter Rosin <peda@axentia.se>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH] dt-bindings: mux: restrict node name suffixes
Message-ID: <170714974483.3420477.9317586688161818392.robh@kernel.org>
References: <20240109082511.15278-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240109082511.15278-1-krzysztof.kozlowski@linaro.org>


On Tue, 09 Jan 2024 09:25:11 +0100, Krzysztof Kozlowski wrote:
> Make the pattern matching node names a bit stricter to improve DTS
> consistency.  The pattern is restricted to -N suffixes to decimal
> numbers.
> 
> Suggested-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Some time ago I did such change treewide, but mux was left out:
> https://lore.kernel.org/all/20230530144851.92059-1-krzysztof.kozlowski@linaro.org/
> ---
>  Documentation/devicetree/bindings/mux/mux-controller.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!


