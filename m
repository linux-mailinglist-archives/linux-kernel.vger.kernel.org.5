Return-Path: <linux-kernel+bounces-151405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A528AAE6C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 14:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A6D3B2159D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 12:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45608565F;
	Fri, 19 Apr 2024 12:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LiPxO04L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F46883A09;
	Fri, 19 Apr 2024 12:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713529685; cv=none; b=YJZTuTvG8qo5qwIrFyGT+IWptpnAA4ohpNHNCVWqDuZD2Ul1HJ0F+1maWlL3Ivh49MUVGgOlAgPNakYq344dvRVHY7vkbhSU+Afv9BX4hx8IG1p2CCTssmWxXcGs3viyaX251fQfCyGbRT7OorTj1KkNoK0MdT21l1e/f1eL0MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713529685; c=relaxed/simple;
	bh=rKbBBVN1Sv/J0FjNeUbfB11IjrEEcT2FLxCc2ZqzQKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KpyMg2u1XWY/k3BUvEO8kzAQJux6r9c/IHFOS67MPjEp4Vriki/pzQOUNqdIkKZqHTWXzJU3SBizjh+t4DSbhWDlvmYhBR6FdRVsq8NGwIi0eTpMnviuVDQzOFkQV2ctoF0EM6ypWnhy1qNuhMK0mCDIH5H4PN+TmVJu/wNdVDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LiPxO04L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDE94C072AA;
	Fri, 19 Apr 2024 12:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713529684;
	bh=rKbBBVN1Sv/J0FjNeUbfB11IjrEEcT2FLxCc2ZqzQKA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LiPxO04LYpjkMKKEHajh2tudryPFwsV2CfV1jFzBOkwS7XWT0TaGH6/uHJVG1RbMG
	 O/hlevBoCGmUofMqX+KMzNaDWb2zqQhfitbSNkZK8Lczl3bEqANaMw6BXuw7kR2884
	 DwIQiwlAbvxYFKwEM5+KjIwIl/qIqqi0/vuaEEcqyWCvoTUdGQzpCR2WAgW1B+Cl0r
	 45G17MhVtipiFBoEipJx8j3dZe4HqQkJka8EYQ+ZhNNu3xb0czOJ80iW2mz/RczyfM
	 mkLn07xR8R2C1tHpOeMCJH/Swx36kQKOpwtL3rAy5k4O197sot/KzZ5J+FgzQcexBU
	 Krpou5wiG5ktA==
Date: Fri, 19 Apr 2024 13:28:00 +0100
From: Simon Horman <horms@kernel.org>
To: =?utf-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: Re: [PATCH net-next] dpaa2-switch: flower: validate control flags
Message-ID: <20240419122800.GY3975545@kernel.org>
References: <20240418161802.189247-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240418161802.189247-1-ast@fiberby.net>

On Thu, Apr 18, 2024 at 04:18:01PM +0000, Asbjørn Sloth Tønnesen wrote:
> This driver currently doesn't support any control flags.
> 
> Use flow_rule_match_has_control_flags() to check for control flags,
> such as can be set through `tc flower ... ip_flags frag`.
> 
> In case any control flags are masked, flow_rule_match_has_control_flags()
> sets a NL extended error message, and we return -EOPNOTSUPP.
> 
> Only compile-tested.
> 
> Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>

Reviewed-by: Simon Horman <horms@kernel.org>


