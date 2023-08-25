Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69A8C78828E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 10:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243934AbjHYIow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 04:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243900AbjHYIoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 04:44:22 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613EA1BF2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 01:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692953020; x=1724489020;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=IkWOEkzFYba0CNLljiWZG0nZMMjbSEDGAWyUgSWb3SA=;
  b=eLyTf0BJlEV0+poZLQTv0kJdmeVLNGc9qdV4dOgMyw6OAiK1kRrlLQx9
   8XfJ/sYRTYVtqN2es+TIb4IWtnHWElOE8LmW2X6par81CijY6pXyBySWC
   0sCp51CWq/K2cbIoQZhqO3iLWQ+LBrZ1EwBPYA0JTXwcoA1irIkhfyxk9
   +PSrskGl7efXfdGgQn1GvUCWUl4nx0Vm/A/B1j4/FEjuTIFWsMEiz3va2
   ogyBMlbWLjNcM4Zfuyg0gbDQVJwjI/TauLuXcFjH5S9I8yNplENQykvBz
   3Dg+lIDbL4JofHVUYfkVlbk9DuOvYlIAS9JjAluefJXXgIhiHEQXo8gsk
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="441012167"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="441012167"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 01:43:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="1068165611"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="1068165611"
Received: from enguerra-mobl.ger.corp.intel.com ([10.251.213.8])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 01:43:24 -0700
Date:   Fri, 25 Aug 2023 11:43:22 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     =?ISO-8859-15?Q?Maciej_Wiecz=F3r-Retman?= 
        <maciej.wieczor-retman@intel.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        Reinette Chatre <reinette.chatre@intel.com>,
        fenghua.yu@intel.com
Subject: Re: [PATCH 1/3] selftests/resctrl: Fix schemata write error check
In-Reply-To: <c3yp5kkhrc75tvytkbmep7xknqgomyn52xpogqzsy3sp7kwefm@ikzmp6rgzisr>
Message-ID: <32f9983a-42e-7cce-8192-bba8bbb93955@linux.intel.com>
References: <cover.1692880423.git.maciej.wieczor-retman@intel.com> <e7ea177261ded70f0c781841b0fb67fb1eb8909d.1692880423.git.maciej.wieczor-retman@intel.com> <5c6a2065-6771-ed87-c5ed-843f4e184ff8@linux.intel.com>
 <c3yp5kkhrc75tvytkbmep7xknqgomyn52xpogqzsy3sp7kwefm@ikzmp6rgzisr>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-236844462-1692952650=:3206"
Content-ID: <fddc2bb8-e24-5049-297e-c5f7ff57b2a8@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-236844462-1692952650=:3206
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <126be168-e37-7e92-b521-bd296fa97e6c@linux.intel.com>

On Fri, 25 Aug 2023, Maciej Wieczór-Retman wrote:
> On 2023-08-24 at 15:52:05 +0300, Ilpo Järvinen wrote:
> >Ki,
> >
> >You're lacking a few people from the To/Cc list. Please see KERNEL 
> >SELFTEST FRAMEWORK entry in MAINTAINERS.
> 
> Thank you, I thought I checked the MAINTAINERS file well enough. I'll
> add them in the next version
> 
> >On Thu, 24 Aug 2023, Wieczor-Retman, Maciej wrote:
> >
> >> Writing bitmasks to the schemata can fail when the bitmask doesn't
> >> adhere to some constraints defined by what a particular CPU supports.
> >> Some example of constraints are max length or being having contiguous
> >
> >"being having" is not good English.
> 
> Thanks, I'll change it
> 
> >> bits. The driver should properly return errors when any rule concerning
> >> bitmask format is broken.
> >> 
> >> Resctrl FS returns error codes from fprintf() only when fclose() is
> >> called.
> >
> >I wonder if this is actually related to libc doing buffering between 
> >fprintf() and the actual write() syscall.
> 
> I started looking and apparently in the manpages for fclose [1] it says
> it uses fflush() to flush any buffered data in the stream. So that would
> probably confirm that it does buffering there.
> 
> In this case is there a situation when the fprintf() before fclose()
> would report an error? I'm thinking if there is a point to keep error
> checking after both function calls or just fclose(). 
>
> Or would putting additional fflush() after fprintf() make some sense?
> To have separate error checks for both function calls.

Another approach would be to use syscalls directly (open, write, and 
close to eliminate the buffering entirely. Given schema is already 
written into local variable first, it would be quite straightforward to do 
that conversion.


-- 
 i.
--8323329-236844462-1692952650=:3206--
