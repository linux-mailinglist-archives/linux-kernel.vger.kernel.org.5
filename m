Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDB0E7F6164
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 15:26:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345787AbjKWO0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 09:26:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345739AbjKWO0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 09:26:17 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B55B9;
        Thu, 23 Nov 2023 06:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700749583; x=1732285583;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=RuvBCPcmRJqqZftA5SLrOzyyk9Yk16dQi7YsEKLQFt8=;
  b=aKcC4J0AGH76JeAKv+ZRBK5PlPCRsIaKQjlwlfPz8M36q/ymcA4nYFZH
   Mi/YpWF/HqLWOnbERtlFWtycZ8r/KqUQ4QscD47aOeugMnsN2cqUICcOW
   nUv+t6hrkwfSxRyC8JrIAcfhPuCFqJSIC0YjsK0/mzsNy5tTk5Vx6wm75
   hDP9/PFyn7537la3M656z9VJq4Nd+7wYUmj6xaVueogPsQd1ZDftykB7G
   gVbSS3ePSWUuw/bDO9Mmewhsw1mEqYesx5cjndWem56P1taqJNbbMa6Zf
   uMGe4ewm2LdilF2HXqRerHxhIonRxdcSMwnzjloF3Tb0ATH98H1j13PaS
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="382677622"
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="scan'208";a="382677622"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 06:26:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="717070840"
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="scan'208";a="717070840"
Received: from mstrobel-mobl.ger.corp.intel.com ([10.252.40.70])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 06:26:21 -0800
Date:   Thu, 23 Nov 2023 16:26:19 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "David E. Box" <david.e.box@linux.intel.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org, rajvi.jingar@linux.intel.com
Subject: Re: [PATCH V5 13/20] platform/x86/intel/pmc: Cleanup SSRAM
 discovery
In-Reply-To: <20231123040355.82139-14-david.e.box@linux.intel.com>
Message-ID: <b1968128-d78a-9b34-6181-98d4e0a4bb2f@linux.intel.com>
References: <20231123040355.82139-1-david.e.box@linux.intel.com> <20231123040355.82139-14-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1369899486-1700749583=:1676"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1369899486-1700749583=:1676
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Wed, 22 Nov 2023, David E. Box wrote:

> Clean up the code handling SSRAM discovery. Handle all resource allocation
> and cleanup in pmc_core_ssram_get_pmc(). Return the error status from this
> function but only fail the init if we fail to discover the primary PMC.
> 
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>

Very easy to follow, thanks for making it this way (in fact so easy
I started to doubt my eyes as I didn't find any flaws in it :-)).

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-1369899486-1700749583=:1676--
