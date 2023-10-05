Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72BDD7BA3FA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjJEQC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237812AbjJEQB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:01:27 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62544270F;
        Thu,  5 Oct 2023 06:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696513855; x=1728049855;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=BFr4H6MozJ7QEfc0QO/jO0A3h1tNpq51OwhnmLN17pY=;
  b=WpM6FGW7Mn2RnTJ/LLGPLp6yOpohZbxwTrAX93vPPlgKWOAXjGE+VFrM
   /WwnG/Qv3Kw/sd5/bMz0nMGR2Wp1AhM+dCEEef54SwccHD9rfEg2y5d3k
   TUpNy8IZ1kFCBYtfZ6CitNURiKrCjYYONalpEqMeb3c6dMSvrNO6CvQgX
   7/EvvbOIThJxXqCSlmSVqT6lYYY8V6DLAPpcRcZbQmOMFH7Z+ZJmB+h63
   mpPXV9nbRO9YdAslepqxwXJpRe7xbwbvsK75wD8h3vDewoP3x38DWX9Sm
   7xhvPMH+2WgE5D8eQhuHkpVJbO2O7rKyJmMOmwnS5bhGXG8UzlI2gNEdW
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="368538983"
X-IronPort-AV: E=Sophos;i="6.03,202,1694761200"; 
   d="scan'208";a="368538983"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 03:51:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="781204465"
X-IronPort-AV: E=Sophos;i="6.03,202,1694761200"; 
   d="scan'208";a="781204465"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO ijarvine-mobl2.mshome.net) ([10.237.66.45])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 03:51:31 -0700
Date:   Thu, 5 Oct 2023 13:51:29 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "Joseph, Jithu" <jithu.joseph@intel.com>
cc:     Hans de Goede <hdegoede@redhat.com>, markgross@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        rostedt@goodmis.org, ashok.raj@intel.com, tony.luck@intel.com,
        LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org, patches@lists.linux.dev,
        ravi.v.shankar@intel.com, pengfei.xu@intel.com
Subject: Re: [PATCH v3 0/9] IFS support for GNR and SRF
In-Reply-To: <19a7d055-bb19-f3e3-1447-7238d14a2138@intel.com>
Message-ID: <41f82af1-d08d-8f6-e642-93abf8531fc8@linux.intel.com>
References: <20230922232606.1928026-1-jithu.joseph@intel.com> <20230929202436.2850388-1-jithu.joseph@intel.com> <19a7d055-bb19-f3e3-1447-7238d14a2138@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Oct 2023, Joseph, Jithu wrote:

> 
> 
> On 9/29/2023 1:24 PM, Jithu Joseph wrote:
> > Changes in v3
> >    Ilpo Jarvinen
> >     - Added Reviewed-by tags wherever provided
> >     - In function validate_ifs_metadata() (patch 6)
> >         - Add != 0 to next line for clarity
> >     - In function ifs_load_firmware() (patch 5)
> >         - return -EINVAL instead of -BADFD
> >     - In function ifs_test_core() (patch 4)
> >         - initialize activate.gen0.rsvd = 0
> >         - use if instead of conditional operator
> >     - alignment change in ifs_scan_hashes_status_gen2 (patch 3)
> > 
> 
> Since the suggested changes from v3 are minimal, I am sending just the 3 modified patches
> in this v3 thread itself.
> 
> Hans let me know if you want me to send a v4.

I'm taking care of 6.7 cycle (or begun from -rc3 onwards to be precise), 
not Hans.

Please send a full v4 please because I want to give lkp an opportunity to 
test the whole series (even if I think the patches look okay).


-- 
 i.

