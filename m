Return-Path: <linux-kernel+bounces-15466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F09822C62
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 12:54:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50C001F232FF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 11:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29D418E3E;
	Wed,  3 Jan 2024 11:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OApK6385"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C1318E29;
	Wed,  3 Jan 2024 11:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704282834; x=1735818834;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=n/vnjjrsEvZOXJJT326FKEYl+/HDigv3czkS2CfPJT0=;
  b=OApK6385WL3gL4WQt6wEH5Y+qNfN1xgXacsFquXhM4nu0AVveDmZWm+X
   2/uzDmNTstDgAhR2rgfIZYlD36n88Q+GQ+sPqim+fqvqEQrh5NweLI9lY
   IRvpFWTRzZ0jj+/1ULpiTZBV2HePYJeM4F5sRFCpELZNbKsCz9nu+d70g
   CcAmBLxIWt9MoBceOGtLYw0KOFH3zhc4VhstbCQH/yeq4didHt2ILgTdQ
   pgf1BfmysEL9nDJoOa0euP6kEvw+MeOTqBdGq7SGIxfRZjdQCNogQ1uXm
   /OLwJWq4byxTN3djeEWhh1zM/I/Y9xGXLChA3N9N1qT6N0C1ZCturMEkQ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="376486991"
X-IronPort-AV: E=Sophos;i="6.04,327,1695711600"; 
   d="scan'208";a="376486991"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 03:53:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="953210478"
X-IronPort-AV: E=Sophos;i="6.04,327,1695711600"; 
   d="scan'208";a="953210478"
Received: from bergbenj-mobl1.ger.corp.intel.com ([10.251.211.32])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 03:53:51 -0800
Date: Wed, 3 Jan 2024 13:53:48 +0200 (EET)
From: =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
cc: jorge.lopez2@hp.com, Hans de Goede <hdegoede@redhat.com>, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] platform/x86: hp-bioscfg: Remove useless else
In-Reply-To: <20240103021746.5337-1-jiapeng.chong@linux.alibaba.com>
Message-ID: <9f34109e-fc90-d2d1-5bd7-87aa51fdc39f@linux.intel.com>
References: <20240103021746.5337-1-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 3 Jan 2024, Jiapeng Chong wrote:

> The assignment of the else and if branches is the same, so the else
> here is redundant, so we remove it.
> 
> ./drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c:544:3-5: WARNING: possible condition with no effect (if == else).
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=7817
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  .../platform/x86/hp/hp-bioscfg/passwdobj-attributes.c  | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c
> index f7efe217a4bb..18c60a847842 100644
> --- a/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c
> +++ b/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c
> @@ -540,14 +540,8 @@ void hp_exit_password_attributes(void)
>  		struct kobject *attr_name_kobj =
>  			bioscfg_drv.password_data[instance_id].attr_name_kobj;
>  
> -		if (attr_name_kobj) {
> -			if (!strcmp(attr_name_kobj->name, SETUP_PASSWD))
> -				sysfs_remove_group(attr_name_kobj,
> -						   &password_attr_group);
> -			else
> -				sysfs_remove_group(attr_name_kobj,
> -						   &password_attr_group);
> -		}
> +		if (attr_name_kobj)
> +			sysfs_remove_group(attr_name_kobj, &password_attr_group);
>  	}
>  	bioscfg_drv.password_instances_count = 0;
>  	kfree(bioscfg_drv.password_data);

When doing something based on a robot finding, please take a look at 
the related code and _think_(!) instead of just hitting send button. If 
you'd have done that, you'd have submitted a patch that cleans up the 
other (create) cases too, not just the one which your robot flagged.

I think this is the second time I've said this about the very same code 
construct to somebody which, disappointingly, turns out to be you:

https://lore.kernel.org/platform-driver-x86/2ec499b-c37e-0a9-c163-2a1591b56029@linux.intel.com/

Again I get an incomplete patch into my inbox because the previous review 
did not lead into an updated v2 patch. Please do not submit this patch 
again unless you addressed my review feedback.

-- 
 i.

