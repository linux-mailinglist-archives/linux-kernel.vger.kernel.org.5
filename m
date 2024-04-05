Return-Path: <linux-kernel+bounces-133216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6534F89A0A7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11CED1F21F78
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6BD316F848;
	Fri,  5 Apr 2024 15:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gk9nkiYV"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B7E16F293
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 15:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712329589; cv=none; b=Mk4kCPDrbXslzJ54GLA3Oq+sQHTV1vABZyNp9dB1S0FsZkteH/vqtV7goxzsaJTqdo64GSOkoi9vL+Q29y0f5NbbwjD1kea9IKfZprMRatvrrzmKLbOcghgEKhwYCUQz7vh+AkqEuD9DJOI/Bp2x2tDhZLGI59kabygy4lJ0UVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712329589; c=relaxed/simple;
	bh=qlwdvOusJure/L1Yv/zKMo5qRCUbM8BhZMF14KYnllA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=trB819HSHk9hXnaYFHpxL6I0HRpwrUUIiIHZHHXF3RHjlB/3KdJNwaZ4bI8Z8X7SaLBioUfEAnAvU3VP8OwnKu5HEugnAjEgjWp8YrIL0ajeEtOIjC/N9Wz8gMCNHgwhXvCUj/wJ/YhMGx8wtS04G8AT5zqh3QzmK2/fVQikPNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gk9nkiYV; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712329587; x=1743865587;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qlwdvOusJure/L1Yv/zKMo5qRCUbM8BhZMF14KYnllA=;
  b=Gk9nkiYV7l42BtmfbwsqM0sUEWDnVWPrjtI7nilwUBe1tIGTxKC4b34/
   VnsS7uy7nB8sGcfmDTS6+k+m/f86O+obBbf30pWG8ba96r8JX2VQ/m2RB
   Gy7KU2dY16P+gufb9tyjdN2NrROOpektKHG6Tjq38IQMohPrGrEUkclAN
   fcex3zHswOjngeSmKW3eHJj7BPYes6qKuYIlzbBMnPcwCjOqfTn1il2Vo
   za1qqDnBuK4iYUBS3SXLztZjAvUy6Irc5ed3w2HBUnJq6c82coHQds1Lp
   JFbT2+4gfAwJm8qP3odB6Bzhk2PE1xwMaFYGYiMBdl/qvkCE2kaNgXQfp
   w==;
X-CSE-ConnectionGUID: OkV1bZ8mSPWWuwJgIt/aPg==
X-CSE-MsgGUID: xXfvyW3CSs27TYs/qx/K7A==
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="18271642"
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="18271642"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 08:06:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="915256454"
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="915256454"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 08:06:23 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rsl92-00000001mBS-3ubw;
	Fri, 05 Apr 2024 18:06:20 +0300
Date: Fri, 5 Apr 2024 18:06:20 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Rob Herring <robh@kernel.org>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, Anatolij Gustschin <agust@denx.de>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Subject: Re: [PATCH v1 1/1] powerpc/52xx: Replace of_gpio.h by proper one
Message-ID: <ZhATbD18BhW9vnI8@smile.fi.intel.com>
References: <20240313135645.2066362-1-andriy.shevchenko@linux.intel.com>
 <Zg0yTnTswS2je9VG@smile.fi.intel.com>
 <871q7k8ytc.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871q7k8ytc.fsf@mail.lhotse>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Apr 05, 2024 at 10:58:55AM +1100, Michael Ellerman wrote:
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
> > On Wed, Mar 13, 2024 at 03:56:45PM +0200, Andy Shevchenko wrote:
> >> of_gpio.h is deprecated and subject to remove.
> >> The driver doesn't use it directly, replace it
> >> with what is really being used.
> >
> > Any comments on this?
> 
> No comment :)
> 
> I'll take it for 6.10, or do you want me to sneak it in as a fix for 6.9?

Up to you and thank you!

-- 
With Best Regards,
Andy Shevchenko



