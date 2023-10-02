Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 323617B5476
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 16:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237611AbjJBNuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 09:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237587AbjJBNtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 09:49:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65004CEE;
        Mon,  2 Oct 2023 06:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696254582; x=1727790582;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Su9edFeqwR1xBkCn8pqPpx4sRmMM7jyFUxO5eDIlZyo=;
  b=agErhDqUw7WVHL8z2hUWdvyuwLz6y4VbiFcfibEZli1YA/JP0fC+qKHx
   Ri8A61YFTtbVXUbHPqIf7lNDXw23q78FU1t4JEp+zUqx8Y7URUy877PE+
   qW/uXedbO79zKIWZP3pnhv9yCWl2g5N70MQcW35L2MosAKmLyilKTiPhK
   f3V34DK15OgFMLSJXxtLcpefUiRQzCI4au6u4zsb76Pyg2Ok1cYtUc9q3
   lnUIteiKyLfqbTa0kSL5No3GKe3HextsIgiiZw1cEqpwczB19lHWNSqXA
   cgHBj6jZE2YmAVi4z3QKPFL3DPCNZxJRaqpIqvJIcA2bxKeYfq2iP0zF+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="382551891"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="382551891"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 06:49:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="874361212"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="874361212"
Received: from roliveir-mobl1.ger.corp.intel.com ([10.251.222.16])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 06:49:07 -0700
Date:   Mon, 2 Oct 2023 16:49:04 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
cc:     Hans de Goede <hdegoede@redhat.com>, markgross@kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        platform-driver-x86@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] platform/x86: ISST : Check major minor version
In-Reply-To: <72a2766bc7bb4f9d6b3d5f2ff114f0af1b6646a4.camel@linux.intel.com>
Message-ID: <45625e9e-997b-eba1-413a-43a7d835feb@linux.intel.com>
References: <20230925194338.966639-1-srinivas.pandruvada@linux.intel.com>  <20230925194338.966639-3-srinivas.pandruvada@linux.intel.com>  <f82fcfc9-eb41-56cb-93e1-abf9cf7413@linux.intel.com> <72a2766bc7bb4f9d6b3d5f2ff114f0af1b6646a4.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-558354592-1696254548=:2459"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-558354592-1696254548=:2459
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Sat, 30 Sep 2023, srinivas pandruvada wrote:

> On Fri, 2023-09-29 at 17:28 +0300, Ilpo Järvinen wrote:
> > On Mon, 25 Sep 2023, Srinivas Pandruvada wrote:
> > 
> > > Parse major and minor version number from the version field. If
> > > there
> > > is a mismatch for major version, exit from further processing for
> > > that
> > > domain.
> > > 
> > > If there is mismatch in minor version, driver continue to process
> > > with
> > > an error message.
> > 
> > This sentence sounds odd.
> What is the suggestion here?

These things sound wrong: It should be "continues" but I also find "to 
process" odd when lacking what it processes.

-- 
 i.

--8323329-558354592-1696254548=:2459--
