Return-Path: <linux-kernel+bounces-88658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A9FB886E4EA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:03:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4ADA8B23EE6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 16:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E17F70CBB;
	Fri,  1 Mar 2024 16:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="YuZsyiyx"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3780B70CB8;
	Fri,  1 Mar 2024 16:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709309001; cv=none; b=AoyZUJN6efgkEWktF8m5ebnPmQ7+ioyCBgpowhjMC2Hc+4a0UnheClDndq78X2jewiiDbqvLk7UnbbwVXKbwy661vZ40L0IgwFvEe6P81tNCmN2rJIce/cm+n19tv8sOJ38o1G/ZT3iSbOzQnFMWzyIh6jwfCEmhiaPwqepGq5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709309001; c=relaxed/simple;
	bh=i9d0LaW7EoAnPFmI2AbKKlcUQ50fbZsyhqoiAmp4vZk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mnW9QGoxLvkq8ivJDz96CxIzRKrl8FfxpLY38uwGBs0svgilwMj5Fneb8RNWul5NfR7OlKmi50tbS98kP0d7EvuQGfM/o2mYcml41CWGT1G9L1QZXy3WLS/4k831yj6KuZYcHHkBVCQbrJiR+0a/XTDcmNpAAqSB9Xt6icFxDxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=YuZsyiyx; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 421Ewl9U003471;
	Fri, 1 Mar 2024 10:03:08 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=PODMain02222019; bh=uEcBiDAd0hStY3/
	Xc8YS/I7Yuem8HRIl7L9QOtD3Px0=; b=YuZsyiyx7a6dedT2hVO228gfatJ5WAP
	rzUyThGVKHj0uTARvlw+4Djzu/tVm/0IYfcCQ33nBMcIZ/gSi6DSrpT04uX7Iqce
	iuA9O2Ac7YHeL3Eb6+jKIqOjDA8lKL+/y2uf11ZDC64+6FtTLMHz8KsCtjWheiOF
	LTgkhaVeRFk3an46ZYdWcZwvRYJlhk0MPT2NxWRB0EdMFUJTM/1FnImKI0Qgf4V3
	ncCM4Jk3VCp8XuoFwJ8Fx0vdxBbY3wolB1AxEa/rV1GLBPNgCwec/6CD2MOMEDBv
	v5xsqto/K4jRvNtyzooHfgt7/exyUu+qQb83uJ6MUVep965JxhaOPwQ==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3wkh8r02ph-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Mar 2024 10:03:07 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 1 Mar
 2024 16:03:05 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.40 via Frontend Transport; Fri, 1 Mar 2024 16:03:05 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPS id CD73382024B;
	Fri,  1 Mar 2024 16:03:05 +0000 (UTC)
Date: Fri, 1 Mar 2024 16:03:04 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Maciej Strozek <mstrozek@opensource.cirrus.com>
CC: Lee Jones <lee@kernel.org>, <alsa-devel@alsa-project.org>,
        <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>,
        <linux-sound@vger.kernel.org>
Subject: Re: [PATCH] mfd: cs42l43: Fix wrong GPIO_FN_SEL and SPI_CLK_CONFIG1
 defaults
Message-ID: <ZeH8OJnhuu2yWP6x@ediswmail9.ad.cirrus.com>
References: <20240301101547.2136948-1-mstrozek@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240301101547.2136948-1-mstrozek@opensource.cirrus.com>
X-Proofpoint-ORIG-GUID: Czjj9oyb3DfnqPmAnsuaCm3dTfRzzCTg
X-Proofpoint-GUID: Czjj9oyb3DfnqPmAnsuaCm3dTfRzzCTg
X-Proofpoint-Spam-Reason: safe

On Fri, Mar 01, 2024 at 10:15:47AM +0000, Maciej Strozek wrote:
> Two regs have wrong values in existing fields, change them to match
> the datasheet.
> 
> Fixes: ace6d1448138 ("mfd: cs42l43: Add support for cs42l43 core driver")
> 
> Signed-off-by: Maciej Strozek <mstrozek@opensource.cirrus.com>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles

