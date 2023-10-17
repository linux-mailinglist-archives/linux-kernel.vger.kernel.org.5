Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FCB77CBF79
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 11:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234963AbjJQJcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 05:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234985AbjJQJbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 05:31:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3AE31723;
        Tue, 17 Oct 2023 02:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697534983; x=1729070983;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=HrDlH7wZqSe1SD5XnfFXghhPlHS8wMBMJ2gI9UsO5iY=;
  b=Rg/ZVi9NqGsJUviAybN/5lwaiixpjNyDxbHzPrh99dDs8YNvNMzYbbJ+
   aZE7cqUwyexxnL7vd7106AtzeiULmr49G1hAL1D8FVGj8S5oHpEkde4BT
   txfztef5bE85fOt6TsMy7/pxmFVhni3pmxggmhtB6oKIAcRi2+iNq8M8V
   gRvDJcAZ3tO22B5Yn2z3Ex93BfjAckPkPa8Jas+CKY4oRAOVa6Na7X8Ok
   RoMD3v7Mp8cDHqL0ZFFJBquQc7wK4JKJrHVlH1BH8lCtzKw9iNgLU0rjm
   SDHW3l28u2+mw/1bwle5WWwxiF1xBJiK2CEnWBEl0CBMw5jnYA7/AwJUm
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="366000798"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="366000798"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 02:29:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="759736570"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="759736570"
Received: from thaimovx-mobl2.ger.corp.intel.com (HELO localhost) ([10.251.208.112])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 02:29:40 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     jlee@suse.com, Edson Juliano Drosdeck <edson.drosdeck@gmail.com>
Cc:     hdegoede@redhat.com, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231016182910.3344-1-edson.drosdeck@gmail.com>
References: <20231016182910.3344-1-edson.drosdeck@gmail.com>
Subject: Re: [PATCH] platform/x86: acer-wmi: Remove void function return
Message-Id: <169753497472.3354.3262324634445556219.b4-ty@linux.intel.com>
Date:   Tue, 17 Oct 2023 12:29:34 +0300
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

On Mon, 16 Oct 2023 15:29:10 -0300, Edson Juliano Drosdeck wrote:

> Adhere to Linux kernel coding style.
> 
> Reported by checkpatch:
> 
> WARNING: void function return statements are not generally useful
> 
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo branch. Note it will show up in the public
platform-drivers-x86/review-ilpo branch only once I've pushed my
local branch there, which might take a while.

Once I've run some tests on the review-ilpo branch the patches
there will be added to the platform-drivers-x86/for-next branch
and eventually will be included in the pdx86 pull-request to
Linus for the next merge-window.

The list of commits applied:
[1/1] platform/x86: acer-wmi: Remove void function return
      commit: d3b614d993781afca1832bd2cbc39da64306d0ba

--
 i.

