Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA1A87D040F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 23:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345256AbjJSVcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 17:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbjJSVcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 17:32:21 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E8F93
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 14:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697751140; x=1729287140;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cw5t3VXt7tUZOXYsPRrDLRYcGpbLTXZ9huugpFgVVdo=;
  b=S5tk2/F/nh2Set71ZKZOWU4D2DwKz60DiX5gpgxGBCaruI8nVzPm5gV1
   6KtB6p9mYkBLriFKTr/Y8D7TcUPU9txR/GH7T0M24Z3PHk0r77ZJ7c8Hb
   14hAK53DAIHSCZhJqtvL/R5Ikt54NnHw9EJtkFHAdKVkywX/VxjeSeim3
   JofTF1u59F1x8ypJk7OoUXCDJANcief6UENbz02cB4FUCdk4ebaZmfQuJ
   AoW99bVewz6eCWLu/U4dhaS31gaLI3cAKdL2axC2HdeR9GkFyZG8TyC0j
   L4A+fXJ6HEsa2XMirJyeLAniOQ/p6KkjJ6r6GZ/5EN4n31Ljmu+8YPDYo
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="390258002"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="390258002"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 14:32:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="707002209"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="707002209"
Received: from xuanyaoo-mobl.gar.corp.intel.com (HELO intel.com) ([10.214.165.172])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 14:32:13 -0700
Date:   Thu, 19 Oct 2023 23:32:04 +0200
From:   Andi Shyti <andi.shyti@linux.intel.com>
To:     Soumya Negi <soumya.negi97@gmail.com>
Cc:     Andi Shyti <andi.shyti@linux.intel.com>,
        Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Julia Lawall <julia.lawall@inria.fr>,
        outreachy@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH v2 2/2] staging: vme_user: Use __func__ instead of
 function name
Message-ID: <ZTGgVNBoxOtWOuE8@ashyti-mobl2.lan>
References: <cover.1697696951.git.soumya.negi97@gmail.com>
 <996c9f92e7fd288f67c02dfb0ba524ab7c5fe421.1697696951.git.soumya.negi97@gmail.com>
 <ZTFOGIu5U+ZUodXW@ashyti-mobl2.lan>
 <20231019191428.GA32717@Negi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019191428.GA32717@Negi>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Soumya,

> > On Thu, Oct 19, 2023 at 12:20:10AM -0700, Soumya Negi wrote:
> > > Replace function names in message strings with __func__ to fix
> > > all checkpatch warnings like:
> > > 
> > >     WARNING: Prefer using '"%s...", __func__' to using 'vme_lm_get',
> > >              this function's name, in a string
> > > 
> > > Signed-off-by: Soumya Negi <soumya.negi97@gmail.com>
> > 
> > you forgot my ack here:
> > 
> > Acked-by: Andi Shyti <andi.shyti@linux.intel.com> 
> > 
> > Andi
> 
> Sorry I forgot the tag Andi. I'll add the tags in v3(Greg has suggested
> more changes). There will be some new patches, so I'll leave the tags out in 
> those as you may want to review them first.

no problem.

I don't see reviews from Greg in this v2 series. If you are
referring to the changelog, then you don't need to resend.

Andi
