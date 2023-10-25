Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F51C7D66B1
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 11:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234262AbjJYJY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 05:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233692AbjJYJY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 05:24:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A45DC
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 02:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698225895; x=1729761895;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Z5QuHEH9/Il1E5F4X+UOg9jbSOOGe6HK4yUv0ZPfB/w=;
  b=idUasxdNicP7LVYk+nceEsvJXvMxxbvsbEuZbLkrbNtuqtEQi+wT4tH+
   QV1DsIOg1x/jfZyti+41vfmshBDw+4YsoogUyDKhPm74yLUcwtx9Pt+9w
   +Dl8hqBXL25E5ZHeNyCtZMfBSDT0Vw4OgK5W0mnNze+pEUw3+S6h8kvz6
   C9xTSt55C5YOst/YKjf3QqCvXHmPRwli4AGnuY9ary4tD6jBpjUSDoVZe
   qSa0jqIxGaqNFh1+Q3nDa5xjbuGBUS/LyNwynSDCk4/sw0hbTpBe+0Ytx
   8K6vkZfam4IpJn58z+WrHkIsLef0wsJR5hwiiuarJvzHCkYHM45LT25aO
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="473508350"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="473508350"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 02:24:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="1005946234"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="1005946234"
Received: from shenkel-mobl.ger.corp.intel.com (HELO intel.com) ([10.252.63.39])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 02:24:52 -0700
Date:   Wed, 25 Oct 2023 11:24:49 +0200
From:   Andi Shyti <andi.shyti@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jani Nikula <jani.nikula@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@gmail.com>
Subject: Re: [Intel-gfx] [PATCH v2 3/7] drm/i915/dsi: Replace check with a
 (missing) MIPI sequence name
Message-ID: <ZTje4ZFzDLuVWkxB@ashyti-mobl2.lan>
References: <20231024155739.3861342-1-andriy.shevchenko@linux.intel.com>
 <20231024155739.3861342-4-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024155739.3861342-4-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 06:57:35PM +0300, Andy Shevchenko wrote:
> Names of the MIPI sequence steps are sequential and defined, no
> need to check for the gaps. However in seq_name the MIPI_SEQ_END
> is missing. Add it there, and drop unneeded NULL check in
> sequence_name().
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>

Andi
