Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9249E7C9865
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 10:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233502AbjJOIjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 04:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232994AbjJOIjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 04:39:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48F2FC5
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 01:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697359158; x=1728895158;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CAca8yqES/vwF/dRn76EQ04yWk+MHXJZqlcatewvia4=;
  b=D162EwAZVluS5mMGAIFshVRwRlq0PPF1N4SRX85ZOYw6zV8h5dLPb0ZS
   Cq3Xtjy7ny9BpV+qHWWsROmyt5Fdd7Man6YxQs5phtDpYLp1rzdW3THcf
   wjyCfWwmEaAbyGS/3t9l1Kq7H5sSesP6sVuEuRo6s/bRRgaNe6vfxnToJ
   w9IqlP1WD0xhh0yaDYMLsZnH/M1uzNMhc20DBVUYPg6Gp8qGje0WlbtZT
   CPuBxFci9l7lVSxIjuxkws/CFJ6+qdRSosIGB3VvaCnUYMbJkW0TB9YA7
   l4KPhe2EKmRQMIcgEhAwVEJIPaVTfCzgu7PHVqRiaSJxjJ7osYRueT51f
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="385212785"
X-IronPort-AV: E=Sophos;i="6.03,226,1694761200"; 
   d="scan'208";a="385212785"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2023 01:39:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="731919556"
X-IronPort-AV: E=Sophos;i="6.03,226,1694761200"; 
   d="scan'208";a="731919556"
Received: from ingmingt-mobl1.gar.corp.intel.com (HELO intel.com) ([10.214.164.147])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2023 01:39:13 -0700
Date:   Sun, 15 Oct 2023 10:39:06 +0200
From:   Andi Shyti <andi.shyti@linux.intel.com>
To:     Gilbert Adikankwu <gilbertadikankwu@gmail.com>
Cc:     gregkh@linuxfoundation.org, outreachy@lists.linux.dev,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: rtl8192u: Align descendant arguments
Message-ID: <ZSulKrvrrLyfnzND@ashyti-mobl2.lan>
References: <ZSuhYpyYfZz5EhDB@gilbert-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSuhYpyYfZz5EhDB@gilbert-PC>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gilbert,

On Sun, Oct 15, 2023 at 09:22:58AM +0100, Gilbert Adikankwu wrote:
> Adhere to Linux kernel coding style.
> 
> "...A very commonly used style is to align descendants to a function
> open parenthesis" - (Excerpted from Linux kernel coding style (#2))
> 
> Reported by checkpatch:
> 
> CHECK: Alignment should match open parenthesis
> 
> Signed-off-by: Gilbert Adikankwu <gilbertadikankwu@gmail.com>

I don't like this commit message. Although it's correctly
written, I think it can be improved in order to be more
immediately understandable.

Write what you did in imperative form:

"Adhere to Linux kernel coding style" doesn't mean much, you can
write

  Align descendant argument to the open parenthesis as per the
  "Linux kernel coding style" in
  Documentation/process/coding-style.rst.

Yuo tell immediately what you did and where to find the
reference. Citing the document in the commit log, in this case,
looks to me like an unnecessary information.

Copy pasting the output of the error is a very good practice and
you can write it as:

  Mute the following checkpatch error:

    CHECK: Alignment should match open parenthesis

> ---
> v2: In the first patch I changed my commit title in the
> email and sent it before amending it in my git tree which then changed
> its SHA ID. I felt it might cause an issue so that is why I did a v2
> of the patch.

It's not an issue, you can do that.

But I'm going to give you another piece of advice that I already
gave in this list. Do not send patches between versions too fast.
Reviewers need some time to review... wait some time before
sending the v2, so that the v1 gets enough visibility. Sometimes
reviewers correct each other, but they need time to read the
e-mails.

This way you would also avoid unnecessary noise.

Andi
