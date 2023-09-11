Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF20079B008
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349807AbjIKWZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236342AbjIKKXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 06:23:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE6D81AB
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 03:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694427819; x=1725963819;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=bvEMa2Vj8vG0UZTNEnBqLbnPwQfb0MClvUIcOVW2KS0=;
  b=V2G3SL28G8epxJ9RjjFAIDXD2LBb4arYfqkJfnZ2JVxxPIzENaKEQVzR
   yESEUZrCWxdoF1D75CWmzwNCavvrBljpGOKSYmhJdRGxVPm0F3gpeWhyU
   LnlRslLqILLSCtAvIlA/kFXH4I60BnqpNepLRuF2ShkMH7VbkFS9ZCksv
   mTE9ddFTS80LlxAHf86fTpl9VHtIwqOlNO3JnRwk33vYs3G81UVwb2Y0M
   hCZPErZlnKKPTOwp5NSAI2DmKAuJYbDrXMaLJyq49yEj3LJqUKzKv6mUK
   dBaT+/sJpfxQB428YlyjLvKid9RqdJreKy+1lUgqbOfXEKJzpvCNJUPOS
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="368286754"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="368286754"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 03:23:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="833455779"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="833455779"
Received: from kschuele-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.63.119])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 03:23:36 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Maxime Ripard <mripard@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: (subset) [PATCH v2] drm/connector: document
 DRM_MODE_COLORIMETRY_COUNT
In-Reply-To: <169409716450.2201230.1132363284756871897.b4-ty@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20230906-topic-drm_connector_doc-v2-1-1f2dcaa43269@gmail.com>
 <169409716450.2201230.1132363284756871897.b4-ty@kernel.org>
Date:   Mon, 11 Sep 2023 13:23:34 +0300
Message-ID: <87il8hf1p5.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 07 Sep 2023, Maxime Ripard <mripard@kernel.org> wrote:
> On Wed, 06 Sep 2023 22:47:38 +0200, Javier Carrasco wrote:
>> The drm_colorspace enum member DRM_MODE_COLORIMETRY_COUNT has been
>> properly documented by moving the description out of the enum to the
>> member description list to get rid of an additional warning and improve
>> documentation clarity.
>> 
>> 
>
> Applied to drm/drm-misc (drm-misc-next).

After the fact, but adding /* private: */ would've been an alternative
approach. I think support for that for enums should be there.

Anyway, just for future reference, the merged patch is fine.

BR,
Jani.

>
> Thanks!
> Maxime
>

-- 
Jani Nikula, Intel Open Source Graphics Center
