Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F36637FD547
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 12:15:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbjK2LPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 06:15:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232705AbjK2LOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 06:14:31 -0500
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 29 Nov 2023 03:12:52 PST
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D282113;
        Wed, 29 Nov 2023 03:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701256373; x=1732792373;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=mH0FS1PLtuPl2wqA0IuYz8tUlWqy6R9bNKMXpWxQdbg=;
  b=TisVpBget2nvD0BtphitsUgNhKnTdaeA6iGV11VTTP9VpvOZWJ96Cqix
   FzW9l0BRp5ISoZa2wz4/AyCUnTlSEjjTMCPbX/fi5tnMbqOyDbuoPWEaT
   SVTpIoVdXvQmXhkvcfJHbtpgPhmriYrbriVzqsAk07CL7O5KpeLmM5Ww2
   b7Q9YSGeCXRbdtCYCvfDVWcgwQTUBMXbDwNualOo+MeU9wP9K220et95D
   RTZ/m2Jt8UV+RpP5UcRVHSVhpy6ukNiLkqQYohrPuLjFoWGw6gy8hHm6v
   M4XLtcSylbcafTApy/BIXVu4gJd4TOx8bUfinAaI79JewJMGW/FVVerfa
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="133836"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="133836"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 03:11:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="17172215"
Received: from akuporos-mobl.ger.corp.intel.com ([10.251.221.122])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 03:11:47 -0800
Date:   Wed, 29 Nov 2023 13:11:44 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
cc:     linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        =?ISO-8859-15?Q?Maciej_Wiecz=F3r-Retman?= 
        <maciej.wieczor-retman@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 26/26] selftests/resctrl: Add test groups and name L3
 CAT test L3_CAT
In-Reply-To: <2787018d-9661-4169-9571-a4016691cfa6@intel.com>
Message-ID: <ca49fc8f-f9f7-138f-ff2f-60f754525df7@linux.intel.com>
References: <20231120111340.7805-1-ilpo.jarvinen@linux.intel.com> <20231120111340.7805-27-ilpo.jarvinen@linux.intel.com> <2787018d-9661-4169-9571-a4016691cfa6@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1781121945-1701256309=:1861"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1781121945-1701256309=:1861
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 28 Nov 2023, Reinette Chatre wrote:
> On 11/20/2023 3:13 AM, Ilpo Järvinen wrote:
> > To select test to run -t parameter can be used. However, -t cat
> > currently maps to L3 CAT test which is confusing after more CAT related
> > tests are added.
> > 
> > Allow selecting tests as groups and call L3 CAT test "L3_CAT", "CAT"
> > group will enable all CAT related tests.
> > 
> > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > ---
> 
> Could you please defer this patch to accompany the series that
> introduces other CAT related tests?

Can be done but it implies Maciej non-continuous CAT test series would 
still be blocked by the lack of this feature which is why I included it 
here.

But perhaps Maciej wants to take this patch and submit it as a part of his 
series. Maciej, are you okay with that change of patch ownership?


-- 
 i.

--8323329-1781121945-1701256309=:1861--
