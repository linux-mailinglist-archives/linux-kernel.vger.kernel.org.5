Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FDA67F745D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 13:55:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbjKXMzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 07:55:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjKXMzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 07:55:46 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682B710E4;
        Fri, 24 Nov 2023 04:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700830553; x=1732366553;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0CJxRztR8sP9yMA/a6oz2vAEEQEj6uTdKxgPbgOsEUU=;
  b=XGO9GYcVle02jjOEVNlICY6HYMhVWz1vInqD0ra3Rx8s2A3TvaWnODgm
   D8vU/m7mVqaZaXkQ4TY3+9WNL3A1veHB93FuBNUS+HfgqK+If/+ITqX1E
   4m1gjLaSMKqcS9jxaddrC+57wWZ+RQVVfLsVVTSaapVA5VU1Y4V8otdDK
   UZ+vt7yIibH4ldFr6tC3X8uAq/OygCO9RJATQtNfkyorSNncTwMgVw8Qi
   SV2x0zWpWkqIRk7IbUyWf56Nzdbw/DP/OXu0EGzGBZlifY95nwVOGlrtx
   oyvbbnD+UtjVoxH2XMzlbgefkGXCori8QQwdSAJZppbhfvHdCdC3gSXHI
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="372582127"
X-IronPort-AV: E=Sophos;i="6.04,224,1695711600"; 
   d="scan'208";a="372582127"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 04:55:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="858380941"
X-IronPort-AV: E=Sophos;i="6.04,224,1695711600"; 
   d="scan'208";a="858380941"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by FMSMGA003.fm.intel.com with SMTP; 24 Nov 2023 04:55:50 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 24 Nov 2023 14:55:49 +0200
Date:   Fri, 24 Nov 2023 14:55:49 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     linux-usb@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: Unplugging USB-C charger cable causes `ucsi_acpi USBC000:00:
 ucsi_handle_connector_change: ACK failed (-110)`
Message-ID: <ZWCdVWRGzh/2RSs3@kuha.fi.intel.com>
References: <b2466bc2-b62c-4328-94a4-b60af4135ba7@molgen.mpg.de>
 <ZVy5+AxnOZNmUZ15@kuha.fi.intel.com>
 <2bfe2311-27a6-46b5-8662-ba3cbb409f81@molgen.mpg.de>
 <ZV3CTg03IPnZTVL0@kuha.fi.intel.com>
 <6288389c-59cb-4eb4-bbe6-163413db7b7e@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6288389c-59cb-4eb4-bbe6-163413db7b7e@molgen.mpg.de>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> > Just list what you have in /sys/class/typec/ before and after plugging
> > a device to the port:
> > 
> >          ls /sys/class/typec/
> 
> Sorry, here you go:
> 
> With charger:
> 
>     $ ls /sys/class/typec/
>     port0  port0-partner
> 
> After unplugging the charger:
> 
>     $ LANG= ls /sys/class/typec/
>     port0

Thanks. The interface does not appear to be completely stuck, which is
what I wanted to check.

> By the way, Linux logs the ucsi_handle_connector_change line around five
> second after unplugging the USB Type-C charger cable.
> 
> Kind regards,
> Paul
> 
> PS: In the logs since October 30th, I see the three distinct lines below:
> 
> 1.  ucsi_acpi USBC000:00: failed to re-enable notifications (-110)
> 2.  ucsi_acpi USBC000:00: GET_CONNECTOR_STATUS failed (-110)
> 3.  ucsi_acpi USBC000:00: ucsi_handle_connector_change: ACK failed (-110)
> 
> Is it documented somewhere what -100 means?

That is the error code, and 110 means Timeout. The driver waits 5s,
which should be more than enough. If the firmware does not respond
within that 5s, it will most likely never respond.

Two of those errors mean that the driver has sent a command to the
firmware but the firmware never completes the command.

The ACK failure means that the driver tries to acknowledge a connector
change event (that you get for example when you plug or unplug the
cable) indicating that the driver has now processed the event, but the
firmware does not react to that acknowledgement like it should.

So the firmware is not behaving correctly in all these cases. I could
try to see if we can workaround those issues, but I would need to be
able reproduce the problems. Unfortunately I do not have XPS 13 9360.

But none of those problems are critical if the interface really
continues to work.

thanks,

-- 
heikki
