Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC8B576CA7F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 12:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232056AbjHBKJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 06:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbjHBKJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 06:09:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF84910B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 03:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690970980; x=1722506980;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=ONzB0seRRHiclo5dMgN21BC+phncruTYL7IKOB4VVg4=;
  b=MnxyaJCBTlFNNxaKjS6NkFTUZo6WEW5nA4x4AbytJgfwnaMtrG8JbuF8
   9Cns7I+JDx/hOpqaioitixdcBmjKUtl94rxjIt/By++fGTfYlcbyKSZVJ
   10w8Tzdbl8NzPbC5lTg/4A/WGixVyt04t3v3qyNEf2+WSGQK42hZccLK1
   Lw3oVCZFdeb/H1FnJvEf+n+LxWTN4S//4IKF4nG7NzMNR/Y86D2t2J0/b
   lgVOG/PJ9k3b95WtwbvSh3fpCZDm4xsMgeNLm0nccXNejGpdDXAbbUyIv
   DBePlMmM3BCcF0P1gRIuQceqrUNVU/WgcANfuKjCG4jQaAXzULNkt7O55
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="367003302"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="367003302"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 03:09:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="764167575"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="764167575"
Received: from osalyk-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.62.215])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 03:09:38 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Ran Sun <sunran001@208suo.com>, alexander.deucher@amd.com,
        airlied@gmail.com, daniel@ffwll.ch
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/amd/pm: Clean up errors in smu73_discrete.h
In-Reply-To: <2f4f53e2-b12b-c77c-e7cb-8c0436a209e5@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20230801100024.8215-1-sunran001@208suo.com>
 <ZMjposYeMFxU5nE9@debian.me> <87cz07vvwu.fsf@intel.com>
 <2f4f53e2-b12b-c77c-e7cb-8c0436a209e5@gmail.com>
Date:   Wed, 02 Aug 2023 13:09:35 +0300
Message-ID: <87o7jpvjq8.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Aug 2023, Bagas Sanjaya <bagasdotme@gmail.com> wrote:
> On 01/08/2023 18:34, Jani Nikula wrote:
>> On Tue, 01 Aug 2023, Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>>> And it is unfortunate that you and @208suo.com people doesn't reply to
>>> review comments (try searching lore.kernel.org)
>> 
>> Essentially a one-way firehose of patches pointed at our general
>> direction is not benefitial to the community. It's not participation,
>> it's not co-operation. If the review gets ignored, why should we invest
>> our time on *any* of the patches?
>> 
>> 
>
> Well, I guess this is the kind of "hey, some new orgs spam us tens
> of trivial patches, then we review them as usual, but people from
> that org are deaf in regards of our reviews (maybe deliberately?)".
> The exact same situation happened last year with @cdjrlc.com
> people, when they were notoriously known for spell-fixing and
> redundant word fixing patches. Many of these patches were correct,
> but some of them were not, triggering reviews requesting changes.
> Yet, they also ignore the reviews.

Since these emails, there have been 50+ more individual patches. :(

BR,
Jani.

-- 
Jani Nikula, Intel Open Source Graphics Center
