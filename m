Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AEBE812C8D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 11:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443562AbjLNKMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 05:12:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443503AbjLNKMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 05:12:50 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94CFAB2;
        Thu, 14 Dec 2023 02:12:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702548777; x=1734084777;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=INz0o1RXXFJG7rPpR1emQNovSti+g5Nnf66owG44gU8=;
  b=NwczzJHdjwpsJDJM+aLRo/+05Bg1YzKAEvq1D6CQ2cmSoviKixmvd99N
   Hzls0SZT81Ihlipsacgg6MgPhUf7uu0R4EoWQT91XULweCV2MqcIM5rB3
   KBAwtNJgwRJM6rb5voVloHqQKTNDxM/aSth8ccJ4PsiUcMxLPXZSoXkqq
   Y6OFhLmIWwJY/5oXVynitp7FrDyqcycDUpdGoI5z7/UuyZ1SxMzkkYgwP
   u2rkDedCAo53Ultf/T72xh+XoqkiStR9wHzziQ5/wmToJugY/aFyzWKSl
   VdSI1cp84KP+zz2Xn9j50MEr2HNqhRiFUy9fruFKa9lfj2UJl85w/kzTa
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="1950190"
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="1950190"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 02:12:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="808533599"
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="808533599"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO ijarvine-mobl2.mshome.net) ([10.237.66.38])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 02:12:53 -0800
Date:   Thu, 14 Dec 2023 12:12:50 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
cc:     linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        =?ISO-8859-15?Q?Maciej_Wiecz=F3r-Retman?= 
        <maciej.wieczor-retman@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 01/29] selftests/resctrl: Convert perror() to
 ksft_perror() or ksft_print_msg()
In-Reply-To: <1e7ede83-ac80-43aa-a452-0f95b32d849c@intel.com>
Message-ID: <c82b5c4-72e-c1ad-dce9-e5adf5d4a9b@linux.intel.com>
References: <20231211121826.14392-1-ilpo.jarvinen@linux.intel.com> <20231211121826.14392-2-ilpo.jarvinen@linux.intel.com> <1e7ede83-ac80-43aa-a452-0f95b32d849c@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-830180910-1702548775=:5690"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-830180910-1702548775=:5690
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 13 Dec 2023, Reinette Chatre wrote:

> Hi Ilpo,
> 
> On 12/11/2023 4:17 AM, Ilpo Järvinen wrote:
> > The resctrl selftest code contains a number of perror() calls. Some of
> > them come with hash character and some don't. The kselftest framework
> > provides ksft_perror() that is compatible with test output formatting
> > so it should be used instead of adding custom hash signs.
> > 
> > Some perror() calls are too far away from anything that sets error.
> > For those call sites, ksft_print_msg() must be used instead.
> > 
> > Convert perror() to ksft_perror() or ksft_print_msg().
> > 
> > Other related changes:
> > - Remove hash signs
> > - Remove trailing stops & newlines from ksft_perror()
> > - Add terminating newlines for converted ksft_print_msg()
> > - Use consistent capitalization
> > 
> 
> Another great cleanup. Also thanks for fixing some non-sensical messages.
> 
> ...
> 
> > @@ -149,7 +149,7 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
> >  	param.num_of_runs = 0;
> >  
> >  	if (pipe(pipefd)) {
> > -		perror("# Unable to create pipe");
> > +		ksft_perror("Unable to create pipe");
> >  		return errno;
> >  	}
> >  
> > @@ -185,7 +185,7 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
> >  			 * Just print the error message.
> >  			 * Let while(1) run and wait for itself to be killed.
> >  			 */
> > -			perror("# failed signaling parent process");
> > +			ksft_perror("Failed signaling parent process");
> >  
> 
> Partial writes are not actually errors and it cannot be expected that errno be set
> in these cases. In these cases I think ksft_print_msg() would be more appropriate.

I can change those to use print instead although I don't think these will
fail for other reasons than a real error as the pipe should be empty and 
only single byte is written to it.

> >  		if (fprintf(fp, "Pid: %d \t Mem_BW_iMC: %f \t Mem_BW_resc: %lu \t Difference: %lu\n",
> >  			    bm_pid, bw_imc, bw_resc, diff) <= 0) {
> > +			ksft_perror("Could not log results");
> >  			fclose(fp);
> > -			perror("Could not log results.");
> >  
> >  			return errno;
> 
> >From what I can tell fprintf() does not set errno on error. Perhaps this
> should rather be ksft_print_msg()?

Oh, what a stupid gotcha in libc. I just assumed it does set errno without 
even checking... because why it wouldn't follow the custom. ...It seems 
nothing can be relied on :-/.

-- 
 i.

--8323329-830180910-1702548775=:5690--
