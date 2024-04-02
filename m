Return-Path: <linux-kernel+bounces-127817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98EA6895156
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAAAE1C235DA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 11:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7DC5A4C7;
	Tue,  2 Apr 2024 11:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Txk5E87x"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0D37A158;
	Tue,  2 Apr 2024 11:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712055754; cv=none; b=fiJjTqeBrScV6QtYjyi0tdiKHab0vojqJcrjxTpSfupB4W2lG01GxXHmZD5ieRhfHmXmdmJJQ0WnAIAnSvBzxzCg4PxemZjBfo4Kmp+wxTTj6OrsyHuzkqy/p0+JfZTCdZon6i+bA4y3BBHpRnng6k9KCUHHr9Z2ZQYbcVPNzio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712055754; c=relaxed/simple;
	bh=GSHFNZ7BdPWI45v3yJSbYZk9VzkKgh/McsNWC1kZ4Ps=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=JYRcxObnC+YCqTxY9OvSKiWuMcnOIBNJAvlXvd9TsgWIL1jxhUgSdjaZjQy7JaY14qCVFSLsa6G8STyAskgKoXP9yuJlKPRExoLOij/3CuG/qtIBZiUTSoFlnK8wgWLvJjU3DMIo0qLzaUwVQHB0gcF2F9BLByqSZGNaqpqrERA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Txk5E87x; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712055753; x=1743591753;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=GSHFNZ7BdPWI45v3yJSbYZk9VzkKgh/McsNWC1kZ4Ps=;
  b=Txk5E87xIzHOeIGH6ZlcIsYnY8Ii/UHIsWZGkZX9Ewv6RiUkEq4nwSoA
   iQC/FhNjHkC7LuBDeQUSKUw8rRtqEY8Bb652X8faPWF4Cws4wWS+lxRp+
   71EufQVrapYlDA2aDPVTetcPyd8vGEO+BhgfeOjskR3Qu/2CitgE+9cRs
   TgnxUiw0634wrVu3ZS/HwxDeoAPXUM2Q7kT8cJJ+m6Wm7PGDPQkuvMHWI
   R+jB6vnhUPvDw8Y/B2gb8lBItPC1qDeOdbl11bUR4UObBBjQUN62e6Lwc
   +KPB5L8QQD4CPIYXBz6WT22gIOpNxqk3O71/bC2x8wDVrv61Vge/LdHdd
   Q==;
X-CSE-ConnectionGUID: HqJd96KCRYG7KEsF3v+oSA==
X-CSE-MsgGUID: fGTSKED4RMiTIW4ehs0UTg==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="7347352"
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; 
   d="scan'208";a="7347352"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 04:02:32 -0700
X-CSE-ConnectionGUID: 0l7luqtsSq+ZvK7MQkQZ2g==
X-CSE-MsgGUID: Y+bO5XtMSfaUEY2Is6Ef4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; 
   d="scan'208";a="55480037"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.23])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 04:02:31 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 2 Apr 2024 14:02:27 +0300 (EEST)
To: "Luke D. Jones" <luke@ljones.dev>
cc: Hans de Goede <hdegoede@redhat.com>, corentin.chary@gmail.com, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 9/9] platform/x86: asus-wmi: cleanup main struct to
 avoid some holes
In-Reply-To: <20240402022607.34625-10-luke@ljones.dev>
Message-ID: <f4d93da8-cbf0-a4f0-fe4c-45b32c23be75@linux.intel.com>
References: <20240402022607.34625-1-luke@ljones.dev> <20240402022607.34625-10-luke@ljones.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-121875101-1712055747=:1019"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-121875101-1712055747=:1019
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 2 Apr 2024, Luke D. Jones wrote:

> Reorganises some attr-available calls to remove a few unrequired
> booleans in the main driver struct which combined with some
> reorganisation prevents a series of large holes seen with pahole.
>=20
> Signed-off-by: Luke D. Jones <luke@ljones.dev>

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-121875101-1712055747=:1019--

