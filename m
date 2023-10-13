Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 860D27C830E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 12:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbjJMKbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 06:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjJMKbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 06:31:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D247EC2;
        Fri, 13 Oct 2023 03:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697193059; x=1728729059;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Aplyv6rJwAzx3jF4qUT1h44OjNduEae/nQks1TM9J9g=;
  b=gTt3mYK39abnB8x8YmO+Ox+rSAhQkO7jpVgcdzHpJE19hnhWB30aUoQN
   t3WvK1Tryjz7AxhB5v4nEFWg93TB2dFGBccwOVK1vROGrcNeiiiJbamAh
   4qsEBmJhoLnAN5NxXGUIZEt5XKhhi57Sj1iRnt8E5E0bWciR3ndRG8VcQ
   Oc2gYipdeYVZA5++JjsXdvHCftr4d2MCg1znGT0b1oOyCQcjn2nEF7dhG
   +Ts3T6YP1s1QoUQl1elOng4IPqenhs8yzrOmY+GpH9rGE+vFuFLndpzTj
   quHbnMqNISB0aQMVCfOq5o6hio0hCr+J+8ewhqUcsFAszAapy265Xpc38
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="364515513"
X-IronPort-AV: E=Sophos;i="6.03,221,1694761200"; 
   d="scan'208";a="364515513"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 03:30:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="758453505"
X-IronPort-AV: E=Sophos;i="6.03,221,1694761200"; 
   d="scan'208";a="758453505"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by fmsmga007.fm.intel.com with SMTP; 13 Oct 2023 03:30:55 -0700
Received: by stinkbox (sSMTP sendmail emulation); Fri, 13 Oct 2023 13:30:55 +0300
Date:   Fri, 13 Oct 2023 13:30:55 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Hamza Mahfooz <hamza.mahfooz@amd.com>
Cc:     dri-devel@lists.freedesktop.org,
        Maxime Ripard <mripard@kernel.org>,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH] drm/edid: add 8 bpc quirk to the BenQ GW2765
Message-ID: <ZSkcX1nJ4Ipf2ICd@intel.com>
References: <20231012184927.133137-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231012184927.133137-1-hamza.mahfooz@amd.com>
X-Patchwork-Hint: comment
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 02:49:27PM -0400, Hamza Mahfooz wrote:
> The BenQ GW2765 reports that it supports higher (> 8) bpc modes, but
> when trying to set them we end up with a black screen. So, limit it to 8
> bpc modes.

Bad cable/etc was ruled out as the cause?

> 
> Cc: stable@vger.kernel.org # 6.5+
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2610
> Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
> ---
>  drivers/gpu/drm/drm_edid.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
> index 0454da505687..bca2af4fe1fc 100644
> --- a/drivers/gpu/drm/drm_edid.c
> +++ b/drivers/gpu/drm/drm_edid.c
> @@ -123,6 +123,9 @@ static const struct edid_quirk {
>  	/* AEO model 0 reports 8 bpc, but is a 6 bpc panel */
>  	EDID_QUIRK('A', 'E', 'O', 0, EDID_QUIRK_FORCE_6BPC),
>  
> +	/* BenQ GW2765 */
> +	EDID_QUIRK('B', 'N', 'Q', 0x78d6, EDID_QUIRK_FORCE_8BPC),
> +
>  	/* BOE model on HP Pavilion 15-n233sl reports 8 bpc, but is a 6 bpc panel */
>  	EDID_QUIRK('B', 'O', 'E', 0x78b, EDID_QUIRK_FORCE_6BPC),
>  
> -- 
> 2.42.0

-- 
Ville Syrjälä
Intel
