Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC2A76A189
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 21:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbjGaTwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 15:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjGaTwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 15:52:43 -0400
Received: from mgamail.intel.com (unknown [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E168CA0;
        Mon, 31 Jul 2023 12:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690833161; x=1722369161;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=xqmlNqtY5MAvTWtEPT/Gz6q8D0HC/50BGqD/OuVYrlU=;
  b=dgvRTABlA6fkv1WT6oPRu0+7WsO2BWeJvZHxzGatOxuJk0bTUaknXdA/
   RWgUCqsWAIcZ2z7zB2LC5o06CQvLpsvC+BLuwXsVie6Qfx7TTPb27pG6v
   Xz3XavWG4/7Z8+pJ2bAyEoo1w5zxztvlOo+RrAvW/0hxOF6p+cCHKWks5
   TiffVIcm+XSEb7jmJXGBpvx0SCR5RC1tJNgkQY6sjLOxJMk5dpzelCd2w
   P1QIuaIdgFzy424CZFYDlgC5U4fk5/BW7n+6Hb48y1HkdkYCcZOdjA68g
   2VZXfCc82W5suZJB8BxLPCGbIDHC9ja16KLMGpoQTfkm9P7FsshE/fvUX
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="368017911"
X-IronPort-AV: E=Sophos;i="6.01,245,1684825200"; 
   d="scan'208";a="368017911"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 12:52:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="793851078"
X-IronPort-AV: E=Sophos;i="6.01,245,1684825200"; 
   d="scan'208";a="793851078"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP; 31 Jul 2023 12:52:38 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qQYwX-003cO8-0K;
        Mon, 31 Jul 2023 22:52:37 +0300
Date:   Mon, 31 Jul 2023 22:52:36 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        Mark Gross <markgross@kernel.org>, Armin Wolf <W_Armin@gmx.de>
Subject: Re: [RFC PATCH v1] platform/x86: wmi: Do not register driver with
 invalid GUID
Message-ID: <ZMgRBKm85DbY+WIm@smile.fi.intel.com>
References: <20230715211604.1272227-1-pobrn@protonmail.com>
 <efe4b91f-2602-2115-738e-bb99b42ec5b6@redhat.com>
 <pjVZC4te3dWaMwoS7jB1-n4z390Ohz0mvuCCUZHwiXlZVMjzwySf_DMa49RDmbhzfvkzRY3FI8zQ0xltNimu-GpBAqJ2Kc3SENu_fwJDJ7E=@protonmail.com>
 <ZMOSO5HgpurayDsN@smile.fi.intel.com>
 <wg3zDdNbblZ43zsIf667-fzagNaEDu7WRuCUeLmIQWc68QcIsDF6nw1wCCbzy1NzmaKvXipcVt2oNJAqRvhxdzgLScwnB3KIts_OajtNROM=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <wg3zDdNbblZ43zsIf667-fzagNaEDu7WRuCUeLmIQWc68QcIsDF6nw1wCCbzy1NzmaKvXipcVt2oNJAqRvhxdzgLScwnB3KIts_OajtNROM=@protonmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2023 at 02:39:07PM +0000, Barnabás Pőcze wrote:
> 2023. július 28., péntek 12:02 keltezéssel, Andy Shevchenko <andriy.shevchenko@linux.intel.com> írta:
> > On Thu, Jul 27, 2023 at 10:54:26PM +0000, Barnabás Pőcze wrote:
> > > 2023. július 26., szerda 10:45 keltezéssel, Hans de Goede <hdegoede@redhat.com> írta:
> > > > On 7/15/23 23:24, Barnabás Pőcze wrote:

...

> > > > I think that having an additional check like the one which you
> > > > propose has some value too, even if it is just to cover drivers
> > > > which for some reason don't use `MODULE_DEVICE_TABLE()`, but IMHO
> > > > the most important check to have is a check in file2alias.c .
> > >
> > > Okay... any tips on how to avoid copying `uuid_is_valid()`?
> > 
> > I think I already told the rough design: we need to split uuid.c to three
> > files: libuuid.h, libuuid.c uuid.c and libuuid.c should be built twice:
> > once for uuid.c and once for file2alias.c. libuuid.h should contain the
> > definitions file2alias.c is using.  Something like that.
> 
> What is not clear at all to me is how includes should be handled. `uuid_is_valid()`
> uses `isxdigit()`, which is found in different header files based on whether it is
> a kernel or user space build.

It may be conditional build or some other tricks (I haven't investigated
myself, though). Alternatively libuuid.c can be included in the other
C-file.

> > > Another idea I had was that maybe `struct wmi_device_id::guid_string` needs to be
> > > changed to be `guid_t` and then `GUID_INIT()` or something similar could be used
> > > to initialize it. That way it is impossible to mess up the format. The only downside
> > > I can see is that guid is no longer "grep-able".
> > 
> > Strictly speaking you may not do that because it's a (semi-)ABI.
> 
> Why is that the case?

As a developer of that idea you should prove that it won't break any of all
possible user configurations (for example, first that comes to my mind is
multi-version modules: when kernel is not signed, but it might be not the
case, you need to research and convince us that there will be no breakage).

-- 
With Best Regards,
Andy Shevchenko


