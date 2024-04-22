Return-Path: <linux-kernel+bounces-152923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E318AC62D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 600B328139E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 08:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E004E1CF;
	Mon, 22 Apr 2024 08:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GAnduGE+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8534AEE0;
	Mon, 22 Apr 2024 08:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713772812; cv=none; b=naHpINHTOw3e1u0NIWJ00b7SfWfDTv5lJSa1fJBAVNOMrX2W6rV60e2Ic/Rc27ikAcd01s08e/CaEuZu+ETWu1RwDmrL0+t7DmQ2sdRtdeMUpjjatwdnE2qqlCQ8h3HfZthSzUgDzhVJXxC/E43fRWq5OqDJkk2GOQXO+5D4bv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713772812; c=relaxed/simple;
	bh=YUc8o0SlTToJRz8zQWrVtWGeJWmVQFUkb3cDyQnQv68=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=uSxP1Hyc52DigZj5il6GDWlaseonP0zXyQ//8bttzhpTM3PvmIIXWWdZWKNs1MQJUzyO39wagyFSClk6ungmEc3a6UgU7PiRkmc8ZzSYtu7LNeg5gT8ajW0CtovfB559iAMVHnF/YqkQeCFfJ2xPrCmsiruBEndjHdUHEjWkiLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GAnduGE+; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713772811; x=1745308811;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=YUc8o0SlTToJRz8zQWrVtWGeJWmVQFUkb3cDyQnQv68=;
  b=GAnduGE+3812y3SfADk9e/C81hvFHH+qyqErycCR1mzE/PaUnxRunZxW
   oBDA+SbGBBz4RhU9n/xtUlDRdhk2T9Pv355Ai4/UKt8kiwuMpZX2g6sP0
   e8orq/L6Og0jGGvCE+UNK/cITL3okc1K3Rb9fIoE3l3QCODQr7m59CxMs
   gRZgnrjJRC634SUHN29/1DCb5otKlvhh8aiPMv61WjJU1kzqCh7IK70kr
   GJ6ccDmMNQ63GBmTxjFXweesMnWMGahqOjm5i+cbk+rYVrxY/UFeruq/B
   Y4SwFvlqCHVxA9C2W9r2TIVVfwv9KkM8+c6ZNdLhV+F1wqSTLhQZYYNKg
   w==;
X-CSE-ConnectionGUID: Xs0YK612Rz+kGSuQUiG6QA==
X-CSE-MsgGUID: 1KhWmkoRRiWxPBeoaQxGNA==
X-IronPort-AV: E=McAfee;i="6600,9927,11051"; a="19850986"
X-IronPort-AV: E=Sophos;i="6.07,220,1708416000"; 
   d="scan'208";a="19850986"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 01:00:10 -0700
X-CSE-ConnectionGUID: rmQv94azSLSXDyaQ/KXtOQ==
X-CSE-MsgGUID: x9s88UbbQ1+Ew+gozB0MNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,220,1708416000"; 
   d="scan'208";a="23914745"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.39])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 01:00:07 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 22 Apr 2024 11:00:00 +0300 (EEST)
To: Armin Wolf <W_Armin@gmx.de>
cc: mlj@danelec.com, rafael.j.wysocki@intel.com, lenb@kernel.org, 
    jdelvare@suse.com, linux@roeck-us.net, linux@weissschuh.net, 
    linux-acpi@vger.kernel.org, linux-hwmon@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH RESEND v5] ACPI: fan: Add hwmon support
In-Reply-To: <20240422060835.71708-1-W_Armin@gmx.de>
Message-ID: <6d8c1b6a-0d6b-c54c-9417-5cfcefcce222@linux.intel.com>
References: <20240422060835.71708-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-160052138-1713772800=:2288"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-160052138-1713772800=:2288
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 22 Apr 2024, Armin Wolf wrote:

> Currently, the driver does only support a custom sysfs
> interface to allow userspace to read the fan speed.
> Add support for the standard hwmon interface so users
> can read the fan speed with standard tools like "sensors".
>=20
> Tested with a custom ACPI SSDT.
>=20
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-160052138-1713772800=:2288--

