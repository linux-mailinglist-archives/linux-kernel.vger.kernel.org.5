Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81CC47E7F84
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 18:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbjKJRyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 12:54:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjKJRx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 12:53:29 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB1EA7515;
        Fri, 10 Nov 2023 05:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699622535; x=1731158535;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=uDZGP2f6h/WZzzSya/mjS46j44Y1shWREjmM3+7CtIE=;
  b=GCp8w7kTSWVtfpgx19/FFHdjFSmyKIjEu1O0eNqgMllvHXn8nJzCUrSE
   tdKCvpJrzw8dLxtNMcV6WhZgWDj0JwumT37BglyiPMh0hTnv5RsfU2+mN
   aNfqPFSaf1C06BbtP42zx7p1Mo/ICQRsVL/CXLX5XoWlSE33TA8DCaJf9
   1J3yQzfcW8IWluUSP0wqV1hPT49ysI4IAUrXytPvbbGEEMreW5mMCwsiB
   Nh8Ea61/ihu9dp4TeRKY8EwytaeoSdiEHh5CnaKMYjLmf3mp/aHxikA4y
   Ivseo6BIafvxJjxE/Ym0WrutD7NmBWyNKNTPcl2eCPDMDWg6rHaxI7tO5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="3168021"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; 
   d="scan'208";a="3168021"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2023 05:22:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; 
   d="scan'208";a="11869178"
Received: from joudin-mobl2.ger.corp.intel.com ([10.252.38.36])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2023 05:22:13 -0800
Date:   Fri, 10 Nov 2023 15:22:10 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     =?ISO-2022-JP?Q?=1B$BghD6=1B=28J?= <aichao@kylinos.cn>
cc:     Hans de Goede <hdegoede@redhat.com>,
        markgross <markgross@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86 <platform-driver-x86@vger.kernel.org>
Subject: Re: Re: [PATCH v6] platform/x86: inspur-platform-profile: Add platform
 profile support
In-Reply-To: <12tjevo53d-12w3aii8qy@nsmail7.0.0--kylin--1>
Message-ID: <207247d-ffd0-2d22-48f-fcbfe12b1d1c@linux.intel.com>
References: fad13328-4246-3659-a887-2dd5ead262f2@linux.intel.com <12tjevo53d-12w3aii8qy@nsmail7.0.0--kylin--1>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-215195145-1699622534=:1596"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-215195145-1699622534=:1596
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Fri, 10 Nov 2023, 艾超 wrote:

>     I'm sorry, receive a mail from  kernel test robot<lkp@intel.com> , that:
>
> > kernel test robot noticed the following build warnings:
> 
> > [auto build test WARNING on linus/master]
> > [also build test WARNING on v6.6]
> > [cannot apply to next-20231102]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.

I'm aware of those, which is why I fixed those /** -> /* while I applied 
your patch so that problem has already been taken care of!

> > If you fix the issue in a separate patch/commit (i.e. not just a new
> version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot
> > | Closes:
> https://lore.kernel.org/oe-kbuild-all/202311021547.KTmJVY2O-lkp@intel.com/
> 
>  
> 
> > All warnings (new ones prefixed by >>):
> 
> > >  drivers/platform/x86/inspur_platform_profile.c:27: warning: cannot
> understand function prototype: 'enum  inspur_tmp_profile '
> > drivers/platform/x86/inspur_platform_profile.c:74: warning: This comment
> starts with '/**', but isn't a kernel-doc comment. Refer
> Documentation/doc-guide/kernel-doc.rst
> > * Set Power Mode to EC RAM. If Power Mode value greater than 0x3,
> > drivers/platform/x86/inspur_platform_profile.c:123: warning: This comment
> starts with '/**', but isn't a kernel-doc comment. Refer
> Documentation/doc-guide/kernel-doc.rst
> >  * Get Power Mode from EC RAM, If Power Mode value greater than 0x3,
> 
> >  vim +27 drivers/platform/x86/inspur_platform_profile.c
> 
>  
> 
>  And I forget to add "Reported-by: kernel test robot" in this patch.

I know the message from lkp sounds like that (and it is slightly 
confusing) but it is to be added only when you're fixing code that has 
already made into a maintainer tree.

If one is submitting entirely new code and lkp finds and issue, one is not 
supposed to add that reported by even if the message tells you to do so. I 
hope this clears any confusion you might have about when it's needed.

-- 
 i.

> On Thu, 9 Nov 2023, Ai Chao wrote:
> 
> > Add support for Inspur platforms to used the platform profile feature.
> >
> > This will allow users to determine and control the platform modes
> > between low-power, balanced and performance modes.
> >
> > Signed-off-by: Ai Chao
> > ---
> >
> > v6: Remove comment for inspur_tmp_profile
> > v5: Rename inspur-wmi to inspur_platform_profile
> > v4: Add select ACPI_PLATFORM_PROFILE
> > v3: Remove input device, using the platform profile interface
> > v2: Remove Event GUID, remove inspur_wmi_notify and inspur_wmi_notify.
> 
> Hi,
> 
> I already took your v5 and it has since made also into Linus' tree.
> 
> If you want to make further changes to the driver, place them as
> incremental changes on top of what's already included, thank you.
> 
> --
> i.
> 
> 
> 
--8323329-215195145-1699622534=:1596--
