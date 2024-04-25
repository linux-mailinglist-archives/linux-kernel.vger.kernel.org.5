Return-Path: <linux-kernel+bounces-158526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA4F8B21AB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 14:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C1C42865D5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 12:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D8C31494B4;
	Thu, 25 Apr 2024 12:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gA3uSsXd"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002B980B;
	Thu, 25 Apr 2024 12:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714048374; cv=none; b=lBhtfIdZDQijoDtY70ejdfjo6nu1PymX6t5hRAesWMtogY5NIvvckO3Clp3daFBCGhT4EuC0hEzDq1fyGCTZFMEW4LGcMrydvVa4E7N4BmmtLC7cVn4FgaUZKl12lxgnDVvqW7iE2d3uQ1LC0lQF5w94YsU3r4yF6dvdnXTWeK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714048374; c=relaxed/simple;
	bh=mB1dRJUqK88lmFSXrckkZ57ybyQRc6ObOL/KSHIOBUM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UqGrRrh/YYYIw3UThVYaQe/5XYxu0B7QEEvRDE+Q6odmYP56yn/dy8FcQ6g0PFjDOvQhlWwUiSkK+vUsPXruNwP4wHcqFEnnMOiETIcy1KUZEVt9HkKCJEQDD0jM1jGfrq0TtVNWmsq4SCmP03H9qiZ/RKuqAlFDw9VAg/9RfGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gA3uSsXd; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714048373; x=1745584373;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=mB1dRJUqK88lmFSXrckkZ57ybyQRc6ObOL/KSHIOBUM=;
  b=gA3uSsXdt99up4pjT+xCSTJa+AYl4QvoezSaBxNRB3sYTHDsQJfwFu+7
   9ic07gm4unWsbvj4wGITpczIWr7UjpI7iJTgqBU6SXa3yu8VaW7//7Jer
   L/z2TI4mvVs/uhG7UtzrQdVqNiw2aH1FQq/ch3TnUOA+SdWEUTsAus6Jg
   z1nMCc+DNiTvDGuB6CoavCNfHDkVIuisXSzf9ULVlMBmSU2gyW78aYLPc
   bhSP0Vh/vlDwONDs4prerLN6gwgLG5nujA35c2tpgULQc/AF7PVs0ss8Z
   QWhah7aHh7zs5yCAxerH8ZX0OAuPeSWwF+5KisFNuIsyaDI1wOPlgK45R
   g==;
X-CSE-ConnectionGUID: xMWbbFMqTf+uYgakkWnYjw==
X-CSE-MsgGUID: 5xmaDTJWS56C9wYakFFkIQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9577561"
X-IronPort-AV: E=Sophos;i="6.07,229,1708416000"; 
   d="scan'208";a="9577561"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 05:32:52 -0700
X-CSE-ConnectionGUID: UNT0Y7qvQwadhPwel1nbTA==
X-CSE-MsgGUID: DTgupLfSRnyNSipdGHxOoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,229,1708416000"; 
   d="scan'208";a="29830704"
Received: from spandruv-desk.jf.intel.com (HELO spandruv-desk.amr.corp.intel.com) ([10.54.75.14])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 05:32:52 -0700
Message-ID: <eafd7f1dd4fd3c86ffd97cf7f5c8a0f1de87f214.camel@linux.intel.com>
Subject: Re: [PATCH v4 60/71] platform/x86: ISST: Switch to new Intel CPU
 model defines
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, Hans de
 Goede <hdegoede@redhat.com>, Ilpo =?ISO-8859-1?Q?J=E4rvinen?=
 <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev
Date: Thu, 25 Apr 2024 05:32:51 -0700
In-Reply-To: <20240424181539.42311-1-tony.luck@intel.com>
References: <20240424181245.41141-1-tony.luck@intel.com>
	 <20240424181539.42311-1-tony.luck@intel.com>
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

But we added new CPU model here, which is targeted for 6.10-rc1. So
there will be merge issues.

> ---
> =C2=A0drivers/platform/x86/intel/speed_select_if/isst_if_common.c | 4 ++-=
-
> =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git
> a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
> b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
> index 08df9494603c..96f3b221b6c8 100644
> --- a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
> +++ b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
> @@ -719,8 +719,8 @@ static struct miscdevice isst_if_char_driver =3D {
> =C2=A0};
> =C2=A0
> =C2=A0static const struct x86_cpu_id hpm_cpu_ids[] =3D {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0X86_MATCH_INTEL_FAM6_MODEL(GRA=
NITERAPIDS_X,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0NULL),
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0X86_MATCH_INTEL_FAM6_MODEL(ATO=
M_CRESTMONT_X,=C2=A0=C2=A0=C2=A0=C2=A0NULL),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0X86_MATCH_VFM(INTEL_GRANITERAP=
IDS_X,=C2=A0=C2=A0=C2=A0=C2=A0NULL),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0X86_MATCH_VFM(INTEL_ATOM_CREST=
MONT_X,=C2=A0=C2=A0=C2=A0NULL),
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{}
> =C2=A0};
> =C2=A0


