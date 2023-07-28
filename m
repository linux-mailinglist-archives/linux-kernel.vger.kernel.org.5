Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78AF57669BD
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 12:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234996AbjG1KDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 06:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235613AbjG1KCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 06:02:48 -0400
Received: from mgamail.intel.com (unknown [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A70F93C07;
        Fri, 28 Jul 2023 03:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690538559; x=1722074559;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=YzZuAZZZIjFoo83EUPCtvSsd8Mis2DtPCekd+t0N+Oo=;
  b=J4C+AwqwgHnYBbxhDQoIc8ZecKWvlkxBLlF1VJ785i851+VVuXmb+O2D
   ee0Fk/RxNHVmPgcRi2zVEWKkf+OTaAoOJr+OwJm7YjwLNwYPdi7WTG1pT
   g+Eu9oqq1TKFMJB2wFLPL3Hce2vWfhdCiTZ3MQCIoslayge9+IwLWIIPG
   fgtz0OlroZD1g0tVTx8N+11Mb8a67gfxSy7mk70MnBdHM+LCXQ+TtKR3S
   vyLvNCOCFzce0hcIoTTjTfHf4JaP5APHHhtdsHkXbdVLVI14TQ36lZdRC
   l+2rhjMj/26SWhlafliKDaeHzf0wH4k0h/9ieGmWQakkPfcbXKKss9aBF
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="371257124"
X-IronPort-AV: E=Sophos;i="6.01,237,1684825200"; 
   d="scan'208";a="371257124"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 03:02:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="762571977"
X-IronPort-AV: E=Sophos;i="6.01,237,1684825200"; 
   d="scan'208";a="762571977"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 28 Jul 2023 03:02:37 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qPKIt-00CcyQ-22;
        Fri, 28 Jul 2023 13:02:35 +0300
Date:   Fri, 28 Jul 2023 13:02:35 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        Mark Gross <markgross@kernel.org>, Armin Wolf <W_Armin@gmx.de>
Subject: Re: [RFC PATCH v1] platform/x86: wmi: Do not register driver with
 invalid GUID
Message-ID: <ZMOSO5HgpurayDsN@smile.fi.intel.com>
References: <20230715211604.1272227-1-pobrn@protonmail.com>
 <efe4b91f-2602-2115-738e-bb99b42ec5b6@redhat.com>
 <pjVZC4te3dWaMwoS7jB1-n4z390Ohz0mvuCCUZHwiXlZVMjzwySf_DMa49RDmbhzfvkzRY3FI8zQ0xltNimu-GpBAqJ2Kc3SENu_fwJDJ7E=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <pjVZC4te3dWaMwoS7jB1-n4z390Ohz0mvuCCUZHwiXlZVMjzwySf_DMa49RDmbhzfvkzRY3FI8zQ0xltNimu-GpBAqJ2Kc3SENu_fwJDJ7E=@protonmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 10:54:26PM +0000, Barnabás Pőcze wrote:
> 2023. július 26., szerda 10:45 keltezéssel, Hans de Goede <hdegoede@redhat.com> írta:
> > On 7/15/23 23:24, Barnabás Pőcze wrote:

...

> > I think that having an additional check like the one which you
> > propose has some value too, even if it is just to cover drivers
> > which for some reason don't use `MODULE_DEVICE_TABLE()`, but IMHO
> > the most important check to have is a check in file2alias.c .
> 
> Okay... any tips on how to avoid copying `uuid_is_valid()`?

I think I already told the rough design: we need to split uuid.c to three
files: libuuid.h, libuuid.c uuid.c and libuuid.c should be built twice:
once for uuid.c and once for file2alias.c. libuuid.h should contain the
definitions file2alias.c is using.  Something like that.

> Another idea I had was that maybe `struct wmi_device_id::guid_string` needs to be
> changed to be `guid_t` and then `GUID_INIT()` or something similar could be used
> to initialize it. That way it is impossible to mess up the format. The only downside
> I can see is that guid is no longer "grep-able".

Strictly speaking you may not do that because it's a (semi-)ABI.

-- 
With Best Regards,
Andy Shevchenko


