Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C437C7F5E38
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 12:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345127AbjKWLvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 06:51:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345105AbjKWLvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 06:51:14 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3C12101;
        Thu, 23 Nov 2023 03:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700740281; x=1732276281;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=c3bcXnDOVlFpX+Ph2RovZJ6+TK7ouwTaIB2jo3XHN/U=;
  b=n+PF/yawXEWT6jfPikm7QikRKdmiJUTzP+E1xzGNLfgsq1HKSX+qoS2G
   8YzZxnVNiEmRx6P5utIjr0qSuZS1QBnWI0RNCSx2+NRQ2W3VQ3oJWMf9P
   C+RBbiy0q+xp+xI6wNaCoVP2trxhzXXEVdjErveX1cAsBigHikB2wAGtv
   UCB958D7sCMT0gQfl/p/ytEV3sCokp+6OE04IOFckHp+Q9dcvITgxFM2H
   06ZdztVbjPBarvJJUDp9/qw5LvH9kLfK1WtQiUXMECNcOpiheMjwfj/30
   5aArmYUZ3xBru4lN6Oj8u8f/HGtuFJTZ6y1wboQDUYs2pCFsAczTQddQ1
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="10929854"
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="scan'208";a="10929854"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 03:51:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="scan'208";a="15632384"
Received: from mstrobel-mobl.ger.corp.intel.com ([10.252.40.70])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 03:51:18 -0800
Date:   Thu, 23 Nov 2023 13:51:15 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     SungHwan Jung <onenowy@gmail.com>
cc:     lkp@intel.com, Hans de Goede <hdegoede@redhat.com>,
        jdelvare@suse.com, jlee@suse.com, linux-hwmon@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, linux@roeck-us.net,
        oe-kbuild-all@lists.linux.dev, platform-driver-x86@vger.kernel.org
Subject: Re: Re: [PATCH v2 2/2] platform/x86: acer-wmi: add fan speed monitoring
 for Predator PHN16-71
In-Reply-To: <20231123055323.417287-1-onenowy@gmail.com>
Message-ID: <24bf6134-4111-87bc-1e4d-a84b2fb67443@linux.intel.com>
References: <202311230750.psygl1ot-lkp@intel.com> <20231123055323.417287-1-onenowy@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Nov 2023, SungHwan Jung wrote:

> It is caused by dependency on hwmon. Setting both hwmon and acer-wmi as
> module (or in-kernel) in config fixes this error.

Then you should add
	depends on HWMON
into the Kconfig in the next version of this patch.

-- 
 i.

