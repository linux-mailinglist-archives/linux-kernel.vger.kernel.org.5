Return-Path: <linux-kernel+bounces-160565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C528B3F34
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 20:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4C811C23652
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 18:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A25AD16E88D;
	Fri, 26 Apr 2024 18:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EXPh+BUY"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398AA168B07;
	Fri, 26 Apr 2024 18:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714155900; cv=none; b=ixUHTgeqtJWERZ/D8ufH8e0i/j+o41KNZb2RU5jZE8E4xYMs68xg9mMSKbqoY7YxcEVKNLyIEz5U1DD4fc+hk6yUHUOdCVRURDxZTI3uIxCLvHom4MwFbMhAUOqlwClGygK8XUT4hnMpLBFpCiLaQyrp24ZOjyCY69Yyn2T4FuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714155900; c=relaxed/simple;
	bh=sfP0FZWu3Bt16APUt0t1Jmo4J8A7H7v0Tff2WrGiTPI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u4wA3rngaRHfVtMnvcEpt9RtQeBOQiWGtK1RqNnaQU58qnEzoUPJaKXAVhx92KvG15eEt5rWzv7yAN5ABl9BncaFGKlOxAzqrHNbFu+qgJqTGAHgVPtm1HeSrpqN/JFBpyrLSWzWIJ5k53Rqej0EAZV1t+BdHcCCUjNTRO+t//Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EXPh+BUY; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714155899; x=1745691899;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=sfP0FZWu3Bt16APUt0t1Jmo4J8A7H7v0Tff2WrGiTPI=;
  b=EXPh+BUY6VaMnuOOgRo/QbEHCGs9Uxwn2HSD48WBwRy1SAW5LiJOxCPt
   JQpgOMsmlYFOtat/LVpMU8P2TxIM2gMPBRYaJnT3Y7x6eZAbi4YVzdXcV
   6BB8mWcWWab2hLXYfWbpdciAwzQnW8WvUhBCH9IctjF5pc/cV+ejRzKBP
   AVcvDiquvpic9YpsGrPLFtwPlrrBFNOp7/vEleG7Hpf2Kf24/nEtyGa0c
   PR/Hr7HBU/BjBBnaZcLV0ar6PylqGJdIv9Em8+ceflfZuZslntcdZGMbc
   WH9EsamdVZNufIxX2shR9XFO56iaFGczqTtdb7x2IHZKUKcREI+gTbbms
   w==;
X-CSE-ConnectionGUID: wBG0zcVfSLG30j7M02tC1A==
X-CSE-MsgGUID: zdMjb4h+Rm2a5Gv7T4BDqg==
X-IronPort-AV: E=McAfee;i="6600,9927,11056"; a="13692135"
X-IronPort-AV: E=Sophos;i="6.07,233,1708416000"; 
   d="scan'208";a="13692135"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 11:24:58 -0700
X-CSE-ConnectionGUID: r3xm3ZW5Tp2nGwr+ANCaFQ==
X-CSE-MsgGUID: iqEhBLhPTi67jN2gMisjeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,233,1708416000"; 
   d="scan'208";a="56667694"
Received: from mmccuske-mobl2.amr.corp.intel.com (HELO spandruv-desk1.amr.corp.intel.com) ([10.212.240.40])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 11:24:58 -0700
Message-ID: <ff583df9124b3f12a129269b0c63249a227e5c18.camel@linux.intel.com>
Subject: Re: [PATCH] platform/x86: dell-laptop: Implement platform_profile
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Lyndon Sanche <lsanche@lyndeno.ca>
Cc: Mario Limonciello <mario.limonciello@amd.com>, Matthew Garrett
 <mjg59@srcf.ucam.org>, Pali =?ISO-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
 Hans de Goede <hdegoede@redhat.com>, Ilpo =?ISO-8859-1?Q?J=E4rvinen?=
 <ilpo.jarvinen@linux.intel.com>,  platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org,  Dell.Client.Kernel@dell.com
Date: Fri, 26 Apr 2024 11:24:57 -0700
In-Reply-To: <N2BKCS.UBBG0H0KMCYF2@lyndeno.ca>
References: <20240425172758.67831-1-lsanche@lyndeno.ca>
	 <a6009bed-aa34-4a3f-91f5-23937e915132@amd.com>
	 <24c7a9ea-7755-4270-a338-4701c8e262e2@app.fastmail.com>
	 <13fe0f7c7da2cb6ce52ec34d4648e90e40f2fbc0.camel@linux.intel.com>
	 <N2BKCS.UBBG0H0KMCYF2@lyndeno.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-04-26 at 12:23 -0600, Lyndon Sanche wrote:
>=20
>=20
> On Fri, Apr 26 2024 at 09:14:07 AM -07:00:00, srinivas pandruvada=20
> <srinivas.pandruvada@linux.intel.com> wrote:
> > > Can you share output of acpidump tool to me? I want to make sure
> > > if
> > there is some way the platform will bypass thermal table if you=20
> > changed
> > to some profile.
> >=20
> > Thanks,
> > Srinivas
>=20
> Hello Srinivas:
>=20
> I used acpidump. For sake of completeness I ran acpidump with each of
> the thermal modes enabled. The files are too large to provide here so
> I=20
> uploaded them to a public gist:
> https://gist.github.com/Lyndeno/65ade5a15f1f2cd07175256dc021f551
>=20
> Please let me know if there is a more appropriate medium for sharing=20
> files like this, and I will remember for next time.

This is fine. Thanks for uploading.

-Srinivas

>=20
> Thank you,
>=20
> Lyndon
>=20
>=20


