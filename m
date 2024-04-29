Return-Path: <linux-kernel+bounces-162685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0808E8B5EF4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 18:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D85E1F247AC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5357C84D22;
	Mon, 29 Apr 2024 16:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dcOav+33"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96498824AA;
	Mon, 29 Apr 2024 16:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714408040; cv=none; b=ke8uSIZ4m4e0NTHjL+bsbe/WD9a3TzbWIeH4Zx7cNUJn2bNKh8MiQpG/U7GBI8vcQH/k1G1MV2+9YFA49ZMquo7uLpOG/MorV6KydzW6PlYEpOSd/d7flUtcpfHq0cnxSUZI5sbr5ulnbk+BiALFomQX+In76IvA1Ld4AwN0+zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714408040; c=relaxed/simple;
	bh=WTd0PHYr8dkvTrJwQDiAv3Ks1lrKu1Q404pSYACa/oQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pTMhZzKSQFNf2jVvIXLVEThsIhCFmBIgNGKJIe3ECKxerOUVSCnrCWoffA/UBhcYm94Qw2zuOf8Y+veJNw+WwPA0lrBRIsueAt2epsQO2Vk0AfriK1DDBVL8/SdVMhfG2uqGsCRyqc4rAhkopvUxn80pI78JXPCxE2+KNFtwGRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dcOav+33; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A997C113CD;
	Mon, 29 Apr 2024 16:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714408040;
	bh=WTd0PHYr8dkvTrJwQDiAv3Ks1lrKu1Q404pSYACa/oQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dcOav+33Qgbmy4BeigepKEv8dt4PMFttVCJkpAoTlQ7VEeAS87P3GRp8kxroRALLU
	 MhX15hTdc1POlRN2YBmEOwthMYLiiAYKF5+kO4PeNIu4F18AnuX9btEH5FnHIsNx7a
	 FU0z/on3LFiHOq2kW8joRg15buD7JKPGTqQ5VZpzlVtgwI0NAwP6d4eAn3bz+veNp+
	 kZ8fK2fCTZFr2OVxAvKqWNCou35H8qGsVYieL+bzPzOEpbRbRea9GoYaEh1zzefw72
	 cEivk0sx3hrX/sbgF+ES4foRNoB/1OzPLRc2GkyGjmh2Q1JQXOKIinBAV8i5+g8LoS
	 OzVbVqv3TBaqw==
Date: Mon, 29 Apr 2024 11:27:17 -0500
From: Rob Herring <robh@kernel.org>
To: Shresth Prasad <shresthprasad7@gmail.com>
Cc: javier.carrasco.cruz@gmail.com, skhan@linuxfoundation.org,
	devicetree@vger.kernel.org, saravanak@google.com,
	linux-kernel@vger.kernel.org, Julia Lawall <julia.lawall@inria.fr>
Subject: Re: [PATCH][next] of: property: Use scope based cleanup on port_node
Message-ID: <171440802093.2111608.15033080205921005255.robh@kernel.org>
References: <20240428115226.41345-2-shresthprasad7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240428115226.41345-2-shresthprasad7@gmail.com>


On Sun, 28 Apr 2024 17:22:27 +0530, Shresth Prasad wrote:
> Use __free cleanup handler which ensures that the resource is freed when
> it goes out of scope, thus removing the need to manually clean it up
> using of_node_put.
> 
> Suggested-by: Julia Lawall <julia.lawall@inria.fr>
> Signed-off-by: Shresth Prasad <shresthprasad7@gmail.com>
> ---
> Rob Herring <robh@kernel.org> sent a patch fixing similar cases in
> property.c but seems to have missed this one. Please let me know if this
> is mistake, or if it was left unchanged for a reason.
> 
>  drivers/of/property.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 

Applied, thanks!


