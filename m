Return-Path: <linux-kernel+bounces-56236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1368A84C7B6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:41:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD88628DBC6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 09:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89FF623741;
	Wed,  7 Feb 2024 09:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fW/bou7Z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72B53C460;
	Wed,  7 Feb 2024 09:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707298755; cv=none; b=NzyMtA4w5+XSXS1S5/N2PDl2mkZWqTL3lOYLlj+SlioxdFDeQM5SiOj3qKqjShqIubbw5KRFn8KNQQlTBd7OpyDMfAwgkM+uf9O6ywnxdp+SDE1ZDZ/NZuO/HKl6+tSGe/VkG5J7m/4UfZCgNJLKUUH77xONBBRiMmDqzuXTRFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707298755; c=relaxed/simple;
	bh=xE7Hz8F4hPX3o7n+0ziBG/3UXfOJKIOA4LqMsgXK5Ks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d6pSNzJck5Yge4ijnow/AwuBfL48F6X4nvHrc+tMSr0HonNPSL16/5ZDYVuDX5jQafqXOXgcgygzyEhTPtIvlw8jjkmue0wjMHg8NEZjVanRbrih1EaiSiD2+i1B77p7HkWPeY+O5Z13T7EZDWU1UbD98X2t4OhN73oq3tJb0BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fW/bou7Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C4F2C433F1;
	Wed,  7 Feb 2024 09:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707298755;
	bh=xE7Hz8F4hPX3o7n+0ziBG/3UXfOJKIOA4LqMsgXK5Ks=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fW/bou7ZEYs8/2v+B73j30Rh/fwJXq1Gkak+lf3dxbe2M7BJRUXDPpRs6uUhBqSLd
	 m+EsSQV3KKen2D7FvJb5L216olYvMe8ldV0MFV2wiMtxusVwIPcy0FpLFTZm1naOAj
	 TgGi8VcE4/iQQrwbvxbkq93bFseruKH95e9UzwJBicgcgpd6LCeBsCMNZ9S+dn/S7q
	 /exzuxAUsrkUpYOYoOXtcFlfUASXhqIGg7Hyy9NLSxQTYGPmihY6/3+C2VnfkDUXr/
	 jJ1fz6VvAusHUkyzR8evvl5o0HhDCp+l38eTfc6izPCw9kdAYlQLUVth+cIRS2fPX5
	 MLK1MUfwoDW4Q==
Date: Wed, 7 Feb 2024 09:39:11 +0000
From: Simon Horman <horms@kernel.org>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Ariel Elior <aelior@marvell.com>, Manish Chopra <manishc@marvell.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] qed: remove duplicated assignment to variable opaque_fid
Message-ID: <20240207093911.GM1104779@kernel.org>
References: <20240205215530.1851115-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205215530.1851115-1-colin.i.king@gmail.com>

On Mon, Feb 05, 2024 at 09:55:30PM +0000, Colin Ian King wrote:
> Variable opaque_fid is being assigned twice with the same value
> in two identical statements. Remove the redundant first assignment.
> 
> Cleans up clang scan build warnin:

warning :)

> drivers/net/ethernet/qlogic/qed/qed_rdma.c:1796:2: warning: Value
> stored to 'opaque_fid' is never read [deadcode.DeadStores]
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


