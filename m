Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C233180EFBB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 16:11:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376706AbjLLPLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 10:11:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376681AbjLLPK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 10:10:57 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC67D3;
        Tue, 12 Dec 2023 07:11:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702393861; x=1733929861;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dLwFIlq58MNhpi4UGL1OxPkTqyvcNKLBZUifmxhXGb0=;
  b=Ik1JLdq8z6jd/uAJuSEFVQT3LXhgeUDZ/BMhbxKf93ejHMCf9gZdohK6
   fn6g6/aIpXRdDxc0hiSrqCBT0hzV+V7OlQP1KaxqdqSplY5zAYrBYYm9D
   96c1w4FrEfgEsBk5u3U+QErvIhLIGTpobSCwZSrIOEhsZwTqqcxnozOnM
   c7Y3YNRG8SucHm/n2Ho7PveI9yJGzaqndTeuJcmEZpctkEYuygTaQdePa
   /A0CqlUN29B0bXmhPxC0iO41NZiJ7olbgUiZkgk8OFWHo85gFBiAUlgF9
   I9HPLwlZKhTvXU11pNP4AO+6nZf2769QrasqwTMZXhsoBY/zpEtck39y5
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="374325642"
X-IronPort-AV: E=Sophos;i="6.04,270,1695711600"; 
   d="scan'208";a="374325642"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 07:10:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="896952942"
X-IronPort-AV: E=Sophos;i="6.04,270,1695711600"; 
   d="scan'208";a="896952942"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 12 Dec 2023 07:10:47 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 52C193D2; Tue, 12 Dec 2023 17:10:46 +0200 (EET)
Date:   Tue, 12 Dec 2023 17:10:46 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Sanath S <Sanath.S@amd.com>
Cc:     mario.limonciello@amd.com, andreas.noever@gmail.com,
        michael.jamet@intel.com, YehezkelShB@gmail.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] thunderbolt: Teardown tunnels and reset downstream
 ports created by boot firmware
Message-ID: <20231212151046.GF1074920@black.fi.intel.com>
References: <20231212140047.2021496-1-Sanath.S@amd.com>
 <20231212140047.2021496-3-Sanath.S@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231212140047.2021496-3-Sanath.S@amd.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 07:30:47PM +0530, Sanath S wrote:
> Boot firmware might have created tunnels of its own. Since we cannot
> be sure they are usable for us. Tear them down and reset the ports
> to handle it as a new hotplug.
> 
> Since we teardown the tunnels, Discovering of tunnels is not needed.

Let's leave this for non-USB4 (That's TBT1-3) as we agreed.
