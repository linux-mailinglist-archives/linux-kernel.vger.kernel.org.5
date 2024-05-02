Return-Path: <linux-kernel+bounces-166028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D24408B94F1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 08:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D26A28230D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 06:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 044DC20B28;
	Thu,  2 May 2024 06:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="E19i7nxa"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F011527BD;
	Thu,  2 May 2024 06:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714633123; cv=none; b=GR8pKMo9dHiBEMpYCi7j3O7ygMqd8qfo9SDHXXoG0PM6b1TTghGVD2+OYl3v5Q5310F+tn7akxvYDMEvVqSeZsbhs3TE0Unug/xkF07zs8GO7lru3U+82afug6eBLEtV9MLA8cib/XxAC21+vOZToUKFAXkxAfMviQavvCBCWvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714633123; c=relaxed/simple;
	bh=fr7JG09i6+Ie5RGRz9apXTyDPusbX3u0P8ottgfVHFM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N3LQzSqGRI1rzE8tkKGUJaC5COO30mfcnHoJ1eymQXTSbUCh5YjLV/s/jaWk7nGgocy+Z433T4EHKoBE0UQA2ulyd++fRd7WFrxqCd4tjSex1nU0uG3ufoz1tSx2PGjud7Pw2RuIN73wBBRuqECsc2y0xtzp3bUZAGhlfiBijOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=E19i7nxa; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1714633121; x=1746169121;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fr7JG09i6+Ie5RGRz9apXTyDPusbX3u0P8ottgfVHFM=;
  b=E19i7nxaKgYVSkNsXp+bOC0P5Tx48/eY36ek6GRYx3F/o9EcGo9/1qXc
   s4sRRsGAYUkuEvQLrWrbukOSyezD9OHUZ71lueckUJFluBeGGsYC3BSnW
   9ZeS0c2+vR6Q+uBteFc0cu9emJXthfvoTlUgO7aYZT9c6B+X2xTRhpVSC
   z7NyKi0q9au9sE4GRhvlQYEHuX5rIBaz5ubtYvZGuR9f1fa4e6bru5rmD
   c4zfYxktYeLmiQQrchr1FY04073qIQpS0gs4xIoKgACn/ax9Tk/df7FJA
   RmR6zEJ0D8jPlnn7X8yXiH5wQ6zqFVIHxyjyPhGWtsZwr0GcuNtN2Nvfi
   g==;
X-CSE-ConnectionGUID: 1LltmwyYR8ajEBloi7ksdA==
X-CSE-MsgGUID: ENN/5CuSTBSZsPEIoUhU1w==
X-IronPort-AV: E=Sophos;i="6.07,247,1708412400"; 
   d="scan'208";a="254178282"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 May 2024 23:58:40 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 1 May 2024 23:58:37 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 1 May 2024 23:58:37 -0700
Date: Thu, 2 May 2024 08:58:36 +0200
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: Min Li <lnimi@hotmail.com>
CC: <richardcochran@gmail.com>, <lee@kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, Min Li
	<min.li.xe@renesas.com>
Subject: Re: [PATCH net-next v7 0/5] ptp: clockmatrix: support 32-bit address
 space
Message-ID: <20240502065836.a6xfpqsxm3vocxwe@DEN-DL-M31836.microchip.com>
References: <LV3P220MB12026032F3316F557415AD9FA0192@LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <LV3P220MB12026032F3316F557415AD9FA0192@LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM>

The 05/01/2024 12:03, Min Li wrote:

Hi Min Li,

> 
> From: Min Li <min.li.xe@renesas.com>
> 
> The main porpose of this series is [PATCH 1/5], which is to support read/write
> to the whole 32-bit address space. Other changes are increamental since
> [PATCH 1/5].

I can see that now you are at version 7, it would be nice to have kept
an history of changes between each version of your patch series so other
people can see what has been changed between versions. Maybe you can do
it from now on.

> 
> 
> Min Li (5):
>   ptp: clockmatrix: support 32-bit address space
>   ptp: clockmatrix: set write phase timer to 0 when not in PCW mode
>   ptp: clockmatrix: dco input-to-output delay is 20 FOD cycles + 8ns
>   ptp: clockmatrix: Fix caps.max_adj to reflect
>     DPLL_MAX_FREQ_OFFSET[MAX_FFO]
>   ptp: clockmatrix: move register and firmware related definition to
>     idt8a340_reg.h
> 
>  drivers/ptp/ptp_clockmatrix.c    | 120 ++++--
>  drivers/ptp/ptp_clockmatrix.h    |  66 +--
>  include/linux/mfd/idt8a340_reg.h | 664 ++++++++++++++++++-------------
>  3 files changed, 482 insertions(+), 368 deletions(-)
> 
> --
> 2.39.2
> 
> 

-- 
/Horatiu

