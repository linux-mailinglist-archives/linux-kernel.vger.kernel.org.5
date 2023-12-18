Return-Path: <linux-kernel+bounces-4275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 607C7817AA1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 20:10:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E49F7B232FB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 19:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C940A5D753;
	Mon, 18 Dec 2023 19:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sWmkz+Yv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2317853BF;
	Mon, 18 Dec 2023 19:10:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C690C433C7;
	Mon, 18 Dec 2023 19:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702926619;
	bh=XGALOxLIXLpZiiD0d7eWWL8+n4CoB+wewPDQcWFCmhk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sWmkz+Yvt9Qrj05CCyrLpZ3TPXeciu2TaZ5JrrcFJlBGi1QKnmM1tSSbfQ/DffYP4
	 3b4PTq5enB8VFO2cuyqleezvn1pBpN8YePMCr1x3+aSEveT8eyiE7c7pUm9oXZR1SU
	 Zd8eAOsno3I0dJoNT8ZVXsRak77rjJSApJL2o9TXxcLXGBydCZMMY7uXT8/X1adWkq
	 Hyar8QMB/LUc/XDbquDBPy8swrMt3mpb1gJkbS9gvFFGCdc3q9bPi8csAHyVDyifFG
	 ihC/n4jUDkvPJMGrN2C4lsN8ZnyvrO51LAz1wN3qkat2Vk6NLeQgb61nYj0hKG6nU2
	 vutWp5r7exVMg==
Date: Mon, 18 Dec 2023 19:10:14 +0000
From: Simon Horman <horms@kernel.org>
To: Suman Ghosh <sumang@marvell.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, sgoutham@marvell.com, sbhatta@marvell.com,
	jerinj@marvell.com, gakula@marvell.com, hkelam@marvell.com,
	lcherian@marvell.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH] octeontx2-af: Fix a double free issue
Message-ID: <20231218191014.GK6288@kernel.org>
References: <20231218180258.303468-1-sumang@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218180258.303468-1-sumang@marvell.com>

On Mon, Dec 18, 2023 at 11:32:58PM +0530, Suman Ghosh wrote:
> There was a memory leak during error handling in function
> npc_mcam_rsrcs_init().
> 
> Fixes: dd7842878633 ("octeontx2-af: Add new devlink param to configure maximum usable NIX block LFs")
> Suggested-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Suman Ghosh <sumang@marvell.com>

Hi Suman,

thanks for the quick fix.

Reviewed-by: Simon Horman <horms@kernel.org>

