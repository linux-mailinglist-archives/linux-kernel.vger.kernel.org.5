Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE4D476A642
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 03:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbjHABYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 21:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbjHABYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 21:24:06 -0400
Received: from mgamail.intel.com (unknown [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE70B1707;
        Mon, 31 Jul 2023 18:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690853044; x=1722389044;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KhN5AuFcQElJOP62go3wRfM0GbtP4K7iYQy+CQD//dY=;
  b=PpIAuttxLc/HdKFvNMW36MqxHJCSeaf1mYVtEpZ2izDjblN7d1jnMkxW
   fn95uX+y6gb+XBDJBXI3UqHx6P5Ex1x1KD1Fq4YTEtKFI6UM2fjtyZ+aZ
   6gz5DjzaiETGrFvwY8Qn7d94C4Oirf0HaJD8wdWMA0/Vu+33ziABjB3nG
   lEFsxgL619HJeoOkSOAn5U6df8RWNOYXzeRVsSHCh+Y71cW/pZCTQgz8y
   iFkmM3k7A9ocaxVBjmkPGQrgVtRWiumHiH9C17IkYp+ig9clRBW7/uySj
   Iu87UjyiS6IqH4MdxvmD0Jwza9glr594Gx9m0vmhWi+YA7CWRkwBCDq4c
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="366638749"
X-IronPort-AV: E=Sophos;i="6.01,246,1684825200"; 
   d="scan'208";a="366638749"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 18:24:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="705629549"
X-IronPort-AV: E=Sophos;i="6.01,246,1684825200"; 
   d="scan'208";a="705629549"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.255.229.233])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 18:24:03 -0700
Date:   Mon, 31 Jul 2023 18:24:02 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cxl/mbox: Fix debug message print
Message-ID: <ZMhesrtXf31iST/O@aschofie-mobl2>
References: <20230731-cxl-fix-clear-event-debug-print-v1-1-42c068f500d1@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731-cxl-fix-clear-event-debug-print-v1-1-42c068f500d1@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 01:52:27PM -0700, Ira Weiny wrote:

Looks like this is rolling for the distro list, so..

Please be more specific than this:
[PATCH] cxl/mbox: Fix debug message print

Something like this is more useful to folks scanning the one-liners:
[PATCH] cxl/mbox: Use correct handle in events debug message

> The handle value used to report an event being cleared by dev_dbg() is
> incorrect due to a post increment of the payload handle index.
> 
> Delay the increment of the index until after the print.  Also add the
> debugging for event processing which was useful in finding this bug.
> 

"Also" always smells like something that should be a separate patch.

I guess you could rewrite the commit message and keep it in one patch:
[PATCH] cxl/mbox: Improve event dev_dbg() messages

Alison


> To: Davidlohr Bueso <dave@stgolabs.net>
> To: Jonathan Cameron <jonathan.cameron@huawei.com>
> To: Dave Jiang <dave.jiang@intel.com>
> To: Alison Schofield <alison.schofield@intel.com>
> To: Vishal Verma <vishal.l.verma@intel.com>
> To: Dan Williams <dan.j.williams@intel.com>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: linux-cxl@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---
> NOTE: This does fix a bug in the patch referenced below.  However, I
> don't think that warrants back porting because this is only a debug
> print.
> 
> Fixes: 6ebe28f9ec72 ("cxl/mem: Read, trace, and clear events on driver load")
> ---
>  drivers/cxl/core/mbox.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index d6d067fbee97..f052d5f174ee 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -882,9 +882,10 @@ static int cxl_clear_event_record(struct cxl_memdev_state *mds,
>  	 */
>  	i = 0;
>  	for (cnt = 0; cnt < total; cnt++) {
> -		payload->handles[i++] = get_pl->records[cnt].hdr.handle;
> +		payload->handles[i] = get_pl->records[cnt].hdr.handle;
>  		dev_dbg(mds->cxlds.dev, "Event log '%d': Clearing %u\n", log,
>  			le16_to_cpu(payload->handles[i]));
> +		i++;
>  
>  		if (i == max_handles) {
>  			payload->nr_recs = i;
> @@ -946,9 +947,13 @@ static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
>  		if (!nr_rec)
>  			break;
>  
> -		for (i = 0; i < nr_rec; i++)
> +		for (i = 0; i < nr_rec; i++) {
> +			dev_dbg(dev, "Event log %d: processing handle %u\n",
> +				type,
> +				le16_to_cpu(payload->records[i].hdr.handle));
>  			cxl_event_trace_record(cxlmd, type,
>  					       &payload->records[i]);
> +		}
>  
>  		if (payload->flags & CXL_GET_EVENT_FLAG_OVERFLOW)
>  			trace_cxl_overflow(cxlmd, type, payload);
> 
> ---
> base-commit: 5d0c230f1de8c7515b6567d9afba1f196fb4e2f4
> change-id: 20230731-cxl-fix-clear-event-debug-print-3b57da0e956c
> 
> Best regards,
> -- 
> Ira Weiny <ira.weiny@intel.com>
> 
