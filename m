Return-Path: <linux-kernel+bounces-150259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 566C48A9C6D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 855641C223AF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7726C165FA3;
	Thu, 18 Apr 2024 14:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HVizdDv9"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16ACC168AEC;
	Thu, 18 Apr 2024 14:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713449735; cv=none; b=p59Nze+E0kNqYaqgTX2BYE/h40I88yR5VC/NYj7jPfvN+6DKhB+EFHUaobPXfL2b3pgI/jo9YowisV/3OFmOOIeECPpp7sXwG9T6JgmKMG4QbCpapgdggcrQQkeHkytPvXvDh/iAmcR5WPhAvjy1f5vax4QfxNpuJJcHb5QnVxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713449735; c=relaxed/simple;
	bh=D/6CKRz9vtbz2zHovt0ctEJHyndLcbRGWPyqRG8nd6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fl7/KehBUmLWQ8pxo1yXCmQ0Mo/cAHDrta/SjAsNAJvuwF+zMwxczfLLyq41DmnGyqn+uTkm9xeKO7nMOa8okeyds1ZxGlqCHL0KIzOYGDypdhdtilbITOmtWM69qy6rBsNLLitKY4qkX9G3/VWT47WVShMEE1Zv/NqtbLlaHdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HVizdDv9; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713449734; x=1744985734;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=D/6CKRz9vtbz2zHovt0ctEJHyndLcbRGWPyqRG8nd6E=;
  b=HVizdDv94qu5vTXUyvjE5Tu5dH4XGbvwfeT4JRGXyAo3lWG0EMJiYPVU
   2kXAeZAQSV3zQ186fIH+/TaWQNQsZz0x54Hgi/XcrWttu3eV5XPKatXhU
   lDsMqPxVK9uAPwAaUBIvW+79srIacwR+/DYJjDuT1aMXb7gnMhxkJNti2
   v1z+Wxu8hBfJRXVGXzPqnmmAjY+p2xlPPvEHxGoGuwSnHSJbw9ZQPnMtv
   egoSar2JZClLbfeeN7dEKg5pZJTMa4wS85Ho0Mm0+sgMqA/rQPjUyl/s5
   Kel+21NYJWUqXAA+vfCoEBAKQJBBdanqXc8MCF2K/NeDicXWvjzWfCGoz
   Q==;
X-CSE-ConnectionGUID: m2xaYCfySAabwvazSZpdmQ==
X-CSE-MsgGUID: UB0Izb9CQ2q7OtJu1pOFhQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="9169566"
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="9169566"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 07:15:33 -0700
X-CSE-ConnectionGUID: 4k8z2oa0T9C0tyDuLMmMKw==
X-CSE-MsgGUID: BVXsXf+ORvyMogrEhpp6Cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="27773079"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 07:15:29 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rxSXu-00000000Lfk-0Afm;
	Thu, 18 Apr 2024 17:15:26 +0300
Date: Thu, 18 Apr 2024 17:15:25 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Konstantin Pugin <rilian.la.te@ya.ru>
Cc: Konstantin Pugin <ria.freelander@gmail.com>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Lech Perczak <lech.perczak@camlingroup.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/3] serial: sc16is7xx: Add bindings documentation for
 EXAR XR20M1172 UART
Message-ID: <ZiEq_dXgxrRBWDSo@smile.fi.intel.com>
References: <20240418135737.3659498-1-rilian.la.te@ya.ru>
 <20240418135737.3659498-3-rilian.la.te@ya.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418135737.3659498-3-rilian.la.te@ya.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Apr 18, 2024 at 04:57:33PM +0300, Konstantin Pugin wrote:
> From: Konstantin Pugin <ria.freelander@gmail.com>
> 
> This patch adds the devicetree documentation for the XR20M1172 UART.

Submitting Patches document says something about "imperative mood", please
read that document in full anyway as it has a lot of nice requirements and
recommendations.

..

>        - nxp,sc16is752
>        - nxp,sc16is760
>        - nxp,sc16is762
> +      - exar,xr20m1172

Wouldn't it be better to keep it alphabetically ordered (at least avoid
bringing more chaos if it's not ordered originally)?

-- 
With Best Regards,
Andy Shevchenko



