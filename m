Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 607F17CD5AC
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 09:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344559AbjJRHvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 03:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjJRHu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 03:50:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C4FF7
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 00:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697615457; x=1729151457;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2e6ywZDG7rC0YaI4mpzW/6wyogmKCONIADxJWPjr35g=;
  b=Ris7k8cvI8G3zzK1+0qkYLVfaaNPC/9aqvZSECaUCxpqHS8ovvvUsWFF
   3daVKnVVA6JHBmPpZmJzG3CtpYY3zrxQ+j3VUuUC+O52XVGWoO4Lp/iHM
   o6IOzP2yUyBH6t/d0DUHc/TPSKm4WQrGLQb7VBjPw2Ewd2lGxU9FJazwp
   Hdyd2X+tegLj5grfGDBPcyNpRp6B58XAy6JUzelYXzbfL0PiUo1zwXkws
   j0BY2ZHn1Lqh56PQYVYNiAQR3pI8NwG6aaylThPSfLdTJa6tWeQc8SyTD
   e3o21H7vnQ3tfjDnpJdh4VeY4tfCxXmnPdA2CeQgJGRXQhZPeplBiOj0W
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="365312994"
X-IronPort-AV: E=Sophos;i="6.03,234,1694761200"; 
   d="scan'208";a="365312994"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 00:50:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="760124176"
X-IronPort-AV: E=Sophos;i="6.03,234,1694761200"; 
   d="scan'208";a="760124176"
Received: from joe-255.igk.intel.com (HELO localhost) ([10.91.220.57])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 00:50:54 -0700
Date:   Wed, 18 Oct 2023 09:50:53 +0200
From:   Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
To:     Deepak R Varma <drv@mailo.com>
Cc:     Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Oded Gabbay <ogabbay@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: ivpu TODO list items
Message-ID: <20231018075053.GB525429@linux.intel.com>
References: <ZSjwuyCOL9Vb9+yb@runicha.com>
 <ZS68dysac34rA32D@runicha.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZS68dysac34rA32D@runicha.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Tue, Oct 17, 2023 at 10:25:19PM +0530, Deepak R Varma wrote:
> On Fri, Oct 13, 2023 at 12:54:43PM +0530, Deepak R Varma wrote:
> > Hello,
> > I am shortlisted as a mentee for the LF Mentorship program. I looked at the TODO
> > file for the ivpu driver for my project tasks. Could you please answer the
> > following questions:
> >
> > 1. Is the TODO list up to date? If not, can we have it updated? Let me know if I
> > can help.
It's not. Some of those was already implemented (but yet not submitted).
Some ideas there was dropped. 

I think this file can be whole removed. Feel free to post patch for
that.

> > 2. Is it absolutely necessary for me to have a specialized hardware to test my
> > patches? Is it limited to the 14thGen or above CPU or do I need more than that?
Yes, I don't think someone can work on ivpu without hardware.

> > 3. Is it okay for me to work on the TODO list items. Let me know if you have a
> > preference [Please note I just started a few months ago and still learning].
I recommend you to work on items from:
https://www.kernel.org/doc/html/latest/gpu/todo.html

> Hello,
> May I request the maintainer to review my questions and comment please?

Sorry, I haven't seen this email before.

Regards
Stanislaw
