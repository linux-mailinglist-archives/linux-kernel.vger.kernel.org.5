Return-Path: <linux-kernel+bounces-91179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C162870AB3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 20:30:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0814A2823B4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 19:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5A479DA9;
	Mon,  4 Mar 2024 19:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OFVmGEKn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DD579946;
	Mon,  4 Mar 2024 19:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709580590; cv=none; b=WbjB6NogBJDxFBKh0IRVdi0Pw9xafpEGXJ0qE0xweJdtSccUwiUSXLXgUUnBbgvheo1OzmGbbceuk8C3lzfiU/MEYgH4+PoXo0jq8RzIhA9d0+QULqfkGcLah+EKPjbnwi4aUPxpQ+nLYhVBqaCqKjB3sjxEAiKRkGMkt3/RnpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709580590; c=relaxed/simple;
	bh=Mm9viwy6QqpvUGccQ4BabLbBp9gEZSSvrumFydB1Blk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=icMih2ZInNPMD72wc6qUZtnxEqsbYIS2ZfIT4/SSStJsn9Mz8ig/+8FDILiRsYLjz6QrC96SSwXTsPJYmWOd22dyIwQO9uxEyfZJL8pWjw+t0NdQWnYtVLR7D3591jdJg37er0fqmoHsgl479yn+yXzZh8BeLDiGT+lpiC99WtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OFVmGEKn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96AE3C433F1;
	Mon,  4 Mar 2024 19:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709580589;
	bh=Mm9viwy6QqpvUGccQ4BabLbBp9gEZSSvrumFydB1Blk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OFVmGEKnZl9oNM/uyxv6LIOqolwMWSVESKukMkKYYQqonADKvZtXKOJiHjRpJhj+U
	 bb/JBfVD/O4AuddQqo0zP94eCTFAtMYPIqbntKGZ5cck9I0ereDkKyj8wYyiXfHffz
	 TVijbKq/O4OuvI1IiAmIbxrOv29E7f36/beVyaIfi7rEcED1rSTHspfI6TMZd9EB9R
	 w+RFUlhfg26LRwGc4y1YKHKY3QSIw3QGIF/NAxHFACjh7pKmCN2AMqDeRdp84KGt2N
	 kl1ScWwscTJWvJBwjLIPHImaxTv9DJ7mqeAlPhj9l2I9iOk2hIxi7kK3gkVgLB9mYI
	 DwoEBIi8Fff+g==
Date: Mon, 4 Mar 2024 19:28:16 +0000
From: Simon Horman <horms@kernel.org>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Richard Cochran <richardcochran@gmail.com>,
	Min Li <min.li.xe@renesas.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ptp: fc3: Convert to platform remove callback returning
 void
Message-ID: <20240304192816.GS403078@kernel.org>
References: <20240304091325.717546-2-u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240304091325.717546-2-u.kleine-koenig@pengutronix.de>

On Mon, Mar 04, 2024 at 10:13:25AM +0100, Uwe Kleine-König wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
> 
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new(), which already returns void. Eventually after all drivers
> are converted, .remove_new() will be renamed to .remove().
> 
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
> 
> note this driver is currently only available in next.

Reviewed-by: Simon Horman <horms@kernel.org>


