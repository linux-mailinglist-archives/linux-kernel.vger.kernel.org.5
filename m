Return-Path: <linux-kernel+bounces-127782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1BF08950E7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 776391F250BF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0ABF612EB;
	Tue,  2 Apr 2024 10:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fCFt9vPF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD9960B96;
	Tue,  2 Apr 2024 10:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712055124; cv=none; b=roQ+Szsffh9Ke8SwmJDpcNwkuOubYv2m2ZUS1vtR4svFPOAmVzDvUn0sZUtI5xzOIiEWF7jhnDsnywgMiSXC7x5PMA8iLkf95qdPUPNWm9jsxsiyox60YBTYbdgLWmDZBiMb74Do6Nj+MUNaS75JyVVxy8oFe2r6HcODt/q792k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712055124; c=relaxed/simple;
	bh=A8AaFaL3w5DJbHE4SKRS5Q3KuH9zLFOX+N22LSkqwYU=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Kxx+Epcxrv5dOJNf/5Pl5D+r0+SQEC7w1uDqOiFEuYR/HZ7lRpRBx2b6cf1DQmhBHG9qHknb1GrxudpW/JieJ40ZB32IAQ61dPASbxCAC7tmLXP3yf5C8GTw69eDLdxmeF9t9oQIQSkm353zJUVxuXwaE4YWPWYM6nIStahFIK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fCFt9vPF; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712055122; x=1743591122;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=A8AaFaL3w5DJbHE4SKRS5Q3KuH9zLFOX+N22LSkqwYU=;
  b=fCFt9vPFDizc6N2q7BTfLON5OoIJcFd/5TxRbiRhaKdjpHfrn5S8DyUE
   U1h9e3sEAbwjUDn7UDcuCpnquj9Idiuq5sy3X0vHEbWKpfeFYF5cWUiox
   wsb5uDe820s8yRgE+iZ+cvRSaTHmDNvdcXM+S+SC3B5kIu3edHNiPjrYt
   ycc/EZvjV4D3qVtCunlnq6dlqZg4ACnNx+/M6vUMuB52PBa8zbuDXyw4h
   2c6G2TKUf1XSO2e9cVGydbq3vEc16QvOdcP2DeMdM+OU6Hqgo0WkZ5Yt9
   +4zT+oREVOxw4Bvh+ricsV/rsV9wx34ZsfVUFaiclr1388oytT0VOIx15
   A==;
X-CSE-ConnectionGUID: 0D8z72ChRTmUk/MeYOanbg==
X-CSE-MsgGUID: UdHW/niAT8akyVQrsNTVQg==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="18575493"
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; 
   d="scan'208";a="18575493"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 03:52:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; 
   d="scan'208";a="18125547"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.23])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 03:52:00 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 2 Apr 2024 13:51:57 +0300 (EEST)
To: "Luke D. Jones" <luke@ljones.dev>
cc: Hans de Goede <hdegoede@redhat.com>, corentin.chary@gmail.com, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 6/9] platform/x86: asus-wmi: adjust formatting of
 ppt-<name>() functions
In-Reply-To: <20240402022607.34625-7-luke@ljones.dev>
Message-ID: <ae8e0599-5f19-4ad8-4e84-40bd0d47ee71@linux.intel.com>
References: <20240402022607.34625-1-luke@ljones.dev> <20240402022607.34625-7-luke@ljones.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-617934564-1712055117=:1019"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-617934564-1712055117=:1019
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 2 Apr 2024, Luke D. Jones wrote:

> Shift the call to dev_get_drvdata() up to top of the function block
> in all of the ppt_<name>() functions as part of a minor cleanup.
>=20
> Signed-off-by: Luke D. Jones <luke@ljones.dev>

Thanks for doing this,

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-617934564-1712055117=:1019--

