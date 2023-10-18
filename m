Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 755927CD963
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 12:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbjJRKig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 06:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjJRKie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 06:38:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35BABBA
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 03:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697625513; x=1729161513;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qLHbWCmacxKJ8ooul8n81Sg2BO9OMG+tTZkTP0mZUGc=;
  b=ThfqWDvXzRAAT36b7awQiDhx9YU/ATwPfB30dut883ZoIsC8x9ySAR8P
   tdCT2p+YIH0peGEg9xZxVh1VxTO5OXlimEWCS+KUIzhxUsJKZQOMM571+
   P7CnT76mrkAJr9ZvtisQBnzqPH6iSgl3soeMJ9ypHWlEz1CVBoLqsy/6k
   Ha9RgBYqi6HxtH8iTnDr+HaX72dcNPqMEYLgG6YVWOrEfsWZ1THWZfUbe
   Cubu4oo2egsihtsS33l27WVRQeYnFv4pZQ9Ts7Ft9zdiX4Z+QN4GZ+yA2
   M7SJNlrs9LnOy+30LnqDyMzPu8RgTLwm0k3cbD/dIKh4WurOaSVZMtPxT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="472211346"
X-IronPort-AV: E=Sophos;i="6.03,234,1694761200"; 
   d="scan'208";a="472211346"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 03:38:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="785882037"
X-IronPort-AV: E=Sophos;i="6.03,234,1694761200"; 
   d="scan'208";a="785882037"
Received: from nurfahan-mobl3.gar.corp.intel.com (HELO intel.com) ([10.213.159.217])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 03:38:26 -0700
Date:   Wed, 18 Oct 2023 12:38:18 +0200
From:   Andi Shyti <andi.shyti@linux.intel.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     kenechukwu maduechesi <maduechesik@gmail.com>,
        outreachy@lists.linux.dev, shreeya.patel23498@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rts5208: Replace delay function.
Message-ID: <ZS+1mpOYTKRaABR1@ashyti-mobl2.lan>
References: <20231018004300.GA3189@ubuntu>
 <7bc719c4-459f-3d8-7ed-b1e1adf158@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7bc719c4-459f-3d8-7ed-b1e1adf158@inria.fr>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Julia,

> > Replace udelay() with usleep_range() for more precise delay handling.
> >
> > Reported by checkpatch:
> >
> > CHECK: usleep_range is preferred over udelay
> 
> This message is typically not a good candidate for outreachy patches,
> because you need access to the device to be sure that any change is
> correct.

I actually don't really mind this patch... I would exchange these
udelay() with almost anything, they look to me placed a bit
random anyway (without going too much in detail).

But in general, for this project, I think you are right and it's
a good idea not to blindly change delay and sleeping functions
without really knowing what you are doing.

Andi
