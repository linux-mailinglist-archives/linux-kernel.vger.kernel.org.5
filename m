Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF8FE7E65BF
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 09:54:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233958AbjKIIyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 03:54:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233778AbjKIIyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 03:54:00 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D7BE8;
        Thu,  9 Nov 2023 00:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699520039; x=1731056039;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=AKewn8lnVPeW7TT49RAuya689cCvDvk9g/ibws78Eyo=;
  b=VKUQLWBysRsaOvMHbpSLZZpiGXeCQu0s9b4PKdw/CkVCkQJu6NIwH0Dm
   VSFQMRrq92C13/xITyzUmCuLZCb+8uOF5Y6BzWFfEby2shS5/s0Dmys5n
   BK1p1QlQgD+SFn+QRz5u2dP22AE6R/LMCi4YLsbqC5Y6YY776gws0ko+t
   riXYm5MPHgGprlFgzAF2wNp3UlPCsTY2Q74mgCb9u4xiGyMqbprOKIu/h
   OfwQ1rDLq+GOz2UL+MOEKpdgo6F/FA2d0lJs5S9KfIMbso9d50xbaLdsT
   kD0XAGbUy4CRSgrMIMWz39pnD5xGPm+LHAt5agpZ6sFt21cpWrQ0Ra+cT
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="2912162"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="2912162"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 00:53:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="756824836"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="756824836"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO ijarvine-mobl2.mshome.net) ([10.237.66.38])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 00:53:56 -0800
Date:   Thu, 9 Nov 2023 10:53:49 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Ai Chao <aichao@kylinos.cn>
cc:     Hans de Goede <hdegoede@redhat.com>, markgross@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v6] platform/x86: inspur-platform-profile: Add platform
 profile support
In-Reply-To: <20231109021533.62939-1-aichao@kylinos.cn>
Message-ID: <fad13328-4246-3659-a887-2dd5ead262f2@linux.intel.com>
References: <20231109021533.62939-1-aichao@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Nov 2023, Ai Chao wrote:

> Add support for Inspur platforms to used the platform profile feature.
> 
> This will allow users to determine and control the platform modes
> between low-power, balanced and performance modes.
> 
> Signed-off-by: Ai Chao <aichao@kylinos.cn>
> ---
> 
> v6: Remove comment for inspur_tmp_profile
> v5: Rename inspur-wmi to inspur_platform_profile
> v4: Add select ACPI_PLATFORM_PROFILE
> v3: Remove input device, using the platform profile interface
> v2: Remove Event GUID, remove inspur_wmi_notify and inspur_wmi_notify.

Hi,

I already took your v5 and it has since made also into Linus' tree.

If you want to make further changes to the driver, place them as 
incremental changes on top of what's already included, thank you.

-- 
 i.

