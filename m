Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE3947DF38F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 14:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376434AbjKBNUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 09:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjKBNUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 09:20:20 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE7BED7
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 06:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698931215; x=1730467215;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=ZSB0D9+QPHya+v4cvK58f2fNKNEFAu+NyRQszqhx4d8=;
  b=MU8FeUc/KVxkUTbV6FF1Y/iZiqdswqUwpsOordThWv7uozgpd7AzOcaW
   mamseuvkaIarfh7dLT3WlTuiKGDWdrl9kQk7pV5F9DWEIOfz/3Q1d3idf
   viQ7SvuHV5bj5lfH/BLvUutQRM5hfBKQ9bvJ2nOu8euY4XjPvR+hadcLj
   033ZQUeTG8Q97FClmP9LWaOwuUc+d6XDpRRdHQR/YlNq8PcyuJtKoZGmr
   U2iQXHNQibxSMsDo0v7Ws1tIwvrXE3am0Ns0qe+GK/VmnJIANBeayJnCx
   M8xEYpj+vJavkXr/4fPHDWy1JAeq+EIHO1rNOB0Sogsf1yXdcFs7+BiDb
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="7348966"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="7348966"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 06:20:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="1008461052"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="1008461052"
Received: from binsumax-mobl.gar.corp.intel.com (HELO [10.249.254.171]) ([10.249.254.171])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 06:20:11 -0700
Message-ID: <9ccea100e2031671c7a970b71ce66f83e4ea0e93.camel@linux.intel.com>
Subject: Re: [PATCH drm-misc-next v8 03/12] drm/gpuvm: export
 drm_gpuvm_range_valid()
From:   Thomas =?ISO-8859-1?Q?Hellstr=F6m?= 
        <thomas.hellstrom@linux.intel.com>
To:     Danilo Krummrich <dakr@redhat.com>, airlied@gmail.com,
        daniel@ffwll.ch, matthew.brost@intel.com, sarah.walker@imgtec.com,
        donald.robson@imgtec.com, boris.brezillon@collabora.com,
        christian.koenig@amd.com, faith@gfxstrand.net
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 02 Nov 2023 14:20:08 +0100
In-Reply-To: <20231101233113.8059-4-dakr@redhat.com>
References: <20231101233113.8059-1-dakr@redhat.com>
         <20231101233113.8059-4-dakr@redhat.com>
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-11-02 at 00:30 +0100, Danilo Krummrich wrote:
> Drivers may use this function to validate userspace requests in
> advance,
> hence export it.
>=20
> Signed-off-by: Danilo Krummrich <dakr@redhat.com>
Reviewed-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>

> ---
> =C2=A0drivers/gpu/drm/drm_gpuvm.c | 14 +++++++++++++-
> =C2=A0include/drm/drm_gpuvm.h=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> =C2=A02 files changed, 14 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/drm_gpuvm.c
> b/drivers/gpu/drm/drm_gpuvm.c
> index 445767f8fbc4..2669f9bbc377 100644
> --- a/drivers/gpu/drm/drm_gpuvm.c
> +++ b/drivers/gpu/drm/drm_gpuvm.c
> @@ -649,7 +649,18 @@ drm_gpuvm_in_kernel_node(struct drm_gpuvm
> *gpuvm, u64 addr, u64 range)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return krange && addr < k=
end && kstart < end;
> =C2=A0}
> =C2=A0
> -static bool
> +/**
> + * drm_gpuvm_range_valid() - checks whether the given range is valid
> for the
> + * given &drm_gpuvm
> + * @gpuvm: the GPUVM to check the range for
> + * @addr: the base address
> + * @range: the range starting from the base address
> + *
> + * Checks whether the range is within the GPUVM's managed
> boundaries.
> + *
> + * Returns: true for a valid range, false otherwise
> + */
> +bool
> =C2=A0drm_gpuvm_range_valid(struct drm_gpuvm *gpuvm,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 addr, u64 range)
> =C2=A0{
> @@ -657,6 +668,7 @@ drm_gpuvm_range_valid(struct drm_gpuvm *gpuvm,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 drm_gpuvm_in_mm_range(gpuvm, addr, range) &&
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 !drm_gpuvm_in_kernel_node(gpuvm, addr, range);
> =C2=A0}
> +EXPORT_SYMBOL_GPL(drm_gpuvm_range_valid);
> =C2=A0
> =C2=A0/**
> =C2=A0 * drm_gpuvm_init() - initialize a &drm_gpuvm
> diff --git a/include/drm/drm_gpuvm.h b/include/drm/drm_gpuvm.h
> index 687fd5893624..13eac6f70061 100644
> --- a/include/drm/drm_gpuvm.h
> +++ b/include/drm/drm_gpuvm.h
> @@ -253,6 +253,7 @@ void drm_gpuvm_init(struct drm_gpuvm *gpuvm,
> const char *name,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct drm_gpuvm_ops *ops)=
;
> =C2=A0void drm_gpuvm_destroy(struct drm_gpuvm *gpuvm);
> =C2=A0
> +bool drm_gpuvm_range_valid(struct drm_gpuvm *gpuvm, u64 addr, u64
> range);
> =C2=A0bool drm_gpuvm_interval_empty(struct drm_gpuvm *gpuvm, u64 addr, u6=
4
> range);
> =C2=A0
> =C2=A0static inline struct drm_gpuva *

