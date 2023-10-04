Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD757B7C91
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 11:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242072AbjJDJrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 05:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232904AbjJDJq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 05:46:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F586A7;
        Wed,  4 Oct 2023 02:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696412815; x=1727948815;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=n1lhfxc/wP5roOkvPQmjjy/QM7cgipKqKy8XywFw8h8=;
  b=EadL71nBlYV4cMO+jWihQowkOGvpKgVgh+cSsB0x8fuk6Ph7GScQnwQp
   7htftLEDT0H3dAjZ9fn1HZaW5MVU4q9wOr95Li7TMytdsbn8WRPxw2Y7y
   2t4QiRH7ARp2bhEZkkJ/llJrRZFqUbuBx1edHbdxqT60d7iH1aNtXFNNt
   nAs4cVTNQnE+4XFvueaDLO6nNYMEfIUS3J8HyXJRfwKSCyjkJoI8RvNza
   /IFk2Oi6qnh95ii49OGzQ8SVGZIMiDZ4pOJGZGEeCV/qt54ZZ5YrlK17D
   pnJa1pnsxbrEyGO9ESgaA/qLlgtvUrUMNn976OsrQ1Ru17fBbMHZqiL8w
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="447290952"
X-IronPort-AV: E=Sophos;i="6.03,199,1694761200"; 
   d="scan'208";a="447290952"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 02:46:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="894861717"
X-IronPort-AV: E=Sophos;i="6.03,199,1694761200"; 
   d="scan'208";a="894861717"
Received: from cyrillet-mobl.ger.corp.intel.com ([10.252.55.203])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 02:45:26 -0700
Date:   Wed, 4 Oct 2023 12:46:49 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
cc:     =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>, markgross@kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        platform-driver-x86@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [UPDATE][PATCH] platform/x86/intel-uncore-freq: Conditionally
 create attribute for read frequency
In-Reply-To: <ab0ab04980b07e2893d9672b96311230ac981e40.camel@linux.intel.com>
Message-ID: <b7fd5b52-9d91-cfe-e011-522160947115@linux.intel.com>
References: <20231002131817.1590966-1-srinivas.pandruvada@linux.intel.com>  <6c59be5-1ff1-d0b1-5960-3789fe10c692@linux.intel.com> <ab0ab04980b07e2893d9672b96311230ac981e40.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-667317560-1696412813=:1931"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-667317560-1696412813=:1931
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 3 Oct 2023, srinivas pandruvada wrote:
> On Tue, 2023-10-03 at 16:10 +0300, Ilpo Järvinen wrote:
> > On Mon, 2 Oct 2023, Srinivas Pandruvada wrote:
> > 
> > > When the current uncore frequency can't be read, don't create
> > > attribute
> > > "current_freq_khz" as any read will fail later. Some user space
> > > applications like turbostat fail to continue with the failure. So,
> > > check
> > > error during attribute creation.
> > > 
> > > Fixes: 8a54e2253e4c ("platform/x86/intel-uncore-freq: Uncore
> > > frequency control via TPMI")
> > 
> > Hi,
> > 
> > Thanks for the update but that commit id looks bogus, or where the
> > value 
> > is used w/o error check?
> 
> commit 8a54e2253e4c25e5b61c9a9bee157bb52da5d432
> Author: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Date:   Thu Apr 20 15:05:14 2023 -0700
> 
>     platform/x86/intel-uncore-freq: Uncore frequency control via TPMI
> 
> 
> This is the commit exposed the issue. This is not the commit which
> changed the code in question. 
> 
> 
> I can add also
> Fixes: dbce412a7733 ("platform/x86/intel-uncore-freq: Split common and
> enumeration part")
> 
> But the change even before that as this commit just reorganized code
> but because of change of folders, that will look like correct commit.

I never thought dbce412a7733 is being fixed here, it's just a refactor 
moving code around like you say.

But how about 414eef27283a ("platform/x86/intel/uncore-freq: Display 
uncore current frequency") which actually adds the code line you're now 
fixing. What was broken before it? All I see is the one call in
show_perf_status_freq_khz() but that's checking for errors.

-- 
 i.

--8323329-667317560-1696412813=:1931--
