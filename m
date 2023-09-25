Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80E187AD7DC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 14:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbjIYMTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 08:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231395AbjIYMTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 08:19:09 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51BDD11D;
        Mon, 25 Sep 2023 05:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695644342; x=1727180342;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=apuZ6KIw6/15l+S9Oovo3skg9jLDHcGg6Hd8Ts4y2co=;
  b=f3bWwCjGPi+VS/sIOXmxXihxsAS3oVbznC1tmR9/vmQwW5U8m6AbEJO6
   Oia9kMBK0lfEuGu9cRXUU0aeJdYiTUfRSj5PzqnAm9Zy7mhTNlsIqwVZn
   o1oAxINhUJ5A0ir59KwFfN1gB1bwZO/V88G+6IN9S61H1Z3GydJlvt4eE
   XA6nGtgAihShkmMI/uPbbwMrOE7SIfhrPaL0AQ2WjrwFDz150OwivS4eE
   Gx5hcbtmHa9XfRW5rFrxU6vhUntHfBHl6NoUZOkL4E5YHnYksaFN0YoVU
   ltH2PTqe9VRjShGHjTtbFJ0OciJvdrA7QNd84yry2wCii6MIdp/rxZzKT
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="383996204"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="383996204"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 05:19:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="748329392"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="748329392"
Received: from stamengx-mobl1.ger.corp.intel.com ([10.249.32.149])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 05:18:58 -0700
Date:   Mon, 25 Sep 2023 15:18:56 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "Fernando Eckhardt Valle (FIPT)" <fevalle@ipt.br>
cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Pearson <mpearson-lenovo@squebb.ca>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "hmh@hmh.eng.br" <hmh@hmh.eng.br>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "ibm-acpi-devel@lists.sourceforge.net" 
        <ibm-acpi-devel@lists.sourceforge.net>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
Subject: Re: [PATCH v4] platform/x86: thinkpad_acpi: sysfs interface to
 auxmac
In-Reply-To: <CPVP152MB50535F32391251E1AF02FA00D8FFA@CPVP152MB5053.LAMP152.PROD.OUTLOOK.COM>
Message-ID: <cc894b7-8513-cd0-f59d-7647541da92@linux.intel.com>
References: <20230921143622.72387-1-fevalle@ipt.br> <946285e6-6064-4084-a1a7-f5ba7dea3e7d@linux.intel.com> <CPVP152MB50535F32391251E1AF02FA00D8FFA@CPVP152MB5053.LAMP152.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Sep 2023, Fernando Eckhardt Valle (FIPT) wrote:

> Thanks for the feedback again!
> 
> > Okay, I wasn't expecting this change as this relies on the nul termination
> > by strscpy() since the original buffer does not have one but the #
> > character there. But I guess it isn't harmful either.
> Yes, precisely because strscpy() put the 'nul terminator' I thought it 
> would be ok. In the tests I did, everything always worked fine too.

It was a bit unorthodox way to take advantage of the way strscpy() works
but like I said, doesn't look harmful.

> >  AUXMAC_START is an offset ??? It should be AUXMAC_LEN.
>
> I thought that since the string 'disabled' has length 8, then I would 
> use AUXMAC_START which is defined as 9 , because that way strscpy would 
> copy the 8 characters of 'disabled' + the nul terminator. Wouldn't that 
> be correct? Or would it be better to use AUXMAC_LEN which is defined to 
> 12? 

strscpy() is takes the size of the destination:

 * @size: Size of destination buffer

...so please use AUXMAC_LEN.

In anycase, "disabled" as the source is itself nul-terminated so strscpy() 
won't copy beyond its length.


-- 
 i.

