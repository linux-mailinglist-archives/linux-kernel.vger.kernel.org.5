Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 998D57B54A1
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 16:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237585AbjJBNzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 09:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237580AbjJBNzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 09:55:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2636FC9;
        Mon,  2 Oct 2023 06:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696254897; x=1727790897;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=tx1tgOGb+obkh2wNcFVuCCVF7/4FoKjjpzWkyz9vmJ4=;
  b=IwK0sZXWGwwoxVZ3nI26Q/M7dv+K0mTknYFenmrP8OkhNihCDCmsFMBZ
   WjLtBlwzec9IpjnASvOL0XNu6XcPcSHQxqmCQVDecgTgs7unBGrYcm8LZ
   Z5oTNK4AOgCUB15fMISmMXStJYEm02b3AFhq+iUcMUnQOV4R6Yld3J+DD
   OjYTAqcY5YUbM7oEprCTOjyKWDu/rhu9BEdgqsQzMfsJBm6dRGUSUv82R
   AMJJ3f0qy3pMMaFebbKhV/XO7AGiwFRKShyyKw1bkiMv3fvab/YDx+UB8
   kSr5843CAHSDvS41sJw1uj0qmrHmA87G4Rs6Q5PRxOJ4w5FlWkcksYtZp
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="372995311"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="372995311"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 06:54:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="924280877"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="924280877"
Received: from spandruv-desk.jf.intel.com (HELO spandruv-desk.amr.corp.intel.com) ([10.54.75.14])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 06:54:56 -0700
Message-ID: <daa44585c4a57b8823cb260d9ec9bd3f59f410c6.camel@linux.intel.com>
Subject: Re: [PATCH 2/3] platform/x86: ISST : Check major minor version
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, markgross@kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        platform-driver-x86@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Date:   Mon, 02 Oct 2023 06:54:56 -0700
In-Reply-To: <45625e9e-997b-eba1-413a-43a7d835feb@linux.intel.com>
References: <20230925194338.966639-1-srinivas.pandruvada@linux.intel.com>
         <20230925194338.966639-3-srinivas.pandruvada@linux.intel.com>
         <f82fcfc9-eb41-56cb-93e1-abf9cf7413@linux.intel.com>
         <72a2766bc7bb4f9d6b3d5f2ff114f0af1b6646a4.camel@linux.intel.com>
         <45625e9e-997b-eba1-413a-43a7d835feb@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-3.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-10-02 at 16:49 +0300, Ilpo J=C3=A4rvinen wrote:
> On Sat, 30 Sep 2023, srinivas pandruvada wrote:
>=20
> > On Fri, 2023-09-29 at 17:28 +0300, Ilpo J=C3=A4rvinen wrote:
> > > On Mon, 25 Sep 2023, Srinivas Pandruvada wrote:
> > >=20
> > > > Parse major and minor version number from the version field. If
> > > > there
> > > > is a mismatch for major version, exit from further processing
> > > > for
> > > > that
> > > > domain.
> > > >=20
> > > > If there is mismatch in minor version, driver continue to
> > > > process
> > > > with
> > > > an error message.
> > >=20
> > > This sentence sounds odd.
> > What is the suggestion here?
>=20
> These things sound wrong: It should be "continues"
OK

>  but I also find "to=20
> process" odd when lacking what it processes.

Further processing means, whatever this driver is supposed to do. You
don't want to fully explain again what this driver is doing.


>=20

