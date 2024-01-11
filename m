Return-Path: <linux-kernel+bounces-23336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D04B82AB3D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 10:50:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4932C1F2244E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 09:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762C511737;
	Thu, 11 Jan 2024 09:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TVI5MbJ8"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E30011722
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 09:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704966596; x=1736502596;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=tAsm8yoR5IypZ9Vanz2h/n8ymc/BnOwePGQki51WXUc=;
  b=TVI5MbJ8fT1LPauScwxjT98ysYAdO/aSXP4BODAGsKfTWZW3HmTbwlft
   KnMkl32k5RIyfBZFjGK06B85jhlk4AmzDkFuQEl8bT6a6SlY9dKrtyQUE
   NyEAEkM3MH/AYDZTKpxcDzD6Qvne9TScmvYu3kenGHKbV3Zrv4ftiUqQR
   sSVoq+Z1Ht0neJ/mkA4aaGvJoIVIZjDPsqIGCsE5ypz8CT5Mo4t5tPz+H
   3BE5u5bWOcJgZ+yiWQDr7VhF/mo/kH/yZHooI/X5f7IDqa0EuxYBmvlOn
   jfTP+3rdMkq+b++SoAHd+vA5Avp8dw4EkpzVw6k91rWMnO1LsOr4dsA8O
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="12284063"
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; 
   d="scan'208";a="12284063"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 01:49:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="1113781983"
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; 
   d="scan'208";a="1113781983"
Received: from gaertgee-mobl.ger.corp.intel.com (HELO localhost) ([10.252.54.206])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 01:49:51 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: GuoHua Chen <chenguohua_716@163.com>, tzimmermann@suse.de,
 airlied@gmail.com, maarten.lankhorst@linux.intel.com, daniel@ffwll.ch,
 mripard@kernel.org, patrik.r.jakobsson@gmail.com
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, GuoHua
 Chen <chenguohua_716@163.com>
Subject: Re: [PATCH] gma500: Clean up errors in psb_intel_sdvo_regs.h
In-Reply-To: <20240111070720.9602-1-chenguohua_716@163.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240111070720.9602-1-chenguohua_716@163.com>
Date: Thu, 11 Jan 2024 11:49:48 +0200
Message-ID: <87edeourlv.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, 11 Jan 2024, GuoHua Chen <chenguohua_716@163.com> wrote:
> Fix the following errors reported by checkpatch:
>
> ERROR: space required after that close brace '}'
>
> Signed-off-by: GuoHua Chen <chenguohua_716@163.com>
> ---
>  drivers/gpu/drm/gma500/psb_intel_sdvo_regs.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/gma500/psb_intel_sdvo_regs.h b/drivers/gpu/drm/gma500/psb_intel_sdvo_regs.h
> index 600e79744d68..e358a6b1bcce 100644
> --- a/drivers/gpu/drm/gma500/psb_intel_sdvo_regs.h
> +++ b/drivers/gpu/drm/gma500/psb_intel_sdvo_regs.h
> @@ -666,7 +666,7 @@ struct psb_intel_sdvo_enhancement_limits_reply {
>  #define SDVO_CMD_SET_TV_LUMA_FILTER			0x79
>  struct psb_intel_sdvo_enhancements_arg {
>      u16 value;
> -}__attribute__((packed));
> +} __attribute__((packed));

__packed is preferred over __attribute__((packed)) anyway...

BR,
Jani.



>  
>  #define SDVO_CMD_GET_DOT_CRAWL				0x70
>  #define SDVO_CMD_SET_DOT_CRAWL				0x71

-- 
Jani Nikula, Intel

