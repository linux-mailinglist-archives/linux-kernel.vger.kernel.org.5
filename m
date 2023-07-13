Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4AFC7529EC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 19:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232454AbjGMRhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 13:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbjGMRhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 13:37:53 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A50C726A5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 10:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689269872; x=1720805872;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yPE9U8xhKmLZhOG3aAehr9AkgPFEJqjH9TK28Frktps=;
  b=OknRYnSSG4SPj8FK0C6rNLcqi5Dsw5tnnrmkvg5fHztCxSfRYdzkyhRi
   e6EgntTFep+KufMFVjZiP7jm5cKnj6a0RGIjy/a+xpEzAxLxU+LmPWOXa
   v7U2jgv+aeqFfjVChyCVXT1YHqLxKwSntZFpuyEiVJf1RZ+IFYZS5Qf38
   DL0p403HkvRgJGRJpJ41E6aruR2SIAlEn6Rl0FEWOUm34/PG1EC7CB9TQ
   QT30NoQnF+97Mviv6IgErSBS/vG6FLchhZ402L1sYOgW9tad7YgEIcNQL
   oO4Y3tFHMSGqamoGl0kKDGw1TCWooS7olQfZx+KDfKbjNyaS2THoYHn5J
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="368822096"
X-IronPort-AV: E=Sophos;i="6.01,203,1684825200"; 
   d="scan'208";a="368822096"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 10:37:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="812106549"
X-IronPort-AV: E=Sophos;i="6.01,203,1684825200"; 
   d="scan'208";a="812106549"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 10:37:50 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id 0CCDB1206E6;
        Thu, 13 Jul 2023 20:37:48 +0300 (EEST)
Date:   Thu, 13 Jul 2023 17:37:48 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: drivers/media/i2c/tc358746.c:817:13: warning: 'p_best' is used
 uninitialized
Message-ID: <ZLA2bDX2hfLIaUkk@kekkonen.localdomain>
References: <202307080250.28r3inuE-lkp@intel.com>
 <20230710063850.o2n5yymuzdhyfqb4@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710063850.o2n5yymuzdhyfqb4@pengutronix.de>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 08:38:50AM +0200, Marco Felsch wrote:
> Hi Sakari,
> 
> On 23-07-08, kernel test robot wrote:
> > Hi Marco,
> > 
> > FYI, the error/warning still remains.
> 
> @Sakari
> 
> I thought your patch fixing flase-positive was applied?

It's in Mauro's fixes branch now:
<URL:https://git.linuxtv.org/media_tree.git/log/?h=fixes>.

-- 
Sakari Ailus
