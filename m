Return-Path: <linux-kernel+bounces-162638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD088B5E67
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 18:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF253B231A8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC10183CC7;
	Mon, 29 Apr 2024 15:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FqIGvbXk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17ECB82871;
	Mon, 29 Apr 2024 15:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714406395; cv=none; b=odrKwJU9YHLKR9V01sqMnenqXeftfltOs0ypXE90Wc2I9Vsn9bO3AFAzZJoruo/1wrHXYIv3ZHYz7A+aarL3+EC000UJnAWzZAh4at/UFZv4En1ecrJrS7R5vk7WRBiws57GRN/6HtzpARVr6SbwTchlcGRlGjFItbEd14iIMpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714406395; c=relaxed/simple;
	bh=CfhM0Hi7F1bxXQjfyx4hYuRdzA5vtBwb494TLMOky9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q+o7gNVrSxv9bfiHQEvZD1rw6Ic9boz+bP98GmxJyPAS5e28wyhF5Ia8HnPyJbw9PTviX+cbFum2dHav1HVRZU1wKTzYIJ4GP9RjnEyEl8+RJScXmMcT4JYyqPOv+ijIBC3F8IYvcBxUn4ODSjeMHLkjQyX1u7huBPLk1auXNho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FqIGvbXk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F644C113CD;
	Mon, 29 Apr 2024 15:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714406394;
	bh=CfhM0Hi7F1bxXQjfyx4hYuRdzA5vtBwb494TLMOky9s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FqIGvbXkPAHS2F+MJ4JT+EjJk74BqYCwrH3TffpPjG1RrqYaglCoOeBeMT5IxCVaP
	 gaPXL9ieS5lgLCXj3v/sk+wnF6GGbklcYialS0IPJUzaaN+Mp5jK2MChvFUQgsMk1A
	 hYclBHT0ne0qL5IbNuaZHWslxbj1zZnGc1+SUmxz6DOKA5eY75YfFLjWy5+F0R/yoX
	 ZqB5aMjPMHWAJGUow535lTtaqBNRRYMHgO9GMOrsCkdMv0aveOvFU4hLGDdrb4CDmf
	 yP5uxiaWqG5r2oCLttUYGU/FpPZnPO0fsxxHIceoWZmA3f6Uz4wdoHR6jAOhSaX+jy
	 oX0DJ/6kI2iHw==
Date: Mon, 29 Apr 2024 10:59:51 -0500
From: Rob Herring <robh@kernel.org>
To: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
Cc: saravanak@google.com, linux-kernel@vger.kernel.org, kernel@quicinc.com,
	devicetree@vger.kernel.org
Subject: Re: [PATCH] of: reserved_mem: Remove the use of phandle from the
 reserved_mem APIs
Message-ID: <171440638161.1895148.11194020129017609758.robh@kernel.org>
References: <20240422235243.2878536-1-quic_obabatun@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240422235243.2878536-1-quic_obabatun@quicinc.com>


On Mon, 22 Apr 2024 16:52:43 -0700, Oreoluwa Babatunde wrote:
> The __find_rmem() function is the only place that references the phandle
> field of the reserved_mem struct. __find_rmem() is used to match a
> device_node object to its corresponding entry in the reserved_mem array
> using its phandle value. But, there is already a function called
> of_reserved_mem_lookup() which carries out the same action using the
> name of the node.
> 
> Using the of_reserved_mem_lookup() function is more reliable because
> every node is gauranteed to have a name, but not all nodes will have a
> phandle.
> 
> Nodes are only assigned a phandle if they are explicitly defined in the
> DT using "phandle = <phandle_number>", or if they are referenced by
> another node in the DT. Hence, If the phandle field is empty, then
> __find_rmem() will return a false negative.
> 
> Hence, delete the __find_rmem() function and switch to using the
> of_reserved_mem_lookup() function to find the corresponding entry of a
> device_node in the reserved_mem array. Since the phandle field of the
> reserved_mem struct is now unused, delete that as well.
> 
> Signed-off-by: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
> ---
>  drivers/of/of_reserved_mem.c    | 26 +++-----------------------
>  include/linux/of_reserved_mem.h |  1 -
>  2 files changed, 3 insertions(+), 24 deletions(-)
> 

Applied, thanks!


