Return-Path: <linux-kernel+bounces-156277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F0D8B00A8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 06:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5ACBEB2278C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 04:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29892153823;
	Wed, 24 Apr 2024 04:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="c1QULi3p"
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C158585C59;
	Wed, 24 Apr 2024 04:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713934035; cv=none; b=O4BLNKuAv6aYnK11FX4NoYSVQwjCnZWgxxC7li+4/ZNBpxjUxfbECVCQE+0QBIm1jZzvNs3rN7/P/V9SEa9dJkgY8GP+tiPgpD21XeftP/b6N2G5Sx9AFjNgl6vF8RAMxCk/wo9pg8AbMCz3coJ2HydIXU9nejLL8aj6NySybDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713934035; c=relaxed/simple;
	bh=TBvnoEQcxOobd66GRpTkzGK29Z7TtnC7+5EEfw7++Mg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AnmWAkLpH7wBLiqYqnpRNdRvZ2z3L1C61GvUaiWExQDoghYxUkQF8mK/qVHIk4NPJGAO/chyMEnDeIJ3nSsGWZsHxAB9VBOcp3BjjGZCrCbyF5qjcJMyU4KOetwz6AWB5KDmW1acYVtOBTeuElSfnZh+Dy6ryB/dKWBCsiAIShw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=c1QULi3p; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=U49s6lS0kYZ2hBt5Nhxm/gouRaxZ/KmWkJlxsY0WEWg=; t=1713934031; x=1714538831; 
	b=c1QULi3pSQHQfSWq9YFadNvxdObC/6pw6y4spKpqfPmod9f130xXPQZ9mQEPTeEC64KhZha/Mem
	8fuZPVHwEveIuNodpnVNQL0Z+Hlpuqbu65LAkYfp2CC74f/deqV5A4G1XQuXCXui2lrmS2/e8p8GK
	wAk4TYF9ypI52S92ZPODKLGJSPp3aS+A8kQx+neKq1w0xYY6aEST8kyVM20VHhAq2y7SiZseIEVq3
	EBsIUYVso8pTiZLKky0HCxd1U/TrJqzB7AjXIDhGCAjIPnl9NZlPCJREtdOGm3Fk+OWoHVvUNB8FU
	8XcnM19PLGOWGBJBKW20Z3pC0EE/z5FO0cSw==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.97)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1rzUX8-000000025fm-1akv; Wed, 24 Apr 2024 06:47:02 +0200
Received: from [80.95.105.245] (helo=[172.16.2.143])
          by inpost2.zedat.fu-berlin.de (Exim 4.97)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1rzUX8-00000000iLK-0eEo; Wed, 24 Apr 2024 06:47:02 +0200
Message-ID: <ef14ac524b205037303afb3ca04b6456f6709c13.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v2] sh: Call paging_init() earlier in the init sequence
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Oreoluwa Babatunde <quic_obabatun@quicinc.com>, 
	ysato@users.sourceforge.jp, dalias@libc.org
Cc: akpm@linux-foundation.org, linux-sh@vger.kernel.org, 
 linux-kernel@vger.kernel.org, robh+dt@kernel.org, kernel@quicinc.com, Rob
 Herring <robh@kernel.org>
Date: Wed, 24 Apr 2024 06:47:01 +0200
In-Reply-To: <20240423233150.74302-1-quic_obabatun@quicinc.com>
References: <20240423233150.74302-1-quic_obabatun@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

On Tue, 2024-04-23 at 16:31 -0700, Oreoluwa Babatunde wrote:
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
> ---
> v2:
> - Added Rob Herrings Reviewed-by.
> - cc Andrew Morton to assist with merging this for sh architecture.
>   Similar change made for loongarch and openrisc in v1 have already
>   been merged.

I'll do it no later than this weekend. Please don't put me under pressure.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

