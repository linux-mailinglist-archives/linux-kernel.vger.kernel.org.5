Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73B5B7DF5BE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 16:10:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343738AbjKBPKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 11:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjKBPKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 11:10:12 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5220B136;
        Thu,  2 Nov 2023 08:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698937803; x=1730473803;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OHXfFQUZrtxpJ0p07bl7b5tBSPqCYpJ5LYV/rngT7UA=;
  b=hvKZm6mt3DN+zYBxwJziRQUKN9iDCQcIiBdjuLrQjJLup1zgpp0/jvFD
   mtYY8t4d1WGrD6i+zYCtzsUa37yFdMj2ecWR47sLiVuM44AlbKzaaVEEp
   qoRYr/jTjUt2n2xgrT1fpKDiWb/MU+Tm9qPX/0NsnKdTwvCCXEAstRhdc
   ocM2oS6y6z0oT4+vrjc+7xuBfqYkeZoLmcuLyu4KcpXcYFTGIqSh/ywuu
   QdIDcNIjkSSMoWds4cGwmc9BTqTqN7xWdigml/R7ol5F04FTawIuHdhMG
   cl6AQbPtjQcChAgtQkBVYSacAQXpO07+o0yk/1BM/XxnF2tDg6eyipzH1
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="474975213"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="474975213"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 08:10:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="851939601"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="851939601"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 08:10:00 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id B775711F929;
        Thu,  2 Nov 2023 17:09:57 +0200 (EET)
Date:   Thu, 2 Nov 2023 15:09:57 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Alexandra Diupina <adiupina@astralinux.ru>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andy@kernel.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: Re: [PATCH 1/4] Remove redundant return value check
Message-ID: <ZUO7xUuZmIVp06sw@kekkonen.localdomain>
References: <20231102141135.369-1-adiupina@astralinux.ru>
 <b2aa6ccb-0a9a-449f-1341-fd71d5c545fd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2aa6ccb-0a9a-449f-1341-fd71d5c545fd@redhat.com>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans, Alexandra,

On Thu, Nov 02, 2023 at 03:21:04PM +0100, Hans de Goede wrote:
> Hi Alexandra,
> 
> On 11/2/23 15:11, Alexandra Diupina wrote:
> > media_entity_pads_init() will not return 0 only if the
> > 2nd parameter >= MEDIA_ENTITY_MAX_PADS (512), but 1 is
> > passed, so checking the return value is redundant
> 
> Generally speaking functions which can fail should always be
> error-checked even if their invocation today happen to be
> such that they will not fail.
> 
> Either the invocation or the function itself my change
> causing it to fail in the future. Which is why we want
> to keep the error checks.
> 
> But maybe media_entity_pads_init() is special and
> does not need to be error checked.
> 
> Sakari, Laurent do you have any opinion on this ?
> 
> > Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> This feels like a false positive of the tool to me,
> but lets wait and see what Sakari or Laurent have
> to say.

I agree with Hans: this function today may not fail with the parameters
passed to it but it may happen in the future. In general it's good to check
a return value of a function that returns one: if that function is changed,
no-one will go through the callers as long as the arguments and the return
value remain the same.

-- 
Regards,

Sakari Ailus
