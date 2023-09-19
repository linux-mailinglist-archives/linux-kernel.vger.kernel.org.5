Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3D4D7A6051
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 12:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbjISK5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 06:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232009AbjISK4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 06:56:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC8B51993;
        Tue, 19 Sep 2023 03:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695120814; x=1726656814;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=hro5XC0Qir/jQ6oLOmDsUMk4tbRNJGYIOHO77/8Kzu4=;
  b=mWPD0s/4ralvNEiJHVs9BZHvnpP0FDmArgnYZwJzQrE8eJE0GMMgYEjt
   Au8Vk4jF9uTG5SlQpNfPTqja2HW/jHp8mdgsnb633qmJV7Iqp8BTZymmo
   rODxUSK4T/uvwD6s/1FWCi+TfRngK2N4ZWsNu1du8uC8JFSysphKRSnHN
   apwF8A6eYAFk3dPgjnMbe5Eik+MeMXXvvbESXERVmEU3pcc5yIs9Gz2U+
   xQiCjFbbwt7ClJPFtlOBvgpZw9OQ8XCPLSXRdM3YFmq7PCfGPlsOWt8lZ
   PbxsVaAf5Y/S4jCptXqr8gBHXNghTkQH/kWHGLZlhwyDVuC90wZaQbILa
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="382660032"
X-IronPort-AV: E=Sophos;i="6.02,159,1688454000"; 
   d="scan'208";a="382660032"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 03:53:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="816398196"
X-IronPort-AV: E=Sophos;i="6.02,159,1688454000"; 
   d="scan'208";a="816398196"
Received: from laichele-mobl1.ger.corp.intel.com ([10.252.38.7])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 03:53:31 -0700
Date:   Tue, 19 Sep 2023 13:53:30 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/15] random tty fixes
In-Reply-To: <2023091952-civic-balancing-5c50@gregkh>
Message-ID: <ce6ced24-758e-e46c-e54f-53e9682f6e1e@linux.intel.com>
References: <20230919085156.1578-1-jirislaby@kernel.org> <6f7b65a8-bc9c-83d2-13c9-a56d85616b53@linux.intel.com> <2023091952-civic-balancing-5c50@gregkh>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-450182543-1695120813=:1920"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-450182543-1695120813=:1920
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Tue, 19 Sep 2023, Greg Kroah-Hartman wrote:

> On Tue, Sep 19, 2023 at 01:17:49PM +0300, Ilpo Järvinen wrote:
> > On Tue, 19 Sep 2023, Jiri Slaby (SUSE) wrote:
> > 
> > > This is a collection of random fixes for tty I did while crawling
> > > through the code. Mostly done for readability and understandability. No
> > > behavior change intended (except for Documentation fixes).
> > > 
> > > Jiri Slaby (SUSE) (15):
> > >   tty: n_tty: use 'retval' instead of 'c'
> > >   tty: n_tty: rename and retype 'retval' in n_tty_ioctl()
> > >   tty: n_tty: use min3() in copy_from_read_buf()
> > >   tty: n_tty: invert the condition in copy_from_read_buf()
> > >   tty: n_tty: use do-while in n_tty_check_{,un}throttle()
> > >   tty: switch tty_{,un}throttle_safe() to return a bool
> > >   tty: invert return values of tty_{,un}throttle_safe()
> > >   tty: fix up and plug in tty_ioctl kernel-doc
> > >   tty: fix kernel-doc for functions in tty.h
> > >   tty: stop using ndash in kernel-doc
> > >   tty: tty_buffer: use bool for 'restart' in
> > >     tty_buffer_unlock_exclusive()
> > >   tty: convert THROTTLE constants into enum
> > >   tty: early return from send_break() on TTY_DRIVER_HARDWARE_BREAK
> > >   tty: don't check for signal_pending() in send_break()
> > >   tty: use 'if' in send_break() instead of 'goto'
> > > 
> > >  Documentation/driver-api/tty/index.rst     |   1 +
> > >  Documentation/driver-api/tty/tty_ioctl.rst |  10 +
> > >  drivers/tty/n_tty.c                        |  77 ++++---
> > >  drivers/tty/tty.h                          |  13 +-
> > >  drivers/tty/tty_buffer.c                   |   5 +-
> > >  drivers/tty/tty_io.c                       |  36 ++--
> > >  drivers/tty/tty_ioctl.c                    | 234 ++++++++++-----------
> > >  drivers/tty/tty_port.c                     |   6 +-
> > >  drivers/tty/vt/consolemap.c                |   2 +-
> > >  drivers/tty/vt/vc_screen.c                 |   4 +-
> > >  drivers/tty/vt/vt.c                        |   4 +-
> > >  include/linux/tty.h                        |  25 +--
> > >  12 files changed, 209 insertions(+), 208 deletions(-)
> > >  create mode 100644 Documentation/driver-api/tty/tty_ioctl.rst
> > 
> > For this whole series except the patches I commented on:
> > 
> > Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > 
> > ...If you make the amendments I requested, please add the tag also to the 
> > patches I commented on.
> 
> That's horrible, b4 will now just add this reviewed-by to all of them
> when I run it :(

Okay, I'll try to avoid it in the future.

-- 
 i.

--8323329-450182543-1695120813=:1920--
