Return-Path: <linux-kernel+bounces-166122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18BBB8B9685
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 10:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C58BE1F24094
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 08:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297C84F88A;
	Thu,  2 May 2024 08:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lXSlvT5k"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C42647F51
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 08:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714638798; cv=none; b=bU7oTTqTUOqUfrmyVwywunlyZf3wN6J0hX4MPUco3Cv/7nD1S/n7BE4PssCaiBAAP52iy6uUeua1zqbaxGuZ+YVMjV2JHp8mz3V3+OKCbRbP5SVdp6WJQ71RVnvlvFDN+8dbWeyuyNu2pbEs/0Su40hli3uadreiUsMGBN8dbCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714638798; c=relaxed/simple;
	bh=0Gpee/NqFKNgoGOPbM0o0bCoRxmPnYe9lCHdjc5Qrws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cv3EpO/shjP/v6xHSXaAodOtrYTdvr5ki86znFzRydzOeGpaD7rpBw3xVxZNnEG+nvqPd2FGKiYbmUBlBsaCRqGUO52U6lE9JFxkGkySFtOlxtLy8c5BoR84fc1LdQo8vWcrsLtvlCHbCl8GT+NPPl+WZeJt+xyPIg0h9lSjBoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lXSlvT5k; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714638797; x=1746174797;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0Gpee/NqFKNgoGOPbM0o0bCoRxmPnYe9lCHdjc5Qrws=;
  b=lXSlvT5kP0+GJ3P2LpY/zTmP/ClVRjoPyBhIIkgDmtMVQxIYt/KH3J0M
   /G4cZYsnxaOD2fD9jzhIHk9YwxDf6cXElk82rkjvvS9wwcfzwpZFK0c5V
   7VMYCriUTN24emaYJATh1blRQbGeeSysooylrEyqxGjIMfxZgShVBcYMu
   DVRSNAkAOqFHlXdq2VBuduGJ5PMnQ6cD7OwscC+crl3zDv9GT3kI+2MQY
   T7HCAqiNecBB00mpyQuT1N0h6G/U7tUSEr/bsxW4WxA++hccUIL72hB3d
   mBSx2GQ+qAWM1AK4l0n4aDSm+BdaSXwd7EkLqTJkQGwzeTee+KZJJRQIJ
   w==;
X-CSE-ConnectionGUID: n94dLELeT9+9Bzb13JnV5Q==
X-CSE-MsgGUID: 1EP8a/C+SvWta7t1bGwc7Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11061"; a="35784267"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="35784267"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 01:33:16 -0700
X-CSE-ConnectionGUID: 4GKmb5v5RWmKohTBcarF8w==
X-CSE-MsgGUID: qyXn1F0WTBW3Urdr3qJUjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="31532997"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 01:33:13 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s2RsL-00000003FHO-466P;
	Thu, 02 May 2024 11:33:09 +0300
Date: Thu, 2 May 2024 11:33:09 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Maxime Ripard <mripard@kernel.org>,
	Sui Jingfeng <sui.jingfeng@linux.dev>,
	Randy Dunlap <rdunlap@infradead.org>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [v1,1/3] drm/panel: ili9341: Correct use of device property APIs
Message-ID: <ZjNPxU_JJX_3o6-0@smile.fi.intel.com>
References: <20240425142706.2440113-2-andriy.shevchenko@linux.intel.com>
 <c2d41916-0b6c-43b5-98eb-514eb0511f84@linux.dev>
 <ZiqqiAztCaiAgI8e@smile.fi.intel.com>
 <2599705c-0a64-4742-b1d7-330e9fde6e7a@linux.dev>
 <20240426-married-augmented-mantis-ff7edd@penduick>
 <509b3822-dcf6-45eb-9516-ba8ff2cc4382@linux.dev>
 <20240429-bouncy-attentive-vole-9964f1@houat>
 <795bec5d-c7ba-4fc2-9be9-78c4063743d9@linux.dev>
 <20240430-unnatural-steel-spaniel-dbacef@houat>
 <75a89efb-f653-4185-a451-ef496dffd804@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75a89efb-f653-4185-a451-ef496dffd804@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, May 02, 2024 at 09:34:17AM +0200, Neil Armstrong wrote:
> On 30/04/2024 11:34, Maxime Ripard wrote:

..

> Anyway since the rant is finished I'll land the patches.

Thank you all for the review and discussion!

-- 
With Best Regards,
Andy Shevchenko



