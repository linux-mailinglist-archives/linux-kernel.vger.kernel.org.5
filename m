Return-Path: <linux-kernel+bounces-158657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF2E38B2382
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 16:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C88BB21D37
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 14:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6572AEEA;
	Thu, 25 Apr 2024 14:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GZTt+zBj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA26149DF2;
	Thu, 25 Apr 2024 14:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714053981; cv=none; b=nEpMsQIGHTlKm6ta61ouJZFkVub/epWV9feH3qD+JjMT+wQOz4rYOEdCN/uZfVWsJmgb0f9/Z8kJFVHAC8kvJTFtFCbbNQfeYa/s7Lox7AzySj1jhZgkn/irfO3gJepaRIcD53EZlHJCEjETE20VXjbuAnVOI4YM+J1YZZnVpS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714053981; c=relaxed/simple;
	bh=JueKNUbqkMrDp5swmUj2e3hVLcv6hwXUPXEKDyvXcoE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mEHqXP1Zzxxji0ksfvS8HBi9ayUgNTUfc8W/nCx1VugYGAEb9LhqRpf1L4hZBww9VADjbmYA5vN95tuRB9WgsIfvKxZ+oAhdt6lq4Ri+HzRs/y7DvL9tEMo+RKJrMf/+DbOmeaTMmObiCwuud/kevZk2+20IYwe+f8W0ef+CFVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GZTt+zBj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BF3AC113CC;
	Thu, 25 Apr 2024 14:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714053981;
	bh=JueKNUbqkMrDp5swmUj2e3hVLcv6hwXUPXEKDyvXcoE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GZTt+zBj/HQReSeMMbY4LRrCLGuIoGLlxcM3wJWirLWujb9y40YI9wr0Qc6zyIjwM
	 Uw/jymb5P9WFpORZZoPlKrOTLAYOlMt/smrfiXHUvBu0twK8bcHzBSe4fAJEWTK9uf
	 9l9om8Pg1CfZ0CMAQ3a7PoxCaX/6osIHW4A9DbkwpR7TPGuuZwSdFQzY+ix/FK7nDR
	 LsXLWCw9Pb3g17uNkK0ofrYZpcAxdc8989GYeQhzXyqJ9XLIlzWg6Q2AHUui64VPcI
	 LWRdB+cIb+YtnblJg7A2ffAuow/UzE8m33UiVDJkf50v02HjtXEH1i/PFKRbnXglcn
	 kcyxzhTBJ8IJw==
Date: Thu, 25 Apr 2024 07:06:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Jiri Pirko <jiri@resnulli.us>, Oleksij Rempel <o.rempel@pengutronix.de>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew@lunn.ch>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Kyle Swenson
 <kyle.swenson@est.tech>, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH net-next v3 0/3] net: pse-pd: Fixes for few small issues
Message-ID: <20240425070619.601d5e40@kernel.org>
In-Reply-To: <20240425103110.33c02857@kmaincent-XPS-13-7390>
References: <20240423-fix_poe-v3-0-e50f32f5fa59@bootlin.com>
	<ZiebQLdu9dOh1v-T@nanopsycho>
	<20240425103110.33c02857@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Apr 2024 10:31:10 +0200 Kory Maincent wrote:
> Your reviewed-by tag has not been taken in the commit merged.
> It seems patchwork does not take the cover letter tag reply into
> account, I think only b4 does.

Sorry about that.
The problem is that patchwork doesn't correctly group the cover letter
in your postings. Not sure why. 

Could you experiment with tweaking the posting?
Maybe we can "bisect" the problem.

