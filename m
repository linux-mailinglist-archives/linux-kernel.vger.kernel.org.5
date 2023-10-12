Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97CB47C7021
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 16:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343929AbjJLOMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 10:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234008AbjJLOMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 10:12:33 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A7F7B7;
        Thu, 12 Oct 2023 07:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697119952; x=1728655952;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=Up5cYfavqLKRXxPm/TxO87Jjez9cVRJpervZ2yVh8tU=;
  b=Nl7oEHdVysWbkRwhmlJp/t8AQ5j1wghc7BR5WvuzNL/CsQt1v9KiQTGz
   CdR7d5h6IixUq4g9jH3bTCGnxG/GDNojne88pZBLuV1a6dKuY7hQFmdjY
   3A/UsT4uCNLdL8LCIOETooDCfd9YLJtKo/5pseK6BNMywRMJHP5ER4gcS
   44OxN1uP4yE/2TkuV/jPIUs9psDJgqkQiAZDZuCfMs9hkMFCH2/ZQ7Y3d
   o6vQunf+zDL678bg82CTrfCvsBH2Qla1e3lauEYLkRMX5nzuCENJoAm1U
   AX2k5xYnEmKxU5ADhMDBMSIdmvEn/AR5NwY4YFGTLalxe2c9u1+NKrQBx
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="365198375"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="365198375"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 07:12:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="1001555047"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="1001555047"
Received: from nesterov-mobl.ger.corp.intel.com (HELO localhost) ([10.249.36.132])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 07:12:29 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mark Gross <markgross@kernel.org>
In-Reply-To: <20231010133936.3891996-1-andriy.shevchenko@linux.intel.com>
References: <20231010133936.3891996-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v4 1/1] platform/x86: xo15-ebook: Replace open coded
 acpi_match_acpi_device()
Message-Id: <169711994332.7227.17924543281934961417.b4-ty@linux.intel.com>
Date:   Thu, 12 Oct 2023 17:12:23 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Oct 2023 16:39:36 +0300, Andy Shevchenko wrote:

> Replace open coded acpi_match_acpi_device() in ebook_switch_add().
> 
> Note, while it is a bit longer it is more robust in case
> more IDs will be added.
> 
> 


Thank you for your contribution, it has been applied to my local
review-ilpo branch. Note it will show up in the public
platform-drivers-x86/review-ilpo branch only once I've pushed my
local branch there, which might take a while.

Once I've run some tests on the review-ilpo branch the patches
there will be added to the platform-drivers-x86/for-next branch
and eventually will be included in the pdx86 pull-request to
Linus for the next merge-window.

The list of commits applied:
[1/1] platform/x86: xo15-ebook: Replace open coded acpi_match_acpi_device()
      commit: 39789590cff4043d81774d03777dabf7ba263176

--
 i.

