Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4973C775078
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 03:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbjHIBl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 21:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjHIBlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 21:41:55 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 217FC19AF
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 18:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691545315; x=1723081315;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=DL/VNnPhOH+sEGlUMddnec9+aT+H8BDOqJ67yuQV3/U=;
  b=ZNkw2pitiulvP6MDGgO9FsdtD+qyIzJqO+eFLxANAbUT1DwTYQxwX8sV
   Pru/tqX5+FYP41VOScXaERM7c4bHmYWRX1HCFHwesZtzZ7dNVPP2ZTHR4
   kXN349FPxVDPYTUT1AkTlXYcDV2FA6/qFRFgZp0Hsz2d3pMtBpCWepNha
   NMUNf8TojEZQGWPELHjyANHAdVHAziQuZRmSY+ewihXRpBJA/Vs4fK6Z/
   8Rhpc44ev1p0Rwip7A3fNRsRwVmYiN8fNGD+qPI3B/3oDk52hsfabTxII
   eUxGTOg00gLKklz3xLfBXMlUl8Hq9ag13YpQvfgM2SYWgaFvC6cIY7kyW
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="361119765"
X-IronPort-AV: E=Sophos;i="6.01,157,1684825200"; 
   d="scan'208";a="361119765"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 18:41:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="766619081"
X-IronPort-AV: E=Sophos;i="6.01,157,1684825200"; 
   d="scan'208";a="766619081"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 18:41:51 -0700
From:   Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To:     tglx@linutronix.de
Cc:     andrew.cooper3@citrix.com, arjan@linux.intel.com, jgross@suse.com,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com,
        pbonzini@redhat.com, peter@keresztesschmidt.de,
        peterz@infradead.org, thomas.lendacky@amd.com, wei.liu@kernel.org,
        x86@kernel.org, qiuxu.zhuo@intel.com
Subject: Re: [patch V3 51/60] x86/apic: Provide common init infrastructure
Date:   Wed,  9 Aug 2023 09:41:47 +0800
Message-Id: <20230809014147.37136-1-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230801103817.944932383@linutronix.de>
References: <20230801103817.944932383@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Thomas Gleixner <tglx@linutronix.de>
> ...
> Subject: [patch V3 51/60] x86/apic: Provide common init infrastructure
> 
> In preparation for converting the hotpath APIC callbacks to static keys,
> provide common initialization inforastructure.

inforastructure -> infrastructure

> ...
