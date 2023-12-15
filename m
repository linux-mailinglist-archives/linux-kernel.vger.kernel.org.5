Return-Path: <linux-kernel+bounces-1251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18EC7814C6E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:05:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB3932858F4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 16:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C709D3BB25;
	Fri, 15 Dec 2023 16:04:47 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B28381D5;
	Fri, 15 Dec 2023 16:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="398084157"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="398084157"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 08:04:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="865445044"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="865445044"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 08:04:35 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andy@kernel.org>)
	id 1rEAfw-00000006ACe-1HeD;
	Fri, 15 Dec 2023 18:04:32 +0200
Date: Fri, 15 Dec 2023 18:04:31 +0200
From: Andy Shevchenko <andy@kernel.org>
To: tanzirh@google.com
Cc: Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org, Nick DeSaulniers <nnn@google.com>,
	Andrew Morton <akpm@linux-foundation.org>, llvm@lists.linux.dev,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v2 1/2] sh: Added kernel.h to word-at-a-time
Message-ID: <ZXx5DyidpHFhRevy@smile.fi.intel.com>
References: <20231214-libstringheader-v2-0-0f195dcff204@google.com>
 <20231214-libstringheader-v2-1-0f195dcff204@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214-libstringheader-v2-1-0f195dcff204@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Dec 14, 2023 at 09:06:12PM +0000, tanzirh@google.com wrote:
> This patch includes linux/kernel.h in asm/word-at-a-time.h for the
> sh architecture. WORD_AT_A_TIME_CONSTANTS depends on kernel.h.
> Making this implicit dependancy explicit allows for later improvements
> in the lib/string.c inclusion list.
> 
> Suggested-by: Al Viro <viro@zeniv.linux.org.uk>

You forgot your SoB, but...

...

>  #ifdef CONFIG_CPU_BIG_ENDIAN
>  # include <asm-generic/word-at-a-time.h>
>  #else
> +#include <linux/kernel.h>

I highly discourage from doing that. Instead, split what is needed to
the separate (new) header and include that one.

>  /*
>   * Little-endian version cribbed from x86.
>   */

-- 
With Best Regards,
Andy Shevchenko



