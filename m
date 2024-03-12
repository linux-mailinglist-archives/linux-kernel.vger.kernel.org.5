Return-Path: <linux-kernel+bounces-100387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F278796B1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:45:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C931D1F218C2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 14:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26597B3E7;
	Tue, 12 Mar 2024 14:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SqOYlm/L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8801DFD8;
	Tue, 12 Mar 2024 14:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710254739; cv=none; b=le82WwRVKlNb5XJ9dbfYMH5cMbg4hL2iv1QjMvLGlEkaimT1iMMEDT2OXq+Qe/l4pIsXXbxngFowztUm6EcpZrCagyFUE45BoYfiylZACdtolsEmMx9To0HJxaaPtHy0vxd8BrFY9ZUe59xIAf8TR/Dde6rB6YV3EhUOjOmVJf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710254739; c=relaxed/simple;
	bh=+QAC9uxxOUEhwDUHpjQ9myV2dLb80WvIj6nsEkr40gQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N06pjo2cB8+khpgqtmDUa4BCz6pMUnG6ORYcYd6TwBA7o9NgyOzEVbZuoT+/KrW+3V1VBC17r46YwPH3f4UZwyp9DBVap6vAvMHR5yCkX/boC06d0cgkpddGNN8GOkHCyuhwzXAkRepUGxvUh7GeU3zLjqH96Np8X6Be02r6N1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SqOYlm/L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43C9BC43394;
	Tue, 12 Mar 2024 14:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710254738;
	bh=+QAC9uxxOUEhwDUHpjQ9myV2dLb80WvIj6nsEkr40gQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SqOYlm/LGWP3q+aR/hSoTRMygHA1mtV9kVzr8kFGxSk+IwTvqB7mMDWNd10Z0y1kH
	 J5ZT7V4ZAgb2lDiwPlrv1gHcYClUOkGgJgowGv+lA1xhwuzgnMa1aHNGYTSuVSmLy6
	 HxC7vs/snvg+/ZMVRMTKinieaibhal2Ugr+COhvJoGiy311Zcep4F9MQDbm/kgXHwk
	 nGVHIwtrThtoMCFFbMtsepO0gb+2MQoM3BEpfuzD4AWdNsBMMpTxzSbRwNJfbLNGeL
	 0dh5e+1ELc2EY5eFaplK7yemiRP8DAbt38wEJt7ZiwMuaX0m2LYnlT4JdUx7jeZXWj
	 XZDN2UV/kzlUQ==
Date: Tue, 12 Mar 2024 07:45:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: David Miller <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Networking <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
 Tariq Toukan <tariqt@nvidia.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the net-next tree
Message-ID: <20240312074537.2c327a9d@kernel.org>
In-Reply-To: <20240312153304.0ef1b78e@canb.auug.org.au>
References: <20240312153304.0ef1b78e@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Mar 2024 15:33:04 +1100 Stephen Rothwell wrote:
> After merging the net-next tree, today's linux-next build (htmldocs)
> produced this warning:
> 
> Documentation/networking/multi-pf-netdev.rst:94: ERROR: Unexpected indentation.
> Documentation/networking/multi-pf-netdev.rst:106: ERROR: Unexpected indentation.

Sorry to ask basic questions during the merge window, but what version
of sphinx do you use?  The warnings generated seem to depend rather
heavily on the version :(

