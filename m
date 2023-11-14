Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0404D7EAC1A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 09:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbjKNIxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 03:53:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231975AbjKNIxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 03:53:44 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B42CA4;
        Tue, 14 Nov 2023 00:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699952021; x=1731488021;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=yAw9k3gw5sgGKUi8oLnxSsuyohYC1OCk82oksGDoQpk=;
  b=YI/9Ap2R4N41jCBfKvE5PmWQHpPkv6/8S5Hb+G1+S+LTKvNOiTSoRANO
   SwA3tQseFUOb/3halXpXbZ7ZtqBwENaHoueieGuAhIGuylVovRphETv0F
   QLTDkcgtqe3LChwfBbiDA5QilCBQ+9XeKpaHNNoEidu2H0zKOK5BdDVgH
   ByD4ZzyaqEZb5FNprCEL5Meil2CwM8qfCKKwNyQccWiI+FJDD749nYwqv
   +I0BiXEI54QfJbc4RCcXcTh19SmCOz4NP3Q+65IqGK//uL61hK5geXODj
   MBiCQw7TKmiBrptELTN6UH+SIJNQJweSveFymSfUwov1t8tvxdk5wPThg
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="394526088"
X-IronPort-AV: E=Sophos;i="6.03,301,1694761200"; 
   d="scan'208";a="394526088"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 00:53:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="1011849315"
X-IronPort-AV: E=Sophos;i="6.03,301,1694761200"; 
   d="scan'208";a="1011849315"
Received: from hatran1-mobl1.ccr.corp.intel.com (HELO localhost) ([10.252.56.145])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 00:53:32 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the drm-intel tree
In-Reply-To: <8734x8u4la.fsf@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20231114141715.6f435118@canb.auug.org.au>
 <8734x8u4la.fsf@intel.com>
Date:   Tue, 14 Nov 2023 10:53:30 +0200
Message-ID: <87y1f0sol1.fsf@intel.com>
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

On Tue, 14 Nov 2023, Jani Nikula <jani.nikula@linux.intel.com> wrote:
> On Tue, 14 Nov 2023, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>> Hi all,
>>
>> After merging the drm-intel tree, today's linux-next build (htmldocs)
>> produced this warning:
>>
>> Documentation/gpu/drm-kms-helpers:296: drivers/gpu/drm/display/drm_dp_mst_topology.c:5484: ERROR: Unexpected indentation.
>> Documentation/gpu/drm-kms-helpers:296: drivers/gpu/drm/display/drm_dp_mst_topology.c:5488: WARNING: Block quote ends without a blank line; unexpected unindent.
>>
>> Introduced by commit
>>
>>   1cd0a5ea4279 ("drm/dp_mst: Factor out a helper to check the atomic state of a topology manager")
>
> Imre, please fix this.

Just noticed there's a fix [1]. Need to merge that via drm-intel.

BR,
Jani.

[1] https://patchwork.freedesktop.org/patch/msgid/20231114081033.27343-1-bagasdotme@gmail.com

>
> Thanks,
> Jani.

-- 
Jani Nikula, Intel
