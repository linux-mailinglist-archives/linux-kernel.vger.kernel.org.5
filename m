Return-Path: <linux-kernel+bounces-142133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C6658A27EE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD3751C22C0F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 686034C62B;
	Fri, 12 Apr 2024 07:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B5Cly4Oc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76D34AEEF;
	Fri, 12 Apr 2024 07:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712906737; cv=none; b=Qu55Z4g4KG6tPKXU+keCKCsd0gZFaRn3vRGV4hWYbXIWeI0aJq76FZPhLWDuWa+ISYyE6QN6WiTvRdC+6J/fz5rBClpbOMkBIOBdOxW5JYgF7ZvTDt2H+vX/cj17Mw1XZGowDTuGMlKSh2b5wtPmKHA1M+hCayLahpLoweFPId4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712906737; c=relaxed/simple;
	bh=Pux0NDQ5g4ljVY9qNbfRnnuBewfYl1+PQgp0gNQJOG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h7KP8RX9ElG7S9PQNMTo+AxJ5b/TgAeCOLav7CJSYsyur68PqhF6zZX6z9RGU8coOdYiy9JQ6M0dtoSvElrGh8bNqvYEFGgarddn/EoVzse8NVbHo9WVSUsUzIIEUgGbTWrLviNRfi2exRXQswWUdUnrFzXrHSviKn/MRMWs4U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B5Cly4Oc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62FB4C113CC;
	Fri, 12 Apr 2024 07:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712906737;
	bh=Pux0NDQ5g4ljVY9qNbfRnnuBewfYl1+PQgp0gNQJOG0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B5Cly4OcRdY3FExxkGltuaVOVv2YKhqkmjmr3TYetGhXjOX1DntVuvYtwmvS1lsW3
	 pPzjBWHSvGb8yZPG2BvHzEUgQDtOrBO1oVr0nnZLdwC5GsuWVAFm3GwFURXeoDoIHZ
	 7huj0hjTwKQhVK8LMpI/paDrz9wHTPKT33OfT/SLMMTFzG/w7j1Szl8UW+o8bNrBTq
	 iGcXFGNNnEIBNN92xwlSSkIepKX5+Mgpl5be9zeavn3N8BK28VnY5tLED51jE9mjdi
	 xHuaZE068IlVVBkPYBdcu+6jLhnlG05UfWX0cYvU7aoTdMHVckurJIj2wvGpUPZ1mX
	 2VlglwXDh+3jQ==
Date: Fri, 12 Apr 2024 08:25:31 +0100
From: Lee Jones <lee@kernel.org>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: Peter Colberg <peter.colberg@intel.com>,
	Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
	linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
	Russ Weight <russ.weight@linux.dev>,
	Marco Pagani <marpagan@redhat.com>,
	Matthew Gerlach <matthew.gerlach@linux.intel.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Russ Weight <russell.h.weight@intel.com>
Subject: Re: [PATCH v2] mfd: intel-m10-bmc: Change staging size to a variable
Message-ID: <20240412072531.GN2399047@google.com>
References: <20240402184925.1065932-1-peter.colberg@intel.com>
 <20240411154956.GH2399047@google.com>
 <ZhieBC124oq/Fcqa@yilunxu-OptiPlex-7050>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZhieBC124oq/Fcqa@yilunxu-OptiPlex-7050>

On Fri, 12 Apr 2024, Xu Yilun wrote:

> On Thu, Apr 11, 2024 at 04:49:56PM +0100, Lee Jones wrote:
> > On Tue, 02 Apr 2024, Peter Colberg wrote:
> > 
> > > From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > > 
> > > The secure update driver does a sanity-check of the image size in
> > > comparison to the size of the staging area in FLASH. Instead of
> > > hard-wiring M10BMC_STAGING_SIZE, move the staging size to the
> > > m10bmc_csr_map structure to make the size assignment more flexible.
> > > 
> > > Co-developed-by: Russ Weight <russell.h.weight@intel.com>
> > > Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> > > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > > Signed-off-by: Peter Colberg <peter.colberg@intel.com>
> > 
> > Xu Yilun, Peter,
> > 
> > Do you require a pull-request from an immutable branch for this?
> 
> No need. The patchset could all be applied to mfd branch.

Prefect, thank you.

-- 
Lee Jones [李琼斯]

