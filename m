Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED0627E80D6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:19:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345643AbjKJSS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:18:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346131AbjKJSQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:16:40 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 994EA33FBB;
        Fri, 10 Nov 2023 04:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699619852; x=1731155852;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=4aJrl9H3tD/2XBPE0fq3m+3nahnrNK455Qp8t7f/mq0=;
  b=luCR0/LsYLzAq2ChtX8/j1fXovLXb3NorV2d1CGvtiCMtsgYjrF7M5Fh
   qDjKlpO9hFJ4ImiGqav9w0cgW7YFnE65AItLBPjnX5l3KwyXwb2mtyD9j
   nDVlYszZInmqQ2aGw5dkPa5uvyUvhLj+egyBSCTH4RwNtBHHvERqyzC7C
   VJNQBaFjd13dmnXhyupyvZv4X7kVG37jOhngS8mm4WC2hNedMXHmnHnCI
   27QPZvhAiUIPEZFArWX2Ox8FHcy1dafUo/mTIW1+AHolf9GBWPf2rrTta
   +jIoyjo0s2Qvx62zfYnPEuI4qApPVy3j1iB+Crrn/DgioFVk3u1s3BzLM
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="380567010"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; 
   d="scan'208";a="380567010"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2023 04:37:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="1095181574"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; 
   d="scan'208";a="1095181574"
Received: from joudin-mobl2.ger.corp.intel.com ([10.252.38.36])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2023 04:37:29 -0800
Date:   Fri, 10 Nov 2023 14:37:23 +0200 (EET)
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
In-Reply-To: <14312000-6369-4669-bcc9-4fa2abb5a98f@app.fastmail.com>
Message-ID: <abecd774-30a4-f11b-e1f-dcae9f1cf7df@linux.intel.com>
References: <mpearson-lenovo@squebb.ca> <20231108162039.13737-1-mpearson-lenovo@squebb.ca> <8b29ab8-fef4-8a60-e6c5-447f31f144a7@linux.intel.com> <14312000-6369-4669-bcc9-4fa2abb5a98f@app.fastmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1099703632-1699619851=:1596"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1099703632-1699619851=:1596
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Thu, 9 Nov 2023, Mark Pearson wrote:
> On Thu, Nov 9, 2023, at 5:10 AM, Ilpo Järvinen wrote:
> > On Wed, 8 Nov 2023, Mark Pearson wrote:
> >
> >> Some new Thinkpads have a new improved performance mode available.
> >> Add support to make this mode usable.
> >> 
> >> To avoid having to create a new profile, just use the improved performance
> >> mode in place of the existing performance mode, when available.
> >> 
> >> Tested on T14 AMD G4 AMD.
> >> 
> >> Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> >> ---
> >>  drivers/platform/x86/thinkpad_acpi.c | 28 ++++++++++++++++++++++++++++
> >>  1 file changed, 28 insertions(+)
> >> 
> >> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
> >> index ad460417f901..eba701ab340e 100644
> >> @@ -10163,11 +10165,14 @@ static struct ibm_struct proxsensor_driver_data = {
> >>  #define DYTC_MODE_MMC_LOWPOWER 3  /* Low power mode */
> >>  #define DYTC_MODE_MMC_BALANCE  0xF  /* Default mode aka balanced */
> >>  #define DYTC_MODE_MMC_DEFAULT  0  /* Default mode from MMC_GET, aka balanced */
> >> +#define DYTC_NOMODE            0xF  /* When Function does not have a mode */
> >>  
> >>  #define DYTC_MODE_PSC_LOWPOWER 3  /* Low power mode */
> >>  #define DYTC_MODE_PSC_BALANCE  5  /* Default mode aka balanced */
> >>  #define DYTC_MODE_PSC_PERFORM  7  /* High power mode aka performance */
> >>  
> >> +#define DYTC_UP_SUPPORT_BIT    8  /* Bit 8 - 1 = supported, 0 = not */
> >
> > It would be preferrable to comment what is supported rather than have a 
> > comment like above which isn't particularly helpful.
> 
> OK - so  just have:
> #define DYTC_UP_SUPPORT_BIT    8  /* Ultra-performance (TMS) mode support */
> 
> Or...reading ahead in the review this should actually be
> #define DYTC_UP_SUPPORT_BIT    BIT(8)  /* Ultra-performance (TMS) mode support */

Yes, the latter look good except I'd just drop the "_BIT" suffix from the 
name.

> >> @@ -10484,6 +10502,16 @@ static int tpacpi_dytc_profile_init(struct ibm_init_struct *iibm)
> >>  		dbg_printk(TPACPI_DBG_INIT, "No DYTC support available\n");
> >>  		return -ENODEV;
> >>  	}
> >> +	err = dytc_command(DYTC_CMD_UP_CAP, &output);
> >> +	dytc_ultraperf_cap = output & BIT(DYTC_UP_SUPPORT_BIT) ? true : false;
> >
> > It would be better to put this BIT() into the define itself and remove 
> > _BIT from the name because it doesn't really add that much information.
> > Since you're assigning to bool, ? true : false construct is not required 
> > but implicit cast will handle it for you. So in the end, this line would 
> > be:
> >
> > 	dytc_ultraperf_cap = output & DYTC_UP_SUPPORT;
> 
> Agreed. I will make that change.
> I'll wait and see if there is any more feedback and then do that with a v2 patch.
> 
> >
> > Looking into the driver a bit more, there are a few other defines which 
> > could also move BIT() from the code into defines. Please tell if you're 
> > going to look at those because if not, I might try to make the patches.
> 
> Happy to look at doing that as I'm playing around with this driver anyway.

Okay, thanks.

-- 
 i.

--8323329-1099703632-1699619851=:1596--
