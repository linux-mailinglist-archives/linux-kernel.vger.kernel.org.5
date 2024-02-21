Return-Path: <linux-kernel+bounces-75240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD4385E515
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:58:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F16E6B24B7A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 17:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B498B85264;
	Wed, 21 Feb 2024 17:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LbTDMqnG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCD183CBC;
	Wed, 21 Feb 2024 17:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708538292; cv=none; b=e+zqCOI0aq/oz5RwsUHfh0AAyJnLblIcj24cUVLsSG5bLpUUiWHoN1iXCGeuTBmzZaA2tuiJq9dX4OUo1z1JHgzfqsbhQKDbVQRlzS4Vb0iMh+usEHHWdbfowVnR+0MaL7LAt5nGSpCJ6SIF8xHrFu7igni7yAwQRgTfXH8DF+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708538292; c=relaxed/simple;
	bh=uomZG9MXqS7kF7JKnSlsE7LuoDTKmetN2P1DLvWOsoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KH3aQERgFkwoMMUHHinfr2cELfiqId25llREKa7SGdDyxPnPauvt0P6YPL5RDOgwM5CoZCxY/eZZb7cAN0K3MXSSyP/mNW0eslvDOhImAF/F7nPqKNMaNkWjt5mkUpQd/CIrMl8jidjQrj7DuaZ3aDUZw/WLCTYQ/V0DFRKG760=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LbTDMqnG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56C86C43390;
	Wed, 21 Feb 2024 17:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708538291;
	bh=uomZG9MXqS7kF7JKnSlsE7LuoDTKmetN2P1DLvWOsoc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LbTDMqnGoJCQvaOcSc00W+PWA5mW2Er7l4McOB67qjWMWp/dHov8ax11GP9yv635w
	 jgjRMJ1ZGwotqQe4QBp3u63W3n9uR81QdeHl1Jv9W3XWXOzMWQkFwnq2SBrKOdpNLs
	 VAsALdvjH8BYugCYatTJpPMDISIlZwFb0CzfZXaFZ4u1ccZ4HeZJxoIRrq9RvpKEkJ
	 x8rsqawRZcV3gnkV85rv4K7FdVEsM6A5mfAGWieNCMHRVr3+zdhOt2sTzLH8y3ocLA
	 9+Wjin2DIOse2oF24RFPu1mF6MNWEosrtHvKapHTx5i0T3QDlLXUOE/4Z4KgH5bQUC
	 9QLRGwjkNwEaQ==
Date: Wed, 21 Feb 2024 17:58:07 +0000
From: Simon Horman <horms@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Veerasenareddy Burru <vburru@marvell.com>,
	Sathesh Edara <sedara@marvell.com>,
	Shinas Rasheed <srasheed@marvell.com>,
	Satananda Burla <sburla@marvell.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [net-next] octeon_ep_vf: Improve help text grammar
Message-ID: <20240221175807.GF722610@kernel.org>
References: <b3b97462c3d9eba2ec03dd6d597e63bf49a7365a.1708512706.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3b97462c3d9eba2ec03dd6d597e63bf49a7365a.1708512706.git.geert+renesas@glider.be>

On Wed, Feb 21, 2024 at 11:52:41AM +0100, Geert Uytterhoeven wrote:
> Add missing articles.
> Fix plural vs. singular.
> Fix present vs. future.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Simon Horman <horms@kernel.org>


