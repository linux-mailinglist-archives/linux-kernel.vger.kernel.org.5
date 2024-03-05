Return-Path: <linux-kernel+bounces-93070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7C3872A6E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 23:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81EBA1F26A30
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 22:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC16112D205;
	Tue,  5 Mar 2024 22:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h3yWbAil"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF6312B17E;
	Tue,  5 Mar 2024 22:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709678924; cv=none; b=GwjBh2BMHZ4cLSvln2q4ZidL+Rk/FnPeq0ur+0MnZxeqGPn7NhfjoxXQdUc1BfJYppdLHZeavbHxgcyQC76I5BiYpnGOO78Xoxp9nAjEdb4E6d16P35Iut2lqR/sHutcY7Fb41VltxZ97D+hZncOl87sjhbHYtbGuAX3EnrsbjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709678924; c=relaxed/simple;
	bh=OmT8m06N0a4inUHPo9yr+BrDaA55dPVfthvngA7inms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gJ8BD1lUoYccC+b7wEumMMXK9yWMX48rX5ughTtIPxhopBqgh4oqs1gBfG+L+CcHSImIECkS4bynm4hLpPjUipk+fJy/rUxWhMM3n0zXoud5xT1u3vyW2LWKmwUCWT8iAXUFQv4RtHdc3xWNDRXFieMhsIoHSBOU+TaZCCrAqfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h3yWbAil; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53A5BC433F1;
	Tue,  5 Mar 2024 22:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709678923;
	bh=OmT8m06N0a4inUHPo9yr+BrDaA55dPVfthvngA7inms=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h3yWbAil4sHbnS82re1wXarSIlGMocOCG1VMTJMbk0+UStj8itUrBDaVcG4WfQriL
	 6jxrKFXAp0JBXgS5rDNZv0ffpMToy4WJ2fnYcO1IlRV5eR7ubfz/GILl8UmNifjz56
	 KdiS3qUKvnu2L7t2ce4lKwSPWGLUR0rUxNQIoDpvKGDmYM4fBklWq7dima2++Zb/aG
	 ssnl+0QXqE3w/hVZlqpozyf6AVNFiZ5Ssd4IBRZRn74Q8Hyy1e7xIB7H6paP+tbQ02
	 /McpREK2+JLHyduZtEmjxWZiRax1tj5ZYNOD7T3N4tzgFjhujLy/0nrDsiY1g9iEt1
	 q8cYwoCMubvLQ==
Date: Tue, 5 Mar 2024 23:48:40 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Young <sean@mess.org>, Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH v1 4/5] media: ir-spi: Remove trailing comma in the
 terminator entry
Message-ID: <4wsig7bdelnyhpfzkagowmec3r25ggo4lw74pxkk623ige7fvs@4w4mtf3i3hnp>
References: <20240305174933.1370708-1-andriy.shevchenko@linux.intel.com>
 <20240305174933.1370708-5-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305174933.1370708-5-andriy.shevchenko@linux.intel.com>

Hi Andy,

On Tue, Mar 05, 2024 at 07:48:29PM +0200, Andy Shevchenko wrote:
> Remove trailing comma in the terminator entry in ID table(s).
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Andi Shyti <andi.shyti@kernel.org>

Thanks,
Andi

