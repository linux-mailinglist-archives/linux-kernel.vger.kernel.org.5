Return-Path: <linux-kernel+bounces-56404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C0984C9C4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 12:41:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8A051F2171D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336551B7F2;
	Wed,  7 Feb 2024 11:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k7mU1ECL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725731B279;
	Wed,  7 Feb 2024 11:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707306078; cv=none; b=TD8FhlmsszOey8tJyNLcc1HgdGI+HUjmDDrBMgMKRabgnc2VTx4CNRERiWFEffLS5NbMp0ITGlpTzOdSoVHgfSSHhnWWm+9c+Pyk+efJE259zveEzt+UpzCKymAqqiPSJBIf+VUufU7jBNckNXTXvcIXy7s3Fg7eIdeNPBb+HJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707306078; c=relaxed/simple;
	bh=HfpUColuhJssCfS2Q4BxR9VCesP0GXEXyT3B8dCl9QE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MF2K0zpfQV1fOEsFRL/WGhrRJllUllCcG1pVNszUNILS4j+5nSEtGfYHI1OEFSljmA3e3lHZ63Jmx2V3l2Qe40x3V9LqjNdbTiu4jRiARxiU/tkVNhkEtc+gOXSPPZvADbIq/3cWC2WSxlcYuPfk6GZQmbsIbpefbCM22YgabOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k7mU1ECL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE37FC433F1;
	Wed,  7 Feb 2024 11:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707306078;
	bh=HfpUColuhJssCfS2Q4BxR9VCesP0GXEXyT3B8dCl9QE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k7mU1ECLLIrDpAzSw8hXR+CFpE2I/Lh+iGK04rGkSspNm15FyN9oIJdIAt97a8j/z
	 vt1AvBNnyO9md+4uAH4kWSfSm/x2s0+TxD4UPEKdwcFy9EiQ8q23D15TXbimZ98xoR
	 UnKVSPXyP4QfnfntN7z0N+ZpJVh2VMXP/uQXMtJVbutOKJf/UeWshEvPIckNGkGoso
	 DVbqjtpj4TOfp20CnCNqijsJcY2LuKpNvv2wKRmmpdY/s2tMDrnKB06MyIfOOIAisW
	 +W6DvFXXmm2X7yCNYWUJPlg+Hn8EXHYfvTT7XNTRSGUK4gKkMZvSlOJCtZ5TxoU+8J
	 JgKqkmLX5jppA==
Date: Wed, 7 Feb 2024 11:41:13 +0000
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
	edumazet@google.com,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, andrew@lunn.ch
Subject: Re: [PATCH net v2 1/9] net: fill in MODULE_DESCRIPTION()s for xfrm
Message-ID: <20240207114113.GF1297511@kernel.org>
References: <20240207101929.484681-1-leitao@debian.org>
 <20240207101929.484681-2-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207101929.484681-2-leitao@debian.org>

On Wed, Feb 07, 2024 at 02:19:20AM -0800, Breno Leitao wrote:
> W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
> Add descriptions to the XFRM interface drivers.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Simon Horman <horms@kernel.org>


