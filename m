Return-Path: <linux-kernel+bounces-91175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD50870AA4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 20:27:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A41D2B26AC9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 19:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44FA079946;
	Mon,  4 Mar 2024 19:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fBJ/0MAW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B5578B68;
	Mon,  4 Mar 2024 19:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709580448; cv=none; b=pSyCzfFTErKGdDOwIJHdzM20T24yVJ6NYqmgt1M/X84ElEGT5FGog9U7ly0MJXy38SQmg1A5eA4+YB8kinHSMSSgKo5bf3SDiSf0ZP6W1s+d5cIe7CEhWezo9h6ePom1CLANOwPzp08AtNN2Tv1LIDxAYs0WaGmS6chcgayn0JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709580448; c=relaxed/simple;
	bh=Q/qmBaGLFXD+OqwG0cV6Sxh9sh+SNUs2jlMlo+ZO0EY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HTm95d348MjuYvG+Jxhh6cKgB0jWvibZj4CNf/47IR4CMYznUcXa2Xd9546UmXwrPuAfyXLUZza/Xv5E4/2Bbwoks8t2VwVK8kufwqGbsy+7GrmZYEuAqt8xXoGTR5GYQe+3dAb+fsM3Q47k2aqH6jkvulqEwaw2rIMp8gLOJmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fBJ/0MAW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECDE7C43399;
	Mon,  4 Mar 2024 19:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709580448;
	bh=Q/qmBaGLFXD+OqwG0cV6Sxh9sh+SNUs2jlMlo+ZO0EY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fBJ/0MAW2FzsYC2u6AUYvioejIJRUAdJ8tnZKSuoF2AH/tRk0VRjLsAap2eEdg96A
	 KAofJu2kRiJRSnsS6kl4y52rJmieLfbl/3u0lQ/zdCw+pbZALn0SLSyW+szuBtUg5B
	 hDwCSvCzRk4er7mOUt3VTzkqEBxsr2Dg4jwdHkclZOrh2m5Q1mkFTKiQiFwDj/n2tp
	 3LgF4VF/6b8WCiqN+TtgzrH8a0caPmYeZl5ijUsEDuJJfRuttUWirgBv1wUzC/lGHh
	 W28XF7VCBr/iiEwanDvrb9lSgEJ8g/vDvrTpJ0pEqJfEihPFuC6M5oGzR/wiQ97Rov
	 1szd+L6+63fXw==
Date: Mon, 4 Mar 2024 13:27:26 -0600
From: Rob Herring <robh@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Frank Rowand <frowand.list@gmail.com>, Rob Herring <robh+dt@kernel.org>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH] of: make for_each_property_of_node() available to to !OF
Message-ID: <170958044459.929757.7231203467292560186.robh@kernel.org>
References: <20240303104853.31511-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240303104853.31511-1-brgl@bgdev.pl>


On Sun, 03 Mar 2024 11:48:53 +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> for_each_property_of_node() is a macro and so doesn't have a stub inline
> function for !OF. Move it out of the relevant #ifdef to make it available
> to all users.
> 
> Fixes: 611cad720148 ("dt: add of_alias_scan and of_alias_get_id")
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
> I have an upcoming driver that will use this but which can also be built
> on non-DT systems. I'd like to get that in as a fix to avoid inter-tree
> dependencies later.
> 
>  include/linux/of.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 

Applied, thanks!


