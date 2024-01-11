Return-Path: <linux-kernel+bounces-24106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 768E282B70A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 23:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6FF51C2420A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 22:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4401B58AA8;
	Thu, 11 Jan 2024 22:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bDSH2aM6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0EA58238;
	Thu, 11 Jan 2024 22:18:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B194AC433C7;
	Thu, 11 Jan 2024 22:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705011491;
	bh=Yljtk+lS5Y4czYfdpEU4I5eKloXf9DSHq8FeoWJos4s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bDSH2aM6GJNV8nN3R59MsSlABhJO8fWj3pcdMdRd10QyDZRNJo7abBI9lM441iZKU
	 XKUxtDJl/lDcahTZw6+bpDznf1ySc3YHQpu5gflv3BsnA49pOgV2anjp+twWENcEhC
	 cj1DN46S9cS0r/YrTm/ITBd3Jswbf83r7pBr4GKFn22W3eKgCzqWQo+L6Cwc0S1b8u
	 LK0MED0D8goWkXKKipTKbZlOTQhM1pXHb76vk5UWFo4fBpc7nVoolSNX4ZC925ES/R
	 4h5sy0S3AkhxUTsroq/XlUOSrP3u6hLYp/Kvzb38rtwGl4VxW1TB5pbCmEjBzR3bnF
	 g/HJKCgY5uaGg==
Date: Thu, 11 Jan 2024 16:18:08 -0600
From: Rob Herring <robh@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: "Christian A . Ehrhardt" <lk@c--e.de>, devicetree@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
	Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH] of: unittest: Fix of_count_phandle_with_args() expected
 value message
Message-ID: <170501148063.1206625.719560568474772943.robh@kernel.org>
References: <20240111085025.2073894-1-geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111085025.2073894-1-geert+renesas@glider.be>


On Thu, 11 Jan 2024 09:50:25 +0100, Geert Uytterhoeven wrote:
> The expected result value for the call to of_count_phandle_with_args()
> was updated from 7 to 8, but the accompanying error message was
> forgotten.
> 
> Fixes: 4dde83569832f937 ("of: Fix double free in of_parse_phandle_with_args_map")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/of/unittest.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!


