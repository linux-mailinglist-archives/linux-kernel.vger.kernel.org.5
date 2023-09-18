Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3B1E7A4524
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 10:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237182AbjIRIt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 04:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240866AbjIRItm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 04:49:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF31E9B;
        Mon, 18 Sep 2023 01:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695026977; x=1726562977;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=2YUUS/Nrfwe4zxrCrHdl4H8tP/8zB6mvDXjfShJFfIE=;
  b=Cm4KyVpwa331JuP/bolAu28XW2SyoeKxBcCK8FMwTrpoS3z9i7MZCGDH
   PmAGHFiEZb+ezsgrxEwnOAMG9/9SPVuzIthA2VK3lc1yHzXYz/o1vDC7D
   YFvLVElPCtl/5i1rZX6XmK5UMw7S8v2Nz2FObdW/lF6UkngOBwXa5RHL0
   scHds4e9xZOLqPYx47RdGnBothR500q6SPRXJo3TuSz823pAmPV3+iaG0
   eSj8TXkXb/YC/9lpiZqUU8Cf5AuqhWWXndVc7CVJj/ElqrYYAUZ+v5wgR
   bfCZ2XCTr81ThLebs7tHOUhTVbNTuEgAaEbeU93eHk2PSUMmh1XBrfvSH
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="364643555"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="364643555"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 01:49:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="835944512"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="835944512"
Received: from nprotaso-mobl1.ccr.corp.intel.com ([10.252.49.156])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 01:49:32 -0700
Date:   Mon, 18 Sep 2023 11:49:26 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "Joseph, Jithu" <jithu.joseph@intel.com>
cc:     Hans de Goede <hdegoede@redhat.com>, markgross@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        rostedt@goodmis.org, ashok.raj@intel.com, tony.luck@intel.com,
        LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org, patches@lists.linux.dev,
        ravi.v.shankar@intel.com, pengfei.xu@intel.com
Subject: Re: [PATCH 03/10] platform/x86/intel/ifs: Image loading for new
 generations
In-Reply-To: <e084652a-91a0-0c16-7acb-d51a3d2f7ed5@intel.com>
Message-ID: <10fe57c-c926-9de4-be84-21a0f8abab6d@linux.intel.com>
References: <20230913183348.1349409-1-jithu.joseph@intel.com> <20230913183348.1349409-4-jithu.joseph@intel.com> <ba753b39-1819-35ff-1248-6ce2c2824ae9@linux.intel.com> <e084652a-91a0-0c16-7acb-d51a3d2f7ed5@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1901495400-1695026647=:1832"
Content-ID: <871ef1de-2fef-353b-b85c-d89c1a5cbdba@linux.intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1901495400-1695026647=:1832
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <546965c1-b17-8942-fff1-fb6f7a96532@linux.intel.com>

On Fri, 15 Sep 2023, Joseph, Jithu wrote:
> On 9/15/2023 9:46 AM, Ilpo Järvinen wrote:
> > On Wed, 13 Sep 2023, Jithu Joseph wrote:
> > 
> >> Scan image loading flow for newer IFS generations (1 and 2) are slightly
> >> different from that of current generation (0). In newer schemes,
> >> loading need not be done once for each socket as was done in gen0.
> >>
> >> Also the width of CHUNK related bitfields in SCAN_HASHES_STATUS MSR has
> >> increased from 8 -> 16 bits. Similarly there are width differences
> >> for CHUNK_AUTHENTICATION_STATUS too.
> >>
> >> Further the parameter to AUTHENTICATE_AND_COPY_CHUNK is passed
> >> differently in newer generations.
> >>
> >> Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
> >> Reviewed-by: Tony Luck <tony.luck@intel.com>
> >> Tested-by: Pengfei Xu <pengfei.xu@intel.com>
> >> ---
> >>  drivers/platform/x86/intel/ifs/ifs.h  |  27 ++++++
> >>  drivers/platform/x86/intel/ifs/load.c | 113 +++++++++++++++++++++++++-
> >>  2 files changed, 138 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/platform/x86/intel/ifs/ifs.h b/drivers/platform/x86/intel/ifs/ifs.h
> >> index d666aeed20fc..886dc74de57d 100644
> >> --- a/drivers/platform/x86/intel/ifs/ifs.h
> >> +++ b/drivers/platform/x86/intel/ifs/ifs.h
> >> @@ -137,6 +137,8 @@
> >>  #define MSR_CHUNKS_AUTHENTICATION_STATUS	0x000002c5
> >>  #define MSR_ACTIVATE_SCAN			0x000002c6
> >>  #define MSR_SCAN_STATUS				0x000002c7
> >> +#define MSR_SAF_CTRL				0x000004f0
> >> +
> >>  #define SCAN_NOT_TESTED				0
> >>  #define SCAN_TEST_PASS				1
> >>  #define SCAN_TEST_FAIL				2
> >> @@ -158,6 +160,19 @@ union ifs_scan_hashes_status {
> >>  	};
> >>  };
> >>  
> >> +union ifs_scan_hashes_status_gen2 {
> >> +	u64	data;
> >> +	struct {
> >> +		u16	chunk_size;
> >> +		u16	num_chunks;
> >> +		u8	error_code;
> >> +		u32	chunks_in_stride :9;
> >> +		u32	rsvd		:2;
> >> +		u32	max_core_limit	:12;
> >> +		u32	valid		:1;
> > 
> > This doesn't look it would be guaranteed to provide the alignment you seem 
> > to want for the fields.
> 
> To Quote Tony from an earlier response to a similar query[1]
> 
> "This driver is X86_64 specific (and it seems
> incredibly unlikely that some other architecture will copy this h/w
> interface so closely that they want to re-use this driver. There's an x86_64
> ABI that says how bitfields in C are allocated."
> 
> 
> 
> [1] https://lore.kernel.org/lkml/SJ1PR11MB6083EBD2D2826E0A247AF242FCD19@SJ1PR11MB6083.namprd11.prod.outlook.com/

Hi,

I was actually not that worried about this from portability perspective
but from placing u32 bitfield after u8 which according to some info I read 
about this topic way back would not get the alignment you're after. As I 
could not find anything concrete which "says" (does somebody have some 
reference for something which actually documents this?) something about 
x86_64 I ended up using pahole and checked that gcc did not leave hole 
there so it seems to be fine after all.

I think Tony's "proof" is pretty invalid. He doesn't differentiate
HW interface related bitfields from those which are not HW interface 
related (to the extent that in fact most of those bitfields likely are not 
HW interface related).

-- 
 i.
--8323329-1901495400-1695026647=:1832--
