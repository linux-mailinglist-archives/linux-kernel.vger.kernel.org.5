Return-Path: <linux-kernel+bounces-56408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3FAF84C9CE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 12:43:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53F211F21ACC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5021D6B6;
	Wed,  7 Feb 2024 11:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LxdpzG59"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C68C1B7E3;
	Wed,  7 Feb 2024 11:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707306123; cv=none; b=m+EBxKjE4ZkpnxiXwtsC90E3BhJ/kUeH4KqqQfqGgLs734XxkgsB816bGF8xw5+DWHduEkhKh7+m9hIeUFDIX5sYok/z3dy0uwbofHkwATy6XtM6Ttktj6bivDWs0cJ10bINpNgIvQISlZYnwsQY963jQDIKhz/GvADzF22YRyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707306123; c=relaxed/simple;
	bh=WeLleabRIJ066vxO+xTAe9illPobFPJYE1sN8fFSgd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pqMzcYRcCgTCqGe0VCK+K/ScL/lMa58CRo5nJDrMAMjwXYobI1oFsVao+x1vrEES7hXE9d7q3YXzvZjdUjAxqknuWzNvcwX1GPDnFTMdgBJljyeycCQou+nbUjKNlIS77o0UJ8HZ1RB4Qfo5QjeU9aRq2IVwavD0jGLQ6dvno40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LxdpzG59; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68122C433C7;
	Wed,  7 Feb 2024 11:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707306122;
	bh=WeLleabRIJ066vxO+xTAe9illPobFPJYE1sN8fFSgd8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LxdpzG59pK/JqcqJhdNqaahBrk9/MHIAzfMxgthVTzt0Bfs4KZsJTEm3pDaIVRvHh
	 JK3mEoCRwiqaFO/csmHTQCI7T2DA+vYRCKv+CZxBxOuptK13PKMoxV6rV+8fhW51g5
	 oEvIiCZA33i+xth8SHr2yFxTPMseGFdeYNFUic5OWeI7MuS3vCvY2muFsD7BRxpXqb
	 MHauKo5mb8yccrCAw04wbcNUc8JSPWCPv1wDhVQS3Kg0IWIYpVDcLRHoVodpmq0ynV
	 soAT4H09IlnpT+4DPyVRE3oYz1RgE7R9gZ0vNf16QKPiT4yUq8/1MF2OfcUfXyKaEd
	 /E2CBJnF1Q8PQ==
Date: Wed, 7 Feb 2024 11:41:58 +0000
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
	edumazet@google.com, Alexander Aring <alex.aring@gmail.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	andrew@lunn.ch,
	"open list:6LOWPAN GENERIC (BTLE/IEEE 802.15.4)" <linux-bluetooth@vger.kernel.org>,
	"open list:6LOWPAN GENERIC (BTLE/IEEE 802.15.4)" <linux-wpan@vger.kernel.org>
Subject: Re: [PATCH net v2 4/9] net: fill in MODULE_DESCRIPTION()s for 6LoWPAN
Message-ID: <20240207114158.GI1297511@kernel.org>
References: <20240207101929.484681-1-leitao@debian.org>
 <20240207101929.484681-5-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207101929.484681-5-leitao@debian.org>

On Wed, Feb 07, 2024 at 02:19:23AM -0800, Breno Leitao wrote:
> W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
> Add descriptions to IPv6 over Low power Wireless Personal Area Network.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Simon Horman <horms@kernel.org>


