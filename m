Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 727557FBA93
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 13:55:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344761AbjK1Myv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 07:54:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344757AbjK1Myt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 07:54:49 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0642A10D8;
        Tue, 28 Nov 2023 04:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701176096; x=1732712096;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=dVu4q/x1civBTJPwWNdWPRxz+AZouCiyXKEZvCfSL7A=;
  b=b0yuf6ygaLe+2qq4qfP2Yw6KCWtZ9pZyHu5EvPYJTt4wJiV8fljZgzoU
   lt0oi1nTpPtkIxQO3GNDicmfL57hwVTErGlFPhniErPzInWDQwWokeXFd
   7rf9UW+AhDg0VoU0BeC6d7oJwQzVXPmJ4MrDjAHWR+7GE0ag8JiyFwIKB
   M5qv4NYE/x7GrgxTzt0Q+fSYIbaDjtCkYzC6gnGcCBqJxd8xIvobSTcVZ
   /dePggJQQnSVna6R37JCYzP3QaFBiLCDwf3XsI5BGeiZl5FXZedIS0gNL
   N5OL9sW0qeURP1lTata7rnqeA45u0OVzUHM80Qqm+9Gi0LN3NpYqD9QfI
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="6116070"
X-IronPort-AV: E=Sophos;i="6.04,233,1695711600"; 
   d="scan'208";a="6116070"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 04:54:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="892073899"
X-IronPort-AV: E=Sophos;i="6.04,233,1695711600"; 
   d="scan'208";a="892073899"
Received: from haslam-mobl1.ger.corp.intel.com ([10.252.43.79])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 04:54:50 -0800
Date:   Tue, 28 Nov 2023 14:54:48 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Henry Shi <henryshi2018@gmail.com>
cc:     hbshi69@hotmail.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, Hans de Goede <hdegoede@redhat.com>,
        markgross@kernel.org, jdelvare@suse.com, linux@roeck-us.net,
        LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org,
        hb_shi2003@yahoo.com, henrys@silicom-usa.com, wenw@silicom-usa.com,
        =?ISO-8859-2?Q?Barnab=E1s_P=F5cze?= <pobrn@protonmail.com>
Subject: Re: [PATCH v15] platform/x86: Add Silicom Platform Driver
In-Reply-To: <20231124200334.5318-1-henryshi2018@gmail.com>
Message-ID: <b9e2321c-7dfb-d2d5-6cb-e3fa1ded1422@linux.intel.com>
References: <20231124200334.5318-1-henryshi2018@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1963003203-1701175569=:1797"
Content-ID: <e8e7589-3b28-421d-5a5e-9b5531705bfc@linux.intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1963003203-1701175569=:1797
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <53551940-6a3b-3470-c377-42fbfd0fa7@linux.intel.com>

On Fri, 24 Nov 2023, Henry Shi wrote:

> platform/x86: Add Silicom Platform Driver
> 
> Add Silicom platform (silicom-platform) Linux driver for Swisscom
> Business Box (Swisscom BB) as well as Cordoba family products.
> 
> This platform driver provides support for various functions via
> the Linux LED framework, GPIO framework, Hardware Monitoring (HWMON)
> and device attributes.
> 
> Signed-off-by: Henry Shi <henryshi2018@gmail.com>

As far as I'm concerned, this seems to be okay shape now:

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

It would be good for somebody to check if the devicename part of the led 
.name is correct (as I cannot even myself figure out what exactly is 
expected there).


-- 
 i.
--8323329-1963003203-1701175569=:1797--
