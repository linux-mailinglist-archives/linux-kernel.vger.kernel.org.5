Return-Path: <linux-kernel+bounces-135717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E13FF89CA2D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 18:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F9C31C23AD6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 16:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E5D142E7F;
	Mon,  8 Apr 2024 16:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N3C+4eVX"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5E363CB;
	Mon,  8 Apr 2024 16:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712595575; cv=none; b=i8Cg5BdDgP1Da9vJcZly3n9M6fHBoh81odEBeZ6Nui4MCIAnalvEFwg2dLp9iXNJhPMo0fmNXB6A6zk0f0wyz72EGlift8mgs2vTTgNRbLnr35zYy024qCAM5M9AU26NDvdR7+acxgwomejeGEGbXW4W8yq1blfWbMbwtLDbT3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712595575; c=relaxed/simple;
	bh=uwXlCBe6K4+2PaB3ZfeXMcVLosXA2aNykan3/vlb37k=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=bNYubD0GtRZBE15c/uT9Fnq6Ifz1QJ0qGs2ULKUFQPz9U0dJg6AsXeZDYAMnv45KLStOwepYjw9rBSC1O+E3stFSrFYuqV/6RL0qN+30kxmLiKH/OzTXHeLLkPkiU87i8pSo9HbuDk1wEeGwO4XHpSOp8PmTXtNoM/llDH4glw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N3C+4eVX; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712595573; x=1744131573;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=uwXlCBe6K4+2PaB3ZfeXMcVLosXA2aNykan3/vlb37k=;
  b=N3C+4eVXf92JB9+24EaEHynxujro+n2ME76cPNVDvwVq4Mk5D7waeG+r
   Rf+OyiSPZzHh4PMRuI5eX9mapOwjfnDNFFp/EDA+TtBd1V1+bdXIfmgTt
   iRtMZRSKzqHqNHVX9ixTRAOti6DVBOUIVBCQ6hTr7jEFBBb/AlIsl1r1a
   7pqV1galXNxuKsljxWipkFLTBmmiW2VCHLfu/+fF/rjnOKLEfWFJ9v3J2
   RPT4wygo3gPrpnmHKcYs1Mgw9SimfhC313CEu7+yXCS4t/HrHJhKlN5PL
   A9wZtj2JOOC/qSN6O/9hT34kTA379qGcjd5g6HAew9ttG0e2J5YC41Scd
   Q==;
X-CSE-ConnectionGUID: AS9aNaIwRO+xA52xQUTQ2A==
X-CSE-MsgGUID: eem4xkAOQxSPXfo+mIULag==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="11722535"
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="11722535"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 09:59:32 -0700
X-CSE-ConnectionGUID: TzzGoOctSsaLZy/24nIypQ==
X-CSE-MsgGUID: 0zOBaai+S8+fzaRhr9e0XQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="20034937"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.28])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 09:59:30 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 8 Apr 2024 19:59:27 +0300 (EEST)
To: "David E. Box" <david.e.box@linux.intel.com>
cc: Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, 
    sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH V3 5/9] tools/arch/x86/intel_sdsi: Fix maximum meter
 bundle length
In-Reply-To: <20240405032507.2637311-6-david.e.box@linux.intel.com>
Message-ID: <fee4a547-721d-5a69-68b9-98e4aa57d3ba@linux.intel.com>
References: <20240405032507.2637311-1-david.e.box@linux.intel.com> <20240405032507.2637311-6-david.e.box@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1243666691-1712595567=:14302"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1243666691-1712595567=:14302
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 4 Apr 2024, David E. Box wrote:

> The maximum number of bundles in the meter certificate was set to 8 which
> is much less than the maximum. Instead, since the bundles appear at the e=
nd
> of the file, set it based on the remaining file size from the bundle star=
t
> position.
>=20
> Fixes: 7fdc03a7370f ("tools/arch/x86: intel_sdsi: Add support for reading=
 meter certificates")
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
>=20
> V3 - Add suggested macros for the number of bundles and bundle size.
>=20
> V2 - Split of V1 patch 7
>=20
>  tools/arch/x86/intel_sdsi/intel_sdsi.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>=20
> diff --git a/tools/arch/x86/intel_sdsi/intel_sdsi.c b/tools/arch/x86/inte=
l_sdsi/intel_sdsi.c
> index 2cd92761f171..7eaffcbff788 100644
> --- a/tools/arch/x86/intel_sdsi/intel_sdsi.c
> +++ b/tools/arch/x86/intel_sdsi/intel_sdsi.c
> @@ -43,7 +43,6 @@
>  #define METER_CERT_MAX_SIZE=094096
>  #define STATE_MAX_NUM_LICENSES=0916
>  #define STATE_MAX_NUM_IN_BUNDLE=09(uint32_t)8
> -#define METER_MAX_NUM_BUNDLES=098
> =20
>  #define __round_mask(x, y) ((__typeof__(x))((y) - 1))
>  #define round_up(x, y) ((((x) - 1) | __round_mask(x, y)) + 1)
> @@ -167,6 +166,11 @@ struct bundle_encoding_counter {
>  =09uint32_t encoding;
>  =09uint32_t counter;
>  };
> +#define METER_BUNDLE_SIZE sizeof(struct bundle_encoding_counter)
> +#define BUNDLE_COUNT(length) ((length) / METER_BUNDLE_SIZE)
> +#define METER_MAX_NUM_BUNDLES=09=09=09=09=09=09=09\
> +=09=09((METER_CERT_MAX_SIZE - sizeof(struct meter_certificate)) /=09\
> +=09=09 sizeof(struct bundle_encoding_counter))
> =20
>  struct sdsi_dev {
>  =09struct sdsi_regs regs;
> @@ -386,9 +390,9 @@ static int sdsi_meter_cert_show(struct sdsi_dev *s)
>  =09=09return -1;
>  =09}
> =20
> -=09if (mc->bundle_length > METER_MAX_NUM_BUNDLES * 8)  {
> -=09=09fprintf(stderr, "More than %d bundles: %d\n",
> -=09=09=09METER_MAX_NUM_BUNDLES, mc->bundle_length / 8);
> +=09if (mc->bundle_length > METER_MAX_NUM_BUNDLES * METER_BUNDLE_SIZE)  {
> +=09=09fprintf(stderr, "More than %ld bundles: actual %ld\n",
> +=09=09=09METER_MAX_NUM_BUNDLES, BUNDLE_COUNT(mc->bundle_length));
>  =09=09return -1;
>  =09}

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-1243666691-1712595567=:14302--

