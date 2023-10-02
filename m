Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 620087B519E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 13:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236782AbjJBLp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 07:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbjJBLp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 07:45:27 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78DDEA6;
        Mon,  2 Oct 2023 04:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696247124; x=1727783124;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=9bwHBLFRV4COs3zXIsaJKBDYTiurCzcYr4Weu9R05qE=;
  b=X1RZhYnKfakksAhjaAx+QeP+vuw2feS+8UjWRvE/WE7amG+n5AdyuhSu
   sGbtMjSc5C6WrRG4CcQCmw0A89a6m4borCAM5+ST7YGlUx77I11nMk6zH
   jdk1SeC9k86BvV3W0Mkf35rQhpsdL7nWX1a2o+kMQmhvVOhF3nthNCLIL
   u3tdfAOd8lSkJVrkL7u9EJ9j8WBJjI/hwFszJgZv7eYB4uaQ+sUIP/QKZ
   icL4yptbYvxzD6JSfUT/4wfinFH27kKTdrq9PAygC2/rrb1UwkrTp6ksP
   Qs9seGO2o0r3LCgeyp0hl4fyVto4bDOAFEAdeLJsPc1Yb75rl7NwYQE1p
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10850"; a="381508667"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="381508667"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 04:45:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10850"; a="754027255"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="754027255"
Received: from roliveir-mobl1.ger.corp.intel.com ([10.251.222.16])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 04:45:19 -0700
Date:   Mon, 2 Oct 2023 14:45:16 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jithu Joseph <jithu.joseph@intel.com>
cc:     Hans de Goede <hdegoede@redhat.com>, markgross@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        rostedt@goodmis.org, ashok.raj@intel.com, tony.luck@intel.com,
        LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org, patches@lists.linux.dev,
        ravi.v.shankar@intel.com, pengfei.xu@intel.com
Subject: Re: [PATCH v3 4/9] platform/x86/intel/ifs: Gen2 Scan test support
In-Reply-To: <20230929202436.2850388-5-jithu.joseph@intel.com>
Message-ID: <36a8ca4-50b5-f177-d1c0-5fddaac5041@linux.intel.com>
References: <20230922232606.1928026-1-jithu.joseph@intel.com> <20230929202436.2850388-1-jithu.joseph@intel.com> <20230929202436.2850388-5-jithu.joseph@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1504648656-1696247123=:2459"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1504648656-1696247123=:2459
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Fri, 29 Sep 2023, Jithu Joseph wrote:

> Width of chunk related bitfields is ACTIVATE_SCAN and SCAN_STATUS MSRs
> are different in newer IFS generation compared to gen0.
> 
> Make changes to scan test flow such that MSRs are populated
> appropriately based on the generation supported by hardware.
> 
> Account for the 8/16 bit MSR bitfield width differences between gen0 and
> newer generations for the scan test trace event too.
> 
> Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Tested-by: Pengfei Xu <pengfei.xu@intel.com>

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>


-- 
 i.

--8323329-1504648656-1696247123=:2459--
