Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C27417DCE93
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 15:03:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344723AbjJaOA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 10:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344758AbjJaOAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 10:00:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B308F1;
        Tue, 31 Oct 2023 07:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698760822; x=1730296822;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=BZtdB+YuiWI031gK4fsYrU57cmwezQDYcGMWaSImpTU=;
  b=je0ejQ5oa1KDqOEztqIuSngaEFfvBGjwWQ6KXMkj/HBoLmN/r+dXWNWv
   7/paRUdBiDf4tzGOhvociuI5DxcBE+TVR7oZshB+hxWeppz42AHF0GMSv
   zDBtmI7XJi10UsqsobkcAuOljHiqTcjYbWdrhpEghIKlYFWuEsbhZQAOl
   6XkRAhAW8qJIFYvKtpkhPsXQkkQDo5u4LimJiRkG+dOms6Pvv3zr/vcac
   MzYt2vIqgjuJcdRVw9Wn1PiqKIHOr9EEVV1GpLzJhOT5EY7aTTdOyDp23
   sGsQz/gbvSPOFhv2EQj8KBpR7gy6mupfOLgZCWt/w2stQQ5QnQ7Ed9oLN
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="373341782"
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="scan'208";a="373341782"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2023 07:00:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="934118568"
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="scan'208";a="934118568"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2023 07:00:18 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
        by kekkonen.fi.intel.com (Postfix) with ESMTP id 9A8DB12033A;
        Tue, 31 Oct 2023 16:00:15 +0200 (EET)
Date:   Tue, 31 Oct 2023 14:00:15 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 5/6] ACPI: scan: Extract MIPI DiSco for Imaging data
 into swnodes
Message-ID: <ZUEIb81Bbzgvf2Uf@kekkonen.localdomain>
References: <2187487.irdbgypaU6@kreacher>
 <7609686.EvYhyI6sBW@kreacher>
 <ZUDBnEJ41tc7nnka@kekkonen.localdomain>
 <CAJZ5v0j_Uv=qVo6eFdz-Q7Ne7W7aTf9ThN128Ust+YEQQ9Gy+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0j_Uv=qVo6eFdz-Q7Ne7W7aTf9ThN128Ust+YEQQ9Gy+Q@mail.gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

On Tue, Oct 31, 2023 at 02:46:51PM +0100, Rafael J. Wysocki wrote:
> Hi Sakari,
> 
> On Tue, Oct 31, 2023 at 11:33 AM Sakari Ailus
> <sakari.ailus@linux.intel.com> wrote:
> >
> > Hi Rafael,
> >
> > On subject:
> >
> > s/DiSco/DisCo/
> 
> Huh
> 
> Thanks for catching this!
> 
> > On Fri, Oct 20, 2023 at 04:39:27PM +0200, Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > Add information extracted from the MIPI DiSco for Imaging device
> >
> > Ditto.
> >
> > > properties to software nodes created during the CSI-2 connection graph
> > > discovery.
> > >
> > > Link: https://www.mipi.org/specifications/mipi-di
> >
> > This URL is broken. The correct URL is:
> >
> >         https://www.mipi.org/specifications/mipi-disco-imaging
> 
> OK
> 
> > > Co-developed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > ---
> > >  drivers/acpi/internal.h |    1
> > >  drivers/acpi/mipi-di.c  |  240 +++++++++++++++++++++++++++++++++++++++++++++++-
> >
> > How about mipi-disco.c? I wouldn't mind having mipi-disco-imaging.c either.
> 
> Well, mipi-disco-imaging is a bit too long and the meaning of
> mipi-disco would not be clear IMO.
> 
> What about mipi-disco-img?

Seems fine to me.

> 
> [cut]
> 
> > > +     ret = fwnode_property_count_u8(port_fwnode, "mipi-img-lane-polarities");
> > > +     if (ret > 0) {
> > > +             unsigned long mask;
> > > +             unsigned int i;
> > > +
> > > +             /*
> > > +              * Total number of lanes here is clock lane + data lanes.
> > > +              * Require that number to be low enough so they all can be
> > > +              * covered by the bits in one byte.
> > > +              */
> > > +             BUILD_BUG_ON(BITS_PER_TYPE(u8) <= ARRAY_SIZE(port->data_lanes));
> > > +
> > > +             fwnode_property_read_u8_array(port_fwnode,
> > > +                                           "mipi-img-lane-polarities",
> > > +                                           val, 1);
> > > +
> > > +             for (mask = val[0], i = 0; i < num_lanes + 1; i++)
> > > +                     port->lane_polarities[i] = test_bit(i, &mask);
> >
> > This works only up to seven lanes.
> 
> True, but then ACPI_DEVICE_CSI2_DATA_LANES is defined as 4.

The spec has no limit and in practice 4 is relatively common while 8 exists
(but is somewhat rare). I actually think it'd be a good idea to bump this
to 8 already.

-- 
Regards,

Sakari Ailus
