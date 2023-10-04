Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1179B7B802A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 15:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242497AbjJDNDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 09:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233003AbjJDNDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 09:03:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 123A698;
        Wed,  4 Oct 2023 06:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696424620; x=1727960620;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=vna89G92+YUSN4xCn006PAPr/J9VzgSDMaNYJ/MQZ/A=;
  b=jzLjYwPqLrrC3zKVkyidZd8RZ5LYwh5IAJPPqWl3p9KmP0V0D79HKJPG
   pxUEPce22fdSONXzCFmcS5BknRIrbOkrPvoaGHWO4A+PgkgCQYzpiIzbz
   k0EyESuymSbfos732Tgxof+Qfzp8Drx+GhOGrkXIgGiePfhM+bAhr+vXl
   hG+xqAS57EKyfPXCxBEODLdYrE5AyKtiXxwe6KxLpbb/6dRyXs9ac9Xpi
   uBuM3qyFB/KXiWYIViMbtORcUKTvgp4yRclLUm9ak9/XBHWL8MFnxFMrW
   YelAKEEAT+ZGy6wO05N/L1KJmrm9ICsrXdLCMfOwbEdkzHSTpismfyqxI
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="385986261"
X-IronPort-AV: E=Sophos;i="6.03,200,1694761200"; 
   d="scan'208";a="385986261"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 06:03:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="1082496523"
X-IronPort-AV: E=Sophos;i="6.03,200,1694761200"; 
   d="scan'208";a="1082496523"
Received: from cyrillet-mobl.ger.corp.intel.com ([10.252.55.203])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 06:03:33 -0700
Date:   Wed, 4 Oct 2023 16:03:31 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] platform/x86/intel/tpmi: Add defines to get
 version information
In-Reply-To: <ZR1hzZ4KNZqElGGH@smile.fi.intel.com>
Message-ID: <a55042c8-bd-d035-4f9e-83f6e2f6038@linux.intel.com>
References: <20231003184916.1860084-1-srinivas.pandruvada@linux.intel.com> <20231003184916.1860084-2-srinivas.pandruvada@linux.intel.com> <ZR1hzZ4KNZqElGGH@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Oct 2023, Andy Shevchenko wrote:

> On Tue, Oct 03, 2023 at 11:49:14AM -0700, Srinivas Pandruvada wrote:
> > Add defines to get major and minor version from a TPMI version field
> > value. This will avoid code duplication to convert in every feature
> > driver. Also add define for invalid version field.
> 
> ...
> 
> > +#define TPMI_VERSION_INVALID	0xff
> 
> I would make it clearer with (GENMASK(7, 5) | GENMASK(4, 0))
> or even with specific masks defined and used in both cases:
> #def
> 
> #define TPMI_MINVER_MASK	GENMASK(4, 0)
> #define TPMI_MAJVER_MASK	GENMASK(7, 5)
> 
> #define TPMI_VERSION_INVALID	(TPMI_MINVER_MASK | TPMI_MAJVER_MASK)
> 
> #define TPMI_MINOR_VERSION(val)	FIELD_GET(TPMI_MINVER_MASK, val)
> #define TPMI_MAJOR_VERSION(val)	FIELD_GET(TPMI_MAJVER_MASK, val)
> 
> > +#define TPMI_MINOR_VERSION(val)	FIELD_GET(GENMASK(4, 0), val)
> > +#define TPMI_MAJOR_VERSION(val)	FIELD_GET(GENMASK(7, 5), val)

In case somebody does, please do it on top of the existing changes as
I already applied the series.


-- 
 i.

