Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E39D7EEE31
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 10:13:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234605AbjKQJNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 04:13:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbjKQJNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 04:13:47 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D32BED4D;
        Fri, 17 Nov 2023 01:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700212424; x=1731748424;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=WjdVKVRCozQOfZSmv4tMG9xPVuBJy+Nbrwk0NYZV2VU=;
  b=FGutNA+oPGB6vSHNy6UCYcCRgEey+fucTvZPQfceSgJu8fN7PW1sx6Rv
   Nxr0ljnJrncX3H55F37CEgQrop/XO9dJBsgy36PyXRM4dGw3OZXs0U/if
   yQGSCVr1/z669Sx/xgVoOuBc09AxWjDte7QaObx4XuRIwiE9aR8dnzv/q
   eMHHAbh8TX0ctrZjUSptH+bx6nWZOqTij+Gbo+xwq60kdN5eYMzFJ177Y
   cWLd769IVp/lsv/TUQhblZ7/E1jiWpOdqM9bSA7Te/AKMXnacPduMrl/x
   jbpLNf/SvwWv+GNIaEGiUrxOSTWkLo9thMZlNnTe36WWu3l9F2X0RhxN8
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="395192459"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="395192459"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 01:13:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="769175291"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="769175291"
Received: from scoltan-mobl.ger.corp.intel.com ([10.249.46.6])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 01:13:41 -0800
Date:   Fri, 17 Nov 2023 11:13:35 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
cc:     Ping-Ke Shih <pkshih@realtek.com>, Kalle Valo <kvalo@kernel.org>,
        Jian-Hong Pan <jhp@endlessos.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Jonathan Bither <jonbither@gmail.com>,
        linux-wireless@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] wifi: rtlwifi: drop unused const_amdpci_aspm
In-Reply-To: <20231116180529.52752-1-helgaas@kernel.org>
Message-ID: <f51c6735-c764-d8ca-dc61-c3f8302634ad@linux.intel.com>
References: <20231116180529.52752-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-898684072-1700212423=:1724"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-898684072-1700212423=:1724
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Thu, 16 Nov 2023, Bjorn Helgaas wrote:

> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Remove the unused "const_amdpci_aspm" member of struct rtl_pci and
> struct rtl_ps_ctl.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-898684072-1700212423=:1724--
