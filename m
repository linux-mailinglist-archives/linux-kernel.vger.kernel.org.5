Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1FD37A5011
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 18:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbjIRQ6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 12:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbjIRQ6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 12:58:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 053D518F;
        Mon, 18 Sep 2023 09:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695056299; x=1726592299;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ziHw/sy984NIKoppaIYXIKlbyWVZyfzywUzaodCwEt4=;
  b=IwW60tA6ccmRYbumrF8fifrQSla0PyJ69esOeIwztAU4c5fFt8sdODN9
   cMvbrLGFotAx6O0B55rotjE2M9oMfBiljf9e5p2btGUfa5IOavci6UGcL
   ToifvYkAukjDsrjy4LdCIli/ykEorsK94hsJUx0Chv0meG57Y/FtUIgc3
   LQMKDeR/Dqw35EMofMpw3BwfGXhYy+Wy01Lp8JH4oijkarNXLfZSuOFYm
   o8QBLL22zXYYB9hD+PXoZapwfg96HVSE8in5d1qwnOSnUWUE9rQPaAyAH
   6FDgIY0c/8DW6CVH0OiVqdYGVfokV82WyRAz0YjOAFwuE5m7IJIASYXZE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="383537645"
X-IronPort-AV: E=Sophos;i="6.02,157,1688454000"; 
   d="scan'208";a="383537645"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 09:58:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="992799245"
X-IronPort-AV: E=Sophos;i="6.02,157,1688454000"; 
   d="scan'208";a="992799245"
Received: from ecochran-mobl1.amr.corp.intel.com (HELO [10.212.244.237]) ([10.212.244.237])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 09:58:03 -0700
Message-ID: <789bc8e6-882a-3dfb-7381-fd9b5aca3c77@intel.com>
Date:   Mon, 18 Sep 2023 09:58:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 03/10] platform/x86/intel/ifs: Image loading for new
 generations
Content-Language: en-US
To:     "Joseph, Jithu" <jithu.joseph@intel.com>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        "Luck, Tony" <tony.luck@intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "Xu, Pengfei" <pengfei.xu@intel.com>
References: <20230913183348.1349409-1-jithu.joseph@intel.com>
 <20230913183348.1349409-4-jithu.joseph@intel.com>
 <ba753b39-1819-35ff-1248-6ce2c2824ae9@linux.intel.com>
 <e084652a-91a0-0c16-7acb-d51a3d2f7ed5@intel.com>
 <10fe57c-c926-9de4-be84-21a0f8abab6d@linux.intel.com>
 <SJ1PR11MB6083A4237D928F180B6DB1E1FCFBA@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <56b486ce-2a6e-c4c7-8bc5-ceeb7119ba1@linux.intel.com>
 <SJ1PR11MB608304A84A2B662C78FDB677FCFBA@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <a02d2957-3ec4-f89c-ebe-474c3987b237@linux.intel.com>
 <826a2b32-bd6a-900a-19fa-e169fcf0d29d@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <826a2b32-bd6a-900a-19fa-e169fcf0d29d@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/18/23 09:51, Joseph, Jithu wrote:
> 
> On 9/18/2023 9:29 AM, Ilpo Järvinen wrote:
> 
>> In this case it is not just about the bitfield itself nor the bit 
>> allocation order but sharing the storage unit with another member, and to 
>> further complicate things, members have different alignment requirement 
>> too (32-bit aligned u8 followed by u32 bitfield).
>>
> I too verified that the size of the whole structure matches that of MSR  64 bits (8 bytes). 
> 
> Initially when IFS scan was added the  all MSR structure members were  bit-fields, later there was a suggestion to
> use basic C types if applicable during subsequent Array BIST patch series. I followed this approach with the  current patch series . 
> 
> I will change the current series to use all bit-field MSR structures in v2, given mixing basic types and bitfields is a a source of confusion

That's the wrong direction. :)

What is more obviously correct.  This:

	struct {
		u16	valid_chunks;
		u16	total_chunks;
		u8	error_code;
		u8	rsvd1;
		u8	rsvd2;
		u8	rsvd3;
	};

or this:

	struct {
		u16	valid_chunks;
		u16	total_chunks;
		u8	error_code;
		u32	error_code	:8;
		u32	rsvd		:24;
	};

?
