Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7EDB77B268
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 09:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234133AbjHNH1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 03:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234095AbjHNH04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 03:26:56 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF676E73;
        Mon, 14 Aug 2023 00:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691998015; x=1723534015;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fJy8W7xTgs+ewccv0eUJYr8iqTVcjrrPHPF1T9aRC98=;
  b=akq0lYAfoudJ/zSg+XwNSUNS/579t0osqPskAt0EbNx5NIZcUq8heTdn
   Vtprt/ke+JkOkIByXa7T3tqk0XD+D96cckoUc1UT81s/VRQghFDh/ZmAY
   kCj1IhphK5JpeEBfseakmykt0+osNxKk/tAJCZtto4aTrtmumWh9pXh+L
   QaUbWksbIoJBdS05V53FZDO4SFMvu+mb8QQdoanWrrVOLLQp9eUP2WLtT
   u/wOgXtlmZEylqzuMSt7IS4f4VtkDLNMZg4Wsnz1AhiQFDBbvPBLr7Izy
   BK3D0SGb4dSVWG5q9HXTeplg4gY8emdfRh+O8MJsXmP12zfDQgu2M9g3+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10801"; a="351579342"
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="scan'208";a="351579342"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 00:26:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10801"; a="803369875"
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="scan'208";a="803369875"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 14 Aug 2023 00:26:53 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id D1A2C33B; Mon, 14 Aug 2023 10:34:05 +0300 (EEST)
Date:   Mon, 14 Aug 2023 10:34:05 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Raag Jadav <raag.jadav@intel.com>
Cc:     linus.walleij@linaro.org, andriy.shevchenko@linux.intel.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, pandith.n@intel.com
Subject: Re: [PATCH v1 0/4] Reuse common functions from pinctrl-intel
Message-ID: <20230814073405.GX14638@black.fi.intel.com>
References: <20230814060311.15945-1-raag.jadav@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230814060311.15945-1-raag.jadav@intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Aug 14, 2023 at 11:33:07AM +0530, Raag Jadav wrote:
>  drivers/pinctrl/intel/Kconfig              |  6 +-
>  drivers/pinctrl/intel/pinctrl-baytrail.c   | 90 +++-------------------
>  drivers/pinctrl/intel/pinctrl-cherryview.c | 69 +++--------------
>  drivers/pinctrl/intel/pinctrl-intel.c      | 30 ++++----
>  drivers/pinctrl/intel/pinctrl-intel.h      | 12 +++
>  drivers/pinctrl/intel/pinctrl-lynxpoint.c  | 86 ++-------------------
>  6 files changed, 57 insertions(+), 236 deletions(-)

This is really nice reductions of lines :-)

For the whole series,

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
