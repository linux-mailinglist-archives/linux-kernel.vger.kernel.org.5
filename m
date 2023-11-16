Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E99737EDF5F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 12:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345117AbjKPLQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 06:16:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235730AbjKPLP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 06:15:56 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ABF0D6A
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 03:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700133353; x=1731669353;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=dFk9C6P6EDoLQ/MU1IPFOE63iJQgYNoIm59o9kn9VFk=;
  b=Ywg6p4YRf602rjvGXhN2x1sPyJdbAbjiY+rNgoW6fcwt0jHvhQb9jdK2
   lxKLKFI9TpwWdSvIALXBqoFIBw9nTmDwiqJk/3y+mIH02x+61dnnh8MiI
   YqxGCIcZjWpOvgHblOFEKOR/mp4NyhIkwUwZovo5+Q1s2wMwdlXqKo2DF
   72vVIEEHz1edasAg+sXwZ00dxA/zo7eowbCqtPWvl4zRdBdMncJNXlhy/
   0kFsCEiKG677y2Wm0rYxEHLQ9nQ4Guju/TJCmSthVcf9QIVFo4272E1WQ
   hvYMfFkL8iYqtWIcIBb+tQNorFEai06tISrIKdGWOPt5dsaTK75eUirpe
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="4195243"
X-IronPort-AV: E=Sophos;i="6.03,308,1694761200"; 
   d="scan'208";a="4195243"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2023 03:15:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="1012582924"
X-IronPort-AV: E=Sophos;i="6.03,308,1694761200"; 
   d="scan'208";a="1012582924"
Received: from oroos-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.41.17])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2023 03:15:48 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sui Jingfeng <sui.jingfeng@linux.dev>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Sui Jingfeng <suijingfeng@loongson.cn>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Phong LE <ple@baylibre.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 8/8] drm/bridge: it66121: Allow link this driver as a lib
In-Reply-To: <CAA8EJpokxcO2qXgZ=+f=J+6EhAS_7KkrNJ_oZgk=RMHfv8riog@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20231114150130.497915-1-sui.jingfeng@linux.dev>
 <20231114150130.497915-9-sui.jingfeng@linux.dev>
 <CAA8EJprQq3aDhzE+yKGZ2-nsuHWcptzMvApsyOi9D63PgeiZ3w@mail.gmail.com>
 <50006160-f82b-4ec1-91a4-2ebbd7752e1d@linux.dev>
 <CAA8EJpokxcO2qXgZ=+f=J+6EhAS_7KkrNJ_oZgk=RMHfv8riog@mail.gmail.com>
Date:   Thu, 16 Nov 2023 13:15:46 +0200
Message-ID: <87y1eyosnx.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Nov 2023, Dmitry Baryshkov <dmitry.baryshkov@linaro.org> wrote:
> On Thu, 16 Nov 2023 at 12:29, Sui Jingfeng <sui.jingfeng@linux.dev> wrote:
>>
>> Hi,
>>
>>
>> On 2023/11/15 00:30, Dmitry Baryshkov wrote:
>> >> @@ -703,14 +704,32 @@ static int it66121_bridge_attach(struct drm_bridge *bridge,
>> >>                                   enum drm_bridge_attach_flags flags)
>> >>   {
>> >>          struct it66121_ctx *ctx = bridge_to_it66121(bridge);
>> >> +       struct drm_bridge *next_bridge = ctx->next_bridge;
>> >> +       struct drm_encoder *encoder = bridge->encoder;
>> >>          int ret;
>> >>
>> >> -       if (!(flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR))
>> >> -               return -EINVAL;
>> >> +       if (next_bridge) {
>> >> +               if (!(flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR)) {
>> >> +                       WARN_ON(1);
>> > Why? At least use WARN() instead
>>
>> If (next_bridge) is true, it says that the driver *already* known that
>> it66121 have a next bridges attached. Then it66121 driver should certainly
>> attach it, no matter what it is. Either a connector or another display bridge.
>> It also says that this is a DT-based system on such a case. CallingWARN_ON(1) here helps to see(print) which DC driver is doing the wired
>> things. Ok, I will remove the WARN_ON(1)  on the next version.
>
> That's why I pointed you to WARN(). WARN_ON(1) gives no information to
> the user. WARN() allows you to add a message.

Please use drm_WARN* while at it.

BR,
Jani.


-- 
Jani Nikula, Intel
