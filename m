Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76FAE777EA6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 18:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235032AbjHJQxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 12:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjHJQxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 12:53:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A46691BD9;
        Thu, 10 Aug 2023 09:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691686412; x=1723222412;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=xBjyT0h78kvMYExk+Cmw0+IryrvAY/AsM4xmx7phi5Y=;
  b=A69bNvuec15pjqQGakRVHmyaOlEqzn0+Yy3WL+r+BaS8wu5fTk+PFyiR
   ReGpV3F7Unz2E1LamFgpreTBDwiiC6H7cRJ0POlKJIXoE4Fm+KCgmWRYV
   AyLzc3PQvqfz4YLc3HOPP22gZq2daneUusN5gSzY8X2265Kug1VJFgG3f
   ZP44fGb0yIWHYg/9lx0k54jRFkffvMj5Yd18JJrgZ3rKB4muYmIn6IQqn
   Gcr3X4ibrMrtuthlkiCODVf+cUFTHNLbHSBnGbvB4lWFULugZj/FR2B/7
   SNY7Q/KLyVU+2jY/7OeIUsE+d9hrAZYGSaOK91xSy2CpVIE5ivMqVFqkv
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="402436911"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="402436911"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 09:53:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="761859431"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="761859431"
Received: from spandruv-desk1.amr.corp.intel.com ([10.212.254.181])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 09:53:23 -0700
Message-ID: <8850e62411ecc0a3d77a647c6bfc51387bf293ee.camel@linux.intel.com>
Subject: Re: [PATCH v1 2/2] thermal: intel: intel_soc_dts_iosf: Drop
 redundant symbol definition
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Date:   Thu, 10 Aug 2023 09:53:23 -0700
In-Reply-To: <2302928.ElGaqSPkdT@kreacher>
References: <12271935.O9o76ZdvQC@kreacher> <2302928.ElGaqSPkdT@kreacher>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-08-09 at 22:28 +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>=20
> SOC_MAX_DTS_SENSORS is already defined in intel_soc_dts_iosf.h which
> is
> included in intel_soc_dts_iosf.c, so it does not need to be defined
> in
> the latter again.
>=20
> Drop the redundant definition of that symbol from
> intel_soc_dts_iosf.c.
>=20
> No intentional functional impact.
>=20
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Srinivas Pandruvada<srinivas.pandruvada@linux.intel.com>

> ---
> =C2=A0drivers/thermal/intel/intel_soc_dts_iosf.c |=C2=A0=C2=A0=C2=A0 3 --=
-
> =C2=A01 file changed, 3 deletions(-)
>=20
> Index: linux-pm/drivers/thermal/intel/intel_soc_dts_iosf.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/thermal/intel/intel_soc_dts_iosf.c
> +++ linux-pm/drivers/thermal/intel/intel_soc_dts_iosf.c
> @@ -40,9 +40,6 @@
> =C2=A0/* Mask for two trips in status bits */
> =C2=A0#define SOC_DTS_TRIP_MASK=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00x03
> =C2=A0
> -/* DTS0 and DTS 1 */
> -#define SOC_MAX_DTS_SENSORS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A02
> -
> =C2=A0static int sys_get_trip_temp(struct thermal_zone_device *tzd, int
> trip,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 int *temp)
> =C2=A0{
>=20
>=20
>=20

