Return-Path: <linux-kernel+bounces-5027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD139818585
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 11:47:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38F4AB21765
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 10:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7073E15AC0;
	Tue, 19 Dec 2023 10:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VlOeb6q7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F560156EC;
	Tue, 19 Dec 2023 10:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702982806; x=1734518806;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=huJKnFT1fUWL+Xrruc9EYHcavn2dIZ966k3dBgI5pJQ=;
  b=VlOeb6q79L1faf18Txt5b1xHvYBV7xB62WlgDIUKSRzBdZHFIHH67SrE
   PFI5IwpyjN9FxQiZpoVTx/4Iy5H+hzawQHyI3WgDemmjAPQkDWez0YsCB
   hrjxJ2DzAUykTLYxeo8LQZL0nOj8+/IjOgwve5CELYyBRmkk6fBcmF3QY
   /myxC/k3WD7y2xpdHnpejYL6hlLRwXMcPelxtqYHdmEKf6oVwZIq0sOZW
   zeDHxLPs3UfnHdsde8zRKNE0AhNb1ujyigihAXhiC/4nvJb+eNJgfRY+D
   D58gM0WJ1MpgXJY+rg4RHFlpHVCwb+yfxvwReJRyrmPxuQs90gn21+6gA
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="386064409"
X-IronPort-AV: E=Sophos;i="6.04,288,1695711600"; 
   d="scan'208";a="386064409"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 02:46:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="725692427"
X-IronPort-AV: E=Sophos;i="6.04,288,1695711600"; 
   d="scan'208";a="725692427"
Received: from mtkaczyk-mobl.ger.corp.intel.com (HELO localhost) ([10.237.142.133])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 02:46:43 -0800
Date: Tue, 19 Dec 2023 11:46:39 +0100
From: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
To: Song Liu <song@kernel.org>
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, Paul E Luse <paul.e.luse@linux.intel.com>
Subject: Re: [PATCH 0/3] md: Remove deprecated flavors
Message-ID: <20231219114639.0000689d@linux.intel.com>
In-Reply-To: <CAPhsuW7w7WbWePpQd4aqnvXHwbdEJzw9efEP_r6tJwpeg0_qLw@mail.gmail.com>
References: <20231214222107.2016042-1-song@kernel.org>
	<20231215125059.00006270@linux.intel.com>
	<CAPhsuW6GZnufqFseLvgpMrrX6qRXodX1n89vEbbC-FqTjsWPDg@mail.gmail.com>
	<20231218093201.000020dd@linux.intel.com>
	<CAPhsuW7w7WbWePpQd4aqnvXHwbdEJzw9efEP_r6tJwpeg0_qLw@mail.gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 18 Dec 2023 08:11:53 -0800
Song Liu <song@kernel.org> wrote:

> Hi Mariusz,
>=20
> On Mon, Dec 18, 2023 at 12:32=E2=80=AFAM Mariusz Tkaczyk
> <mariusz.tkaczyk@linux.intel.com> wrote:
> > =20
> [...]
> > > >
> > > > Please note that there are mdadm tests for those levels. I can appr=
ove
> > > > it only when mdadm clean-up is merged. Our tests must pass
> > > > continuously. =20
> > >
> > > Is the continuous test result available publicly? =20
> >
> > We are working on public CI (Paul owns it). On my side I'm not executin=
g all
> > tests, IMSM only. In this case it is obvious that mdadm tests will stop
> > passing, I don't need results to see that. We should keep both mdadm an=
d md
> > compatible. We are continuously adding new MD regression tests to mdadm=
 (at
> > least Kuai is doing that) so we should also care about removing things.
> > =20
> > > =20
> > > >
> > > > It is a nice code complexity improvement so let me know if you would
> > > > like to get my help with mdadm patches. =20
> > >
> > > On my local tests with mdadm, I need to make changes to the following
> > > tests:
> > >
> > > 00linear...
> > > 00names...
> > > 00raid0...
> > > 00readonly...
> > > 02lineargrow...
> > > 03r0assem...
> > > 04r0update...
> > > 04update-metadata...
> > >
> > > The changes are all straightforward (just remove things related to
> > > linear/multipath/faulty).
> > > =20
> >
> > Please do not forgot remove dead code from mdadm. For example simple fi=
nd
> > "multipath" (case insensitive) reefers me to multiple places with speci=
al
> > handling for this level. We need to remove it from code and documentati=
on.
> > Can you handle this too? =20
>=20
> I think this is a bigger discussion: will mdadm stop supporting these
> flavors on
> older kernels? Say, mdadm-5.0+ (or a different number) will not support
> multipath flavor on older kernels?
>=20

Good point, I forgot that we are keeping backward compatibility with old
kernels. Currently 3.10 is the lowest one supported so agree, we need to ke=
ep
this code. Thanks for clarifying!

> >
> > Oh and last one, I can't find update for md man in your changes. Could =
you
> > please remove those levels from md man? =20
>=20
> man side is easier. Once we know which major will have this set (6.8 or
> later), we can update the man pages with the information.

Understood!

No further questions, please just remove tests and eventually add warning w=
hen
creating those levels in mdadm i.e "Linear/Multipath/Faulty are deprecated =
and
will be removed in next releases".

Thanks,
Mariusz

