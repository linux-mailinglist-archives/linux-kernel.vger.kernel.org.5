Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 254007D6675
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 11:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232807AbjJYJPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 05:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbjJYJPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 05:15:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D44C2DC
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 02:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698225330; x=1729761330;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rYW6amP+fIPpnP3NeIC+HgesnNCvhKUTO/tNWXvFmPU=;
  b=dnjndGuzKpvlpkItwnfellTgVdIwucsT3DKDnqMoaASvJLBl+JbNIz5j
   9no96HUMqeNbwIB+3/mSXC27t8qQZyTlMBk6NRbYM+ePMFIKbwI3WoPCG
   C3PaapmnTT2Xj2QizzDWTtb0rKNWMyADBP2SyKiKC1rUM2vbhcX6FwrUo
   h/nGCpRucmvovUbBf0O64aVyxXitXcj6OnnKGjvLNk0y3NqbtgRuK9rND
   eihx7zzvLTtMKlkH7Z67jmg0JhOIaHz+z4+uxe50ca9B4CYDXOc2lCfz5
   tsQ0ndASkW29N3sXRzScu2KiWK0mA/cbBtO/ICe0+IDqk1FL4vBuIgEw0
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="367484004"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="367484004"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 02:15:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="849472957"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="849472957"
Received: from shenkel-mobl.ger.corp.intel.com (HELO intel.com) ([10.252.63.39])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 02:15:27 -0700
Date:   Wed, 25 Oct 2023 11:15:24 +0200
From:   Andi Shyti <andi.shyti@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jani Nikula <jani.nikula@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@gmail.com>
Subject: Re: [Intel-gfx] [PATCH v2 1/7] drm/i915/dsi: Replace while(1) with
 one with clear exit condition
Message-ID: <ZTjcrNYd8JBkZ8lb@ashyti-mobl2.lan>
References: <20231024155739.3861342-1-andriy.shevchenko@linux.intel.com>
 <20231024155739.3861342-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024155739.3861342-2-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Tue, Oct 24, 2023 at 06:57:33PM +0300, Andy Shevchenko wrote:
> Move existing condition to while(), so it will be clear on what
> circumstances the loop is successfully finishing.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>

Andi
