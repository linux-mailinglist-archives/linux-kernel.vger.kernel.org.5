Return-Path: <linux-kernel+bounces-93067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA37872A63
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 23:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1B4D1F268A0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 22:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F71E12D204;
	Tue,  5 Mar 2024 22:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AGy1/JGT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B6A12AAD1;
	Tue,  5 Mar 2024 22:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709678707; cv=none; b=ep7OWQUsd5uRQejLYyLQoCypeinYo6wRsWncistG+yQKuV9L3PtgVGG4bFshJ8Dbv2376pUvxPOJlv9aoz/6Zmu005qe5eVWjDya3z3DX6NVMVHwBHbfksHMNMaRrCS+6mRGlfBNm81pPb7gtq5R3BptswKSmIdwZ60YLYVLybE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709678707; c=relaxed/simple;
	bh=oxMjZT69c7aQJPieO1jFDDJPYjQ1BYwVYRL+wgtRYGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GMx/rr4NCxZ39b8rLRpay1YYmzLfxsqVWbzSQPrPAQ99WMGZKJpD1fzssw3K6u3wCHEuldq9Q+kUoKhD4EuqZ3Kd+/Xx2zrb19Duywj6YagTieklhtW0SgdekGCLDlxdoTDFlwTe2Djas7eztwOUcTEiM06KKo1UkfQlDYxMqtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AGy1/JGT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDD19C43390;
	Tue,  5 Mar 2024 22:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709678707;
	bh=oxMjZT69c7aQJPieO1jFDDJPYjQ1BYwVYRL+wgtRYGY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AGy1/JGTIfydcGFzYT5XAoqkzVPQEZVZoyWs7ml4gaDexkhgkVwozUeRLdpyVgI7j
	 byo+nwyX5S8GVY3UJHs7qrARv8R5iCWWiKtXgr3+phV3yZIlKS6EDQFL2LwYyHkHjm
	 pK6a2zuIa9ul9b4PtPWUzBGF4SXgcxGLPer/nVk8aHRVG5QFWVMwDMPwytbo3rj0Q/
	 OowrxkOsQJf00ynNJgVR2BI3Kp6tjBHhcDsGAM4Qj9PyAdDNjx/x+ux2hYpLf77zYT
	 H1+1aVG3Ss1L6Jbonm+jyD7Bo2eKQUafcc675ewoNnwqx3ew/7sLnVYJO0TH7JxFBd
	 cl/HOo3aBVGGg==
Date: Tue, 5 Mar 2024 23:45:03 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Young <sean@mess.org>, Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [SPAM] [PATCH v1 2/5] media: ir-spi: Make use of device
 properties
Message-ID: <5yzomqvex6tede5df5loqd5hitgv3lhace6vjpiwvynpu5yh5f@a3d4twlvn6qy>
References: <20240305174933.1370708-1-andriy.shevchenko@linux.intel.com>
 <20240305174933.1370708-3-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305174933.1370708-3-andriy.shevchenko@linux.intel.com>

Hi Andy,

On Tue, Mar 05, 2024 at 07:48:27PM +0200, Andy Shevchenko wrote:
> Convert the module to be property provider agnostic and allow
> it to be used on non-OF platforms.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Andi Shyti <andi.shyti@kernel.org>

Thanks,
Andi

