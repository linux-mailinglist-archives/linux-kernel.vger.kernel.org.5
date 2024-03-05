Return-Path: <linux-kernel+bounces-92801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1247387261F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 19:02:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4D951F22E59
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 18:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E644917BCD;
	Tue,  5 Mar 2024 18:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="acGE0/E9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F3016427
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 18:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709661723; cv=none; b=W5pTCado+1ebO6fArZLsycZeU1W+qWvHyZ+8FQduIQhtpUHD0k0KR1hWa/SXTiEzy63AVARSiYph03vPBCJ88d3FJJBdDKv0+mABWdJhzfizVdKh0NI+lBIvGd3hNoEzNrb1ddpw84iu0BfYppHBo5tATlyWcKXGSep8JZgaMtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709661723; c=relaxed/simple;
	bh=DuC3d/cwIEAQKuPyMuJn/MWa7uNznQPc1WusaND35/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hgxKJyXI7yQEyW3fvDv8ixFEP4dnnXO8uFyV6PRMsIo7ecWQv3gBqQTGQod/cWq1ETB+HW6RvI91OczjH0UvLTJPh/WNy6Rz6sTDOacY9wKJm8GB+TRxVwL+pOWqCnu8fNmyGpQdA/u5NPlrfRumGRjfWWI9wTM+wmJcXnExo70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=acGE0/E9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89C77C433C7;
	Tue,  5 Mar 2024 18:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709661722;
	bh=DuC3d/cwIEAQKuPyMuJn/MWa7uNznQPc1WusaND35/o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=acGE0/E9tmRibmy22wtC6gaejMjj/jz9L7AVbUxQnolYCbeX0EoCvWIoJHwojStI+
	 XyBvAiIDTDnEra0DvqMXSY6YJXhsU0/Jc64r1V/QPAx2NzYjWwKgof2lZRHjxmjsyY
	 72xTlVRxBnyY2/iSHxYtVHIkUc8mFRb7s8dW/SDZi84mKv+t8XeMK8UrtpSC8m2MB+
	 F34swpWg8ONbvYKYzJKTJptOe8qN85A0FomY8hw6Im4EPnI/7dFD9/CURkzLv37YTt
	 uJjrRRWSNkK851ykbVVkPZxme70O3Vk+QTrKEglGcNEfj9OszBfjnJ5sjmkQSbIm/+
	 edkQy9QbRIxjA==
Date: Tue, 5 Mar 2024 12:02:00 -0600
From: Rob Herring <robh@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Li Yang <leoyang.li@nxp.com>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] soc: fsl: qbman: Remove RESERVEDMEM_OF_DECLARE usage
Message-ID: <170966167830.3808046.18290518120456288771.robh@kernel.org>
References: <20240201192931.1324130-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201192931.1324130-1-robh@kernel.org>


On Thu, 01 Feb 2024 13:29:30 -0600, Rob Herring wrote:
> There is no reason to use RESERVEDMEM_OF_DECLARE() as the initialization
> hook just saves off the base address and size. Use of
> RESERVEDMEM_OF_DECLARE() is reserved for non-driver code and
> initialization which must be done early. For qbman, retrieving the
> address and size can be done in probe just as easily.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/soc/fsl/qbman/bman_ccsr.c | 27 +++---------
>  drivers/soc/fsl/qbman/dpaa_sys.c  | 12 +++--
>  drivers/soc/fsl/qbman/dpaa_sys.h  |  4 +-
>  drivers/soc/fsl/qbman/qman_ccsr.c | 73 ++++++++++---------------------
>  4 files changed, 38 insertions(+), 78 deletions(-)
> 

No one is going to pick this up? I applied to the DT tree.

Rob

