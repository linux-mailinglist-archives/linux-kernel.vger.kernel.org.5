Return-Path: <linux-kernel+bounces-9947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 494BD81CDB1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 18:41:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C359AB243A1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 17:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 314B328DDC;
	Fri, 22 Dec 2023 17:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h1nIouA7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0F324A09;
	Fri, 22 Dec 2023 17:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703266853; x=1734802853;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=WZamYqzzs9Xmm1nTXwdiLWmcvR3nl+x/q6EpuUCFBfY=;
  b=h1nIouA7wnAKu6wUtpQtB6slDa5u9J2EAU1s5xRxxlIS1icUoeQ6I5KC
   gEYJgLNpkPeYppkePfYQJEU59/k+/KFxuH5/JUWLEirKMNwzXseHUvT6v
   kxoXJGpvt2QLOqjNv8aUDSz4kjdVh4chLbcAiiDihtYgzuqvNsa0k4pws
   Edgq6BTEOlMGSI3qKhMkR5gfHr3KHrKlLxi1cQCTLkrqW8llKhVgNw0ft
   zetzWINGE5oI2vP6geehflSQZlxaSe0fTYZUaA/oA2I3/QPxvIWUWXtBW
   p3YH3MhXAfxgigNrjwr5ZKFk4UPmrFsdsCaPUHNY11dKxjuxGoI45tjmu
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="3382952"
X-IronPort-AV: E=Sophos;i="6.04,297,1695711600"; 
   d="scan'208";a="3382952"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 09:40:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,297,1695711600"; 
   d="scan'208";a="19096588"
Received: from yspisare-mobl2.ger.corp.intel.com (HELO localhost) ([10.252.50.156])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 09:40:49 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Vegard Nossum <vegard.nossum@oracle.com>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Vegard Nossum <vegard.nossum@oracle.com>,
 Breno Leitao <leitao@debian.org>, "David S . Miller"
 <davem@davemloft.net>, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH net-next] Documentation: add pyyaml to requirements.txt
In-Reply-To: <20231222133628.3010641-1-vegard.nossum@oracle.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20231222133628.3010641-1-vegard.nossum@oracle.com>
Date: Fri, 22 Dec 2023 19:40:46 +0200
Message-ID: <87a5q2rv8h.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, 22 Dec 2023, Vegard Nossum <vegard.nossum@oracle.com> wrote:
> Commit f061c9f7d058 ("Documentation: Document each netlink family") added
> a new Python script that is invoked during 'make htmldocs' and which reads
> the netlink YAML spec files.
>
> Using the virtualenv from scripts/sphinx-pre-install, we get this new
> error wen running 'make htmldocs':
>
>   Traceback (most recent call last):
>     File "./tools/net/ynl/ynl-gen-rst.py", line 26, in <module>
>       import yaml
>   ModuleNotFoundError: No module named 'yaml'
>   make[2]: *** [Documentation/Makefile:112: Documentation/networking/netlink_spec/rt_link.rst] Error 1
>   make[1]: *** [Makefile:1708: htmldocs] Error 2
>
> Fix this by adding 'pyyaml' to requirements.txt.
>
> Note: This was somehow present in the original patch submission:
> <https://lore.kernel.org/all/20231103135622.250314-1-leitao@debian.org/>
> I'm not sure why the pyyaml requirement disappeared in the meantime.

FWIW, not really specific to the patch at hand, but I'd always prefer
strictyaml [1] with schemas over plain yaml. You get strict typing and
validation of the data during parsing. It's pretty nice, maybe worth
looking into here.


BR,
Jani.


[1] https://hitchdev.com/strictyaml/



>
> Fixes: f061c9f7d058 ("Documentation: Document each netlink family")
> Cc: Breno Leitao <leitao@debian.org>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
> ---
>  Documentation/sphinx/requirements.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/sphinx/requirements.txt b/Documentation/sphinx/requirements.txt
> index 335b53df35e2..a8a1aff6445e 100644
> --- a/Documentation/sphinx/requirements.txt
> +++ b/Documentation/sphinx/requirements.txt
> @@ -1,3 +1,4 @@
>  # jinja2>=3.1 is not compatible with Sphinx<4.0
>  jinja2<3.1
>  Sphinx==2.4.4
> +pyyaml

-- 
Jani Nikula, Intel

