Return-Path: <linux-kernel+bounces-155372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C82418AE978
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 16:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8225C281F9C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09BD01DFED;
	Tue, 23 Apr 2024 14:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZG7vYlho"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82ED517BA8;
	Tue, 23 Apr 2024 14:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713882657; cv=none; b=LWwwdJgUznV7J0R50beaKX7f9rupIH6RxYfae7dcZohp3pYBUeCjhlxNTmk9We49Hgvi6H4RuCk9wmB9ZggU724Pz7J4TF/3eZXkd8g9LrABVvrGH+K4sWa/jAsXeduDWtFv7BcG1VHj4fBl7AXTjpPcw9kcB81R0HZ1bSso0Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713882657; c=relaxed/simple;
	bh=T41/P40s+6Zoo4IdYAoL4zuwWwRvlo4/hEyC/wAlqtc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=elY5nyGg3Mt/Ahh61neEa8L+tZx/jAxM6sQA4QBIhNTFmnBhmAGMZJjZKlI08OQqK/HZWE2xJ0+AT4AtVESsEoca1crKDDkPOnlY3mSKd/8Hli2XLdGJ0xNgu4z8fh84H0pwQIurKdD4jWEjmlGjPdKjh8B3E/P7dvLj5ktv/oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZG7vYlho; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713882655; x=1745418655;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=T41/P40s+6Zoo4IdYAoL4zuwWwRvlo4/hEyC/wAlqtc=;
  b=ZG7vYlhop1wL1gjnzeFVPl79lzWqRYHVELED0yzEYrkx/LetZpne1RH1
   ygU1j5vrp7zTfDDBKD70ZXip2ZannLGtq5CeLAj9RkDAaHYTKgtlepE04
   zGfjNoUSOqKMipKFpeRIEa0OrUn1760Loafcvd0rz6DisUQPSxl3+sxXn
   OvjKltuMw2qiBpdnj4VPdSc1AJLjEF+Qpvx0F9dT9Edp3WJ9vhwOi/lxA
   dEgkiBQhSWbGh402PmrNp0k+0mEWcVy6vRYtPq+ezbUnOVsMzMLMmhefy
   hxZNg2oqoQHg06XTMwWxhrVsARAZivOFvLaVhoYskvRs7iEvtup6stbKc
   g==;
X-CSE-ConnectionGUID: cOeyKSduRfuZXlASVQg1eg==
X-CSE-MsgGUID: JwSRjgK4SsSa3ILybEF7/A==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="9300606"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="9300606"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 07:30:54 -0700
X-CSE-ConnectionGUID: yne6HTRWSk2fp38YKxxq7A==
X-CSE-MsgGUID: wU3FDOt6RyewayGjLnCbUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="28884464"
Received: from fpirou-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.46.117])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 07:30:52 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, workflows@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v1 2/2] Documentation: process: Recommend to put Cc:
 tags after cutter '---' line
In-Reply-To: <20240423132024.2368662-3-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240423132024.2368662-1-andriy.shevchenko@linux.intel.com>
 <20240423132024.2368662-3-andriy.shevchenko@linux.intel.com>
Date: Tue, 23 Apr 2024 17:30:49 +0300
Message-ID: <871q6wrw12.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, 23 Apr 2024, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> The recommendation is based on the following rationale:
>
> - it makes the commit messages much cleaner and easy to read, especially
>   on the screens of the mobile devices;
>
> - it reduces resources (memory, time, energy) to retrieve all these
>   headers, which are barely needed by a mere user, as for automation
>   they will be still available via mail archives, such as
>   https://lore.kernel.org, assuming the Link: or Message-ID tag is
>   provided.

I find the information in the commit message useful, and it tells me who
were explicitly included in the discussion.

For example when fixing a regression I'd like to Cc everyone who was
Cc'd in the regressing commit. The drm subsystem maintainer tool
actually has a helper for doing just that. 'dim fixes <sha1>' digs up
all the relevant info.

The Cc's on the mailing list archive are harder to dig up, and do not
accurately reflect the same information. A lot of patches get sent with
more Cc's in the mail message than in the commit message.

BR,
Jani.


> Let's be environment friendly and save the planet!
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  Documentation/process/5.Posting.rst          | 4 ++++
>  Documentation/process/submitting-patches.rst | 5 +++++
>  2 files changed, 9 insertions(+)
>
> diff --git a/Documentation/process/5.Posting.rst b/Documentation/process/5.Posting.rst
> index 90a7fe2a85f2..157b3fc0087a 100644
> --- a/Documentation/process/5.Posting.rst
> +++ b/Documentation/process/5.Posting.rst
> @@ -276,6 +276,10 @@ for addition without the explicit permission of the person named; using
>  Reported-by: is fine most of the time as well, but ask for permission if
>  the bug was reported in private.
>  
> +It's recommended to locate the additional Cc: tags after the cutter '---' line
> +in the patches as it makes sure the commit message won't be polluted with them.
> +At the same time they will be available via email headers on the mail archives,
> +such as https://lore.kernel.org.
>  
>  Sending the patch
>  -----------------
> diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
> index 6775f0698136..0c898d9e00f5 100644
> --- a/Documentation/process/submitting-patches.rst
> +++ b/Documentation/process/submitting-patches.rst
> @@ -491,6 +491,11 @@ automatically converted to the Cc: email header and you do not need to
>  have an explicit ``Cc:`` tag, if the person is already mentioned by another
>  tag.
>  
> +It's recommended to locate the additional ``Cc:`` tags after the cutter '---' line
> +in the patches as it makes sure the commit message won't be polluted with them.
> +At the same time they will be available via email headers on the mail archives,
> +such as https://lore.kernel.org.
> +
>  Co-developed-by: states that the patch was co-created by multiple developers;
>  it is used to give attribution to co-authors (in addition to the author
>  attributed by the From: tag) when several people work on a single patch.  Since

-- 
Jani Nikula, Intel

