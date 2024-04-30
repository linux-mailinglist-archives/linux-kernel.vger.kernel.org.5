Return-Path: <linux-kernel+bounces-163261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D648B67DF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 04:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16D17B20FEA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 02:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E9A9463;
	Tue, 30 Apr 2024 02:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PWJs5Rny"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F251C33;
	Tue, 30 Apr 2024 02:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714443366; cv=none; b=Yef5Wup7UwE4giVVBBNDCUSSwXbrOn09pSbt+xtUo/XGAq8KbsKx/hfYzzg+zCJUvgZCeVOxxburdb5QFrQIgGlPhHB1ocBesNgWV0mu2OcT3QF0miucUwjzs8ulCRaCjt/eMmtAkBjbI092WOFtQ2aQKUhiBv4cQVZEMmO2J+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714443366; c=relaxed/simple;
	bh=FEYx4JC+14yee2/OFeo1xzAi0y2DiicqS68he4KfFKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OA/a4jIZ7Tjysl0qfctBD9gf/1ui9FYwlRD4I9D+UIFsuHIc4GE1WT+WLFSQScHNlbUexzHcT/FWx7I6V+P0bK9+wuzx1KyiNuuYnWmC/WSb0aO7XzuD+XcD7fAWyPuklFp49tT+RhxCTibQLoIuy+a4ik+6cUBj+wab3REcC64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PWJs5Rny; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714443365; x=1745979365;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FEYx4JC+14yee2/OFeo1xzAi0y2DiicqS68he4KfFKE=;
  b=PWJs5RnyDA7l+p4uu0WHIvw57qOroAZMfHsXrB+a2dq1kCBjQZxovwGF
   5nv8xRTFKpgSzdmHJSuTgf1VgYKNarzBbW4RATqVylnHr3vtRA3OIvtHy
   7HSDcmFO/vJrFIhMfapPm7vQlqHirkAVU0/hd5nMwx8jv1X7+YAO49aPi
   GUrr0xdEsJ/8MJ8iaRjxOJgTjtnKgkAvhzBSo+k5MVT8aHGITEZRFrTiO
   FOvDlxxqobsd7qoPGkH/bw8BSb1ibdAl87ebO0gzdnww7e4EBbVCxbXoJ
   rKUM28vAIhvIk4flU4diWEIXzoF7sWGqZxazS4nFQuWv3iobk5Q1FvJbu
   g==;
X-CSE-ConnectionGUID: EsFHEUz3QOKcSHgjuiQ54Q==
X-CSE-MsgGUID: OB6TbK6bR+6w7kZXWij7fQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="20814396"
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="20814396"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 19:16:01 -0700
X-CSE-ConnectionGUID: /EVNWWnnRDWGAFoa5okH1Q==
X-CSE-MsgGUID: v37V+LvyQAee/Q757M641g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="26231973"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa009.fm.intel.com with ESMTP; 29 Apr 2024 19:15:58 -0700
Date: Tue, 30 Apr 2024 10:10:29 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: "Colberg, Peter" <peter.colberg@intel.com>
Cc: "Xu, Yilun" <yilun.xu@intel.com>,
	"linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
	"mdf@kernel.org" <mdf@kernel.org>, "Wu, Hao" <hao.wu@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"russ.weight@linux.dev" <russ.weight@linux.dev>,
	"Pagani, Marco" <marpagan@redhat.com>, "Rix, Tom" <trix@redhat.com>,
	"matthew.gerlach@linux.intel.com" <matthew.gerlach@linux.intel.com>
Subject: Re: [PATCH] fpga: dfl-pci: add PCI subdevice ID for Intel D5005 card
Message-ID: <ZjBTFViASK857NHL@yilunxu-OptiPlex-7050>
References: <20240422230257.1959-1-peter.colberg@intel.com>
 <ZispK+l5kWCxtfns@yilunxu-OptiPlex-7050>
 <0081a4ba1304f37142e6b1714d022fd4e7c9821f.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0081a4ba1304f37142e6b1714d022fd4e7c9821f.camel@intel.com>

On Fri, Apr 26, 2024 at 09:35:07PM +0000, Colberg, Peter wrote:
> On Fri, 2024-04-26 at 12:10 +0800, Xu Yilun wrote:
> > On Mon, Apr 22, 2024 at 07:02:57PM -0400, Peter Colberg wrote:
> > > Add PCI subdevice ID for the Intel D5005 Stratix 10 FPGA card as
> > > used with the Open FPGA Stack (OFS) FPGA Interface Manager (FIM).
> > > 
> > > Unlike the Intel D5005 PAC FIM which exposed a separate PCI device ID,
> > > the OFS FIM reuses the same device ID for all DFL-based FPGA cards
> > > and differentiates on the subdevice ID. The subdevice ID values were
> > > chosen as the numeric part of the FPGA card names in hexadecimal.
> > > 
> > > Link: https://github.com/OFS/dfl-feature-id/pull/4
> > 
> > Any reason to put the Link in changelog. I didn't see it provide any
> > extra info.
> 
> The link is provided to point to the corresponding change in the dfl-
> pci-ids registry, for someone who might not be aware of its existence.

I suggest you don't put it in changelog, few people care about
this downstream history.  Put it below '---' if really necessary. I
deleted this link when apply.

Thanks,
Yilun

