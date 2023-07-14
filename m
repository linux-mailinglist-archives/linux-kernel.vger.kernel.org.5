Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5249F75364A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 11:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235195AbjGNJTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 05:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235794AbjGNJTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 05:19:07 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0966D30D7;
        Fri, 14 Jul 2023 02:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689326346; x=1720862346;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jEIYV80vRxGiLEqENU5MqsOCGbuQYYjfCnaYxUSgig8=;
  b=FpoAP8kdVdg62+FqxjQpHaNEk1fSghl/yXeqYUQdp1rHGrjC+VRTKaiq
   j22QESRjUKjzD9rMXKzXhC2ujW4kiuQINnUJibmEUXr50qsspo58qxIlg
   OxS60KeURHqC3hOTP7Z8/hkcLqbursqZmXi1MchqWftF3oopFcQLlQttp
   JNMnWofCJsPQHDo5XSO4svvEwzMuU/+B9qUSMYvv4+gwVpCYNTRUbr844
   zAqA82rQWyVroDW4WThKOuI08PBaMyEcM+Aj3eZGwV8mScWJhenTdX0Lk
   dQNP+Jvon/IqlREv+fup+WiSmMV+JRK2hkSWDl39DnspHahbzgn8r9mau
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="365469195"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="365469195"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 02:18:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="716281813"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="716281813"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 14 Jul 2023 02:18:57 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qKEwx-002c6z-1V;
        Fri, 14 Jul 2023 12:18:55 +0300
Date:   Fri, 14 Jul 2023 12:18:55 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the sound-asoc tree
Message-ID: <ZLES/6iNcmR7H+f7@smile.fi.intel.com>
References: <20230713121627.17990c86@canb.auug.org.au>
 <ZK/ruOD4QFPQ3Q5q@smile.fi.intel.com>
 <ZK/w5LFanElxZazG@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZK/w5LFanElxZazG@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 03:41:09PM +0300, Andy Shevchenko wrote:
> On Thu, Jul 13, 2023 at 03:19:04PM +0300, Andy Shevchenko wrote:
> > On Thu, Jul 13, 2023 at 12:16:27PM +1000, Stephen Rothwell wrote:
> > > Hi all,
> > > 
> > > After merging the sound-asoc tree, today's linux-next build (htmldocs)
> > > produced this warning:
> > > 
> > > include/linux/int_log.h:1: warning: no structured comments found
> > > 
> > > Introduced by commit
> > > 
> > >   f97fa3dcb2db ("lib/math: Move dvb_math.c into lib/math/int_log.c")
> > 
> > Can you elaborate a bit, please?
> > 
> > Seems to me to be a false positive, or unveils a bug somewhere else.
> 
> Ah, now I understand. There is a header file that has descriptions but
> EXPORT_SYMBOL. We have to drop keyword export from the index.
> 
> Thank you for the report, I'll cook the patch ASAP.

The 20230713165320.14199-1-andriy.shevchenko@linux.intel.com had been sent.

-- 
With Best Regards,
Andy Shevchenko


