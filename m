Return-Path: <linux-kernel+bounces-151149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C65C8AA9C4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 10:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD5A5B245B0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 08:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D344EB43;
	Fri, 19 Apr 2024 08:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P1VfIa1X"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5904AED9;
	Fri, 19 Apr 2024 08:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713514080; cv=none; b=C2veng2HFarlbqkcyxt6JN+Z0NGFhrIvFynGdcmmripsRatDlzlXobhQuThyr+sh/QK0JXkjyv0uRDKihMTl7pksE0YVmU2hnkWxIyT2wM4RWd9MP+Ryb+g8+bDVHqUod7qMrY74DARRhzSuqjeZcFL5yg1NYmy76jqh7llATVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713514080; c=relaxed/simple;
	bh=BcDBvgIIPmjxJr0AhEDkRNxcBWNE5zvu3xjWvD0Ecmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OdxA+x9WDBOVs2k1k2mEyqXX5VxQAZKv+Mgnh5SImc/6TWuprBoXDjBHrNzocaqbOk5CDPpH2BBZ54i5Qd3IbA9WSym5AaG3NVEmm/D9iXhDa0CUevr/K9p6IsUDBZ71lZ/ILGk2gkj49KknfYVlknn7RNQnrF3+iVNyGkwml14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P1VfIa1X; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713514079; x=1745050079;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BcDBvgIIPmjxJr0AhEDkRNxcBWNE5zvu3xjWvD0Ecmo=;
  b=P1VfIa1XHvitvwnsmagaOT6lL64kdOwQC/3doHM/1X5H1g9xu1ij8wyy
   /ZnJWXQEw0gEihGNkUkYlN0c4flvbdJdVIBYglSf27hGTIUt3+FyD4cHx
   hBWcn9FXzbJTWIubhGJQThV+07geumArMwUu4GJL7MuBMxMDTnLp/baD5
   3yHWU+uSi6Ykj0XkytBwhDyqc2dtP1ohT/EKLYoFavg9aGqGnxEi7vyIB
   TbVZbKPlqSstUvuh16a8/VwNrGdlTmqOgi1lMbJ+Y9rbO+dliTMc8Ab8H
   Idk1dmWRjGPCcki617dPdopYrpks+CD+NN1lqPfzW6nOwhRdEj6EGxOih
   A==;
X-CSE-ConnectionGUID: 2Vrp7412SNCwpFhLIKDhNQ==
X-CSE-MsgGUID: MX58V3gBQRi/xpbekNJkHA==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="8973613"
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="8973613"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 01:06:57 -0700
X-CSE-ConnectionGUID: E1OQvV1hT/2/hVYBDCQvCQ==
X-CSE-MsgGUID: 2GEEdAiiRkK4zabOC++2Yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="46544623"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa002.fm.intel.com with ESMTP; 19 Apr 2024 01:06:44 -0700
Date: Fri, 19 Apr 2024 16:01:30 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Peter Colberg <peter.colberg@intel.com>
Cc: Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
	Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
	linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
	Russ Weight <russ.weight@linux.dev>,
	Marco Pagani <marpagan@redhat.com>,
	Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: Re: [PATCH v3] fpga: dfl: remove unused member pdata from struct
 dfl_{afu,fme}
Message-ID: <ZiIk2lftfCqEFahc@yilunxu-OptiPlex-7050>
References: <20240415235937.3121-1-peter.colberg@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415235937.3121-1-peter.colberg@intel.com>

On Mon, Apr 15, 2024 at 07:59:37PM -0400, Peter Colberg wrote:
> The member pdata in struct dfl_{afu,fme} is set in function
> {afu,fme}_dev_init(), respectively, but never used.
> 
> Fixes: 857a26222ff7 ("fpga: dfl: afu: add afu sub feature support")
> Fixes: 29de76240e86 ("fpga: dfl: fme: add partial reconfiguration sub feature support")
> Signed-off-by: Peter Colberg <peter.colberg@intel.com>
> Reviewed-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>

Acked-by: Xu Yilun <yilun.xu@intel.com>

Applied to for-next.

