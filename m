Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C362C791162
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 08:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234339AbjIDGc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 02:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231654AbjIDGc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 02:32:56 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2AC9D9
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 23:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693809173; x=1725345173;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ql1SeTsT6ragrHVV+S7gG0Gx1pDdAI3ifiqhz6TY8BI=;
  b=ZJDw/NoBZHdGNyKNRvgepmrApPgaqWdzZRFR0a/DqeRRnqFbAx9Iw5oh
   x/RvEyfCb2YN1ISG+GmKo0mcG+uiNH2sZEIKoCknGY3qXKPzkMtxhOjVx
   oWM8eJYBZeZpAxQibNhkC54b30VN4urFse+NYaITPAeww2N/YCCYFlcuE
   cGDLjdOLflMPsfI8YABF7HPbeXu6WhHujyu4nH1Yecx1qy4UjF1mARFHX
   3KKevdw+W04AsF+Eu3FOj12E4GeZE6mDrtPF2za/9m9JJmvTixvew3dmG
   kByRltZCKeAaYLSnGeWKKJk/fU2SRP+JQKyuiFgBXmg7ZEHWfRuo6IYQQ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="366750378"
X-IronPort-AV: E=Sophos;i="6.02,225,1688454000"; 
   d="scan'208";a="366750378"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2023 23:32:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="914404453"
X-IronPort-AV: E=Sophos;i="6.02,225,1688454000"; 
   d="scan'208";a="914404453"
Received: from acohen8-mobl2.ger.corp.intel.com (HELO intel.com) ([10.252.59.133])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2023 23:32:44 -0700
Date:   Mon, 4 Sep 2023 08:32:40 +0200
From:   Andi Shyti <andi.shyti@linux.intel.com>
To:     Jim Cromie <jim.cromie@gmail.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, daniel.vetter@ffwll.ch,
        daniel@ffwll.ch, jani.nikula@intel.com,
        ville.syrjala@linux.intel.com, seanpaul@chromium.org,
        robdclark@gmail.com, Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Imre Deak <imre.deak@intel.com>,
        Radhakrishna Sripada <radhakrishna.sripada@intel.com>,
        Mika Kahola <mika.kahola@intel.com>,
        =?iso-8859-15?Q?Jos=E9?= Roberto de Souza 
        <jose.souza@intel.com>,
        Ankit Nautiyal <ankit.k.nautiyal@intel.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Matthew Auld <matthew.auld@intel.com>,
        Andi Shyti <andi.shyti@linux.intel.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rob Clark <robdclark@chromium.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Fei Yang <fei.yang@intel.com>
Subject: Re: [PATCH v2 3/6] drm_dbg: add trailing newlines to msgs
Message-ID: <ZPV6CMBlDWriMyva@ashyti-mobl2.lan>
References: <20230903184607.272198-1-jim.cromie@gmail.com>
 <20230903184607.272198-4-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230903184607.272198-4-jim.cromie@gmail.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jim,

On Sun, Sep 03, 2023 at 12:46:00PM -0600, Jim Cromie wrote:
> By at least strong convention, a print-buffer's trailing newline says
> "message complete, send it".  The exception (no TNL, followed by a call
> to pr_cont) proves the general rule.
> 
> Most DRM.debug calls already comport with this: 207 DRM_DEV_DEBUG,
> 1288 drm_dbg.  Clean up the remainders, in maintainer sized chunks.
> 
> No functional changes.
> 
> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>

Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com> 

Andi
