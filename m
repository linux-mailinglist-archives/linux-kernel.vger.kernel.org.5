Return-Path: <linux-kernel+bounces-58158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84EBB84E209
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 14:35:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 169041F22075
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EEAE76409;
	Thu,  8 Feb 2024 13:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="J6XSgqol"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3999763EF;
	Thu,  8 Feb 2024 13:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707399314; cv=none; b=Vk51LCAxJzP+45kNYNqLRqSQ5inVOqPdHiqJOOtsxI+mwRToSqoqEEP3dYIUviLXZfIwZqpwqY2J2ovj7p930RkjaeGQGDN6LFiGq22eAmCbz1bRKnxRgjyG3S4V0vGvFccXdxbhYaRRKFixzYSrHblCeQmnnjSzNIGr6bxWZgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707399314; c=relaxed/simple;
	bh=zLQhZr8yGUt3B2m7CqB+4AxyhWRzVNenVlrezkIRqNo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NgPkIzgv8HhQvvUiy5JbN18GNho+HuzEuuM03FK/g4Vi24cDoXazbQe9NZCZR8rw+K4yhS8O16psPkHxixgIP+HmcxyNQc1ehi9PBXD8Vjc2HCijZPYeeTq8D0Ea0wHcQ5qpafNIIIw/RsjJIamUK6AE4mGL1cX4ZfTxpIUxPYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=J6XSgqol; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41861Rub021374;
	Thu, 8 Feb 2024 07:35:09 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:content-transfer-encoding:in-reply-to; s=
	PODMain02222019; bh=DV/lXCim1BwQxa2+q6Mt8a8g3JVHmhpC7TxpWpWSHwg=; b=
	J6XSgqoljGZ8a0PZwEcuHm9FH7yrLXoMsRq5jRp4h83wSOa59OCoy7cGe1HtwEJW
	V98SZnehgNqOjYWBZsc7zeZ5Seo45P/YseJ+S3PM5+UNUYTjxKErqWqiXtgEyPad
	5PAl77xCJBeafKu7g09JnD0FixYr1lsQmEg/z/VtJWRPCizxAymMiQrSjKyB12p5
	W9W1Vl+NWxq6Cz7f+txjoXFYP3z4oPz7o3nifMob2Li/szTw/Pcvf+BpI1Ggx6Sz
	iYbr4zUldvrEIYgtrwkq1dZnwi2O54GRRluL18cUV4E2s2SI/AtLFlVCbYaPJPKu
	pPNQBqRB4McACi+KQYdHVg==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3w1ks2ej3w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Feb 2024 07:35:08 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 8 Feb
 2024 13:35:06 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.40 via Frontend Transport; Thu, 8 Feb 2024 13:35:06 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPS id 8CA67820243;
	Thu,  8 Feb 2024 13:35:06 +0000 (UTC)
Date: Thu, 8 Feb 2024 13:35:05 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Lee Jones <lee@kernel.org>
CC: <broonie@kernel.org>, <andy.shevchenko@gmail.com>,
        <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>
Subject: Re: (subset) [PATCH v4 1/6] spi: cs42l43: Tidy up header includes
Message-ID: <ZcTYift6P9KkiI7g@ediswmail9.ad.cirrus.com>
References: <20240129152557.3221212-1-ckeepax@opensource.cirrus.com>
 <170738736196.904064.7729211182384063971.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <170738736196.904064.7729211182384063971.b4-ty@kernel.org>
X-Proofpoint-GUID: TuDgfRtjaHTaj92qeYgJTSHdd5sRWAki
X-Proofpoint-ORIG-GUID: TuDgfRtjaHTaj92qeYgJTSHdd5sRWAki
X-Proofpoint-Spam-Reason: safe

On Thu, Feb 08, 2024 at 10:16:01AM +0000, Lee Jones wrote:
> On Mon, 29 Jan 2024 15:25:52 +0000, Charles Keepax wrote:
> > Including some missing headers.
> > 
> > 
> 
> Applied, thanks!
> 
> [2/6] mfd: cs42l43: Tidy up header includes
>       commit: a5bc1c6c93853fb1026fb5feb6c36c9cd9512724
> [3/6] mfd: cs42l43: Use __u8 type rather than u8 for firmware interface
>       commit: eb40e181cc480c89b906aca1f29ff6f6df6b66b9
> [4/6] mfd: cs42l43: Add time postfixes on defines
>       commit: 43a94a8cf0fa136d5fc726121ff7a602754c9680
> [5/6] mfd: cs42l43: Add some missing dev_err_probe()s
>       commit: 104c68194edbe0e8c3036ce283a3f69434415be2
> [6/6] mfd: cs42l43: Handle error from devm_pm_runtime_enable()
>       commit: 8716f2c79eb82bd4dc5d7f9523a560e35efe0795
> 
> --
> Lee Jones [李琼斯]
> 

The SPI one needs to be applied along with these, otherwise
this will cause build breakage in the SPI driver.

Thanks,
Charles

