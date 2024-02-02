Return-Path: <linux-kernel+bounces-49183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B608466E5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 05:15:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B8ED1C25DA7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 04:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8042EAEA;
	Fri,  2 Feb 2024 04:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hMLGFbP/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED741E549;
	Fri,  2 Feb 2024 04:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706847330; cv=none; b=Epl3JVGUaFys6hY5n24AREh5M5RMfW/eLh31ieyguQk+SYPFtjBhc8QkQn5tc07/ufJcnHJK0aV427QgQFTWwOVKy7xn65KAekmeEv1d5GOjtaGBv/rynEjIqDMZuTWDWK9iux/CmVlCOFEmYeihwEygqJmSdXWyPgAIZOUJsQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706847330; c=relaxed/simple;
	bh=kkjBxErGvqMyqVNGgQPkKqrSn2xGdcYeslQx1VwjIYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JALj6aREzo8pZOXrZgGcR1qHviagCL1D4Oj/SmHfw2IJEKZe0k2qdMJD7GwwjLVqOeloGvh6faoEAjiNmP1doGtln39faQlXqvqTZluCsxCn4mdjTWDhb3fwOAIXcrlzsa0eTdBmmVCXue2mDMxgrjaxngu7OMaRnoNISgW43YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hMLGFbP/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEB01C433C7;
	Fri,  2 Feb 2024 04:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706847329;
	bh=kkjBxErGvqMyqVNGgQPkKqrSn2xGdcYeslQx1VwjIYE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hMLGFbP/hcARdZrNnP6IggS9IfdiSlwHKrbQesdFAJinKWDJLeH7HDoEXYYpEbVXe
	 H3TpeVnVVXbTb9R8AKk/WU13CkEH4PTAqMF2hKmsvJ292L+K/AxYGQM64nSLYyWb+3
	 IIe0uJPjRhfN56fypd8Q1etN9I+9GvywStHP8EvGtFIpSstxnk7cQLH3pN+Fye2Ix6
	 MPTmiXK8cymWbPAEMWZscfRfjFzfP5ETieGmYfuKApePJhGgP5BjXWRO3Ub9kiTYhW
	 h4n6LT6Mvy9pmNDqvqX+V6Dm5zr2fWFkVeGhe0vaoQaT42taXe/QbHwdD9JSx1yg3a
	 IHb6n5ptUPU1A==
Date: Thu, 1 Feb 2024 22:15:26 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, 
	konrad.dybcio@linaro.org, krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, robh+dt@kernel.org
Subject: Re: Re: [PATCH v3 2/2] arm64: dts: qcom: ipq6018: enable sdhci node
Message-ID: <eqepewdgp5k3ajusf3hk7nazi2eli2w6wgxlbjroldwyobzh3d@aewtie2d3ora>
References: <3dev6ez4iovtigj5felmwhascaaupzzptwz5wfoag7ml7knlmj@arnddy2jaqxz>
 <20240129024006.1110513-1-amadeus@jmu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129024006.1110513-1-amadeus@jmu.edu.cn>

On Mon, Jan 29, 2024 at 10:40:06AM +0800, Chukun Pan wrote:
> Hi, Bjorn
> > Subject and commit message says "enable", but this says disable. Could
> > you change this to "Add" instead?
> 
> Thanks for your suggestion, I will change this to "Add".
> 

Thanks

> > Do you have a patch for any board where this is actually enabled?
> > Perhaps you missed a 3rd patch that enables this and uses the ipq6018_l2
> > regulator you add in patch 1?
> 
> Some ipq6000 devices do not have pmic chips, resulting in l2 being
> unavailable. So vqmmc-supply should be configured in the dts of each
> specific device. As Robert suggested, the ipq6018_l2 node is used for
> the device dts reference.
> 

That sounds good, but do we have any one of those boards that should
reference &ipq6018_l2? Could make plug it into the sdhci node on some
board?

Essentially, why is it needed upstream, when there are no user?

Regards,
Bjorn

