Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF8D7FBA90
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 13:54:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344755AbjK1MyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 07:54:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344747AbjK1MyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 07:54:05 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B1DD6D;
        Tue, 28 Nov 2023 04:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701176051; x=1732712051;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=5K++CR/OvistPw0XQfzY/YBgYQVr3P4OlOvmEu/zZC4=;
  b=gXTbmgMBI9JWxWh3pdsub7ntkhG2pDcAauw3qNg36I6GATPTC1nyAgF9
   vPqc8UZTaYjGQko9j/LBoakBrn20KrtCNFcnC9ovXoOQ4uwSbpNKaYpqz
   ZfQLgyagThHQnCT2KdQSFyeGtTSWsQT+oqzKFeAVl/Pnc7FICIRkSGCU/
   cBrDXNB1sWOjs9Jen0SnmTSvWbKm41Dfu/yqTvWJRWnrUDgHL23qM5R2q
   zS+ZxdJJuoI1VxYFsx6okVE2xRwNcNW6bxIFW4hk6aS3VKQtc85yiWD7M
   obPkymzN+aNXptgxxh7fIsf4rM+0ElMlIhlqQboYXv1fPHQ/+puycU12R
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="377943906"
X-IronPort-AV: E=Sophos;i="6.04,233,1695711600"; 
   d="scan'208";a="377943906"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 04:54:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="1015900733"
X-IronPort-AV: E=Sophos;i="6.04,233,1695711600"; 
   d="scan'208";a="1015900733"
Received: from mravivx-mobl.ger.corp.intel.com (HELO localhost) ([10.252.42.57])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 04:54:04 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Maxime Ripard <mripard@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Emma Anholt <emma@anholt.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Sandy Huang <hjc@rock-chips.com>,
        Heiko =?utf-8?Q?St?= =?utf-8?Q?=C3=BCbner?= <heiko@sntech.de>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev,
        Maxime Ripard <mripard@kernel.org>
Subject: Re: [PATCH v4 05/45] drm/connector: Check drm_connector_init
 pointers arguments
In-Reply-To: <20231128-kms-hdmi-connector-state-v4-5-c7602158306e@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20231128-kms-hdmi-connector-state-v4-0-c7602158306e@kernel.org>
 <20231128-kms-hdmi-connector-state-v4-5-c7602158306e@kernel.org>
Date:   Tue, 28 Nov 2023 14:54:02 +0200
Message-ID: <87h6l66nth.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Nov 2023, Maxime Ripard <mripard@kernel.org> wrote:
> All the drm_connector_init variants take at least a pointer to the
> device, connector and hooks implementation.
>
> However, none of them check their value before dereferencing those
> pointers which can lead to a NULL-pointer dereference if the author
> isn't careful.

Arguably oopsing on the spot is preferrable when this can't be caused by
user input. It's always a mistake that should be caught early during
development.

Not everyone checks the return value of drm_connector_init and friends,
so those cases will lead to more mysterious bugs later. And probably
oopses as well.


BR,
Jani.


>
> Let's test those pointers instead and error out if any is NULL.
>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>  drivers/gpu/drm/drm_connector.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
> index b0516505f7ae..2f60755dccdd 100644
> --- a/drivers/gpu/drm/drm_connector.c
> +++ b/drivers/gpu/drm/drm_connector.c
> @@ -229,6 +229,9 @@ static int __drm_connector_init(struct drm_device *dev,
>  	struct ida *connector_ida =
>  		&drm_connector_enum_list[connector_type].ida;
>  
> +	if (!dev || !connector || !funcs)
> +		return -EINVAL;
> +
>  	WARN_ON(drm_drv_uses_atomic_modeset(dev) &&
>  		(!funcs->atomic_destroy_state ||
>  		 !funcs->atomic_duplicate_state));

-- 
Jani Nikula, Intel
