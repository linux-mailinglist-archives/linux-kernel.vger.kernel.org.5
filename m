Return-Path: <linux-kernel+bounces-44657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61EC7842591
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 13:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02E721F27C8F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADCA66D1B8;
	Tue, 30 Jan 2024 12:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PNSyGueO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F139D4C66;
	Tue, 30 Jan 2024 12:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706619394; cv=none; b=FGIaEHgYpnGrc1v5eUvnGq3iMDTCvc7bJ36/2UGyvwTkDIp/HeVmVeN6p4ppxcZUZF/BECVz8o6uv3mnSPKjzRFIQWXYQ8/RLXrxALvB62O6IyPLcPMU8Sski4bUqh9gMPbjWRmVqz933954WK3Lb2D0tNlTty+1lwQVyjiN3VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706619394; c=relaxed/simple;
	bh=KyR7sOxAPLedpIOOlfHHGt22ct4nPdqlIF9BevqnKro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CMAMTYMQ2Bho+FofPPOUH7i3AcXoSd/bZa7vnSMlvv0kNw/PWhtiD9slNfGOYDdjgmOIKAyI8Z10W55iptiMZD/3dCaz3Z8ISoSq34DVWIUwYbhsVGg+9bVL/N8cHYg/ybJdh38f56kWqnSGbJotc3VRRFm8vn8rTkFPzaYCBWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PNSyGueO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECD76C433C7;
	Tue, 30 Jan 2024 12:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706619393;
	bh=KyR7sOxAPLedpIOOlfHHGt22ct4nPdqlIF9BevqnKro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PNSyGueOWv2YlvGHF4OVhqnENEd3qZxOE0FX9gdqbTfvYkXnROqSXm6fBWfOUsQOK
	 B+X/etxGlp1YWvdkZmO3bMFN82mbxcIdt40myoKN+sYml7rLuYlSkP1sPlYezKYpcV
	 PpEkLdY7cnxuAwhGbYcWFuXYiNndLSg7Em53rvVbcH+GPxneodK9eJE5d07O3RREZ7
	 4YHJeWuie5s4nHpA7DyUEBFV6UgDa/buJU70O81sjM3hFrAs3dzE6fbddimeDLVrkb
	 uRXVD6Ey3623nfC55F95kgkRCKHTg/x/+CLIHhiggMoc4KNCsa3h7B3rtxd91/3jRP
	 WLZBXOzHCAQug==
Date: Tue, 30 Jan 2024 12:56:26 +0000
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
	edumazet@google.com, Timur Tabi <timur@kernel.org>,
	Subash Abhinov Kasiviswanathan <quic_subashab@quicinc.com>,
	Sean Tranchetti <quic_stranche@quicinc.com>, dsahern@kernel.org,
	weiwan@google.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 04/10] net: fill in MODULE_DESCRIPTION()s for Qualcom
 drivers
Message-ID: <20240130125626.GC351311@kernel.org>
References: <20240125193420.533604-1-leitao@debian.org>
 <20240125193420.533604-5-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125193420.533604-5-leitao@debian.org>

On Thu, Jan 25, 2024 at 11:34:14AM -0800, Breno Leitao wrote:
> W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
> Add descriptions to the Qualcom rmnet and emac drivers.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Reviewed-by: Subash Abhinov Kasiviswanathan <quic_subashab@quicinc.com>

Reviewed-by: Simon Horman <horms@kernel.org>


