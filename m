Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 611B67ADB3E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 17:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbjIYPVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 11:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231603AbjIYPVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 11:21:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF5F10A
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 08:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695655283; x=1727191283;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=s/7F8JPADE3C56cj5cVed5GZl+/bUbObAnuxptH4P6s=;
  b=TXhIik9f9xQ4cgY5O2HtNlHcKxyqRd3IZnRIjUqR1SjGjaTnmUDRTDPz
   DCmReabDf2fCMiVeL1xOJo99luxN3gqXRs92JXU7VbyNxaeQrc9x9eOQV
   +HGMS7/JTerCcFEMzr8Np/W+XI1NALdeUkiQSK/uWqdSw661gem3kXOxs
   v3z/IJd/d/XV42lZlSCzV+ejKE9Djatt6ZfHQsVSTrKcGOkhgmWoYoc2K
   esWcxyh93jJ8pJcH6+j0uZnoE93ZJ0MW8mVbeTDs9wuBHPgUEpvZs0Iib
   SnSynP9xWgq85oZiLHTKPDpzOe+X1YJ7HnBhWgxmoT24BmcgQRKJpGZh1
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="360658136"
X-IronPort-AV: E=Sophos;i="6.03,175,1694761200"; 
   d="scan'208";a="360658136"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 08:19:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="1079248803"
X-IronPort-AV: E=Sophos;i="6.03,175,1694761200"; 
   d="scan'208";a="1079248803"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 08:19:45 -0700
From:   Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To:     tglx@linutronix.de
Cc:     arjan@linux.intel.com, ashok.raj@intel.com, bp@alien8.de,
        chang.seok.bae@intel.com, linux-kernel@vger.kernel.org,
        nik.borisov@suse.com, x86@kernel.org, qiuxu.zhuo@intel.com
Subject: Re: [patch V3 03/30] x86/microcode/intel: Rip out mixed stepping support for Intel CPUs
Date:   Mon, 25 Sep 2023 23:19:39 +0800
Message-Id: <20230925151939.54555-1-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230912065500.948602532@linutronix.de>
References: <20230912065500.948602532@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> ...
> 
> Mixed steppings aren't supported on Intel CPUs. Only one patch is required
> for the entire system. The caching of micro code blobs which match the

s/micro code/microcode/

> family and model is therefore pointless and in fact it is disfunctional as

s/disfunctional/dysfunctional/

> CPU hotplug updates use only a single microcode blob, i.e. the one where
> *intel_ucode_patch points to.
> 
> Remove the microcode cache and make it an AMD local feature.
> 
> ...
