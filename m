Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8097FFF69
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 00:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377279AbjK3XYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 18:24:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377269AbjK3XYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 18:24:36 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3225010FC;
        Thu, 30 Nov 2023 15:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701386682; x=1732922682;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=uGbbctLMljhlsB6T/8B4y5j9G3mH6s1oSescm24JZhs=;
  b=PQc5rw54P3Xpi/J6MszJ3rNwOurD0SKkWak37ArKe/hq8ESHW37qoAU7
   adXggPfyS6YVyM/2Q7A2M2op79ROPt8kQt748Dnh6xDHFVRWV6MWtUqPQ
   DtFNGSYHm2IXW7BSI3ewc8hOmcAAjOQDeJUZSxP3f63LUy6KLueMQFB8M
   kqvY4a/4F41/ME96etTOh83o4q1J9EvkXLj5GRm7SyFb6ZniAJ3GiZV+C
   s5vH3JDoxtBlHgbhoa8D45nSjA+2O4RzZYn4y5zGEn2mQY+fLnjDV7jiu
   ciaxjU0KMtT/G1TkxQuEIPIeQa2hyM0SxpzE58U92Vb++lJEE1pYD4yJi
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="411034"
X-IronPort-AV: E=Sophos;i="6.04,240,1695711600"; 
   d="scan'208";a="411034"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 15:24:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="1016809150"
X-IronPort-AV: E=Sophos;i="6.04,240,1695711600"; 
   d="scan'208";a="1016809150"
Received: from jpneilso-mobl3.amr.corp.intel.com (HELO [10.212.31.74]) ([10.212.31.74])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 15:24:39 -0800
Message-ID: <e84824057954fa8593783c4433f5b535f0da6490.camel@linux.intel.com>
Subject: Re: [PATCH v2 0/5] TPMI update for permissions
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org,
        ilpo.jarvinen@linux.intel.com, andriy.shevchenko@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 30 Nov 2023 18:24:38 -0500
In-Reply-To: <20231130214751.3100418-1-srinivas.pandruvada@linux.intel.com>
References: <20231130214751.3100418-1-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-11-30 at 13:47 -0800, Srinivas Pandruvada wrote:
> Process read/write and enabled state for feature drivers. When a
> feature
> is disabled, don't create a device to load a feature driver. When a
> read
> is blocked then don't load feature drivers. When write is blocked
> continue
> to function in read only mode.
>=20
> v2:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Dropped patch platform/x8=
6/intel/tpmi: Add additional TPMI
> header fields
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Addressed other review co=
mments, details are in each patch
>=20
lkp@intel.com is complaining that these patches can't be applied. I
will fix any issue after review and post v3 if required.

Thanks,
Srinivas


> Srinivas Pandruvada (5):
> =C2=A0 platform/x86/intel/tpmi: Don't create devices for disabled feature=
s
> =C2=A0 platform/x86/intel/tpmi: Modify external interface to get
> read/write
> =C2=A0=C2=A0=C2=A0 state
> =C2=A0 platform/x86/intel/tpmi: Move TPMI ID definition
> =C2=A0 platform/x86: ISST: Process read/write blocked feature status
> =C2=A0 platform/x86/intel-uncore-freq: Process read/write blocked feature
> =C2=A0=C2=A0=C2=A0 status
>=20
> =C2=A0.../intel/speed_select_if/isst_tpmi_core.c=C2=A0=C2=A0=C2=A0 | 25 +=
++++++++++++
> =C2=A0drivers/platform/x86/intel/tpmi.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 35 +++++++++--------
> --
> =C2=A0.../uncore-frequency/uncore-frequency-tpmi.c=C2=A0 | 15 ++++++++
> =C2=A0include/linux/intel_tpmi.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 | 18 ++++++++--
> =C2=A04 files changed, 72 insertions(+), 21 deletions(-)
>=20

