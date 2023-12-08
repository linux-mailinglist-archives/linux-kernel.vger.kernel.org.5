Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22E6380A241
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 12:33:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbjLHLdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 06:33:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjLHLdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 06:33:06 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B0C10FC;
        Fri,  8 Dec 2023 03:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702035192; x=1733571192;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=qSSiTdVtUd5Ku/y6N4rfjtDnlWxAxtZ/pt6ANlrK6/o=;
  b=Fd9YW7Kmz79yb2NIB+kQ8GsjjNey0Y0fhvlPfwQ2sFc18lohucE5qPbc
   LXq7l4C5s6dAF762ZXD2/2ZNTKT35D2q8BQIV13h2XWZKYdbJblY9PyPr
   Z2jQ72biytkvZf1qe9xq8TJKPZQwltxtmN5lHHYJ34enBMpMcHDmomqKY
   PIc/Y8STFf8XC7L9UYap8OB5I5WHRGg/hU9c9I/2U1TRsaeHnj0JHNwKV
   d/KmY0WsYO0Ks7Zoc9aBkVVA/SLXh9SkyrR/nTuppSNHS1/0BEmeyr9nR
   Xg/2wgpnFpBO9PokTu9EoSLVx/H4rqorFrfboeaEKuMbzeWfYnFmQNrMR
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="374556038"
X-IronPort-AV: E=Sophos;i="6.04,260,1695711600"; 
   d="scan'208";a="374556038"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 03:33:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="842569866"
X-IronPort-AV: E=Sophos;i="6.04,260,1695711600"; 
   d="scan'208";a="842569866"
Received: from smatua-mobl.ger.corp.intel.com ([10.251.223.110])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 03:33:10 -0800
Date:   Fri, 8 Dec 2023 13:33:07 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Armin Wolf <W_Armin@gmx.de>
cc:     Hans de Goede <hdegoede@redhat.com>, corbet@lwn.net,
        Dell.Client.Kernel@dell.com, linux-doc@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/5] platform/x86: wmi: Remove debug_event module param
In-Reply-To: <20231207222623.232074-3-W_Armin@gmx.de>
Message-ID: <ee7d574a-4b3c-1583-197c-9333576332ca@linux.intel.com>
References: <20231207222623.232074-1-W_Armin@gmx.de> <20231207222623.232074-3-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-51272856-1702035191=:1875"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-51272856-1702035191=:1875
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Thu, 7 Dec 2023, Armin Wolf wrote:

> Users can already listen to ACPI WMI events through
> the ACPI netlink interface. The old wmi_notify_debug()
> interface also uses the deprecated GUID-based interface.
> Remove it to make the event handling code more readable.
> 
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-51272856-1702035191=:1875--
