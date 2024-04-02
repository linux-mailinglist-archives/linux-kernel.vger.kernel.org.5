Return-Path: <linux-kernel+bounces-127370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E3C894A6B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 06:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7ACCC1C21E99
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 04:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65CE917BBA;
	Tue,  2 Apr 2024 04:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sUAsZe9J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A218B17721;
	Tue,  2 Apr 2024 04:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712031867; cv=none; b=HJv618cfL0fcePe1hNFxIAJ7ZbY+FXqpd1do1bVjITJRkoVFfNg5xHDUWs5go8CwngLoXuhYPfIMlqW3MN/Imh7o+6ReUfI5H/6U7s1/MhZ49tvqRPQetk62Z7yULYOKCHqIYChknzTvgG2SPD35DBe2BGBNG4la1S6nkLC1x84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712031867; c=relaxed/simple;
	bh=geEcctVkFaVS6+KbDswFswc/zT6m5w/FixnNGT1kRRs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lJoX3ZUuO7hyI3Gxinm98qNSSaaYaFzchUu6MctM/Aj13cCVjsWrWlgyDvpxwLVasqvdH/UaTqQV7GhL44961mIVjGxMG0be8F8CBdTAvI0VrPfBTcFgiiypL2mr0cIYA4lkXAUT7kE4abyl15JGxdwClXS6+U403fRjXxSX9p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sUAsZe9J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D85C1C433C7;
	Tue,  2 Apr 2024 04:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712031867;
	bh=geEcctVkFaVS6+KbDswFswc/zT6m5w/FixnNGT1kRRs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sUAsZe9JtF5+UaYzHQzoIhH7EQuEEI/jmR0ygDW8jmcI0gzWMYnhbrNVLxVo3TLSy
	 CAqAJ0cnkiXpOMS7E06JzHWQWCqGDy8ielQjGcCuL6I3dLeSjrGlVd/WLkkOQgu6P7
	 ErMTeDPKj2C7dYT00K/zgdlOdjtkTV8R+pSfxyl2YiEdeUXMI7JNTb79wWbUyYyHs5
	 VRRZLelu/x82qIg8NnpSoPRPslQ14Ylp6weXX8/k/oCma2/ACgtTAIrzmVjS8n7mdz
	 xJx0T4oDGVVjyFe1TySJW0XE8ZF/EB/ZmvMmlgTjHFnicjJZ+aaeq3qEj9Nnh5nQ3j
	 6KOjH1ag4efow==
Date: Mon, 1 Apr 2024 21:24:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Louis Peens <louis.peens@corigine.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, oss-drivers@corigine.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] nfp: Avoid -Wflex-array-member-not-at-end
 warnings
Message-ID: <20240401212424.34a9a9cd@kernel.org>
In-Reply-To: <ZgYWlkxdrrieDYIu@neat>
References: <ZgYWlkxdrrieDYIu@neat>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 Mar 2024 19:17:10 -0600 Gustavo A. R. Silva wrote:
> --- a/drivers/net/ethernet/netronome/nfp/nfp_net_debugdump.c
> +++ b/drivers/net/ethernet/netronome/nfp/nfp_net_debugdump.c
> @@ -34,8 +34,11 @@ enum nfp_dumpspec_type {
>  
>  /* generic type plus length */
>  struct nfp_dump_tl {
> -	__be32 type;
> -	__be32 length;	/* chunk length to follow, aligned to 8 bytes */
> +	/* New members must be added within the struct_group() macro below. */
> +	struct_group_tagged(nfp_dump_tl_hdr, hdr,
> +		__be32 type;
> +		__be32 length;	/* chunk length to follow, aligned to 8 bytes */
> +	);
>  	char data[];
>  };

I counted 9 references to nfp_dump_tl->data.
Better to add:

static void *nfp_dump_tl_data(struct nfp_dump_tl *spec)
{
	return &spec[1];
}

and delete the flex array completely.
-- 
pw-bot: cr

