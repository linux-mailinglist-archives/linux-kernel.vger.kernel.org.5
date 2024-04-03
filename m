Return-Path: <linux-kernel+bounces-129542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C13D4896C59
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 532EF28AC41
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B47713E413;
	Wed,  3 Apr 2024 10:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ov7o+Abw"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521A313DDB6;
	Wed,  3 Apr 2024 10:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712139983; cv=none; b=tvBKcMWTaO1fDk98V1S9JPbTUmcSJrWDttUE75lTiBISENz8sOZ7guSD4ky2tqVs/CpRgY7QHX395Ck9qmNCFp+QSn6JeBKnAgZXZ9M87A19OWc7rPXuGpIs9m70AG7KqHcwDb7ee8GKiR9H6ppf9fDW1mNHwNG3lwYzNhARPh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712139983; c=relaxed/simple;
	bh=uvNwH5AhBZRtd1Efkm5wZZSPyGfV9X51E6xAbQSgfX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rsdi2fJsHzYzY4DKZ0AyAbAHr/tiMDeNPfhZgS2DX4RDF7yRfTyo2pdahFhjkkSUs/1qhA8s4zmI3n1YCnnSC6XmBdtJ2KuoHSphNbFEAWhwGQGNr/W9RKDMeG5cvdVbM+FjxEg1XPQdj43McCON8yt9YhJ+1iL8irW7rP942wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ov7o+Abw; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712139982; x=1743675982;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uvNwH5AhBZRtd1Efkm5wZZSPyGfV9X51E6xAbQSgfX8=;
  b=Ov7o+AbwwjdyFK29sjbufrRU6K/4YUlbP78JXW/SE7rlrjQRGET43vWW
   8VKnzX2TKQQBcC4hNUcEyHsEFtoNTGzDKNjsF/2OM4Fr0+IGVGr4IR35v
   DEy21VzBMTkRWGjc+ZNgMJiMwv0TTJlALoQV7sPuS2yPKze6FjQ/F/vNf
   mzZCJscBXvbo6JwNRIwJWC50KilvZZIJWp2kHOTFCbS1TkbFHmkwAW3T5
   L5bJL5PucwhxJcS2FSQzLpteG/W0ecnpl51WzF2oxH6Xnh/dTzOFt1SSO
   zFEZpwUuX9noCA7QpIjm3NjSlNB0KEhkXNOouVBblxBOeu0Mo+JQWKvd4
   A==;
X-CSE-ConnectionGUID: T3SuE+qqSC6Arvc0hpGW+A==
X-CSE-MsgGUID: 7Q5xrgK/QY+fqUb9VG/66Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="7283162"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="7283162"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 03:26:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="937084819"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="937084819"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 03 Apr 2024 03:26:19 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 03 Apr 2024 13:26:18 +0300
Date: Wed, 3 Apr 2024 13:26:18 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Ran Wang <ran.wang_1@nxp.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] usb: typec: displayport: drop driver owner
 assignment
Message-ID: <Zg0uyrXJVzGirRkY@kuha.fi.intel.com>
References: <20240331091737.19836-1-krzk@kernel.org>
 <20240331091737.19836-3-krzk@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240331091737.19836-3-krzk@kernel.org>

On Sun, Mar 31, 2024 at 11:17:37AM +0200, Krzysztof Kozlowski wrote:
> Core in typec_altmode_register_driver() already sets the .owner, so
> driver does not need to.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> 
> Changes in v2:
> 1. New patch
> ---
>  drivers/usb/typec/altmodes/displayport.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/altmodes/displayport.c b/drivers/usb/typec/altmodes/displayport.c
> index 038dc51f429d..596cd4806018 100644
> --- a/drivers/usb/typec/altmodes/displayport.c
> +++ b/drivers/usb/typec/altmodes/displayport.c
> @@ -802,7 +802,6 @@ static struct typec_altmode_driver dp_altmode_driver = {
>  	.remove = dp_altmode_remove,
>  	.driver = {
>  		.name = "typec_displayport",
> -		.owner = THIS_MODULE,
>  		.dev_groups = displayport_groups,
>  	},
>  };
> -- 
> 2.34.1

-- 
heikki

