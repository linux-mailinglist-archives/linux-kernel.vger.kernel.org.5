Return-Path: <linux-kernel+bounces-59226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E27084F376
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 11:31:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFA0A1F21BD9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 10:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8AAB1D549;
	Fri,  9 Feb 2024 10:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mm/vjH9j"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3B2DF57;
	Fri,  9 Feb 2024 10:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707474705; cv=none; b=PrgNygfQPOr3ckxl+bGERzyx47j6RXGyZiQ1uFwIW0drrlsSJTI6Yr1TMwVAL4uxvF0y+7gWeAbKH0OZsiV8rOquZE76MC6VFsOS1lQCV0dS/bW/OGqWCCxhjZLe9ACRMaXOUr34yeOMGxsVYNAbjO083X7WWL2CkaXgGvkXLRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707474705; c=relaxed/simple;
	bh=PBl/GJQjl2Lbu5vktcoTjOy2xzE5dgG45w/I1fACQ/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kfS4M5KRgKSyYAANO0V9cQwc4jDhVwxa2zhyB7yjz7XLWVhTQnV4fLJCLwLukieUFRiC54uNMwR8i1y9Vmh7qlbi2sXq/vUmCb++VoQOH12vXgx7CTErnRXtIxe5ITV0ZqWd7MApJCABq8S6poI43rNM2oQ29faPEsilw2EIoUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mm/vjH9j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1C8FC433C7;
	Fri,  9 Feb 2024 10:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707474704;
	bh=PBl/GJQjl2Lbu5vktcoTjOy2xzE5dgG45w/I1fACQ/0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mm/vjH9j5Mhwwu2owNACHTfDwYvOTnCE52TnBaz8PVE5TY+U1xZ6balyLCgzQXu2H
	 Hhby9wa1mYpHqjAS3hTpTMe7fdTjY0nVHc2gY7gjX1sfV5/7fr+fd+dmZ7YL+CByxc
	 KtNZCGhpI8F2j2d2wL69ThoiVd5OPJu8Zal+McUPryOpaabdzh2Jfxjbvxtei9ordY
	 4CrKaknvgjcCTdkUw+z6J7H5hrC7D+kD/Kklrx45bVqCgpeaA73sZGWPVik1XcNOjg
	 Qd9FL0HObF0O6gUUe18UAeonV2n7X18fDhqC+HJ1LJcxUbmpGzEWJKfiLMSku+qj8Z
	 D02LvuyOI5GmA==
Date: Fri, 9 Feb 2024 10:31:41 +0000
From: Rob Herring <robh@kernel.org>
To: Saravana Kannan <saravanak@google.com>
Cc: Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@android.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Xu Yang <xu.yang_2@nxp.com>
Subject: Re: [PATCH v2 0/3] Improve remote-endpoint parsing
Message-ID: <170747468366.3526577.15059271363267528182.robh@kernel.org>
References: <20240207011803.2637531-1-saravanak@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207011803.2637531-1-saravanak@google.com>


On Tue, 06 Feb 2024 17:17:59 -0800, Saravana Kannan wrote:
> Some changes to do a more accurate parsing of remote-endpoints. Making
> fw_devlink a tiny bit more efficient and the debug logs a bit cleaner when
> trying to debug fw_devlink.
> 
> Rob,
> 
> Can we get this into 6.8-rcX please?
> 
> Thanks,
> Saravana
> 
> v1->v2:
> - Switched from fwnode_graph_get_port_parent() to of_graph_get_port_parent()
> - Added Patch 3
> 
> Saravana Kannan (3):
>   of: property: Improve finding the consumer of a remote-endpoint
>     property
>   of: property: Improve finding the supplier of a remote-endpoint
>     property
>   of: property: Add in-ports/out-ports support to
>     of_graph_get_port_parent()
> 
>  drivers/of/property.c | 63 +++++++++++++++++--------------------------
>  1 file changed, 24 insertions(+), 39 deletions(-)
> 
> --
> 2.43.0.594.gd9cf4e227d-goog
> 
> 
> 

Applied, thanks!


