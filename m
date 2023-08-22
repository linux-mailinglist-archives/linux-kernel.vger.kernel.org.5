Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72258783FDB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 13:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235196AbjHVLq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 07:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234461AbjHVLq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 07:46:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CEF7E4A
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 04:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692704756; x=1724240756;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=NhLbpMBB+lX2f+xyEl+B8376ASkcAco+ugMB0R+Q15o=;
  b=XVLnZKCJ5sFVdsa7peA5EHsNB3+tl7kiJqqLx35mRes3GQwqmZGaP+8U
   Z8+HYOIK3s85c3DUujbWyyJ/mfvPEozCNPEiKtEeEJimG5ELDoj0ur8gs
   sbEuDtQHgIA1gxClSViINdxYl3MPM9QK8kQSpETvhEsegNQsiRs4wrCEt
   790jbkr2787DFZwGQ+5wRj+jp2Tcd7gitpa15mkEi1N93RqUHMLq2JJx4
   ha78ql9f0L6hJL1B7T4QWBOHq/aF+p1o8xePoXJMvebyoQ0phUXle5c/i
   IykK2C+zFdLQCt8E4qFJhOa4GueUsa0ZOvbvDvJxt1ZUCy9+1HTHCgjTq
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="372751656"
X-IronPort-AV: E=Sophos;i="6.01,192,1684825200"; 
   d="scan'208";a="372751656"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 04:44:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="850580730"
X-IronPort-AV: E=Sophos;i="6.01,192,1684825200"; 
   d="scan'208";a="850580730"
Received: from kainaats-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.42.230])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 04:43:55 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Hamza Mahfooz <hamza.mahfooz@amd.com>,
        amd-gfx@lists.freedesktop.org
Cc:     Wenjing Liu <wenjing.liu@amd.com>, dri-devel@lists.freedesktop.org,
        Hamza Mahfooz <hamza.mahfooz@amd.com>,
        Jun Lei <Jun.Lei@amd.com>, Nasir Osman <nasir.osman@amd.com>,
        kernel test robot <lkp@intel.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Stylon Wang <stylon.wang@amd.com>, Leo Li <sunpeng.li@amd.com>,
        pengfuyuan <pengfuyuan@kylinos.cn>,
        Hersen Wu <hersenxs.wu@amd.com>,
        Mike Hsieh <Mike.Hsieh@amd.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Qingqing Zhuo <qingqing.zhuo@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>, linux-kernel@vger.kernel.org,
        Leon Huang <Leon.Huang1@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?utf-8?Q?K=C3=B6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH 3/3] drm/amd/display: drop unused count variable in
 create_eml_sink()
In-Reply-To: <20230517183350.314082-3-hamza.mahfooz@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20230517183350.314082-1-hamza.mahfooz@amd.com>
 <20230517183350.314082-3-hamza.mahfooz@amd.com>
Date:   Tue, 22 Aug 2023 14:43:53 +0300
Message-ID: <87a5uj7152.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 May 2023, Hamza Mahfooz <hamza.mahfooz@amd.com> wrote:
> Since, we are only interested in having
> drm_edid_override_connector_update(), update the value of
> connector->edid_blob_ptr. We don't care about the return value of
> drm_edid_override_connector_update() here. So, drop count.
>
> Fixes: 068553e14f86 ("drm/amd/display: assign edid_blob_ptr with edid from debugfs")

The *real* problems with that commit are:

1) It uses drm_edid_override_connector_update() *at all*. Its
   documentation says:

	Only to be used from drm_helper_probe_single_connector_modes()
	as a fallback for when DDC probe failed during drm_get_edid()
	and caused the override/firmware EDID to be skipped.

2) It messes with edid_blob_ptr directly. All drivers should stop doing
   that. It just complicates all the logic in the overrides and the
   property updates.


BR,
Jani.


> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 14b296e1d0f6..5a2d04f47276 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -6396,9 +6396,8 @@ static void create_eml_sink(struct amdgpu_dm_connector *aconnector)
>  		/* if connector->edid_override valid, pass
>  		 * it to edid_override to edid_blob_ptr
>  		 */
> -		int count;
>  
> -		count = drm_edid_override_connector_update(&aconnector->base);
> +		drm_edid_override_connector_update(&aconnector->base);
>  
>  		if (!aconnector->base.edid_blob_ptr) {
>  			DRM_ERROR("No EDID firmware found on connector: %s ,forcing to OFF!\n",

-- 
Jani Nikula, Intel Open Source Graphics Center
