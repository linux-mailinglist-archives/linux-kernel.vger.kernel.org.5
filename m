Return-Path: <linux-kernel+bounces-160364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 622368B3C8F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 18:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17FA91F22BC2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 16:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE6315253B;
	Fri, 26 Apr 2024 16:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E+Dzn38l"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA54145358;
	Fri, 26 Apr 2024 16:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714148060; cv=none; b=aOoqpaNvqr1BTMAmnwzsuV3bA6QMzKAEbVx+LCgh2w/GoCOvkrdrjQ30dgZljeaDtjHCdsflUrix0IGfK5fElECksglWeTjEH+X525aXi5rQHDTIVJtdIFjRHKOqUTQDMixMRDphSSFSOEwjiKpac+HypyE+qyLM/Vjrhss0y8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714148060; c=relaxed/simple;
	bh=gxfIvs2FhkwmskjgUeXOhHt49KN7YTPPnA6Le5WZTsc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n/TCp/BnJ+GvzimDEkU1+iTpWf4zPLvCtxUyXC7yvHCk+YT9PoyxuQyOMEDH7Qg/8ggP8YsPIId3O8YBdyOBM0QZEbY3V5ZX4NJNfHKYbmugb8wbGvTG/fatURl2trGo669FJwomAQ4yCVB1R7dU6e/bmxX+ZdojFI+/ogQX80Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E+Dzn38l; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714148058; x=1745684058;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=gxfIvs2FhkwmskjgUeXOhHt49KN7YTPPnA6Le5WZTsc=;
  b=E+Dzn38lbqIP56aIr5ydtBx+kb5LBDe8MEvUdBT0HGveH9TpPyMENxOS
   KKL2I7wRERWvC7lZ2LnHNHVmAQND7i4WrQxsSpqElIoMSMk9uwyMqWPPU
   iOSrMyuCK7jsrOSJ06BZWBKK70ftcXvGpoqBJJYdMn9JBb4i0EJFvmXMk
   hkN2moiGfPDDn2Tx3zy2GmmlXdAZGFFQMcHOHm9zscb6yRsvsV6Xtg36P
   91u5h+aXP7Yryg1xVWoMlHDQNsWF+qBnFCF/XyH04kxNQMHl5bX/CYwTw
   uBqQozh54l0K2St7rbOnFSfSmP1QikrZOO3Ot6W0/dDD4KQaQGyJ6g/qu
   w==;
X-CSE-ConnectionGUID: DdbUNyWlTaqOa1YvJcpC6w==
X-CSE-MsgGUID: xBPyRQ7KRQ652F0F1ZDqUQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11056"; a="10048018"
X-IronPort-AV: E=Sophos;i="6.07,233,1708416000"; 
   d="scan'208";a="10048018"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 09:14:17 -0700
X-CSE-ConnectionGUID: n/1jZoIFQzi4/0YF0kpmxw==
X-CSE-MsgGUID: nkVo7aakSaOM2RFCVugpOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,233,1708416000"; 
   d="scan'208";a="30272767"
Received: from spandruv-desk1.amr.corp.intel.com ([10.247.119.99])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 09:14:13 -0700
Message-ID: <13fe0f7c7da2cb6ce52ec34d4648e90e40f2fbc0.camel@linux.intel.com>
Subject: Re: [PATCH] platform/x86: dell-laptop: Implement platform_profile
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Lyndon Sanche <lsanche@lyndeno.ca>, Mario Limonciello
	 <mario.limonciello@amd.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Pali =?ISO-8859-1?Q?Roh=E1r?=
 <pali@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Ilpo
 =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dell.Client.Kernel@dell.com
Date: Fri, 26 Apr 2024 09:14:07 -0700
In-Reply-To: <24c7a9ea-7755-4270-a338-4701c8e262e2@app.fastmail.com>
References: <20240425172758.67831-1-lsanche@lyndeno.ca>
	 <a6009bed-aa34-4a3f-91f5-23937e915132@amd.com>
	 <24c7a9ea-7755-4270-a338-4701c8e262e2@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-04-25 at 14:24 -0600, Lyndon Sanche wrote:
> On Thu, Apr 25, 2024, at 2:07 PM, Mario Limonciello wrote:
> > + Srinivas
> >=20
> > On 4/25/2024 12:27, Lyndon Sanche wrote:
> > > Some Dell laptops support configuration of preset
> > > fan modes through smbios tables.
> > >=20
> > > If the platform supports these fan modes, set up
> > > platform_profile to change these modes. If not
> > > supported, skip enabling platform_profile.
> > >=20
> > > Signed-off-by: Lyndon Sanche <lsanche@lyndeno.ca>
> > > ---
> >=20
> > When you developed this was it using a Dell Intel or Dell AMD
> > system?
> >=20
> > If it was an Intel system, did you test it with thermald installed
> > and=20
> > active?
> >=20
> > I'm wondering how all this stuff jives with the stuff that thermald
> > does.=C2=A0 I don't know if they fight for any of the same "resources".
>=20
> Thank you for your response.
>=20
> I did my development and testing on a Dell Intel system. Specifically
> the XPS 15 9560 with i7-7700HQ.
>=20
> I do have thermald running, though I admit I am not really aware of
> what exactly it does, besides being related to thermals in some way.
>=20
> I normally set the thermal mode with Dell's smbios-thermal-ctl
> program. I am not too sure all the values that the bios configures on
> it's own depending on the provided mode, so I am not sure if thermald
> conflicts. But my understanding is that would be out of scope of this
> driver, since we are only telling the bios what we want at a high
> level.
>=20
> Lyndon
Can you share output of acpidump tool to me? I want to make sure if
there is some way the platform will bypass thermal table if you changed
to some profile.

Thanks,
Srinivas

