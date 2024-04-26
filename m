Return-Path: <linux-kernel+bounces-160165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86BBE8B3A15
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 16:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 486862829F6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 14:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1672E639;
	Fri, 26 Apr 2024 14:32:57 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD93B1FC4;
	Fri, 26 Apr 2024 14:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714141977; cv=none; b=cZX8NlbCiE0tribtFeqvWeeDcOcuF2OF96laU/CgslLLJuAlJNGys/ZapxUph82MbvCRVHE0w2DTKgUqeb5bGSaCdTUIv0vzcqjsmXaBFmIZAOAVeRmH23/4jeosaSafL58aYVuDAkJiA/ZvuzdN3jf3nJcUggmI6F//GHsh3QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714141977; c=relaxed/simple;
	bh=kuY2xevYet7iwELgIpHpbnhaszdDogTO2VH3y4LUsLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UXBdB3pJFIHAqCyzwNWNl4n25OeF44ue9Pxh0uhwQbvRrn5GcVMW4mZm9DYeRUS1oDji+h1q2b1IT0PA0EBpq+fDkGEQSTmJtcRlanyMCx7HAj6oSwgJyoJ+UhGluWGxZtI+EWKqwAxJ59caxtGiUn5wNEG1+T+FoUCfVJblGN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: yGUG0yxnSCumv48uPnsVLQ==
X-CSE-MsgGUID: TBbuBWBtTBq/zyWsfjiyKA==
X-IronPort-AV: E=McAfee;i="6600,9927,11056"; a="10092384"
X-IronPort-AV: E=Sophos;i="6.07,232,1708416000"; 
   d="scan'208";a="10092384"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 07:32:55 -0700
X-CSE-ConnectionGUID: 6nTkIPWhS2SY5XOJhJlJhg==
X-CSE-MsgGUID: qZLUUijfTKOI8QBpnXYuXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,232,1708416000"; 
   d="scan'208";a="25508048"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 07:32:51 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andy@kernel.org>)
	id 1s0Md4-00000001LW3-3zOv;
	Fri, 26 Apr 2024 17:32:46 +0300
Date: Fri, 26 Apr 2024 17:32:46 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Konstantin Pugin <rilian.la.te@ya.ru>
Cc: krzk@kernel.org, conor@kernel.org, lkp@intel.com, vz@mleia.com,
	robh@kernel.org, jcmvbkbc@gmail.com, nicolas.ferre@microchip.com,
	manikanta.guntupalli@amd.com, corbet@lwn.net, ychuang3@nuvoton.com,
	u.kleine-koenig@pengutronix.de, Maarten.Brock@sttls.nl,
	Konstantin Pugin <ria.freelander@gmail.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Lech Perczak <lech.perczak@camlingroup.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v9 1/3] serial: sc16is7xx: announce support of
 SER_RS485_RTS_ON_SEND
Message-ID: <Ziu7DpoHGLrURI_9@smile.fi.intel.com>
References: <20240425183251.174412-1-rilian.la.te@ya.ru>
 <20240425183251.174412-2-rilian.la.te@ya.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425183251.174412-2-rilian.la.te@ya.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Apr 25, 2024 at 09:32:33PM +0300, Konstantin Pugin wrote:
> From: Konstantin Pugin <ria.freelander@gmail.com>
> 
> When specifying flag SER_RS485_RTS_ON_SEND in RS485 configuration,
> we get the following warning after commit 4afeced55baa ("serial: core:
> fix sanitizing check for RTS settings"):
> 
>     invalid RTS setting, using RTS_AFTER_SEND instead
> 
> This results in SER_RS485_RTS_AFTER_SEND being set and the
> driver always write to the register field SC16IS7XX_EFCR_RTS_INVERT_BIT,
> which breaks some hardware using these chips.
> 
> The hardware supports both RTS_ON_SEND and RTS_AFTER_SEND modes, so fix
> this by announcing support for RTS_ON_SEND.

Greg KH, who is maintainer of TTY/serial subsystem, usually asks to separate
fixes from new features. So, sending this patch separately may not only help
him, but let's move forward with your stuff.

-- 
With Best Regards,
Andy Shevchenko



