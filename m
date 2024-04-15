Return-Path: <linux-kernel+bounces-144979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7253F8A4D8B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD2FCB224A9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 11:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1D05F54D;
	Mon, 15 Apr 2024 11:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B4TCCscZ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92AB1E896;
	Mon, 15 Apr 2024 11:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713180109; cv=none; b=dFkBj9mNUfimJnJ0RZFdBmm85NJwR3rR/U81UzJlJ6ir9Ii0sGQ4TrJbRUfcuYK6hFshv+mngeR1W9MPFwvI0b4eX8c+KhF2CXCjy1TONT7w3HDDlVCiggiTdjySBlHyACU2r3Nn9M3hV2YA+ZBxmBiPNYQNLhpfsIW4aRytAT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713180109; c=relaxed/simple;
	bh=sWIR7btRXBx7+IBOBxrzrqS7BWtoqCpvVr4Yb0Em0y0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=URTqFuL0052uvDfrZ7f9MclTLX/p5NWHE5HQBG51R7uiy0Xwyijyg1WKTO0NAavWzCVHntRMWGJy3IWd4zhmgdwtrx9eEpvoHQR99lXXT25rn+flcNcyMjcW+Mn8MoSB9nsPrW2e14dZireMg1a+ObhN5++lJDVpXOK+vF05Ec4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B4TCCscZ; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713180107; x=1744716107;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sWIR7btRXBx7+IBOBxrzrqS7BWtoqCpvVr4Yb0Em0y0=;
  b=B4TCCscZLyPWqn9iCklvFYaGx7I5EkXSCEFVNwTtYBOEdAWAt4EfXCe7
   9BkhS2c8rquDlot8lIqCgkd6qYQ6rh61W81Hz3sZ+MgCHa229cpIc3egG
   MGeqZibLuJWbQDSaorsC1gvtWxr+T0Ky9kGrRs4yBsG1xhP5FrFLgJh2w
   plLWqdBpPwa7Sybm8sUQUnhi3IxBlRGfzds60lu5pgLt/ExIQgORWuOIQ
   RK9EEivyk4H4F6eOS3QtuVopIuP2u5lD4ba9zNcDlht/qVUMDwLcx4EBs
   wbhibg8U/zze3CuKtlk1UmDzNw2shyL1CiUF9IfcUdTxygLuZC1YmLXe2
   w==;
X-CSE-ConnectionGUID: vpl/pwySRIOYngpyZ3YozA==
X-CSE-MsgGUID: BEoS1rn2Rk6uN2FTjAfCqw==
X-IronPort-AV: E=McAfee;i="6600,9927,11044"; a="8784086"
X-IronPort-AV: E=Sophos;i="6.07,203,1708416000"; 
   d="scan'208";a="8784086"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 04:21:46 -0700
X-CSE-ConnectionGUID: DK23tnP7QXaFNZtjvzC77Q==
X-CSE-MsgGUID: Wl4Cc+QpROe5LKoBdFIsSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,203,1708416000"; 
   d="scan'208";a="21956767"
Received: from unknown (HELO intel.com) ([10.247.119.21])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 04:21:38 -0700
Date: Mon, 15 Apr 2024 13:21:32 +0200
From: Andi Shyti <andi.shyti@linux.intel.com>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Andi Shyti <andi.shyti@linux.intel.com>,
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] drm/i915: remove redundant assignement to variable
 err
Message-ID: <Zh0NvAwxl1xmyNFd@ashyti-mobl2.lan>
References: <20240415095659.482989-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415095659.482989-1-colin.i.king@gmail.com>

Hi Colin,

On Mon, Apr 15, 2024 at 10:56:59AM +0100, Colin Ian King wrote:
> The variable err is being assigned a value 0 that is never read, the
> break statement escapes a do-while loop and then the code returns
> without referencing err. The assignment is redundant and can be
> removed.
> 
> Cleans up clang scan build warning:
> drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c:1075:5: warning: Value
> stored to 'err' is never read [deadcode.DeadStores]
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>

Thanks,
Andi

