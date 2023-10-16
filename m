Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7947CB543
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 23:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232345AbjJPV2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 17:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjJPV2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 17:28:12 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4075EA2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 14:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697491691; x=1729027691;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YuEvxvbRQHuoGsy33W3UvZxxg9UVkl9Dv986sm//sCM=;
  b=LHAbKV6QJI2Bw3Tyr8a4Zu0z0d3yewn31TFdXDOG9iHPc3j5ocBCLR6T
   cLKwu5X+UZboQPXxJuCRgI/XKuZ22VvvaXxoA/nZEvgKJpN7YHsg4B+Ao
   HzIKf3lqRE7niQIIBswlrc2WvOxvlgOhU8/1RaU0BkfJ/xWwlomjpgPkv
   s0TQmCNuTCnCSs/K9MSRzbLe7Y3RA986k7w3EwXq1jZ+mvnbZWfpT/2P5
   EICYJnqNZ1dubaOd6GeGmPJ4g+JyPwvBFxnTjp5s3w94DbNbN4MIfnJbV
   VU6XERoychwdQ67NfO8DRRw+iA+RUEyuKALhnwN2N3/UmeGSsLXKJ90Tw
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="449865295"
X-IronPort-AV: E=Sophos;i="6.03,230,1694761200"; 
   d="scan'208";a="449865295"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 14:27:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,230,1694761200"; 
   d="scan'208";a="3797840"
Received: from yckhoo-mobl2.gar.corp.intel.com (HELO intel.com) ([10.215.157.119])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 14:27:16 -0700
Date:   Mon, 16 Oct 2023 23:27:03 +0200
From:   Andi Shyti <andi.shyti@linux.intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Gilbert Adikankwu <gilbertadikankwu@gmail.com>,
        outreachy@lists.linux.dev, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: emxx_udc: Remove unnecessary parentheses around
 condition tests
Message-ID: <ZS2qpwnfCxsbvOld@ashyti-mobl2.lan>
References: <ZS0f+xaaLmLpKv2a@gilbert-PC>
 <2023101658-unmoral-survival-25cf@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023101658-unmoral-survival-25cf@gregkh>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Fix 47 warnings detected by checkpatch.pl about unnecessary parenthesis
> > around condition tests.
> 
> And as I have stated numerous times in the past, they are not
> "unnecessary" at all, and provide a valuable hint to the developer as to
> what is the ordering involved.
> 
> So you can ignore this checkpatch warning please, it's not valid as far
> as I'm concerned for the subsystems that I maintain in the kernel.

I find this very confusing, though:

   if (((ep->epnum == 0) || (data & (1 << ep->epnum)) == 0))

Andi
