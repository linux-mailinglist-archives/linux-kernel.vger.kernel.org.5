Return-Path: <linux-kernel+bounces-6923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 698F6819F5F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 13:55:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 258E0282BFE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 12:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F92625563;
	Wed, 20 Dec 2023 12:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nlZ+pKVN"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F206D25545;
	Wed, 20 Dec 2023 12:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703076933; x=1734612933;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=QCN29+Y6GsynNFm7eCSzB+g/YYppH5Z5kO3yAxJk1EM=;
  b=nlZ+pKVNZKle1R6wukOu0GVXRhiXWr3jURqw0vo7mZMwgBN4R5UR2gbt
   FABgr1rvyHZhl+onez+WXwpmlvzlCTMCfVNruz7dUFRYGmbV+XterR03P
   pGZbMsP6yGaOo66IyrtoqL3IX5Ms63MqaMaXINDfKf5Rn+1VGNM9wPSc+
   +LUTH9R2FJHcvC/PoFeQvbPFYL+1OrvPMs/PFFuzE6PgBIBi7RomwS1W3
   mlhwx/cxB8fe8QrAYGySzitfpOMz4Fva+abNLPKH0GHdvzaoY1YbV0BEs
   EWJnb4zsnQpixdy6lEULMaDUCooY+0lC2Ru0ITMzHMBHvIrVUZb01ntBG
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="481996688"
X-IronPort-AV: E=Sophos;i="6.04,291,1695711600"; 
   d="scan'208";a="481996688"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 04:55:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,291,1695711600"; 
   d="scan'208";a="24569612"
Received: from spandruv-desk.jf.intel.com (HELO spandruv-desk.amr.corp.intel.com) ([10.54.75.14])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 04:55:31 -0800
Message-ID: <90c4f24d697f0dbd5a1afac7d5ac49ffbe6fff14.camel@linux.intel.com>
Subject: Re: [PATCH 2/3] HID: make ishtp_cl_bus_type const
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, jikos@kernel.org, 
	benjamin.tissoires@redhat.com
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Date: Wed, 20 Dec 2023 04:55:31 -0800
In-Reply-To: <2023122048-tribute-quote-1b4d@gregkh>
References: <2023122045-pellet-eggbeater-8d2f@gregkh>
	 <2023122048-tribute-quote-1b4d@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-3.fc36) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2023-12-20 at 08:38 +0100, Greg Kroah-Hartman wrote:
> Now that the driver core can properly handle constant struct
> bus_type,
> move the ishtp_cl_bus_type variable to be a constant structure as
> well,
> placing it into read-only memory which can not be modified at
> runtime.
>=20
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: Jiri Kosina <jikos@kernel.org>
> Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> Cc: linux-input@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> ---
> =C2=A0drivers/hid/intel-ish-hid/ishtp/bus.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/hid/intel-ish-hid/ishtp/bus.c
> b/drivers/hid/intel-ish-hid/ishtp/bus.c
> index 7fc738a22375..aa6cb033bb06 100644
> --- a/drivers/hid/intel-ish-hid/ishtp/bus.c
> +++ b/drivers/hid/intel-ish-hid/ishtp/bus.c
> @@ -378,7 +378,7 @@ static const struct dev_pm_ops
> ishtp_cl_bus_dev_pm_ops =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.restore =3D ishtp_cl_dev=
ice_resume,
> =C2=A0};
> =C2=A0
> -static struct bus_type ishtp_cl_bus_type =3D {
> +static const struct bus_type ishtp_cl_bus_type =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.name=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=3D "ishtp",
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.dev_groups=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=3D ishtp_cl_dev_groups,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.probe=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=3D ishtp_cl_device_probe,


