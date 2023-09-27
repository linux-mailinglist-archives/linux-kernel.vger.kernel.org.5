Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 924447B02F0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 13:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbjI0L2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 07:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231611AbjI0L2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 07:28:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED3D4CFB;
        Wed, 27 Sep 2023 04:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695814092; x=1727350092;
  h=from:to:in-reply-to:references:subject:message-id:date:
   mime-version:content-transfer-encoding;
  bh=uFGitsElrhMRHDkmcqIiTAhrwAa+OQv1/O5WTCTxAck=;
  b=fk/AIaAWfzQ7U35eOfY1qGLU8+CVx1lX4qk5jC0fe/2/mZjGVno9V308
   N/JrNyOD6cbHuGlKlqrfuIn2qOv3/qNBRE3Et0WRm/44wUlNvsA5yTP2w
   wJyESY3yGis0T23ZXD3CkgWbtOcqbNzDsbvs0Bp0bAQEnjxoHDAhNhQbE
   uZ+e+5mPDm4SCWM5T0bl9jey6Z+2CSSnSxxU3zzifB5vk1GZSsLxfEGJZ
   awv4ccisM+McbjONWewE/ai2ry54P8gqdVHxSnScyPuAYpiLbDf0O12j3
   75qxw+EAYYWv2eFf7VKBCXbrj8Pv1OM9OdX6npPwe9louy/x0TE0ndgoH
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="468084279"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="468084279"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 04:28:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="996111025"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="996111025"
Received: from pjfarr-mobl2.ger.corp.intel.com (HELO localhost) ([10.249.32.193])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 04:26:53 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     hdegoede@redhat.com, mpearson-lenovo@squebb.ca, corbet@lwn.net,
        hmh@hmh.eng.br, markgross@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org,
        Fernando Eckhardt Valle <fevalle@ipt.br>
In-Reply-To: <20230926202144.5906-1-fevalle@ipt.br>
References: <20230926202144.5906-1-fevalle@ipt.br>
Subject: Re: [PATCH v6] platform/x86: thinkpad_acpi: sysfs interface to
 auxmac
Message-Id: <169581394434.329979.16556041128440048227.b4-ty@linux.intel.com>
Date:   Wed, 27 Sep 2023 14:25:44 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Sep 2023 17:21:44 -0300, Fernando Eckhardt Valle wrote:

> Newer Thinkpads have a feature called MAC Address Pass-through.
> This patch provides a sysfs interface that userspace can use
> to get this auxiliary mac address.
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
[1/1] platform/x86: thinkpad_acpi: sysfs interface to auxmac
      commit: e17b4df0af1c21b767067b42c227d24d61b3ad15

--
 i.

