Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75DED7729B4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 17:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbjHGPrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 11:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjHGPrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 11:47:33 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C0DBD;
        Mon,  7 Aug 2023 08:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691423247; x=1722959247;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=S5R8lyVpxKToCI44Qh86SOGp/9Nirm8EW7ml2N+tB4s=;
  b=KKFvK+qigxQa7gkIzU9/53OELDrJiJkcE0A++hJfW+IhGku53zHtP+Gu
   QCulMId71usNmn0KaJK3yUdkqmjRGfkXK9vTqFm9u6XG/vxb7GrPcOWH2
   kS49LAX1rmTVd3c3IeszM5KpRXbSpyCDwwq//4eNEYVTkiTtCLMqwaJNM
   RCg5zK9HHrSRn8VQcWQ/p4ITbSImwYpCx42/+hwDXh4mckGKel2f/raoN
   HVDM1thiYCcnbYEPXacVCJlDq7sdlTgEKwhTcuWKfLkoFaeqZoyYlxoVC
   zRS0R29Q0us+XjdqzkOCLXqW1q1QT5GHaG0O5bUD3bbPu7Vdlpqoom0lE
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="360664471"
X-IronPort-AV: E=Sophos;i="6.01,262,1684825200"; 
   d="scan'208";a="360664471"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2023 08:45:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="874355996"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 07 Aug 2023 08:45:16 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qT2Pw-000NAK-1V;
        Mon, 07 Aug 2023 18:45:12 +0300
Date:   Mon, 7 Aug 2023 18:45:12 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Justin Tee <justin.tee@broadcom.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: Re: [PATCH v1 1/1] scsi: lpfc: Do not abuse UUID APIs
Message-ID: <ZNERiABjPliMWu8f@smile.fi.intel.com>
References: <20230807095823.33902-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807095823.33902-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2023 at 12:58:23PM +0300, Andy Shevchenko wrote:
> The lpfc_vmid_host_uuid is not defined as uuid_t and its usage is not
> the same as for uuid_t operations (like exporting or importing).
> Hence replace call to uuid_is_null() by respective memchr_inv() without
> abusing casting.

The v2 had been issued, this patch is wrong, sorry.

-- 
With Best Regards,
Andy Shevchenko


