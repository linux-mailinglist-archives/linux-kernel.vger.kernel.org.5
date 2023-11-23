Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64A6F7F6114
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 15:08:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345704AbjKWOIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 09:08:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345693AbjKWOIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 09:08:21 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D231BD;
        Thu, 23 Nov 2023 06:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700748507; x=1732284507;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=umwDKZhXx2hLm7DW386Y1ZZ1CWEgbWF3n/PNhEesmmM=;
  b=BSOaDJddjAEfZsRpCzksWMDGyhD7fmQq9dUiJJ1X3m41aPXF9bi/SB/Y
   KGJl3YB2t6lC+H2aRsJ/fEEnafVqkiFovrKKMfHx/wadi6TVQnIxYjGTr
   PWSZ+ZwPZJAom7jTVNP9MrUOgvhg/A86jDOYu59LEMArQ5O2gZtiMZIik
   voKtMsgYeHN+xbXtx4a378boGf6nLc87/POR1W9V/X7E2UJzKGC9IHF15
   WFY/z9AJewMsrsvcAWCLqQbxK1czcyYk1DMfVk2t9dPcXZV9HjFApAAaU
   e94mgA5QNuYq4BK+95WZyPssGw56Z82s7g4+n8FjmZzZahKmQM6QsgwYr
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="377296321"
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="scan'208";a="377296321"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 06:08:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="1098833895"
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="scan'208";a="1098833895"
Received: from mstrobel-mobl.ger.corp.intel.com ([10.252.40.70])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 06:08:25 -0800
Date:   Thu, 23 Nov 2023 16:08:23 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "David E. Box" <david.e.box@linux.intel.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org, rajvi.jingar@linux.intel.com
Subject: Re: [PATCH V5 16/20] platform/x86/intel/pmc: Display LPM requirements
 for multiple PMCs
In-Reply-To: <20231123040355.82139-17-david.e.box@linux.intel.com>
Message-ID: <fe419f5-3ff3-3677-419-735dd7e66473@linux.intel.com>
References: <20231123040355.82139-1-david.e.box@linux.intel.com> <20231123040355.82139-17-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-2093636943-1700748506=:1676"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2093636943-1700748506=:1676
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Wed, 22 Nov 2023, David E. Box wrote:

> From: Rajvi Jingar <rajvi.jingar@linux.intel.com>
> 
> Update the substate_requirements attribute to display the requirements for
> all the PMCs on a package.
> 
> Signed-off-by: Rajvi Jingar <rajvi.jingar@linux.intel.com>
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---

This change looked fine.

However, I spent considerable time in figuring out the addition of 
lpm_req_regs NULL check so it would be nice to mention it in the commit 
message that since the caller's primary_pmc->lpm_req_regs check no longer 
covers all pmcs, it has to checked within the loop. It's was far from 
obvious whether it was a bugfix accidently mixed together with this patch 
or required by this change itself but I managed to finally convince 
myself it's the latter.

With that noted down for the benefit of the next unfortunate victim who 
has to read this change from the git history, :-)

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>


-- 
 i.

--8323329-2093636943-1700748506=:1676--
