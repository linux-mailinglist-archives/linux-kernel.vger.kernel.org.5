Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C540C7EAB87
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 09:22:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbjKNIWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 03:22:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbjKNIWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 03:22:46 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8631A6;
        Tue, 14 Nov 2023 00:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699950163; x=1731486163;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=MZt/KOjjeBEpZwQs4CWWZOvi6VhSAlgvO9Gjd3zyI/c=;
  b=P6k2CrWfLK/ese0T2JhVIS+bEX+ce7azo/3AJz8l/F/GNbLsJV5Y/+ZT
   04e+ZD3DUN/maFc1ig8u9C60FgS9chTw5zMduNKO5XEgOXQojtZFl+Alp
   EcGOf88p8788KXdvC2Z9PSsb32o/kI1bX0CC4Wsl2QIqXSBmFBAef1Lnt
   0trqhTRdctpXXhdZ320QN4jhC3VSPFOBb7ycTVbSnazbsMdCE03XF5gMW
   tpiHr6cr9ugFkFc2Rcq+G27eufrFzekkLM2kBJQyGY/GcWbnc8dBCBPGf
   sNHrXtBWRjS+MaYKRxrbR9EOz1nfoBaUVclIFefwOuSkNnQGi5E4iEWvG
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="421706970"
X-IronPort-AV: E=Sophos;i="6.03,301,1694761200"; 
   d="scan'208";a="421706970"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 00:22:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="741025692"
X-IronPort-AV: E=Sophos;i="6.03,301,1694761200"; 
   d="scan'208";a="741025692"
Received: from hatran1-mobl1.ccr.corp.intel.com (HELO localhost) ([10.252.56.145])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 00:22:28 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Imre Deak <imre.deak@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the drm-intel tree
In-Reply-To: <20231114141715.6f435118@canb.auug.org.au>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20231114141715.6f435118@canb.auug.org.au>
Date:   Tue, 14 Nov 2023 10:22:25 +0200
Message-ID: <8734x8u4la.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Nov 2023, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi all,
>
> After merging the drm-intel tree, today's linux-next build (htmldocs)
> produced this warning:
>
> Documentation/gpu/drm-kms-helpers:296: drivers/gpu/drm/display/drm_dp_mst_topology.c:5484: ERROR: Unexpected indentation.
> Documentation/gpu/drm-kms-helpers:296: drivers/gpu/drm/display/drm_dp_mst_topology.c:5488: WARNING: Block quote ends without a blank line; unexpected unindent.
>
> Introduced by commit
>
>   1cd0a5ea4279 ("drm/dp_mst: Factor out a helper to check the atomic state of a topology manager")

Imre, please fix this.

Thanks,
Jani.

-- 
Jani Nikula, Intel
