Return-Path: <linux-kernel+bounces-160257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F44C8B3AEC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE86E1C24BE0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E56149007;
	Fri, 26 Apr 2024 15:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FxQYq5yi"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B96D149E0B;
	Fri, 26 Apr 2024 15:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714144338; cv=none; b=Lc+3SUnLEBjTVUffM9clPxunwNUBGLeyTJuMFx4Lt/3pfXiAOMIBNav3zSSH6HvR/CoXI1EuxBxsZ6BD1M+PhDUD3fj3FFVntT90M/adCjiU5qgBYrJp8RN/8k1RHv21G2VPyFEDZZXBMxAvMR0gUgxJ1Lj1cc+4YaS2HVodfDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714144338; c=relaxed/simple;
	bh=Kr7zkCguCy7sd6KYvhCOQrIp4hZGHM6YPuaMgfJqxPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P3UNlhAP0n0YKhSlqUKAAqmwPY1qsC1Y9luC6glzZNet85VTauJEwxSdE7HADBpxXWLKUCBzRTQQrT+inUlaYSFDDIYdpqm3OlAMRk24jLXiWXxIXBlFqFG9/T76yIiNIfmsMIKTLbW/LNWYKx6QWOtAADvbGr0HuOB7AsnxdRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FxQYq5yi; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714144337; x=1745680337;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Kr7zkCguCy7sd6KYvhCOQrIp4hZGHM6YPuaMgfJqxPc=;
  b=FxQYq5yiRC7LP4dgn4cZW60JU7I6AgCJew9LblKfe7HlCVKmhuTDhi1j
   1kSZSgZhYeyFPLzZsF/t404YqCpJBlvE1fojlcXsnJDypQri+ZbjvTOpM
   znlBmNEOaNUK0mejty0SxKAnj46g9zc2zKISJDHXDyryUt9A1X4DfYS92
   b0MszfmzP0HbLcwyzlNhaffsfgYxpo7cATOr4DrYdWFEWiQERpVOarY7o
   7xxlasBAPuJK9bLdcFC3uh9VXU42PfxwD+GOTpUooqmOkwm/qA1iy9u57
   U5C6vsgQCmvJnaUjmtwaznVAeA2VtjLQgOMa7kYaWoktgxVoBk6SFOmP2
   Q==;
X-CSE-ConnectionGUID: aR5Lcj7oSTSCdvhb78Q6Rg==
X-CSE-MsgGUID: m4Ior/4ISQaJhW5FXbAQxg==
X-IronPort-AV: E=McAfee;i="6600,9927,11056"; a="35269947"
X-IronPort-AV: E=Sophos;i="6.07,232,1708416000"; 
   d="scan'208";a="35269947"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 08:12:16 -0700
X-CSE-ConnectionGUID: 1Vj0lcevTuKqc1CFgpQSqQ==
X-CSE-MsgGUID: 3IVWF+mHTcyfIYnSZvM35w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,232,1708416000"; 
   d="scan'208";a="25520161"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 08:12:11 -0700
Date: Fri, 26 Apr 2024 18:11:56 +0300
From: Tony Lindgren <tony.lindgren@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Claudiu <claudiu.beznea@tuxon.dev>, gregkh@linuxfoundation.org,
	jirislaby@kernel.org, tony@atomide.com, l.sanfilippo@kunbus.com,
	tglx@linutronix.de, geert+renesas@glider.be, ulf.hansson@linaro.org,
	peng.fan@nxp.com, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-pm@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [RFT PATCH v2] serial: core: Call device_set_awake_path() for
 console port
Message-ID: <ZivDpyUgTinFbQh4@black.fi.intel.com>
References: <20240425070936.547100-1-claudiu.beznea.uj@bp.renesas.com>
 <ZionWJ7ods60zuYX@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZionWJ7ods60zuYX@smile.fi.intel.com>

On Thu, Apr 25, 2024 at 12:50:16PM +0300, Andy Shevchenko wrote:
> The rest makes sense to me as we also have an internal hack to achieve
> something similar in the case of Intel LPSS (8250_dw).
> 
> But I like Tony to comment on this, from my perspective it's good:
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Yes nice, makes sense to me too:

Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>

