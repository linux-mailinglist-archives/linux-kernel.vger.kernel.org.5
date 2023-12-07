Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1528C8091FD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 20:59:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233081AbjLGT7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 14:59:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjLGT7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 14:59:38 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F1410EF;
        Thu,  7 Dec 2023 11:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701979185; x=1733515185;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=kySfWtvu+dSPcwXer3wIupFJdUPFKblbUaSVoORb70Q=;
  b=Dvw6tfCg1HbCoA7YHTR9030Ij/guFpUzHRxRNoPHev8ERR1msJBY8GGI
   ms6xI0KPWozSuW0qONAWMby0smFMIV8MGqicNqsNeWwEwTc4rIbmS9mgM
   anOwJL5Qsf+UMNA/0DYj/QNEdKpHni1C2UkwrkkLJNGv7TlX/m697NxpX
   ev6dGy4OdxVI6IrXAlhabJq6OdSKm0J6MLZ6O7lj8COh/DqrbVWcAa/rs
   Q+owQ0HY6ll4ui9YdZWyECUUmkqhyPIDMc1k2C1C8y1gQq6a5QhSqORPW
   3bKvWjEnxgy7LrEa0KBjdqu221nwzhR6oBAPXIBS2jIXOhsKUj/a2g7a0
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="1163579"
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="1163579"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 11:59:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="945166057"
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="945166057"
Received: from barinat-mobl1.amr.corp.intel.com ([10.213.188.213])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 11:59:41 -0800
Message-ID: <ae9e4984a50842e056363cbae73ea01a745aebb6.camel@linux.intel.com>
Subject: Re: [PATCH v12 13/14] crypto: iaa - Add IAA Compression Accelerator
 stats
From:   Tom Zanussi <tom.zanussi@linux.intel.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        fenghua.yu@intel.com, vkoul@kernel.org
Cc:     dave.jiang@intel.com, tony.luck@intel.com,
        wajdi.k.feghali@intel.com, james.guilford@intel.com,
        kanchana.p.sridhar@intel.com, vinodh.gopal@intel.com,
        giovanni.cabiddu@intel.com, pavel@ucw.cz,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        dmaengine@vger.kernel.org
Date:   Thu, 07 Dec 2023 13:59:39 -0600
In-Reply-To: <4f53df8e-0957-44b6-b18e-e4362800e180@wanadoo.fr>
References: <20231205212530.285671-1-tom.zanussi@linux.intel.com>
         <20231205212530.285671-14-tom.zanussi@linux.intel.com>
         <4f53df8e-0957-44b6-b18e-e4362800e180@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

On Thu, 2023-12-07 at 07:22 +0100, Christophe JAILLET wrote:
> Le 05/12/2023 =C3=A0 22:25, Tom Zanussi a =C3=A9crit=C2=A0:
> > Add support for optional debugfs statistics support for the IAA
> > Compression Accelerator.=C2=A0 This is enabled by the kernel config
> > item:
> >=20
> > =C2=A0=C2=A0 CRYPTO_DEV_IAA_CRYPTO_STATS
> >=20
> > When enabled, the IAA crypto driver will generate statistics which
> > can
> > be accessed at /sys/kernel/debug/iaa-crypto/.
> >=20
> > See Documentation/driver-api/crypto/iax/iax-crypto.rst for details.
> >=20
> > Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> > ---
>=20
> > +void update_max_adecomp_delay_ns(u64 start_time_ns)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u64 time_diff;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0time_diff =3D ktime_get_ns()=
 - start_time_ns;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (time_diff > max_adecomp_=
delay_ns)
> > +
>=20
> Nit: unneeded NL.
>=20

Good eye, thanks for pointing it out.

Tom

> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0max_adecomp_delay_ns =3D time_diff;
> > +}
>=20
> CJ

