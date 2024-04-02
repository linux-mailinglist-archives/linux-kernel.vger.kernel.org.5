Return-Path: <linux-kernel+bounces-127870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94104895200
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15E9CB22B77
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 11:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35988679FE;
	Tue,  2 Apr 2024 11:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hrz0FvWc"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2BB1F619
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 11:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712057937; cv=none; b=rQIYadvVhluSbqvMI3249BQiTbZcwnPHW6KKXOt6FWTQMVJNffGu/a9sLQ60BpLO1UmbLz78H1Mfl6/57Gul8EQziYY66aSm0F4HJZJxfyQhDldEXd5qMwQBqX0N06owvFsQdkB5fvOLGE8xpDJb/srm2mLP0szOJ1Ul3HNyBcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712057937; c=relaxed/simple;
	bh=vC3XgrPyprneuVAKwm2B87wMA3ERHZHeO7QwzGK1YY0=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=nqmkgRc8uak/RrIpEhOCmhbmAp3ROGSHyzlOe9ntOP9VwqFtzdH2GRvhQZDgJ79SXQ8xTCH0g5nRA29thzfn7hEcOsxPYZ44SY3dzT3fkAab1osCV877seMdJ/U5Clxv6HNuqH0tjGNFAhCum2DOBJpAKPl6S2V6X81hV8ix8Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hrz0FvWc; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712057936; x=1743593936;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=vC3XgrPyprneuVAKwm2B87wMA3ERHZHeO7QwzGK1YY0=;
  b=Hrz0FvWcWtPHY686cXUGWxvndor2aADKRAlgCAalFn+WWsGQXsEclszj
   rwMc33fVbsw9xOWWVHC+vMGQLkmEoogMaDsoBmJhPNrqcRqs7tjzP0SSU
   hicdoKX1QiWaWCXQpFnd/xkwrXdeX/N5c0/eA9ZKX4ij7+cjgmZBKceZc
   wkhLInesZD5A6O8rJyRbqIbLtI771TuQGl0P73k0QKIjB4+M/TBLKu0Nl
   QNFh/CnoYKzojvm/Y8weAK0b6jQBiO0N7NdNd82YRmV2OXrHN5g/XRqoD
   LGjKc8ZGJkKYNKwx9BAhi/eLv5iU/Tfv52GZfOoVoXlk2GbLjB5rqtKHq
   g==;
X-CSE-ConnectionGUID: 38cltsUKRyGYtcExi52xbg==
X-CSE-MsgGUID: r1MMrNa1TuSNXFvnAYQXrg==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="10184698"
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; 
   d="scan'208";a="10184698"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 04:38:54 -0700
X-CSE-ConnectionGUID: x/VeaTrMQR+D2WNOW6jGVA==
X-CSE-MsgGUID: BYgA3Tq8TnW/6mT9Exww5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; 
   d="scan'208";a="22726552"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.23])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 04:38:52 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 2 Apr 2024 14:38:48 +0300 (EEST)
To: Feng Chunguo <chunguo.feng@semidrive.com>
cc: Greg KH <gregkh@linuxfoundation.org>, 
    "fengchunguo@126.com" <fengchunguo@126.com>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    Jiri Slaby <jirislaby@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tty: serial: fixed uart irq maybe cause irq storm
In-Reply-To: <727f9378143988cc621a116574fe5252a8f42301.f0b607c1.a18c.4c73.a561.fef5700437ab@feishu.cn>
Message-ID: <7dd8f053-aaba-beaa-0f2f-118b0b1c2d85@linux.intel.com>
References: <1711963801-184362-1-git-send-email-fengchunguo@126.com> <2024040147-stinging-payback-04f5@gregkh> <727f9378143988cc621a116574fe5252a8f42301.f0b607c1.a18c.4c73.a561.fef5700437ab@feishu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1196340581-1712057626=:1019"
Content-ID: <c1d73548-550d-38a8-b8f2-66620195738d@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1196340581-1712057626=:1019
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <a190ba26-debc-8b3a-8088-63b1f4e7dcb5@linux.intel.com>

On Mon, 1 Apr 2024, Feng Chunguo wrote:

> Hi Greg KH=EF=BC=8C
>=20
> Sent this path again.
>=20
> =C2=A0the irq should not be turned off here, what happens if some data co=
mes in while this
> function is running?=C2=A0 Will it be lost?
> --> lost=EF=BC=8Cnot receive other irq.
>=20
> =C2=A0When the uart was switching the baud rate from one to other,=C2=A0 =
this issue can be
> reproduced.


>> This feels wrong,
>> the irq should not be turned off here, what happens if some data comes i=
n while this
>> function is running? Will it be lost? thanks, greg k-h

Changing rate always risks losing what's currently on wire due to timing=20
related corruption, I don't think there there's a way around that IRQ=20
being enabled or not.


--=20
 i.
--8323328-1196340581-1712057626=:1019--

