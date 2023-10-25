Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D18867D6694
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 11:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233979AbjJYJS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 05:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234128AbjJYJSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 05:18:53 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6682C8F
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 02:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698225531; x=1729761531;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VKZaWKRzncOuvfeeEacHAU7Yg5OLgefyKjeLOiPbgx0=;
  b=ZdqHge3wkExYzluKVLZG+wY7rplnKrFJjK5EsOIL0IWcE/FCDIGdluHy
   0JoEXsNlvTLRKK468qD/KE8C29BlMZl4x49FrIyMsb5dluLV1/Re4jGz9
   2m0czt8P47SSY8D27oqOG9hX9cvU3oWxE+5EILPUSouDh7AUrW7Xb5HiN
   TwcTqF1jiC/Grd86y+msCb9PbmaR2vK8LQKUD0h1KAR6+gK1bZl6WYl6o
   Bta7dUZJTd3iKjkfqybDmu02cp5gZoOB096fgBGxyR4it/3dWglW8hUsW
   ZpmOUNoPE39BXABMT9NoMllS0KRUXqnAlB+KZAuD5UBsg3KZ9PG/qD++c
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="384480465"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="384480465"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 02:18:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="882394875"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="882394875"
Received: from shenkel-mobl.ger.corp.intel.com (HELO intel.com) ([10.252.63.39])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 02:18:48 -0700
Date:   Wed, 25 Oct 2023 11:18:45 +0200
From:   Andi Shyti <andi.shyti@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jani Nikula <jani.nikula@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@gmail.com>
Subject: Re: [Intel-gfx] [PATCH v2 2/7] drm/i915/dsi: Get rid of redundant
 'else'
Message-ID: <ZTjddaEfiDAZQ2a1@ashyti-mobl2.lan>
References: <20231024155739.3861342-1-andriy.shevchenko@linux.intel.com>
 <20231024155739.3861342-3-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024155739.3861342-3-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Tue, Oct 24, 2023 at 06:57:34PM +0300, Andy Shevchenko wrote:
> In the snippets like the following
> 
> 	if (...)
> 		return / goto / break / continue ...;
> 	else
> 		...
> 
> the 'else' is redundant. Get rid of it.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>

Andi
