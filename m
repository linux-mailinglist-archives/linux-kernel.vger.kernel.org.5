Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 192C778273D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 12:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234794AbjHUKkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 06:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbjHUKkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 06:40:20 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C409D9;
        Mon, 21 Aug 2023 03:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692614419; x=1724150419;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=T3pqH57YeRysEQczHrN7LymfQeIVRRCVLyFCg4RwBgM=;
  b=fp7y7dUpU631MgHWai5Y3qyxWrhVFuyIMW4ivjBiijk0jGFmdR29MJOQ
   aMmY66q+0O5weOW+Hvrj3BNJceasxPABG2+gPqGisOC/bBunjhdnnmlxF
   oUJu/uAy935gaFThedr/WcXjSUvEcU/Ub7SEyKmtSUR+4yzIubZRNMQo8
   KnCnXrnS1Xc1chQazAEi19bo0NR7xRNoBUG0YD+3I0+82ioJy1nG1JgRh
   DoqWuZcMfoPCu8ElA3iv5xQv1fmrxP6MThTzEQzItylCD06YxBAW44o0Z
   yct3+oNmxym4sWsVjKM2Yb0VKAbfXHm3Z3bf77Q6CyOknkDvWKg/WkpyT
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10808"; a="370987904"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="370987904"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 03:40:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10808"; a="729380551"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="729380551"
Received: from nsnaveen-mobl.gar.corp.intel.com ([10.252.54.252])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 03:39:57 -0700
Date:   Mon, 21 Aug 2023 13:39:55 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Huibin Shi <henrys@silicom-usa.com>
cc:     Henry Shi <henryshi2018@gmail.com>,
        "hbshi69@hotmail.com" <hbshi69@hotmail.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "hb_shi2003@yahoo.com" <hb_shi2003@yahoo.com>,
        Wen Wang <wenw@silicom-usa.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] Add Silicom Platform Driver
In-Reply-To: <7f537cef-d5cd-4816-a07b-9df27954ef93@roeck-us.net>
Message-ID: <1ecd7ad-3878-c826-45a5-7123e55d8527@linux.intel.com>
References: <20230818154341.20553-1-henryshi2018@gmail.com> <8b8b0503-8f8f-4615-97ab-11d2c0e1a960@roeck-us.net> <PA4PR04MB9222910BAC2754A073A70E609A18A@PA4PR04MB9222.eurprd04.prod.outlook.com> <7f537cef-d5cd-4816-a07b-9df27954ef93@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Aug 2023, Guenter Roeck wrote:

> On Sat, Aug 19, 2023 at 02:20:32PM +0000, Huibin Shi wrote:
> > Hi Guenter,
> > 
> > Thanks for your comments. Probably, I should not resubmit patch too rushed. I will add version number to subject and change log in cover letter for next resubmission.
> > 
> > See my comments below. Please let me know whether you accept my explanation.
> > 
> > Henry
> > -----Original Message-----
> [ ... ]
> 
> > > +
> > > +static u32 temp_get(void)
> > > +{
> > > +     u32 reg;
> > > +
> > > +     mutex_lock(&mec_io_mutex);
> > > +     /* Select memory region */
> > > +     outb(IO_REG_BANK, EC_ADDR_MSB);
> > > +     outb(0xc, EC_ADDR_LSB);
> > > +     /* Get current data from the address */
> > > +     reg = inl(MEC_DATA(DEFAULT_CHAN_LO));
> > > +     mutex_unlock(&mec_io_mutex);
> > > +
> > > +     return (reg >> 16) / 10;
> > 
> > The hwmon ABI expects temperatures to be reported in milli-degrees C.
> > The above sets the maximum temperature to 65,535 / 10 = 6,553 milli-degrees or 6.553 degrees C. It is very unlikely that this is correct.
> > 
> > Again, I commented on this before.
> > 
> > Henry: this is due to an internal implementation of MIcor-controller firmware, instead of putting real temperature to the register, it put (real temperature * 10 ) to the register. So, in order to report correct temperature to user space application, the read value is divided by 10, then report to user space. 
> > 
> > Please let me know if you accept this. If not, I can change the code, but let user space application to do adjustment. 
> 
> No, I do not accept this. I do not believe that the maximum temperature
> reported by the microcontroller is 6.553 degrees C. I suspect it reports
> 10th of degrees C. In that case, the number reported should be multiplied
> by 100 to make it milli-degrees C as expected by the ABI.

...And for that multiplication, please use the constant defined in 
include/linux/units.h instead of a literal.


And please do version the patches properly, it's getting messy to track 
which version is which (if something is new or not). If you use git 
format-patch, it has an argument that can be used to add the version, no 
need to add it by hand.


-- 
 i.

