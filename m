Return-Path: <linux-kernel+bounces-158528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 588388B21B3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 14:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AFB51C2211B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 12:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B0B1494B9;
	Thu, 25 Apr 2024 12:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z+9RcWIv"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B871494C4;
	Thu, 25 Apr 2024 12:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714048408; cv=none; b=Wd32zHS8ShXe5ZURbdLHS/3uMQg8GaQSC8h22e3QlAm9c3QCudv9URMLFJvd7cwlze1+3BEUXKIZrgvVEHAuNBi6GI1CNPI9ToFLeL+yvs1yLamLb0XPbc+tXq0Nr1rjoa4fk0m5AG2CaqFn5MBfc4mPYUof+rwZ0bFpTnROGus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714048408; c=relaxed/simple;
	bh=AT1p51Nd/Ndno6KDZTIXRoxxWTb7rV0Thh15ObEv6DE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Uhb3jDRNETUs9g0sIrvQwkTf/yDqVyC6unBNWD9S/GyPJXJm+ehZ6gA3/9zuDOKi9wWXiXf5bgx+PieLYPE7SkV2rgA2iJE6R/e+ZXh+ZwR5SjTwhZ3bLQWQ/9Y1X4lbDilj5/iBID0285U0rHnriN2yCaxWqfYChLiwh5f8A9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z+9RcWIv; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714048407; x=1745584407;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=AT1p51Nd/Ndno6KDZTIXRoxxWTb7rV0Thh15ObEv6DE=;
  b=Z+9RcWIvgLXMpVRB630JgR/FHPJYEOu1kXeFx1n7h2bzEp06I5Tci1h9
   qHRQ0JUe3hhS8sq67qYbAkb8FefBRr2p9Od3YNsFpfsa02PSqU1f8IMp9
   tNr+LEFX0hMmqAabwXoa7/CnuwSOIL5EYA74vJsTu/9d4AVVQVPwRBqr8
   0oc7sk/R7XbvUvuPa6kfxNCxc+Uvzee13hnNtAVphxjXctw4tLvblXIlQ
   KWh4rrXM9mpDGf6MdTfh1U8JGH5PXWavmIwOidR2z7o68t6OmwmHwjM2s
   EkYwUWhm02cBrJDgC66P32xZhekxygQ8FxUX6wSFZcEbwwtEhCh+9u+II
   Q==;
X-CSE-ConnectionGUID: vjQrsDnlQfCTaFV7Lb4i9w==
X-CSE-MsgGUID: n0L/8knAR1ugVidwocKMUw==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9656380"
X-IronPort-AV: E=Sophos;i="6.07,229,1708416000"; 
   d="scan'208";a="9656380"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 05:33:26 -0700
X-CSE-ConnectionGUID: gIgjxxA6Tr6Sh9hw8V6S3g==
X-CSE-MsgGUID: n5ScX5ltTlaZtoDYSdPl3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,229,1708416000"; 
   d="scan'208";a="25544925"
Received: from spandruv-desk.jf.intel.com (HELO spandruv-desk.amr.corp.intel.com) ([10.54.75.14])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 05:33:26 -0700
Message-ID: <293e2aac01edf24460ba15ed4605ffc90476bedd.camel@linux.intel.com>
Subject: Re: [PATCH v4 61/71] platform/x86: intel_speed_select_if: Switch to
 new Intel CPU model defines
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, Hans de
 Goede <hdegoede@redhat.com>, Ilpo =?ISO-8859-1?Q?J=E4rvinen?=
 <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev
Date: Thu, 25 Apr 2024 05:33:26 -0700
In-Reply-To: <20240424181540.42330-1-tony.luck@intel.com>
References: <20240424181245.41141-1-tony.luck@intel.com>
	 <20240424181540.42330-1-tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-3.fc36) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-04-24 at 11:15 -0700, Tony Luck wrote:
> New CPU #defines encode vendor and family as well as model.
>=20
> Signed-off-by: Tony Luck <tony.luck@intel.com>

Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> ---
> =C2=A0drivers/platform/x86/intel/speed_select_if/isst_if_mbox_msr.c | 2 +=
-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git
> a/drivers/platform/x86/intel/speed_select_if/isst_if_mbox_msr.c
> b/drivers/platform/x86/intel/speed_select_if/isst_if_mbox_msr.c
> index 1b6eab071068..6c36f7704fe7 100644
> --- a/drivers/platform/x86/intel/speed_select_if/isst_if_mbox_msr.c
> +++ b/drivers/platform/x86/intel/speed_select_if/isst_if_mbox_msr.c
> @@ -161,7 +161,7 @@ static struct notifier_block isst_pm_nb =3D {
> =C2=A0};
> =C2=A0
> =C2=A0static const struct x86_cpu_id isst_if_cpu_ids[] =3D {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0X86_MATCH_INTEL_FAM6_MODEL(SKY=
LAKE_X, NULL),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0X86_MATCH_VFM(INTEL_SKYLAKE_X,=
 NULL),
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{}
> =C2=A0};
> =C2=A0MODULE_DEVICE_TABLE(x86cpu, isst_if_cpu_ids);


