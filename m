Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31D0D7E9D35
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 14:32:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbjKMNcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 08:32:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbjKMNcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 08:32:01 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A6DA173F;
        Mon, 13 Nov 2023 05:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699882315; x=1731418315;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=Rm8xF28+ANlnLl+TZCO3wVUuV3CaKuPWQyQ/AtEUikQ=;
  b=CQYRCbHCx8H6oq50/3YXhfJCl6xElZcOuugY76LoPjzoDFaxkKKaj2yW
   OYEEiMCFJ57CYqiYpRyXtvpm9D8Ie58w4sEZCuF8Ju3JYvLFlTk3V/3wV
   IaHngBmlSTlgRuOeS6W30+CaDlJWliosKOOrOIDKXKwabPUfj3Tne8PjX
   I2jze3eJUcMwB2rKJwMiKNmIOJoig6y/IQpi44pGROGHZw9dcKRRvQOg+
   +RSwfZTo4SsTGgz7/FHMCjPNjCSQKH9Yo7m52xe1xADeFuBNw/Yn0pwT2
   XNaYmqpShPlAMF09/846PLefy3GulJt0nlzyn/xR/8S40YcyMn9ddDeMq
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="393296277"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="393296277"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 05:31:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="767921283"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="767921283"
Received: from alexdsou-mobl3.gar.corp.intel.com ([10.249.44.83])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 05:31:50 -0800
Date:   Mon, 13 Nov 2023 15:31:48 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
cc:     Jorge Lopez <jorge.lopez2@hp.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        =?ISO-8859-15?Q?Thomas_Wei=DFschuh?= <linux@weissschuh.net>,
        platform-driver-x86@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, dan.carpenter@linaro.org,
        kernel-janitors@vger.kernel.org, error27@gmail.com,
        vegard.nossum@oracle.com, darren.kenny@oracle.com,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2 4/4] platform/x86: hp-bioscfg: Fix error handling in
 hp_add_other_attributes()
In-Reply-To: <fb97e3ea-1bee-4d7d-a8d4-dd76107f75ef@oracle.com>
Message-ID: <1b58df2d-b444-ddb7-7533-9911d35f8f7@linux.intel.com>
References: <20231110142921.3398072-1-harshit.m.mogalapalli@oracle.com> <20231110142921.3398072-4-harshit.m.mogalapalli@oracle.com> <211e6c1e-9bfa-ac29-b6ba-e198c4f36688@linux.intel.com> <fb97e3ea-1bee-4d7d-a8d4-dd76107f75ef@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-668022575-1699881249=:1867"
Content-ID: <4bf2d21-2a7d-3d82-5c6a-36a047ed157b@linux.intel.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-668022575-1699881249=:1867
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <86264ee5-b556-95d6-45c4-305fcfb9e81b@linux.intel.com>

On Sat, 11 Nov 2023, Harshit Mogalapalli wrote:
> On 10/11/23 8:14 pm, Ilpo Järvinen wrote:
> > On Fri, 10 Nov 2023, Harshit Mogalapalli wrote:
> > 
> 
> Thanks for the review.
> 
> > This changelog needs to be rewritten, it contains multiple errors. I
> > suppose even this patch could be split into two but I'll not be too picky
> > here if you insist on fixing them in the same patch.
> > 
> 
> Any thoughts on how to split this into two patches ?
> 
> I thought of fixing memory leak in separate patch, but that would add more
> code which should be removed when we move kobject_put() to the end.

I meant that in the first patch you fix add the missing kfree(). Then in 
the second one, you correct kobject_put() + play with goto labels. There's 
no extra code that needs to be added and then removed AFAICT.

That way, you can make the commit messages more to the point too per 
patch.

> > > We have two issues:
> > > 1. Memory leak of 'attr_name_kobj' in the error handling path.
> > 
> > True, but not specific enough to be useful.
> > 
> 
> Should I mention something like:
> 
> 'attr_name_kobj' is allocated using kzalloc, but on all the error paths we
> don't free it, hence we have a memory leak.
>
> > > 2. When kobject_init_and_add() fails on every subsequent error path call
> > >     kobject_put() to cleanup.
> > 
> > This makes no sense. The only case when there old code had no issue is
> > "when kobject_init_and_add() fails" but now your wording claims it to be
> > source of problem. Please rephrase this.
> > 
> 
> Does this look better:
> 
> kobject_put() must be called to cleanup memory associated with the object if
> kobject_init_and_add() returns an error , before this patch only the error
> path which is immediately next to kobject_init_and_add() has a kobject_put()
> not any other error paths after it. Fix this by moving the kobject_put() into
> a goto label "err_other_attr_init:" and use that for error paths after
> kobject_init_and_add().

This is easier to understand I think:

kobject_put() must be always called after passing the object to 
kobject_init_and_add(). Only the error path which is immediately next
to kobject_init_and_add() calls kobject_put() and not any other error 
path after it.

Fix the error handling by moving the kobject_put() into the goto label 
err_other_attr_init that is already used by all the error paths after
kobject_init_and_add().

> > > Both of these issues will be fixed when we add kobject_put() in the goto
> > > label, as kfree() is already part of kobject_put().
> > 
> > No, you're fixing a problem in the patch which is not covered by moving
> > kobject_put()!
>
> Sure, I will try to rephrase it to:
> 
> 1. Add a new label "unlock_drv_mutex"
> 2. Add a kfree() in the default statement of switch before going to
> "unlock_drv_mutex" to free up the memory allocated with kzalloc.
> 2. Move kobject_put() to goto "err_other_attr_init:" and use this goto label
> in every error path after kobject_init_and_add().
> 
> Please let me know if you have any comments.

I think none of this is needed for this patch after you move the other fix 
into a separate patch. Those two paragraphs I suggest above would explain 
the problem and solution (no need to have these numbered bullets or 
anything else besides those 2 paragraphs).

-- 
 i.
--8323329-668022575-1699881249=:1867--
