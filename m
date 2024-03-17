Return-Path: <linux-kernel+bounces-105551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F3B87DFFB
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 21:36:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BE322813E2
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 20:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A681F94D;
	Sun, 17 Mar 2024 20:36:51 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA721DFF9
	for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 20:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710707810; cv=none; b=gMxSfQUVfF26ukcs4Wb82PRkgVQUcrczB2j/i0jl/3Fd7nqyzNMKYs+9fpVxSqjN46USMT12kt5odd5NMsqEj4dCWPTZyCKsaA2/BNwkNQUzWmY/Mtrf2x58fWoDcZQnRNMesI1IUnLZ0d1ZMcrcxxd7T15R67HUR3W6OJ/YfH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710707810; c=relaxed/simple;
	bh=Mf2qW8qx1VFkY6exzuZ/MhBPqsKo8S6DE2T7Zs6/dsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sSxjdGqu20BvQSTtj319j+5t8r0CNRloU8DAO9eHf1UbPMTkCiEsG0aDViTffR10gmQ6NVpD3sdDMZjG5lgTBws/qmjBgR7OGA2ehj0k3NHIyAvbt/UQKiKmAMYJ/LaN/JRO0VRHMx8+oFr34ILvp2J58lbXL5KTya/WZAhHYaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id A530668C7B; Sun, 17 Mar 2024 21:36:45 +0100 (CET)
Date: Sun, 17 Mar 2024 21:36:45 +0100
From: Christoph Hellwig <hch@lst.de>
To: kernel test robot <oliver.sang@intel.com>
Cc: Christoph Hellwig <hch@lst.de>, oe-lkp@lists.linux.dev, lkp@intel.com,
	linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
	Max Gurtovoy <mgurtovoy@nvidia.com>, linux-nvme@lists.infradead.org,
	ying.huang@intel.com, feng.tang@intel.com, fengwei.yin@intel.com
Subject: Re: [linus:master] [nvme]  63dfa10043:  fsmark.files_per_sec 6.4%
 improvement
Message-ID: <20240317203645.GB5975@lst.de>
References: <202403151552.e3809b61-oliver.sang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202403151552.e3809b61-oliver.sang@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Mar 15, 2024 at 04:21:13PM +0800, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed a 6.4% improvement of fsmark.files_per_sec on:
> 
> 
> commit: 63dfa1004322d596417f23da43cdc43cf6298c71 ("nvme: move NVME_QUIRK_DEALLOCATE_ZEROES out of nvme_config_discard")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> testcase: fsmark
> test machine: 96 threads 2 sockets Intel(R) Xeon(R) Platinum 8260L CPU @ 2.40GHz (Cascade Lake) with 128G memory
> parameters:

That is kinda odd and unexpected.  Is this system using one of the old
Intel SSDs that this quirk is actually used for?


