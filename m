Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 873FD7B8AB4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 20:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244483AbjJDSh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 14:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233552AbjJDSh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 14:37:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FEB6DD;
        Wed,  4 Oct 2023 11:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696444673; x=1727980673;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=DpVXv4bi27kbwhcFtKiltzdEWNLjeqF8vKmHb71bbO8=;
  b=LTQbCcyv84P+F5JBseUGtauxYe7ACRUL1641sO+cgY+taiTWED+oUd6r
   dlsN1pQ56Ff24MRXb5NTH0O3dGBwdpqHMAG1SHypagep0wKFI7q+0L00h
   lqWGzTGQIIkikQbakQpZhzSaNxbcK5WGGDusAZh3O+LdeusAxBMvelt+o
   fBO2PzoQOe4iPp/KvIKTYrCBiPwKQ8PJcWgUm0IpheyagQiG0oYuD7s0A
   0/q6GUB5IXNvlElx1JrNVSksmNbaDH5bdVPBbUNDlv96j8HoBByTHVv66
   Ksvc47LWxsh+Ih3wylVeBqT3gQMox9lUjvbFsoIZE2niFCSNUlwKsloLZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="386091281"
X-IronPort-AV: E=Sophos;i="6.03,201,1694761200"; 
   d="scan'208";a="386091281"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 11:37:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="745094397"
X-IronPort-AV: E=Sophos;i="6.03,201,1694761200"; 
   d="scan'208";a="745094397"
Received: from spandruv-desk1.amr.corp.intel.com ([10.209.86.10])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 11:37:52 -0700
Message-ID: <798686123b656dcd0907851160ea1a26506750d1.camel@linux.intel.com>
Subject: Re: [PATCH v2 1/3] platform/x86/intel/tpmi: Add defines to get
 version information
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     hdegoede@redhat.com, markgross@kernel.org,
        ilpo.jarvinen@linux.intel.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 04 Oct 2023 11:37:45 -0700
In-Reply-To: <ZR1hzZ4KNZqElGGH@smile.fi.intel.com>
References: <20231003184916.1860084-1-srinivas.pandruvada@linux.intel.com>
         <20231003184916.1860084-2-srinivas.pandruvada@linux.intel.com>
         <ZR1hzZ4KNZqElGGH@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-10-04 at 15:59 +0300, Andy Shevchenko wrote:
> On Tue, Oct 03, 2023 at 11:49:14AM -0700, Srinivas Pandruvada wrote:
> > Add defines to get major and minor version from a TPMI version
> > field
> > value. This will avoid code duplication to convert in every feature
> > driver. Also add define for invalid version field.
>=20
> ...
>=20
> > +#define TPMI_VERSION_INVALID=C2=A0=C2=A0=C2=A00xff
>=20
> I would make it clearer with (GENMASK(7, 5) | GENMASK(4, 0))
> or even with specific masks defined and used in both cases:
> #def
>=20
> #define TPMI_MINVER_MASK=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0G=
ENMASK(4, 0)
> #define TPMI_MAJVER_MASK=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0G=
ENMASK(7, 5)
>=20
> #define TPMI_VERSION_INVALID=C2=A0=C2=A0=C2=A0=C2=A0(TPMI_MINVER_MASK | T=
PMI_MAJVER_MASK)
>=20
> #define TPMI_MINOR_VERSION(val)=C2=A0FIELD_GET(TPMI_MINVER_MASK, val)
> #define TPMI_MAJOR_VERSION(val)=C2=A0FIELD_GET(TPMI_MAJVER_MASK, val)
>=20
> > +#define TPMI_MINOR_VERSION(val)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0FIELD_GET(GENMASK(4, 0),
> > val)
> > +#define TPMI_MAJOR_VERSION(val)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0FIELD_GET(GENMASK(7, 5),
> > val)

OK. Will add another patch on top.

Thanks,
Srinivas

>=20

