Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA0E4809001
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 19:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233088AbjLGSdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 13:33:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233032AbjLGSdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 13:33:40 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6460510E7;
        Thu,  7 Dec 2023 10:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701974026; x=1733510026;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=vOrZCjTlpOw7hm/DaYACfQ5R3zdPrvsOUsNaWvhG3Fk=;
  b=As9Xf3sblg86nm3qcZw8xnVqN1amKxvL75u+6BZFM5EFa/y5Y6wkBZVR
   hzICXoXRqyQWHDz1J3bGyMhIV6N1earCAT2yyKTl45TSnJd62xmc+3e9Y
   kw9bimf84nWcn64UoQfyD+AEZtPrQaEZp59qSXQFgMIp815RJA2mkTUZ5
   BlqqN3oTWPjWFEgfe49qVq0a9meoJ9/9mt+9sFKiDji54VXxwDMjJD1sW
   xcGZXvr7PKFktX3CoV56pOwvb0RswSqo794QodqISluIwwQ0nYWLDIFt3
   8ajlGXVS6jUQWc8nuOOwwFeVDD/poUVJ9ml7WHR3DU0oev/rsDsQyzSS8
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="393152071"
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="393152071"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 10:33:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="889833432"
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="889833432"
Received: from dkrupnov-mobl3.ger.corp.intel.com ([10.249.34.6])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 10:33:43 -0800
Date:   Thu, 7 Dec 2023 20:33:41 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
cc:     linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        =?ISO-8859-15?Q?Maciej_Wiecz=F3r-Retman?= 
        <maciej.wieczor-retman@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 08/26] selftests/resctrl: Split measure_cache_vals()
In-Reply-To: <8f6c7b40-5218-4427-865d-55e5f09c594f@intel.com>
Message-ID: <f6f42f73-ef84-535-78d7-c93685625aca@linux.intel.com>
References: <20231120111340.7805-1-ilpo.jarvinen@linux.intel.com> <20231120111340.7805-9-ilpo.jarvinen@linux.intel.com> <c303ba1b-d7bd-47cf-9e81-8ea0c60b973c@intel.com> <e87d8ba-141a-5779-fc6-27e4735fc1bf@linux.intel.com>
 <8f6c7b40-5218-4427-865d-55e5f09c594f@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-2060136618-1701974025=:1765"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2060136618-1701974025=:1765
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 7 Dec 2023, Reinette Chatre wrote:
> On 12/7/2023 6:32 AM, Ilpo Järvinen wrote:
> > On Tue, 28 Nov 2023, Reinette Chatre wrote:
> >> On 11/20/2023 3:13 AM, Ilpo Järvinen wrote:
> 
> ...
> >>> -	/*
> >>> -	 * Measure llc occupancy from resctrl.
> >>> -	 */
> >>> -	if (!strncmp(param->resctrl_val, CMT_STR, sizeof(CMT_STR))) {
> >>> -		ret = get_llc_occu_resctrl(&llc_occu_resc);
> >>> -		if (ret < 0)
> >>> -			return ret;
> >>> -		llc_value = llc_occu_resc;
> >>> -	}
> >>> -	ret = print_results_cache(param->filename, bm_pid, llc_value);
> >>> -	if (ret)
> >>> +	ret = print_results_cache(filename, bm_pid, llc_perf_miss);
> >>> +	return ret;
> >>> +}
> >>
> >> Perhaps print_results_cache() can be made to return negative error
> >> and this just be "return print_results_cache(...)" and the function
> >> comment be accurate?
> > 
> > I think, I'll just change all "return errno;" to "return -1" before this,
> > however, one open question which impacts whether this is actually Fixes 
> > class issue:
> > 
> > It seems that perror()'s manpage doesn't answer one important question, 
> > whether it ifself can alter errno or not. The resctrl selftest code 
> > assumes it doesn't but some evidence I came across says otherwise so doing 
> > return errno; after calling perror() might not even be valid at all.
> > 
> > So I'm tempted to create an additional Fixes patch about the return change 
> > into the front of the series.
> > 
> 
> I would not trust errno to contain code of earlier calls after a call to perror().
> If errno is needed I think it should be saved before calling perror(). Looking
> at perror() at [1] I do not see an effort to restore errno before it returns,
> and looking at the implementation of perror() there appears to be many
> opportunities for errno to change.
> 
> Reinette
> 
> [1] https://sourceware.org/git/?p=glibc.git;a=blob;f=stdio-common/perror.c;h=51e621e332a5e2aa76ecefb3bcf325efb43b345f;hb=HEAD#l47

I already spent some moments in converting all return error -> return -1, 
since all such places do perror() calls anyway (which I also converted to 
ksft_perror() or ksft_print_msg() where perror() didn't make any sense) 
there's not much added value in returning the errno which was not 
correctly done in the existing code anyway.


-- 
 i.

--8323329-2060136618-1701974025=:1765--
