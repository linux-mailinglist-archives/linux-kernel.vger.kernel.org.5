Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7464F7A5B81
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 09:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbjISHot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 03:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231803AbjISHoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 03:44:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D75AFFC;
        Tue, 19 Sep 2023 00:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695109473; x=1726645473;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=DueEHAS4pNn6cHKKxtYpc8Y6eCVUjoxCLg1+H69gZ5U=;
  b=D5g6Mb5hqm+Ni8czkJ0Jawl3cbAgdYI5a+TSJJNnml1r+qp7CcZIQRPH
   aF4GP093vzcA4AJ3HAhZgcu7FDGZPR/DPE+Bkxc4sxHGx6uKyrHnZThfg
   rPtvlivKanANTtgKHv7ITazHsJ+HUHiggMGsQGS8FgBlexkwxA6gWc47H
   ZipsuC+zgRVXoCj6k0Zg7NE7paMjL82ki/HqbUVna6Anq5LOqoRkWOfKt
   vXifFu1jYvgt8bZJqpgByDu4Ubt0REcizO/VMtdHj4veI1EVOM5if3YEa
   5bI4jkHDE3HxuR/6wS3GYlRn2kfz1PKkNlyHkI3HqLW4lkGfuSL0H42kJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="378774247"
X-IronPort-AV: E=Sophos;i="6.02,158,1688454000"; 
   d="scan'208";a="378774247"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 00:44:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="722762868"
X-IronPort-AV: E=Sophos;i="6.02,158,1688454000"; 
   d="scan'208";a="722762868"
Received: from laichele-mobl1.ger.corp.intel.com ([10.252.38.7])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 00:44:21 -0700
Date:   Tue, 19 Sep 2023 10:44:14 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "Joseph, Jithu" <jithu.joseph@intel.com>
cc:     Hans de Goede <hdegoede@redhat.com>, markgross@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        rostedt@goodmis.org, ashok.raj@intel.com, tony.luck@intel.com,
        LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org, patches@lists.linux.dev,
        ravi.v.shankar@intel.com, pengfei.xu@intel.com
Subject: Re: [PATCH 04/10] platform/x86/intel/ifs: Scan test for new
 generations
In-Reply-To: <5a66a02d-3504-ab5f-5373-789c8789557f@intel.com>
Message-ID: <d94e516f-6331-2f20-468-bb8c6cf899c4@linux.intel.com>
References: <20230913183348.1349409-1-jithu.joseph@intel.com> <20230913183348.1349409-5-jithu.joseph@intel.com> <74882e91-f41e-7672-3835-d74f1364bbdd@linux.intel.com> <5a66a02d-3504-ab5f-5373-789c8789557f@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-534009368-1695109467=:1920"
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

--8323329-534009368-1695109467=:1920
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Fri, 15 Sep 2023, Joseph, Jithu wrote:
> On 9/15/2023 9:51 AM, Ilpo Järvinen wrote:
> > On Wed, 13 Sep 2023, Jithu Joseph wrote:
> > 
> >> Make changes to scan test flow such that MSRs are populated
> >> appropriately based on the generation supported by hardware.
> >>
> >> Width of chunk related bitfields is ACTIVATE_SCAN and SCAN_STATUS MSRs
> >> are different in newer IFS generation compared to gen0.
> >>
> >> Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
> >> Reviewed-by: Tony Luck <tony.luck@intel.com>
> >> Tested-by: Pengfei Xu <pengfei.xu@intel.com>
> >> ---
> >>  drivers/platform/x86/intel/ifs/ifs.h     | 14 ++++++++++++++
> >>  drivers/platform/x86/intel/ifs/runtest.c | 23 ++++++++++++++++++-----
> >>  2 files changed, 32 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/drivers/platform/x86/intel/ifs/ifs.h b/drivers/platform/x86/intel/ifs/ifs.h
> >> index 886dc74de57d..3265a6d8a6f3 100644
> >> --- a/drivers/platform/x86/intel/ifs/ifs.h
> >> +++ b/drivers/platform/x86/intel/ifs/ifs.h
> >> @@ -205,6 +205,12 @@ union ifs_scan {
> >>  		u32	delay	:31;
> >>  		u32	sigmce	:1;
> >>  	};
> >> +	struct {
> >> +		u16	start;
> >> +		u16	stop;
> >> +		u32	delay	:31;
> >> +		u32	sigmce	:1;
> >> +	} gen2;
> > 
> > I don't like the way old struct is left without genx naming. It makes the 
> > code below more confusing as is.
> > 
> 
> Given that less than half the fields (2/4 in ifs_scan and 2/5 in ifs_status ) are changing across
> generations(and rest are common) , I felt the code would be more readable if the common fields are
> accessed without generation as is done now. 
> 
> That said I don’t mind changing if you feel strongly about this

I would certainly prefer the generation dependent fields to marked as 
such. However, it does not say you couldn't have the other fields remain 
w/o gen.

How about this definition (it comes with the added benefit that you 
cannot accidently use start/stop without specifying gen which guards 
against one type of bugs):

union ifs_scan {
        u64     data;
        struct {
		union {
			struct {
	        	        u8      start;
        	        	u8      stop;
	        	        u16     rsvd;
			} gen0;
		        struct {
                		u16     start;
		                u16     stop;
			} gen2;
		};
                u32     delay   :31;
                u32     sigmce  :1;
        };
};

Note that I used start and stop in gen0 without the bitfield that
seems unnecessary.

-- 
 i.

--8323329-534009368-1695109467=:1920--
