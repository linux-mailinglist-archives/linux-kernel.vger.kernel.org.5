Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 421D07DE007
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 12:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234116AbjKALCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 07:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjKALCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 07:02:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 780AF10C;
        Wed,  1 Nov 2023 04:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698836556; x=1730372556;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=he45rIbXb42Sm6DXp2Al9jchDSVbh17ZLLy0apFcu2Y=;
  b=bZoSreyFq9M3BXtdA6HZMDH/moW+Oq9iuGEuPBsC/Mrv91GfNAAnxSwq
   an3Zg/BnW72eM/cfbSYD2y3qIGYQQAzO3JCle+r+Ro7V8ZCTicwgZZofs
   GMhroMrwvf7UBKqwg2IVSbEcc+kn++yD0AjebmS6eIpfudiE5ewk3PEPr
   OGfvPxGFQPSu/UoLbtXope36YB5e/vaYGYQQfkJJ82H5O7Kh0HesLfRa/
   rG2kcoaRVQhxMWCC0g9U0ebKq7qq3NpfMD143rqvBTFm34JzZj7P6LJJn
   ffKTcCfJGd247untzd0EjRcUA3r1vTjyTcLMay73II8vsgdfw/U+13JBE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="368684077"
X-IronPort-AV: E=Sophos;i="6.03,268,1694761200"; 
   d="scan'208";a="368684077"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 04:02:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="760903972"
X-IronPort-AV: E=Sophos;i="6.03,268,1694761200"; 
   d="scan'208";a="760903972"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 04:02:33 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id 3888F1207A3;
        Wed,  1 Nov 2023 12:53:40 +0200 (EET)
Date:   Wed, 1 Nov 2023 10:53:40 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        Alain Volmat <alain.volmat@foss.st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] Revert "media: imx290: Convert to new CCI register
 access helpers"
Message-ID: <ZUIuNDTJAN_fz3q6@kekkonen.localdomain>
References: <20231101100900.224567-1-alexander.stein@ew.tq-group.com>
 <ZUIpEJmmdGTFdx09@kekkonen.localdomain>
 <c097e11b-8cec-1b04-141a-c8713bf56461@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c097e11b-8cec-1b04-141a-c8713bf56461@redhat.com>
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

On Wed, Nov 01, 2023 at 11:41:36AM +0100, Hans de Goede wrote:
> Hi,
> 
> On 11/1/23 11:31, Sakari Ailus wrote:
> > Hi Alexander,
> > 
> > On Wed, Nov 01, 2023 at 11:09:00AM +0100, Alexander Stein wrote:
> >> cci_write() unconditionally writes multi-byte data in big-endian format.
> >> But IMX290 and IMX327 use little-endian format for multi-byte registers.
> >> Revert the CCI usage until little-endian is supported by CCI register
> >> access helpers.
> >> This reverts commit af73323b97702e53b0a336972aaf23e7dd92c850.
> >>
> >> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> >> ---
> >> The difference is subtile, but imx290_write() uses put_unaligned_le24(),
> >> while cci_write() uses put_unaligned_be24().
> >>
> >> I assume this should go into stable as well. How to deal with that?
> >> Shall a revert get the fixes tag as well?
> > 
> > I'd very much prefer addressing this in v4l2-cci instead. It should also be
> > a much smaller patch (or patches).
> 
> I was under the impression the v4l2-cci conversion was already
> reverted because this breakage has been known for a while now.
> 
> Anyways, if someone wants to fix this directly this has been
> discussed in this thread:
> 
> https://lore.kernel.org/linux-media/20231030173637.GA2977515@gnbcxd0016.gnb.st.com/
> 
> and the consensus is that the best way to fix this is to
> add CCI_REG16_LE(x) CCI_REG24_LE(x), etc. macros to
> mirror the existing CCI_REG16(x), etc. macros.
> 
> The _LE macros would then look something like this:
> 
> #define CCI_REG_LE		BIT(20)
> 
> #define CCI_REG16_LE(x)                (CCI_REG_LE | (2 << CCI_REG_WIDTH_SHIFT) | (x))
> 
> etc.
> 
> And then the get_unaligned_beXX() and put_unaligned_beXX()
> calls in drivers/media/v4l2-core/v4l2-cci.c would need
> to be made conditional on a check for the CCI_REG_LE flag
> and if that flag is set use the _le_ versions of those
> functions instead.
> 
> The reason to go this way instead of a global LE flag
> somewhere is that some sensors have mixed endianness
> for different registers, so encoding this in the
> register-address high bits is the best solution.

Seems good to me.

> 
> Alexander, perhaps you can prepare 2 patches:
> 
> 1. Adding the discussed CCI_REGXX_LE(x) macros to v4l2-cci
> described above.
> 
> 2. Patch the imx290 code to use the _LE versions for the
> registers which are 2 or more bytes wide.
> 
> ?
> 
> Note I know that Alain (added to the Cc) from the thread
> linked above is also looking into implementing 1. 

-- 
Regards,

Sakari Ailus
