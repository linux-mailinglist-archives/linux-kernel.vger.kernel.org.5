Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97AF77A50EC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 19:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbjIRRZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 13:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbjIRRZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 13:25:22 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3734FE;
        Mon, 18 Sep 2023 10:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695057917; x=1726593917;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=SIG5Q4uL+P053EqzXCbB6Lu6kIje4h7gQ5SWY/pulkw=;
  b=N6mQd0Kw5gMXdsfkmYPPHjWAPwGKOKLHiP+hxnljMkawC8O4Sj+BFi/b
   mYk7Y6oVAY3hY6oyyejf8HpSdkp4jdIVwAHHng/JKPrkXIzebCIbMvB9u
   YHSK+y6qCIS5M1utFg+irBQJwjdTJPlGGGI93cQ1kuKjCTqUUIvW77sN+
   P/6krTXO7CB93dw535DamQ80+0Km8q3MHzqsKG7nybOmZ/2pZh4+ZR8Tq
   t83oynPZLugJzEBfRhD6MPPVWinAgvf3DAEyp/MfzRfY6OKuEo8T8nQDr
   ARAuC8UJ6KpSeS/FmCb60n7am5a7+xKMqU4TyHujWj6ZbhLz1dVMXE/rt
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="382466640"
X-IronPort-AV: E=Sophos;i="6.02,157,1688454000"; 
   d="scan'208";a="382466640"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 10:25:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="739247599"
X-IronPort-AV: E=Sophos;i="6.02,157,1688454000"; 
   d="scan'208";a="739247599"
Received: from spandruv-desk1.amr.corp.intel.com ([10.209.0.131])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 10:25:16 -0700
Message-ID: <f4989b6e49323e501cce1597f73ab024498ab7e7.camel@linux.intel.com>
Subject: Re: [PATCH v3] tools/power/x86/intel_pstate_tracer: python minimum
 version
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Doug Smythies <dsmythies@telus.net>, rafael.j.wysocki@intel.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mario.Limonciello@amd.com,
        'Swapnil Sapkal' <swapnil.sapkal@amd.com>, Ray.Huang@amd.com
Date:   Mon, 18 Sep 2023 10:25:15 -0700
In-Reply-To: <002401d9e9e5$248f3d50$6dadb7f0$@telus.net>
References: <001701d9e9ae$02438120$06ca8360$@telus.net>
         <002301d9e9e2$13424090$39c6c1b0$@telus.net>
         <002401d9e9e5$248f3d50$6dadb7f0$@telus.net>
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

On Sun, 2023-09-17 at 21:03 -0700, Doug Smythies wrote:
>=20
Think somehow one extra new line in email.

> From: Doug Smythies <dsmythies@telus.net>
>=20
> Change the minimum python version from 2.7 to 3.6.
> Remove a 2.X backwards compatibility line.
>=20
> Signed-off-by: Doug Smythies <dsmythies@telus.net>
Acked-by: Srinivas Pandruvada<srinivas.pandruvada@linux.intel.com>

> ---
>=20
> v2 -> v3: Try to fix mess that was v2.
> v1 -> v2: Fix careless typos.
>=20
> ---
> .../x86/intel_pstate_tracer/intel_pstate_tracer.py=C2=A0=C2=A0 | 12 +++++=
+-----
> -
> =C2=A01 file changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git
> a/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
> b/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
> index ec3323100e1a..38cfbdcdedb7 100755
> --- a/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
> +++ b/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
> @@ -1,4 +1,4 @@
> -#!/usr/bin/env python
> +#!/usr/bin/env python3
> =C2=A0# SPDX-License-Identifier: GPL-2.0-only
> =C2=A0# -*- coding: utf-8 -*-
> =C2=A0#
> @@ -11,11 +11,11 @@ then this utility enables and collects trace data
> for a user specified interval
> =C2=A0and generates performance plots.
>=20
> =C2=A0Prerequisites:
> -=C2=A0=C2=A0=C2=A0 Python version 2.7.x or higher
> +=C2=A0=C2=A0=C2=A0 Python version 3.6.x or higher
> =C2=A0=C2=A0=C2=A0=C2=A0 gnuplot 5.0 or higher
> -=C2=A0=C2=A0=C2=A0 gnuplot-py 1.8 or higher
> +=C2=A0=C2=A0=C2=A0 python3-gnuplot 1.8 or higher
> =C2=A0=C2=A0=C2=A0=C2=A0 (Most of the distributions have these required p=
ackages. They
> may be called
> -=C2=A0=C2=A0=C2=A0=C2=A0 gnuplot-py, phython-gnuplot or phython3-gnuplot=
, gnuplot-nox,
> ... )
> +=C2=A0=C2=A0=C2=A0=C2=A0 gnuplot-py, python-gnuplot or python3-gnuplot, =
gnuplot-nox, ...
> )
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 HWP (Hardware P-States are disabled)
> =C2=A0=C2=A0=C2=A0=C2=A0 Kernel config for Linux trace is enabled
> @@ -23,7 +23,7 @@ Prerequisites:
> =C2=A0=C2=A0=C2=A0=C2=A0 see print_help(): for Usage and Output details
>=20
> =C2=A0"""
> -from __future__ import print_function
> +
> =C2=A0from datetime import datetime
> =C2=A0import subprocess
> =C2=A0import os
> @@ -562,7 +562,7 @@ if __name__ =3D=3D "__main__":
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 # Temporary (or perhaps not)
> =C2=A0=C2=A0=C2=A0=C2=A0 cur_version =3D sys.version_info
> -=C2=A0=C2=A0=C2=A0 print('python version (should be >=3D 2.7):')
> +=C2=A0=C2=A0=C2=A0 print('python version (should be >=3D 3.6):')
> =C2=A0=C2=A0=C2=A0=C2=A0 print(cur_version)
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 # Left as "cleanup" for potential future re-run =
ability.
> --
> 2.25.1
>=20
>=20

