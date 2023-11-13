Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9081C7E9ECD
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 15:33:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbjKMOdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 09:33:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjKMOdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 09:33:50 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D66AD59;
        Mon, 13 Nov 2023 06:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699886027; x=1731422027;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=egHIBGt8+rNKBYGNGvooMu5FhegqZKF8DPmSf9ScxPc=;
  b=dmBQIewVHU9Yq1w94BAFI3ppLuROUWImXOYnxpssE28RWjQ6hzMdWJu3
   j+Xfa4sdOju79dBr8ZyAmbdqc9hRSRWhQ/Fn/uQVKQntcAVecLRekuUnT
   PgDklwgK3yj+EGQ1ZiUh/ucu3KJTddMZSwTY3Thl/Ts3hxZQMle9MzAzJ
   W7nFv52Cd7sQelDLqFWMqUw7kPJwBo0blPj+w30DtBW5qPhmlJP5bSkEF
   Rd3k6Nf5SkZwQIWv30XwrWUfr+Qtnc5MyJ9MaXtTIX/DIv5xzhbfTG80N
   oVJiEbG1Doo12xUAI0o62MflD/QUH+RlJoVAqjYA+r7fnp+cWb8MAM1H7
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="421544235"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="421544235"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 06:24:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="937752617"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="937752617"
Received: from alexdsou-mobl3.gar.corp.intel.com ([10.249.44.83])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 06:24:48 -0800
Date:   Mon, 13 Nov 2023 16:24:46 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Mark Pearson <mpearson-lenovo@squebb.ca>
cc:     "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        ibm-acpi-devel@lists.sourceforge.net,
        "Limonciello, Mario" <mario.limonciello@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] platform/x86: Add support for improved performance
 mode
In-Reply-To: <b3167aca-032d-4ec4-b438-38416a5d8a10@app.fastmail.com>
Message-ID: <e2b73a2a-b1ef-9dc8-9924-f1ab2b1f5fd@linux.intel.com>
References: <mpearson-lenovo@squebb.ca> <20231108162039.13737-1-mpearson-lenovo@squebb.ca> <8b29ab8-fef4-8a60-e6c5-447f31f144a7@linux.intel.com> <14312000-6369-4669-bcc9-4fa2abb5a98f@app.fastmail.com> <abecd774-30a4-f11b-e1f-dcae9f1cf7df@linux.intel.com>
 <b3167aca-032d-4ec4-b438-38416a5d8a10@app.fastmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-497537181-1699885490=:1867"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-497537181-1699885490=:1867
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Mon, 13 Nov 2023, Mark Pearson wrote:
> On Fri, Nov 10, 2023, at 7:37 AM, Ilpo Järvinen wrote:
> > On Thu, 9 Nov 2023, Mark Pearson wrote:
> >> On Thu, Nov 9, 2023, at 5:10 AM, Ilpo Järvinen wrote:
> >> > On Wed, 8 Nov 2023, Mark Pearson wrote:
> <snip>
> >> 
> >> >
> >> > Looking into the driver a bit more, there are a few other defines which 
> >> > could also move BIT() from the code into defines. Please tell if you're 
> >> > going to look at those because if not, I might try to make the patches.
> >> 
> >> Happy to look at doing that as I'm playing around with this driver anyway.
> >
> > Okay, thanks.
> >
> Just a quick note - I pushed v2 for this patch, and I'll tackle the 
> other BIT changes separately (rather than adding it as part of a 
> series). Looking through the code I wanted to spend more time on that 
> piece - I'm not ignoring it :) 

Yeah, no problem. I was expecting it separately anyway. :-)

-- 
 i.

--8323329-497537181-1699885490=:1867--
