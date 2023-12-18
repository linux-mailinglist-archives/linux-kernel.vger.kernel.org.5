Return-Path: <linux-kernel+bounces-3160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 498DE816810
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 09:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9BB91F22E32
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 08:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359F310786;
	Mon, 18 Dec 2023 08:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZURJpj5n"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F20910A29;
	Mon, 18 Dec 2023 08:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702888328; x=1734424328;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t6/Sw1KsGXTBaJiPRn+9IUbFxEcnyk7++tLcplOnYZw=;
  b=ZURJpj5nim8NNOWAaRNk2vBvhHR6f1Um0mnaG0arLuCLkpecQsd8qHD9
   gcH1OohMoUHjDd3wysPUbb194/lixc1clvu3R0V+1lEQvS7jaE/yZiqBx
   2WM1RrVoqgTtqj9f4mdp7zejBJFkT1u3+4STQiFLDQoOwVtXj8mzThyM3
   0qvW4JmSBj8XRMmrBxtZoCyK48wXp7kEwEochQJ995vMA776hJj9NGQM3
   kerIJyJ6Z1Art42WwMWY8rA6zZlt/1RTwCaIT21YKCPNBww3oYBt+aYua
   O1fYbOvp4L9hk5pfrCBcbW6z1EHqLSQ4S3scAxBmvdZWTXGPJ4WD9XtUe
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="8834708"
X-IronPort-AV: E=Sophos;i="6.04,284,1695711600"; 
   d="scan'208";a="8834708"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 00:32:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="809732739"
X-IronPort-AV: E=Sophos;i="6.04,284,1695711600"; 
   d="scan'208";a="809732739"
Received: from mtkaczyk-mobl.ger.corp.intel.com (HELO localhost) ([10.237.142.76])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 00:32:05 -0800
Date: Mon, 18 Dec 2023 09:32:01 +0100
From: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
To: Song Liu <song@kernel.org>
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, Paul E Luse <paul.e.luse@linux.intel.com>
Subject: Re: [PATCH 0/3] md: Remove deprecated flavors
Message-ID: <20231218093201.000020dd@linux.intel.com>
In-Reply-To: <CAPhsuW6GZnufqFseLvgpMrrX6qRXodX1n89vEbbC-FqTjsWPDg@mail.gmail.com>
References: <20231214222107.2016042-1-song@kernel.org>
	<20231215125059.00006270@linux.intel.com>
	<CAPhsuW6GZnufqFseLvgpMrrX6qRXodX1n89vEbbC-FqTjsWPDg@mail.gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 15 Dec 2023 07:37:54 -0800
Song Liu <song@kernel.org> wrote:

> Hi Mariusz,
>=20
> On Fri, Dec 15, 2023 at 3:51=E2=80=AFAM Mariusz Tkaczyk
> <mariusz.tkaczyk@linux.intel.com> wrote:
> >
> > On Thu, 14 Dec 2023 14:21:04 -0800
> > Song Liu <song@kernel.org> wrote:
> > =20
> > > Linear, multipath, and faulty have been marked as deprecated for 2.5
> > > years. Let's remove them.
> > >
> > > Thanks,
> > > Song =20
> >
> > Hi Song,
> > Great idea!
> >
> > Please note that there are mdadm tests for those levels. I can approve =
it
> > only when mdadm clean-up is merged. Our tests must pass continuously. =
=20
>=20
> Is the continuous test result available publicly?

We are working on public CI (Paul owns it). On my side I'm not executing all
tests, IMSM only. In this case it is obvious that mdadm tests will stop pas=
sing,
I don't need results to see that. We should keep both mdadm and md compatib=
le.
We are continuously adding new MD regression tests to mdadm (at least Kuai =
is
doing that) so we should also care about removing things.

>=20
> >
> > It is a nice code complexity improvement so let me know if you would
> > like to get my help with mdadm patches. =20
>=20
> On my local tests with mdadm, I need to make changes to the following
> tests:
>=20
> 00linear...
> 00names...
> 00raid0...
> 00readonly...
> 02lineargrow...
> 03r0assem...
> 04r0update...
> 04update-metadata...
>=20
> The changes are all straightforward (just remove things related to
> linear/multipath/faulty).
>=20

Please do not forgot remove dead code from mdadm. For example simple find
"multipath" (case insensitive) reefers me to multiple places with special
handling for this level. We need to remove it from code and documentation.
Can you handle this too?

Oh and last one, I can't find update for md man in your changes. Could you
please remove those levels from md man?

Thanks,
Mariusz

