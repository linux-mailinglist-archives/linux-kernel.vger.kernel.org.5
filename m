Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A225476D39D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 18:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbjHBQ1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 12:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbjHBQ1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 12:27:42 -0400
Received: from mgamail.intel.com (unknown [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F6861FFA;
        Wed,  2 Aug 2023 09:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690993661; x=1722529661;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0tSFjpEs5UlhC+O+bw+rDjme00w81L/vG49zgOEoiJY=;
  b=Qzc16tjw4RFlxlw9Onar/1NfK1B5uyRnLYyPQlR6g7wmoSx1ciDgkcv+
   kUWfur2qBRlPLauAQKvWJjWGKYiWepgmQtu5Atj2Qt0fSnGkDqlda/3Mi
   SPSXS9SFAvOeIksPlkZGM5OHnpn4Ug6bGVDmInDN9BZNAEwQwYRNF6Nt8
   Ya9fyBHG+St3F/ZeMgoamioO6py7EaaBj8YHiuTRg/8W6ID8I6pILo04k
   rN9sJJKIBeKB4xHMkf34rGkaGATQmj8VAUW0jwxtMxGxq+3by/v/GClET
   bdFfID8Wjbh/C9hF74hCQb5XIOYuCPk91Mq6+PMZRGexHc/yH3yNz+Cwt
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="456006618"
X-IronPort-AV: E=Sophos;i="6.01,249,1684825200"; 
   d="scan'208";a="456006618"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 09:26:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="872564979"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.146.50])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 09:26:07 -0700
Date:   Wed, 2 Aug 2023 09:26:03 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] cxl/mbox: Use correct handle in events debug
 message
Message-ID: <ZMqDm5IJQv9sR3TO@aschofie-mobl2>
References: <20230731-cxl-fix-clear-event-debug-print-v2-0-9bdd08d386e9@intel.com>
 <20230731-cxl-fix-clear-event-debug-print-v2-1-9bdd08d386e9@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731-cxl-fix-clear-event-debug-print-v2-1-9bdd08d386e9@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2023 at 01:13:28PM -0700, Ira Weiny wrote:
> The handle value used to report an event being cleared by dev_dbg() is
> incorrect due to a post increment of the payload handle index.
> 
> Delay the increment of the index until after the print.
> 
> Fixes: 6ebe28f9ec72 ("cxl/mem: Read, trace, and clear events on driver load")
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

> 
> ---
> Changes for v2
> [Dan] Go ahead and mark this for backporting
> [Dan] Remove 'To/Cc' cruft from individual patches
> [Dan/Alison] Split out the additional debugging
> [Alison] New oneliner
> ---
>  drivers/cxl/core/mbox.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index d6d067fbee97..a1c490f66bbf 100644
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
> 
> -- 
> 2.41.0
> 
