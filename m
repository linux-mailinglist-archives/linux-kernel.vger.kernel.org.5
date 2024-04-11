Return-Path: <linux-kernel+bounces-140329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F88D8A12DC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 615311C211AE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6211482EF;
	Thu, 11 Apr 2024 11:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YoZ7vomS"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210A4147C86;
	Thu, 11 Apr 2024 11:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712834438; cv=none; b=kF7JadaQ6rqQGQ813AZPrnAOThZVXEDpSX7jUv+F2dHzqrgAUjIzf8Dunw/p2jjGK3+AlwTwpL3vzL3FYjUnwyqlt3lT40+H3++Wv6us5tz4E/Dm8xyLjMQicqB1R9hkRNxTBGpRu1UZEWuSjE0GDe3SU47eVzSvqa9qllTeNWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712834438; c=relaxed/simple;
	bh=+926ajbsXSpyzZveFO9nj3gRQLdTdIRLCaK6UzM314k=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=WqTVy+LzS+tzEcPpzp1WeBZzyVKoRlgwfWuY5wmM0su6Q8olg7u959Y5i27cmF6sMwIY+L2aPKr9x6uZMrecN2U/3RfNjb9GxJ3AZ51FZfwvrmzkMI1w2zUaJ4zOY57+xi0NmF2Bl2hyCgVQ3pLju/N8/BHeEKvywTkgpkqVhV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YoZ7vomS; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712834438; x=1744370438;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=+926ajbsXSpyzZveFO9nj3gRQLdTdIRLCaK6UzM314k=;
  b=YoZ7vomSdPBuB/icjZHsGpWdVk71ddE6Z8fzKnl4/D2ehds0p1GeLJ2y
   Mg9DdYBW7o3Rz/dY9CbRwttH0ayjvUiGVR7XOzMUG69xk88Bn5MhaDzH3
   BLudOoDzKQ5bZYT8BpZ3hEb1D2C1o4zesBLLK/uYYwazsk0ciWWRSMyoc
   /35QlCbCmfZE9xrfs9ZofZluN07FzHE7+8I6oGTPqfutOCjoRZiwwgmLo
   LTFyIReM3qSW4Tfogh4f5V2osnytbjXfklRnhpxa/mAwc64AMtCUtn56p
   ZaGXX58EkPJBKCqcqSsLDzgFeW9jG2hp85zr0kxUwcRaiCdZ3y3eH/83u
   w==;
X-CSE-ConnectionGUID: VVDW2VAuRWqrQ36VZVunyA==
X-CSE-MsgGUID: vx/xG8M3Rkivs28jjNDsbA==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="12016020"
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="12016020"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 04:20:37 -0700
X-CSE-ConnectionGUID: VRGMNC62R4+HcPuzvSo5zA==
X-CSE-MsgGUID: stVam8kfTNqJBnaEOAyVGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="21366764"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.30])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 04:20:34 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 11 Apr 2024 14:20:29 +0300 (EEST)
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    LKML <linux-kernel@vger.kernel.org>, 
    linux-serial <linux-serial@vger.kernel.org>, 
    Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v1 1/1] serial: max3100: Convert to_max3100_port() to be
 static inline
In-Reply-To: <20240410141135.1378948-1-andriy.shevchenko@linux.intel.com>
Message-ID: <0efff014-43a2-b1e2-6690-515a6b2a3edd@linux.intel.com>
References: <20240410141135.1378948-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-94683981-1712834247=:1017"
Content-ID: <b296fc51-820a-5172-1f94-14d0777a60c8@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-94683981-1712834247=:1017
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <d4ccf212-a95c-7bf6-6d13-d12ae3696795@linux.intel.com>

On Wed, 10 Apr 2024, Andy Shevchenko wrote:

> As Jiri rightfully pointed out the current to_max3100_port() macro
> implementation is fragile in a sense that it expects the variable
> name to be port, otherwise it blow up the build.
>=20
> Change this to be static inline to prevent bad compilation.
>=20
> Suggested-by: Jiri Slaby <jirislaby@kernel.org>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/tty/serial/max3100.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/tty/serial/max3100.c b/drivers/tty/serial/max3100.c
> index 1e6b5763ce3f..07ee001640bb 100644
> --- a/drivers/tty/serial/max3100.c
> +++ b/drivers/tty/serial/max3100.c
> @@ -111,7 +111,10 @@ struct max3100_port {
>  =09struct timer_list=09timer;
>  };
> =20
> -#define to_max3100_port(port)=09container_of(port, struct max3100_port, =
port)
> +static inline struct max3100_port *to_max3100_port(struct uart_port *por=
t)
> +{
> +=09return container_of(port, struct max3100_port, port);
> +}
> =20
>  static struct max3100_port *max3100s[MAX_MAX3100]; /* the chips */
>  static DEFINE_MUTEX(max3100s_lock);=09=09   /* race on probe */
>=20

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

It seems liteuart has the same trap.

--=20
 i.
--8323328-94683981-1712834247=:1017--

