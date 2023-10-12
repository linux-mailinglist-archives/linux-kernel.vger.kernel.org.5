Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4C197C74E4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 19:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347474AbjJLRhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 13:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347378AbjJLRg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 13:36:56 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F92213E;
        Thu, 12 Oct 2023 10:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697131394; x=1728667394;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=xdt5/Au8+P8aciApF5KRE4r7URgA+4e3oS7ZjhG6eHQ=;
  b=jsrlDXhAGvrxqm1Z2KZnnF75f0L0CK/GNzCpv6s2oReCTU2GDH4/Q+AN
   0Wn8H3MdwxSsrh5bFgv/4GS65NqUKQNq7OW63/NPjNuWwljO72ncOlrmp
   ixHQEm2e7xfM6iUYs6hAot/odE5x0f7Q/6kM3J+4VDbFw81gnBm+BFaFh
   mHGn+dUEtoVo1H1bIuUVYMj0s5QEpG/NXojuvbcXDQl9qkIkLIH2CbF/c
   NoGtkhNeI15GQM6AeJ8S/MuVSXYoZVEDxRFhYqOvddhVE35m8radtHnAS
   ib3/4dePImn1PCOzmLXMvwZBgR8CVxSMHKPRVdGxsSV/QNKf5/BVvVKC8
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="365247170"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="365247170"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 10:23:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="870677425"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="870677425"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 10:23:13 -0700
Received: from [10.54.75.156] (debox1-desk1.jf.intel.com [10.54.75.156])
        by linux.intel.com (Postfix) with ESMTP id C355C580919;
        Thu, 12 Oct 2023 10:23:13 -0700 (PDT)
Message-ID: <6ed4cd5ae37a054d4780c8fa519dc83396b15c14.camel@linux.intel.com>
Subject: Re: [PATCH V3 03/16] platform/x86/intel/vsec: Use cleanup.h
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     kernel test robot <lkp@intel.com>, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, ilpo.jarvinen@linux.intel.com,
        rajvi.jingar@linux.intel.com
Cc:     oe-kbuild-all@lists.linux.dev
Date:   Thu, 12 Oct 2023 10:23:13 -0700
In-Reply-To: <202310121314.3Xpqom2w-lkp@intel.com>
References: <20231012023840.3845703-4-david.e.box@linux.intel.com>
         <202310121314.3Xpqom2w-lkp@intel.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-10-12 at 13:25 +0800, kernel test robot wrote:
> Hi David,
>=20
> kernel test robot noticed the following build warnings:
>=20
> [auto build test WARNING on acce85a7dd28eac3858d44230f4c65985d0f271c]
>=20
> url:=C2=A0=C2=A0=C2=A0
> https://github.com/intel-lab-lkp/linux/commits/David-E-Box/platform-x86-i=
ntel-vsec-Move-structures-to-header/20231012-104217
> base:=C2=A0=C2=A0 acce85a7dd28eac3858d44230f4c65985d0f271c
> patch link:=C2=A0=C2=A0=C2=A0
> https://lore.kernel.org/r/20231012023840.3845703-4-david.e.box%40linux.in=
tel.com
> patch subject: [PATCH V3 03/16] platform/x86/intel/vsec: Use cleanup.h
> reproduce:
> (https://download.01.org/0day-ci/archive/20231012/202310121314.3Xpqom2w-l=
kp@in
> tel.com/reproduce)
>=20
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion
> of
> the same patch/commit), kindly add following tags
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes:
> > https://lore.kernel.org/oe-kbuild-all/202310121314.3Xpqom2w-lkp@intel.c=
om/
>=20
> # many are suggestions rather than must-fix
>=20
> ERROR:SPACING: need consistent spacing around '*' (ctx:WxV)
> #31: FILE: drivers/platform/x86/intel/vsec.c:159:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct intel_vsec_device __fre=
e(kfree) *intel_vsec_dev =3D NULL;

These looks like false positives.

David

> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^
>=20

