Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72D9A7A5F4D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 12:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbjISKSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 06:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjISKR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 06:17:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE824E8;
        Tue, 19 Sep 2023 03:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695118672; x=1726654672;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=05/TtXTbpaSK6G3uOTBzMjq0JajybnUaFTuIy2/oKgI=;
  b=cGi6L46yQmTyolfhP9gUW+NdTLhtSbrDmY4Rujxzda0YlCgcN4E26pbI
   koqO+37AS/9HoSKd9BB5MqLi6emG09AiyRmwZr9jW/oxgKg20qcdG9hwn
   GJRj1btAjwgtie+ob7IsnXUQ1w6hd9oK8p8GydMx29S6kSwSaIJsEMp+4
   y60PwzvGSrepuyL1+IGr4imVMpSlQHhJX2UC/aqg6gRKC1JWZbpQlvE9J
   Pnl+Czwpu8pDXw7goIqkOVWwXcz/41lwjiHZRwaQIomuTfP/WTdSxW0Yy
   49WRiyV1jatjqOA4nIjI6LY4R6BB6ywMgPdluAaNsZCYLgkwHFscDizcX
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="410832470"
X-IronPort-AV: E=Sophos;i="6.02,159,1688454000"; 
   d="scan'208";a="410832470"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 03:17:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="781256036"
X-IronPort-AV: E=Sophos;i="6.02,159,1688454000"; 
   d="scan'208";a="781256036"
Received: from laichele-mobl1.ger.corp.intel.com ([10.252.38.7])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 03:17:50 -0700
Date:   Tue, 19 Sep 2023 13:17:49 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/15] random tty fixes
In-Reply-To: <20230919085156.1578-1-jirislaby@kernel.org>
Message-ID: <6f7b65a8-bc9c-83d2-13c9-a56d85616b53@linux.intel.com>
References: <20230919085156.1578-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-85316023-1695118627=:1920"
Content-ID: <8751c2-6ac4-be6-4791-191036869597@linux.intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-85316023-1695118627=:1920
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <f1e8e3ff-69ed-b7aa-f0ac-aff5809ca27@linux.intel.com>

On Tue, 19 Sep 2023, Jiri Slaby (SUSE) wrote:

> This is a collection of random fixes for tty I did while crawling
> through the code. Mostly done for readability and understandability. No
> behavior change intended (except for Documentation fixes).
> 
> Jiri Slaby (SUSE) (15):
>   tty: n_tty: use 'retval' instead of 'c'
>   tty: n_tty: rename and retype 'retval' in n_tty_ioctl()
>   tty: n_tty: use min3() in copy_from_read_buf()
>   tty: n_tty: invert the condition in copy_from_read_buf()
>   tty: n_tty: use do-while in n_tty_check_{,un}throttle()
>   tty: switch tty_{,un}throttle_safe() to return a bool
>   tty: invert return values of tty_{,un}throttle_safe()
>   tty: fix up and plug in tty_ioctl kernel-doc
>   tty: fix kernel-doc for functions in tty.h
>   tty: stop using ndash in kernel-doc
>   tty: tty_buffer: use bool for 'restart' in
>     tty_buffer_unlock_exclusive()
>   tty: convert THROTTLE constants into enum
>   tty: early return from send_break() on TTY_DRIVER_HARDWARE_BREAK
>   tty: don't check for signal_pending() in send_break()
>   tty: use 'if' in send_break() instead of 'goto'
> 
>  Documentation/driver-api/tty/index.rst     |   1 +
>  Documentation/driver-api/tty/tty_ioctl.rst |  10 +
>  drivers/tty/n_tty.c                        |  77 ++++---
>  drivers/tty/tty.h                          |  13 +-
>  drivers/tty/tty_buffer.c                   |   5 +-
>  drivers/tty/tty_io.c                       |  36 ++--
>  drivers/tty/tty_ioctl.c                    | 234 ++++++++++-----------
>  drivers/tty/tty_port.c                     |   6 +-
>  drivers/tty/vt/consolemap.c                |   2 +-
>  drivers/tty/vt/vc_screen.c                 |   4 +-
>  drivers/tty/vt/vt.c                        |   4 +-
>  include/linux/tty.h                        |  25 +--
>  12 files changed, 209 insertions(+), 208 deletions(-)
>  create mode 100644 Documentation/driver-api/tty/tty_ioctl.rst

For this whole series except the patches I commented on:

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

...If you make the amendments I requested, please add the tag also to the 
patches I commented on.

-- 
 i.
--8323329-85316023-1695118627=:1920--
