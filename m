Return-Path: <linux-kernel+bounces-135734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 380BF89CA8B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 19:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E81B028827F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 17:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBDAD14388A;
	Mon,  8 Apr 2024 17:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nqxH6EO/"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AEC142906;
	Mon,  8 Apr 2024 17:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712596438; cv=none; b=bZ9WOT3B59JO/KdcDlRf2YKl+RGcpRXR9nHwAuFTaZcWLWSSRUpZISGTLKcNr4loApG+qouyAZSCu4U78ikPmqYP5l7to+bn9ILo6RhzOiSWVtIK4aHLIv5HcrxvyfD8z7q+VjF9SjA0NwqAwtwdY6/w66f8G7Eu9zwq5FFXve0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712596438; c=relaxed/simple;
	bh=aHlnDtYgF5sHA2gDq8CnXU8bKMjq82wegMvazgZEzcA=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=LMV5LH79wixvG4ssmdo6A8n4geaL2zrdTLjpsb+mH7LhGKc9Z7KzAyU+HOAoz47Grn9R+8/L0bf1ET44rMw0Q0t0kK5J2AOWPpf2FD8TWqpQuotUEj+NaTBM6Uj4ROUgruwgme57/6H/KjQ1wrYkhziJ5K39f0+uRmaHAE9ulUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nqxH6EO/; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712596437; x=1744132437;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=aHlnDtYgF5sHA2gDq8CnXU8bKMjq82wegMvazgZEzcA=;
  b=nqxH6EO/IQGroE1oute6a16TDL+muJZ/mw+YwdDhitum4YUPKM938wyy
   hISeFh248R2lMiirgujedbYetWUzEcMs26t+CfA+dIMCHA7y6rln+cflh
   vOHjzq97l4jmbHjGmxQx0Ttz97k+uez9DINSNhS7hAbLTrIyHwhOrcu8l
   tPD25RBCp5xKVltCgV4h1JG2FDD+prvJxjaaav4xpxnlxr8KnibRtxPZR
   P+N0oRmgwS8tnPEaskeBHdk6oN9bix7NREB2KuLb5qMh2kf/YSvrpZSKO
   qgPTwA6uQN2jRcvixkh7RCJrCFJqAH8u9z3plNPOPl1X75TDLjL7/m1j0
   Q==;
X-CSE-ConnectionGUID: gyyuA4WNQOWAl8J0G7EhHQ==
X-CSE-MsgGUID: ytWg8u74QDiBPXvlWuhXXg==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="7757073"
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="7757073"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 10:13:57 -0700
X-CSE-ConnectionGUID: mz3ABMMCR9eOvJxOt3sZeg==
X-CSE-MsgGUID: xOx9u3YGSe6uW+ZzVt3uHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="19977335"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.28])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 10:13:54 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 8 Apr 2024 20:13:50 +0300 (EEST)
To: "David E. Box" <david.e.box@linux.intel.com>
cc: Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, 
    sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH V3 6/9] tools/arch/x86/intel_sdsi: Fix meter_show
 display
In-Reply-To: <20240405032507.2637311-7-david.e.box@linux.intel.com>
Message-ID: <567552c0-db6b-21db-aa89-2950f5a802ad@linux.intel.com>
References: <20240405032507.2637311-1-david.e.box@linux.intel.com> <20240405032507.2637311-7-david.e.box@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1469216011-1712596430=:14302"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1469216011-1712596430=:14302
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 4 Apr 2024, David E. Box wrote:

> Fixes sdsi_meter_cert_show() to correctly decode and display the meter
> certificate output. Adds and displays a missing version field, displays t=
he
> ASCII name of the signature, and fixes the print alignment.
>=20
> Fixes: 7fdc03a7370f ("tools/arch/x86: intel_sdsi: Add support for reading=
 meter certificates")
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
> V3 - Change patch subject and changelog to clarify changes.
>    - Use new BUNDLE_COUNT #def
>=20
> V2 - Split of V1 patch 7
>=20
>  tools/arch/x86/intel_sdsi/intel_sdsi.c | 29 +++++++++++++++++---------
>  1 file changed, 19 insertions(+), 10 deletions(-)
>=20
> diff --git a/tools/arch/x86/intel_sdsi/intel_sdsi.c b/tools/arch/x86/inte=
l_sdsi/intel_sdsi.c
> index 7eaffcbff788..a0711177e1bb 100644
> --- a/tools/arch/x86/intel_sdsi/intel_sdsi.c
> +++ b/tools/arch/x86/intel_sdsi/intel_sdsi.c
> @@ -153,11 +153,12 @@ struct bundle_encoding {
>  };
> =20
>  struct meter_certificate {
> -=09uint32_t block_signature;
> +=09uint32_t signature;
> +=09uint32_t version;
> +=09uint64_t ppin;
>  =09uint32_t counter_unit;
> -=09uint64_t ppin;
>  =09uint32_t bundle_length;
> -=09uint32_t reserved;
> +=09uint64_t reserved;
>  =09uint32_t mmrc_encoding;
>  =09uint32_t mmrc_counter;
>  };
> @@ -338,6 +339,7 @@ static int sdsi_meter_cert_show(struct sdsi_dev *s)
>  =09uint32_t count =3D 0;
>  =09FILE *cert_ptr;
>  =09int ret, size;
> +=09char name[4];
> =20
>  =09ret =3D sdsi_update_registers(s);
>  =09if (ret)
> @@ -379,12 +381,19 @@ static int sdsi_meter_cert_show(struct sdsi_dev *s)
>  =09printf("\n");
>  =09printf("Meter certificate for device %s\n", s->dev_name);
>  =09printf("\n");
> -=09printf("Block Signature:       0x%x\n", mc->block_signature);
> -=09printf("Count Unit:            %dms\n", mc->counter_unit);
> -=09printf("PPIN:                  0x%lx\n", mc->ppin);
> -=09printf("Feature Bundle Length: %d\n", mc->bundle_length);
> -=09printf("MMRC encoding:         %d\n", mc->mmrc_encoding);
> -=09printf("MMRC counter:          %d\n", mc->mmrc_counter);
> +
> +=09get_feature(mc->signature, name);
> +=09printf("Signature:                    %.4s\n", name);
> +
> +=09printf("Version:                      %d\n", mc->version);
> +=09printf("Count Unit:                   %dms\n", mc->counter_unit);
> +=09printf("PPIN:                         0x%lx\n", mc->ppin);
> +=09printf("Feature Bundle Length:        %d\n", mc->bundle_length);
> +
> +=09get_feature(mc->mmrc_encoding, name);
> +=09printf("MMRC encoding:                %.4s\n", name);
> +
> +=09printf("MMRC counter:                 %d\n", mc->mmrc_counter);
>  =09if (mc->bundle_length % 8) {
>  =09=09fprintf(stderr, "Invalid bundle length\n");
>  =09=09return -1;
> @@ -398,7 +407,7 @@ static int sdsi_meter_cert_show(struct sdsi_dev *s)
> =20
>  =09bec =3D (void *)(mc) + sizeof(mc);
> =20
> -=09printf("Number of Feature Counters:          %d\n", mc->bundle_length=
 / 8);
> +=09printf("Number of Feature Counters:   %ld\n", BUNDLE_COUNT(mc->bundle=
_length));
>  =09while (count++ < mc->bundle_length / 8) {
>  =09=09char feature[5];

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-1469216011-1712596430=:14302--

