Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAC6E80A239
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 12:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573581AbjLHLa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 06:30:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjLHLa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 06:30:57 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2EA010F7;
        Fri,  8 Dec 2023 03:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702035063; x=1733571063;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=8nNPRoOiMRUc4CWsKGUh1Mf18tvr3fF0GjgxjqrMw5E=;
  b=AY8YBlKDZNcTwhJN+dbmqPysk5T+HBe2AXWT1CFhpNBr1h1kSBVmJQQ8
   I386U2BWF7TYYj2yEEWnhkVyIk3XxsnyMunCx8MrdhgYauL/KPvyUR70e
   PRZK9E5GqtZk/sqcdqJzawAh2BrdLBnRDI/RnRTQ1lH4S91wPW/O5wNFu
   liW+dpUm/3pWn2UkL0EpWY4Fx7i5BZqwBWia2vPN1VFsG4xw0uEVyhy57
   u7kXXv/KwQeoDUfHuJtFILNIZJYotg9lXYq+boJvtwNK+2FNR6azs+G0v
   L3BIIiD1nvoV6/NgJiEbSKFCQ4adUBWpjUcWSpykkPhtrAntHd9S/6ZNt
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="480589529"
X-IronPort-AV: E=Sophos;i="6.04,260,1695711600"; 
   d="scan'208";a="480589529"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 03:31:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="772100127"
X-IronPort-AV: E=Sophos;i="6.04,260,1695711600"; 
   d="scan'208";a="772100127"
Received: from smatua-mobl.ger.corp.intel.com ([10.251.223.110])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 03:31:00 -0800
Date:   Fri, 8 Dec 2023 13:30:58 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Armin Wolf <W_Armin@gmx.de>
cc:     Hans de Goede <hdegoede@redhat.com>, corbet@lwn.net,
        Dell.Client.Kernel@dell.com, linux-doc@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/5] platform/x86: wmi: Remove debug_dump_wdg module
 param
In-Reply-To: <20231207222623.232074-2-W_Armin@gmx.de>
Message-ID: <cb38dd67-f19-dad0-ff73-a06be7945b97@linux.intel.com>
References: <20231207222623.232074-1-W_Armin@gmx.de> <20231207222623.232074-2-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1657504482-1702035062=:1875"
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

--8323329-1657504482-1702035062=:1875
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Thu, 7 Dec 2023, Armin Wolf wrote:

> The functionality of dumping WDG entries is better provided by
> userspace tools like "fwts wmi", which also does not suffer from
> garbled printk output caused by pr_cont().
> 
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-1657504482-1702035062=:1875--
