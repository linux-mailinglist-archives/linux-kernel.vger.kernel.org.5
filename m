Return-Path: <linux-kernel+bounces-127764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3D489509A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FD911F225C6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC275E060;
	Tue,  2 Apr 2024 10:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ruuw4q5b"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741F25D8EB;
	Tue,  2 Apr 2024 10:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712054667; cv=none; b=PR6WlRQhh05/vl/Tj/Apt9n1KBk1h32aQwTpel0AUxNcMEtROx8rDYIm0ZFSEhCwIW3F23kRgwbMj1kFcEF/wTxbFM1FPS5ij8EGg6LMIOUjh54a5cApQNylGFwpXePhMIdSh5xoJ+k+3VQ3e5nTtltN4iI/Yiuzr/YBcGnrGUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712054667; c=relaxed/simple;
	bh=XdiyO3QMFuwJYuIh4+gWB/Jf/gbm121Q5dupOJmCe58=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=FsmEUWnSFv9zYs1yOw7z2FsgwtFmu4AqFC0G8C8TqwGQJEghMN1Vs0jhfKXUqo42XGhkYaQpLq3boi9KRxYYvWUrxY4d4Ea1NBRLtaBIt+HZFdBaPgQfaM1gF3pkl5uWU77jOSiURqBW1ylEhmlZdUX4up/vba6cLBgZINKq4Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ruuw4q5b; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712054667; x=1743590667;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=XdiyO3QMFuwJYuIh4+gWB/Jf/gbm121Q5dupOJmCe58=;
  b=Ruuw4q5bzEN1A8rcjMLbsJ6sMGHEuHyOhdvSYdRZpB+SUevs5PdqP5vh
   MbvVuij5Z6qWYQtFHA2oa9Z8FFzZcqLX4fMGDgI5MT+P592Nw0sIyAxUI
   SbshJkiGN9zVH+oly55OFChPISGA0s/Pw5G/2DGzZ0yIimQ767vOHrfCO
   o60tUoQhPvzWPC5ImOvjPQ4tz48coqyirge1AH/NgilW3uPcafLaHDHAu
   dfvPZrJqyQk6ozz/vsqL5ZsaP1tWRyQX5UerqYioJyTdVYscXY66xU10g
   XdvaiGi712U/NaSBIS9RKCFrEYPB/3kjVpgtl93/QRdVABZ36wd/sTIU0
   w==;
X-CSE-ConnectionGUID: vB5RTDPaRFWrf8KrfChxlA==
X-CSE-MsgGUID: 4SCEEKA6SBiBL9fF2iBdig==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="11049222"
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; 
   d="scan'208";a="11049222"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 03:44:26 -0700
X-CSE-ConnectionGUID: EZamX/HmQj+9A7LOJlW8fQ==
X-CSE-MsgGUID: 1sGAsfLuRwWdBcSylYkKYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; 
   d="scan'208";a="22476458"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.23])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 03:44:23 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 2 Apr 2024 13:44:20 +0300 (EEST)
To: "Luke D. Jones" <luke@ljones.dev>
cc: Hans de Goede <hdegoede@redhat.com>, corentin.chary@gmail.com, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/9] platform/x86: asus-wmi: add support for Vivobook
 GPU MUX
In-Reply-To: <20240402022607.34625-3-luke@ljones.dev>
Message-ID: <2fb961af-258a-9c9c-531d-0bd4f0e70f37@linux.intel.com>
References: <20240402022607.34625-1-luke@ljones.dev> <20240402022607.34625-3-luke@ljones.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-275081869-1712054660=:1019"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-275081869-1712054660=:1019
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 2 Apr 2024, Luke D. Jones wrote:

> Add support for the Vivobook dgpu MUX available on the ASUS Viviobook
> and some of the other ranges (Zen).
>=20
> This MUX functions exactly the same as the existing ROG MUX support so
> the existing functionality now detects which MUX is available and uses
> that for control.
>=20
> Signed-off-by: Luke D. Jones <luke@ljones.dev>

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-275081869-1712054660=:1019--

